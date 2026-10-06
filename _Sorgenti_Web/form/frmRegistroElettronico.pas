unit frmRegistroElettronico;

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
  DevExtreme.Data,
  DevExtreme.CustomControl,
  DevExtreme.Button,
  DevExtreme.DataGrid,
  DevExtreme.DataGrid.JS,
  DevExtreme.Form,
  DevExtreme.Form.JS,
  BaseWebFrm;

type
  TFormRegistroElettronico = class(TBaseWebForm)
    Lezione: TjdxDataSource;
    Presenze: TjdxDataSource;
    btnTest: TjdxButton;
    btnSuccessiva: TjdxButton;
    btnPrecedente: TjdxButton;
    btnSalva: TjdxButton;
    function btnPrecedenteClick(e: TJSObject): Boolean;
    function btnSalvaClick(e: TJSObject): Boolean;
    function btnSuccessivaClick(e: TJSObject): Boolean;
    function btnTestClick(e: TJSObject): Boolean;
  private
    formLezione: TdxForm;
    gridPresenze: TdxDataGrid;
  private
    procedure InitButtons;
  public
    [async]
    procedure AfterCreate(const id: integer = -1); override;
  end;

var
  FormRegistroElettronico: TFormRegistroElettronico;

implementation

uses
  DevExtreme.utils,
  DevExtreme.factory,
  DevExtreme.Options;

{$R *.dfm}

procedure TFormRegistroElettronico.AfterCreate(const id: integer = -1);
var
  Options: TJSObject;

  fields: TJSArray;
  o: TJSObject;
begin
  inherited;
  InitButtons;

  dxFactory.Form('#formLezione', Lezione, formLezione)._then(
    function(aValue: JSValue): JSValue
    begin
      Lezione.load()._then(
        function(aValue: JSValue): JSValue
        var
          a: TJSArray;
          Data: JSValue;
        begin
          console.log('Lezione');
          console.log(aValue);

          a := JS.toArray(aValue);
          Data := a[0];
          console.log(Data);

          formLezione.option('formData', Data);
        end);
    end);

  /// /////////////////////////////////////////////

  Presenze.load();
  dxFactory.DataGrid('#gridPresenze', Presenze, gridPresenze);
end;

function TFormRegistroElettronico.btnPrecedenteClick(e: TJSObject): Boolean;
begin
  inherited;
  ShowMessage('RegistroElettronico', 'Precedente');
end;

function TFormRegistroElettronico.btnSuccessivaClick(e: TJSObject): Boolean;
begin
  inherited;
  ShowMessage('RegistroElettronico', 'Successiva');
end;

function TFormRegistroElettronico.btnSalvaClick(e: TJSObject): Boolean;
begin
  inherited;
  ShowMessage('RegistroElettronico', 'Salva');
end;

function TFormRegistroElettronico.btnTestClick(e: TJSObject): Boolean;
begin
  inherited;
  ShowMessage('RegistroElettronico', 'Test');
end;

procedure TFormRegistroElettronico.InitButtons;
begin
  btnPrecedente.icon := 'fa-solid fa-arrow-left';
  btnSuccessiva.icon := 'fa-solid fa-arrow-right';
  btnSalva.icon := 'fa-solid fa-floppy-disk';
end;

end.

  btnSalva

  icon: 'fa fa-envelope-o',
