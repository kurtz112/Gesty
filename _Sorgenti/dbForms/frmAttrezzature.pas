unit frmAttrezzature;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxLabel,
  BaseFrm,
  zFileViewer,
  Vcl.StdActns,
  dxFileActions;

type
  TFormAttrezzature = class(TBaseForm)
    ActionList: TActionList;
    InviaMail: TAction;
    procedure FormCreate(Sender: TObject);
    procedure InviaMailExecute(Sender: TObject);
  private
  protected
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  FormAttrezzature: TFormAttrezzature;

implementation

uses
  cxFilter,
  dmAttrezzature,
  zDbView,
  Files.Lib;

{$R *.dfm}

procedure TFormAttrezzature.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Risorse_Dotazioni') then
    // begin
      // view.AddAction(InviaMail, zDmImages.ImageList16);
      // view.InitToolActions;
    // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormAttrezzature.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Attrezzature';
  ReportGroup := 'Attrezzature';
end;

procedure TFormAttrezzature.CreateDataModule;
begin
  inherited;
  CreateDM(TAttrezzature, Attrezzature);
end;

procedure TFormAttrezzature.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Attrezzature);
end;

procedure TFormAttrezzature.InviaMailExecute(Sender: TObject);
begin
  inherited;
  Attrezzature.InviaMail;
end;

end.
