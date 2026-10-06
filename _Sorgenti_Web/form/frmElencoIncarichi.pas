unit frmElencoIncarichi;

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
  Vcl.StdCtrls,
  WEBLib.StdCtrls,
  Vcl.Controls,
  WEBLib.WebCtrls,
  DevExtreme.Types,
  DevExtreme.Data,
  DevExtreme.CustomControl,
  DevExtreme.Button,
  DevExtreme.DataGrid,
  DevExtreme.DataGrid.JS,
  DevExtreme.FilterBuilder,
  DevExtreme.FilterBuilder.JS,
  BaseWebFrm;

type
  TFormElencoIncarichi = class(TBaseWebForm)
    ElencoIncarichi: TjdxDataSource;
    filterElencoIncarichi: TWebHTMLDiv;
    apply: TjdxButton;
    btnTest: TjdxButton;
    function applyClick(e: TJSObject): Boolean;
    function btnTestClick(e: TJSObject): Boolean;
  private
    grid: TdxDataGrid;
    Filter: TdxFilterBuilder;
  public
    [async]
    procedure AfterCreate(const id: integer = -1); override;

  private
  end;

var
  FormElencoIncarichi: TFormElencoIncarichi;

implementation

uses
  DevExtreme.base,
  DevExtreme.factory,
  DevExtreme.Options;

{$R *.dfm}

procedure TFormElencoIncarichi.AfterCreate(const id: integer = -1);
begin
  inherited;

  ElencoIncarichi.load()._then(
    function(aValue: JSValue): JSValue
    begin
    end);

  dxFactory.DataGrid('#gridElencoIncarichi', ElencoIncarichi, grid)._then(
    function(aValue: JSValue): JSValue
    var
      Options: TJSObject;
      fields: TJSArray;
    begin
      fields := grid.columns;
      Options := new([]);
      Options['fields'] := fields;
      Filter := dxFactory.FilterBuilder('#filterElencoIncarichi', Options);
    end);
end;

function TFormElencoIncarichi.applyClick(e: TJSObject): Boolean;
var
  FilterValue: JSValue;
begin
  FilterValue := Filter.option('value');
  grid.option('filterValue', FilterValue);
end;

function TFormElencoIncarichi.btnTestClick(e: TJSObject): Boolean;
begin
  inherited;
  ShowMessage('ElencoIncarichi', 'Test');
end;

end.
