unit dmAdmin;

interface

uses
  Winapi.ShellAPI,
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  System.UITypes,
  Data.DB,
  FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Comp.Client,
  FireDAC.Phys.IBBase,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Web.HTTPApp,
  lib.Context,
  route,
  routes.Attributes;

type

  [Path('')]
  TAdmin = class(TRoute)
  private
    function TryLoginActiveDirecory(const Username: string; const Password: string): boolean;
  public
    // api
    /// /////////////////
    ///
    [ANY('getData', pkJWT)]
    procedure GetData(Context: TzContext); override;
    /// /////////////////
    ///
    [ANY('execSP', pkJWT)]
    procedure ExecSP(Context: TzContext); override;
    /// /////////////////
    ///
    [ANY('download', pkJWT)]
    procedure download(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('upload', pkJWT)]
    procedure UploadFile(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('meta', pkNone)]
    procedure Meta(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('api', pkNone)]
    procedure Api(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('ver', pkNone)]
    procedure Ver(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('cmd', pkNone)]
    procedure Cmd(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('ping', pkNone)]
    procedure Ping(ctx: TzContext);
    /// /////////////////
    /// registrazione & co
    [ANY('comuniAbilitati', pkNone)]
    procedure ComuniAbilitati(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('richiestaRegistrazione', pkNone)]
    procedure RichiestaRegistrazione(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('confermaRegistrazione', pkNone)]
    procedure ConfermaRegistrazione(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('recuperaUsername', pkNone)]
    procedure RecuperaUsername(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('recuperaPassword', pkNone)]
    procedure RecuperaPassword(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('modificaPassword', pkJWT)]
    procedure ModificaPassword(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('login', pkNone)]
    procedure Login(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('logout', pkJWT)]
    procedure Logout(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('webConfig', pkJWT)]
    procedure WebConfig(ctx: TzContext);
    /// /////////////////
    ///
    [ANY('checkjwt', pkNone)]
    procedure Check_JWT(ctx: TzContext);
    ///
    [ANY('dump', pkNone)]
    procedure Dump(ctx: TzContext);
  end;

var
  Admin: TAdmin;

implementation

uses
  System.JSON,
  System.IOUtils,
  System.DateUtils,
  System.StrUtils,
  System.Math,
  System.NetEncoding,
  lib.JsonRest,
  lib.Consts,
  lib.Config,
  lib.JWT,
  lib.mail,
  zz.ActiveDirectory,
  zz.Folders,
  zz.VersionInfo,
  zz.SmartInspect;

// DBXJSONReflect,

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TAdmin.GetData(Context: TzContext);
begin
  // non eliminare
  inherited;
end;

procedure TAdmin.download(ctx: TzContext);
var
  StoredProc: TFDStoredProc;
  idFile: integer;
  idFileStr: string;
  FileName: string;
const
  StoredProcName = 'WEB_GET_FULL_FILE_NAME';
  Const_ID_FILE = 'ID_FILE';
  Const_FULL_FILE_NAME = 'FULL_FILE_NAME';
begin
  SiMain.EnterMethod(Self, 'download');
  try
    idFileStr := ctx.Request.ParamByName(Const_ID_FILE);
    SiMain.LogString('idFileStr', idFileStr);

    if not TryStrToInt(idFileStr, idFile) then
      Exit;

    Connect(ctx);
    try
      StoredProc := CreateStoredProc(StoredProcName);
      try
        Prepare(ctx.Request, StoredProc);
        StoredProc.ParamByName(Const_ID_FILE).Value := idFile;
        StoredProc.ExecProc;
        FileName := StoredProc.ParamByName(Const_FULL_FILE_NAME).AsString;
        StoredProc.Close;
      finally
        FreeAndNil(StoredProc);
      end;
    finally
      Disconnect;
    end;

    SiMain.LogString('FileName', FileName);

    if FileExists(FileName) then
      ctx.Response.Render(FileName)
    else if (DebugHook <> 0) and (idFile = -1) then // debug
      ctx.Response.Render(TFolders.ModuleFolder + 'test_download.pdf')
    else
      ctx.Response.RenderError('File non trovato.');
  finally
    SiMain.LeaveMethod(Self, 'download');
  end;
end;

procedure TAdmin.Api(ctx: TzContext);
var
  WebActionItem: TWebActionItem;
  WebModule: TWebModule;
  i: integer;
  JSONObject: TJSONObject;
begin
  SiMain.EnterMethod('Api');
  try

    if not ConfigProps.Metadata then
    begin
      ctx.Response.RenderOk;
      Exit;
    end;

    { TODO : Reindirizzare su RTTI }

    if owner is TWebModule then
    begin
      WebModule := TWebModule(owner);

      JSONObject := TJSONObject.Create;
      for i := 0 to WebModule.Actions.Count - 1 do
      begin
        WebActionItem := WebModule.Actions[i];
        JSONObject.AddPair(WebActionItem.PathInfo, TJSONBool.Create(WebActionItem.Enabled));
      end;

      ctx.Response.Render(True, JSONObject);
    end
    else
      ctx.Response.RenderError('Chiamata non valida.');
  finally
    SiMain.LeaveMethod('Api');
  end;
end;

procedure TAdmin.Ver(ctx: TzContext);
var
  Res: TJSONObject;
