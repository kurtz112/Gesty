unit frmInterventiIntegrativi;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  zDbView,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  dxLayoutcxEditAdapters,
  dxLayoutContainer,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBExtLookupComboBox,
  dxLayoutControl;

type
  TFormInterventiIntegrativi = class(TBaseForm)
    Actions: TActionList;
    Firma: TAction;
    Precedente: TAction;
    Successiva: TAction;
    Salva: TAction;
    Oggi: TAction;
    VaiAlGiorno: TAction;
    dxLayoutControl: TdxLayoutControl;
    dxBarDockControl: TdxBarDockControl;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutGrouptoolbar: TdxLayoutGroup;
    dxLayoutItemBar: TdxLayoutItem;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    edDocente: TcxExtLookupComboBox;
    dxLayoutItemFormatore: TdxLayoutItem;

    dxBarManagerBar: TdxBar;
    dxBarButtonPermessiAzione: TdxBarButton;
    dxBarButtonOggi: TdxBarButton;
    dxBarButtonVaiAlGiorno: TdxBarButton;
    dxBarButtonPrecedente: TdxBarButton;
    dxBarButtonSuccessiva: TdxBarButton;
    dxBarButtonSalva: TdxBarButton;
    dxBarButtonFirma: TdxBarButton;
    AggiungiStudenti: TAction;
    GeneraRilevamento: TAction;
    GeneraIncarico: TAction;
    procedure AggiungiStudentiExecute(Sender: TObject);
    procedure OggiExecute(Sender: TObject);
    procedure PrecedenteExecute(Sender: TObject);
    procedure SuccessivaExecute(Sender: TObject);
    procedure VaiAlGiornoExecute(Sender: TObject);
    procedure edDocentePropertiesEditValueChanged(Sender: TObject);
    procedure GeneraIncaricoExecute(Sender: TObject);
    procedure GeneraRilevamentoExecute(Sender: TObject);
  private
    function GetDataLezione: TDateTime;
    procedure SetDataLezione(const Value: TDateTime);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure AfterCreateControls; override;
  public
    constructor Create(aOwner: TComponent); override;
  public
    // property IdProgetto: integer;
    // property IdFormatore: integer;
    property DataLezione: TDateTime read GetDataLezione write SetDataLezione;
  end;

var
  FormInterventiIntegrativi: TFormInterventiIntegrativi;

implementation

uses
  System.DateUtils,
  zDm_Images,
  dmInterventiIntegrativi,
  zDX,
  zMsg;

{$R *.dfm}

procedure TFormInterventiIntegrativi.CreateDataModule;
begin
  inherited;
  CreateDM(TInterventiIntegrativi, InterventiIntegrativi);
end;

procedure TFormInterventiIntegrativi.DestroyDataModule;
begin
  inherited;
  FreeAndNil(InterventiIntegrativi);
end;

constructor TFormInterventiIntegrativi.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'Interventi Integrativi';
  Caption := 'Interventi Integrativi';

  dxLayoutControl.Visible := False;
  dxLayoutControl.Parent := Self;

  dx.InitBar(dxBarManagerBar);
  dx.InitLayoutControl(dxLayoutControl);
  dxLayoutControl.Height := 80;

  dx.InitLookup('', edDocente, InterventiIntegrativi.lkDocenti, InterventiIntegrativi.lkDocentiSrc, 'ID_RISORSA', 'NOMINATIVO_O_RAGIONE_SOCIALE;ID_RISORSA');

  VaiAlGiorno.Caption := DateToStr(DataLezione);
end;

procedure TFormInterventiIntegrativi.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(dxLayoutControl, 'FiltriAndToolbar', False);
end;

procedure TFormInterventiIntegrativi.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'InterventiIntegrativi') then
    // begin
      // view.AddAction(GeneraIncarico, zDmImages.ImageList16);
      // view.AddAction(GeneraRilevamento, zDmImages.ImageList16);
      // view.InitToolActions;
    // end
    // else
      // if SameText(DataSetName, 'Presenze') then
      // begin
        // view.AddAction(AggiungiStudenti, zDmImages.ImageList16);
        // view.InitToolActions;
      // end
      // else
        // if SameText(DataSetName, 'Riepilogo') then
        // begin
          // Tools.AddFiltroAnnoFormativo(view, InterventiIntegrativi.GetDataSet(DataSetName));
        // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormInterventiIntegrativi.SetDataLezione(const Value: TDateTime);
begin
  InterventiIntegrativi.DataLezione := Value;
  VaiAlGiorno.Caption := DateToStr(DataLezione);
end;

function TFormInterventiIntegrativi.GetDataLezione: TDateTime;
begin
  Result := InterventiIntegrativi.DataLezione;
end;

procedure TFormInterventiIntegrativi.OggiExecute(Sender: TObject);
begin
  inherited;

  if InterventiIntegrativi.CloseQuery then
    DataLezione := IncDay(DataLezione, -1);
end;

procedure TFormInterventiIntegrativi.PrecedenteExecute(Sender: TObject);
begin
  inherited;

  if InterventiIntegrativi.CloseQuery then
    DataLezione := IncDay(DataLezione, -1);
end;

procedure TFormInterventiIntegrativi.SuccessivaExecute(Sender: TObject);
begin
  inherited;

  if InterventiIntegrativi.CloseQuery then
    DataLezione := IncDay(DataLezione, +1);
end;

procedure TFormInterventiIntegrativi.VaiAlGiornoExecute(Sender: TObject);
var
  Data: TDate;
begin
  inherited;

  if not InterventiIntegrativi.CloseQuery then
    exit;

  Data := DataLezione;

  if zMsg.InputDate('Seleziona data', 'Seleziona data', Data) then
    DataLezione := Data;
end;

procedure TFormInterventiIntegrativi.edDocentePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if VarIsNull(edDocente.EditValue) then
    InterventiIntegrativi.IdDocente := -1
  else
    InterventiIntegrativi.IdDocente := edDocente.EditValue;
end;

procedure TFormInterventiIntegrativi.AggiungiStudentiExecute(Sender: TObject);
begin
  inherited;
  InterventiIntegrativi.AggiungiStudenti;
end;

procedure TFormInterventiIntegrativi.GeneraIncaricoExecute(Sender: TObject);
begin
  inherited;
  InterventiIntegrativi.GeneraIncarico;
end;

procedure TFormInterventiIntegrativi.GeneraRilevamentoExecute(Sender: TObject);
begin
  inherited;
  InterventiIntegrativi.GeneraRilevamento;
end;

end.
