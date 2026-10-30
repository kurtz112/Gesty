unit zHelp.form;

interface

uses
  System.SysUtils,
  System.Classes,
  System.ImageList,
  System.Variants,
  System.Actions,
  Data.DB,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.StdActns,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxImageList,
  dxBar,
  cxClasses,
  dxStatusBar,
  cxContainer,
  cxEdit,
  cxListView,
  dxRibbonForm,
  dxFileActions,
  dxUIAClasses,
  cxFilter,
  cxCustomData,
  cxStyles,
  dxScrollbarAnnotations,
  cxTL,
  cxTLdxBarBuiltInMenu,
  cxInplaceContainer,
  cxTextEdit,
  zRestrictions,
  zFileSystem,
  HelpGen.types,
  HelpGen.config;

type
  TzHelpForm = class(TdxRibbonForm, IRestriction)
    dnsPanel1: TPanel;
    ActionList: TActionList;
    VisualizzaGuida: TAction;
    ModificaGuida: TAction;
    NuovaGuida: TAction;
    Cartella: TAction;
    Chiudi: TAction;
    dxBarManager: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    dxBarManagerBar: TdxBar;
    dxBarButtonAnteprima: TdxBarButton;
    dxBarButtonChiudi: TdxBarButton;
    dxBarSubItemSistema: TdxBarSubItem;
    cxImageList24: TcxImageList;
    cxImageList16: TcxImageList;
    dxBarButtonNuovo: TdxBarButton;
    dxBarButtonModifica: TdxBarButton;
    dxBarButtonCartella: TdxBarButton;
    actPoliticheAccessi: TAction;
    actRicaricaPolitiche: TAction;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxBarButton8: TdxBarButton;
    actPermessiAzione: TAction;
    popActions: TdxBarPopupMenu;
    Aggiorna: TAction;
    dxBarButton6: TdxBarButton;
    dxBarButton9: TdxBarButton;
    tree: TcxTreeList;
    treeColumn: TcxTreeListColumn;
    treeImages: TcxImageList;
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actPermessiAzioneExecute(Sender: TObject);
    procedure actPoliticheAccessiExecute(Sender: TObject);
    procedure actRicaricaPoliticheExecute(Sender: TObject);
    procedure AggiornaExecute(Sender: TObject);
    procedure ChiudiExecute(Sender: TObject);
    procedure VisualizzaGuidaExecute(Sender: TObject);
    procedure VisualizzaGuidaUpdate(Sender: TObject);
    procedure ModificaGuidaExecute(Sender: TObject);
    procedure NuovaGuidaExecute(Sender: TObject);
    procedure CartellaExecute(Sender: TObject);
    procedure dxBarManagerBarVisibleChange(Sender: TdxBarManager; ABar: TdxBar);
    procedure FormActivate(Sender: TObject);
    procedure popActionsPopup(Sender: TObject);
    procedure treeColumnTcxTreeListColumnSummaryFooterSummaryItems0GetText(Sender: TcxTreeListSummaryItem; const AValue: Variant; var AText: string);
    procedure treeDblClick(Sender: TObject);
    procedure treeSelectionChanged(Sender: TObject);
  private
    procedure doGeneraHelp(HelpFileName: string; HelpSubject: IHelpSubject);
  private
    procedure LoadHelps;
    procedure FillTreeList;
    procedure SelectFolder(const Folder: String);

    procedure ShowHelpFiles;
  private
    function IsHelpSelected: Boolean;
    function SelectedHelp: TzFile;
    function SelectedFolder: string;
  private
    HelpFiles: TzFolder;
    FHelpSubject: IHelpSubject;
    RestrictionManager: TRestrictionManager;

    procedure ApplyRestrictions;
    function GetRestrictionManager: TRestrictionManager;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure ShowHelpForm(HelpSubject: IHelpSubject);
    property HelpSubject: IHelpSubject read FHelpSubject;
  end;

implementation

uses
  Winapi.ShellAPI,
  Winapi.Windows,
  Vcl.Printers,
  Vcl.Clipbrd,
  frxVariables,
  zMsg,
  zdx,
  zRestrictions.types,
  zSystem,
  zz.Strings,
  zFrmInspector,
  ConfigModule,
  Gesty.Authorizations,
  HelpGen.Editor,
  zoffice.pdf.form,
  SmartInspect.Vcl,
  SmartInspect.Vcl.SiAuto;

{$R *.DFM}
/// //////////////////////////////////////////////////////

