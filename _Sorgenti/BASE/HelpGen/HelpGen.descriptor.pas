unit HelpGen.Descriptor;

interface

uses
  System.SysUtils,
  System.Variants,
  System.classes,
  System.Actions,
  System.ImageList,
  System.Generics.Collections,
  System.JSON,
  Vcl.ActnList,
  Vcl.Menus,
  cxTL,
  zSystem,
  zDbView,
  zDbCard,
  zDbPivot,
  zMap,
  zToolActions,
  BaseFrm,
  HelpGen.Request.classes,
  HelpGen.Config,
  HelpGen.types,
  zAI.Descriptors,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TBaseFormDescriptor = record
  private
    // Versa un descrittore neutro (prodotto dal builder dai props dichiarativi)
    // dentro l'elemento HelpGen, effettuando lo storno delle azioni collegate.
    procedure ApplyDescriptor(const desc: TAIComponentDescriptor; elemento: THelpGenRequestElemento; Actions: TStrings);

    // Costruisce il descrittore di un componente VIVO via TAIDescriptorBuilder e
    // lo applica all'elemento. AComp deve supportare IzBaseComponent.
    procedure DescribeComponent(const AComp: IInterface; elemento: THelpGenRequestElemento; Actions: TStringList);

    // Descrive "a freddo" dai props del diagram, senza creare componenti.
    // BaseForm e' l'owner per la risoluzione delle azioni.
    procedure ApplyProps(BaseForm: TBaseForm; const AProps: TzBaseComponentProps;
      const AKind: TzComponentType; const ATitle: string;
      elemento: THelpGenRequestElemento; Actions: TStringList);
  private
    procedure DescribeView(view: TzDbView; elemento: THelpGenRequestElemento; Actions: TStringList);
    procedure DescribeCard(card: TzDbCard; elemento: THelpGenRequestElemento; Actions: TStringList);
    procedure DescribePivot(pivot: TzDbPivot; elemento: THelpGenRequestElemento; Actions: TStringList);
    // function DescribeMap
    // function DescribeFile
  private
    procedure DescribeDiagramView(BaseForm: TBaseForm; zDataSet: TzDiagramDataSet; elemento: THelpGenRequestElemento; Actions: TStringList);
    procedure DescribeDiagramCard(BaseForm: TBaseForm; zDataSet: TzDiagramDataSet; elemento: THelpGenRequestElemento; Actions: TStringList);
    procedure DescribeDiagramPivot(BaseForm: TBaseForm; zDataSet: TzDiagramDataSet; elemento: THelpGenRequestElemento; Actions: TStringList);
    // function DescribeDiagramMap
    // function DescribeDiagramFile
  private
    procedure TreeMenuToJSON(BaseForm: TBaseForm; node: TcxTreeListNode; elemento: THelpGenRequestElemento; Actions: TStringList);
    procedure AddAzioniNonCollegate(BaseForm: TBaseForm; Request: THelpGenRequestDocumentazione; AzioniNonCollegate: TStringList);
  private
    procedure EnumTreeMenu(BaseForm: TBaseForm; Request: THelpGenRequestDocumentazione; Actions: TStringList);
    procedure EnumFormComps(BaseForm: TBaseForm; Request: THelpGenRequestDocumentazione; Actions: TStringList);
    function DescribeForm(BaseForm: TBaseForm): THelpGenRequestDocumentazione;
  public
    // Genera il descrittore neutro di un singolo componente che supporti
    // IzBaseComponent. Punto d'accesso riusabile sia da HelpGen sia dal
    // contesto chat AI. Solleva se AComp non supporta IzBaseComponent.
    function GenerateDescriptor(const AComp: IInterface): TAIComponentDescriptor;

    function GeneraRequest(BaseForm: TBaseForm): string;

    { Il solo descrittore della form, in TOON, senza il modello di prompt e
      senza scrivere tracce su file. Nasce per il contesto della chat: li'
      serve sapere com'e' fatta la scheda, non ordinare una guida. }
    function DescriviContesto(BaseForm: TBaseForm): string;
  end;

implementation

uses
  zTreeMenu,
  zToolFilterHelper,
  zMsg,
  zz.toon,
  zz.Vcl,
  System.IOUtils,
  zAI.Descriptors.Builder;