begin

  if not ConfigProps.Metadata then
  begin
    ctx.Response.RenderOk;
    Exit;
  end;

  Res := TJSONObject.Create; // distrutto da Render

  Res.AddPair('ProductName', ProductName);
  Res.AddPair('FileDescription', FileDescription);
  Res.AddPair('ModuleName', ExtractFileName(TFolders.ModuleName));
  Res.AddPair('LegalCopyright', LegalCopyright);
  Res.AddPair('ProductVersion', ProductVersion);
  Res.AddPair('FileVersion', FileVersion);
  Res.AddPair('_Ver', ConfigProps.Ver);

  ctx.Response.Render(True, Res);
end;

procedure TAdmin.WebConfig(ctx: TzContext);
var
  SessionId: integer;
  procWebConfig: TFDStoredProc;
begin
  SiMain.EnterMethod('WebConfig');
  try
    SessionId := ctx.Request.ParamByName(ident_JWT_Session).ToInteger;
    SiMain.LogInteger('WebConfig: SessionId', SessionId);

    Connect(ctx);
    try
      procWebConfig := CreateStoredProc('WEB_CONFIG_GET');
      try
        Prepare(ctx.Request, procWebConfig);

        if SessionId = -1 then
          procWebConfig.ParamByName('ID_SESSIONE').Clear
        else
          procWebConfig.ParamByName('ID_SESSIONE').Value := SessionId;

        procWebConfig.ExecProc;
        try
          ctx.Response.Render(procWebConfig);
        finally
          procWebConfig.Close;
        end;
      finally
        FreeAndNil(procWebConfig)
      end;
    finally
      Disconnect;
    end;
  finally
    SiMain.LeaveMethod('WebConfig');
  end;
end;

procedure TAdmin.Cmd(ctx: TzContext);
var
  Res: TJSONObject;
  Folder: string;
  Cmd: string;
  FileName: string;
  cmdResult: HINST;
begin

  if not ConfigProps.Cmd_Enabled then
  begin
    ctx.Response.RenderOk;
    Exit;
  end;

  Folder := TFolders.SubFolder(ConfigProps.CartellaFiles, 'cmd');
  Cmd := ctx.Request.ParamByName('cmd');
  FileName := Folder + Cmd;

  if not FileExists(FileName) then
  begin
    Res := TJSONObject.Create; // distrutto da Render
    Res.AddPair('Error', 'File not found');
    Res.AddPair('cmd', Cmd);
    Res.AddPair('RemoteIP', ctx.Request.RemoteIP);

    ctx.Response.Render(False, Res);
    Exit;
  end;

  SiMain.LogColored(TColors.Red, 'ShellExecute');
  SiMain.LogString('ShellExecute', Cmd);

  cmdResult := ShellExecute(0, nil, pchar(FileName), nil, nil, SW_SHOWNOACTIVATE);

  Res := TJSONObject.Create; // distrutto da Render
  Res.AddPair('cmd', Cmd);
  Res.AddPair('cmdResult', TJSONNumber.Create(cmdResult));
  Res.AddPair('RemoteIP', ctx.Request.RemoteIP);
  ctx.Response.Render(True, Res);
end;

procedure TAdmin.ComuniAbilitati(ctx: TzContext);
var
  DataSet: TFDQuery;
begin
  SiMain.EnterMethod(Self, 'ComuniAbilitati');
  try
    Connect(ctx);
    try
      DataSet := CreateDataSet;
      try
        DataSet.SQL.Text := 'SELECT * FROM USR_COMUNI_ABILITATI(:APP)';
        Prepare(ctx.Request, DataSet);
        DataSet.Active := True;
        try
          ctx.Response.Render(DataSet);
        finally
          DataSet.Active := False;
        end;
      finally
        FreeAndNil(DataSet);
      end;
    finally
      Disconnect;
    end;
  finally
    SiMain.LeaveMethod(Self, 'ComuniAbilitati');
  end;
end;

procedure TAdmin.ConfermaRegistrazione(ctx: TzContext);
var
  Token: string;
  IndirizzoIp: string;
  procConfermaReg: TFDStoredProc;
begin
  SiMain.EnterMethod(Self, 'ConfermaRegistrazione');
  try
    Token := ctx.Request.ParamByName(ident_Token);
    IndirizzoIp := ctx.Request.RemoteAddr;

    AdminConnect;
    try
      procConfermaReg := CreateStoredProc('USR_INT_CONFERMA_REGISTRAZIONE');
      try
        procConfermaReg.ParamByName('TOKEN').AsString := Token;
        procConfermaReg.ParamByName('INDIRIZZO_IP').AsString := IndirizzoIp;
        procConfermaReg.ExecProc;
        procConfermaReg.Close;
        ctx.Response.RenderOk;
      finally
        FreeAndNil(procConfermaReg);
      end;
    finally
      Disconnect;
    end;
  finally
    SiMain.LeaveMethod(Self, 'ConfermaRegistrazione');
  end;
end;

procedure TAdmin.ExecSP(Context: TzContext);
begin
  // non eliminare
  inherited;
end;

procedure TAdmin.Login(ctx: TzContext);
var
  Admin: boolean;
  App: string;
  ConnectionName: string;
  DataScadenzaPassword: TDateTime;
  Expiration: TDateTime;
  jParamsOut: TJSONObject;
  JWT: string;
  TipoUser: string;
  Nominativo: string;
  procLogin: TFDStoredProc;
  SessionId: integer;
  Username: string;
  Password: string;
  UserID: integer;
  SkipCreateSession: boolean;
