unit WizNuovaRichiestaAttivazioneFrm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  BaseWizrd,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  System.ImageList,
  Vcl.ImgList,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  Vcl.ExtCtrls,
  zDbCard,
  zFbDataSet,
  zDbView,
  data.db,
  cxTextEdit,
  cxMemo,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.Mask,
  dxLayoutContainer,
  dxLayoutControl,
  dxLayoutControlAdapters,
  Vcl.Menus,
  cxButtons,
  dxLayoutcxEditAdapters,
  cxMaskEdit,
  dxGDIPlusClasses,
  cxImage,
  cxRadioGroup,
  cxDropDownEdit,
  cxImageComboBox,
  cxImageList,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  zFileViewer,
  Base_DataModule,
  dxLayoutLookAndFeels,
  cxSplitter,
  dxCustomWizardControl,
  dxWizardControl,
  cxCheckBox,
  cxDBExtLookupComboBox;

type
  TWizNuovaRichiestaAttivazioneForm = class(TBaseWizard)
    cardAltro: TzDbCard;
    viewSettori: TzDbView;
    memoRiepilogo: TcxMemo;
    dxLayoutControlRicercaGroup_Root: TdxLayoutGroup;
    dxLayoutControlRicerca: TdxLayoutControl;
    dxLayoutItemPartitaIVA: TdxLayoutItem;
    edPartitaIVA: TcxTextEdit;
    dxLayoutItemCodiceFiscale: TdxLayoutItem;
    edCodiceFiscale: TcxMaskEdit;
    dxLayoutGroupRicerca: TdxLayoutGroup;
    Verifica: TAction;
    AggiungiForniture: TAction;
    viewForniture: TzDbView;
    memoEsigenza: TcxMemo;
    dxLayoutItemEsigenza: TdxLayoutItem;
    cxImageListTipoRisorse: TcxImageList;
    edTipoRisorsa: TcxImageComboBox;
    dxLayoutItemTipoRisorsa: TdxLayoutItem;
    dxLayoutGroupEsigenza: TdxLayoutGroup;
    btnVerifica: TcxButton;
    dxLayoutItemVerifica: TdxLayoutItem;
    cardAzienda: TzDbCard;
    cardPersonale: TzDbCard;
    AggiungiCompetenze: TAction;
    AggiungiSettori: TAction;
    AggiungiTestoEsigenza: TAction;
    btnEsigenze: TcxButton;
    dxLayoutItemAggiungiEsigenza: TdxLayoutItem;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    edRichiedente: TcxExtLookupComboBox;
    dxLayoutItemRichiedente: TdxLayoutItem;
    cardAziendaDetail: TzDbCard;
    viewAllegati: TzDbView;
    viewerAllegati: TzFileViewer;
    Splitter1: TcxSplitter;
    panelForniture: TPanel;
    viewCompetenze: TzDbView;
    Splitter2: TcxSplitter;
    Splitter3: TcxSplitter;
    cardTipologiaFornitore: TzDbCard;
    dxLayoutEmptySpaceItem3: TdxLayoutEmptySpaceItem;
    ImageList: TImageList;
    pagePersonale: TdxWizardControlPage;
    pageAzienda: TdxWizardControlPage;
    pageAziendaDetail: TdxWizardControlPage;
    pageAltro: TdxWizardControlPage;
    pageSettori: TdxWizardControlPage;
    pageForniture: TdxWizardControlPage;
    pageAllegati: TdxWizardControlPage;
    procedure AggiungiTestoEsigenzaExecute(Sender: TObject);
    procedure AggiungiCompetenzeExecute(Sender: TObject);
    procedure AggiungiFornitureExecute(Sender: TObject);
    procedure AggiungiSettoriExecute(Sender: TObject);
    procedure edTipoRisorsaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure VerificaExecute(Sender: TObject);
    procedure viewerAllegatiImportFile(Sender: TzFileViewer; const FileName: string);
    procedure WizardPageChanged(Sender: TObject);
    procedure WizardPageChanging(Sender: TObject; ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);
  private
    procedure SetRequiredControls;
  protected
    function ConfermaAnnulla: Boolean; override;
    function ConfermaChiusura: Boolean; override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

