unit AdminDM;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  WEBLib.Modules,
  WEBLib.JSON,
  js,
  web,
  BaseWebFrm,
  zz.web.user,
  zz.web.JsonResponse;

type
  TDataCallBack = reference to procedure(data: TJSArray);

  TAdmin = class(TWebDataModule)
  private
    procedure SaveToStorage;
    procedure LoadFromStorage;
    procedure ClearStorage;
  private
    procedure LoadConfig;
    procedure DisplayError(const title, msg: string; proc: TProc = nil);
  public
    constructor Create(aOwner: TComponent); override;

    procedure StartApplication;

    procedure Login(Const UserName: string; Const Password: string; const RestaConnesso: boolean);
    Procedure Logout;
    procedure ComuniAbilitati(callback: TDataCallBack);
    procedure RichiestaRegistrazione(const CodiceCliente, eMail, UserName, Password, CodiceFiscale, Belfiore: string; callback: TProc);
    procedure ConfermaRegistrazione(const token: string);
    procedure RecuperaUsername(const eMail: string);
    procedure RecuperaPassword(const UserName, eMail: string; callback: TProc);
    procedure ModificaPassword(const PasswordCorrente, NuovaPassword: string; callback: TProc);
    function PasswordStrength(const Password: string): integer;
    //
    procedure SaveUserTheme;
  end;

var
  Admin: TAdmin;

implementation

uses
  StrUtils,
  Dialogs,
  WEBLib.Forms,
  WEBLib.Storage,
  libjquery,
  zz.web.url,
  zz.web.js,
  zz.web.fetch,
  DevExtreme.utils,
  BaseWebFrmController,
  AppController,
  DevExtreme.themes,
  zz.web.DataRequest;

{$R *.dfm}

constructor TAdmin.Create(aOwner: TComponent);
begin
  inherited;
  TUrl.jwt := '';
  user.Clear;
end;

procedure TAdmin.SaveToStorage;
begin
  user.SaveToStorage;
  // jwt
  TLocalStorage.setValue('Token', TUrl.jwt);
end;

procedure TAdmin.LoadFromStorage;
begin
  user.Clear;
  TUrl.jwt := '';

  try
    user.LoadFromStorage;

    // jwt
    TUrl.jwt := TLocalStorage.getValue('Token');

    if user.DarkTheme then
      TdxThemes.SetThemeDark
    else
      TdxThemes.SetThemeLight;
  except
    user.ClearStorage;
  end;
end;

procedure TAdmin.ClearStorage;
begin
  // user
  user.ClearStorage;

  // jwt
  TLocalStorage.RemoveKey('Token');
end;

procedure TAdmin.Login(Const UserName: string; Const Password: string; const RestaConnesso: boolean);
var
  Params: TStringList;
  PostData: string;
begin
  TUrl.jwt := '';
  user.Clear;
  user.UserName := UserName;

  Params := TStringList.Create;
  try
    Params.AddPair('app', zz.web.DataRequest.__app);
    Params.AddPair('user', UserName);
    Params.AddPair('pwd', Password);
    PostData := Params.Text;
  finally
    FreeAndNil(Params);
  end;

  /// ///////////////////////////////////////////////////

  fetch(TUrl.Login, PostData)._then(
    function(aValue: JSValue): JSValue
    var
      o: TJSObject;
      s: string;
    begin
      o := js.toObject(aValue);

      user.UserID := js.ToInteger(o['USER_ID']);
      user.Nominativo := js.ToString(o['NOMINATIVO']);
      user.TipoUser.AsString := js.ToString(o['TIPO_USER']);
      user.Onnipotente := js.ToBoolean(o['ADMIN_USER']);
      s := js.ToString(o['DATA_SCADENZA_PASSWORD']);
      user.DataScadenzaPassword := StrToDate(s, '/');
      user.IdSessione := js.ToInteger(o['ID_SESSIONE']);

      // JWT: serve anche per CambioPassword
      TUrl.jwt := js.ToString(o['JWT']);

      if user.PasswordScaduta then
        Controller.Admin.CambioPassword
      else
      begin
        if RestaConnesso then
          SaveToStorage;
        //

        LoadConfig; // chiama StartApp
      end;
    end,
    function(aValue: JSValue): JSValue
    var
      err: String;
    begin
      err := js.ToString(aValue);
      DisplayError('Login', err,
        procedure
        begin
          // riapre login
          Controller.Admin.Login;
        end);
    end);
