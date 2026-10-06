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
  private
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

procedure TFormGRS.ImportaGOLAccept(Sender: TObject);
var
  id: integer;
  view: TzDbView;
begin
  inherited;

  id := GRS.ImportaGOL(ImportaGOL.Dialog.Filename);

  if id <> -1 then
  begin
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
