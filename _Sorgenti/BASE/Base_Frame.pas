unit Base_Frame;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Actions,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  ActionListController,
  PageControlController,
  zSystem,
  zDbCard,
  zDbView,
  cxClasses,
  dxBar,
  zRestrictions,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxControls,
  cxButtons,
  dxLayoutContainer,
  dxLayoutControl;

type
  TBaseFrame = class(TFrame, IRestriction)
    dxBarManager: TdxBarManager;
    BaseActions: TActionList;
    actPermessiAzione: TAction;
    popActions: TdxBarPopupMenu;
    dxBarButtonPermessiAzione: TdxBarButton;
    procedure ActionUpdateAdmin(Sender: TObject);
    procedure actPermessiAzioneExecute(Sender: TObject);
    procedure dxBarManagerBarVisibleChange(Sender: TdxBarManager; ABar: TdxBar);
    procedure popActionsPopup(Sender: TObject);
  private
    ActionListController: TActionListController;
    PageControlController: TPageControlController;
  private
    RestrictionManager: TRestrictionManager;
    function GetRestrictionManager: TRestrictionManager;
  public
    procedure ApplyRestrictions;
  protected
    procedure SetIdCard(Card: TzDbCard);
    procedure VisibleIfAdmin(Sender: TObject);

    procedure ExpandButtonActivated(Sender: TObject);
    procedure LoadFromIni; virtual;
    procedure SaveToIni; virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterPrint; virtual;
    procedure BeforePrint; virtual;
    procedure Init; virtual;
  end;

// Lega a dx.Immagini le ActionList di Proprietario rimaste senza immagini
procedure AssegnaImmaginiActionList(Proprietario: TComponent);

implementation

uses
  Init_Controls,
  ConfigModule,
  zStorage,
  zRestrictions.Types,
  zz.Vcl,
  zDx;

{$R *.dfm}

procedure AssegnaImmaginiActionList(Proprietario: TComponent);
var
  Indice: Integer;
  ActionList: TActionList;
begin
  for Indice := 0 to Proprietario.ComponentCount - 1 do
    if Proprietario.Components[Indice] is TActionList then
    begin
      ActionList := TActionList(Proprietario.Components[Indice]);
      if not Assigned(ActionList.Images) then
        ActionList.Images := dx.Immagini;
    end;
end;

{ TBaseFrame }

constructor TBaseFrame.Create(aOwner: TComponent);
var
  IRestrictionIntf: IRestriction;
begin
  inherited;

  // I legami a dx.Immagini scritti nel DFM si perdono se la unit si salva con zDX
  // chiuso: si ripristinano da codice, anche per le ActionList dei frame derivati
  dxBarManager.ImageOptions.Images := dx.Immagini;
  dxBarManager.ImageOptions.LargeImages := dx.Immagini;
  BaseActions.Images := dx.Immagini;
  AssegnaImmaginiActionList(Self);

  ShowHint := True;

  Init_Ctrls(Self);

  LoadFromIni;

  ActionListController := TActionListController.Create;
  ActionListController.InitActions(Self);
  PageControlController := TPageControlController.Create(Self);
  PageControlController.InitFrame(Self);

  RestrictionManager := nil;
  if Supports(Owner, IRestriction, IRestrictionIntf) then
    RestrictionManager := IRestrictionIntf.GetRestrictionManager;

  ForEach<TcxButton>(
    procedure(cxButton: TcxButton)
    begin
      cxButton.PopupMenu := popActions;
    end);
end;

destructor TBaseFrame.Destroy;
begin
  FreeAndNil(ActionListController);
  FreeAndNil(PageControlController);

  SaveToIni;

  inherited;
end;

procedure TBaseFrame.ExpandButtonActivated(Sender: TObject);
begin
  PageControlController.ResetActivePages;
  PageControlController.ActivateDataSets;
  PageControlController.AutoSizePageControls;
end;

procedure TBaseFrame.SetIdCard(Card: TzDbCard);
begin
  if Assigned(Card) then
    Card.CardID := Self.Name + '.' + Card.Name;
end;

procedure TBaseFrame.VisibleIfAdmin(Sender: TObject);
begin
  if Sender is TAction then
    if Assigned(Config) then
      if Config.zSystem.ZSecurity.LoggedIn then
      begin
        TAction(Sender).Enabled := Config.zSystem.IsAdmin;
        TAction(Sender).Visible := Config.zSystem.IsAdmin;
      end;
end;

procedure TBaseFrame.ActionUpdateAdmin(Sender: TObject);
begin
  if Sender is TAction then
    if Assigned(Config) then
      if Config.zSystem.ZSecurity.LoggedIn then
      begin
        TAction(Sender).Enabled := Config.zSystem.IsAdmin;
        TAction(Sender).Visible := Config.zSystem.IsAdmin;
      end;
end;

procedure TBaseFrame.Init;
begin;
end;

procedure TBaseFrame.LoadFromIni;
begin;
  TzStorage.LoadControlFromIni(Config.StorageFileName, Self, Width, Height);
end;

procedure TBaseFrame.SaveToIni;
begin
  TzStorage.SaveControlToIni(Config.StorageFileName, Self);
end;

procedure TBaseFrame.AfterPrint;
begin
end;

procedure TBaseFrame.BeforePrint;
begin
end;

function TBaseFrame.GetRestrictionManager: TRestrictionManager;
begin
  result := RestrictionManager;
end;

procedure TBaseFrame.ApplyRestrictions;
begin
  // DisableAlign;
  // try
  // RestrictionManager.ApplyRestrictions;
  // finally
  // EnableAlign;
  // end;
end;

procedure TBaseFrame.actPermessiAzioneExecute(Sender: TObject);
var
  Action: TCustomAction;
begin
  Action := TCustomAction(popActions.Tag);

  if Assigned(Action) then
    RestrictionManager.EditComponentRestrictions(ClassName, ccAction, Action.Name);
end;

procedure TBaseFrame.dxBarManagerBarVisibleChange(Sender: TdxBarManager; ABar: TdxBar);
begin
  dx.dxBarAssignPopupMenu(ABar, popActions);
end;

procedure TBaseFrame.popActionsPopup(Sender: TObject);
var
  ctrl: TControl;
begin
  if not Config.zSystem.CanEditRestrictions then
    System.SysUtils.Abort
  else
  begin
    ctrl := ControlAtPos(ScreenToClient(GetMouseCursorPos), True, True);

    if ctrl is TdxLayoutControl then
      ctrl := TdxLayoutControl(ctrl).ControlAtPos(ScreenToClient(GetMouseCursorPos), True, True);

    if ctrl is TcxButton then
      if Assigned(TcxButton(ctrl).Action) then
        popActions.Tag := NativeInt(TcxButton(ctrl).Action);
  end;
end;

end.

zdbview.filter