begin
  SiMain.EnterMethod('Login');
  // try
  // rivedendo la parte web si elimina loginUserName

  App := ctx.Request.ParamByName(ident_App);
  Username := ctx.Request.ParamByName(ident_LoginUsername);
  if Username = '' then
    Username := ctx.Request.ParamByName(ident_User);
  if Username = '' then
    Username := ctx.Request.ParamByName('user');

  Password := ctx.Request.ParamByName(ident_LoginPassword);
  if Password = '' then
    Password := ctx.Request.ParamByName(ident_Password);
  if Password = '' then
    Password := ctx.Request.ParamByName(ident_Pwd);

  SkipCreateSession := SameText(ctx.Request.ParamByName(ident_SkipCreateSession), 'S'); // SCS=S

  // se passa l'autenticazione di dominio,
  // lo username per il db rimane quello, ma la password
  // viene sostituita con una 'universale' poich� non � possibile
  // tenerle sincronizzate tra server di dominio e db
  if ConfigProps.Dominio <> '' then
  begin
    if not TryLoginActiveDirecory(Username, Password) then
      raise Exception.Create('AD Login failed');

    Password := ConfigProps.DominioPwd;
    ConnectionName := CreateUserConnection(Username);
    SiMain.LogVerbose('ActiveDirecory.NewConnection');
  end
  else
    ConnectionName := DefaultConnectionName;

  /// //////////////////////////////////////////////////////////////////////////

  Connect(ConnectionName);
  try
    /// /////////////////////////////////////////////////
    /// /////////////////////////////////////////////////
    /// /////////////////////////////////////////////////

    procLogin := CreateStoredProc('USR_LOGIN');
    try
      Prepare(ctx.Request, procLogin);
      procLogin.ParamByName('APP').AsString := App;
      procLogin.ParamByName('USER_NAME').AsString := Username;
      procLogin.ParamByName('PASSWORD_').AsString := Password;
      procLogin.ParamByName('COMPUTER_NAME').AsString := 'GestyServer';
      // procLogin.ParamByName('SKIP_CREATE_SESSION').AsBoolean := SkipCreateSession;
      // procLogin.ParamByName('INDIRIZZO_IP').AsString := System.copy(Request.RemoteAddr, 1, 15);

      procLogin.ExecProc;
      try
        SessionId := procLogin.ParamByName('ID_SESSIONE').Value;
        UserID := procLogin.ParamByName('USER_ID').Value;
        Nominativo := procLogin.ParamByName('NOMINATIVO').AsString;
        TipoUser := procLogin.ParamByName('TIPO_USER').AsString;
        DataScadenzaPassword := procLogin.ParamByName('DATA_SCADENZA_PASSWORD').AsDate;
        Admin := procLogin.ParamByName('ADMIN_USER').AsBoolean;
      finally
        procLogin.Close;
      end;
    finally
      FreeAndNil(procLogin);
    end;

    /// /////////////////////////////////////////////////
    /// /////////////////////////////////////////////////
    /// /////////////////////////////////////////////////
  finally
    Disconnect;
  end;

  /// //////////////////////////////////////////////////////////////////////////
  JWT := CreateToken(App, Username, Password, ConnectionName, UserID, SessionId);
  // Response.SetCustomHeader('Access-Control-Expose-Headers', '__JWT');
  // Response.SetCustomHeader(ident_JWT, JWT);

  jParamsOut := TJSONObject.Create; // distrutto da Render
  jParamsOut.AddPair('ID_SESSIONE', TJSONNumber.Create(SessionId));
  jParamsOut.AddPair('USER_ID', TJSONNumber.Create(UserID));
  jParamsOut.AddPair('NOMINATIVO', TJSONString.Create(Nominativo));
  jParamsOut.AddPair('TIPO_USER', TJSONString.Create(TipoUser));
  jParamsOut.AddPair('DATA_SCADENZA_PASSWORD', TJSONString.Create(DateToStr(DataScadenzaPassword)));
  jParamsOut.AddPair('ADMIN_USER', TJSONBool.Create(Admin));
  jParamsOut.AddPair('JWT', TJSONString.Create(JWT));

  ctx.Response.Render(True, jParamsOut);
  // finally
  SiMain.LeaveMethod('Login');
  // end;
end;

procedure TAdmin.Logout(ctx: TzContext);
var
  procLogout: TFDStoredProc;
  JSONObject: TJSONObject;
  SessionId: integer;
begin
  SiMain.EnterMethod('Logout');
  try
    SessionId := ctx.Request.ParamByName(ident_JWT_Session).ToInteger;
    SiMain.LogInteger('Logout: SessionId', SessionId);

    Connect(ctx);
    try
      procLogout := CreateStoredProc('USR_LOGOUT');
      try
        Prepare(ctx.Request, procLogout);

        if SessionId = -1 then
          procLogout.ParamByName('ID_SESSIONE').Clear
        else
          procLogout.ParamByName('ID_SESSIONE').Value := SessionId;

        procLogout.ExecProc;
        procLogout.Close;
      finally
        FreeAndNil(procLogout)
      end;
    finally
      Disconnect;
    end;

    JSONObject := TJSONObject.Create;
    JSONObject.AddPair('url', ConfigProps.LogoutUrl);
    ctx.Response.Render(True, JSONObject);
  finally
    SiMain.LeaveMethod('Logout');
  end;
end;

