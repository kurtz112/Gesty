unit frmCalendarioAvvioCorsi;

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
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxClasses,
  dxLayoutContainer,
  dxLayoutControl,
  dxCore,
  dxCoreClasses,
  dxHashUtils,
  dxSpreadSheetCore,
  dxSpreadSheetCoreFormulas,
  dxSpreadSheetCoreHistory,
  dxSpreadSheetCoreStyles,
  dxSpreadSheetCoreStrs,
  dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules,
  dxSpreadSheetClasses,
  dxSpreadSheetContainers,
  dxSpreadSheetFormulas,
  dxSpreadSheetHyperlinks,
  dxSpreadSheetFunctions,
  dxSpreadSheetStyles,
  dxSpreadSheetGraphics,
  dxSpreadSheetPrinting,
  dxSpreadSheetTypes,
  dxSpreadSheetUtils,
  dxSpreadSheetFormattedTextUtils,
  dxBarBuiltInMenu,
  dxSpreadSheetReportDesigner,
  dxSpreadSheet,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  Data.DB,
  cxDBData,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  dxLayoutControlAdapters,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  System.Actions,
  Vcl.ActnList,
  System.ImageList,
  Vcl.ImgList,
  cxImageList,
  Vcl.StdActns,
  dxFileActions,
  dxBar,
  dxSpreadSheetReportDesignerActions,
  dxActions,
  dxSpreadSheetActions,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  dxLayoutcxEditAdapters,
  cxContainer,
  cxGroupBox,
  Vcl.ComCtrls,
  cxDateUtils,
  cxDropDownEdit,
  cxCalendar,
  cxTextEdit,
  cxMaskEdit,
  cxSpinEdit,
  cxTimeEdit,
  dximctrl,
  BaseFrm,
  dxBarExtItems,
  cxLabel,
  zDbView,
  cxCheckBox,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cxDBExtLookupComboBox;

