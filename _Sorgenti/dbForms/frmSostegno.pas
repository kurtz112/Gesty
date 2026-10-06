unit frmSostegno;

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
  TFormSostegno = class(TBaseForm)
    Actions: TActionList;
    Firma: TAction;
    Precedente: TAction;
    Successiva: TAction;
    Salva: TAction;
    Oggi: TAction;
    VaiAlGiorno: TAction;
    dxLayoutControl: TdxLayoutControl;
    edProgetto: TcxExtLookupComboBox;
    edCorso: TcxExtLookupComboBox;
    dxBarDockControl: TdxBarDockControl;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutItemProgetto: TdxLayoutItem;
    dxLayoutGrouptoolbar: TdxLayoutGroup;
    dxLayoutItemCorso: TdxLayoutItem;
    dxLayoutGroupProgetto: TdxLayoutGroup;
    dxLayoutSplitterItem1: TdxLayoutSplitterItem;
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
    dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    AggiungiStudenti: TAction;
    GeneraRilevamento: TAction;
    GeneraIncarico: TAction;
    procedure AggiungiStudentiExecute(Sender: TObject);
    procedure OggiExecute(Sender: TObject);
    procedure PrecedenteExecute(Sender: TObject);
    procedure SuccessivaExecute(Sender: TObject);
    procedure VaiAlGiornoExecute(Sender: TObject);
    procedure edProgettoPropertiesEditValueChanged(Sender: TObject);
    procedure edCorsoPropertiesEditValueChanged(Sender: TObject);
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
  FormSostegno: TFormSostegno;

implementation

uses
  System.DateUtils,
  zDm_Images,
  dmSostegno,
  zdx,
  zMsg,
   
  ConfigModule;

{$R *.dfm}

procedure TFormSostegno.CreateDataModule;
begin
  inherited;
  CreateDM(TSostegno, Sostegno);
end;

procedure TFormSostegno.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Sostegno);
end;

constructor TFormSostegno.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'Sostegno';
  Caption := 'Sostegno';

  dxLayoutControl.Visible := False;
  dxLayoutControl.Parent := Self;

  dx.InitBar(dxBarManagerBar);

  dx.InitLookup('', edProgetto, Sostegno.lkProgetti, Sostegno.lkProgettiSrc, 'ID_PROGETTO', 'DENOMINAZIONE_PROGETTO;ANNO_FORMATIVO');
  dx.InitLookup('', edCorso, Sostegno.lkCorsi, Sostegno.lkCorsiSrc, 'ID_CORSO', 'IDENTIFICATIVO_CORSO;ID_CORSO');
  dx.InitLookup('', edDocente, Sostegno.lkDocenti, Sostegno.lkDocentiSrc, 'ID_RISORSA', 'NOMINATIVO_O_RAGIONE_SOCIALE;ID_RISORSA');

  VaiAlGiorno.Caption := DateToStr(DataLezione);
end;

procedure TFormSostegno.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(dxLayoutControl, 'FiltriAndToolbar', False);
end;

procedure TFormSostegno.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Ore_Sostegno') then
    // begin
      // view.AddAction(GeneraIncarico, zDmImages.ImageList16);
      // view.AddAction(GeneraRilevamento, zDmImages.ImageList16);
      // view.InitToolActions;
    // end
    // else
      // if SameText(DataSetName, 'Studenti_Presenze_Sostegno') then
      // begin
        // view.AddAction(AggiungiStudenti, zDmImages.ImageList16);
        // view.InitToolActions;
      // end
      // else
        // if SameText(DataSetName, 'Studenti_Sostegno_Riepilogo') then
        // begin
          // Tools.AddFiltroAnnoFormativo(view, Sostegno.GetDataSet(DataSetName));
        // end
        // else
          // if SameText(DataSetName, 'Studenti_Sostegno_Riepilogo_Annuale') then
          // begin
            // Tools.AddFiltroAnnoFormativo(view, Sostegno.GetDataSet(DataSetName));
          // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormSostegno.SetDataLezione(const Value: TDateTime);
begin
  Sostegno.DataLezione := Value;
  VaiAlGiorno.Caption := DateToStr(DataLezione);
end;

function TFormSostegno.GetDataLezione: TDateTime;
begin
  Result := Sostegno.DataLezione;
end;

procedure TFormSostegno.OggiExecute(Sender: TObject);
begin
  inherited;

  if Sostegno.CloseQuery then
    DataLezione := Date;
end;

procedure TFormSostegno.PrecedenteExecute(Sender: TObject);
begin
  inherited;

  if Sostegno.CloseQuery then
    DataLezione := IncDay(DataLezione, -1);
end;

procedure TFormSostegno.SuccessivaExecute(Sender: TObject);
begin
  inherited;

  if Sostegno.CloseQuery then
    DataLezione := IncDay(DataLezione, +1);
end;

procedure TFormSostegno.VaiAlGiornoExecute(Sender: TObject);
var
  Data: TDate;
begin
  inherited;

  if not Sostegno.CloseQuery then
    exit;

  Data := DataLezione;

  if zMsg.InputDate('Seleziona data', 'Seleziona data', Data) then
    DataLezione := Data;
end;

procedure TFormSostegno.edProgettoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if VarIsNull(edProgetto.EditValue) then
    Sostegno.IdProgetto := -1
  else
    Sostegno.IdProgetto := edProgetto.EditValue;

  edCorso.Clear;
  Sostegno.IdCorso := -1
end;

procedure TFormSostegno.edCorsoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if VarIsNull(edCorso.EditValue) then
    Sostegno.IdCorso := -1
  else
    Sostegno.IdCorso := edCorso.EditValue;
end;

procedure TFormSostegno.edDocentePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if VarIsNull(edDocente.EditValue) then
    Sostegno.IdDocente := -1
  else
    Sostegno.IdDocente := edDocente.EditValue;
end;

procedure TFormSostegno.AggiungiStudentiExecute(Sender: TObject);
begin
  inherited;
  Sostegno.AggiungiStudenti;
end;

procedure TFormSostegno.GeneraIncaricoExecute(Sender: TObject);
begin
  inherited;
  Sostegno.GeneraIncarico;
end;

procedure TFormSostegno.GeneraRilevamentoExecute(Sender: TObject);
begin
  inherited;
  Sostegno.GeneraRilevamento;
end;

end.