procedure TAdmin.Meta(ctx: TzContext);
var
  DataSet: TFDQuery;
  DataSetName: string;
  FileName: string;
  dm: string;
  Folder: string;
  i: integer;
  jParamsOut: TJSONObject;
  Richiesta: string;
  Risposta: string;
  s: string;
  jDataSet: TJSONObject;

  // function DummyDataSet(DataSet: TDataSet): TJSONValue;
  // var
  // Field: TField;
  // Res: TJSONObject;
  // jRecord: TJSONObject;
  // jDataSet: TJSONArray;
  // begin
  // result := nil;
  //
  // Res := TJSONObject.Create;
  //
  // jDataSet := TJSONArray.Create;
  //
  // DataSet.First;
  // jRecord := TJSONObject.Create;
  // jDataSet.AddElement(jRecord);
  //
  // for Field in DataSet.Fields do
  // if not(Field is TDataSetField) then
  // jRecord.AddPair(TJSONPair.Create(Field.FieldName, REST_DummyValue(Field.DataType)));
  //
  // Res.AddPair(TJSONPair.Create(ident_SuccessProperty, TJSONTrue.Create));
  // Res.AddPair(TJSONPair.Create(ident_TotalProperty, TJSONNumber.Create(1)));
  // Res.AddPair(TJSONPair.Create(ident_DataRoot, jDataSet));
  //
  // result := Res;
  //
  // SiMain.LogString('ExportDataSet.Result', result.Value);
  // end;

begin

  if not ConfigProps.Metadata then
  begin
    ctx.Response.RenderOk;
    Exit;
  end;

  // SiMain.EnterMethod(Self, 'Meta');
  // try
  // dm := Request.ParamByName(ident_Datamodule);
  //
  // if dm = '' then
  // raise exception.Create(ident_Datamodule + ' non specificato.');
  //
  // jParamsOut := TJSONObject.Create;
  //
  // AdminConnect;
  // try
  // DataSet := CreateDataSet;
  // try
  // Folder := DataModuleFolder(dm);
  // SiMain.LogString('Meta:Folder', Folder);
  //
  // for FileName in TDirectory.GetFiles(Folder, '*.sql') do
  // begin
  // DataSetName := ChangeFileExt(ExtractFileName(FileName), '');
  //
  // LoadSql(Request, DataSet, dm, DataSetName);
  // DataSet.Open;
  // // Request
  // Richiesta := '<host>/api/getData?' + ident_Datamodule + '=' + dm + '&' + ident_DataSet + '=' + DataSetName;
  // for i := 0 to DataSet.ParamCount - 1 do
  // if DataSet.Params[i].ParamType in [ptInput, ptInputOutput] then
  // Richiesta := Richiesta + '&' + DataSet.Params[i].Name + '=' + REST_DummyValueStr(DataSet.Params[i].DataType);
  //
  // /// /////
  // jDataSet := TJSONObject.Create;
  // jDataSet.AddPair('Richiesta', Richiesta);
  // jDataSet.AddPair('Risposta', DummyDataSet(DataSet));
  // jParamsOut.AddPair(DataSetName, jDataSet);
  // end;
  // finally
  // FreeAndNil(DataSet);
  // end;
  // finally
  // Disconnect;
  // end;
  //
  // Response_JSON(Response, REST_Result(True, jParamsOut));
  // finally
  // SiMain.LeaveMethod(Self, 'Meta');
  // end;
end;

procedure TAdmin.ModificaPassword(ctx: TzContext);
var
  IdSessione: integer;
  NewPassword: string;
  OldPassword: string;
  procCambiaPwd: TFDStoredProc;
  Res: TJSONObject;
  UserIdStr: string;
  UserID: integer;
begin
  SiMain.EnterMethod(Self, 'ModificaPassword');
  try
    NewPassword := ctx.Request.ParamByName(ident_NewPassword);
    OldPassword := ctx.Request.ParamByName(ident_OldPassword);
    UserIdStr := ctx.Request.ParamByName(ident_UserId);
    IdSessione := ctx.Request.ParamByName(ident_JWT_Session).ToInteger;

    if not TryStrToInt(UserIdStr, UserID) then
      raise Exception.Create('UserID non specificato.');

    if UserID = -1 then
      raise Exception.Create('UserID non valido: -1.');

    if IdSessione = -1 then
      IdSessione := ctx.Request.ParamByName(ident_ID_SESSIONE).ToInteger;

    SiMain.LogString('UserId', UserIdStr);
    SiMain.LogInteger('SessionId', IdSessione);

    Connect(ctx);
    try
      procCambiaPwd := CreateStoredProc('USR_CAMBIA_PASSWORD');
      try
        procCambiaPwd.ParamByName('ID_SESSIONE').Value := IdSessione;
        procCambiaPwd.ParamByName('USER_ID').Value := UserID;
        procCambiaPwd.ParamByName('OLD_PASSWORD').AsString := OldPassword;
        procCambiaPwd.ParamByName('NEW_PASSWORD').AsString := NewPassword;

        procCambiaPwd.ExecProc;
        try
          ctx.Response.RenderOk;
        except
          on E: Exception do
          begin
            ctx.Response.RenderError('Impossibile variare la password.');
            SiMain.LogException(E);
          end;
        end;
      finally
        FreeAndNil(procCambiaPwd);
      end;
    finally
      Disconnect;
    end;
  finally
    SiMain.LeaveMethod(Self, 'ModificaPassword');
  end;
