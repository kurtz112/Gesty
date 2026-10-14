unit frmAssistenzaScolastica;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.StdActns,
  Data.DB,
  dxBar,
  dxBarExtItems,
  dxLayoutContainer,
  dxLayoutControl,
  dxFileActions,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxLabel,
  zFileViewer,
  zDbView,
  zDbCard,
  BaseFrm,
  dxUIAClasses,
  cxCustomPivotGrid,
  cxCustomData,
  cxStyles,
  dxBarBuiltInMenu,
  cxDBPivotGrid,
  zDbPivot,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TFormAssistenzaScolastica = class(TBaseForm)
    ActionList: TActionList;
    InserimentoInterventoAS: TAction;
    InserimentoInterventoAES: TAction;
    InserimentoInterventoADH: TAction;
    SchedaAnagraficaUtenteAS: TAction;
    SchedaAnagraficaUtenteAES: TAction;
    SchedaAnagraficaUtenteADH: TAction;
    AggiungiUtentiAGruppo: TAction;
    DuplicaAS: TAction;
    DuplicaAES: TAction;
    DuplicaADH: TAction;
    ImpostaCostoOrario: TAction;
    procedure AggiungiUtentiAGruppoExecute(Sender: TObject);
    procedure As_Utenti_GruppiDataSetInsert(Sender: TObject);
    procedure DuplicaADHExecute(Sender: TObject);
    procedure DuplicaAESExecute(Sender: TObject);
    procedure DuplicaASExecute(Sender: TObject);
    procedure ImpostaCostoOrarioExecute(Sender: TObject);
    procedure InserimentoInterventoADHExecute(Sender: TObject);
    procedure InserimentoInterventoAESExecute(Sender: TObject);
    procedure InserimentoInterventoASExecute(Sender: TObject);
    procedure SchedaAnagraficaUtenteADHExecute(Sender: TObject);
    procedure SchedaAnagraficaUtenteAESExecute(Sender: TObject);
    procedure SchedaAnagraficaUtenteASExecute(Sender: TObject);
  private const
    groupInterventiAS = 'dxLayoutGroupAs_Interventi_ASControls';
    groupInterventiDetailsAS = 'dxLayoutGroupAs_Interventi_AsDetails';
    groupInterventiAES = 'dxLayoutGroupAs_Interventi_AESControls';
    groupInterventiDetailsAES = 'dxLayoutGroupAs_Interventi_AESDetails';
    groupInterventiADH = 'dxLayoutGroupAs_Interventi_ADHControls';
    groupInterventiDetailsADH = 'dxLayoutGroupAs_Interventi_ADHDetails';
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
  private
    procedure PivotStatoAvanzamentoAfterCreateControls(Sender: TObject);
  private
    procedure ShowCard(const DataSetName, GroupName: string; Inserting: Boolean);

    procedure InterventoASShowCard(Sender: TObject; Inserting: Boolean);
    procedure InterventoASInsert(Sender: TObject);

    procedure InterventoAESShowCard(Sender: TObject; Inserting: Boolean);
    procedure InterventoAESInsert(Sender: TObject);

    procedure InterventoADHShowCard(Sender: TObject; Inserting: Boolean);
    procedure InterventoADHInsert(Sender: TObject);
  protected
    procedure FormControllerTabChanged(group: TdxLayoutGroup);
    function FormControllerTabChanging(group: TdxLayoutGroup; ANewTabIndex: integer): Boolean;
  protected
    procedure SetPK(const Value: Variant); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAssistenzaScolastica: TFormAssistenzaScolastica;

implementation

uses
  System.Math,
  cxFilter,
  zHyperLinks,
  Files.Lib,
  zDm_Images,
  dmAssistenzaScolastica,
  zFbDataSet,
  System.StrUtils,
  zSystem,
  zDX;

{$R *.dfm}

procedure TFormAssistenzaScolastica.CreateDataModule;
begin
  inherited;
  CreateDM(TAssistenzaScolastica, AssistenzaScolastica);
end;

procedure TFormAssistenzaScolastica.DestroyDataModule;
begin
  inherited;
  FreeAndNil(AssistenzaScolastica);
end;