function TBaseFormDescriptor.GenerateDescriptor(const AComp: IInterface): TAIComponentDescriptor;
var
  comp: IzBaseComponent;
begin
  if not Supports(AComp, IzBaseComponent, comp) then
    raise Exception.Create('GenerateDescriptor: il componente non supporta IzBaseComponent');

  Result := TAIDescriptorBuilder.DescribeComponent(comp);
end;

procedure TBaseFormDescriptor.ApplyDescriptor(const desc: TAIComponentDescriptor; elemento: THelpGenRequestElemento; Actions: TStrings);
var
  actDesc: TAIActionDescriptor;
  fltDesc: TAIFilterDescriptor;
  azione: THelpGenRequestAzione;
  idx: Integer;
begin
  SiMain.EnterMethod('ApplyDescriptor');

  // Descrizione dichiarativa del componente. Non sovrascrive una descrizione
  // gia' impostata a monte (es. la Note del dataset, che ha priorita').
  if elemento.descrizione.Trim.IsEmpty and not desc.Description.IsEmpty then
    elemento.descrizione := desc.Description;

  // Azioni: dal descrittore neutro (fonte: Description dichiarativa + caption).
  for actDesc in desc.Actions do
  begin
    azione := THelpGenRequestAzione.Create;
    elemento.azioni.Add(azione);

    azione.name := actDesc.Name;
    azione.caption := actDesc.Caption;
    azione.shortCut := actDesc.ShortCut;
    azione.hint := actDesc.Hint;            // hint grezzo del TCustomAction
    azione.description := actDesc.Description; // riga riassuntiva per l'AI

    // Storna Name da elenco azioni non collegate.
    idx := Actions.IndexOf(azione.name);
    if idx <> -1 then
      Actions.Delete(idx);
  end;

  // Filtri: dal descrittore neutro (fonte: TzToolFilterProps.Description).
  for fltDesc in desc.Filters do
    elemento.Filtri.Add(fltDesc.Description);

  SiMain.LeaveMethod('ApplyDescriptor');
end;

procedure TBaseFormDescriptor.DescribeComponent(const AComp: IInterface; elemento: THelpGenRequestElemento; Actions: TStringList);
var
  comp: IzBaseComponent;
begin
  SiMain.EnterMethod('DescribeComponent');

  if Supports(AComp, IzBaseComponent, comp) then
    ApplyDescriptor(TAIDescriptorBuilder.DescribeComponent(comp), elemento, Actions)
  else
    SiMain.LogWarning('DescribeComponent: componente privo di IzBaseComponent, ignorato');

  SiMain.LeaveMethod('DescribeComponent');
end;

procedure TBaseFormDescriptor.ApplyProps(BaseForm: TBaseForm; const AProps: TzBaseComponentProps;
  const AKind: TzComponentType; const ATitle: string;
  elemento: THelpGenRequestElemento; Actions: TStringList);
var
  Owner: TComponent;
  Resolved: TComponent;
begin
  SiMain.EnterMethod('ApplyProps');

  if Assigned(AProps) then
  begin
    // Le TAction sono figlie della form: owner di default = BaseForm. Se i props
    // dichiarano un ActionOwnerName esplicito, lo si risolve lungo la catena.
    Owner := BaseForm;
    if AProps.ActionOwnerName <> '' then
    begin
      Resolved := TzActionOwnerResolver.ResolveOwner(BaseForm, AProps.ActionOwnerName);
      if Assigned(Resolved) then
        Owner := Resolved;
    end;

    ApplyDescriptor(
      TAIDescriptorBuilder.DescribeProps(AProps, Owner, AKind, ATitle),
      elemento, Actions);
  end
  else
    SiMain.LogWarning('ApplyProps: props non assegnati, ignorato');

  SiMain.LeaveMethod('ApplyProps');
end;

procedure TBaseFormDescriptor.DescribeView(view: TzDbView; elemento: THelpGenRequestElemento; Actions: TStringList);
begin
  SiMain.EnterMethod('DescribeView');

  DescribeComponent(view, elemento, Actions);

  SiMain.LeaveMethod('DescribeView');
end;