type
  TFormCalendarioAvvioCorsi = class(TBaseForm)
    ActionList: TActionList;
    Svuota: TAction;
    btnSvuota: TcxButton;
    dxLayoutControl: TdxLayoutControl;
    edOra_Inizio_2_Lun: TcxTimeEdit;
    edOra_Fine_2_Lun: TcxTimeEdit;
    edNumero_Ore_Lun: TcxTextEdit;
    edOra_Inizio_1_Lun: TcxTimeEdit;
    edOra_Inizio_1_Mar: TcxTimeEdit;
    edOra_Inizio_1_Mer: TcxTimeEdit;
    edOra_Inizio_1_Gio: TcxTimeEdit;
    edOra_Inizio_1_Ven: TcxTimeEdit;
    edOra_Inizio_1_Sab: TcxTimeEdit;
    edOra_Inizio_1_Dom: TcxTimeEdit;
    edOra_Fine_1_Lun: TcxTimeEdit;
    edOra_Fine_1_Mar: TcxTimeEdit;
    edOra_Fine_1_Mer: TcxTimeEdit;
    edOra_Fine_1_Gio: TcxTimeEdit;
    edOra_Fine_1_Ven: TcxTimeEdit;
    edOra_Fine_1_Sab: TcxTimeEdit;
    edOra_Fine_1_Dom: TcxTimeEdit;
    edOra_Inizio_2_Mar: TcxTimeEdit;
    edOra_Fine_2_Mar: TcxTimeEdit;
    edNumero_Ore_Mar: TcxTextEdit;
    edOra_Inizio_2_Mer: TcxTimeEdit;
    edOra_Fine_2_Mer: TcxTimeEdit;
    edNumero_Ore_Mer: TcxTextEdit;
    edOra_Inizio_2_Gio: TcxTimeEdit;
    edOra_Fine_2_Gio: TcxTimeEdit;
    edNumero_Ore_Gio: TcxTextEdit;
    edOra_Inizio_2_Ven: TcxTimeEdit;
    edOra_Fine_2_Ven: TcxTimeEdit;
    edNumero_Ore_Ven: TcxTextEdit;
    edOra_Inizio_2_Sab: TcxTimeEdit;
    edOra_Fine_2_Sab: TcxTimeEdit;
    edNumero_Ore_Sab: TcxTextEdit;
    edOra_Inizio_2_Dom: TcxTimeEdit;
    edOra_Fine_2_Dom: TcxTimeEdit;
    edNumero_Ore_Dom: TcxTextEdit;
    edDalGiorno: TcxDateEdit;
    edAlGiorno: TcxDateEdit;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutGroupBtns: TdxLayoutGroup;
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
    dxLayoutItemOra2InizioLun: TdxLayoutItem;
    dxLayoutItemOra2InizioMar: TdxLayoutItem;
    dxLayoutItemOra2InizioMer: TdxLayoutItem;
    dxLayoutItemOra2InizioGio: TdxLayoutItem;
    dxLayoutItemOra2InizioVen: TdxLayoutItem;
    dxLayoutItemOra2InizioSab: TdxLayoutItem;
    dxLayoutItemOra2InizioDom: TdxLayoutItem;
    dxLayoutItemOra2FineLun: TdxLayoutItem;
    dxLayoutItemOra2FineMar: TdxLayoutItem;
    dxLayoutItemOra2FineMer: TdxLayoutItem;
    dxLayoutItemOra2FineGio: TdxLayoutItem;
    dxLayoutItemOra2FineVen: TdxLayoutItem;
    dxLayoutItemOra2FineSab: TdxLayoutItem;
    dxLayoutItemOra2FineDom: TdxLayoutItem;
    dxLayoutItemTotaleOreLun: TdxLayoutItem;
    dxLayoutItemTotaleOreMar: TdxLayoutItem;
    dxLayoutItemTotaleOreMer: TdxLayoutItem;
    dxLayoutItemTotaleOreGio: TdxLayoutItem;
    dxLayoutItemTotaleOreVen: TdxLayoutItem;
    dxLayoutItemTotaleOreSab: TdxLayoutItem;
    dxLayoutItemTotaleOreDom: TdxLayoutItem;
    dxLayoutItemDataInizio: TdxLayoutItem;
    dxLayoutItemDataFine: TdxLayoutItem;
    dxLayoutGroupLunedi: TdxLayoutGroup;
    dxLayoutGroupMartedi: TdxLayoutGroup;
    dxLayoutGroupMercoledi: TdxLayoutGroup;
    dxLayoutGroupGiovedi: TdxLayoutGroup;
    dxLayoutGroupSabato: TdxLayoutGroup;
    dxLayoutGroupVenerdi: TdxLayoutGroup;
    dxLayoutGroupDomenica: TdxLayoutGroup;
    dxLayoutGroupGiorni: TdxLayoutGroup;
    dxLayoutEmptySpaceItemLun: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemMar: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemMer: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemGio: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemVen: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemSab: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemDom: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotLun: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotMar: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotMer: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotGio: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotVen: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotSab: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotDom: TdxLayoutEmptySpaceItem;
    dxLayoutItemSvuota: TdxLayoutItem;
    dxLayoutGroupMain: TdxLayoutGroup;
    Genera: TAction;
    btnGenera: TcxButton;
    dxLayoutItemGenera: TdxLayoutItem;
    edModalita: TcxComboBox;
    dxLayoutItemModalita: TdxLayoutItem;
    dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    viewGiorni: TzDbView;
    dxLayoutItemCalendario: TdxLayoutItem;
    viewChiusure: TzDbView;
    dxLayoutItemChiusure: TdxLayoutItem;
    dxLayoutGroupTop: TdxLayoutGroup;
    dxLayoutEmptySpaceItem3: TdxLayoutEmptySpaceItem;
    checkLunedi: TcxCheckBox;
    checkMercoledi: TcxCheckBox;
    checkGiovedi: TcxCheckBox;
    checkVenerdi: TcxCheckBox;
    checkSabato: TcxCheckBox;
    checkDomenica: TcxCheckBox;
    checkMartedi: TcxCheckBox;
    dxLayoutItemLunedi: TdxLayoutItem;
    dxLayoutItemMartedì: TdxLayoutItem;
    dxLayoutItemMercoledi: TdxLayoutItem;
    dxLayoutItemGiovedi: TdxLayoutItem;
    dxLayoutItemVenerdi: TdxLayoutItem;
    dxLayoutItemSabato: TdxLayoutItem;
    dxLayoutItemDomenica: TdxLayoutItem;
    edTitoloCorso: TcxTextEdit;
    edCodiceCorso: TcxTextEdit;
    edTipoAnnualita: TcxTextEdit;
    edIdSezione: TcxTextEdit;
    edCodiceSezione: TcxTextEdit;
    edProgetto: TcxExtLookupComboBox;
    dxLayoutItemProgetto: TdxLayoutItem;
    dxLayoutItemTitoloCorso: TdxLayoutItem;
    dxLayoutItemCodiceCorso: TdxLayoutItem;
    dxLayoutItemTipoAnnualita: TdxLayoutItem;
    dxLayoutItemIdSezione: TdxLayoutItem;
    dxLayoutItemCodiceSezione: TdxLayoutItem;
    dxLayoutGroupProgetto: TdxLayoutGroup;
    dxLayoutGroupDate: TdxLayoutGroup;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    dxLayoutGroupCalendario: TdxLayoutGroup;
    procedure SvuotaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GeneraExecute(Sender: TObject);
    procedure EditValueChanged(Sender: TObject);
    procedure edModalitaPropertiesEditValueChanged(Sender: TObject);
    procedure edDalGiornoPropertiesEditValueChanged(Sender: TObject);
    procedure edAlGiornoPropertiesEditValueChanged(Sender: TObject);
    procedure AbilitaGiorni(Sender: TObject);
    procedure edProgettoPropertiesEditValueChanged(Sender: TObject);
    procedure edTitoloCorsoPropertiesEditValueChanged(Sender: TObject);
    procedure edCodiceCorsoPropertiesEditValueChanged(Sender: TObject);
    procedure edTipoAnnualitaPropertiesEditValueChanged(Sender: TObject);
    procedure edIdSezionePropertiesEditValueChanged(Sender: TObject);
    procedure edCodiceSezionePropertiesEditValueChanged(Sender: TObject);
  private
    procedure InitEditors;
    procedure InitValues;
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  FormCalendarioAvvioCorsi: TFormCalendarioAvvioCorsi;

