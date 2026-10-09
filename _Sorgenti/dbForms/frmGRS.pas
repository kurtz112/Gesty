unit frmGRS;

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
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  System.Actions,
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  Vcl.StdActns,
  dxFileActions,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  Vcl.Menus,
  dxLayoutcxEditAdapters,
  dxLayoutControlAdapters,
  dxLayoutContainer,
  Vcl.StdCtrls,
  cxButtons,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  dxLayoutControl,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBExtLookupComboBox;

type
  TFormGRS = class(TBaseForm)
    ActionList: TActionList;
    Esporta: TdxFileSaveAs;
    ImportaGRS: TdxFileOpen;
    ImportaSIUF: TdxFileOpen;
    ImportaGOL: TdxFileOpen;
    ElaboraFileImport: TAction;
    GeneraIncarico: TAction;
    GeneraRilevamento: TAction;
    EliminaFileImport: TAction;
    ElaboraRigheImportNonValide: TAction;
    CooperazioneApplicativa: TAction;
    DifferenzeMantieniGesty: TAction;
    DifferenzeSovrascrivi: TAction;
    MonitoraggioEsegui: TAction;
    DifformitaGiustifica: TAction;
    DifformitaRisolta: TAction;
    DifformitaRiapri: TAction;
    procedure CooperazioneApplicativaExecute(Sender: TObject);
    procedure CooperazioneApplicativaUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EsportaAccept(Sender: TObject);
    procedure ElaboraFileImportExecute(Sender: TObject);
    procedure ElaboraRigheImportNonValideExecute(Sender: TObject);
    procedure EliminaFileImportExecute(Sender: TObject);
    procedure GeneraIncaricoExecute(Sender: TObject);
    procedure GeneraRilevamentoExecute(Sender: TObject);
    procedure ImportaGOLAccept(Sender: TObject);
    procedure ImportaGRSAccept(Sender: TObject);
    procedure ImportaSIUFAccept(Sender: TObject);
    procedure DifferenzeMantieniGestyExecute(Sender: TObject);
    procedure DifferenzeSovrascriviExecute(Sender: TObject);
    procedure MonitoraggioEseguiExecute(Sender: TObject);
    procedure DifformitaGiustificaExecute(Sender: TObject);
    procedure DifformitaRisoltaExecute(Sender: TObject);
    procedure DifformitaRiapriExecute(Sender: TObject);
    procedure DifformitaUpdate(Sender: TObject);
  private
    procedure DecidiDifferenzeSelezionate(const Decisione: string);
    procedure CambiaStatoDifformitaSelezionate(const Stato: string);
  protected
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  FormGRS: TFormGRS;

implementation

uses
  System.DateUtils,
  System.Generics.Collections,
  cxFilter,
  zDX,
  dmGRS,
  zDbView,
  zDm_Images,
  zFrmParams,
  zBaseLib,
  dmCommon,
  ConfigModule,
  Gesty.Authorizations,
  zMsg;
{$R *.dfm}

procedure TFormGRS.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'GRS';
  Caption := 'GRS';
end;

procedure TFormGRS.CreateDataModule;
begin
  inherited;
  CreateDM(TGRS, GRS);
end;

procedure TFormGRS.DestroyDataModule;
begin
  inherited;
  FreeAndNil(GRS);
end;

procedure TFormGRS.EsportaAccept(Sender: TObject);
begin
  inherited;
  GRS.Esporta(SelectedDataSetName, Esporta.Dialog.Filename);
end;

procedure TFormGRS.ImportaGRSAccept(Sender: TObject);
var
  id: integer;
  view: TzDbView;
begin
  inherited;

  id := GRS.ImportaGRS(ImportaGRS.Dialog.Filename);

  if id <> -1 then
  begin
    view := GetView('GRS_FILES');

    view.AddFilterCondition('ID_GRS_IMPORT_FILE', foEqual, id);

    view.ShowRecord(false);

    // Mantis #228 - 2026-10-09: l'importazione registra solo il file; l'elaborazione segue come da "Elabora",
    // quindi con il confronto con le lezioni gia' presenti in Gesty.
    GRS.ElaboraFileImport(id);
  end;
end;

procedure TFormGRS.ElaboraFileImportExecute(Sender: TObject);
begin
  inherited;
  GRS.ElaboraFileImport;
end;

procedure TFormGRS.ElaboraRigheImportNonValideExecute(Sender: TObject);
begin
  inherited;
  GRS.ElaboraRigheImportNonValide;
end;

procedure TFormGRS.EliminaFileImportExecute(Sender: TObject);
begin
  inherited;
  GRS.EliminaFileImport;
end;

procedure TFormGRS.GeneraIncaricoExecute(Sender: TObject);
begin
  inherited;
  GRS.GeneraIncaricoMancante;
end;

procedure TFormGRS.GeneraRilevamentoExecute(Sender: TObject);
var
  orari: TList<integer>;
  view: TzDbView;
