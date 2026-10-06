unit frmFbExpert;

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
  zDbView,
  zFBExpert.Frame,
  dxUIAClasses;

type
  TFormFbExpert = class(TBaseForm)
    zFBExpertFrame: TzFBExpertFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  FormFbExpert: TFormFbExpert;

implementation

uses
  zDm_Images,
  ConfigModule,
  dmFbExpert;

{$R *.dfm}

procedure TFormFbExpert.CreateDataModule;
begin
  inherited;
  CreateDM(TFbExpert, FbExpert);
end;

procedure TFormFbExpert.DestroyDataModule;
begin
  inherited;
  FreeAndNil(FbExpert);
end;

procedure TFormFbExpert.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'FbExpert';
  Caption := 'FbExpert';

  EnterAsTab := false;
end;

procedure TFormFbExpert.FormShow(Sender: TObject);
begin
  inherited;
  zFBExpertFrame.Init(Config.zSystem, Config.Database, FbExpert.ReadTrans, FbExpert.WriteTrans, FbExpert.DataSet, Config.zSystem.MetaData);
end;

end.
