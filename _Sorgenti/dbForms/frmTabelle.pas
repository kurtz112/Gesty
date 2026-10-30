unit frmTabelle;

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
  dxBar,
  dxBarExtItems,
  cxClasses,
  Vcl.ActnList,
  cxLabel,
  System.Actions,
  zFormController,
  zFileViewer,
  Base_DataModule,
  zDbView;

type
  TFormTabelle = class(TBaseForm)
    ActionList: TActionList;
    AggiungiContenuti: TAction;
    procedure AggiungiContenutiExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  FormTabelle: TFormTabelle;

implementation

uses
  dmTabelle,
  Files.Lib;
{$R *.dfm}

procedure TFormTabelle.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Tabelle';
  Caption := 'Tabelle';
end;

procedure TFormTabelle.CreateDataModule;
begin
  inherited;
  CreateDM(TTabelle, Tabelle);
end;

procedure TFormTabelle.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Tabelle);
end;

procedure TFormTabelle.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Zz_Ambiti_Inserimento_Contenuti') then
    // begin
      // view.AddAction(AggiungiContenuti, zDmImages.ImageList16);
      // view.InitToolActions;
    // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormTabelle.AggiungiContenutiExecute(Sender: TObject);
begin
  inherited;
  Tabelle.AggiungiContenuti;
end;

end.