constructor TFormAssistenzaScolastica.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'AssistenzaScolastica';
  Caption := 'AssistenzaScolastica';

  FormController.LayoutController.TabChangedProc := FormControllerTabChanged;
  FormController.LayoutController.TabChangingProc := FormControllerTabChanging;

  AssistenzaScolastica.InterventiAS_AfterScrollProc := procedure
    var
      DataSet: TDataSet;
      Visible: Boolean;
      item: TdxCustomLayoutItem;
    begin
      DataSet := GetDataSet('AS_INTERVENTI_AS');
      Visible := DataSet.FieldByName('ELENCO_GRUPPI').isNull;

      item := FormController.LayoutController.dxLayoutControl.FindItem('dxLayoutItemcardAs_Interventi_AS_Interventi_AS_Parte_Economica');
      item.Visible := Visible;

      item := FormController.LayoutController.dxLayoutControl.FindItem('dxLayoutItemcardAs_Interventi_groupRendicontazione');
      item.Visible := Visible;
    end;

  AssistenzaScolastica.InterventiAES_AfterScrollProc := procedure
    var
      DataSet: TDataSet;
      Visible: Boolean;
      item: TdxCustomLayoutItem;
    begin
      DataSet := GetDataSet('AS_INTERVENTI_AES');
      Visible := DataSet.FieldByName('ELENCO_GRUPPI').isNull;

      item := FormController.LayoutController.dxLayoutControl.FindItem('dxLayoutItemcardAs_Interventi_AES_Interventi_AES_Parte_Economica');
      item.Visible := Visible;

      item := FormController.LayoutController.dxLayoutControl.FindItem('dxLayoutGroupRendicontazioni_AES');
      item.Visible := Visible;
    end;

  AssistenzaScolastica.InterventiADH_AfterScrollProc := procedure
    var
      DataSet: TDataSet;
      Visible: Boolean;
      item: TdxCustomLayoutItem;
    begin
      DataSet := GetDataSet('AS_INTERVENTI_ADH');
      Visible := DataSet.FieldByName('ELENCO_GRUPPI').isNull;

      item := FormController.LayoutController.dxLayoutControl.FindItem('dxLayoutItemcardAs_Interventi_ADH_Interventi_ADH_Parte_Economica');
      item.Visible := Visible;

      item := FormController.LayoutController.dxLayoutControl.FindItem('dxLayoutGroupRendicontazione');
      item.Visible := Visible;
    end;
end;

procedure TFormAssistenzaScolastica.InterventoASInsert(Sender: TObject);
begin
  InserimentoInterventoAS.Execute;
end;

procedure TFormAssistenzaScolastica.InterventoAESInsert(Sender: TObject);
begin
  InserimentoInterventoAES.Execute;
end;

procedure TFormAssistenzaScolastica.InterventoADHInsert(Sender: TObject);
begin
  InserimentoInterventoADH.Execute;
end;

procedure TFormAssistenzaScolastica.InserimentoInterventoASExecute(Sender: TObject);
begin
  inherited;
  InterventoASShowCard(Sender, true);
end;

procedure TFormAssistenzaScolastica.InserimentoInterventoAESExecute(Sender: TObject);
begin
  inherited;
  InterventoAESShowCard(Sender, true);
end;

procedure TFormAssistenzaScolastica.InserimentoInterventoADHExecute(Sender: TObject);
begin
  inherited;
  InterventoADHShowCard(Sender, true);
end;

procedure TFormAssistenzaScolastica.ShowCard(const DataSetName, GroupName: string; Inserting: Boolean);
var
  group: TdxLayoutGroup;
begin

  if assigned(FormController.LayoutController) then
  begin
    group := FormController.LayoutController.FindGroup(GroupName);

    if assigned(group) then
      group.itemIndex := 1;
  end;

  if Inserting then
    GetDataSet(DataSetName).Append;
end;

procedure TFormAssistenzaScolastica.InterventoASShowCard(Sender: TObject; Inserting: Boolean);
begin
  ShowCard('As_Interventi_AS', groupInterventiAS, Inserting);
end;

procedure TFormAssistenzaScolastica.InterventoAESShowCard(Sender: TObject; Inserting: Boolean);
begin
  ShowCard('As_Interventi_AES', groupInterventiAES, Inserting);
end;

procedure TFormAssistenzaScolastica.InterventoADHShowCard(Sender: TObject; Inserting: Boolean);
begin
  ShowCard('As_Interventi_ADH', groupInterventiADH, Inserting);
end;