end;

procedure TAdmin.Logout;
var
  PostData: string;
begin

  if TUrl.jwt.IsEmpty then // errore nel login, chiama nuovamente login
    Controller.Admin.Login
  else
  begin
    PostData := 'ID_SESSIONE=' + user.IdSessione.ToString;

    /// ///////////////////////////////////////////////////
    fetch(TUrl.Logout, PostData)._then(
      function(aValue: JSValue): JSValue
      begin
        TUrl.jwt := '';
        user.Clear;
        ClearStorage;
        BaseWebFormController.CloseActiveForm;
        Controller.Admin.Login;
      end,
      function(value: JSValue): JSValue
      var
        ErrorMsg: String;
      begin
        ErrorMsg := js.ToString(value);
        DisplayError('Logout', ErrorMsg);
      end);
  end;
end;

procedure TAdmin.LoadConfig;
var
  PostData: string;
begin
  PostData := 'ID_SESSIONE=' + user.IdSessione.ToString;

  fetch(TUrl.WebConfig, PostData)._then(
    function(aValue: JSValue): JSValue
    var
      o: TJSObject;
    begin
      o := js.toObject(aValue);
      user.IdRisorsa := js.ToInteger(o['ID_RISORSA']);
      user.AnnoFormativo := js.ToInteger(o['ANNO_FORMATIVO']);
      user.AnnoFormativoDesc := js.ToString(o['ANNO_FORMATIVO_DESC']);
      Controller.StartApplication;
    end,
    function(aValue: JSValue): JSValue
    var
      ErrorMsg: String;
    begin
      ErrorMsg := js.ToString(aValue);
      DisplayError('Load Config', ErrorMsg,
        procedure
        begin
          Controller.Admin.Login;
        end);
    end);
end;

procedure TAdmin.StartApplication;
var
  errore: string;
  Valido: boolean;
begin
  LoadFromStorage;

  if TUrl.jwt.IsEmpty then
    Controller.Admin.Login
  else
  begin
    fetch(TUrl.Check_JWT, '')._then(
      function(aValue: JSValue): JSValue
      var
        o: TJSObject;
      begin
        o := js.toObject(aValue);

        Valido := js.ToBoolean(o['Valido']);

        if Valido then
          LoadConfig
        else
        begin
          errore := js.ToString(o['Errore']);
          TdxUtils.Notify(errore);

          TUrl.jwt := '';
          Controller.Admin.Login;
        end;
      end,
      function(aValue: JSValue): JSValue
      var
        ErrorMsg: String;
      begin
        ErrorMsg := js.ToString(aValue);
        DisplayError('Start', ErrorMsg);
      end);
  end;
end;

procedure TAdmin.ComuniAbilitati(callback: TDataCallBack);
begin
  /// //////////
  Exit;
  /// //////////
end;

procedure TAdmin.RichiestaRegistrazione(

  const CodiceCliente, eMail, UserName, Password, CodiceFiscale, Belfiore: string; callback: TProc);
var
  Params: TStringList;
  PostData: string;
  ReqOptions: TJSObject;
  req: TJSRequest;
begin
  TUrl.jwt := '';
  user.Clear;
  user.UserName := UserName;

  Params := TStringList.Create;
  try
    Params.AddPair('app', 'WTWEB_SPORTELLO');
    Params.AddPair('idIntestatario', CodiceCliente);
    Params.AddPair('Username', UserName);
    Params.AddPair('Password', Password);
    Params.AddPair('eMail', eMail);
    Params.AddPair('Belfiore', Belfiore);
    Params.AddPair('CodiceFiscale', CodiceFiscale);
    PostData := Params.Text;
  finally
    FreeAndNil(Params);
  end;

  fetch(TUrl.RichiestaRegistrazione, PostData)._then(
    function(aValue: JSValue): JSValue
    var
      o: TJSObject;
      risultato: integer;
      descRisultato: string;
    begin
      o := js.toObject(aValue);

      risultato := js.ToInteger(o['Risultato']);
      descRisultato := js.ToString(o['DescRisultato']);

      if risultato = 0 then
        callback
      else
        DisplayError('Registrazione', descRisultato);
    end,
    function(aValue: JSValue): JSValue
    var
      ErrorMsg: String;
    begin
      ErrorMsg := js.ToString(aValue);
      DisplayError('Richiesta Registrazione', ErrorMsg);
    end);
