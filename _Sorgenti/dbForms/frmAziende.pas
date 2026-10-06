unit frmAziende;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.TMSFNCMaps,
  Data.DB,
  dxBar,
  dxBarExtItems,
  dxLayoutContainer,
  dxLayoutControl,
  dxLayoutcxEditAdapters,
  dxLayoutControlAdapters,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxLabel,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBExtLookupComboBox,
  cxCheckBox,
  cxCheckComboBox,
  cxButtons,
  zDbView,
  BaseFrm,
  zMap,
  Vcl.ExtCtrls,
  cxStyles,
  cxFilter,
  dxScrollbarAnnotations,
  cxInplaceContainer,
  cxVGrid,
  cxDBVGrid,
  dxLayoutLookAndFeels;

type
  TFormAziende = class(TBaseForm)
    layoutFiltriGroup_Root: TdxLayoutGroup;
    layoutFiltri: TdxLayoutControl;
    edFiltroSettori: TcxCheckComboBox;
    edFiltroCAP: TcxTextEdit;
    edFiltroRagioneSociale: TcxTextEdit;
    edFiltroPIvaCodFisc: TcxTextEdit;
    edFiltroEnte: TcxExtLookupComboBox;
    dxLayoutItemFiltroSettore: TdxLayoutItem;
    dxLayoutItemFiltroCAP: TdxLayoutItem;
    dxLayoutItemRagioneSociale: TdxLayoutItem;
    dxLayoutItemFiltroPIvaCodFisc: TdxLayoutItem;
    dxLayoutItemFiltroEnte: TdxLayoutItem;
    dxLayoutGroupRicercaFiltri: TdxLayoutGroup;
    dxLayoutEmptySpaceItemTop: TdxLayoutEmptySpaceItem;
    dxLayoutLabeledItemRicercaFiltro: TdxLayoutLabeledItem;
    dxLayoutEmptySpaceItemLeft: TdxLayoutEmptySpaceItem;
    zMap: TzMap;
    ActionList: TActionList;
    MostraSuMappa: TAction;
    btnMappa: TcxButton;
    dxLayoutItemMappa: TdxLayoutItem;
    dxLayoutEmptySpaceItemCAP: TdxLayoutEmptySpaceItem;
    dxLayoutGroupCAP: TdxLayoutGroup;
    dxLayoutSplitterItemSettore: TdxLayoutSplitterItem;
    dxLayoutSplitterItemPIVACodFisc: TdxLayoutSplitterItem;
    dxLayoutSplitterItemEnte: TdxLayoutSplitterItem;
    dxLayoutSplitterItemRagioneSociale: TdxLayoutSplitterItem;
    edFiltroDisponibilita: TcxCheckComboBox;
    dxLayoutItemDisponibilita: TdxLayoutItem;
    dxLayoutSplitterItemDisponibilita: TdxLayoutSplitterItem;
    dxLayoutLookAndFeelList: TdxLayoutLookAndFeelList;
    procedure edFiltroSettorePropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroCAPPropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroRagioneSocialePropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroPIvaCodFiscPropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroEntePropertiesEditValueChanged(Sender: TObject);
    procedure MostraSuMappaExecute(Sender: TObject);
    procedure zMapMapInitialized(Sender: TObject);
    procedure zMapMarkerClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
    procedure edFiltroDisponibilitaPropertiesEditValueChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure layoutFiltriContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
    procedure AfterCreateControls; override;
    procedure AfterLayoutControlLoadProps; override;
  private
    procedure cardAziendaDblClick(Sender: TObject);
  private
    procedure AddSummary(view: TzDbView);
    function FiltroValue(value: variant): string;

    procedure AllineaCollaborazioni;

    procedure ImpostaFontLabelCollaborazioni;
    procedure CollaborazioniSetImageIndex;

    procedure DetailRecordChanged(Sender: TObject);
  private
    procedure ShowMarkerAziende;
    function GetProperties(AEventData: TTMSFNCMapsEventData): String; overload;
    function GetProperties(PolyElement: TTMSFNCMapsPolyElement): String; overload;
    function GetProperties(Marker: TTMSFNCMapsMarker): String; overload;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAziende: TFormAziende;