procedure TFormAssistenzaScolastica.SetPK(const Value: Variant);
begin
  inherited;

  var
    view: TzDbView;
  begin
    inherited;
    //
    if pkMode then
    begin

      if pkField = 'ID_INTERVENTO_AS' then
      begin
        SelectedDataSetName := 'As_Interventi_AS';

        view := getView('As_Interventi_AS');
        if assigned(view) then
        begin
          view.ClearFilter(False);
          view.AddFilterCondition('ID_INTERVENTO_AS', foEqual, pk);
          view.ShowRecord(False);
        end;
      end
      else
        if pkField = 'ID_INTERVENTO_AES' then
        begin
          SelectedDataSetName := 'As_Interventi_AES';

          view := getView('As_Interventi_AES');
          if assigned(view) then
          begin
            view.ClearFilter(False);
            view.AddFilterCondition('ID_INTERVENTO_AES', foEqual, pk);
            view.ShowRecord(False);
          end;
        end
        else
          if pkField = 'ID_INTERVENTO_ADH' then
          begin
            SelectedDataSetName := 'As_Interventi_ADH';

            view := getView('As_Interventi_ADH');
            if assigned(view) then
            begin
              view.ClearFilter(False);
              view.AddFilterCondition('ID_INTERVENTO_ADH', foEqual, pk);
              view.ShowRecord(False);
            end;
          end;
    end;
  end;
end;

function TFormAssistenzaScolastica.FormControllerTabChanging(group: TdxLayoutGroup; ANewTabIndex: integer): Boolean;
begin
  result := CloseQuery;
end;

procedure TFormAssistenzaScolastica.FormControllerTabChanged(group: TdxLayoutGroup);

  procedure SetGroupHeigth(grpTopName, grpDetailName: String; card: TzDbCard);
  const
    MinDetailHeight = 100;
    SplitterHeight = 20;
  var
    grpTop, grpDetail: TdxLayoutGroup;
    maxH: integer;
    cardHeight: integer;
  begin
    grpTop := FormController.LayoutController.dxLayoutControl.FindItem(grpTopName) as TdxLayoutGroup;
    grpDetail := FormController.LayoutController.dxLayoutControl.FindItem(grpDetailName) as TdxLayoutGroup;

    if not assigned(grpTop) then
      exit;

    if not assigned(grpDetail) then
      exit;

    grpTop.SizeOptions.Height := 0;
    grpDetail.SizeOptions.Height := 0;

    maxH := grpTop.Parent.ViewInfo.Bounds.Height;

    card.RefreshDisplay;
    cardHeight := card.CalcDialogHeight;

    grpDetail.SizeOptions.Height := Max(maxH - cardHeight - SplitterHeight, MinDetailHeight);
    grpTop.SizeOptions.Height := maxH - grpDetail.SizeOptions.Height; // - SplitterHeight;
  end;

  procedure SetCardHeigth(const GroupName, groupDetails, DataSetName: string; cardNames: array of string);
  var
    card: TzDbCard;
    cardName: string;
  begin
    card := nil;

    if group.itemIndex = 0 then
      exit
    else
    begin
      cardName := cardNames[group.itemIndex - 1];
      card := GetCard(DataSetName, cardName);
    end;

    /// ///////////////////////////////////////////////
    // L'allinamento del pagecontrol dev'essere alTop
    // Per i detail impostare minWidth

    if assigned(card) then
      SetGroupHeigth(GroupName, groupDetails, card);
  end;

begin
  /// ///////////////////////////////////////////////

  // if SameText(group.Name, groupInterventiAS) then
  // SetCardHeigth(groupInterventiAS, groupInterventiDetailsAS, 'As_Interventi_AS', ['Interventi_AS_Dati_Anagrafici', 'Interventi_AS_Scheda_Intervento', 'Interventi_AS_TipologiaIntervento',
  // 'Interventi_AS_Monitoraggio', 'Interventi_AS_Parte_Economica'])
  // else
  // if SameText(group.Name, groupInterventiA�ES) then
  // SetCardHeigth(groupInterventiAES, groupInterventiDetailsAES, 'As_Interventi_AES', ['Interventi_AES_Dati_Anagrafici', 'Interventi_AES_Scheda_Intervento', 'Interventi_AES_Parte_Economica'])
  // else
  // if SameText(group.Name, groupInterventiADH) then
  // SetCardHeigth(groupInterventiADH, groupInterventiDetailsADH, 'As_Interventi_ADH', ['Interventi_ADH_Dati_Anagrafici', 'Interventi_ADH_Scheda_Intervento', 'Interventi_ADH_Parte_Economica']);
