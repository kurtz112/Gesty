unit frmPersonaleScheda;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
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
  zFormController,
  Vcl.Menus,
  cxStyles,
  dxBarBuiltInMenu,
  dxLayoutContainer,
  dxLayoutcxEditAdapters,
  dxLayoutControlAdapters,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  Vcl.StdCtrls,
  cxButtons,
  cxDropDownEdit,
  cxCalendar,
  cxTextEdit,
  cxMaskEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  zDbView,
  dxLayoutControl,
  System.ImageList,
  Vcl.ImgList,
  cxImageList,
  Base_Frame,
  dxUIAClasses;

type
  TFormPersonaleScheda = class(TBaseForm)
    ActionList: TActionList;
    RilevamentoOre: TAction;
    dxBarButton1: TdxBarButton;
    GeneraRilevamento: TAction;
    IsDebug: TAction;
    procedure FormCreate(Sender: TObject);
    procedure RilevamentoOreExecute(Sender: TObject);
    procedure GeneraRilevamentoExecute(Sender: TObject);
    procedure IsDebugExecute(Sender: TObject);
    procedure IsDebugUpdate(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  private
  public
  end;

var
  FormPersonaleScheda: TFormPersonaleScheda;

implementation

uses
  System.DateUtils,
  zBaseLib,
  dmPersonaleScheda,
   
  zDX,
  zDbCard;

{$R *.dfm}

procedure TFormPersonaleScheda.CreateDataModule;
begin
  inherited;
  CreateDM(TPersonaleScheda, PersonaleScheda);
end;

procedure TFormPersonaleScheda.DestroyDataModule;
begin
  inherited;
  FreeAndNil(PersonaleScheda);
end;

procedure TFormPersonaleScheda.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Personale Scheda';
  Caption := 'Scheda Personale';
end;

procedure TFormPersonaleScheda.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// begin
  // inherited;
// 
  /// /////////////
// 
  // if Component is TzDbCard then
  // begin
    // var
      // card: TzDbCard := TzDbCard(Component);
// 
    // if SameText(DataSetName, 'Personale') then
    // begin
      // card.AddAction(IsDebug, zDmImages.ImageList16);
      // card.InitToolActions;
    // end;
  // end;
// 
  /// /////////////
// 
  // if Component is TzDbView then
  // begin
    // var
      // view: TzDbView := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Personale') then
    // begin
      // view.AddAction(IsDebug, zDmImages.ImageList16);
      // view.InitToolActions;
    // end
    // else
      // if SameText(DataSetName, 'Personale_Rilevamento_Ore') then
      // begin
        // view.AddAction(RilevamentoOre, zDmImages.ImageList16).HideInCard;
        // view.InitToolActions;
// 
        // Tools.AddFiltroMese(view, PersonaleScheda.GetDataSet(DataSetName));
        // Tools.AddFiltroAnnoSolare(view, PersonaleScheda.GetDataSet(DataSetName));
      // end
      // else
        // if SameText(DataSetName, 'Personale_Incarichi') then
        // begin
          // Tools.AddFiltroAnnoFormativo(view, PersonaleScheda.GetDataSet(DataSetName));
        // end
        // else
          // if SameText(DataSetName, 'Personale_Presenze') then
          // begin
            // Tools.AddFiltroMese(view, PersonaleScheda.GetDataSet(DataSetName));
            // Tools.AddFiltroAnnoSolare(view, PersonaleScheda.GetDataSet(DataSetName));
          // end
          // else
            // if SameText(DataSetName, 'Personale_Presenze_Libere') then
            // begin
              // Tools.AddFiltroMese(view, PersonaleScheda.GetDataSet(DataSetName));
              // Tools.AddFiltroAnnoSolare(view, PersonaleScheda.GetDataSet(DataSetName));
// 
              // view.AddAction(GeneraRilevamento, zDmImages.ImageList16).HideInCard;
              // view.InitToolActions;
            // end
            // else
              // if SameText(DataSetName, 'Timesheet_Elenco_Progetti_X_Risorsa') then
              // begin
                // Tools.AddFiltroMese(view, PersonaleScheda.GetDataSet(DataSetName));
                // Tools.AddFiltroAnnoSolare(view, PersonaleScheda.GetDataSet(DataSetName));
              // end;
    // sono prese da Timesheet_Elenco_Progetti_X_Risorsa
    // else
    // if SameText(DataSetName, 'Timesheet_Mensile') then
    // begin
    // Tools.AddFiltroMese(view, PersonaleScheda.GetDataSet(DataSetName));
    // Tools.AddFiltroAnnoSolare(view, PersonaleScheda.GetDataSet(DataSetName));
    // end
    // else
    // if SameText(DataSetName, 'Timesheet_Mensile_A_Colonne') then
    // begin
    // Tools.AddFiltroMese(view, PersonaleScheda.GetDataSet(DataSetName));
    // Tools.AddFiltroAnnoSolare(view, PersonaleScheda.GetDataSet(DataSetName));
    // end
    // else
    // if SameText(DataSetName, 'Timesheet_Mensile_Mattina_Pomeriggio') then
    // begin
    // Tools.AddFiltroMese(view, PersonaleScheda.GetDataSet(DataSetName));
    // Tools.AddFiltroAnnoSolare(view, PersonaleScheda.GetDataSet(DataSetName));
    // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormPersonaleScheda.RilevamentoOreExecute(Sender: TObject);
const
  DataSetName = 'Personale_Rilevamento_Ore';
var
  view: TzDbView;
begin
  inherited;
  SelectedDataSetName := DataSetName;
  view := GetView(DataSetName);

  if Assigned(view) then
    view.ShowRecord(true);
end;

procedure TFormPersonaleScheda.GeneraRilevamentoExecute(Sender: TObject);
var
  viewRilevamenti: TzDbView;
  viewPresenze: TzDbView;
  presenze: TList<integer>;
begin
  inherited;

  viewPresenze := GetView('Personale_Presenze_Libere');
  viewRilevamenti := GetView('Ore_Rilevate_Elenco');

  if viewPresenze.SelectedCount = 1 then
  begin

    if Assigned(viewRilevamenti) then
      if PersonaleScheda.GeneraRilevamentoDaOraLibera then
        viewRilevamenti.ShowRecord(False)
  end
  else
  begin
    presenze := TList<integer>.Create;
    try
      viewPresenze.GetSelectedRows('ID_PRESENZA_LIBERA', presenze);
      PersonaleScheda.GeneraRilevamentiMultipli(presenze);
    finally
      FreeAndNil(presenze);
    end;
  end;
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

procedure TFormPersonaleScheda.IsDebugExecute(Sender: TObject);
begin
  inherited;
  // IsDebug.Checked := not IsDebug.Checked;
  PersonaleScheda.IsDebug := IsDebug.Checked;
end;

procedure TFormPersonaleScheda.IsDebugUpdate(Sender: TObject);
begin
  inherited;

  ActionUpdateAdmin(Sender);
  IsDebug.Checked := PersonaleScheda.IsDebug;
end;

end.