implementation

uses
  VCL.TMSFNCMapsCommonTypes, cxCustomData, zDm_Images, dmAziende, zDX, zBaseLib,
    zDbCard, zMsg;

{$R *.dfm}

procedure TFormAziende.CreateDataModule;
begin
  inherited;
  CreateDM(TAziende, Aziende);
end;

procedure TFormAziende.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Aziende);
end;

constructor TFormAziende.Create(aOwner: TComponent);
var
  StringList: TStringList;

begin
  inherited;
  ReportGroup := 'Aziende';
  Caption := 'Aziende';

  Aziende.BloccaFiltri := true;
  try

    edFiltroSettori.Clear;
    edFiltroCAP.Clear;
    edFiltroRagioneSociale.Clear;
    edFiltroPIvaCodFisc.Clear;
    edFiltroEnte.Clear;

    dx.InitLayoutControl(layoutFiltri);
    dx.InitProperties(ctCheckComboBox, edFiltroSettori.ActiveProperties);
    dx.InitProperties(ctCheckComboBox, edFiltroDisponibilita.ActiveProperties);

    StringList := TStringList.Create;
    try
      Aziende.FillSettori(StringList);
      edFiltroSettori.FillItems(StringList);

      Aziende.FillDisponibilita(StringList);
      edFiltroDisponibilita.FillItems(StringList);
    finally
      FreeAndNil(StringList);
    end;

    dx.InitLookup('Aziende_FiltroEnte', edFiltroEnte, Aziende.lkEnti, Aziende.lkEntiSrc, 'ID_ENTE', 'ENTE');
  finally
    Aziende.BloccaFiltri := false;
  end;
end;

procedure TFormAziende.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(layoutFiltri, 'Filtri', false);
  AddLayoutItem(zMap, 'Mappa', false);
end;

function TFormAziende.FiltroValue(value: variant): string;
begin
  if VarIsNull(value) then
    result := ''
  else
    result := value;
end;

procedure TFormAziende.edFiltroSettorePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  Aziende.FiltroSettori := FiltroValue(edFiltroSettori.EditValue);
end;

procedure TFormAziende.edFiltroCAPPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  Aziende.FiltroCAP := FiltroValue(edFiltroCAP.EditValue);
end;

procedure TFormAziende.edFiltroDisponibilitaPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  Aziende.FiltroDisponibilita := FiltroValue(edFiltroDisponibilita.EditValue);
end;

procedure TFormAziende.edFiltroRagioneSocialePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  Aziende.FiltroRagioneSociale := FiltroValue(edFiltroRagioneSociale.EditValue);
end;

procedure TFormAziende.edFiltroPIvaCodFiscPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  Aziende.FiltroPartitaIvaCodiceFiscale := FiltroValue(edFiltroPIvaCodFisc.EditValue);
end;

procedure TFormAziende.edFiltroEntePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  if VarIsNull(edFiltroEnte.EditValue) then
    Aziende.FiltroEnte := -1
  else
    Aziende.FiltroEnte := edFiltroEnte.EditValue;
end;

procedure TFormAziende.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
  // card: TzDbCard;
// begin
  // inherited;
// 
  // if Component is TzDbCard then
  // begin
    // card := TzDbCard(Component);
// 
    // if SameText(DataSetName, 'Aziende') then
    // begin
      // card.cxScrollBox.OnDblClick := cardAziendaDblClick;
      // card.OnDataSetEdit := cardAziendaDblClick;
    // end;
  // end
  // else
    // if Component is TzDbView then
    // begin
      // view := TzDbView(Component);
