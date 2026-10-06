unit frmGeneraPrenotazioniAule;

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
  OkCancel,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  Vcl.Menus,
  cxContainer,
  cxEdit,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  dxLayoutcxEditAdapters,
  dxLayoutControlAdapters,
  dxLayoutContainer,
  cxClasses,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cxCheckBox,
  zDbView,
  cxDropDownEdit,
  cxCalendar,
  cxTextEdit,
  cxMaskEdit,
  cxSpinEdit,
  cxTimeEdit,
  Vcl.StdCtrls,
  cxButtons,
  dxLayoutControl,
  dxFormattedLabel,
  cxDBExtLookupComboBox,
  Data.DB,
  zFbDataSet;

type
  TGenerazionePrenotazioniAuleParams = record
    Aula: string;
    Oggetto: string;
    IdProgetto: integer;
    IdCorso: integer;

    DalGiorno: TDate;
    AlGiorno: TDate;

    SvuotaPrenotazioni: boolean;

    Lunedi: boolean;
    Martedi: boolean;
    Mercoledi: boolean;
    Giovedi: boolean;
    Venerdi: boolean;
    Sabato: boolean;
    Domenica: boolean;

    OraInizio_Lunedi: TTime;
    OraFine_Lunedi: TTime;
    OraInizio_Martedi: TTime;
    OraFine_Martedi: TTime;
    OraInizio_Mercoledi: TTime;
    OraFine_Mercoledi: TTime;
    OraInizio_Giovedi: TTime;
    OraFine_Giovedi: TTime;
    OraInizio_Venerdi: TTime;
    OraFine_Venerdi: TTime;
    OraInizio_Sabato: TTime;
    OraFine_Sabato: TTime;
    OraInizio_Domenica: TTime;
    OraFine_Domenica: TTime;

    procedure Init;
    function Verifica: boolean;
  end;

  TFormGeneraPrenotazioniAule = class(TForm)
    dxLayoutControl: TdxLayoutControl;
    edOra_Inizio_Lun: TcxTimeEdit;
    edOra_Inizio_Mar: TcxTimeEdit;
    edOra_Inizio_Mer: TcxTimeEdit;
    edOra_Inizio_Gio: TcxTimeEdit;
    edOra_Inizio_Ven: TcxTimeEdit;
    edOra_Inizio_Sab: TcxTimeEdit;
    edOra_Inizio_Dom: TcxTimeEdit;
    edOra_Fine_Lun: TcxTimeEdit;
    edOra_Fine_Mar: TcxTimeEdit;
    edOra_Fine_Mer: TcxTimeEdit;
    edOra_Fine_Gio: TcxTimeEdit;
    edOra_Fine_Ven: TcxTimeEdit;
    edOra_Fine_Sab: TcxTimeEdit;
    edOra_Fine_Dom: TcxTimeEdit;
    edDalGiorno: TcxDateEdit;
    edAlGiorno: TcxDateEdit;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutItemOra1InizioLun: TdxLayoutItem;
    dxLayoutItemOra1InizioMar: TdxLayoutItem;
    dxLayoutItemOra1InizioMer: TdxLayoutItem;
    dxLayoutItemOra1InizioGio: TdxLayoutItem;
    dxLayoutItemOra1InizioVen: TdxLayoutItem;
    dxLayoutItemOra1InizioSab: TdxLayoutItem;
    dxLayoutItemOra1InizioDom: TdxLayoutItem;
    dxLayoutItemOra1FineLun: TdxLayoutItem;
    dxLayoutItemOra1FineMar: TdxLayoutItem;
    dxLayoutItemOra1FineMer: TdxLayoutItem;
    dxLayoutItemOra1FineGio: TdxLayoutItem;
    dxLayoutItemOra1FineVen: TdxLayoutItem;
    dxLayoutItemOra1FineSab: TdxLayoutItem;
    dxLayoutItemOra1FineDom: TdxLayoutItem;
    dxLayoutItemDataInizio: TdxLayoutItem;
    dxLayoutItemDataFine: TdxLayoutItem;
    dxLayoutGroupLunedi: TdxLayoutGroup;
    dxLayoutGroupMartedi: TdxLayoutGroup;
    dxLayoutGroupMercoledi: TdxLayoutGroup;
    dxLayoutGroupGiovedi: TdxLayoutGroup;
    dxLayoutGroupSabato: TdxLayoutGroup;
    dxLayoutGroupVenerdi: TdxLayoutGroup;
    dxLayoutGroupDomenica: TdxLayoutGroup;
    dxLayoutGroupMain: TdxLayoutGroup;
    dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    dxLayoutGroupDate: TdxLayoutGroup;
    dxLayoutGroup: TdxLayoutGroup;
    dxLayoutItemLabelLunedi: TdxLayoutItem;
    dxLayoutItemLabelMartedi: TdxLayoutItem;
    dxLayoutItemLabelMercoledi: TdxLayoutItem;
    dxLayoutItemLabelDomenica: TdxLayoutItem;
    dxLayoutItemLabelSabato: TdxLayoutItem;
    dxLayoutItemLabelVenerdi: TdxLayoutItem;
    dxLayoutItemLabelGiovedi: TdxLayoutItem;
    tnOk: TcxButton;
    dxLayoutItemOk: TdxLayoutItem;
    btnCancel: TcxButton;
    dxLayoutItemCancel: TdxLayoutItem;
    dxLayoutGroupButtons: TdxLayoutGroup;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    checkLunedi: TcxCheckBox;
    checkMartedi: TcxCheckBox;
    checkMercoledi: TcxCheckBox;
    checkGiovedi: TcxCheckBox;
    checkVenerdi: TcxCheckBox;
    checkSabato: TcxCheckBox;
    checkDomenica: TcxCheckBox;
    edProgetto: TcxExtLookupComboBox;
    edCorso: TcxExtLookupComboBox;
    edAula: TcxExtLookupComboBox;
    edOggetto: TcxTextEdit;
    lkAuleSrc: TDataSource;
    lkProgettiSrc: TDataSource;
    lkCorsiSrc: TDataSource;
    dxLayoutItemAula: TdxLayoutItem;
    dxLayoutItemProgetto: TdxLayoutItem;
    dxLayoutItemCorso: TdxLayoutItem;
    dxLayoutItemOggetto: TdxLayoutItem;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutGroup2: TdxLayoutGroup;
    edEliminazionePrenotazioni: TcxCheckBox;
    dxLayoutItemEliminazionePrenotazioni: TdxLayoutItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure edDalGiornoPropertiesEditValueChanged(Sender: TObject);
    procedure edAlGiornoPropertiesEditValueChanged(Sender: TObject);
    procedure edProgettoPropertiesEditValueChanged(Sender: TObject);
    procedure edCorsoPropertiesEditValueChanged(Sender: TObject);
    procedure edOggettoPropertiesEditValueChanged(Sender: TObject);
    procedure edAulaPropertiesEditValueChanged(Sender: TObject);
    procedure edEliminazionePrenotazioniPropertiesEditValueChanged(Sender: TObject);
  private
    initialized: boolean;
    params: TGenerazionePrenotazioniAuleParams;
    lkAule, lkProgetti, lkCorsi: TzFbDataSet;
  private
    procedure InitEditors;
    procedure ActivateLookupDatasets(const Active: boolean);
    procedure AbilitaGiorni;
    procedure GiorniOreEditValueChanged(Sender: TObject);
    procedure OreEditValueChanged(Sender: TObject);

    function VerificaDati: boolean;
  public
    function Genera(var aParams: TGenerazionePrenotazioniAuleParams): boolean;
  end;