end;

procedure TFormAssistenzaScolastica.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
// card: TzDbCard;
// pivot: TzDbPivot;
// begin
// inherited;
//
// if Component is TzDbCard then
// begin
// card := TzDbCard(Component);
//
// if SameText(DataSetName, 'As_Interventi_AS') then
// begin
// card.AddAction(DuplicaAS, zDmImages.ImageList16);
// card.InitToolActions;
// end
// else
// if SameText(DataSetName, 'Interventi_AS_Scheda_Intervento') then
// begin
// card.onDataSetInsert := InterventoASInsert;
// card.AddAction(SchedaAnagraficaUtenteAS, zDmImages.ImageList16);
// card.InitToolActions;
// end
// else
// if SameText(DataSetName, 'As_Interventi_AES') then
// begin
// card.AddAction(DuplicaAES, zDmImages.ImageList16);
// card.InitToolActions;
// end
// else
//
// if SameText(DataSetName, 'Interventi_AES_Scheda_Intervento') then
// begin
// card.onDataSetInsert := InterventoAESInsert;
// card.AddAction(SchedaAnagraficaUtenteAES, zDmImages.ImageList16);
// card.InitToolActions;
// end
// else
// if SameText(DataSetName, 'Interventi_ADH_Scheda_Intervento') then
// begin
// card.onDataSetInsert := InterventoADHInsert;
// card.AddAction(SchedaAnagraficaUtenteADH, zDmImages.ImageList16);
// card.InitToolActions;
// end
// else
// if SameText(DataSetName, 'As_Gruppi') then
// begin
// card.AddAction(AggiungiUtentiAGruppo, zDmImages.ImageList16);
// card.InitToolActions;
// end
// else
// if SameText(DataSetName, 'As_Interventi_ADH') then
// begin
// card.AddAction(DuplicaADH, zDmImages.ImageList16);
// card.InitToolActions;
// end;
//
// if 'Interventi_AS_Parte_Economica;Interventi_AES_Parte_Economica;Interventi_ADH_Parte_Economica;'.ToUpper.Contains(card.CardID.ToUpper) then
// begin
// card.AddAction(ImpostaCostoOrario, zDmImages.ImageList16);
// card.InitToolActions;
// end;
// end
// else
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'As_Interventi_AS') then
// begin
// view.AddAction(SchedaAnagraficaUtenteAS, zDmImages.ImageList16);
// view.AddAction(DuplicaAS, zDmImages.ImageList16);
// view.InitToolActions;
//
// tools.AddFiltroAS_Comuni(view, AssistenzaScolastica.GetDataSet(DataSetName));
// tools.AddFiltroAnnoFormativo(view, AssistenzaScolastica.GetDataSet(DataSetName));
//
// view.OnShowCard := InterventoASShowCard;
// view.onDataSetInsert := InterventoASInsert;
// end
// else
// if SameText(DataSetName, 'As_Interventi_As_RiepilogoEconomico') then
// begin
// tools.AddFiltroAS_Comuni(view, AssistenzaScolastica.GetDataSet(DataSetName));
// tools.AddFiltroAnnoFormativo(view, AssistenzaScolastica.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'As_Interventi_AES') then
// begin
// view.AddAction(SchedaAnagraficaUtenteAES, zDmImages.ImageList16);
// view.AddAction(DuplicaAES, zDmImages.ImageList16);
// view.InitToolActions;
//
// tools.AddFiltroAS_Comuni(view, AssistenzaScolastica.GetDataSet(DataSetName));
// tools.AddFiltroAnnoFormativo(view, AssistenzaScolastica.GetDataSet(DataSetName));
//
// view.OnShowCard := InterventoAESShowCard;
// view.onDataSetInsert := InterventoAESInsert;
// end
// else
// if SameText(DataSetName, 'As_Interventi_ADH') then
// begin
// view.AddAction(SchedaAnagraficaUtenteADH, zDmImages.ImageList16);
// view.AddAction(DuplicaADH, zDmImages.ImageList16);
// view.InitToolActions;
//
// tools.AddFiltroAS_Comuni(view, AssistenzaScolastica.GetDataSet(DataSetName));
// tools.AddFiltroAnnoFormativo(view, AssistenzaScolastica.GetDataSet(DataSetName));
//
// view.OnShowCard := InterventoADHShowCard;
// view.onDataSetInsert := InterventoADHInsert;
// end
// else
// if SameText(DataSetName, 'As_Gruppi') then
// begin
// tools.AddFiltroAS_Comuni(view, AssistenzaScolastica.GetDataSet(DataSetName));
// tools.AddFiltroAnnoFormativo(view, AssistenzaScolastica.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'As_Utenti_Gruppi_Studenti') then
// begin
// view.onDataSetInsert := As_Utenti_GruppiDataSetInsert;
// end
// else
// if SameText(DataSetName, 'Rendicontazioni_AS') then
// begin
// tools.AddFiltroMese(view, AssistenzaScolastica.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'Rendicontazioni_Gruppi') then
// begin
// tools.AddFiltroMese(view, AssistenzaScolastica.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'As_Stato_Avanzamento') then
// begin
// tools.AddFiltroMese(view, AssistenzaScolastica.GetDataSet(DataSetName));
// tools.AddFiltroAnnoFormativo(view, AssistenzaScolastica.GetDataSet(DataSetName));
// tools.AddFiltroPickList('AS_TIPO_ORE', view, AssistenzaScolastica.GetDataSet(DataSetName), 'TIPO_ORE', 'Tipo Ore', 'tipo orerichiesta', null, true, 'Tutti', 120);
// tools.AddFiltroPickList('AS_TIPO_INTERVENTO', view, AssistenzaScolastica.GetDataSet(DataSetName), 'TIPO_INTERVENTO', 'Tipo Intervento', 'tipo intervento', null, true, 'Tutti', 120);
// tools.AddFiltroAS_Comuni(view, AssistenzaScolastica.GetDataSet(DataSetName));
// end;
// end
// else
// if Component is TzDbPivot then
// begin
// pivot := TzDbPivot(Component);
//
// if SameText(DataSetName, 'As_Stato_Avanzamento') then
// begin
// tools.AddFiltroMese(pivot, AssistenzaScolastica.GetDataSet(DataSetName), ivNull);
// tools.AddFiltroAnnoFormativo(pivot, AssistenzaScolastica.GetDataSet(DataSetName));
// tools.AddFiltroPickList('AS_TIPO_ORE', pivot, AssistenzaScolastica.GetDataSet(DataSetName), 'TIPO_ORE', 'Tipo Ore', 'tipo orerichiesta', null, true, 'Tutti', 120);
// tools.AddFiltroPickList('AS_TIPO_INTERVENTO', pivot, AssistenzaScolastica.GetDataSet(DataSetName), 'TIPO_INTERVENTO', 'Tipo Intervento', 'tipo intervento', null, true, 'Tutti', 120);
// tools.AddFiltroAS_Comuni(pivot, AssistenzaScolastica.GetDataSet(DataSetName));
//
// pivot.OnAfterCreateControls := PivotStatoAvanzamentoAfterCreateControls;
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormAssistenzaScolastica.SchedaAnagraficaUtenteASExecute(Sender: TObject);
begin
  inherited;
  AssistenzaScolastica.MostaSchedaAnagraficaUtente('As_Interventi_AS');