// 
      // if SameText(DataSetName, 'TirociniFormativi') then
      // begin
        // view.AddAction(Autorizza, zDmImages.ImageList16);
        // view.InitToolActions;
        // Tools.AddFiltroEnte(view, Aziende.GetDataSet(DataSetName));
        // view.OnRecordChanged := DetailRecordChanged;
        // AddSummary(view);
      // end
      // else
        // if SameText(DataSetName, 'TirociniExtracurricolari') then
        // begin
          // view.OnRecordChanged := DetailRecordChanged;
          // AddSummary(view);
        // end
        // else
          // if SameText(DataSetName, 'ApprendistatiDuali') then
          // begin
            // view.OnRecordChanged := DetailRecordChanged;
            // AddSummary(view);
          // end
          // else
            // if SameText(DataSetName, 'ApprendistatiIFTS_ITS') then
            // begin
              // view.OnRecordChanged := DetailRecordChanged;
              // AddSummary(view);
            // end
            // else
              // if SameText(DataSetName, 'CorsiAttivati') then
              // begin
                // view.OnRecordChanged := DetailRecordChanged;
                // AddSummary(view);
              // end
              // else
                // if SameText(DataSetName, 'IncarichiFormazione') then
                // begin
                  // view.OnRecordChanged := DetailRecordChanged;
                  // AddSummary(view);
                // end
                // else
                  // if SameText(DataSetName, 'Contratti_Fornitura') then
                  // begin
                    // view.OnRecordChanged := DetailRecordChanged;
                    // AddSummary(view);
                  // end
                  // else
                    // if SameText(DataSetName, 'Sal_Richieste_Personale') then
                    // begin
                      // view.OnRecordChanged := DetailRecordChanged;
                      // AddSummary(view);
                    // end;
    // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormAziende.cardAziendaDblClick(Sender: TObject);
var
  view: TzDbView;
begin
  view := getView('Aziende');
  view.ShowRecord(false);
end;

procedure TFormAziende.zMapMarkerClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
var
  s: string;
  id: Integer;
begin
  inherited;

  if CtrlKey then
  begin
    if assigned(AEventData.Marker) then
    begin
      // if AEventData.Marker.DataString = Qta_GiriRaccolta.ConferimentiPerArea.Name then
      // Qta_GiriRaccolta.ApriConferimentoDetail(AEventData.Marker.DataInteger)
      // else
      // maps.ApriEdificioOrCivico(AEventData);
    end;
  end
  else
  begin
    s := GetProperties(AEventData);

    if not s.IsEmpty then
      ConfirmOk(s);
  end;
end;

function TFormAziende.GetProperties(AEventData: TTMSFNCMapsEventData): String;
begin
  result := '';

  if assigned(AEventData) then
    if assigned(AEventData.PolyElement) then
      result := GetProperties(AEventData.PolyElement)
    else
      if assigned(AEventData.Marker) then
        result := GetProperties(AEventData.Marker);
end;

function TFormAziende.GetProperties(Marker: TTMSFNCMapsMarker): String;
begin
  result := '';

  if assigned(Marker) then
    if assigned(Marker.DataObject) then
      if Marker.DataObject is TStrings then
        result := TStrings(Marker.DataObject).Text;
end;

procedure TFormAziende.ImpostaFontLabelCollaborazioni;
var
  zLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;

  item: TdxCustomLayoutItem;
begin
  // imposta il font a 11

  if dxLayoutLookAndFeelList.Count = 0 then
  begin
    zLayoutLookAndFeel := dxLayoutLookAndFeelList.CreateItem(TzLayoutLookAndFeel) as TzLayoutLookAndFeel;
    zLayoutLookAndFeel.Name := 'LookAndFeelCollaborazioni';
    TzLayoutLookAndFeel(zLayoutLookAndFeel).LookAndFeel.Kind := lfUltraFlat;
    zLayoutLookAndFeel.ItemOptions.CaptionOptions.Font.Size := 11;
  end
  else
    zLayoutLookAndFeel := dxLayoutLookAndFeelList.items[0];

  item := FormController.LayoutController.dxLayoutControl.FindItem('dxLayoutLabelCollaborazioni');
  if assigned(item) then
    item.LayoutLookAndFeel := zLayoutLookAndFeel;