end;

procedure TAdmin.ConfermaRegistrazione(const token: string);
var
  PostData: string;
begin
  PostData := 'Token=' + token;

  fetch(TUrl.ConfermaRegistrazione, PostData)._then(
    function(aValue: JSValue): JSValue
    begin
      Controller.Admin.Login;
    end,
    function(aValue: JSValue): JSValue
    var
      ErrorMsg: String;
    begin
      ErrorMsg := js.ToString(aValue);
      DisplayError('Conferma Registrazione', ErrorMsg);
    end);
end;

procedure TAdmin.ModificaPassword(const PasswordCorrente, NuovaPassword: string; callback: TProc);
var
  Params: TStringList;
  PostData: string;
begin
  Params := TStringList.Create;
  try
    Params.AddPair('UserId', user.UserID.ToString);
    Params.AddPair('ID_SESSIONE', user.IdSessione.ToString);
    Params.AddPair('NewPassword', NuovaPassword);
    Params.AddPair('OldPassword', PasswordCorrente);
    PostData := Params.Text;
  finally
    FreeAndNil(Params);
  end;

  fetch(TUrl.ModificaPassword, PostData)._then(
    function(aValue: JSValue): JSValue
    begin
      callback;
    end,
    function(aValue: JSValue): JSValue
    var
      ErrorMsg: String;
    begin
      ErrorMsg := js.ToString(aValue);
      DisplayError('Modifica Password', ErrorMsg);
    end);
end;

procedure TAdmin.RecuperaPassword(const UserName, eMail: string; callback: TProc);
var
  Params: TStringList;
  PostData: string;
begin
  Params := TStringList.Create;
  try
    Params.AddPair('Username', UserName);
    Params.AddPair('eMail', eMail);
    PostData := Params.Text;
  finally
    FreeAndNil(Params);
  end;

  fetch(TUrl.RecuperaPassword, PostData)._then(
    function(aValue: JSValue): JSValue
    begin
      callback;
    end,
    function(aValue: JSValue): JSValue
    var
      ErrorMsg: String;
    begin
      ErrorMsg := js.ToString(aValue);
      DisplayError('Recupero Password', ErrorMsg);
    end);
end;

procedure TAdmin.RecuperaUsername(const eMail: string);
var
  Params: TStringList;
  PostData: string;
begin
  Params := TStringList.Create;
  try
    Params.AddPair('eMail', eMail);
    PostData := Params.Text;
  finally
    FreeAndNil(Params);
  end;

  fetch(TUrl.RecuperaUsername, PostData)._then(
    function(aValue: JSValue): JSValue
    begin
      Controller.Admin.Login;
    end,
    function(aValue: JSValue): JSValue
    var
      ErrorMsg: String;
    begin
      ErrorMsg := js.ToString(aValue);
      DisplayError('Recupero Username', ErrorMsg);
    end);
end;

procedure TAdmin.DisplayError(const title, msg: string; proc: TProc = nil);
begin
  TdxUtils.Alert(title, msg)._then(
    function(value: JSValue): JSValue
    begin
      if assigned(proc) then
        proc
    end);
end;

function TAdmin.PasswordStrength(const Password: string): integer;

  function match(const s: string; chars: string): boolean;
  var
    c: char;
  begin
    result := false;
    for c in chars do
      if s.contains(c) then
        Exit(true);
  end;

// const

begin
  result := 0;

  // lunghezza password
  if Password.length >= 8 then
    inc(result);

  // if(this.value.match(/[0-9]+/))
  if match(Password, '01234567890') then
    inc(result);

  if match(Password, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') then
    inc(result);

  if match(Password, 'abcdefghijklmnopqrstuvwxyz') then
    inc(result);

  if match(Password, '/[-!$%^&*()_+|~=`{}[\]:";''<>?,./\\]/') then
    inc(result);
end;

procedure TAdmin.SaveUserTheme;
begin
  user.DarkTheme := TdxThemes.Dark;

  if user.IsStored then
    SaveToStorage;
end;

end.