implementation

uses
  System.DateUtils,
  cxGeometry,
  dmCalendarioAvvioCorsi,
  zDX,
  zMsg;

{$R *.dfm}

procedure TFormCalendarioAvvioCorsi.CreateDataModule;
begin
  inherited;
  CreateDM(TCalendarioAvvioCorsi, CalendarioAvvioCorsi);
end;

procedure TFormCalendarioAvvioCorsi.DestroyDataModule;
begin
  inherited;
  FreeAndNil(CalendarioAvvioCorsi);
end;

procedure TFormCalendarioAvvioCorsi.FormCreate(Sender: TObject);
begin
  inherited;

  InitEditors;

  InitValues;

  viewGiorni.zDataSet := CalendarioAvvioCorsi.Giorni;
  viewChiusure.zDataSet := CalendarioAvvioCorsi.DateChiusura;

  SelectedDataSetName := CalendarioAvvioCorsi.ElencoPerReport.name;

  WindowState := wsMaximized;
end;

procedure TFormCalendarioAvvioCorsi.EditValueChanged(Sender: TObject);
begin
  CalendarioAvvioCorsi.Lunedi := checkLunedi.Checked;
  CalendarioAvvioCorsi.Martedi := checkMartedi.Checked;
  CalendarioAvvioCorsi.Mercoledi := checkMercoledi.Checked;
  CalendarioAvvioCorsi.Giovedi := checkGiovedi.Checked;
  CalendarioAvvioCorsi.Venerdi := checkVenerdi.Checked;
  CalendarioAvvioCorsi.Sabato := checkSabato.Checked;
  CalendarioAvvioCorsi.Domenica := checkDomenica.Checked;

  CalendarioAvvioCorsi.DalGiorno := DateOf(edDalGiorno.Date);
  CalendarioAvvioCorsi.AlGiorno := DateOf(edAlGiorno.Date);

  CalendarioAvvioCorsi.OraInizio1_Lunedi := TimeOf(edOra_Inizio_1_Lun.Time);
  CalendarioAvvioCorsi.OraFine1_Lunedi := TimeOf(edOra_Fine_1_Lun.Time);
  CalendarioAvvioCorsi.OraInizio2_Lunedi := TimeOf(edOra_Inizio_2_Lun.Time);
  CalendarioAvvioCorsi.OraFine2_Lunedi := TimeOf(edOra_Fine_2_Lun.Time);

  CalendarioAvvioCorsi.OraInizio1_Martedi := TimeOf(edOra_Inizio_1_Mar.Time);
  CalendarioAvvioCorsi.OraFine1_Martedi := TimeOf(edOra_Fine_1_Mar.Time);
  CalendarioAvvioCorsi.OraInizio2_Martedi := TimeOf(edOra_Inizio_2_Mar.Time);
  CalendarioAvvioCorsi.OraFine2_Martedi := TimeOf(edOra_Fine_2_Mar.Time);

  CalendarioAvvioCorsi.OraInizio1_Mercoledi := TimeOf(edOra_Inizio_1_Mer.Time);
  CalendarioAvvioCorsi.OraFine1_Mercoledi := TimeOf(edOra_Fine_1_Mer.Time);
  CalendarioAvvioCorsi.OraInizio2_Mercoledi := TimeOf(edOra_Inizio_2_Mer.Time);
  CalendarioAvvioCorsi.OraFine2_Mercoledi := TimeOf(edOra_Fine_2_Mer.Time);

  CalendarioAvvioCorsi.OraInizio1_Giovedi := TimeOf(edOra_Inizio_1_Gio.Time);
  CalendarioAvvioCorsi.OraFine1_Giovedi := TimeOf(edOra_Fine_1_Gio.Time);
  CalendarioAvvioCorsi.OraInizio2_Giovedi := TimeOf(edOra_Inizio_2_Gio.Time);
  CalendarioAvvioCorsi.OraFine2_Giovedi := TimeOf(edOra_Fine_2_Gio.Time);

  CalendarioAvvioCorsi.OraInizio1_Venerdi := TimeOf(edOra_Inizio_1_Ven.Time);
  CalendarioAvvioCorsi.OraFine1_Venerdi := TimeOf(edOra_Fine_1_Ven.Time);
  CalendarioAvvioCorsi.OraInizio2_Venerdi := TimeOf(edOra_Inizio_2_Ven.Time);
  CalendarioAvvioCorsi.OraFine2_Venerdi := TimeOf(edOra_Fine_2_Ven.Time);

  CalendarioAvvioCorsi.OraInizio1_Sabato := TimeOf(edOra_Inizio_1_Sab.Time);
  CalendarioAvvioCorsi.OraFine1_Sabato := TimeOf(edOra_Fine_1_Sab.Time);
  CalendarioAvvioCorsi.OraInizio2_Sabato := TimeOf(edOra_Inizio_2_Sab.Time);
  CalendarioAvvioCorsi.OraFine2_Sabato := TimeOf(edOra_Fine_2_Sab.Time);

  CalendarioAvvioCorsi.OraInizio1_Domenica := TimeOf(edOra_Inizio_1_Dom.Time);
  CalendarioAvvioCorsi.OraFine1_Domenica := TimeOf(edOra_Fine_1_Dom.Time);
  CalendarioAvvioCorsi.OraInizio2_Domenica := TimeOf(edOra_Inizio_2_Dom.Time);
  CalendarioAvvioCorsi.OraFine2_Domenica := TimeOf(edOra_Fine_2_Dom.Time);

  CalendarioAvvioCorsi.CalcolaTotali;

  edNumero_Ore_Lun.Text := CalendarioAvvioCorsi.TotaleOreLunedi.ToString;
  edNumero_Ore_Mar.Text := CalendarioAvvioCorsi.TotaleOreMartedi.ToString;
  edNumero_Ore_Mer.Text := CalendarioAvvioCorsi.TotaleOreMercoledi.ToString;
  edNumero_Ore_Gio.Text := CalendarioAvvioCorsi.TotaleOreGiovedi.ToString;
  edNumero_Ore_Ven.Text := CalendarioAvvioCorsi.TotaleOreVenerdi.ToString;
  edNumero_Ore_Sab.Text := CalendarioAvvioCorsi.TotaleOreSabato.ToString;
  edNumero_Ore_Dom.Text := CalendarioAvvioCorsi.TotaleOreDomenica.ToString;