function GenerazionePrenotazioniAule(var params: TGenerazionePrenotazioniAuleParams): boolean;

implementation

uses
  System.DateUtils,
  zDX,
  dmPrenotazioniAule,
  zMsg;

{$R *.dfm}

function GenerazionePrenotazioniAule(var params: TGenerazionePrenotazioniAuleParams): boolean;
var
  FormGeneraPrenotazioniAule: TFormGeneraPrenotazioniAule;
begin
  Application.CreateForm(TFormGeneraPrenotazioniAule, FormGeneraPrenotazioniAule);
  try
    result := FormGeneraPrenotazioniAule.Genera(params);
  finally
    FreeAndNil(FormGeneraPrenotazioniAule);
  end;
end;

/// ///////////////////////////////////////////

procedure TGenerazionePrenotazioniAuleParams.Init;
var
  Inizio, Fine: TTime;
begin
  Aula := '';
  Oggetto := '';
  IdProgetto := -1;
  IdCorso := -1;

  DalGiorno := DateOf(Date);
  AlGiorno := DateOf(Date);

  SvuotaPrenotazioni := false;

  Lunedi := True;
  Martedi := True;
  Mercoledi := True;
  Giovedi := True;
  Venerdi := True;
  Sabato := false;
  Domenica := false;

  Inizio := EncodeTime(8, 0, 0, 0);
  Fine := EncodeTime(12, 0, 0, 0);

  OraInizio_Lunedi := Inizio;
  OraFine_Lunedi := Fine;
  OraInizio_Martedi := Inizio;
  OraFine_Martedi := Fine;
  OraInizio_Mercoledi := Inizio;
  OraFine_Mercoledi := Fine;
  OraInizio_Giovedi := Inizio;
  OraFine_Giovedi := Fine;
  OraInizio_Venerdi := Inizio;
  OraFine_Venerdi := Fine;
  OraInizio_Sabato := 0;
  OraFine_Sabato := 0;
  OraInizio_Domenica := 0;
  OraFine_Domenica := 0;