function ApriNuovaRichiestaAttivazione: Integer;

implementation

uses
  WizNuovaRichiestaAttivazioneDM,
  zCodiceFiscale,
  ConfigModule,
  zBaseLib,
  zDbViewDlg,
  Files.Lib,
  zDX,
  cxFilter,
  zSystem,
   
  dmCommon;

{$R *.dfm}

function ApriNuovaRichiestaAttivazione: Integer;
var
  WizNuovaRichiestaAttivazioneForm: TWizNuovaRichiestaAttivazioneForm;
begin
  result := -1;

  Application.CreateForm(TWizNuovaRichiestaAttivazioneForm, WizNuovaRichiestaAttivazioneForm);
  try
    if WizNuovaRichiestaAttivazioneForm.ShowForm(True) then
      result := WizNuovaRichiestaAttivazione.idRichiestaAttivazione;
  finally
    FreeAndNil(WizNuovaRichiestaAttivazioneForm);
  end;
end;

procedure TWizNuovaRichiestaAttivazioneForm.AggiungiTestoEsigenzaExecute(Sender: TObject);
begin
  inherited;
  WizNuovaRichiestaAttivazione.AggiungiTestoEsigenza(memoEsigenza.Lines);
end;

function TWizNuovaRichiestaAttivazioneForm.ConfermaAnnulla: Boolean;
begin
  result := False;
  if CloseQuery then
    result := WizNuovaRichiestaAttivazione.ConfermaAnnulla;
end;

function TWizNuovaRichiestaAttivazioneForm.ConfermaChiusura: Boolean;
begin
  result := WizNuovaRichiestaAttivazione.ConfermaChiusura;
end;

procedure TWizNuovaRichiestaAttivazioneForm.CreateDataModule;
begin
  inherited;
  CreateDM(TWizNuovaRichiestaAttivazione, WizNuovaRichiestaAttivazione);
end;

procedure TWizNuovaRichiestaAttivazioneForm.DestroyDataModule;
begin
  inherited;
  FreeAndNil(WizNuovaRichiestaAttivazione);
end;

procedure TWizNuovaRichiestaAttivazioneForm.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Nuova Richiesta Attivazione';
  ReportGroup := 'Nuova Richiesta Attivazione';

  setPageIndex([pageWelcome, pagePersonale, pageAzienda, pageAziendaDetail, pageAltro, pageForniture, pageSettori, pageAllegati, pageFinish]);

  memoEsigenza.Clear;
  edTipoRisorsa.ItemIndex := 0;

  edRichiedente.Text := '';

  dx.InitLookup('', edRichiedente, WizNuovaRichiestaAttivazione.lkRichiedenti, WizNuovaRichiestaAttivazione.lkRichiedentiSrc, '', '');

  edRichiedente.EditValue := Common.CurrentIdRisorsa;

  ActiveControl := edCodiceFiscale;

  if DebugHook <> 0 then
    if Config.zSystem.IsAdmin then
    begin
      edCodiceFiscale.EditValue := 'ZBRLCU71B11L872Z';
      edPartitaIVA.EditValue := '01675770034';
      edRichiedente.EditValue := 12;

      memoEsigenza.Lines.Text := 'Esigenza';
    end;

  dx.SetEditability(edRichiedente, edRequired);
end;

procedure TWizNuovaRichiestaAttivazioneForm.SetRequiredControls;
begin
  cardPersonale.UpdateColors;
  cardAzienda.UpdateColors;
  cardAziendaDetail.UpdateColors;
  cardAltro.UpdateColors;
end;