constructor TzHelpForm.Create(aOwner: TComponent);
begin
  inherited;
  FHelpSubject := nil;
  HelpFiles := TzFolder.Create(nil);

  // tree.Styles.StyleController := dx.GetStyleController(edReadOnly);

  dxBarSubItemSistema.Visible := dx.Visible(config.Authorizhed(Gesty_Authorizations.HELP_MODIFICA));

  RestrictionManager := TRestrictionManager.Create(Self, config.zSystem, Self, nil);

  RestrictionManager.AddDefaultLevel(VisualizzaGuida, 'Base', TAccessLevel.alFull);
  RestrictionManager.AddDefaultLevel(Chiudi, 'Base', TAccessLevel.alFull);

  RestrictionManager.AddDefaultLevel(NuovaGuida, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ModificaGuida, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(Cartella, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actPoliticheAccessi, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actRicaricaPolitiche, 'Base', TAccessLevel.alNone);

  ActiveControl := tree;
end;

destructor TzHelpForm.Destroy;
begin
  FreeAndNil(HelpFiles);
  RootLookAndFeel.RemoveChangeListener(Self);
  FreeAndNil(RestrictionManager);
  inherited;
end;

procedure TzHelpForm.ShowHelpFiles;
begin
  LoadHelps;
  FillTreeList;
  SelectFolder(HelpSubject.HelpFolder);
end;

procedure TzHelpForm.ShowHelpForm(HelpSubject: IHelpSubject);
begin
  FHelpSubject := HelpSubject;

  ShowHelpFiles;

  ApplyRestrictions;

  ActiveControl := tree;

  ShowModal;
end;

procedure TzHelpForm.actPoliticheAccessiExecute(Sender: TObject);
begin
  RestrictionManager.EditRestrictions;
end;

procedure TzHelpForm.actRicaricaPoliticheExecute(Sender: TObject);
begin
  ApplyRestrictions;
end;

procedure TzHelpForm.ApplyRestrictions;
begin
  RestrictionManager.ApplyRestrictions;
end;

procedure TzHelpForm.ChiudiExecute(Sender: TObject);
begin
  Close;
end;

procedure TzHelpForm.NuovaGuidaExecute(Sender: TObject);
begin
  doGeneraHelp('', HelpSubject);
end;

procedure TzHelpForm.ModificaGuidaExecute(Sender: TObject);
var
  FileName: string;
begin
  if IsHelpSelected then
  begin
    FileName := SelectedHelp.FullName;
    FileName := ChangeFileExt(SelectedHelp.FullName, '.docx');

    doGeneraHelp(FileName, HelpSubject);
  end;
end;

procedure TzHelpForm.CartellaExecute(Sender: TObject);
var
  Folder: string;
begin
  Folder := SelectedFolder;

  if not Folder.IsEmpty then
    ShellExecute(0, PCHAR('open'), PCHAR(Folder), nil, nil, SW_RESTORE);
end;

function TzHelpForm.GetRestrictionManager: TRestrictionManager;
begin
  Result := RestrictionManager;
end;

function TzHelpForm.IsHelpSelected: Boolean;
begin
  Result := SelectedHelp <> nil;
end;

function TzHelpForm.SelectedHelp: TzFile;
var
  Node: TcxTreeListNode;
begin
  try
    Result := nil;

    if tree.SelectionCount = 0 then
      exit;

    Node := tree.Selections[0];

    if assigned(Node) then
      if Node.Data <> nil then
        if TObject(Node.Data) is TzFile then
          Result := TzFile(Node.Data);
  except
  end;
end;

function TzHelpForm.SelectedFolder: string;
var
  Node: TcxTreeListNode;
  FileSystemObject: TzFileSystemObject;
begin
  Result := '';

  if tree.SelectionCount = 0 then
    exit;

  Node := tree.Selections[0];

  if Node.Data <> nil then
    if TObject(Node.Data) is TzFileSystemObject then
    begin
      FileSystemObject := TzFileSystemObject(Node.Data);

      if FileSystemObject.isFolder then
        Result := TzFolder(FileSystemObject).FullName
      else
        Result := TzFile(FileSystemObject).Folder;
    end;
end;

procedure TzHelpForm.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  dxBarSubItemSistema.Visible := dx.Visible(config.Authorizhed(Gesty_Authorizations.HELP_MODIFICA));
end;

procedure TzHelpForm.actPermessiAzioneExecute(Sender: TObject);
var
  Action: TCustomAction;
begin
  Action := TCustomAction(popActions.Tag);

  if assigned(Action) then
    RestrictionManager.EditComponentRestrictions(ClassName, ccAction, Action.Name);
end;

procedure TzHelpForm.dxBarManagerBarVisibleChange(Sender: TdxBarManager; ABar: TdxBar);
begin
  dx.dxBarAssignPopupMenu(ABar, popActions);
end;

procedure TzHelpForm.popActionsPopup(Sender: TObject);
begin
  if not config.zSystem.CanEditRestrictions then
    System.SysUtils.Abort;
end;

procedure TzHelpForm.AggiornaExecute(Sender: TObject);
begin
  ShowHelpFiles;
  ActiveControl := tree;
end;

procedure TzHelpForm.treeDblClick(Sender: TObject);
begin
  VisualizzaGuida.Execute;
end;

procedure TzHelpForm.treeSelectionChanged(Sender: TObject);
begin
  UpdateActions;
  tree.Summary.Recalculate;
end;

procedure TzHelpForm.VisualizzaGuidaUpdate(Sender: TObject);
begin
  VisualizzaGuida.Enabled := IsHelpSelected;
end;

procedure TzHelpForm.VisualizzaGuidaExecute(Sender: TObject);
var
  Help: TzFile;
  FileName: string;
begin

  if not IsHelpSelected then
    exit;

  Help := SelectedHelp;

  if assigned(Help) then
  begin
    FileName := Help.FullName;
    ViewFilePdf(FileName);
  end;
end;

procedure TzHelpForm.treeColumnTcxTreeListColumnSummaryFooterSummaryItems0GetText(Sender: TcxTreeListSummaryItem; const AValue: Variant; var AText: string);
var
  Help: TzFile;
begin
  Help := SelectedHelp;

  if assigned(Help) then
    AText := Help.FullName
  else
    AText := SelectedFolder;
end;

procedure TzHelpForm.FillTreeList;

  procedure EnumFolder(Folder: TzFolder; parent: TcxTreeListNode);
  var
    sub: TzFolder;
    zHelp: TzFile;
    folderNode, fileNode: TcxTreeListNode;
  begin
    folderNode := tree.AddChild(parent);
    folderNode.Texts[0] := Folder.Name;
    folderNode.ImageIndex := 0;
    folderNode.Data := Folder;

    for sub in Folder.Folders do
      EnumFolder(sub, folderNode);

    for zHelp in Folder.Files do
    begin
      fileNode := tree.AddChild(folderNode);
      fileNode.Texts[0] := zHelp.Name;

      if zHelp.FileExt.toLower = '.pdf' then
        fileNode.ImageIndex := 1
      else
        fileNode.ImageIndex := 2;

      fileNode.Data := zHelp;
    end;
  end;

var
  I: Integer;
  Node: TcxTreeListNode;
begin
  tree.Clear;

  EnumFolder(HelpFiles, nil);
  tree.root.Expand(true);

  ActiveControl := tree;
end;

procedure TzHelpForm.LoadHelps;
begin
  HelpFiles.Clear;
  HelpFiles.FullName := zHelpConfig.HelpFolder;

  if config.Authorizhed(Gesty_Authorizations.HELP_MODIFICA) then
    HelpFiles.LoadFolder(nil, '', ['*.pdf', '*.docx'], ['_backup'])
  else
    HelpFiles.LoadFolder(nil, '', ['*.pdf'], ['_backup']);
end;

procedure TzHelpForm.SelectFolder(const Folder: String);
var
  I: Integer;
  Node: TcxTreeListNode;
begin
  tree.FullCollapse;

  for I := 0 to tree.AbsoluteCount - 1 do
  begin
    Node := tree.AbsoluteItems[I];

    if Node.Data <> nil then
      if TObject(Node.Data) is TzFolder then
        if SameText(TzFolder(Node.Data).Name, Folder) then
        begin
          Node.MakeVisible;
          Node.Selected := true;

          if Node.Count > 0 then
            Node.Items[0].Selected := true;

          while assigned(Node.parent) do
          begin
            Node.Expand(false);
            Node := Node.parent;
          end;

          exit;
        end;
  end;

  // se non trova nulla
  tree.FullExpand;
end;

procedure TzHelpForm.FormActivate(Sender: TObject);
begin
  ShowHelpFiles;
  ActiveControl := tree;
end;

procedure TzHelpForm.doGeneraHelp(HelpFileName: string; HelpSubject: IHelpSubject);
begin
  GeneraHelp(HelpFileName, HelpSubject);
end;

end.