end;

function TGenerazionePrenotazioniAuleParams.Verifica: boolean;
  procedure VerificaOre(Giorno: string; OraInizio, OraFine: TTime);
  begin

    if (OraInizio <> 0) and (OraFine <> 0) and (OraInizio >= OraFine) then
      raise Exception.Create(Giorno + ': ora inizio maggiore di ora fine.');
  end;

begin
  result := false;

  if Aula.IsEmpty then
    raise Exception.Create('Aula non specificata.');

  if not SvuotaPrenotazioni then
    if Oggetto.IsEmpty then
      raise Exception.Create('Oggetto non specificato.');

  if (DalGiorno = 0) or (DalGiorno = cxDateUtils.NullDate) then
    raise Exception.Create('Data Inizio non specificata.');

  if (AlGiorno = 0) or (AlGiorno = cxDateUtils.NullDate) then
    raise Exception.Create('Data Fine non specificata.');

  if DalGiorno > AlGiorno then
    raise Exception.Create('Data inizio maggiore data fine.');

  VerificaOre('Lunedì', OraInizio_Lunedi, OraFine_Lunedi);
  VerificaOre('Martedì', OraInizio_Martedi, OraFine_Martedi);
  VerificaOre('Mercoledì', OraInizio_Mercoledi, OraFine_Mercoledi);
  VerificaOre('Giovedì', OraInizio_Giovedi, OraFine_Giovedi);
  VerificaOre('Venerdì', OraInizio_Venerdi, OraFine_Venerdi);
  VerificaOre('Sabato', OraInizio_Sabato, OraFine_Sabato);
  VerificaOre('Domenica', OraInizio_Domenica, OraFine_Domenica);

  if SvuotaPrenotazioni then
    if not ConfirmYesNo('Si desidera eliminare le prenotazioni preesistenti?', mtWarning) then
    begin
      result := false;
      exit;
    end;

  result := True;
end;

/// //////////////////////////////////////////////////////////////////////////////////

procedure TFormGeneraPrenotazioniAule.FormCreate(Sender: TObject);
begin
  params.Init;
  dx.InitLayoutControl(dxLayoutControl);

  lkAule := PrenotazioniAule.GetDataSet('lkPrenotPeriodoAule');
  lkProgetti := PrenotazioniAule.GetDataSet('lkPrenotPeriodoProgetti');
  lkCorsi := PrenotazioniAule.GetDataSet('lkPrenotPeriodoCorsi');

  lkAuleSrc.DataSet := lkAule;
  lkProgettiSrc.DataSet := lkProgetti;
  lkCorsiSrc.DataSet := lkCorsi;

  InitEditors;
end;

