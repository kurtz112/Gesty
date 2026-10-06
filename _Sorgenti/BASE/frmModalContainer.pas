unit frmModalContainer;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs;

type
  TFormModalContainer = class(TForm)
  private
    { Private declarations }
  public
    procedure ModalShow(const Caption: string; Control: TWinControl);
  end;

procedure ModalContainerShow(const Caption: string; Control: TWinControl);

implementation

{$R *.dfm}
{ TFormModalContainer }

procedure ModalContainerShow(const Caption: string; Control: TWinControl);
var
  FormModalContainer: TFormModalContainer;
begin
  Application.CreateForm(TFormModalContainer, FormModalContainer);
  try
    FormModalContainer.ModalShow(Caption, Control);
  finally
    FreeAndNil(FormModalContainer);
  end;
end;

procedure TFormModalContainer.ModalShow(const Caption: string; Control: TWinControl);
var
  OldParent: TWinControl;
  OldAlign: TAlign;
begin
  //
  OldParent := Control.Parent;
  OldAlign := Control.Align;
  //
  Control.Parent := Self;
  Control.Align := alClient;
  try
    WindowState := wsMaximized;
    ShowModal;
  finally
    Control.Parent := OldParent;
    Control.Align := OldAlign;
  end;
  //
end;

end.
