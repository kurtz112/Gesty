unit frmGeneraCalendarioStage;

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
  dxUIAClasses,
  zFbDataSet,
  cxDBExtLookupComboBox,
  Data.DB;

type
  TGeneraCalendarioStageParams = record
    Lunedi: boolean;
    Martedi: boolean;
    Mercoledi: boolean;
    Giovedi: boolean;
    Venerdi: boolean;
    Sabato: boolean;
    Domenica: boolean;

    DalGiorno: TDate;
    AlGiorno: TDate;

    Orario: boolean;

    OraInizio1_Lunedi: TTime;
    OraFine1_Lunedi: TTime;
    Contenuti1_Lunedi: string;
    OraInizio2_Lunedi: TTime;
    OraFine2_Lunedi: TTime;
    Contenuti2_Lunedi: string;
    OraInizio3_Lunedi: TTime;
    OraFine3_Lunedi: TTime;
    Contenuti3_Lunedi: string;

    OraInizio1_Martedi: TTime;
    OraFine1_Martedi: TTime;
    Contenuti1_Martedi: string;
    OraInizio2_Martedi: TTime;
    OraFine2_Martedi: TTime;
    Contenuti2_Martedi: string;
    OraInizio3_Martedi: TTime;
    OraFine3_Martedi: TTime;
    Contenuti3_Martedi: string;

    OraInizio1_Mercoledi: TTime;
    OraFine1_Mercoledi: TTime;
    Contenuti1_Mercoledi: string;
    OraInizio2_Mercoledi: TTime;
    OraFine2_Mercoledi: TTime;
    Contenuti2_Mercoledi: string;
    OraInizio3_Mercoledi: TTime;
    OraFine3_Mercoledi: TTime;
    Contenuti3_Mercoledi: string;

    OraInizio1_Giovedi: TTime;
    OraFine1_Giovedi: TTime;
    Contenuti1_Giovedi: string;
    OraInizio2_Giovedi: TTime;
    OraFine2_Giovedi: TTime;
    Contenuti2_Giovedi: string;
    OraInizio3_Giovedi: TTime;
    OraFine3_Giovedi: TTime;
    Contenuti3_Giovedi: string;

    OraInizio1_Venerdi: TTime;
    OraFine1_Venerdi: TTime;
    Contenuti1_Venerdi: string;
    OraInizio2_Venerdi: TTime;
    OraFine2_Venerdi: TTime;
    Contenuti2_Venerdi: string;
    OraInizio3_Venerdi: TTime;
    OraFine3_Venerdi: TTime;
    Contenuti3_Venerdi: string;

    OraInizio1_Sabato: TTime;
    OraFine1_Sabato: TTime;
    Contenuti1_Sabato: string;
    OraInizio2_Sabato: TTime;
    OraFine2_Sabato: TTime;
    Contenuti2_Sabato: string;
    OraInizio3_Sabato: TTime;
    OraFine3_Sabato: TTime;
    Contenuti3_Sabato: string;

    OraInizio1_Domenica: TTime;
    OraFine1_Domenica: TTime;
    Contenuti1_Domenica: string;
    OraInizio2_Domenica: TTime;
    OraFine2_Domenica: TTime;
    Contenuti2_Domenica: string;
    OraInizio3_Domenica: TTime;
    OraFine3_Domenica: TTime;
    Contenuti3_Domenica: string;

    TotaleOreLunedi: double;
    TotaleOreMartedi: double;
    TotaleOreMercoledi: double;
    TotaleOreGiovedi: double;
    TotaleOreVenerdi: double;
    TotaleOreSabato: double;
    TotaleOreDomenica: double;

    procedure Init;
    procedure CalcolaTotali;
    function Verifica: boolean;
  end;

  TFormGeneraCalendarioStage = class(TForm)
    dxLayoutControl: TdxLayoutControl;
    edOra_Inizio_2_Lun: TcxTimeEdit;
    edOra_Fine_2_Lun: TcxTimeEdit;
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
    edOra_Inizio_2_Mer: TcxTimeEdit;
    edOra_Fine_2_Mer: TcxTimeEdit;
    edOra_Inizio_2_Gio: TcxTimeEdit;
    edOra_Fine_2_Gio: TcxTimeEdit;
    edOra_Inizio_2_Ven: TcxTimeEdit;
    edOra_Fine_2_Ven: TcxTimeEdit;
    edOra_Inizio_2_Sab: TcxTimeEdit;
    edOra_Fine_2_Sab: TcxTimeEdit;
    edOra_Inizio_2_Dom: TcxTimeEdit;
    edOra_Fine_2_Dom: TcxTimeEdit;
    edDalGiorno: TcxDateEdit;
    edAlGiorno: TcxDateEdit;
    checkLunedi: TcxCheckBox;
    checkMercoledi: TcxCheckBox;
    checkGiovedi: TcxCheckBox;
    checkVenerdi: TcxCheckBox;
    checkSabato: TcxCheckBox;
    checkDomenica: TcxCheckBox;
    checkMartedi: TcxCheckBox;
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
    dxLayoutItemOra2InizioLun: TdxLayoutItem;
    dxLayoutItemOra2InizioMar: TdxLayoutItem;
    dxLayoutItemOra2InizioMer: TdxLayoutItem;
    dxLayoutItemOra2InizioGio: TdxLayoutItem;
    dxLayoutItemOra2InizioVen: TdxLayoutItem;
    dxLayoutItemOra2InizioSab1: TdxLayoutItem;
    dxLayoutItemOra2InizioDom: TdxLayoutItem;
    dxLayoutItemOra2FineLun: TdxLayoutItem;
    dxLayoutItemOra2FineMar: TdxLayoutItem;
    dxLayoutItemOra2FineMer: TdxLayoutItem;
    dxLayoutItemOra2FineGio: TdxLayoutItem;
    dxLayoutItemOra2FineVen: TdxLayoutItem;
    dxLayoutItemOra2FineSab: TdxLayoutItem;
    dxLayoutItemOra2FineDom: TdxLayoutItem;
    dxLayoutItemDataInizio: TdxLayoutItem;
    dxLayoutItemDataFine: TdxLayoutItem;
    dxLayoutGroupLunedi: TdxLayoutGroup;
    dxLayoutGroupMartedi: TdxLayoutGroup;
    dxLayoutGroupMercoledi: TdxLayoutGroup;
    dxLayoutGroupGiovedi: TdxLayoutGroup;
    dxLayoutGroupSabato: TdxLayoutGroup;
    dxLayoutGroupVenerdi: TdxLayoutGroup;
    dxLayoutGroupDomenica: TdxLayoutGroup;
    dxLayoutEmptySpaceItemLun1: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemMar1: TdxLayoutEmptySpaceItem;
    dxLayoutGroup2Mer: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemGio1: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemVen1: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemSab: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemDom1: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotLun: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotMar: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotMer: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotGio: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotVen: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotSab: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemTotDom: TdxLayoutEmptySpaceItem;
    dxLayoutGroupMain: TdxLayoutGroup;
    dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    dxLayoutItemLunedi: TdxLayoutItem;
    dxLayoutItemMartedì: TdxLayoutItem;
    dxLayoutItemMercoledi: TdxLayoutItem;
    dxLayoutItemGiovedi: TdxLayoutItem;
    dxLayoutItemVenerdi: TdxLayoutItem;
    dxLayoutItemSabato: TdxLayoutItem;
    dxLayoutItemDomenica: TdxLayoutItem;
    dxLayoutGroupDate: TdxLayoutGroup;
    dxLayoutGroupGiorni: TdxLayoutGroup;
    dxLayoutGroupOrari: TdxLayoutGroup;
    dxLayoutGroupSettimana: TdxLayoutGroup;
    tnOk: TcxButton;
    dxLayoutItemOk: TdxLayoutItem;
    btnCancel: TcxButton;
    dxLayoutItemCancel: TdxLayoutItem;
    dxLayoutGroupButtons: TdxLayoutGroup;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    edOra_Inizio_3_Lun: TcxTimeEdit;
    edOra_Fine_3_Lun: TcxTimeEdit;
    edOra_Inizio_3_Mar: TcxTimeEdit;
    edOra_Fine_3_Mar: TcxTimeEdit;
    edOra_Inizio_3_Mer: TcxTimeEdit;
    edOra_Fine_3_Mer: TcxTimeEdit;
    edOra_Inizio_3_Gio: TcxTimeEdit;
    edOra_Fine_3_Gio: TcxTimeEdit;
    edOra_Inizio_3_Ven: TcxTimeEdit;
    edOra_Fine_3_Ven: TcxTimeEdit;
    edOra_Inizio_3_Sab: TcxTimeEdit;
    edOra_Fine_3_Sab: TcxTimeEdit;
    edOra_Inizio_3_Dom: TcxTimeEdit;
    edOra_Fine_3_Dom: TcxTimeEdit;
    dxLayoutItemOra3FineLun: TdxLayoutItem;
    dxLayoutItemOra3InizioLun: TdxLayoutItem;
    dxLayoutItemOra3InizioMar: TdxLayoutItem;
    dxLayoutEmptySpaceItemLun2: TdxLayoutEmptySpaceItem;
    dxLayoutItemOra3FineMar: TdxLayoutItem;
    dxLayoutEmptySpaceItemMar2: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemMer2: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemGio2: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemVen2: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemSab2: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItemDom2: TdxLayoutEmptySpaceItem;
    dxLayoutItemOra3InizioMer: TdxLayoutItem;
    dxLayoutItemOra3FineMer: TdxLayoutItem;
    dxLayoutItemOra3InizioGio: TdxLayoutItem;
    dxLayoutItemOra3FineGio: TdxLayoutItem;
    dxLayoutItemOra3InizioVen: TdxLayoutItem;
    dxLayoutItemOra3FineVen: TdxLayoutItem;
    dxLayoutItemOra3InizioSab: TdxLayoutItem;
    dxLayoutItemOra3FineSab: TdxLayoutItem;
    dxLayoutGroupOra3InizioDom: TdxLayoutItem;
    dxLayoutGroupOra3FineDom: TdxLayoutItem;
    edContenuti1_Lun: TcxExtLookupComboBox;
    edContenuti2_Lun: TcxExtLookupComboBox;
    edContenuti3_Lun: TcxExtLookupComboBox;
    edContenuti1_Mar: TcxExtLookupComboBox;
    edContenuti2_Mar: TcxExtLookupComboBox;
    edContenuti3_Mar: TcxExtLookupComboBox;
    edContenuti1_Mer: TcxExtLookupComboBox;
    edContenuti2_Mer: TcxExtLookupComboBox;
    edContenuti3_Mer: TcxExtLookupComboBox;
    edContenuti1_Gio: TcxExtLookupComboBox;
    edContenuti2_Gio: TcxExtLookupComboBox;
    edContenuti3_Gio: TcxExtLookupComboBox;
    edContenuti1_Ven: TcxExtLookupComboBox;
    edContenuti2_Ven: TcxExtLookupComboBox;
    edContenuti3_Ven: TcxExtLookupComboBox;
    edContenuti1_Sab: TcxExtLookupComboBox;
    edContenuti2_Sab: TcxExtLookupComboBox;
    edContenuti3_Sab: TcxExtLookupComboBox;
    edContenuti1_Dom: TcxExtLookupComboBox;
    edContenuti2_Dom: TcxExtLookupComboBox;
    edContenuti3_Dom: TcxExtLookupComboBox;
    dxLayoutItemContenuti1_Lun: TdxLayoutItem;
    dxLayoutItemContenuti2_Lun: TdxLayoutItem;
    dxLayoutItemContenuti3_Lun: TdxLayoutItem;
    dxLayoutItemContenuti1_Mar: TdxLayoutItem;
    dxLayoutItemContenuti2_Mar: TdxLayoutItem;
    dxLayoutItemContenuti3_Mar: TdxLayoutItem;
    dxLayoutItemContenuti1_Mer: TdxLayoutItem;
    dxLayoutItemContenuti2_Mer: TdxLayoutItem;
    dxLayoutItemContenuti3_Mer: TdxLayoutItem;
    dxLayoutItemContenuti1_Gio: TdxLayoutItem;
    dxLayoutItemContenuti2_Gio: TdxLayoutItem;
    dxLayoutItemContenuti3_Gio: TdxLayoutItem;
    dxLayoutItemContenuti1_Ven: TdxLayoutItem;
    dxLayoutItemContenuti2_Ven: TdxLayoutItem;
    dxLayoutItemContenuti3_Ven: TdxLayoutItem;
    dxLayoutItemContenuti1_Sab: TdxLayoutItem;
    dxLayoutItemContenuti2_Sab: TdxLayoutItem;
    dxLayoutItemContenuti3_Sab: TdxLayoutItem;
    dxLayoutItemContenuti1_Dom: TdxLayoutItem;
    dxLayoutItemContenuti2_Dom: TdxLayoutItem;
    dxLayoutItemContenuti3_Dom: TdxLayoutItem;
    dxLayoutGroupOre1Lun: TdxLayoutGroup;
    dxLayoutGroup1Lun: TdxLayoutGroup;
    dxLayoutGroupOre2Lun: TdxLayoutGroup;
    dxLayoutGroup2Lun: TdxLayoutGroup;
    dxLayoutGroupOre3Lun: TdxLayoutGroup;
    dxLayoutGroup3Lun: TdxLayoutGroup;
    dxLayoutGroupOre1Mar: TdxLayoutGroup;
    dxLayoutGroupOre2Mar: TdxLayoutGroup;
    dxLayoutGroupOre3Mar: TdxLayoutGroup;
    dxLayoutGroup3Mar: TdxLayoutGroup;
    dxLayoutGroup2Mar: TdxLayoutGroup;
    dxLayoutGroup1Mar: TdxLayoutGroup;
    dxLayoutGroupOre1Mer: TdxLayoutGroup;
    dxLayoutGroup2: TdxLayoutGroup;
    dxLayoutGroupOre3Mer: TdxLayoutGroup;
    dxLayoutGroup3Mer: TdxLayoutGroup;
    dxLayoutGroupOre2Mer: TdxLayoutGroup;
    dxLayoutGroup1Mer: TdxLayoutGroup;
    dxLayoutGroupOre1Gio: TdxLayoutGroup;
    dxLayoutGroup1Gio: TdxLayoutGroup;
    dxLayoutGroupOre2Gio: TdxLayoutGroup;
    dxLayoutGroup2Gio: TdxLayoutGroup;
    dxLayoutGroup3OreGio: TdxLayoutGroup;
    dxLayoutGroup3Gio: TdxLayoutGroup;
    dxLayoutGroupOre1Ven: TdxLayoutGroup;
    dxLayoutGroup1Ven: TdxLayoutGroup;
    dxLayoutGroupOre2Ven: TdxLayoutGroup;
    dxLayoutGroup2Ven: TdxLayoutGroup;
    dxLayoutGroupORe3Ven: TdxLayoutGroup;
    dxLayoutGroup3Ven: TdxLayoutGroup;
    dxLayoutGroupOre1Sab: TdxLayoutGroup;
    dxLayoutGroup1Sab: TdxLayoutGroup;
    dxLayoutGroupOre2Sab: TdxLayoutGroup;
    dxLayoutGroup2Sab: TdxLayoutGroup;
    dxLayoutGroupOre3Sab: TdxLayoutGroup;
    dxLayoutGroup3Sab: TdxLayoutGroup;
    dxLayoutGroupOre1Dom: TdxLayoutGroup;
    dxLayoutGroup1Dom: TdxLayoutGroup;
    dxLayoutGroupOre2Dom: TdxLayoutGroup;
    dxLayoutGroup2Dom: TdxLayoutGroup;
    dxLayoutGroupOre3Dom: TdxLayoutGroup;
    dxLayoutGroup3Dom: TdxLayoutGroup;
    dxLayoutGroupPeriodo: TdxLayoutGroup;
    dxLayoutEmptySpaceItem3: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItem4: TdxLayoutEmptySpaceItem;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutEmptySpaceItem5: TdxLayoutEmptySpaceItem;
    procedure dxLayoutGroupOrariCheckBoxStateChanged(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure edDalGiornoPropertiesEditValueChanged(Sender: TObject);
    procedure edAlGiornoPropertiesEditValueChanged(Sender: TObject);
  private
    initialized: boolean;
    params: TGeneraCalendarioStageParams;
    generaDatasetFunc: TFunc<TComponent, TzFbDataset>;

    procedure InitEditors;
    procedure InitLookups;
    procedure CreateDataSet(const owner: TComponent; out dataset: TzFbDataset; out datasource: TDataSource);

    procedure AbilitaGiorni;
    procedure GiorniOreEditValueChanged(Sender: TObject);
    procedure OreEditValueChanged(Sender: TObject);
    procedure ContenutiPropertiesEditValueChanged(Sender: TObject);

    function VerificaDati: boolean;
  public
    function Genera(var aParams: TGeneraCalendarioStageParams; generaDatasetFunc: TFunc<TComponent, TzFbDataset>): boolean;
  end;

function GeneraDateCalendarioStage(var params: TGeneraCalendarioStageParams; generaDatasetFunc: TFunc<TComponent, TzFbDataset>): boolean;

implementation

uses
  System.DateUtils,
  zDx;

{$R *.dfm}

function GeneraDateCalendarioStage(var params: TGeneraCalendarioStageParams; generaDatasetFunc: TFunc<TComponent, TzFbDataset>): boolean;
var
  FormGeneraCalendarioStage: TFormGeneraCalendarioStage;
begin
  Application.CreateForm(TFormGeneraCalendarioStage, FormGeneraCalendarioStage);
  try
    result := FormGeneraCalendarioStage.Genera(params, generaDatasetFunc);
  finally
    FreeAndNil(FormGeneraCalendarioStage);
  end;
end;

/// ///////////////////////////////////////////

procedure TGeneraCalendarioStageParams.Init;
var
  Inizio1, Fine1, Inizio2, Fine2, Inizio3, Fine3: TTime;
begin
  Lunedi := True;
  Martedi := True;
  Mercoledi := True;
  Giovedi := True;
  Venerdi := True;
  Sabato := false;
  Domenica := false;

  DalGiorno := DateOf(Date);
  AlGiorno := DateOf(Date);

  Orario := True;

  Inizio1 := EncodeTime(8, 0, 0, 0);
  Fine1 := EncodeTime(12, 0, 0, 0);
  Inizio2 := EncodeTime(14, 0, 0, 0);
  Fine2 := EncodeTime(17, 0, 0, 0);
  Inizio3 := EncodeTime(0, 0, 0, 0);
  Fine3 := EncodeTime(0, 0, 0, 0);

  OraInizio1_Lunedi := Inizio1;
  OraFine1_Lunedi := Fine1;
  OraInizio2_Lunedi := Inizio2;
  OraFine2_Lunedi := Fine2;
  OraInizio3_Lunedi := Inizio3;
  OraFine3_Lunedi := Fine3;

  OraInizio1_Martedi := Inizio1;
  OraFine1_Martedi := Fine1;
  OraInizio2_Martedi := Inizio2;
  OraFine2_Martedi := Fine2;
  OraInizio3_Martedi := Inizio3;
  OraFine3_Martedi := Fine3;

  OraInizio1_Mercoledi := Inizio1;
  OraFine1_Mercoledi := Fine1;
  OraInizio2_Mercoledi := Inizio2;
  OraFine2_Mercoledi := Fine2;
  OraInizio3_Mercoledi := Inizio3;
  OraFine3_Mercoledi := Fine3;

  OraInizio1_Giovedi := Inizio1;
  OraFine1_Giovedi := Fine1;
  OraInizio2_Giovedi := Inizio2;
  OraFine2_Giovedi := Fine2;
  OraInizio3_Giovedi := Inizio3;
  OraFine3_Giovedi := Fine3;

  OraInizio1_Venerdi := Inizio1;
  OraFine1_Venerdi := Fine1;
  OraInizio2_Venerdi := 0;
  OraFine2_Venerdi := 0;
  OraInizio3_Venerdi := 0;
  OraFine3_Venerdi := 0;

  OraInizio1_Sabato := 0;
  OraFine1_Sabato := 0;
  OraInizio2_Sabato := 0;
  OraFine2_Sabato := 0;
  OraInizio3_Sabato := 0;
  OraFine3_Sabato := 0;

  OraInizio1_Domenica := 0;
  OraFine1_Domenica := 0;
  OraInizio2_Domenica := 0;
  OraFine2_Domenica := 0;
  OraInizio3_Domenica := 0;
  OraFine3_Domenica := 0;

  Contenuti1_Lunedi := '';
  Contenuti2_Lunedi := '';
  Contenuti3_Lunedi := '';
  Contenuti1_Martedi := '';
  Contenuti2_Martedi := '';
  Contenuti3_Martedi := '';
  Contenuti1_Mercoledi := '';
  Contenuti2_Mercoledi := '';
  Contenuti3_Mercoledi := '';
  Contenuti1_Giovedi := '';
  Contenuti2_Giovedi := '';
  Contenuti3_Giovedi := '';
  Contenuti1_Venerdi := '';
  Contenuti2_Venerdi := '';
  Contenuti3_Venerdi := '';
  Contenuti1_Sabato := '';
  Contenuti2_Sabato := '';
  Contenuti3_Sabato := '';
  Contenuti1_Domenica := '';
  Contenuti2_Domenica := '';
  Contenuti3_Domenica := '';
end;

procedure TGeneraCalendarioStageParams.CalcolaTotali;

  function numero_ore(OraInizio1, OraFine1, OraInizio2, OraFine2, OraInizio3, OraFine3: TTime): double;
  begin
    result := 0;

    if (OraInizio1 <> 0) and (OraFine1 <> 0) then
      result := MinutesBetween(OraInizio1, OraFine1);

    if (OraInizio2 <> 0) and (OraFine2 <> 0) then
      result := result + MinutesBetween(OraInizio2, OraFine2);

    if (OraInizio3 <> 0) and (OraFine3 <> 0) then
      result := result + MinutesBetween(OraInizio3, OraFine3);

    result := result / 60.0;
  end;

begin
  TotaleOreLunedi := numero_ore(OraInizio1_Lunedi, OraFine1_Lunedi, OraInizio2_Lunedi, OraFine2_Lunedi, OraInizio3_Lunedi, OraFine3_Lunedi);
  TotaleOreMartedi := numero_ore(OraInizio1_Martedi, OraFine1_Martedi, OraInizio2_Martedi, OraFine2_Martedi, OraInizio3_Martedi, OraFine3_Martedi);
  TotaleOreMercoledi := numero_ore(OraInizio1_Mercoledi, OraFine1_Mercoledi, OraInizio2_Mercoledi, OraFine2_Mercoledi, OraInizio3_Mercoledi, OraFine3_Mercoledi);
  TotaleOreGiovedi := numero_ore(OraInizio1_Giovedi, OraFine1_Giovedi, OraInizio2_Giovedi, OraFine2_Giovedi, OraInizio3_Giovedi, OraFine3_Giovedi);
  TotaleOreVenerdi := numero_ore(OraInizio1_Venerdi, OraFine1_Venerdi, OraInizio2_Venerdi, OraFine2_Venerdi, OraInizio3_Venerdi, OraFine3_Venerdi);
  TotaleOreSabato := numero_ore(OraInizio1_Sabato, OraFine1_Sabato, OraInizio2_Sabato, OraFine2_Sabato, OraInizio3_Sabato, OraFine3_Sabato);
  TotaleOreDomenica := numero_ore(OraInizio1_Domenica, OraFine1_Domenica, OraInizio2_Domenica, OraFine2_Domenica, OraInizio3_Domenica, OraFine3_Domenica);
end;

function TGeneraCalendarioStageParams.Verifica: boolean;
  procedure VerificaOre(Giorno: string; OraInizio1, OraFine1, OraInizio2, OraFine2, OraInizio3, OraFine3: TTime);
  begin

    if (OraInizio1 <> 0) and (OraFine1 <> 0) and (OraInizio1 >= OraFine1) then
      raise Exception.Create(Giorno + ': data 1 inizio maggiore di data 1 fine.');

    if (OraInizio2 <> 0) and (OraFine2 <> 0) and (OraInizio2 >= OraFine2) then
      raise Exception.Create(Giorno + ': data 2 inizio maggiore di data 2 fine.');

    if (OraInizio3 <> 0) and (OraFine3 <> 0) and (OraInizio3 >= OraFine3) then
      raise Exception.Create(Giorno + ': data 3 inizio maggiore di data 3 fine.');

    if (OraInizio1 <> 0) and (OraInizio2 <> 0) and (OraFine1 >= OraInizio2) then
      raise Exception.Create(Giorno + ': data 1 fine maggiore di data 2 inizio.');

    if (OraInizio2 <> 0) and (OraInizio3 <> 0) and (OraFine2 >= OraInizio3) then
      raise Exception.Create(Giorno + ': data 2 fine maggiore di data 3 inizio.');
  end;

begin
  result := false;

  if (DalGiorno = 0) or (DalGiorno = cxDateUtils.NullDate) then
    raise Exception.Create('Data Inizio non specificata');

  if (AlGiorno = 0) or (AlGiorno = cxDateUtils.NullDate) then
    raise Exception.Create('Data Fine non specificata');

  if DalGiorno > AlGiorno then
    raise Exception.Create('Data inizio maggiore data fine.');

  VerificaOre('Lunedì', OraInizio1_Lunedi, OraFine1_Lunedi, OraInizio2_Lunedi, OraFine2_Lunedi, OraInizio3_Lunedi, OraFine3_Lunedi);
  VerificaOre('Martedì', OraInizio1_Martedi, OraFine1_Martedi, OraInizio2_Martedi, OraFine2_Martedi, OraInizio3_Martedi, OraFine3_Martedi);
  VerificaOre('Mercoledì', OraInizio1_Mercoledi, OraFine1_Mercoledi, OraInizio2_Mercoledi, OraFine2_Mercoledi, OraInizio3_Mercoledi, OraFine3_Mercoledi);
  VerificaOre('Giovedì', OraInizio1_Giovedi, OraFine1_Giovedi, OraInizio2_Giovedi, OraFine2_Giovedi, OraInizio3_Giovedi, OraFine3_Giovedi);
  VerificaOre('Venerdì', OraInizio1_Venerdi, OraFine1_Venerdi, OraInizio2_Venerdi, OraFine2_Venerdi, OraInizio3_Venerdi, OraFine3_Venerdi);
  VerificaOre('Sabato', OraInizio1_Sabato, OraFine1_Sabato, OraInizio2_Sabato, OraFine2_Sabato, OraInizio3_Sabato, OraFine3_Sabato);
  VerificaOre('Domenica', OraInizio1_Domenica, OraFine1_Domenica, OraInizio2_Domenica, OraFine2_Domenica, OraInizio3_Domenica, OraFine3_Domenica);

  result := True;
end;

/// //////////////////////////////////////////////////////////////////////////////////

procedure TFormGeneraCalendarioStage.FormCreate(Sender: TObject);
begin
  generaDatasetFunc := nil;
  params.Init;
  dx.InitLayoutControl(dxLayoutControl);
  InitEditors;
end;

procedure TFormGeneraCalendarioStage.InitEditors;

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
  InitTimeEdit(edOra_Inizio_3_Lun);
  InitTimeEdit(edOra_Fine_3_Lun);

  InitTimeEdit(edOra_Inizio_1_Mar);
  InitTimeEdit(edOra_Fine_1_Mar);
  InitTimeEdit(edOra_Inizio_2_Mar);
  InitTimeEdit(edOra_Fine_2_Mar);
  InitTimeEdit(edOra_Inizio_3_Mar);
  InitTimeEdit(edOra_Fine_3_Mar);

  InitTimeEdit(edOra_Inizio_1_Mer);
  InitTimeEdit(edOra_Fine_1_Mer);
  InitTimeEdit(edOra_Inizio_2_Mer);
  InitTimeEdit(edOra_Fine_2_Mer);
  InitTimeEdit(edOra_Inizio_3_Mer);
  InitTimeEdit(edOra_Fine_3_Mer);

  InitTimeEdit(edOra_Inizio_1_Gio);
  InitTimeEdit(edOra_Fine_1_Gio);
  InitTimeEdit(edOra_Inizio_2_Gio);
  InitTimeEdit(edOra_Fine_2_Gio);
  InitTimeEdit(edOra_Inizio_3_Gio);
  InitTimeEdit(edOra_Fine_3_Gio);

  InitTimeEdit(edOra_Inizio_1_Ven);
  InitTimeEdit(edOra_Fine_1_Ven);
  InitTimeEdit(edOra_Inizio_2_Ven);
  InitTimeEdit(edOra_Fine_2_Ven);
  InitTimeEdit(edOra_Inizio_3_Ven);
  InitTimeEdit(edOra_Fine_3_Ven);

  InitTimeEdit(edOra_Inizio_1_Sab);
  InitTimeEdit(edOra_Fine_1_Sab);
  InitTimeEdit(edOra_Inizio_2_Sab);
  InitTimeEdit(edOra_Fine_2_Sab);
  InitTimeEdit(edOra_Inizio_3_Sab);
  InitTimeEdit(edOra_Fine_3_Sab);

  InitTimeEdit(edOra_Inizio_1_Dom);
  InitTimeEdit(edOra_Fine_1_Dom);
  InitTimeEdit(edOra_Inizio_2_Dom);
  InitTimeEdit(edOra_Fine_2_Dom);
  InitTimeEdit(edOra_Inizio_3_Dom);
  InitTimeEdit(edOra_Fine_3_Dom);
end;

procedure TFormGeneraCalendarioStage.AbilitaGiorni;

  procedure AbilitaTimeEdit(cxTimeEdit: TcxTimeEdit; const Abilitato: boolean);
  begin
    cxTimeEdit.Properties.ReadOnly := not Abilitato;
    cxTimeEdit.Enabled := Abilitato;
  end;

begin
  inherited;

  if not initialized then
    exit;

  AbilitaTimeEdit(edOra_Inizio_1_Lun, checkLunedi.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Lun, checkLunedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Lun, checkLunedi.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Lun, checkLunedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_3_Lun, checkLunedi.Checked);
  AbilitaTimeEdit(edOra_Fine_3_Lun, checkLunedi.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Mar, checkMartedi.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Mar, checkMartedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Mar, checkMartedi.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Mar, checkMartedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_3_Mar, checkMartedi.Checked);
  AbilitaTimeEdit(edOra_Fine_3_Mar, checkMartedi.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Mer, checkMercoledi.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Mer, checkMercoledi.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Mer, checkMercoledi.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Mer, checkMercoledi.Checked);
  AbilitaTimeEdit(edOra_Inizio_3_Mer, checkMercoledi.Checked);
  AbilitaTimeEdit(edOra_Fine_3_Mer, checkMercoledi.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Gio, checkGiovedi.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Gio, checkGiovedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Gio, checkGiovedi.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Gio, checkGiovedi.Checked);
  AbilitaTimeEdit(edOra_Inizio_3_Gio, checkGiovedi.Checked);
  AbilitaTimeEdit(edOra_Fine_3_Gio, checkGiovedi.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Ven, checkVenerdi.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Ven, checkVenerdi.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Ven, checkVenerdi.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Ven, checkVenerdi.Checked);
  AbilitaTimeEdit(edOra_Inizio_3_Ven, checkVenerdi.Checked);
  AbilitaTimeEdit(edOra_Fine_3_Ven, checkVenerdi.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Sab, checkSabato.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Sab, checkSabato.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Sab, checkSabato.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Sab, checkSabato.Checked);
  AbilitaTimeEdit(edOra_Inizio_3_Sab, checkSabato.Checked);
  AbilitaTimeEdit(edOra_Fine_3_Sab, checkSabato.Checked);

  AbilitaTimeEdit(edOra_Inizio_1_Dom, checkDomenica.Checked);
  AbilitaTimeEdit(edOra_Fine_1_Dom, checkDomenica.Checked);
  AbilitaTimeEdit(edOra_Inizio_2_Dom, checkDomenica.Checked);
  AbilitaTimeEdit(edOra_Fine_2_Dom, checkDomenica.Checked);
  AbilitaTimeEdit(edOra_Inizio_3_Dom, checkDomenica.Checked);
  AbilitaTimeEdit(edOra_Fine_3_Dom, checkDomenica.Checked);
end;

procedure TFormGeneraCalendarioStage.dxLayoutGroupOrariCheckBoxStateChanged(Sender: TObject);
begin
  dxLayoutGroupOrari.Expanded := dxLayoutGroupOrari.ButtonOptions.CheckBox.Checked;
  params.Orario := dxLayoutGroupOrari.ButtonOptions.CheckBox.Checked;
  AbilitaGiorni;
end;

procedure TFormGeneraCalendarioStage.edDalGiornoPropertiesEditValueChanged(Sender: TObject);
begin
  params.DalGiorno := edDalGiorno.Date;
end;

procedure TFormGeneraCalendarioStage.edAlGiornoPropertiesEditValueChanged(Sender: TObject);
begin
  params.AlGiorno := edAlGiorno.Date;
end;

procedure TFormGeneraCalendarioStage.GiorniOreEditValueChanged(Sender: TObject);
begin
  AbilitaGiorni;
end;

procedure TFormGeneraCalendarioStage.OreEditValueChanged(Sender: TObject);
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

  params.Orario := dxLayoutGroupOrari.ButtonOptions.CheckBox.Checked;

  params.OraInizio1_Lunedi := TimeOf(edOra_Inizio_1_Lun.Time);
  params.OraFine1_Lunedi := TimeOf(edOra_Fine_1_Lun.Time);
  params.OraInizio2_Lunedi := TimeOf(edOra_Inizio_2_Lun.Time);
  params.OraFine2_Lunedi := TimeOf(edOra_Fine_2_Lun.Time);
  params.OraInizio3_Lunedi := TimeOf(edOra_Inizio_3_Lun.Time);
  params.OraFine3_Lunedi := TimeOf(edOra_Fine_3_Lun.Time);

  params.OraInizio1_Martedi := TimeOf(edOra_Inizio_1_Mar.Time);
  params.OraFine1_Martedi := TimeOf(edOra_Fine_1_Mar.Time);
  params.OraInizio2_Martedi := TimeOf(edOra_Inizio_2_Mar.Time);
  params.OraFine2_Martedi := TimeOf(edOra_Fine_2_Mar.Time);
  params.OraInizio3_Martedi := TimeOf(edOra_Inizio_3_Mar.Time);
  params.OraFine3_Martedi := TimeOf(edOra_Fine_3_Mar.Time);

  params.OraInizio1_Mercoledi := TimeOf(edOra_Inizio_1_Mer.Time);
  params.OraFine1_Mercoledi := TimeOf(edOra_Fine_1_Mer.Time);
  params.OraInizio2_Mercoledi := TimeOf(edOra_Inizio_2_Mer.Time);
  params.OraFine2_Mercoledi := TimeOf(edOra_Fine_2_Mer.Time);
  params.OraInizio3_Mercoledi := TimeOf(edOra_Inizio_3_Mer.Time);
  params.OraFine3_Mercoledi := TimeOf(edOra_Fine_3_Mer.Time);

  params.OraInizio1_Giovedi := TimeOf(edOra_Inizio_1_Gio.Time);
  params.OraFine1_Giovedi := TimeOf(edOra_Fine_1_Gio.Time);
  params.OraInizio2_Giovedi := TimeOf(edOra_Inizio_2_Gio.Time);
  params.OraFine2_Giovedi := TimeOf(edOra_Fine_2_Gio.Time);
  params.OraInizio3_Giovedi := TimeOf(edOra_Inizio_3_Gio.Time);
  params.OraFine3_Giovedi := TimeOf(edOra_Fine_3_Gio.Time);

  params.OraInizio1_Venerdi := TimeOf(edOra_Inizio_1_Ven.Time);
  params.OraFine1_Venerdi := TimeOf(edOra_Fine_1_Ven.Time);
  params.OraInizio2_Venerdi := TimeOf(edOra_Inizio_2_Ven.Time);
  params.OraFine2_Venerdi := TimeOf(edOra_Fine_2_Ven.Time);
  params.OraInizio3_Venerdi := TimeOf(edOra_Inizio_3_Ven.Time);
  params.OraFine3_Venerdi := TimeOf(edOra_Fine_3_Ven.Time);

  params.OraInizio1_Sabato := TimeOf(edOra_Inizio_1_Sab.Time);
  params.OraFine1_Sabato := TimeOf(edOra_Fine_1_Sab.Time);
  params.OraInizio2_Sabato := TimeOf(edOra_Inizio_2_Sab.Time);
  params.OraFine2_Sabato := TimeOf(edOra_Fine_2_Sab.Time);
  params.OraInizio3_Sabato := TimeOf(edOra_Inizio_3_Sab.Time);
  params.OraFine3_Sabato := TimeOf(edOra_Fine_3_Sab.Time);

  params.OraInizio1_Domenica := TimeOf(edOra_Inizio_1_Dom.Time);
  params.OraFine1_Domenica := TimeOf(edOra_Fine_1_Dom.Time);
  params.OraInizio2_Domenica := TimeOf(edOra_Inizio_2_Dom.Time);
  params.OraFine2_Domenica := TimeOf(edOra_Fine_2_Dom.Time);
  params.OraInizio3_Domenica := TimeOf(edOra_Inizio_3_Dom.Time);
  params.OraFine3_Domenica := TimeOf(edOra_Fine_3_Dom.Time);

  params.CalcolaTotali;

  // edNumero_Ore_Lun.Text := params.TotaleOreLunedi.ToString;
  // edNumero_Ore_Mar.Text := params.TotaleOreMartedi.ToString;
  // edNumero_Ore_Mer.Text := params.TotaleOreMercoledi.ToString;
  // edNumero_Ore_Gio.Text := params.TotaleOreGiovedi.ToString;
  // edNumero_Ore_Ven.Text := params.TotaleOreVenerdi.ToString;
  // edNumero_Ore_Sab.Text := params.TotaleOreSabato.ToString;
  // edNumero_Ore_Dom.Text := params.TotaleOreDomenica.ToString;
end;

procedure TFormGeneraCalendarioStage.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if ModalResult = mrOk then
    params.Verifica;

  CanClose := True;
end;

function TFormGeneraCalendarioStage.Genera(var aParams: TGeneraCalendarioStageParams; generaDatasetFunc: TFunc<TComponent, TzFbDataset>): boolean;
begin
  initialized := false;
  self.generaDatasetFunc := generaDatasetFunc;
  params := aParams;

  InitLookups;

  checkLunedi.Checked := params.Lunedi;
  checkMartedi.Checked := params.Martedi;
  checkMercoledi.Checked := params.Mercoledi;
  checkGiovedi.Checked := params.Giovedi;
  checkVenerdi.Checked := params.Venerdi;
  checkSabato.Checked := params.Sabato;
  checkDomenica.Checked := params.Domenica;

  edDalGiorno.Date := params.DalGiorno;
  edAlGiorno.Date := params.AlGiorno;

  dxLayoutGroupOrari.ButtonOptions.CheckBox.Checked := params.Orario;
  dxLayoutGroupOrari.Expanded := dxLayoutGroupOrari.ButtonOptions.CheckBox.Checked;

  edOra_Inizio_1_Lun.Time := params.OraInizio1_Lunedi;
  edOra_Fine_1_Lun.Time := params.OraFine1_Lunedi;
  edOra_Inizio_2_Lun.Time := params.OraInizio2_Lunedi;
  edOra_Fine_2_Lun.Time := params.OraFine2_Lunedi;
  edOra_Inizio_3_Lun.Time := params.OraInizio3_Lunedi;
  edOra_Fine_3_Lun.Time := params.OraFine3_Lunedi;

  edOra_Inizio_1_Mar.Time := params.OraInizio1_Martedi;
  edOra_Fine_1_Mar.Time := params.OraFine1_Martedi;
  edOra_Inizio_2_Mar.Time := params.OraInizio2_Martedi;
  edOra_Fine_2_Mar.Time := params.OraFine2_Martedi;
  edOra_Inizio_3_Mar.Time := params.OraInizio3_Martedi;
  edOra_Fine_3_Mar.Time := params.OraFine3_Martedi;

  edOra_Inizio_1_Mer.Time := params.OraInizio1_Mercoledi;
  edOra_Fine_1_Mer.Time := params.OraFine1_Mercoledi;
  edOra_Inizio_2_Mer.Time := params.OraInizio2_Mercoledi;
  edOra_Fine_2_Mer.Time := params.OraFine2_Mercoledi;
  edOra_Inizio_3_Mer.Time := params.OraInizio3_Mercoledi;
  edOra_Fine_3_Mer.Time := params.OraFine3_Mercoledi;

  edOra_Inizio_1_Gio.Time := params.OraInizio1_Giovedi;
  edOra_Fine_1_Gio.Time := params.OraFine1_Giovedi;
  edOra_Inizio_2_Gio.Time := params.OraInizio2_Giovedi;
  edOra_Fine_2_Gio.Time := params.OraFine2_Giovedi;
  edOra_Inizio_3_Gio.Time := params.OraInizio3_Giovedi;
  edOra_Fine_3_Gio.Time := params.OraFine3_Giovedi;

  edOra_Inizio_1_Ven.Time := params.OraInizio1_Venerdi;
  edOra_Fine_1_Ven.Time := params.OraFine1_Venerdi;
  edOra_Inizio_2_Ven.Time := params.OraInizio2_Venerdi;
  edOra_Fine_2_Ven.Time := params.OraFine2_Venerdi;
  edOra_Inizio_3_Ven.Time := params.OraInizio3_Venerdi;
  edOra_Fine_3_Ven.Time := params.OraFine3_Venerdi;

  edOra_Inizio_1_Sab.Time := params.OraInizio1_Sabato;
  edOra_Fine_1_Sab.Time := params.OraFine1_Sabato;
  edOra_Inizio_2_Sab.Time := params.OraInizio2_Sabato;
  edOra_Fine_2_Sab.Time := params.OraFine2_Sabato;
  edOra_Inizio_3_Sab.Time := params.OraInizio3_Sabato;
  edOra_Fine_3_Sab.Time := params.OraFine3_Sabato;

  edOra_Inizio_1_Dom.Time := params.OraInizio1_Domenica;
  edOra_Fine_1_Dom.Time := params.OraFine1_Domenica;
  edOra_Inizio_2_Dom.Time := params.OraInizio2_Domenica;
  edOra_Fine_2_Dom.Time := params.OraFine2_Domenica;
  edOra_Inizio_3_Dom.Time := params.OraInizio3_Domenica;
  edOra_Fine_3_Dom.Time := params.OraFine3_Domenica;

  AbilitaGiorni;

  initialized := True;

  result := ShowModal = mrOk;

  if result then
    aParams := params;
end;

function TFormGeneraCalendarioStage.VerificaDati: boolean;

  procedure VerificaOre(Giorno: string; OraInizio1, OraFine1, OraInizio2, OraFine2, OraInizio3, OraFine3: TTime);
  begin

    if (OraInizio1 <> 0) and (OraFine1 <> 0) and (OraInizio1 >= OraFine1) then
      raise Exception.Create(Giorno + ': data 1 inizio maggiore di data 1 fine.');

    if (OraInizio2 <> 0) and (OraFine2 <> 0) and (OraInizio2 >= OraFine2) then
      raise Exception.Create(Giorno + ': data 2 inizio maggiore di data 2 fine.');

    if (OraInizio3 <> 0) and (OraFine3 <> 0) and (OraInizio3 >= OraFine3) then
      raise Exception.Create(Giorno + ': data 3 inizio maggiore di data 3 fine.');

    if (OraInizio1 <> 0) and (OraInizio2 <> 0) and (OraFine1 >= OraInizio2) then
      raise Exception.Create(Giorno + ': data 1 fine maggiore di data 2 inizio.');

    if (OraInizio2 <> 0) and (OraInizio3 <> 0) and (OraFine2 >= OraInizio3) then
      raise Exception.Create(Giorno + ': data 2 fine maggiore di data 3 inizio.');
  end;

begin
  result := false;

  if (edDalGiorno.Date = 0) or (edDalGiorno.Date = cxDateUtils.NullDate) then
    raise Exception.Create('Data Inizio non specificata');

  if (edAlGiorno.Date = 0) or (edAlGiorno.Date = cxDateUtils.NullDate) then
    raise Exception.Create('Data Fine non specificata');

  if edDalGiorno.Date < edAlGiorno.Date then
    raise Exception.Create('Data inizio minore data fine.');

  if dxLayoutGroupOrari.ButtonOptions.CheckBox.Checked then
  begin
    VerificaOre('Lunedì', edOra_Inizio_1_Lun.Time, edOra_Fine_1_Lun.Time, edOra_Inizio_2_Lun.Time, edOra_Fine_2_Lun.Time, edOra_Inizio_3_Lun.Time, edOra_Fine_3_Lun.Time);
    VerificaOre('Martedì', edOra_Inizio_1_Mar.Time, edOra_Fine_1_Mar.Time, edOra_Inizio_2_Mar.Time, edOra_Fine_2_Mar.Time, edOra_Inizio_3_Mar.Time, edOra_Fine_3_Mar.Time);
    VerificaOre('Mercoledì', edOra_Inizio_1_Mer.Time, edOra_Fine_1_Mer.Time, edOra_Inizio_2_Mer.Time, edOra_Fine_2_Mer.Time, edOra_Inizio_3_Mer.Time, edOra_Fine_3_Mer.Time);
    VerificaOre('Giovedì', edOra_Inizio_1_Gio.Time, edOra_Fine_1_Gio.Time, edOra_Inizio_2_Gio.Time, edOra_Fine_2_Gio.Time, edOra_Inizio_3_Gio.Time, edOra_Fine_3_Gio.Time);
    VerificaOre('Venerdì', edOra_Inizio_1_Ven.Time, edOra_Fine_1_Ven.Time, edOra_Inizio_2_Ven.Time, edOra_Fine_2_Ven.Time, edOra_Inizio_3_Ven.Time, edOra_Fine_3_Ven.Time);
    VerificaOre('Sabato', edOra_Inizio_1_Sab.Time, edOra_Fine_1_Sab.Time, edOra_Inizio_2_Sab.Time, edOra_Fine_2_Sab.Time, edOra_Inizio_3_Sab.Time, edOra_Fine_3_Sab.Time);
    VerificaOre('Domenica', edOra_Inizio_1_Dom.Time, edOra_Fine_1_Dom.Time, edOra_Inizio_2_Dom.Time, edOra_Fine_2_Dom.Time, edOra_Inizio_3_Dom.Time, edOra_Fine_3_Dom.Time);
  end;

  result := True;
end;

procedure TFormGeneraCalendarioStage.InitLookups;

  procedure InitLookup(lk: TcxExtLookupComboBox);
  var
    s: String;
    dataset: TzFbDataset;
    datasource: TDataSource;
  begin
    s := self.ClassName + '_' + lk.name;
    CreateDataSet(lk, dataset, datasource);

    dx.InitLookup(s, lk, dataset, datasource, 'CONTENUTI', 'CONTENUTI');

    lk.Properties.ImmediatePost := True;
    lk.Properties.OnEditValueChanged := ContenutiPropertiesEditValueChanged;
  end;

begin
  InitLookup(edContenuti1_Lun);
  InitLookup(edContenuti2_Lun);
  InitLookup(edContenuti3_Lun);
  InitLookup(edContenuti1_Mar);
  InitLookup(edContenuti2_Mar);
  InitLookup(edContenuti3_Mar);
  InitLookup(edContenuti1_Mer);
  InitLookup(edContenuti2_Mer);
  InitLookup(edContenuti3_Mer);
  InitLookup(edContenuti1_Gio);
  InitLookup(edContenuti2_Gio);
  InitLookup(edContenuti3_Gio);
  InitLookup(edContenuti1_Ven);
  InitLookup(edContenuti2_Ven);
  InitLookup(edContenuti3_Ven);
  InitLookup(edContenuti1_Sab);
  InitLookup(edContenuti2_Sab);
  InitLookup(edContenuti3_Sab);
  InitLookup(edContenuti1_Dom);
  InitLookup(edContenuti2_Dom);
  InitLookup(edContenuti3_Dom);
end;

procedure TFormGeneraCalendarioStage.ContenutiPropertiesEditValueChanged(Sender: TObject);
  function getValue(lk: TcxExtLookupComboBox): string;
  begin
    if varIsNull(lk.EditValue) then
      result := ''
    else
      result := VarToStr(lk.EditValue);
  end;

begin
  params.Contenuti1_Lunedi := getValue(edContenuti1_Lun);
  params.Contenuti2_Lunedi := getValue(edContenuti2_Lun);
  params.Contenuti3_Lunedi := getValue(edContenuti3_Lun);
  params.Contenuti1_Martedi := getValue(edContenuti1_Mar);
  params.Contenuti2_Martedi := getValue(edContenuti2_Mar);
  params.Contenuti3_Martedi := getValue(edContenuti3_Mar);
  params.Contenuti1_Mercoledi := getValue(edContenuti1_Mer);
  params.Contenuti2_Mercoledi := getValue(edContenuti2_Mer);
  params.Contenuti3_Mercoledi := getValue(edContenuti3_Mer);
  params.Contenuti1_Giovedi := getValue(edContenuti1_Gio);
  params.Contenuti2_Giovedi := getValue(edContenuti2_Gio);
  params.Contenuti3_Giovedi := getValue(edContenuti3_Gio);
  params.Contenuti1_Venerdi := getValue(edContenuti1_Ven);
  params.Contenuti2_Venerdi := getValue(edContenuti2_Ven);
  params.Contenuti3_Venerdi := getValue(edContenuti3_Ven);
  params.Contenuti1_Sabato := getValue(edContenuti1_Sab);
  params.Contenuti2_Sabato := getValue(edContenuti2_Sab);
  params.Contenuti3_Sabato := getValue(edContenuti3_Sab);
  params.Contenuti1_Domenica := getValue(edContenuti1_Dom);
  params.Contenuti2_Domenica := getValue(edContenuti2_Dom);
  params.Contenuti3_Domenica := getValue(edContenuti3_Dom);
end;

procedure TFormGeneraCalendarioStage.CreateDataSet(const owner: TComponent; out dataset: TzFbDataset; out datasource: TDataSource);
begin
  dataset := generaDatasetFunc(owner);
  dataset.name := owner.name + '_dataset';
  dataset.Active := True;

  datasource := TDataSource.Create(owner);
  datasource.dataset := dataset;
  datasource.name := owner.name + '_datasource';
end;

end.

//


zz.tuples
zfbdataset