procedure TBaseFormDescriptor.AddAzioniNonCollegate(BaseForm: TBaseForm; Request: THelpGenRequestDocumentazione; AzioniNonCollegate: TStringList);
var
  actName: string;
  Action: TCustomAction;
  azione: THelpGenRequestAzione;
  idx: Integer;
begin
  SiMain.EnterMethod('AddAzioniNonCollegate');

  for actName in AzioniNonCollegate do
    if not actName.isEmpty then
    begin
      Action := BaseForm.GetComponent<TCustomAction>(actName);

      if assigned(Action) then
      begin
        azione := THelpGenRequestAzione.Create;
        Request.AzioniNonCollegate.Add(azione);

        azione.name := Action.name;
        azione.caption := Action.caption;
        azione.hint := Action.hint;
        azione.shortCut := ShortCutToText(Action.shortCut);
      end;
    end;

  SiMain.LeaveMethod('AddAzioniNonCollegate');
end;

procedure TBaseFormDescriptor.DescribeCard(card: TzDbCard; elemento: THelpGenRequestElemento; Actions: TStringList);
begin
  SiMain.EnterMethod('DescribeCard');

  DescribeComponent(card, elemento, Actions);

  SiMain.LeaveMethod('DescribeCard');
end;

procedure TBaseFormDescriptor.DescribePivot(pivot: TzDbPivot; elemento: THelpGenRequestElemento; Actions: TStringList);
begin
  SiMain.EnterMethod('DescribePivot');

  DescribeComponent(pivot, elemento, Actions);

  SiMain.LeaveMethod('DescribePivot');
end;

procedure TBaseFormDescriptor.DescribeDiagramView(BaseForm: TBaseForm; zDataSet: TzDiagramDataSet; elemento: THelpGenRequestElemento; Actions: TStringList);
var
  i: Integer;
  item: TzDiagramDataSet.TDbView;
begin
  SiMain.EnterMethod('DescribeDiagramView');

  for i := 0 to zDataSet.DbViews.Count - 1 do
  begin
    item := zDataSet.DbViews.Items[i];
    if item.Visible then
      ApplyProps(BaseForm, item.zDbViewProps(True), ctView, item.Caption, elemento, Actions);
  end;

  SiMain.LeaveMethod('DescribeDiagramView');
end;

procedure TBaseFormDescriptor.DescribeDiagramCard(BaseForm: TBaseForm; zDataSet: TzDiagramDataSet; elemento: THelpGenRequestElemento; Actions: TStringList);
var
  i: Integer;
  item: TzDiagramDataSet.TDbCard;
begin
  SiMain.EnterMethod('DescribeDiagramCard');

  for i := 0 to zDataSet.DbCards.Count - 1 do
  begin
    item := zDataSet.DbCards.Items[i];
    if item.Visible then
      ApplyProps(BaseForm, item.zDbCardProps(True), ctCard, item.Caption, elemento, Actions);
  end;

  SiMain.LeaveMethod('DescribeDiagramCard');
end;

procedure TBaseFormDescriptor.DescribeDiagramPivot(BaseForm: TBaseForm; zDataSet: TzDiagramDataSet; elemento: THelpGenRequestElemento; Actions: TStringList);
var
  i: Integer;
  item: TzDiagramDataSet.TDbPivot;
begin
  SiMain.EnterMethod('DescribeDiagramPivot');

  for i := 0 to zDataSet.DbPivots.Count - 1 do
  begin
    item := zDataSet.DbPivots.Items[i];
    if item.Visible then
      ApplyProps(BaseForm, item.zDbPivotProps(True), ctPivot, item.Caption, elemento, Actions);
  end;

  SiMain.LeaveMethod('DescribeDiagramPivot');
end;

procedure TBaseFormDescriptor.EnumFormComps(BaseForm: TBaseForm; Request: THelpGenRequestDocumentazione; Actions: TStringList);
var
  this: TBaseFormDescriptor;
