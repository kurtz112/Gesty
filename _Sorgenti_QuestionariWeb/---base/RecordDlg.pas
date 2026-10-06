unit RecordDlg;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  Web,
  libjquery,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  BaseWebFrm,
  BaseWebModalFrm,
  BaseWebDialogFrm,
  DevExtreme;

type
  TRecordDialog = class(TBaseWebDialogForm)
  private
    procedure onFieldDataChanged(e: TJSObject);
  private
  public
    readOnly: boolean;
    meta: TJSObject;
    rec: TJSObject;
    OkProc: TProc;
  protected
    procedure doOk; override;
    function DefaultWidth: integer; override;
  public
    procedure AfterCreate(const id: integer; data: TJSObject; OkProc: TProc); override;
  public
  end;

var
  RecordDialog: TRecordDialog;

implementation

uses
  System.Math,
  DevExtreme.Types,
  DevExtreme.Form,
  DevExtreme.Datagrid,
  AppController;

{$R *.dfm}

procedure TRecordDialog.AfterCreate(const id: integer; data: TJSObject; OkProc: TProc);
var
  card: TJSObject;
  options: TJSObject;
  items: TJSArray;
  cardId: String;
  titolo: string;
begin
  inherited;
  CreateHEADER('Scheda');

  // recuperare cardId da meta
  readOnly := JS.TOBoolean(data['readOnly']);
  meta := JS.TOObject(data['meta']);
  rec := JS.TOObject(data['rec']);
  OkProc := OkProc;

  card := TJSObject(TJSArray(meta['Cards'])[0]);
  cardId := JS.ToString(card['DataSetName']);
  titolo := JS.ToString(card['Caption']);
  JQuery('#Titolo').html(titolo);

  // copiarli in un nuovo insieme
  items := TJSArray(card['FormItems']);

  options := dxFormOptions(cardId, rec);
  options['colCount'] := 1;
  options['items'] := items;
  options['labelLocation'] := 'left';
  options['onFieldDataChanged'] := @onFieldDataChanged;
  options['readOnly'] := readOnly;

  CreateModalForm('Record', options);
  // focus sul primo campo Form.FocusEditor('InvioTramiteMail');

  CreateOkCancel('Ok', 'Annulla');
end;

procedure TRecordDialog.onFieldDataChanged(e: TJSObject);
var
  j: JSValue;
begin
  j := dxModalForm.validate;

  if dx.validation.isValid(j) then
    dxModalForm.ButtonEnabled('btnOk', True)
  else
    dxModalForm.ButtonEnabled('btnOk', false);
end;

function TRecordDialog.DefaultWidth: integer;
begin
  result := 500;
end;


procedure TRecordDialog.doOk;
var
  j: JSValue;
begin
  j := dxModalForm.validate;

  if dx.validation.isValid(j) then
    inherited
  else
    DisplayError('Errore', dx.validation.ErrorMessage(j));
end;


function _dxShowRecord(rec: TJSObject; readOnly: boolean; meta: TJSObject; OkProc: TProc): boolean;
var
  data: TJSObject;
begin
  data := TJSObject.new;
  data['meta'] := meta;
  data['rec'] := rec;
  data['readOnly'] := readOnly;

  Controller.Utils.ShowRecord(data, OkProc);
end;

initialization

dxShowRecord := _dxShowRecord;

end.