begin
  inherited;

  orari := TList<integer>.Create;
  try
    view := GetView('RilevamentiMancanti');
    view.GetSelectedRows('ID_ORARIO', orari);
    GRS.GeneraRilevamentiMancanti(orari);
  finally
    FreeAndNil(orari);
  end;
end;

// Mantis #228 - 2026-10-08: decisione sulle lezioni delle righe selezionate nella scheda
// "Differenze con Gesty" (M = mantieni Gesty, S = sovrascrivi con il file)
procedure TFormGRS.DecidiDifferenzeSelezionate(const Decisione: string);
var
  Lezioni: TList<integer>;
  view: TzDbView;
begin
  Lezioni := TList<integer>.Create;
  try
    view := GetView('Grs_Files_Differenze');
    view.GetSelectedRows('ID_ORARIO', Lezioni);
    GRS.DecidiDifferenze(Lezioni, Decisione);
  finally
    FreeAndNil(Lezioni);
  end;
end;

procedure TFormGRS.DifferenzeMantieniGestyExecute(Sender: TObject);
begin
  inherited;
  DecidiDifferenzeSelezionate('M');
end;

procedure TFormGRS.DifferenzeSovrascriviExecute(Sender: TObject);
begin
  inherited;
  DecidiDifferenzeSelezionate('S');
end;

// Mantis #228 - 2026-10-08: controllo a richiesta di importazioni e invii SIUF, lo stesso che
// GestyScript esegue alle 7:00. Non blocca e non avvia invii.
procedure TFormGRS.MonitoraggioEseguiExecute(Sender: TObject);
begin
  inherited;
  GRS.EseguiMonitoraggioSiuf;
end;

// Mantis #228 - 2026-10-08: cambio di stato delle difformita' selezionate. Nel registro non si
// modifica niente: ogni cambio e' una riga nuova (G giustificata, R risolta, V da verificare)
procedure TFormGRS.CambiaStatoDifformitaSelezionate(const Stato: string);
var
  Righe: TList<integer>;
  view: TzDbView;
begin
  if not Config.zSystem.Authorizhed(Gesty_Authorizations.SIUF_COOPERAZIONE_APPLICATIVA) then
  begin
    ConfirmOk('Utente non autorizzato.');
    Exit;
  end;

  Righe := TList<integer>.Create;
  try
    view := GetView('Siuf_Monitoraggio_Difformita');
    view.GetSelectedRows('ID_SIUF_MONITORAGGIO_REGISTRO', Righe);
    GRS.CambiaStatoDifformita(Righe, Stato);
  finally
    FreeAndNil(Righe);
  end;
end;

procedure TFormGRS.DifformitaGiustificaExecute(Sender: TObject);
begin
  inherited;
  CambiaStatoDifformitaSelezionate('G');
end;

procedure TFormGRS.DifformitaRisoltaExecute(Sender: TObject);
begin
  inherited;
  CambiaStatoDifformitaSelezionate('R');
end;

procedure TFormGRS.DifformitaRiapriExecute(Sender: TObject);
begin
  inherited;
  CambiaStatoDifformitaSelezionate('V');
end;

procedure TFormGRS.DifformitaUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Visible := Config.zSystem.Authorizhed(Gesty_Authorizations.SIUF_COOPERAZIONE_APPLICATIVA);
end;

procedure TFormGRS.ImportaGOLAccept(Sender: TObject);
var
  id: integer;
  view: TzDbView;
begin
  inherited;

  id := GRS.ImportaGOL(ImportaGOL.Dialog.Filename);

  if id <> -1 then
  begin
    // Mantis #228 - 2026-10-09: l'elaborazione non e' piu' dentro l'importazione; qui resta immediata e senza confronto, come prima.
    GRS.ElaboraFileSenzaConfronto(id);

    view := GetView('GRS_FILES');

    view.AddFilterCondition('ID_GRS_IMPORT_FILE', foEqual, id);

    view.ShowRecord(false);
  end;
end;

procedure TFormGRS.ImportaSIUFAccept(Sender: TObject);
var
  id: integer;
  view: TzDbView;
begin
  inherited;

  id := GRS.ImportaSIUF(ImportaSIUF.Dialog.Filename);

  if id <> -1 then
  begin
    // Mantis #228 - 2026-10-09: l'elaborazione non e' piu' dentro l'importazione; qui resta immediata e senza confronto, come prima.
    GRS.ElaboraFileSenzaConfronto(id);

    view := GetView('GRS_FILES');

    view.AddFilterCondition('ID_GRS_IMPORT_FILE', foEqual, id);

    view.ShowRecord(false);
  end;
end;