begin
  SiMain.EnterMethod('EnumFormComps');

  this := self;

  BaseForm.ForEach<TzDbCard>(
    procedure(card: TzDbCard)
    var
      elemento: THelpGenRequestElemento;
    begin
      elemento := THelpGenRequestElemento.Create;
      elemento.voce := card.GetDialogTitle;
      Request.root.submenu.Add(elemento);
      this.DescribeCard(card, elemento, Actions);
    end);

  BaseForm.ForEach<TzDbPivot>(
    procedure(pivot: TzDbPivot)
    var
      elemento: THelpGenRequestElemento;
    begin
      elemento := THelpGenRequestElemento.Create;
      elemento.voce := pivot.GetTitle;
      Request.root.submenu.Add(elemento);
      this.DescribePivot(pivot, elemento, Actions);
    end);

  BaseForm.ForEach<TzDbView>(
    procedure(view: TzDbView)
    var
      elemento: THelpGenRequestElemento;
    begin
      elemento := THelpGenRequestElemento.Create;
      elemento.voce := view.GetTitle;
      Request.root.submenu.Add(elemento);
      this.DescribeView(view, elemento, Actions);
    end);

  SiMain.LeaveMethod('EnumFormComps');
end;

function TBaseFormDescriptor.DescribeForm(BaseForm: TBaseForm): THelpGenRequestDocumentazione;

  function FillActions: TStringList;
  var
    captured: TStrings;
  begin
    result := TStringList.Create;
    captured := result;

    BaseForm.ForEach<TContainedAction>(
      procedure(Action: TContainedAction)
      begin

        if Action.ActionList <> BaseForm.BaseActions then
          captured.Add(Action.name);
      end);
  end;

var
  Actions: TStringList;
begin
  SiMain.EnterMethod('DescribeForm');

  result := THelpGenRequestDocumentazione.Create;
  try
    result.modulo := BaseForm.name;
    result.modulo := result.modulo.Replace('TForm', '', [rfIgnoreCase]);
    result.caption := BaseForm.caption;

    { TODO : Ricondurre a HelpInit/Done }
    TzToolFilterHelper.DisableImpostaFiltro := true;
    try
      BaseForm.DM.DisableGetDataSet := true;
      try
        Actions := FillActions;
        try
          if BaseForm.DM.zDataModule.BuildGui then
            EnumTreeMenu(BaseForm, result, Actions)
          else
            EnumFormComps(BaseForm, result, Actions);

          AddAzioniNonCollegate(BaseForm, result, Actions);
        finally
          FreeAndNil(Actions);
        end;
      finally
        BaseForm.DM.DisableGetDataSet := false;
      end;
    finally
      TzToolFilterHelper.DisableImpostaFiltro := false;
    end;
  except
    on e: exception do
    begin
      result.Free;
      raise;
    end;
  end;

  SiMain.LeaveMethod('DescribeForm');
end;

procedure TBaseFormDescriptor.EnumTreeMenu(BaseForm: TBaseForm; Request: THelpGenRequestDocumentazione; Actions: TStringList);
var
  TreeMenu: TzTreeMenu;
begin
  SiMain.EnterMethod('EnumTreeMenu');

  TreeMenu := TzTreeMenu.Create(nil);
  try
    TreeMenu.zSystem := BaseForm.FormController.zSystem;
    TreeMenu.zDataModule := BaseForm.FormController.zDataModule;
    TreeMenu.LoadMenu;

    if TreeMenu.tree.count > 0 then
      TreeMenuToJSON(BaseForm, TreeMenu.tree.root, Request.root, Actions);
  finally
    FreeAndNil(TreeMenu);
  end;

  SiMain.LeaveMethod('EnumTreeMenu');
end;

function TBaseFormDescriptor.DescriviContesto(BaseForm: TBaseForm): string;
var
  Request: THelpGenRequestDocumentazione;
  RequestValue: TJSONValue;
begin
  Request := DescribeForm(BaseForm);
  try
    RequestValue := Request.ToJSONObject;
    try
      Result := TzToon.FromJsonValue(RequestValue);
    finally
      RequestValue.Free;
    end;
  finally
    Request.Free;
  end;
end;

function TBaseFormDescriptor.GeneraRequest(BaseForm: TBaseForm): string;
var
  RequestTemplateFileName: string;
  logFileName: string;
  template, s: string;
  Request: THelpGenRequestDocumentazione;
  RequestValue: TJSONValue;