end;

function TFormAziende.GetProperties(PolyElement: TTMSFNCMapsPolyElement): String;
begin
  result := '';

  if assigned(PolyElement) then
    if assigned(PolyElement.DataObject) then
      if PolyElement.DataObject is TStrings then
        result := TStrings(PolyElement.DataObject).Text;
end;

procedure TFormAziende.zMapMapInitialized(Sender: TObject);
begin
  inherited;
  ShowMarkerAziende;
end;

procedure TFormAziende.AfterLayoutControlLoadProps;
begin
  inherited;
  AllineaCollaborazioni;

  ImpostaFontLabelCollaborazioni;

  // attivare/nascondere le varie tipologie
end;

procedure TFormAziende.MostraSuMappaExecute(Sender: TObject);
var
  group: TdxLayoutGroup;
begin
  group := FormController.LayoutController.dxLayoutControl.FindItem('gruppoPageControl') as TdxLayoutGroup;
  group.ItemIndex := 1;

  if zMap.Ready then
    ShowMarkerAziende
  else
    zMap.InitMap;
end;

procedure TFormAziende.ShowMarkerAziende;

var
  coord: string;
  ElencoAziende: TDataSet;
  SediOperative: TDataSet;
  FillMarker: TProc<TDataSet>;
begin
  inherited;

  StartWait('Attendere...', true);
  try
    if not zMap.Ready then
      exit;

    zMap.ClearMarkers;

    FillMarker := procedure(ElencoAziende: TDataSet)
      var
        indirizzoSedeLegale: string;
        indirizzoSedeOperativa: string;
        Properties: TStringList;
        coord: TTMSFNCMapsCoordinateRec;
      begin

        if zMap.map.Markers.Count >= 50 then
          exit;

        Properties := TStringList.Create;
        try
          indirizzoSedeLegale := ElencoAziende.FieldByName('SEDE_LEGALE_INDIRIZZO_COMPLETO').AsString;

          if not indirizzoSedeLegale.IsEmpty then
          begin
            coord := zMap.GetAddressCoordinates(indirizzoSedeLegale);

            if (coord.Latitude <> 0) and (coord.Longitude <> 0) then
            begin
              zMap.GetProperties(ElencoAziende, 'ID_AZIENDA;AZIENDA;RAGIONE_SOCIALE;', Properties);
              zMap.AddMarker(ElencoAziende.FieldByName('ID_AZIENDA').AsInteger, coord.Latitude, coord.Longitude, '', Properties, TMarkerIconColor.icRed);
            end;
          end;

          SediOperative.First;
          while not SediOperative.Eof do
          begin
            indirizzoSedeOperativa := SediOperative.FieldByName('INDIRIZZO_COMPLETO').AsString;

            if not indirizzoSedeLegale.IsEmpty then
            begin
              coord := zMap.GetAddressCoordinates(indirizzoSedeOperativa);

              if (coord.Latitude <> 0) and (coord.Longitude <> 0) then
              begin
                zMap.GetProperties(SediOperative, 'ID_SEDE_OPERATIVA;ID_AZIENDA;AZIENDA;RAGIONE_SOCIALE;SEDE_OPERATIVA;', Properties);
                zMap.AddMarker(SediOperative.FieldByName('ID_SEDE_OPERATIVA').AsInteger, coord.Latitude, coord.Longitude, '', Properties, TMarkerIconColor.icBlue);
              end;
            end;

            SediOperative.Next;
          end;
          // INDIRIZZO_COMPLETO

        finally
          FreeAndNil(Properties);
        end;
      end;

    /// ///////////////////////////////////

    ElencoAziende := GetDataSet('Aziende');
    SediOperative := GetDataSet('Aziende_Sedi_Operative_Elenco');

    ElencoAziende.DisableControls;
    try
      zMap.AddMarkers(ElencoAziende, 'ID_AZIENDA', 'AZIENDA', 'ID_AZIENDA;AZIENDA;RAGIONE_SOCIALE;', FillMarker, nil);
    finally
      ElencoAziende.EnableControls;
    end;
  finally
    StopWait;
  end;
