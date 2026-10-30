unit frmTirocini;

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
  Data.DB,
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
  cxFilter,
  zFormController,
  zFileViewer,
  zDbView,
  cxTextEdit,
  cxMaskEdit,
  cxButtonEdit,
  cxDropDownEdit,
  cxCheckComboBox,
  cxDBCheckComboBox,
  dxLayoutcxEditAdapters,
  dxLayoutContainer,
  cxSpinEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBExtLookupComboBox,
  dxLayoutControl,
  Vcl.StdActns,
  dxLayoutControlAdapters,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  dxWheelPicker,
  dxNumericWheelPicker,
  dxDateTimeWheelPicker,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  cxCalendar,
  cxStyles,
  cxCustomData,
  cxData,
  cxDataStorage,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxDBData,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  dxUIAClasses;

type
  TFormTirocini = class(TBaseForm)
    ActionList: TActionList;
    NuovaAziendaOspitante: TAction;
    GeneraTutorAziendale: TAction;
    layoutPagamentiMese: TdxLayoutControl;
    edMese: TcxComboBox;
    edAnno: TcxSpinEdit;
    layoutPagamentiMeseGroup_Root: TdxLayoutGroup;
    dxLayoutItemMese: TdxLayoutItem;
    dxLayoutItemAnno: TdxLayoutItem;
    ElaboraIndennitaMese: TAction;
    EsportaIndennitaMese: TFileSaveAs;
    btnElaboraIndennitaMese: TcxButton;
    dxLayoutItemElaboraIndennitaMese: TdxLayoutItem;
    btnEsportaIndennitaMese: TcxButton;
    dxLayoutItemEsportaIndennitaMese: TdxLayoutItem;
    GeneraCalendarioStage: TAction;
    SettimanaPrecedente: TAction;
    SettimanaSuccessiva: TAction;
    ApriRendicontazione: TAction;
    CreaUtenteSistemaStudente: TAction;
    CreaUtenteSistemaTutor: TAction;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    dxLayoutGroup1: TdxLayoutGroup;
    procedure GeneraCalendarioStageExecute(Sender: TObject);
    procedure ElaboraIndennitaMeseExecute(Sender: TObject);
    procedure EsportaIndennitaMeseAccept(Sender: TObject);
    procedure EsportaIndennitaMeseBeforeExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NuovaAziendaOspitanteExecute(Sender: TObject);
    procedure edMesePropertiesEditValueChanged(Sender: TObject);
    procedure edAnnoPropertiesEditValueChanged(Sender: TObject);
    procedure ApriRendicontazioneExecute(Sender: TObject);
    procedure CreaUtenteSistemaStudenteExecute(Sender: TObject);
    procedure CreaUtenteSistemaTutorExecute(Sender: TObject);
  private
  private
    procedure TirociniCardAfterCreateDbControl(Sender: TObject; const FieldName: string; cxCustomEdit: TcxCustomEdit);
    procedure ObiettivoButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure PeriodiButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure Studenti_Tirocini_CalendarioGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
    procedure AfterCreateControls; override;
    procedure SetPK(const Value: Variant); override;
  public
  end;

var
  FormTirocini: TFormTirocini;

implementation

uses
  System.IOUtils,
  System.DateUtils,
  Files.Lib,
  dmTirocini,
  zMsg,
  zdx,
  zHyperLinks,
   
  Gesty.Types,
  zFbDataSet;

{$R *.dfm}

procedure TFormTirocini.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  inherited;
  Caption := 'Tirocini/State';
  ReportGroup := 'Tirocini';

  layoutPagamentiMese.Visible := False;
  layoutPagamentiMese.Parent := Self;
  dx.InitLayoutControl(layoutPagamentiMese);
  layoutPagamentiMese.Height := 50;

  edMese.Properties.Items.Clear;

  for I := 1 to 12 do
    edMese.Properties.Items.Add(FormatSettings.LongMonthNames[I]);

  edMese.ItemIndex := MonthOf(Date) - 1;
  edAnno.Value := YearOf(Date);

  // dx.InitProperties(ctLookup, edProgetto.Properties);
  // edProgetto.Text := '';
  // edProgetto.Properties.KeyFieldNames := 'ID_PROGETTO';
  // edProgetto.Properties.ListFieldNames := 'DENOMINAZIONE_PROGETTO';
  // // edProgetto.Properties.ListFieldNames := 'DESC_COMPLETA_PROGETTO';
  // edProgetto.Properties.ListSource := Risorse.lkProgettiSrc;
  // edProgetto.Properties.OnButtonClick := edProgettoPropertiesButtonClick;
end;

procedure TFormTirocini.CreateDataModule;
begin
  inherited;
  CreateDM(TTirocini, Tirocini);
end;

procedure TFormTirocini.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Tirocini);
end;

procedure TFormTirocini.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Tirocini') then
    // begin
      // view.AddAction(GeneraDocumentazione, zDmImages.ImageList16);
      // view.AddAction(CreaUtenteSistemaStudente, zDmImages.ImageList16);
      // view.InitToolActions;
      // view.OnCardAfterCreateDbControl := TirociniCardAfterCreateDbControl;
