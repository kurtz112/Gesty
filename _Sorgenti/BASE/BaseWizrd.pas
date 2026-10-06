unit BaseWizrd;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Menus,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  dxCustomWizardControl,
  dxWizardControl,
  BaseFrm;

type
  TBaseWizard = class(TBaseForm)
    ActionList: TActionList;
    BasePopup: TdxBarPopupMenu;
    Wizard: TdxWizardControl;
    pageWelcome: TdxWizardControlPage;
    pageFinish: TdxWizardControlPage;
    actConfiguraWizard: TAction;
    procedure actConfiguraWizardExecute(Sender: TObject);
    procedure ActionVisible(Sender: TObject);
    procedure actVisualizzaGuidaExecute(Sender: TObject);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure WizardButtonClick(Sender: TObject; AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
    procedure WizardHandleChildControlKey(const Message: TCMChildKey; var AHandled: Boolean);
  private
    procedure SetWizardColors;
  protected
    procedure SetPageIndex(Pages: array of TdxWizardControlCustomPage);
    function NextVisiblePage: TdxWizardControlCustomPage;
    procedure InitWizard; virtual;

    procedure LoadWizardFromZip; virtual;
    procedure SaveWizardToZip; virtual;

    procedure CloseWizard(aModalResult: TModalResult);
    function ConfermaChiusura: Boolean; virtual;
    function ConfermaAnnulla: Boolean; virtual;

    procedure zzRaiseError(Msg: string; Control: TWinControl);
    procedure zzSetFocus(Control: TWinControl);
  public
    constructor Create(aOwner: TComponent); override;
    function ShowForm(const Modal: Boolean): Boolean; override;
  end;

implementation

uses
  ConfigModule, zSystem, zBaseLib, zDX, zFrmInspector, zDbCard, zMsg;

{$R *.dfm}
{ TFormVariazioneWizard }

constructor TBaseWizard.Create(aOwner: TComponent);
  procedure AddPopupItem(Action: TAction; BeginGroup: Boolean = false);
  var
    btn: TdxBarButton;
    ItemLink: TdxBarItemLink;
  begin
    btn := TdxBarButton.Create(self);
    btn.Action := Action;
    btn.PaintStyle := psCaptionGlyph;

    ItemLink := BasePopup.ItemLinks.Insert(0);
    ItemLink.Item := btn;
    ItemLink.BeginGroup := BeginGroup;
  end;

var
  I: Integer;

begin
  inherited;

  HideToolbars;

  AddPopupItem(ActStampa, True);
  AddPopupItem(actConfiguraWizard, True);
  actConfiguraWizard.OnUpdate := ActionVisible;
  //

  SetWizardColors;
  // Consorzio 21.01.2016
  Position := poMainFormCenter;
end;

procedure TBaseWizard.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  Handled := True;
  if Config.zSystem.IsAdmin then
    BasePopup.PopupFromCursorPos;
end;

procedure TBaseWizard.ActionVisible(Sender: TObject);
begin
  inherited;
  if Assigned(Config) then
    zBaseLib.ActionVisible(Sender as TAction, Config.zSystem.IsAdmin);
end;

procedure TBaseWizard.InitWizard;
var
  I: Integer;
  Page: TdxWizardControlCustomPage;
begin
  Wizard.ActivePage := pageWelcome; // chiamare per prima

  pageWelcome.PageIndex := 0;
  pageFinish.PageIndex := Wizard.PageCount - 1;

  for I := 0 to Wizard.PageCount - 1 do
  begin
    Page := Wizard.Pages[I];
    Page.Header.TitleFont.Name := 'Segoe UI';
    Page.Header.TitleFont.Size := 11;
    Page.Header.TitleFont.Style := [fsBold];
    //
    Page.Header.DescriptionFont.Name := 'Segoe UI';
    Page.Header.DescriptionFont.Size := 9;
    Page.Header.DescriptionFont.Style := [];
    //
    if SameText(Page.Header.Title, 'Title') then
      Page.Header.Title := '';

    if SameText(Page.Header.Description, 'Subtitle') then
      Page.Header.Description := '';
  end;
end;

procedure TBaseWizard.SetPageIndex(Pages: array of TdxWizardControlCustomPage);
var
  PageIndex: Integer;
  Page: TdxWizardControlCustomPage;
begin
  PageIndex := 0;
  for Page in Pages do
  begin
    Page.PageIndex := PageIndex;
    inc(PageIndex);
  end;
end;

function TBaseWizard.NextVisiblePage: TdxWizardControlCustomPage;
var
  I: Integer;
begin
  result := nil;

  for I := Wizard.ActivePage.PageIndex + 1 to Wizard.PageCount - 1 do
    if Wizard.Pages[I].PageVisible then
    begin
      result := Wizard.Pages[I];
      exit;
    end;
end;

procedure TBaseWizard.zzRaiseError(Msg: string; Control: TWinControl);
begin
  ConfirmOk(Msg);
  zzSetFocus(Control);
  System.SysUtils.Abort;
end;

procedure TBaseWizard.zzSetFocus(Control: TWinControl);
begin
  try
    if self.Visible then
      if Control.CanFocus then
      begin
        Control.SetFocus;

        if Control is TzDbCard then
          try
            Perform(Wm_NextDlgCtl, 0, 0);
          except
          end;
      end;
  except
  end;
end;

procedure TBaseWizard.CloseWizard(aModalResult: TModalResult);
begin
  ModalResult := aModalResult;
  CloseModal;
end;

function TBaseWizard.ConfermaChiusura: Boolean;
begin
  result := True;
end;

function TBaseWizard.ConfermaAnnulla: Boolean;
begin
  result := True;
end;

procedure TBaseWizard.SetWizardColors;
var
  comp: TComponent;
  I: Integer;
  Page: TdxWizardControlCustomPage;
  HeaderColor: TColor;
  HeaderFontColor: TColor;
begin
  inherited;

  // Wizard.Color := dx.GetColor(ckWizard);
  Wizard.Font.Color := dx.GetFontColor(ckWizard);

  HeaderColor := dx.GetColor(ckWizardTitle);
  HeaderFontColor := dx.GetFontColor(ckWizardTitle);

  for I := 0 to Wizard.PageCount - 1 do
  begin
    Page := Wizard.Pages[I];
    // Page.Color := Wizard.Color;
    // Page.Header.Color := HeaderColor;
    Page.Header.TitleFont.Color := HeaderFontColor;
    Page.Header.DescriptionFont.Color := HeaderFontColor;
  end;
end;

procedure TBaseWizard.WizardButtonClick(Sender: TObject; AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
begin
  inherited;

  case AKind of
    wcbkBack:
      begin
        AHandled := false;
      end;

    wcbkNext:
      begin
        AHandled := false;
      end;

    wcbkCancel:
      begin
        if ConfermaAnnulla then
          CloseWizard(mrCancel);

        AHandled := True;
      end;

    wcbkHelp:
      begin
        actVisualizzaGuida.Execute;
        AHandled := True;
      end;

    wcbkFinish:
      begin
        if ConfermaChiusura then
          CloseWizard(mrOk);

        AHandled := True;
      end;
  end;
end;

procedure TBaseWizard.WizardHandleChildControlKey(const Message: TCMChildKey; var AHandled: Boolean);
begin
  inherited;

  AHandled := false;

  if Message.CharCode = VK_ESCAPE then
    AHandled := True
  else
    if Message.CharCode = VK_RETURN then
      AHandled := EnterAsTab;
end;

procedure TBaseWizard.LoadWizardFromZip;
var
  I: Integer;
  Page: TdxWizardControlCustomPage;
  idx: Integer;
  Item: TzWizard;
  SaveZip: Boolean;
  ItemPage: TzWizardPage;
begin
  SaveZip := false;

  idx := Config.zSystem.zWizards.IndexOf(self.Name);
  if idx <> -1 then
    Item := Config.zSystem.zWizards[idx]
  else
    Item := nil;

  if Assigned(Item) then
    for I := 0 to Wizard.PageCount - 1 do
    begin
      Page := Wizard.Pages[I];

      idx := Item.Pages.IndexOf(Page.Name);
      if idx <> -1 then
      begin
        ItemPage := Item.Pages[idx];
        Page.Header.Title := ItemPage.Header;
        Page.Header.Description := ItemPage.Subtitle.Text;
      end
      else
        SaveZip := True;
    end;

  if SaveZip then
    SaveWizardToZip;
end;

procedure TBaseWizard.SaveWizardToZip;
var
  I: Integer;
  idx: Integer;
  Item: TzWizard;
  ItemPage: TzWizardPage;
begin
  idx := Config.zSystem.zWizards.IndexOf(self.Name);
  if idx <> -1 then
    Item := Config.zSystem.zWizards[idx]
  else
  begin
    Item := Config.zSystem.zWizards.Add;
    Item.Name := self.Name;
  end;

  for I := 0 to Wizard.PageCount - 1 do
  begin
    idx := Item.Pages.IndexOf(Wizard.Pages[I].Name);
    if idx <> -1 then
      ItemPage := Item.Pages[idx]
    else
      ItemPage := Item.Pages.Add;

    ItemPage.Name := Wizard.Pages[I].Name;
    ItemPage.Header := Wizard.Pages[I].Header.Title;
    ItemPage.Subtitle.Text := Wizard.Pages[I].Header.Description;
  end;

  Config.zSystem.SaveZip(csWizards, 'Wizard');
end;

procedure TBaseWizard.actConfiguraWizardExecute(Sender: TObject);
var
  I: Integer;
  idx: Integer;
  Item: TzWizard;
  ItemPage: TzWizardPage;
begin
  inherited;

  idx := Config.zSystem.zWizards.IndexOf(self.Name);
  if idx <> -1 then
    Item := Config.zSystem.zWizards[idx]
  else
  begin
    Item := Config.zSystem.zWizards.Add;
    Item.Name := self.Name;
  end;

  idx := Item.Pages.IndexOf(Wizard.ActivePage.Name);
  if idx <> -1 then
    ItemPage := Item.Pages[idx]
  else
  begin
    ItemPage := Item.Pages.Add;
    ItemPage.Name := Wizard.ActivePage.Name;
    ItemPage.Header := Wizard.ActivePage.Header.Title;
    ItemPage.Subtitle.Text := Wizard.ActivePage.Header.Description;
  end;

  if zEditProperties([ItemPage]) then
  begin
    Config.zSystem.SaveZip(csWizards, 'Wizard');
    LoadWizardFromZip;
  end;
end;

procedure TBaseWizard.actVisualizzaGuidaExecute(Sender: TObject);
begin
  inherited;
  if HelpType = HtContext then
    Application.HelpContext(HelpContext)
  else
    Application.HelpKeyword(HelpKeyword);
end;

function TBaseWizard.ShowForm(const Modal: Boolean): Boolean;
begin
  InitWizard;
  LoadWizardFromZip;

  result := inherited;
end;

end.


// wizGeneraAccertamentoFrm
// wizGeneraFatturaFrm
// wizIntestatarioFrm
// wizRateizzazioneFrm

// wizRegistrazioneContabileFrm
// wizRegistrazioneIncassoFrm
// wizRegistrazioneTributoFrm
// wizScadenzaManualeFrm
// wizVariazioneFrm
// wizGeraSostituzionePneumaticiFrm