end;

procedure TFormCalendarioAvvioCorsi.InitEditors;

  procedure InitCheckBox(cxCheckBox: TcxCheckBox);
  begin
    cxCheckBox.Properties.Alignment := taLeftJustify;
    cxCheckBox.Properties.ImmediatePost := True;
    cxCheckBox.Transparent := True;
    cxCheckBox.Properties.OnEditValueChanged := AbilitaGiorni;
  end;

  procedure InitTimeEdit(cxTimeEdit: TcxTimeEdit);
  begin
    cxTimeEdit.Properties.ImmediatePost := True;
    cxTimeEdit.Properties.ReadOnly := False;
    cxTimeEdit.Properties.SpinButtons.Position := sbpHorzRight;
    cxTimeEdit.Properties.TimeFormat := tfHourMin;
    cxTimeEdit.Properties.OnEditValueChanged := EditValueChanged;
  end;

begin
  inherited;

  dx.InitLookup('', edProgetto, CalendarioAvvioCorsi.lkProgetti, CalendarioAvvioCorsi.lkProgettiSrc, 'ID_PROGETTO', 'DENOMINAZIONE_PROGETTO');

  InitCheckBox(checkLunedi);
  InitCheckBox(checkMartedi);
  InitCheckBox(checkMercoledi);
  InitCheckBox(checkGiovedi);
  InitCheckBox(checkVenerdi);
  InitCheckBox(checkSabato);
  InitCheckBox(checkDomenica);

  InitTimeEdit(edOra_Inizio_1_Lun);
  InitTimeEdit(edOra_Fine_1_Lun);
  InitTimeEdit(edOra_Inizio_2_Lun);
  InitTimeEdit(edOra_Fine_2_Lun);

  InitTimeEdit(edOra_Inizio_1_Mar);
  InitTimeEdit(edOra_Fine_1_Mar);
  InitTimeEdit(edOra_Inizio_2_Mar);
  InitTimeEdit(edOra_Fine_2_Mar);

  InitTimeEdit(edOra_Inizio_1_Mer);
  InitTimeEdit(edOra_Fine_1_Mer);
  InitTimeEdit(edOra_Inizio_2_Mer);
  InitTimeEdit(edOra_Fine_2_Mer);

  InitTimeEdit(edOra_Inizio_1_Gio);
  InitTimeEdit(edOra_Fine_1_Gio);
  InitTimeEdit(edOra_Inizio_2_Gio);
  InitTimeEdit(edOra_Fine_2_Gio);

  InitTimeEdit(edOra_Inizio_1_Ven);
  InitTimeEdit(edOra_Fine_1_Ven);
  InitTimeEdit(edOra_Inizio_2_Ven);
  InitTimeEdit(edOra_Fine_2_Ven);

  InitTimeEdit(edOra_Inizio_1_Sab);
  InitTimeEdit(edOra_Fine_1_Sab);
  InitTimeEdit(edOra_Inizio_2_Sab);
  InitTimeEdit(edOra_Fine_2_Sab);

  InitTimeEdit(edOra_Inizio_1_Dom);
  InitTimeEdit(edOra_Fine_1_Dom);
  InitTimeEdit(edOra_Inizio_2_Dom);
  InitTimeEdit(edOra_Fine_2_Dom);
