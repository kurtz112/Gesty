unit frmRilevamenti;

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
  BaseWebFrm,
  DevExtreme.Data,
  Vcl.Controls,
  DevExtreme.Types,
  DevExtreme.CustomControl,
  DevExtreme.DataGrid.JS,
  DevExtreme.DataGrid,
  DevExtreme.List,
  DevExtreme.Button,
  Vcl.StdCtrls,
  WEBLib.StdCtrls,
  WEBLib.WebCtrls;

type
  TFormRilevamenti = class(TBaseWebForm)
    Rilevamenti: TjdxDataSource;
    btnTest: TjdxButton;
  private
    grid: TdxDataGrid;
  public
    [async]
    procedure AfterCreate(const id: integer = -1); override;
  end;

var
  FormRilevamenti: TFormRilevamenti;

implementation

uses
  DevExtreme.factory;

{$R *.dfm}

procedure TFormRilevamenti.AfterCreate(const id: integer = -1);
begin
  inherited;

  Rilevamenti.load();
  dxFactory.DataGrid('#gridRilevamenti', Rilevamenti, grid);
end;

end.
