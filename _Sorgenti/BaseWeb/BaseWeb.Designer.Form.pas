unit BaseWeb.Designer.Form;

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
  OkCancel,
  BaseWeb.Models,
  BaseWeb.Designer.Frame;

type
  TBaseWebDesignerForm = class(TForm)
    OkCancel: TOkCancel;
  private
    BaseWebDesignerFrame: TBaseWebDesignerFrame;
  public
    constructor Create(aOwner: TComponent); override;
    function EditDataSet(var DatasetStruct: TBaseWebDatasetStructure): boolean;
  end;

function BaseWebEditDataSet(var DatasetStruct: TBaseWebDatasetStructure): boolean;

implementation

{$R *.dfm}

function BaseWebEditDataSet(var DatasetStruct: TBaseWebDatasetStructure): boolean;
var
  BaseWebDesignerForm: TBaseWebDesignerForm;
begin
  Application.CreateForm(TBaseWebDesignerForm, BaseWebDesignerForm);
  try
    result := BaseWebDesignerForm.EditDataSet(DatasetStruct);
  finally
    FreeAndNil(BaseWebDesignerForm);
  end;
end;

constructor TBaseWebDesignerForm.Create(aOwner: TComponent);
begin
  inherited;
  BaseWebDesignerFrame := TBaseWebDesignerFrame.Create(Self);
  BaseWebDesignerFrame.Parent := Self;
  BaseWebDesignerFrame.Align := alClient;
end;

function TBaseWebDesignerForm.EditDataSet(var DatasetStruct: TBaseWebDatasetStructure): boolean;
begin

  Caption := DatasetStruct.Dataset.Dataset;

  BaseWebDesignerFrame.LoadDataset(DatasetStruct);

  result := ShowModal = mrOk;

  if result then
    BaseWebDesignerFrame.SaveDataset(DatasetStruct);
end;

end.
