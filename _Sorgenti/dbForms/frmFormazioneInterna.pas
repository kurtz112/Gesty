unit frmFormazioneInterna;

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
  cxLabel;

type
  TFormFormazioneInterna = class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormFormazioneInterna: TFormFormazioneInterna;

implementation

uses
  zDm_Images,
  dmFormazioneInterna;

{$R *.dfm}

procedure TFormFormazioneInterna.CreateDataModule;
begin
  inherited;
  CreateDM(TFormazioneInterna, FormazioneInterna);
end;

procedure TFormFormazioneInterna.DestroyDataModule;
begin
  inherited;
  FreeAndNil(FormazioneInterna);
end;

constructor TFormFormazioneInterna.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'FormazioneInterna';
  Caption := 'FormazioneInterna';
end;

procedure TFormFormazioneInterna.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Progetti_Elenco') then
    // begin
      // Tools.AddFiltroEnte(view, FormazioneInterna.GetDataSet(DataSetName));
      // Tools.AddFiltroAnnoFormativo(view, FormazioneInterna.GetDataSet(DataSetName));
// 
      // view.AddAction(Autorizza, zDmImages.ImageList16);
      // view.InitToolActions;
    // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

end.