procedure TFormGRS.SetupComponent(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
  BeforeShowParamsProc: TBeforeShowParamsProc;
begin
  inherited;

  BeforeShowParamsProc := procedure(zParamDialog: TzParamDialog)
    var
      edData: TcxDateEdit;
      edLookup: TcxExtLookupComboBox;
      idEnte, idSede, idProgetto, idCorso, idStudente: integer;
      Raggruppamento: string;
      group: TdxLayoutGroup;
      item: TdxCustomLayoutItem;
    begin
      zParamDialog.zDialog.Width := 500;
      zParamDialog.zDialog.Height := 220;

      // Ente
      Common.GetEnteAndSedeDefault(idEnte, idSede, Raggruppamento);
      edLookup := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctLookupExt, 'PARAM_ID_ENTE', 'Ente', idEnte) as TcxExtLookupComboBox;
      dx.InitLookup('GRS.lkEnti', edLookup, GRS.lkEnti, GRS.lkEntiSrc, 'ID_ENTE', 'ENTE;ID_ENTE');
      edLookup.EditValue := idEnte;

      // Progetto
      edLookup := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctLookupExt, 'PARAM_ID_PROGETTO', 'DENOMINAZIONE_PROGETTO', idProgetto) as TcxExtLookupComboBox;
      dx.InitLookup('GRS.lkProgetti', edLookup, GRS.lkProgetti, GRS.lkProgettiSrc, 'ID_PROGETTO', 'DENOMINAZIONE_PROGETTO;ID_PROGETTO');
      edLookup.EditValue := null;

      // Corso
      if zParamDialog.zDialog.zFormBuilder.Exists('PARAM_ID_CORSO') then
      begin
        edLookup := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctLookupExt, 'PARAM_ID_CORSO', 'IDENTIFICATIVO_CORSO', idCorso) as TcxExtLookupComboBox;
        dx.InitLookup('GRS.lkCorsi', edLookup, GRS.lkCorsi, GRS.lkCorsiSrc, 'ID_CORSO', 'IDENTIFICATIVO_CORSO;ID_CORSO');
        edLookup.EditValue := null;
        edLookup.ActiveProperties.Alignment.Horz := taLeftJustify;
      end;

      // Studente
      edLookup := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctLookupExt, 'PARAM_ID_STUDENTE', 'NOMINATIVO_STUDENTE', idStudente) as TcxExtLookupComboBox;
      dx.InitLookup('GRS.lkStudenti', edLookup, GRS.lkStudenti, GRS.lkStudentiSrc, 'ID_STUDENTE', 'NOMINATIVO_STUDENTE;ID_STUDENTE');
      edLookup.EditValue := null;

      /// //////////////////////////////////////
      group := zParamDialog.zDialog.zFormBuilder.AddLayoutGroup(nil, 'groupDate', ldHorizontal, '', false);

      // Dal Giorno
      edData := zParamDialog.zDialog.zFormBuilder.ControlByName<TcxDateEdit>('DAL_GIORNO');
      edData.Date := StartOfTheWeek(Date);
      edData.Properties.ShowTime := false;

      item := zParamDialog.zDialog.zFormBuilder.LayoutItemByControl(edData);
      if assigned(item) then
        item.Parent := group;

      // Al Giorno
      edData := zParamDialog.zDialog.zFormBuilder.ControlByName<TcxDateEdit>('AL_GIORNO');
      edData.Date := EndOfTheWeek(Date);
      edData.Properties.ShowTime := false;

      item := zParamDialog.zDialog.zFormBuilder.LayoutItemByControl(edData);
      if assigned(item) then
        item.Parent := group;
    end;

  if Component is TzDbView then
  begin
    view := TzDbView(Component);

    if SameText(DataSetName, 'ExportGRS') then
    begin
      view.BeforeShowParamsProc := BeforeShowParamsProc;
    end
    else
      if SameText(DataSetName, 'Grs_Export_Aule') then
      begin
        view.BeforeShowParamsProc := BeforeShowParamsProc;
      end
      else
        if SameText(DataSetName, 'Grs_Export_Sostegno') then
        begin
          view.BeforeShowParamsProc := BeforeShowParamsProc;
        end
        else
          if SameText(DataSetName, 'Grs_Export_Pip') then
          begin
            view.BeforeShowParamsProc := BeforeShowParamsProc;
          end
          else
            if SameText(DataSetName, 'Grs_Export_Tirocini') then
            begin
              view.BeforeShowParamsProc := BeforeShowParamsProc;
            end
            else
              if SameText(DataSetName, 'Grs_Export_Tirocini_Non_Accorp') then
              begin
                view.BeforeShowParamsProc := BeforeShowParamsProc;
              end;
  end;
end;

procedure TFormGRS.CooperazioneApplicativaExecute(Sender: TObject);
begin
  inherited;
  // vedere ambiente di test

  if not Config.zSystem.Authorizhed(Gesty_Authorizations.SIUF_COOPERAZIONE_APPLICATIVA) then
  begin
    ConfirmOk('Utente non autorizzato.');
    Exit;
  end;

  GRS.CooperazioneApplicativa(SelectedDataSetName);
end;

procedure TFormGRS.CooperazioneApplicativaUpdate(Sender: TObject);
begin
  inherited;
  CooperazioneApplicativa.Visible := Config.zSystem.Authorizhed(Gesty_Authorizations.SIUF_COOPERAZIONE_APPLICATIVA);
end;

end.