end;

procedure TFormAziende.AllineaCollaborazioni;

  procedure SetIndex(const itemName: string; var index: Integer);
  var
    item: TdxCustomLayoutItem;
  begin
    item := FormController.LayoutController.dxLayoutControl.FindItem(itemName);
    if assigned(item) then
    begin
      item.index := index;
      inc(index);
    end;
  end;

  procedure SetItemHeight(const itemName: string; const MinHeight: Integer);
  var
    item: TdxCustomLayoutItem;
  begin
    item := FormController.LayoutController.dxLayoutControl.FindItem(itemName);
    if assigned(item) then
      if item.SizeOptions.Height < MinHeight then
        item.SizeOptions.Height := MinHeight;
  end;

  procedure SetItemWidth(const itemName: string; const MinWidth: Integer);
  var
    item: TdxCustomLayoutItem;
  begin
    item := FormController.LayoutController.dxLayoutControl.FindItem(itemName);
    if assigned(item) then
      if item.SizeOptions.Width < MinWidth then
        item.SizeOptions.Width := MinWidth;
  end;

const
  MinHeight = 150;

var
  index: Integer;
begin
  exit; // <====================================================================

  FormController.LayoutController.dxLayoutControl.BeginUpdate;
  try
    index := 0;

    SetIndex('dxLayoutGroupTirociniFormativi', index);

    SetIndex('dxLayoutSplitterTirociniExtracurricolari', index);
    SetIndex('dxLayoutGroupTirociniExtracurricolari', index);

    SetIndex('dxLayoutSplitterApprendistatiDuali', index);
    SetIndex('dxLayoutGroupApprendistatiDuali', index);

    SetIndex('dxLayoutSplitterApprendistatiIFTS_ITS', index);
    SetIndex('dxLayoutGroupApprendistatiIFTS_ITS', index);

    SetIndex('dxLayoutSplitterCorsiAttivati', index);
    SetIndex('dxLayoutGroupCorsiAttivati', index);

    SetIndex('dxLayoutSplitterIncarichiFormazione', index);
    SetIndex('dxLayoutGroupIncarichiFormazione', index);

    SetIndex('dxLayoutSplitterContratti_Fornitura', index);
    SetIndex('dxLayoutGroupContratti_Fornitura', index);

    // Elenco aziende a sx
    SetItemWidth('dxLayoutItemviewAziende_Aziende', 400);

    // altezza minima delle view
    SetItemHeight('dxLayoutGroupTirociniFormativi', MinHeight);
    SetItemHeight('dxLayoutGroupTirociniExtracurricolari', MinHeight);
    SetItemHeight('dxLayoutGroupApprendistatiDuali', MinHeight);
    SetItemHeight('dxLayoutGroupApprendistatiIFTS_ITS', MinHeight);
    SetItemHeight('dxLayoutGroupCorsiAttivati', MinHeight);
    SetItemHeight('dxLayoutGroupIncarichiFormazione', MinHeight);
    SetItemHeight('dxLayoutGroupContratti_Fornitura', MinHeight);

    // reset degli splitter
    SetItemHeight('dxLayoutSplitterTirociniExtracurricolari', 0);
    SetItemHeight('dxLayoutSplitterApprendistatiDuali', 0);
    SetItemHeight('dxLayoutSplitterApprendistatiIFTS_ITS', 0);
    SetItemHeight('dxLayoutSplitterCorsiAttivati', 0);
    SetItemHeight('dxLayoutSplitterIncarichiFormazione', 0);
    SetItemHeight('dxLayoutSplitterContratti_Fornitura', 0);
  finally
    FormController.LayoutController.dxLayoutControl.EndUpdate;
  end;