end;

procedure TAdmin.Ping(ctx: TzContext);
begin
  SiMain.EnterMethod('Ping');
  try
    ctx.Response.RenderOk;
  finally
    SiMain.LeaveMethod('Ping');
  end;
end;

procedure TAdmin.RecuperaUsername(ctx: TzContext);
var
  CorpoMail: string;
  CorpoMailHtml: string;
  eMail: string;
  IndirizzoIp: string;
  MailReplay: string;
  MailUtente: string;
  Oggetto: string;
  procResetPwd: TFDStoredProc;
  Username: string;
begin
  SiMain.EnterMethod(Self, 'RecuperaUsername');
  try
    eMail := ctx.Request.ParamByName(ident_eMail);
    IndirizzoIp := ctx.Request.RemoteAddr;

    AdminConnect;
    try
      StartTrans;
      try
        procResetPwd := CreateStoredProc('USR_RECUPERA_USER_NAME');
        try
          procResetPwd.ParamByName('E_MAIL').AsString := eMail;
          procResetPwd.ParamByName('INDIRIZZO_IP').AsString := IndirizzoIp;
          procResetPwd.ExecProc;
          try
            MailUtente := procResetPwd.ParamByName('MAIL_PER_INVIO').AsString;
            MailReplay := procResetPwd.ParamByName('MAIL_PER_RISPOSTE').AsString;
            Oggetto := procResetPwd.ParamByName('MAIL_RECUPERO_USER_OGGETTO').AsString;
            CorpoMail := procResetPwd.ParamByName('MAIL_RECUPERO_USER_CORPO').AsString;
            CorpoMailHtml := procResetPwd.ParamByName('MAIL_RECUPERO_USER_CORPO_HTML').AsString;
          finally
            procResetPwd.Close;
          end;
        finally
          FreeAndNil(procResetPwd);
        end;

        /// ////////////////////////////////////////////////////
        SiMain.LogString('MailUtente', MailUtente);
        SiMain.LogString('MailReplay', MailReplay);
        SiMain.LogString('Oggetto', Oggetto);
        SiMain.LogString('CorpoMail', CorpoMail);
        SiMain.LogString('CorpoMailHtml', CorpoMailHtml);

        if SendMail(MailReplay, MailUtente, Oggetto, CorpoMail, CorpoMailHtml) then
        begin
          ctx.Response.RenderOk;
          Commit;
        end
        else
        begin
          ctx.Response.RenderError('Impossibile inviare mail conferma.');
          Rollback;
        end;
        /// ////////////////////////////////////////////////////
      except
        on E: Exception do
        begin
          Rollback;
          raise;
        end;
      end;
    finally;
      Disconnect;
    end;
    /// ////////////////////////////////////////////////////
  finally
    SiMain.LeaveMethod(Self, 'RecuperaUsername');
  end;
end;

procedure TAdmin.RecuperaPassword(ctx: TzContext);
var
  CorpoMail: string;
  CorpoMailHtml: string;
  eMail: string;
  IndirizzoIp: string;
  jParamsOut: TJSONObject;
  MailReplay: string;
  MailUtente: string;
  Oggetto: string;
  procResetPwd: TFDStoredProc;
  Username: string;
  NuovaPassword: string;
begin
  SiMain.EnterMethod(Self, 'RecuperaPassword');
  try
    Username := ctx.Request.ParamByName(ident_UserName);
    eMail := ctx.Request.ParamByName(ident_eMail);
    IndirizzoIp := ctx.Request.RemoteAddr;

    AdminConnect;
    try
      StartTrans;
      try
        procResetPwd := CreateStoredProc('USR_RECUPERA_PASSWORD');
        try
          procResetPwd.ParamByName('USER_NAME').AsString := Username;
          procResetPwd.ParamByName('E_MAIL').AsString := eMail;
          procResetPwd.ParamByName('INDIRIZZO_IP').AsString := IndirizzoIp;
          procResetPwd.ExecProc;
          try
            NuovaPassword := procResetPwd.ParamByName('NUOVA_PASSWORD').AsString;
            MailUtente := procResetPwd.ParamByName('MAIL_PER_INVIO').AsString;
            MailReplay := procResetPwd.ParamByName('MAIL_PER_RISPOSTE').AsString;
            Oggetto := procResetPwd.ParamByName('MAIL_RESET_PWD_OGGETTO').AsString;
            CorpoMail := procResetPwd.ParamByName('MAIL_RESET_PWD_CORPO').AsString;
            CorpoMailHtml := procResetPwd.ParamByName('MAIL_RESET_PWD_CORPO_HTML').AsString;
          finally
            procResetPwd.Close;
          end;
        finally
          FreeAndNil(procResetPwd);
        end;
        /// ////////////////////////////////////////////////////
        SiMain.LogString('MailUtente', MailUtente);
        SiMain.LogString('MailReplay', MailReplay);
        SiMain.LogString('Oggetto', Oggetto);
        SiMain.LogString('CorpoMail', CorpoMail);
        SiMain.LogString('CorpoMailHtml', CorpoMailHtml);

        if SendMail(MailReplay, MailUtente, Oggetto, CorpoMail, CorpoMailHtml) then
        begin
          jParamsOut := TJSONObject.Create; // distrutto da Render
          jParamsOut.AddPair('Password', NuovaPassword);
          ctx.Response.Render(True, jParamsOut);
          Commit;
        end
        else
        begin
          ctx.Response.RenderError('Impossibile inviare mail conferma.');
          Rollback;
        end;

        /// ////////////////////////////////////////////////////
      except
        on E: Exception do
        begin
          Rollback;
          raise;
        end;
      end;
    finally;
      Disconnect;
    end;
    /// ////////////////////////////////////////////////////
  finally
    SiMain.LeaveMethod(Self, 'RecuperaPassword');
  end;