// 
      // tools.AddFiltroPickList('TIROCINI_STATO', view, Tirocini.GetDataSet(DataSetName), 'STATO_TIROCINIO', 'Stato', 'stato tirocinio', 'A', true, 'Tutti', 120);
    // end
    // else
      // if SameText(DataSetName, 'Studenti_Tirocini_Calend_Stage') then
      // begin
        // view.AddAction(GeneraCalendarioStage, zDmImages.ImageList16);
        // view.AddAction(ApriRendicontazione, zDmImages.ImageList16);
        // view.InitToolActions;
// 
        // view.cxGridDBTableView.Styles.OnGetContentStyle := Studenti_Tirocini_CalendarioGetContentStyle;
      // end
      // else
        // if SameText(DataSetName, 'Presenze') then
        // begin
          // view.AddAction(ApriRendicontazione, zDmImages.ImageList16);
          // view.InitToolActions;
        // end
        // else
          // if SameText(DataSetName, 'Progetti_Formativi') then
          // begin
            // tools.AddFiltroEnte(view, Tirocini.GetDataSet(DataSetName));
            // tools.AddFiltroAnnoFormativo(view, Tirocini.GetDataSet(DataSetName));
          // end
          // else
            // if SameText(DataSetName, 'AziendeOspitanti') then
            // begin
              // view.AddAction(NuovaAziendaOspitante, zDmImages.ImageList16);
              // view.InitToolActions;
            // end
            // else
              // if SameText(DataSetName, 'AziendeOspitanti_Tirocini') then
              // begin
// 
              // end
              // else
                // if SameText(DataSetName, 'Aziende_Contatti') then
                // begin
                  // view.AddAction(CreaUtenteSistemaTutor, zDmImages.ImageList16);
                  // view.InitToolActions;
                // end
                // else
                  // if SameText(DataSetName, 'ElencoIndennita') then
                  // begin
                    // tools.AddFiltroAnnoSolare(view, Tirocini.GetDataSet(DataSetName));
                  // end
                  // else
                    // if SameText(DataSetName, 'RiepilogoIndennita') then
                    // begin
                      // tools.AddFiltroFonteFinanziamento(view, Tirocini.GetDataSet(DataSetName));
                      // tools.AddFiltroAnnoSolare(view, Tirocini.GetDataSet(DataSetName));
                      // { TODO : Report Riepilogo Indennit� Tirocinio.xlsx }
                    // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormTirocini.Studenti_Tirocini_CalendarioGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  col: TcxGridDbColumn;
begin

  if AItem is TcxGridDbColumn then
  begin
    col := TcxGridDbColumn(AItem);

    if col.GetProperties.ReadOnly then
      // AStyle := dx.GetStyle(scBtnFace)
    else
      AStyle := dx.GetStyle(scCream);
  end;
end;

procedure TFormTirocini.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(layoutPagamentiMese, 'FiltriIndennitaMese', False);
end;

procedure TFormTirocini.GeneraCalendarioStageExecute(Sender: TObject);
begin
  inherited;
  Tirocini.GeneraCalendarioStage;
end;

procedure TFormTirocini.SetPK(const Value: Variant);
var
  view: TzDbView;
begin
  inherited;
  //
  if pkMode then
  begin

    if pkField = 'ID_TIROCINIO' then
    begin
      SelectedDataSetName := 'Tirocini';

      view := getView('Tirocini');
      if Assigned(view) then
      begin
        view.ClearFilter(False);
        view.AddFilterCondition('ID_TIROCINIO', foEqual, pk);
      end;
    end
    else
      if pkField = 'ID_PROGETTO_FORMATIVO' then
      begin

        SelectedDataSetName := 'Progetti_Formativi';

        view := getView('Progetti_Formativi');
        if Assigned(view) then
        begin
          view.ClearFilter(False);
          view.AddFilterCondition('ID_PROGETTO_FORMATIVO', foEqual, pk);
        end;
      end
      else
        if pkField = 'ID_AZIENDA_OSPITANTE' then
        begin

          SelectedDataSetName := 'AziendeOspitanti';

          view := getView('AziendeOspitanti');
          if Assigned(view) then
          begin
            view.ClearFilter(False);
            view.AddFilterCondition('ID_AZIENDA_OSPITANTE', foEqual, pk);
          end;
        end;
  end;
end;

procedure TFormTirocini.NuovaAziendaOspitanteExecute(Sender: TObject);
begin
  inherited;
  Tirocini.NuovaAziendaOspitantePerProgettoFormativo;
end;

procedure TFormTirocini.ObiettivoButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  ConfirmOk('ok');
end;

procedure TFormTirocini.PeriodiButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  Tirocini.ModificaPeriodi;
end;

procedure TFormTirocini.EsportaIndennitaMeseAccept(Sender: TObject);
begin
  inherited;
  Tirocini.EsportaIndennitaMese(EsportaIndennitaMese.Dialog.FileName);