procedure TWizNuovaRichiestaAttivazioneForm.AggiungiFornitureExecute(Sender: TObject);
begin
  inherited;
  WizNuovaRichiestaAttivazione.AggiungiForniture;
end;

procedure TWizNuovaRichiestaAttivazioneForm.AggiungiSettoriExecute(Sender: TObject);
begin
  inherited;
  WizNuovaRichiestaAttivazione.AggiungiSettori;
end;

procedure TWizNuovaRichiestaAttivazioneForm.AggiungiCompetenzeExecute(Sender: TObject);
begin
  inherited;
  WizNuovaRichiestaAttivazione.AggiungiCompetenze;
end;

procedure TWizNuovaRichiestaAttivazioneForm.edTipoRisorsaClick(Sender: TObject);
begin
  inherited;

  if edTipoRisorsa.EditValue = 'A' then
  begin
    WizNuovaRichiestaAttivazione.TipoRisorsa := trAzienda;
    dxLayoutItemPartitaIVA.Index := dxLayoutItemTipoRisorsa.Index + 1;
    dxLayoutItemCodiceFiscale.Index := dxLayoutItemPartitaIVA.Index + 1;
  end
  else
  begin
    WizNuovaRichiestaAttivazione.TipoRisorsa := trPersonale;
    dxLayoutItemCodiceFiscale.Index := dxLayoutItemTipoRisorsa.Index + 1;
    dxLayoutItemPartitaIVA.Index := dxLayoutItemCodiceFiscale.Index + 1;
  end;

  /// /////////////////////////////////////////////////////////////////////
  pagePersonale.PageVisible := WizNuovaRichiestaAttivazione.TipoRisorsa = trPersonale;
  pageAzienda.PageVisible := WizNuovaRichiestaAttivazione.TipoRisorsa = trAzienda;
  pageAziendaDetail.PageVisible := WizNuovaRichiestaAttivazione.TipoRisorsa = trAzienda;
end;

procedure TWizNuovaRichiestaAttivazioneForm.VerificaExecute(Sender: TObject);
begin
  inherited;
  WizNuovaRichiestaAttivazione.VerificaCodiceFiscale(edCodiceFiscale.Text, edPartitaIVA.Text);
end;

procedure TWizNuovaRichiestaAttivazioneForm.viewerAllegatiImportFile(Sender: TzFileViewer; const FileName: string);
var
  idFile: Integer;
  oid: Integer;
begin
  inherited;
  oid := GetOid(Sender.DataSet, viewerAllegati.FieldNameOID);
  idFile := ImportObjFile(oid, Sender.DataSet, FileName, nil, false);
  WizNuovaRichiestaAttivazione.SetTipoAllegatoRequired;

  // posiziona sul record appena creato utilizzano Locate standard
  WizNuovaRichiestaAttivazione.Allegati.LocateNonSQL('ID_OBJECT_FILE', idFile, []);

  viewAllegati.ShowRecord(False);
end;

procedure TWizNuovaRichiestaAttivazioneForm.WizardPageChanged(Sender: TObject);
begin
  inherited;

  if Assigned(Wizard.ActivePage) then
    Wizard.Buttons.Back.Enabled := not((Wizard.ActivePage = pagePersonale) or (Wizard.ActivePage = pageAzienda));
end;

procedure TWizNuovaRichiestaAttivazioneForm.WizardPageChanging(Sender: TObject; ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);

  procedure SetCard(DataSet: TzFbDataSet; card: TzDbCard; cardId: string);
  begin
    if Assigned(card.zDataSet) then
      exit;

    card.cardId := 'WizNuovaRichiestaAttivazioneForm.' + cardId;
    card.zDataSet := DataSet;
    card.UpdateColors;
  end;

  procedure SetView(DataSet: TzFbDataSet; view: TzDbView);
  begin
    if not Assigned(view.zDataSet) then
    begin
      view.zDataSet := DataSet;
      DataSet.Active := True;
    end;
  end;