end;

procedure TFormAssistenzaScolastica.SchedaAnagraficaUtenteAESExecute(Sender: TObject);
begin
  inherited;
  AssistenzaScolastica.MostaSchedaAnagraficaUtente('As_Interventi_AES');
end;

procedure TFormAssistenzaScolastica.SchedaAnagraficaUtenteADHExecute(Sender: TObject);
begin
  inherited;
  AssistenzaScolastica.MostaSchedaAnagraficaUtente('As_Interventi_ADH');
end;

procedure TFormAssistenzaScolastica.As_Utenti_GruppiDataSetInsert(Sender: TObject);
begin
  inherited;
  AssistenzaScolastica.AggiungiUtentiAGruppoSelezionato;
end;

procedure TFormAssistenzaScolastica.AggiungiUtentiAGruppoExecute(Sender: TObject);
begin
  inherited;
  AssistenzaScolastica.AggiungiUtentiAGruppoSelezionato;
end;

procedure TFormAssistenzaScolastica.DuplicaASExecute(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;

  view := getView('As_Interventi_AS');
  if assigned(view) then
    if AssistenzaScolastica.DuplicaUtente('As_Interventi_AS') then
      view.ShowRecord(False);
end;

procedure TFormAssistenzaScolastica.DuplicaAESExecute(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;

  view := getView('As_Interventi_AES');
  if assigned(view) then
    if AssistenzaScolastica.DuplicaUtente('As_Interventi_AES') then
      view.ShowRecord(False);
end;

procedure TFormAssistenzaScolastica.DuplicaADHExecute(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;

  view := getView('As_Interventi_ADH');
  if assigned(view) then
    if AssistenzaScolastica.DuplicaUtente('As_Interventi_ADH') then
      view.ShowRecord(False);
end;

procedure TFormAssistenzaScolastica.ImpostaCostoOrarioExecute(Sender: TObject);
begin
  inherited;
  AssistenzaScolastica.ImpostaCostoOrario;
end;

procedure TFormAssistenzaScolastica.PivotStatoAvanzamentoAfterCreateControls(Sender: TObject);
var
  pivot: TzDbPivot;
  PivotField: TcxDBPivotGridField;
begin

  if not(Sender is TzDbPivot) then
    exit;

  pivot := TzDbPivot(Sender);

  // Il totale generale di riga non deve contare la colonna 'Ore Dirette Totali',
  // che è già un totale derivato: senza esclusione verrebbe sommata due volte.
  pivot.SetGrandTotalExclusions('ORE_TOTALI', ['Ore Dirette Totali']);
  pivot.SetGrandTotalExclusions('COSTO_TOTALE', ['Ore Dirette Totali']);
end;

procedure TFormAssistenzaScolastica.SetupComponent(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
  card: TzDbCard;
  pivot: TzDbPivot;
begin
  inherited;

  if Component is TzDbView then
  begin
    view := TzDbView(Component);

    if SameText(DataSetName, 'As_Interventi_AS') then
    begin
      view.OnShowCard := InterventoASShowCard;
      view.onDataSetInsert := InterventoASInsert;
    end
    else
      if SameText(DataSetName, 'As_Interventi_AES') then
      begin
        view.OnShowCard := InterventoAESShowCard;
        view.onDataSetInsert := InterventoAESInsert;
      end
      else
        if SameText(DataSetName, 'As_Interventi_ADH') then
        begin
          view.OnShowCard := InterventoADHShowCard;
          view.onDataSetInsert := InterventoADHInsert;
        end
        else
          if SameText(DataSetName, 'As_Utenti_Gruppi_Studenti') then
          begin
            view.onDataSetInsert := As_Utenti_GruppiDataSetInsert;
          end;
  end;

  if Component is TzDbCard then
  begin
    card := TzDbCard(Component);

    if SameText(DataSetName, 'Interventi_AS_Scheda_Intervento') then
    begin
      card.onDataSetInsert := InterventoASInsert;
    end
    else
      if SameText(DataSetName, 'Interventi_AES_Scheda_Intervento') then
      begin
        card.onDataSetInsert := InterventoAESInsert;
      end
      else
        if SameText(DataSetName, 'Interventi_ADH_Scheda_Intervento') then
        begin
          card.onDataSetInsert := InterventoADHInsert;
        end
        else
          if SameText(DataSetName, 'As_Interventi_ADH') then
          begin
            // === TODO REVISIONE MANUALE (blocco non classificato automaticamente) ===
            if 'Interventi_AS_Parte_Economica;Interventi_AES_Parte_Economica;Interventi_ADH_Parte_Economica;'.ToUpper.Contains(card.CardID.ToUpper) then
            begin
              card.AddAction(ImpostaCostoOrario, dx.Immagini);
              card.InitToolActions;
            end;
            // === fine TODO ===
          end;
  end;

  if Component is TzDbPivot then
  begin
    pivot := TzDbPivot(Component);

    if SameText(DataSetName, 'As_Stato_Avanzamento') then
    begin
      pivot.OnAfterCreateControls := PivotStatoAvanzamentoAfterCreateControls;
    end;
  end;
end;

initialization

HyperLinks.RegisterHandler('ID_INTERVENTO_AS', TFormAssistenzaScolastica);
HyperLinks.RegisterHandler('ID_INTERVENTO_AES', TFormAssistenzaScolastica);
HyperLinks.RegisterHandler('ID_INTERVENTO_ADH', TFormAssistenzaScolastica);

end.

// se passano da AS a AES o ADH => closequery

// dxLayoutItemcardAs_Interventi_AS_Interventi_AS_Parte_Economica

  zDbView

  DuplicaAS

  As_Stato_Avanzamento