end;

procedure TFormTirocini.EsportaIndennitaMeseBeforeExecute(Sender: TObject);
begin
  inherited;

  if EsportaIndennitaMese.Dialog.FileName = '' then
    EsportaIndennitaMese.Dialog.FileName := 'Indennit� ' + edMese.Text + ' ' + edAnno.Text + '.xlsx';
end;

procedure TFormTirocini.edAnnoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  Tirocini.Anno_Indennita := edAnno.Value;
end;

procedure TFormTirocini.edMesePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  Tirocini.Mese_Indennita := edMese.ItemIndex + 1;
end;

procedure TFormTirocini.ElaboraIndennitaMeseExecute(Sender: TObject);
begin
  inherited;
  Tirocini.ElaboraIndennitaMese;
end;

procedure TFormTirocini.ApriRendicontazioneExecute(Sender: TObject);
begin
  inherited;
  Tirocini.ApriRendicontazioneTirocinio;
end;

procedure TFormTirocini.TirociniCardAfterCreateDbControl(Sender: TObject; const FieldName: string; cxCustomEdit: TcxCustomEdit);

  function GetDataSet(cxCustomEdit: TcxCustomEdit): TDataSet;
  var
    props: TcxExtLookupComboBoxProperties;
  begin
    result := nil;

    if cxCustomEdit.ActiveProperties is TcxExtLookupComboBoxProperties then
    begin
      props := TcxExtLookupComboBoxProperties(cxCustomEdit.ActiveProperties);

      if Assigned(props.view) then
        if props.view is TcxGridDBTableView then
          if Assigned(TcxGridDBTableView(props.view).DataController.DataSource) then
            result := TcxGridDBTableView(props.view).DataController.DataSource.DataSet;
    end;
  end;

var
  DataSet: TDataSet;
begin
  inherited;

  if SameText(FieldName, 'OBIETTIVO') then
  begin
    cxCustomEdit.ActiveProperties.Buttons.Add.Kind := bkEllipsis;
    cxCustomEdit.ActiveProperties.OnButtonClick := ObiettivoButtonClick;
  end
  else
    if SameText(FieldName, 'ELENCO_PERIODI') then
    begin
      cxCustomEdit.ActiveProperties.Buttons.Add.Kind := bkEllipsis;
      cxCustomEdit.ActiveProperties.OnButtonClick := PeriodiButtonClick;
    end
    else
      if SameText(FieldName, 'ID_TUTOR_AZIENDALE') then
      begin
        DataSet := GetDataSet(cxCustomEdit);

        if Assigned(DataSet) then
          DataSet.OnNewRecord := Tirocini.ContattiNewRecord;
      end
      else
        if SameText(FieldName, 'ID_CONVENZIONE') then
        begin
          DataSet := GetDataSet(cxCustomEdit);

          if Assigned(DataSet) then
            DataSet.OnNewRecord := Tirocini.ConvenzioniNewRecord;
        end
        else
          if SameText(FieldName, 'ID_SEDE_OPERATIVA') then
          begin
            DataSet := GetDataSet(cxCustomEdit);

            if Assigned(DataSet) then
              DataSet.OnNewRecord := Tirocini.SediOperativeNewRecord;
          end;
end;

procedure TFormTirocini.CreaUtenteSistemaStudenteExecute(Sender: TObject);
begin
  inherited;
  Tirocini.CreaUtenteSistemaStudente;
end;

procedure TFormTirocini.CreaUtenteSistemaTutorExecute(Sender: TObject);
begin
  inherited;
  Tirocini.CreaUtenteSistemaTutor;
end;

procedure TFormTirocini.SetupComponent(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
begin
  inherited;

  if Component is TzDbView then
  begin
    view := TzDbView(Component);

    if SameText(DataSetName, 'Tirocini') then
    begin
      view.OnCardAfterCreateDbControl := TirociniCardAfterCreateDbControl;
    end
    else
      if SameText(DataSetName, 'Studenti_Tirocini_Calend_Stage') then
      begin
        view.cxGridDBTableView.Styles.OnGetContentStyle := Studenti_Tirocini_CalendarioGetContentStyle;
      end;
  end;
end;

initialization

HyperLinks.RegisterHandler('ID_TIROCINIO', TFormTirocini);
HyperLinks.RegisterHandler('ID_PROGETTO_FORMATIVO', TFormTirocini);

// HyperLinks.RegisterHandler('ID_AZIENDA_OSPITANTE', TFormTirocini);
end.
//

// ApriTirociniOrario => GeneraCalendarioStage

// Tirocini.Studenti_Tirocini_Calendario
// togliere il pannello di rendicontazione
// aggiungere pulsante per generare/stampare
/// //////////////////////////////////////////
/// Tirocini.Presenze
/// Sdoppiare, aggiungere una sezione per la rendicontazione su base settimanale
///
/// Tirocini.GeneraPresenze;
///
///
///
///
/// procedure TForm1.Button1Click(Sender: TObject);
///
///
  zoffice.word.form