begin
  result := '';

  RequestTemplateFileName := zHelpConfig.TemplateFolder + 'HelpGen_RichiestaCompleta.txt';
  logFileName := zHelpConfig.TemplateFolder + 'Request_' + BaseForm.HelpModuleName + '.txt';

  if not TFile.Exists(RequestTemplateFileName) then
    raise exception.Create('Il template non esiste: ' + slineBreak + zHelpConfig.TemplateFolder + 'HelpGen_RichiestaCompleta.txt');

  template := TFile.ReadAllText(RequestTemplateFileName);

  Request := DescribeForm(BaseForm);
  try
    // Il descrittore viaggia in TOON, non in JSON: stessa informazione, circa
    // un quarto di caratteri in meno del JSON compatto (gli elenchi di azioni
    // diventano tabelle, con i nomi dei campi scritti una volta sola invece
    // che su ogni riga). ATTENZIONE: il modello di richiesta
    // HelpGen_RichiestaCompleta.txt deve dichiarare che il modulo e' in TOON e
    // che la RISPOSTA va comunque data in JSON, perche' il TOON qui si sa solo
    // scrivere, non rileggere
    RequestValue := Request.ToJSONObject;
    try
      s := template.Replace('@@modulo@@', TzToon.FromJsonValue(RequestValue), [rfIgnoreCase, rfReplaceAll]);
    finally
      RequestValue.Free;
    end;

    // Traccia di quello che viene spedito davvero. Il TOON e' gia' leggibile:
    // non serve piu' la doppia versione, formattata per l'occhio e compatta
    // per il modello
    TFile.WriteAllText(logFileName, s);

    result := s;
  finally
    Request.Free;
  end;
end;

procedure TBaseFormDescriptor.TreeMenuToJSON(BaseForm: TBaseForm; node: TcxTreeListNode; elemento: THelpGenRequestElemento; Actions: TStringList);
var
  child: TcxTreeListNode;
  zDiagramDataSet: TzDiagramDataSet;
  sub: THelpGenRequestElemento;
begin
  SiMain.EnterMethod('TreeMenuToJSON');

  zDiagramDataSet := nil;

  if assigned(node.Data) then
    if (TObject(node.Data) is TzDiagramDataSet) then
      zDiagramDataSet := TzDiagramDataSet(node.Data);

  if assigned(zDiagramDataSet) then
  begin
    elemento.voce := zDiagramDataSet.menu.caption;
    SiMain.logString('zDiagramDataSet', zDiagramDataSet.name);

    // Dataset di supporto (lookup) o esclusi esplicitamente dal descrittore:
    // non se ne descrivono i componenti. Si prosegue comunque sui figli, che
    // potrebbero essere inclusi.
    if zDiagramDataSet.IsLookupDataSet or (not zDiagramDataSet.Descriptor.Include) then
      SiMain.logString('descrittore: dataset escluso', zDiagramDataSet.name)
    else
    begin
      // Nota redazionale d'insieme del dataset, se presente.
      if not zDiagramDataSet.Descriptor.Note.Trim.IsEmpty then
        elemento.descrizione := zDiagramDataSet.Descriptor.Note.Trim;

      if zDiagramDataSet.DbViews.VisibleCount > 0 then
        DescribeDiagramView(BaseForm, zDiagramDataSet, elemento, Actions);

      if zDiagramDataSet.DbCards.VisibleCount > 0 then
        DescribeDiagramCard(BaseForm, zDiagramDataSet, elemento, Actions);

      if zDiagramDataSet.DbPivots.VisibleCount > 0 then
        DescribeDiagramPivot(BaseForm, zDiagramDataSet, elemento, Actions);
    end;
  end
  else
  begin
    // gruppo non collegato a dataset
    if not node.Texts[0].isEmpty then
    begin
      elemento.menuGroup := node.Texts[0];
      SiMain.logString('group', node.Texts[0]);
    end;
  end;

  if node.HasChildren then
  begin

    child := node.GetFirstChild;
    while child <> nil do
    begin
      sub := THelpGenRequestElemento.Create;
      elemento.submenu.Add(sub);

      TreeMenuToJSON(BaseForm, child, sub, Actions);
      child := child.GetNextSibling;
    end;
  end;

  SiMain.LeaveMethod('TreeMenuToJSON');
end;

end.