var
  isNext: Boolean;
  IdRichiedente: Integer;
begin
  inherited;

  if not Assigned(Wizard.ActivePage) then
    exit;

  if not Assigned(WizNuovaRichiestaAttivazione) then
    exit;

  /// /////////////////////////////////////////////////////////////////////

  isNext := ANewPage.PageIndex >= Wizard.ActivePage.PageIndex;
  /// /////////////////////////////////////////////////////////////////////
  // post della testata
  if isNext then
  begin
    if Wizard.ActivePage = pageForniture then
      WizNuovaRichiestaAttivazione.RichiestaAttivazione.CheckBrowseMode
    else
      if Wizard.ActivePage = pageAllegati then
      begin
        if not WizNuovaRichiestaAttivazione.VerificaAllegati then
          ANewPage := pageAllegati;
      end;
  end;

  /// /////////////////////////////////////////////////////////////////////

  if (Wizard.ActivePage = pageWelcome) then
  begin
    if edRichiedente.EditText = '' then
      IdRichiedente := -1
    else
      IdRichiedente := edRichiedente.EditValue;

    WizNuovaRichiestaAttivazione.InitRichiesta(edCodiceFiscale.Text, edPartitaIVA.Text, IdRichiedente, memoEsigenza.Lines);

    SetRequiredControls;
  end
  /// /////////////////////////////////////////////////////////////////////
  else
    if (Wizard.ActivePage = pagePersonale) then
    begin
    end
    else
      if (Wizard.ActivePage = pageAzienda) then
      begin
      end;

  /// /////////////////////////////////////////////////////////////////////
  /// /////////////////////////////////////////////////////////////////////
  /// /////////////////////////////////////////////////////////////////////

  if ANewPage = pagePersonale then
  begin
    SetCard(WizNuovaRichiestaAttivazione.RichiestaAttivazione, cardPersonale, 'cardPersonale');
  end
  else
    if ANewPage = pageAzienda then
    begin
      SetCard(WizNuovaRichiestaAttivazione.RichiestaAttivazione, cardAzienda, 'cardAzienda');
    end
    else
      if ANewPage = pageAziendaDetail then
      begin
        SetCard(WizNuovaRichiestaAttivazione.RichiestaAttivazione, cardAziendaDetail, 'cardAziendaDetail');
      end
      else
        if ANewPage = pageAltro then
        begin
          SetCard(WizNuovaRichiestaAttivazione.RichiestaAttivazione, cardAltro, 'cardAltro');
        end
        else
          if ANewPage = pageForniture then
          begin
            SetCard(WizNuovaRichiestaAttivazione.RichiestaAttivazione, cardTipologiaFornitore, 'cardTipologiaFornitore');
            SetView(WizNuovaRichiestaAttivazione.Forniture, viewForniture);
            SetView(WizNuovaRichiestaAttivazione.Competenze, viewCompetenze);
          end
          else
            if ANewPage = pageAllegati then
            begin
              SetView(WizNuovaRichiestaAttivazione.Allegati, viewAllegati);
              viewAllegati.cardId := 'Allegato';

              if viewerAllegati.DataSet = nil then
              begin
                viewerAllegati.DataSet := WizNuovaRichiestaAttivazione.Allegati;
                viewerAllegati.FieldName := 'FULL_FILE_NAME';
                viewerAllegati.FieldNameOID := 'ID_RICHIESTA_ATTIVAZIONE';
              end;
            end
            else
              if ANewPage = pageSettori then
              begin
                SetView(WizNuovaRichiestaAttivazione.Settori, viewSettori);
              end;

  /// /////////////////////////////////////////////////////////////////////
  // no else, il blocco precedente potrebbe variare la condizione
  if ANewPage = pageFinish then
    memoRiepilogo.Lines.Text := WizNuovaRichiestaAttivazione.GetRiepilogo;
end;

end.