end;

procedure TFormCalendarioAvvioCorsi.edModalitaPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalendarioAvvioCorsi.ModalitaOperativa := edModalita.EditingValue;
end;

procedure TFormCalendarioAvvioCorsi.edDalGiornoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalendarioAvvioCorsi.DalGiorno := edDalGiorno.Date;
end;

procedure TFormCalendarioAvvioCorsi.edAlGiornoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalendarioAvvioCorsi.AlGiorno := edAlGiorno.Date;
end;

procedure TFormCalendarioAvvioCorsi.GeneraExecute(Sender: TObject);
begin
  CalendarioAvvioCorsi.Genera;
end;

procedure TFormCalendarioAvvioCorsi.SvuotaExecute(Sender: TObject);
begin

  if ConfirmYesNo('Si desidera eliminare tutte le date lezione?', mtWarning) then
    CalendarioAvvioCorsi.SvuotaTemp;
end;

procedure TFormCalendarioAvvioCorsi.AbilitaGiorni(Sender: TObject);

  procedure AbilitaTimeEdit(cxTimeEdit: TcxTimeEdit; const Abilitato: boolean);
  begin
    cxTimeEdit.Properties.ReadOnly := not Abilitato;
    cxTimeEdit.Enabled := Abilitato;
  end;

begin
  inherited;

  AbilitaTimeEdit(edOra_Inizio_1_Lun, checkLunedi.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Lun, checkLunedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Lun, checkLunedi.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Lun, checkLunedi.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Mar, checkMartedi.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Mar, checkMartedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Mar, checkMartedi.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Mar, checkMartedi.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Mer, checkMercoledi.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Mer, checkMercoledi.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Mer, checkMercoledi.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Mer, checkMercoledi.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Gio, checkGiovedi.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Gio, checkGiovedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Gio, checkGiovedi.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Gio, checkGiovedi.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Ven, checkVenerdi.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Ven, checkVenerdi.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Ven, checkVenerdi.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Ven, checkVenerdi.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Sab, checkSabato.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Sab, checkSabato.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Sab, checkSabato.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Sab, checkSabato.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Dom, checkDomenica.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Dom, checkDomenica.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Dom, checkDomenica.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Dom, checkDomenica.Checked);