procedure TFormGeneraPrenotazioniAule.InitEditors;

  procedure InitCheckBox(cxCheckBox: TcxCheckBox);
  begin
    cxCheckBox.Properties.Alignment := taLeftJustify;
    cxCheckBox.Properties.ImmediatePost := True;
    cxCheckBox.Transparent := True;
    cxCheckBox.Properties.OnEditValueChanged := GiorniOreEditValueChanged;
  end;

  procedure InitTimeEdit(cxTimeEdit: TcxTimeEdit);
  begin
    cxTimeEdit.Properties.ImmediatePost := True;
    cxTimeEdit.Properties.ReadOnly := false;
    cxTimeEdit.Properties.SpinButtons.Position := sbpHorzRight;
    cxTimeEdit.Properties.TimeFormat := tfHourMin;
    cxTimeEdit.Properties.OnEditValueChanged := OreEditValueChanged;
  end;

begin
  dx.InitLookup('edPrenotPeriodoAule', edAula, lkAule, lkAuleSrc, 'AULA', 'AULA');
  dx.InitLookup('edPrenotPeriodoProgetti', edProgetto, lkProgetti, lkProgettiSrc, 'ID_PROGETTO', 'DENOMINAZIONE_PROGETTO;ANNO_FORMATIVO');
  dx.InitLookup('edPrenotPeriodoCorsi', edCorso, lkCorsi, lkCorsiSrc, 'ID_CORSO', 'IDENTIFICATIVO_CORSO;ID_CORSO');

  InitCheckBox(checkLunedi);
  InitCheckBox(checkMartedi);
  InitCheckBox(checkMercoledi);
  InitCheckBox(checkGiovedi);
  InitCheckBox(checkVenerdi);
  InitCheckBox(checkSabato);
  InitCheckBox(checkDomenica);

  InitTimeEdit(edOra_Inizio_Lun);
  InitTimeEdit(edOra_Fine_Lun);
  InitTimeEdit(edOra_Inizio_Mar);
  InitTimeEdit(edOra_Fine_Mar);
  InitTimeEdit(edOra_Inizio_Mer);
  InitTimeEdit(edOra_Fine_Mer);
  InitTimeEdit(edOra_Inizio_Gio);
  InitTimeEdit(edOra_Fine_Gio);
  InitTimeEdit(edOra_Inizio_Ven);
  InitTimeEdit(edOra_Fine_Ven);
  InitTimeEdit(edOra_Inizio_Sab);
  InitTimeEdit(edOra_Fine_Sab);
  InitTimeEdit(edOra_Inizio_Dom);
  InitTimeEdit(edOra_Fine_Dom);
end;

procedure TFormGeneraPrenotazioniAule.AbilitaGiorni;

  procedure AbilitaTimeEdit(cxTimeEdit: TcxTimeEdit; const Abilitato: boolean);
  begin
    cxTimeEdit.Properties.ReadOnly := not Abilitato;
    cxTimeEdit.Enabled := Abilitato;
  end;

begin
  inherited;

  if not initialized then
    exit;

  AbilitaTimeEdit(edOra_Inizio_Lun, checkLunedi.Checked);
  AbilitaTimeEdit(edOra_Fine_Lun, checkLunedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_Mar, checkMartedi.Checked);
  AbilitaTimeEdit(edOra_Fine_Mar, checkMartedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_Mer, checkMercoledi.Checked);
  AbilitaTimeEdit(edOra_Fine_Mer, checkMercoledi.Checked);
  AbilitaTimeEdit(edOra_Inizio_Gio, checkGiovedi.Checked);
  AbilitaTimeEdit(edOra_Fine_Gio, checkGiovedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_Ven, checkVenerdi.Checked);
  AbilitaTimeEdit(edOra_Fine_Ven, checkVenerdi.Checked);
  AbilitaTimeEdit(edOra_Inizio_Sab, checkSabato.Checked);
  AbilitaTimeEdit(edOra_Fine_Sab, checkSabato.Checked);
  AbilitaTimeEdit(edOra_Inizio_Dom, checkDomenica.Checked);
  AbilitaTimeEdit(edOra_Fine_Dom, checkDomenica.Checked);
end;