end;

procedure TFormAziende.FormShow(Sender: TObject);
begin
  inherited;
  CollaborazioniSetImageIndex;
end;

procedure TFormAziende.CollaborazioniSetImageIndex;
  procedure SetImageIndex(const itemName, DataSetName: string);
  var
    group: TdxLayoutGroup;
    DataSet: TDataSet;
    imageIndex: Integer;
  begin
    group := FormController.LayoutController.dxLayoutControl.FindItem(itemName) as TdxLayoutGroup;
    if assigned(group) then
    begin
      DataSet := GetDataSet(DataSetName);

      if assigned(DataSet) then
      begin

        if DataSet.IsEmpty then
          imageIndex := 2
        else
          imageIndex := 1;

        group.CaptionOptions.imageIndex := imageIndex;
      end;
    end;
  end;

begin
  inherited;

  if not assigned(FormController.LayoutController.dxLayoutControl) then
    exit;

  SetImageIndex('dxLayoutGroupTirociniFormativi', 'TirociniFormativi');
  SetImageIndex('dxLayoutGroupTirociniExtracurricolari', 'TirociniExtracurricolari');
  SetImageIndex('dxLayoutGroupTirociniInclusione', 'TirociniInclusione');
  SetImageIndex('dxLayoutGroupApprendistatiDuali', 'ApprendistatiDuali');
  SetImageIndex('dxLayoutGroupApprendistatiIFTS_ITS', 'ApprendistatiIFTS_ITS');
  SetImageIndex('dxLayoutGroupCorsiAttivati', 'CorsiAttivati');
  SetImageIndex('dxLayoutGroupIncarichiFormazione', 'IncarichiFormazione');
  SetImageIndex('dxLayoutGroupContratti_Fornitura', 'Contratti_Fornitura');
  SetImageIndex('dxLayoutGroupSal_Richieste_Personale', 'Sal_Richieste_Personale');
end;

procedure TFormAziende.DetailRecordChanged(Sender: TObject);
begin
  CollaborazioniSetImageIndex;
end;

procedure TFormAziende.AddSummary(view: TzDbView);
var
  summary: TcxDataSummaryItem;
begin
  view.cxGridDBTableView.DataController.DataModeController.SmartRefresh := false;

  summary := view.cxGridDBTableView.DataController.summary.DefaultGroupSummaryItems.Add;
  summary.Format := '###.###';
  summary.Kind := skCount;
  summary.Position := spGroup;
end;

procedure TFormAziende.layoutFiltriContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  Handled := false;
  { TODO : generare un popup per i TabbedGroup }
  // TdxLayoutControl(Sender).GetHitTest(MousePos.X, MousePos.Y).Item
end;

