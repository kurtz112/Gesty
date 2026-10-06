unit BaseWebFrm;

interface

uses
  System.SysUtils,
  System.Classes,
  JS,
  Web,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  BaseWebCustomFrm;

type
  TBaseWebForm = class(TBaseWebCustomForm)
  public
    procedure AfterCreate(const id: integer = -1); overload; virtual;
  end;

var
  BaseWebForm: TBaseWebForm;

implementation

{$R *.dfm}

procedure TBaseWebForm.AfterCreate(const id: integer = -1);
begin
  inherited AfterCreate;
end;

end.