end;

procedure TAdmin.RichiestaRegistrazione(ctx: TzContext);
var
  App: string;
  idIntestatario: integer;
  Username: string;
  Password: string;
  eMail: string;
  Belfiore: string;
  CodiceFiscale: string;
  IndirizzoIp: string;
  CorpoMail: string;
  CorpoMailHtml: string;
  MailReplay: string;
  MailUtente: string;
  Oggetto: string;
  procRegistrazione: TFDStoredProc;
  Risultato: integer;
  DescRisultato: string;
  jParamsOut: TJSONObject;
begin
  SiMain.EnterMethod(Self, 'RichiestaRegistrazione');
  try
    // App := Request.ParamByName(ident_App);
    // Username := Request.ParamByName(ident_UserName);
    // Password := Request.ParamByName(ident_Password);
    // eMail := Request.ParamByName(ident_eMail);
    // CodiceFiscale := Request.ParamByName(ident_CodiceFiscale);
    //
    // /// /////////////////////////////////////////////////
    // AdminConnect;
    // try
    // StartTrans;
    // try
    // procRegistrazione := CreateStoredProc('USR_INT_RICHIESTA_REGISTRAZIONE');
    // try
    // procRegistrazione.ParamByName('APP').AsString := App;
    // procRegistrazione.ParamByName('USER_NAME').AsString := Username;
    // procRegistrazione.ParamByName('PASSWORD_').AsString := Password;
    // procRegistrazione.ParamByName('E_MAIL').AsString := eMail;
    // procRegistrazione.ParamByName('ID_INTESTATARIO').AsInteger := idIntestatario;
    // procRegistrazione.ParamByName('BELFIORE').AsString := Belfiore;
    // procRegistrazione.ParamByName('CODICE_FISCALE').AsString := CodiceFiscale;
    //
    // procRegistrazione.ExecProc;
    // try
    // Risultato := procRegistrazione.ParamByName('RISULTATO').AsInteger;
    // DescRisultato := procRegistrazione.ParamByName('DESC_RISULTATO').AsString;
    // MailUtente := procRegistrazione.ParamByName('MAIL_PER_INVIO').AsString;
    // MailReplay := procRegistrazione.ParamByName('MAIL_PER_RISPOSTE').AsString;
    // Oggetto := procRegistrazione.ParamByName('MAIL_REGISTRAZIONE_OGGETTO').AsString;
    // CorpoMail := procRegistrazione.ParamByName('MAIL_REGISTRAZIONE_CORPO').AsString;
    // CorpoMailHtml := procRegistrazione.ParamByName('MAIL_REGISTRAZIONE_CORPO_HTML').AsString;
    // finally
    // procRegistrazione.Close;
    // end;
    // finally
    // FreeAndNil(procRegistrazione);
    // end;
    //
    // /// ////////////////////////////////////////////////////
    // SiMain.LogInteger('Risultato', Risultato);
    // SiMain.LogString('DescRisultato', DescRisultato);
    // SiMain.LogString('MailUtente', MailUtente);
    // SiMain.LogString('MailReplay', MailReplay);
    // SiMain.LogString('Oggetto', Oggetto);
    // SiMain.LogString('CorpoMail', CorpoMail);
    // SiMain.LogString('CorpoMailHtml', CorpoMailHtml);
    //
    // /// ////////////////////////////////////////////////////
    //
    // jParamsOut := TJSONObject.Create;
    // try
    // jParamsOut.AddPair('Risultato', TJSONNumber.Create(Risultato));
    // jParamsOut.AddPair('DescRisultato', DescRisultato);
    //
    // /// ////////////////////////////////////////////////////
    // if Risultato <> 0 then // errore nella proc
    // Response.Render(True, jParamsOut)
    // else
    // if SendMail(MailReplay, MailUtente, Oggetto, CorpoMail, CorpoMailHtml) then
    // begin
    // Response.Render(True, jParamsOut);
    // Commit;
    // end
    // else
    // begin
    // FreeAndNil(jParamsOut);
    // Response.RenderError('Impossibile inviare mail conferma.');
    // Rollback;
    // end;
    // except
    // on E: Exception do
    // jParamsOut.Free;
    // end;
    // except
    // on E: Exception do
    // begin
    // Rollback;
    // raise;
    // end;
    // end;
    // finally
    // Disconnect;
    // end;

    /// ////////////////////////////////////////////////////
  finally
    SiMain.LeaveMethod(Self, 'Web_Registrazione');
  end;
end;

function TAdmin.TryLoginActiveDirecory(const Username: string; const Password: string): boolean;
begin
  SiMain.EnterMethod('TryLoginActiveDirecory');

  Result := False;

  if ConfigProps.Dominio <> '' then
  begin
    Result := zz.ActiveDirectory.ActiveDirectoryAuthenticate(ConfigProps.Dominio, Username, Password);
    SiMain.LogBoolean('TryLoginActiveDirecory.Result', Result);
  end;

  SiMain.LeaveMethod('TryLoginActiveDirecory');