procedure TFormAziende.SetupComponent(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
  card: TzDbCard;
begin
  inherited;

  if Component is TzDbView then
  begin
    view := TzDbView(Component);

    if SameText(DataSetName, 'TirociniFormativi') then
    begin
      view.OnRecordChanged := DetailRecordChanged;
      AddSummary(view);
    end
    else if SameText(DataSetName, 'TirociniExtracurricolari') then
    begin
      view.OnRecordChanged := DetailRecordChanged;
      AddSummary(view);
    end
    else if SameText(DataSetName, 'ApprendistatiDuali') then
    begin
      view.OnRecordChanged := DetailRecordChanged;
      AddSummary(view);
    end
    else if SameText(DataSetName, 'ApprendistatiIFTS_ITS') then
    begin
      view.OnRecordChanged := DetailRecordChanged;
      AddSummary(view);
    end
    else if SameText(DataSetName, 'CorsiAttivati') then
    begin
      view.OnRecordChanged := DetailRecordChanged;
      AddSummary(view);
    end
    else if SameText(DataSetName, 'IncarichiFormazione') then
    begin
      view.OnRecordChanged := DetailRecordChanged;
      AddSummary(view);
    end
    else if SameText(DataSetName, 'Contratti_Fornitura') then
    begin
      view.OnRecordChanged := DetailRecordChanged;
      AddSummary(view);
    end
    else if SameText(DataSetName, 'Sal_Richieste_Personale') then
    begin
      view.OnRecordChanged := DetailRecordChanged;
      AddSummary(view);
    end
    ;
  end;

  if Component is TzDbCard then
  begin
    card := TzDbCard(Component);

    if SameText(DataSetName, 'Aziende') then
    begin
      // TODO BaseNew
      //card.cxScrollBox.OnDblClick := cardAziendaDblClick;
      card.OnDataSetEdit := cardAziendaDblClick;
    end
    ;
  end;

end;

end.

// completare frmAziendaScheda
// vedere WizardAzienda

  zdx

  TirociniFormativi TirociniExtracurricolari ApprendistatiDuali ApprendistatiIFTS_ITS

  CorsiAttivati ANNO_FORMATIVO IncarichiFormazione ANNO_FORMATIVO

  Contratti_Fornitura

  HyperLink Su In_Incarico zDbCard

  zDbView




// DataController.Summary.SummaryGroups = <
// item
// Links = <
// item
// Column = tvOrdersCustomerID
// end>
// SummaryItems = <
// item
// Kind = skSum
// Position = spFooter
// Column = tvOrdersPaymentAmount
// end
// item
// Format = '0'
// Kind = skCount
// end
// item
// Format = 'Last order: '
// Kind = skMax
// Column = tvOrdersPurchaseDate
// end
// item
// Kind = skCount
// Position = spFooter
// Column = tvOrdersProductID
// end
// item
// Format = '$,0.00'
// Kind = skSum
// Column = tvOrdersPaymentAmount
// end
// item
// Kind = skSum
// Position = spFooter
// Column = tvOrdersQuantity
// end
// item
// Kind = skMax
// Position = spFooter
// Column = tvOrdersPurchaseDate
// end>
// end
// item
// Links = <
// item
// Column = tvOrdersProductID
// end>
// SummaryItems = <
// item
// Format = 'Quantity: 0'
// Kind = skSum
// Column = tvOrdersQuantity
// end
// item
// Format = 'First: '
// Kind = skMin
// Column = tvOrdersPurchaseDate
// end
// item
// Format = 'Last: '
// Kind = skMax
// Column = tvOrdersPurchaseDate
// end
// item
// Kind = skSum
// Position = spFooter
// Column = tvOrdersPaymentAmount
// end
// item
// Format = '0'
// Kind = skSum
// Position = spFooter
// Column = tvOrdersQuantity
// end
// item
// Format = 'Average: $,0.00'
// Kind = skAverage
// Column = tvOrdersPaymentAmount
// end>
// end
// item
// Links = <
// item
// Column = tvOrdersPurchaseDate
// end
// item
// Column = tvOrdersPaymentType
// end>
// SummaryItems = <
// item
// Kind = skCount
// end
// item
// Format = 'Quantity: 0'
// Kind = skSum
// Column = tvOrdersQuantity
// end
// item
// Kind = skAverage
// Position = spFooter
// Column = tvOrdersPaymentAmount
// end>
// end>
//
// OptionsView.ColumnAutoWidth = True
// OptionsView.GroupFooters = gfVisibleWhenExpanded
// OptionsView.GroupSummaryLayout = gslAlignWithColumns
//

  object cxDBVerticalGrid: TcxDBVerticalGrid Left = 576 Top = 240 Width = 150 Height = 200 Navigator.Buttons.CustomButtons = <> ScrollbarAnnotations.CustomAnnotations = <>
  TabOrder = 7 DataController.DataSource = DataSource1 Version = 1 end