procedure TFormGeneraPrenotazioniAule.edDalGiornoPropertiesEditValueChanged(Sender: TObject);
begin
  params.DalGiorno := edDalGiorno.Date;
end;

procedure TFormGeneraPrenotazioniAule.edAlGiornoPropertiesEditValueChanged(Sender: TObject);
begin
  params.AlGiorno := edAlGiorno.Date;
end;

procedure TFormGeneraPrenotazioniAule.GiorniOreEditValueChanged(Sender: TObject);
begin
  AbilitaGiorni;
end;

procedure TFormGeneraPrenotazioniAule.OreEditValueChanged(Sender: TObject);
begin

  if not initialized then
    exit;

  params.Lunedi := checkLunedi.Checked;
  params.Martedi := checkMartedi.Checked;
  params.Mercoledi := checkMercoledi.Checked;
  params.Giovedi := checkGiovedi.Checked;
  params.Venerdi := checkVenerdi.Checked;
  params.Sabato := checkSabato.Checked;
  params.Domenica := checkDomenica.Checked;

  params.DalGiorno := DateOf(edDalGiorno.Date);
  params.AlGiorno := DateOf(edAlGiorno.Date);

  params.OraInizio_Lunedi := TimeOf(edOra_Inizio_Lun.Time);
  params.OraFine_Lunedi := TimeOf(edOra_Fine_Lun.Time);
  params.OraInizio_Martedi := TimeOf(edOra_Inizio_Mar.Time);
  params.OraFine_Martedi := TimeOf(edOra_Fine_Mar.Time);
  params.OraInizio_Mercoledi := TimeOf(edOra_Inizio_Mer.Time);
  params.OraFine_Mercoledi := TimeOf(edOra_Fine_Mer.Time);
  params.OraInizio_Giovedi := TimeOf(edOra_Inizio_Gio.Time);
  params.OraFine_Giovedi := TimeOf(edOra_Fine_Gio.Time);
  params.OraInizio_Venerdi := TimeOf(edOra_Inizio_Ven.Time);
  params.OraFine_Venerdi := TimeOf(edOra_Fine_Ven.Time);
  params.OraInizio_Sabato := TimeOf(edOra_Inizio_Sab.Time);
  params.OraFine_Sabato := TimeOf(edOra_Fine_Sab.Time);
  params.OraInizio_Domenica := TimeOf(edOra_Inizio_Dom.Time);
  params.OraFine_Domenica := TimeOf(edOra_Fine_Dom.Time);
end;

procedure TFormGeneraPrenotazioniAule.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := True;

  if ModalResult = mrOk then
    CanClose := params.Verifica;
end;

function TFormGeneraPrenotazioniAule.Genera(var aParams: TGenerazionePrenotazioniAuleParams): boolean;
begin
  initialized := false;

  params := aParams;

  ActivateLookupDatasets(True);
  try

    if not params.Aula.IsEmpty then
      edAula.EditValue := params.Aula;

    if params.IdProgetto <> -1 then
      edProgetto.EditValue := params.IdProgetto;

    if params.IdCorso <> -1 then
      edCorso.EditValue := params.IdCorso;

    edOggetto.EditValue := params.Oggetto;

    edEliminazionePrenotazioni.Checked := false;

    checkLunedi.Checked := params.Lunedi;
    checkMartedi.Checked := params.Martedi;
    checkMercoledi.Checked := params.Mercoledi;
    checkGiovedi.Checked := params.Giovedi;
    checkVenerdi.Checked := params.Venerdi;
    checkSabato.Checked := params.Sabato;
    checkDomenica.Checked := params.Domenica;

    edDalGiorno.Date := params.DalGiorno;
    edAlGiorno.Date := params.AlGiorno;

    edOra_Inizio_Lun.Time := params.OraInizio_Lunedi;
    edOra_Fine_Lun.Time := params.OraFine_Lunedi;
    edOra_Inizio_Mar.Time := params.OraInizio_Martedi;
    edOra_Fine_Mar.Time := params.OraFine_Martedi;
    edOra_Inizio_Mer.Time := params.OraInizio_Mercoledi;
    edOra_Fine_Mer.Time := params.OraFine_Mercoledi;
    edOra_Inizio_Gio.Time := params.OraInizio_Giovedi;
    edOra_Fine_Gio.Time := params.OraFine_Giovedi;
    edOra_Inizio_Ven.Time := params.OraInizio_Venerdi;
    edOra_Fine_Ven.Time := params.OraFine_Venerdi;
    edOra_Inizio_Sab.Time := params.OraInizio_Sabato;
    edOra_Fine_Sab.Time := params.OraFine_Sabato;
    edOra_Inizio_Dom.Time := params.OraInizio_Domenica;
    edOra_Fine_Dom.Time := params.OraFine_Domenica;

    AbilitaGiorni;

    initialized := True;

    result := ShowModal = mrOk;

    // GeneraPrenotazioniAule

    if result then
      aParams := params;
  finally
    ActivateLookupDatasets(false);
  end;