end;

procedure TAdmin.UploadFile(ctx: TzContext);

  procedure SaveFile(const FileName: string);
  var
    stream: TFileStream;
  begin
    stream := TFileStream.Create(FileName, fmCreate);
    try
      stream.Write(ctx.Request.RawContent[0], Length(ctx.Request.RawContent));
    finally
      FreeAndNil(stream);
    end;
  end;

var
  StoredProc: TFDStoredProc;

  FileName: string;
  memStream: TMemoryStream;
  FileStream: TFileStream;
  Folder: string;
  s: String;
  oid: integer;
  NomeFileOriginale: string;
  TipoAllegato: string;
  idFile: integer;
  i: integer;
begin
  SiMain.EnterMethod(Self, 'UploadFile');
  try
    /// ////////////////////////////////////////////////////

    s := ctx.Request.GetFieldByName('OID');
    if not TryStrToInt(s, oid) then
      oid := -1;
    NomeFileOriginale := ctx.Request.GetFieldByName('NOME_FILE_ORIGINALE');
    TipoAllegato := ctx.Request.GetFieldByName('TIPO_ALLEGATO');

    /// ////////////////////////////////////////////////////

    for i := 0 to ctx.Request.QueryFields.Count - 1 do
      SiMain.LogString('QueryFields ' + i.ToString, ctx.Request.QueryFields.Names[i]);

    for i := 0 to ctx.Request.ContentFields.Count - 1 do
      SiMain.LogString('ContentFields ' + i.ToString, ctx.Request.ContentFields.Names[i]);

    for i := 0 to ctx.Request.Files.Count - 1 do
    begin
      SiMain.LogString('Files ' + i.ToString, ctx.Request.Files[i].FieldName + ' ' + ctx.Request.Files[i].FileName);
      SiMain.LogObject('Files ' + i.ToString, ctx.Request.Files[i]);
    end;


    // ctx.Request.QueryFields('TIPO_ALLEGATO')

    /// ////////////////////////////////////////////////////
    SiMain.LogString('OID', oid.ToString);
    SiMain.LogString('NOME_FILE_ORIGINALE', NomeFileOriginale);
    SiMain.LogString('TIPO_ALLEGATO', TipoAllegato);

    /// ////////////////////////////////////////////////////

    if oid = -1 then
      raise Exception.Create('OID non specificato.');

    /// ////////////////////////////////////////////////////
    ///
    Connect(ctx);
    try
      StoredProc := CreateStoredProc('WEB_UPLOAD_INIT');
      try
        Prepare(ctx.Request, StoredProc);
        StoredProc.ParamByName('OID').Value := oid;
        StoredProc.ParamByName('TIPO_ALLEGATO').Value := TipoAllegato;
        StoredProc.ParamByName('NOME_FILE_ORIGINALE').Value := NomeFileOriginale;
        StoredProc.ExecProc;
        FileName := StoredProc.ParamByName('FULL_FILE_NAME').AsString;
        idFile := StoredProc.ParamByName('ID_FILE').AsInteger;
        StoredProc.Close;
      finally
        FreeAndNil(StoredProc);
      end;
    finally
      Disconnect;
    end;

    /// ////////////////////////////////////////////////////
    SiMain.LogString('FullFileName', FileName);

    if FileName.IsEmpty then
      Exit;

    Folder := ExtractFilePath(FileName);
    ForceDirectories(Folder);

    if TFile.Exists(FileName) then
      TFile.Delete(FileName);

    SaveFile(FileName);

    /// ////////////////////////////////////////////////////
    ///
    Connect(ctx);
    try
      StoredProc := CreateStoredProc('WEB_UPLOAD_DONE');
      try
        Prepare(ctx.Request, StoredProc);
        StoredProc.ParamByName('ID_FILE').Value := idFile;
        StoredProc.ExecProc;
        StoredProc.Close;
      finally
        FreeAndNil(StoredProc);
      end;
    finally
      Disconnect;
    end;

    /// ////////////
    ctx.Response.RenderOk;
  finally
    SiMain.LeaveMethod(Self, 'UploadFile');
  end;
end;

procedure TAdmin.Check_JWT(ctx: TzContext);
var
  JSONObject: TJSONObject;
  Error: string;
begin
  SiMain.LeaveMethod('Check_JWT');
  try
    JSONObject := TJSONObject.Create;

    if VerifyRequest(ctx, Error) then
      JSONObject.AddPair('Valido', TJSONTrue.Create)
    else
    begin
      JSONObject.AddPair('Valido', TJSONFalse.Create);
      JSONObject.AddPair('Errore', Error);
    end;

    ctx.Response.Render(True, JSONObject);
  finally
    SiMain.LeaveMethod('Check_JWT');
  end;
end;

procedure TAdmin.Dump(ctx: TzContext);
var
  dumpfile: TStringList;
  FileName: string;