end;

procedure TFormCalendarioAvvioCorsi.InitValues;
  function OraInizio: TTime;
  begin
    result := EncodeTime(08, 0, 0, 0);
  end;

  function OraFine: TTime;
  begin
    result := EncodeTime(12, 0, 0, 0);
  end;

begin
  edTitoloCorso.Clear;
  edCodiceCorso.Clear;
  edTipoAnnualita.Text := 'Annualità unica';
  edIdSezione.Clear;
  edCodiceSezione.Text := 'Annualità unica';

  edModalita.ItemIndex := 0;

  checkLunedi.Checked := True;
  edOra_Inizio_1_Lun.Time := OraInizio;
  edOra_Fine_1_Lun.Time := OraFine;
  edOra_Inizio_2_Lun.Clear;
  edOra_Fine_2_Lun.Clear;

  checkMartedi.Checked := True;
  edOra_Inizio_1_Mar.Time := OraInizio;
  edOra_Fine_1_Mar.Time := OraFine;
  edOra_Inizio_2_Mar.Clear;
  edOra_Fine_2_Mar.Clear;

  checkMercoledi.Checked := True;
  edOra_Inizio_1_Mer.Time := OraInizio;
  edOra_Fine_1_Mer.Time := OraFine;
  edOra_Inizio_2_Mer.Clear;
  edOra_Fine_2_Mer.Clear;

  checkGiovedi.Checked := True;
  edOra_Inizio_1_Gio.Time := OraInizio;
  edOra_Fine_1_Gio.Time := OraFine;
  edOra_Inizio_2_Gio.Clear;
  edOra_Fine_2_Gio.Clear;

  checkVenerdi.Checked := True;
  edOra_Inizio_1_Ven.Time := OraInizio;
  edOra_Fine_1_Ven.Time := OraFine;
  edOra_Inizio_2_Ven.Clear;
  edOra_Fine_2_Ven.Clear;

  checkSabato.Checked := False;
  edOra_Inizio_1_Sab.Clear;
  edOra_Fine_1_Sab.Clear;
  edOra_Inizio_2_Sab.Clear;
  edOra_Fine_2_Sab.Clear;

  checkDomenica.Checked := False;
  edOra_Inizio_1_Dom.Clear;
  edOra_Fine_1_Dom.Clear;
  edOra_Inizio_2_Dom.Clear;
  edOra_Fine_2_Dom.Clear;

  edNumero_Ore_Lun.Text := '0';
  edNumero_Ore_Mar.Text := '0';
  edNumero_Ore_Mer.Text := '0';
  edNumero_Ore_Gio.Text := '0';
  edNumero_Ore_Ven.Text := '0';
  edNumero_Ore_Sab.Text := '0';
  edNumero_Ore_Dom.Text := '0';