end;

function TFormGeneraPrenotazioniAule.VerificaDati: boolean;

  procedure VerificaOre(Giorno: string; OraInizio, OraFine: TTime);
  begin

    if (OraInizio <> 0) and (OraFine <> 0) and (OraInizio >= OraFine) then
      raise Exception.Create(Giorno + ': ora inizio maggiore di ora fine.');
  end;

begin
  result := false;

  { TODO : oggetto/aula }

  if (edDalGiorno.Date = 0) or (edDalGiorno.Date = cxDateUtils.NullDate) then
    raise Exception.Create('Data Inizio non specificata');

  if (edAlGiorno.Date = 0) or (edAlGiorno.Date = cxDateUtils.NullDate) then
    raise Exception.Create('Data Fine non specificata');

  if edDalGiorno.Date < edAlGiorno.Date then
    raise Exception.Create('Data inizio minore data fine.');

  VerificaOre('Lunedì', edOra_Inizio_Lun.Time, edOra_Fine_Lun.Time);
  VerificaOre('Martedì', edOra_Inizio_Mar.Time, edOra_Fine_Mar.Time);
  VerificaOre('Mercoledì', edOra_Inizio_Mer.Time, edOra_Fine_Mer.Time);
  VerificaOre('Giovedì', edOra_Inizio_Gio.Time, edOra_Fine_Gio.Time);
  VerificaOre('Venerdì', edOra_Inizio_Ven.Time, edOra_Fine_Ven.Time);
  VerificaOre('Sabato', edOra_Inizio_Sab.Time, edOra_Fine_Sab.Time);
  VerificaOre('Domenica', edOra_Inizio_Dom.Time, edOra_Fine_Dom.Time);

  result := True;
end;

procedure TFormGeneraPrenotazioniAule.edAulaPropertiesEditValueChanged(Sender: TObject);
begin

  if VarIsNull(edAula.EditValue) then
    params.Aula := ''
  else
    params.Aula := edAula.EditValue;
end;

procedure TFormGeneraPrenotazioniAule.edProgettoPropertiesEditValueChanged(Sender: TObject);
begin
  if VarIsNull(edProgetto.EditValue) then
    params.IdProgetto := -1
  else
    params.IdProgetto := edProgetto.EditValue;

  edCorso.Clear;
  params.IdCorso := -1
end;

procedure TFormGeneraPrenotazioniAule.edCorsoPropertiesEditValueChanged(Sender: TObject);
begin

  if VarIsNull(edCorso.EditValue) then
    params.IdCorso := -1
  else
    params.IdCorso := edCorso.EditValue;
end;

procedure TFormGeneraPrenotazioniAule.edOggettoPropertiesEditValueChanged(Sender: TObject);
begin
  params.Oggetto := edOggetto.Text;
end;

procedure TFormGeneraPrenotazioniAule.ActivateLookupDatasets(const Active: boolean);
begin
  lkAule.Active := Active;
  lkProgetti.Active := Active;
  lkCorsi.Active := Active;
end;

procedure TFormGeneraPrenotazioniAule.edEliminazionePrenotazioniPropertiesEditValueChanged(Sender: TObject);
begin
  params.SvuotaPrenotazioni := edEliminazionePrenotazioni.Checked;
end;

end.
