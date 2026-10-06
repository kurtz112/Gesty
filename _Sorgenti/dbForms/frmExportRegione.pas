unit frmExportRegione;

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
  zFormController,
  zFileViewer,
  zDbView,
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
  dxLayoutControl;

type
  TFormExportRegione = class(TBaseForm)
    ActionList: TActionList;
    Esporta: TdxFileSaveAs;
    Apri: TAction;
    LayoutExportRegione: TdxLayoutControl;
    edDalGiorno: TcxDateEdit;
    edAlGiorno: TcxDateEdit;
    btnApriExport: TcxButton;
    btnExportRegione: TcxButton;
    LayoutExportRegioneGroup_Root: TdxLayoutGroup;
    dxLayoutItemDalGiorno: TdxLayoutItem;
    dxLayoutItemAlGiorno: TdxLayoutItem;
    dxLayoutItemApriExport: TdxLayoutItem;
    dxLayoutItemExportRegione: TdxLayoutItem;
    procedure ApriExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edDalGiornoPropertiesEditValueChanged(Sender: TObject);
    procedure EsportaAccept(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure AfterCreateControls; override;
  public
  end;

var
  FormExportRegione: TFormExportRegione;

implementation

uses
  System.DateUtils,
  zDX,
  dmExportRegione;

{$R *.dfm}

procedure TFormExportRegione.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'ExportRegione';
  Caption := 'Export Regione';

  dx.InitLayoutControl(LayoutExportRegione);
end;

procedure TFormExportRegione.CreateDataModule;
begin
  inherited;
  CreateDM(TExportRegione, ExportRegione);
end;

procedure TFormExportRegione.DestroyDataModule;
begin
  inherited;
  FreeAndNil(ExportRegione);
end;

procedure TFormExportRegione.edDalGiornoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  edAlGiorno.Date := EndOfTheWeek(edDalGiorno.Date);
end;

procedure TFormExportRegione.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(LayoutExportRegione, 'LayoutExportRegione', False);
end;

procedure TFormExportRegione.ApriExecute(Sender: TObject);
begin
  inherited;
  ExportRegione.ApriExportRegione(edDalGiorno.Date, edAlGiorno.Date);
end;

procedure TFormExportRegione.EsportaAccept(Sender: TObject);
begin
  inherited;
  ExportRegione.Esporta(Esporta.Dialog.Filename);
end;

end.