begin
  SiMain.LogSeparator;
  SiMain.LogVerbose('Dump');

  SiMain.LogStringList('ContentFields', ctx.Request.ContentFields);
  SiMain.LogStringList('QueryFields', ctx.Request.QueryFields);
  SiMain.LogStringList('CookieFields', ctx.Request.CookieFields);

  SiMain.LogString('Method', ctx.Request.Method);
  SiMain.LogString('ProtocolVersion', ctx.Request.ProtocolVersion);
  SiMain.LogString('URL', ctx.Request.URL);
  SiMain.LogString('Query', ctx.Request.Query);
  SiMain.LogString('PathInfo', ctx.Request.PathInfo);
  SiMain.LogString('PathTranslated', ctx.Request.PathTranslated);
  SiMain.LogString('Authorization', ctx.Request.Authorization);

  SiMain.LogString('CacheControl', ctx.Request.CacheControl);
  SiMain.LogString('Cookie', ctx.Request.Cookie);
  SiMain.LogDateTime('Date', ctx.Request.Date);

  SiMain.LogString('Accept', ctx.Request.Accept);
  SiMain.LogString('From', ctx.Request.From);
  SiMain.LogString('Host', ctx.Request.Host);
  SiMain.LogDateTime('IfModifiedSince', ctx.Request.IfModifiedSince);
  SiMain.LogString('Referer', ctx.Request.Referer);
  SiMain.LogString('UserAgent', ctx.Request.UserAgent);
  SiMain.LogString('ContentEncoding', ctx.Request.ContentEncoding);
  SiMain.LogString('ContentType', ctx.Request.ContentType);
  SiMain.LogInt64('ContentType', ctx.Request.ContentLength);

  SiMain.LogString('ContentVersion', ctx.Request.ContentVersion);
  // siMain.LogString( 'RawContent',ctx.Request.RawContent);
  SiMain.LogString('Content', ctx.Request.Content);
  SiMain.LogString('Connection', ctx.Request.Connection);
  SiMain.LogString('DerivedFrom', ctx.Request.DerivedFrom);
  SiMain.LogDateTime('Expires', ctx.Request.Expires);
  SiMain.LogString('Title', ctx.Request.Title);
  SiMain.LogString('RemoteAddr', ctx.Request.RemoteAddr);
  SiMain.LogString('ScriptName', ctx.Request.ScriptName);
  SiMain.LogInt64('ServerPort', ctx.Request.ServerPort);
  SiMain.LogString('InternalPathInfo', ctx.Request.InternalPathInfo);
  SiMain.LogString('RawPathInfo', ctx.Request.RawPathInfo);
  SiMain.LogInteger('Files.Count', ctx.Request.Files.Count);
  SiMain.LogSeparator;

  // su file

  dumpfile := TStringList.Create;
  try
    dumpfile.AddPair('ContentFields', ctx.Request.ContentFields.Text);
    dumpfile.add('');
    dumpfile.AddPair('QueryFields', ctx.Request.QueryFields.Text);
    dumpfile.add('');
    dumpfile.AddPair('CookieFields', ctx.Request.CookieFields.Text);
    dumpfile.add('');

    dumpfile.AddPair('Method', ctx.Request.Method);
    dumpfile.AddPair('ProtocolVersion', ctx.Request.ProtocolVersion);
    dumpfile.AddPair('URL', ctx.Request.URL);
    dumpfile.AddPair('Query', ctx.Request.Query);
    dumpfile.AddPair('PathInfo', ctx.Request.PathInfo);
    dumpfile.AddPair('PathTranslated', ctx.Request.PathTranslated);
    dumpfile.AddPair('Authorization', ctx.Request.Authorization);

    dumpfile.AddPair('CacheControl', ctx.Request.CacheControl);
    dumpfile.AddPair('Cookie', ctx.Request.Cookie);
    dumpfile.AddPair('Date', ctx.Request.Date.ToString);

    dumpfile.AddPair('Accept', ctx.Request.Accept);
    dumpfile.AddPair('From', ctx.Request.From);
    dumpfile.AddPair('Host', ctx.Request.Host);
    dumpfile.AddPair('IfModifiedSince', ctx.Request.IfModifiedSince.ToString);
    dumpfile.AddPair('Referer', ctx.Request.Referer);
    dumpfile.AddPair('UserAgent', ctx.Request.UserAgent);
    dumpfile.AddPair('ContentEncoding', ctx.Request.ContentEncoding);
    dumpfile.AddPair('ContentType', ctx.Request.ContentType);
    dumpfile.AddPair('ContentType', ctx.Request.ContentLength.ToString);

    dumpfile.AddPair('ContentVersion', ctx.Request.ContentVersion);
    dumpfile.AddPair('Content', ctx.Request.Content);
    dumpfile.AddPair('Connection', ctx.Request.Connection);
    dumpfile.AddPair('DerivedFrom', ctx.Request.DerivedFrom);
    dumpfile.AddPair('Expires', ctx.Request.Expires.ToString);
    dumpfile.AddPair('Title', ctx.Request.Title);
    dumpfile.AddPair('RemoteAddr', ctx.Request.RemoteAddr);
    dumpfile.AddPair('ScriptName', ctx.Request.ScriptName);
    dumpfile.AddPair('ServerPort', ctx.Request.ServerPort.ToString);
    dumpfile.AddPair('InternalPathInfo', ctx.Request.InternalPathInfo);
    dumpfile.AddPair('RawPathInfo', ctx.Request.RawPathInfo);
    dumpfile.AddPair('Files.Count', ctx.Request.Files.Count.ToString);
    //

    FileName := TFolders.WorkingSubFolder('dump', True) + 'dump_' + FormatDateTime('yyyymmdd hh nn', Now) + '.log';
    dumpfile.SaveToFile(FileName);
  finally
    FreeAndNil(dumpfile);
  end;

  // Response

  ctx.Response.RenderOk;
end;

initialization

RegisterClass(TAdmin);

end.