end;

procedure TFormCalendarioAvvioCorsi.edTitoloCorsoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalendarioAvvioCorsi.TitoloCorso := edTitoloCorso.EditingValue;
end;

procedure TFormCalendarioAvvioCorsi.edCodiceCorsoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalendarioAvvioCorsi.CodiceCorso := edCodiceCorso.EditingValue;
end;

procedure TFormCalendarioAvvioCorsi.edTipoAnnualitaPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalendarioAvvioCorsi.TipoAnnualita := edTipoAnnualita.EditingValue;
end;

procedure TFormCalendarioAvvioCorsi.edIdSezionePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalendarioAvvioCorsi.IdSezione := edIdSezione.EditingValue;
end;

procedure TFormCalendarioAvvioCorsi.edCodiceSezionePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalendarioAvvioCorsi.CodiceSezione := edCodiceSezione.EditingValue;
end;

procedure TFormCalendarioAvvioCorsi.edProgettoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalendarioAvvioCorsi.IdProgetto := CalendarioAvvioCorsi.lkProgetti.FieldByName('ID_PROGETTO').AsInteger;

  edTitoloCorso.Text := CalendarioAvvioCorsi.lkProgetti.FieldByName('DENOMINAZIONE_PROGETTO').AsString;

  edDalGiorno.Date := CalendarioAvvioCorsi.lkProgetti.FieldByName('DATA_INIZIO_PROGETTO').AsDateTime;
  edAlGiorno.Date := CalendarioAvvioCorsi.lkProgetti.FieldByName('DATA_FINE_PROGETTO').AsDateTime;
end;

end.


// CalendarioAvvioCorsiTitoloCorso: string read FTitoloCorso write FTitoloCorso;
// CalendarioAvvioCorsiCodiceCorso: string read FCodiceCorso write FCodiceCorso;
// CalendarioAvvioCorsiTipoAnnualita: string read FTipoAnnualita write FTipoAnnualita;
// CalendarioAvvioCorsiIdSezione: string read FIdSezione write FIdSezione;
// CalendarioAvvioCorsiCodiceSezione: string read FCodiceSezione write FCodiceSezione;
// CalendarioAvvioCorsiDalGiorno: TDateTime read FDalGiorno write FDalGiorno;
// CalendarioAvvioCorsiAlGiorno: TDateTime read FAlGiorno write FAlGiorno;
