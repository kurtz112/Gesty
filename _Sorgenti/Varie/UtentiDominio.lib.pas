unit UtentiDominio.lib;

interface

function CreaUtenteDominio(const Server, Username, Password: string): Boolean;

function IsAdministrator: Boolean;
function IsElevated: Boolean;

implementation

uses
  Winapi.Windows,
  Winapi.ShellAPI,
  System.UITypes,
  System.Win.ComObj,
  System.SysUtils,
  Vcl.Dialogs,
  JclWin32,
  zMsg;

function CheckTokenMembership(TokenHandle: THANDLE; SidToCheck: Pointer; var IsMember: BOOL): BOOL; stdcall; external advapi32 name 'CheckTokenMembership';

function IsAdministrator: Boolean;
var
  psidAdmin: Pointer;
  B: BOOL;
const
  SECURITY_NT_AUTHORITY: TSidIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS = $00000220;
  SE_GROUP_USE_FOR_DENY_ONLY = $00000010;
begin
  psidAdmin := nil;
  try
    // Создаём SID группы админов для проверки
    Win32Check(AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2, SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0, psidAdmin));

    // Проверяем, входим ли мы в группу админов (с учётов всех проверок на disabled SID)
    if CheckTokenMembership(0, psidAdmin, B) then
      Result := B
    else
      Result := False;
  finally
    if psidAdmin <> nil then
      FreeSid(psidAdmin);
  end;
end;

function IsElevated: Boolean;
const
  TokenElevation = TTokenInformationClass(20);
type
  TOKEN_ELEVATION = record
    TokenIsElevated: DWORD;
  end;
var
  TokenHandle: THANDLE;
  ResultLength: Cardinal;
  ATokenElevation: TOKEN_ELEVATION;
  HaveToken: Boolean;
begin
  if CheckWin32Version(6, 0) then
  begin
    TokenHandle := 0;
    HaveToken := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True, TokenHandle);
    if (not HaveToken) and (GetLastError = ERROR_NO_TOKEN) then
      HaveToken := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, TokenHandle);
    if HaveToken then
    begin
      try
        ResultLength := 0;
        if GetTokenInformation(TokenHandle, TokenElevation, @ATokenElevation, SizeOf(ATokenElevation), ResultLength) then
          Result := ATokenElevation.TokenIsElevated <> 0
        else
          Result := False;
      finally
        CloseHandle(TokenHandle);
      end;
    end
    else
      Result := False;
  end
  else
    Result := IsAdministrator;
end;

function CreaUtenteDominio(const Server, Username, Password: string): Boolean;
var
  Buf: USER_INFO_2; // Buf for the new user info
  Err: NET_API_STATUS;
  ParamErr: DWORD;
  GrpUsrInfo: USER_INFO_0; // Buf for the group
  DummyStr: WideString;
begin

  if not(IsAdministrator or IsElevated) then

    if not ConfirmYesNo('Attenzione: servono i diritti di amministratore per questa operazione. Continuare?', mtWarning) then
      exit;

  DummyStr := '';
  FillChar(Buf, SizeOf(USER_INFO_2), 0);

  Buf.usri2_name := PWideChar(Username);
  Buf.usri2_full_name := PWideChar(Username); // You can add a more descriptive name here
  Buf.usri2_password := PWideChar(Password);
  Buf.usri2_comment := PWideChar(DummyStr);
  Buf.usri2_priv := USER_PRIV_USER;
  Buf.usri2_flags := UF_SCRIPT OR UF_DONT_EXPIRE_PASSWD;
  Buf.usri2_script_path := PWideChar(DummyStr);
  Buf.usri2_home_dir := PWideChar(DummyStr);
  Buf.usri2_acct_expires := TIMEQ_FOREVER;

  Err := NetUserAdd(PWideChar(Server), 1, @Buf, @ParamErr);
  Result := (Err = NERR_SUCCESS);

  if not Result then
    ConfirmOk('Errore generazione utente di dominio. Codice errore: ' + IntToStr(Err));
end;

end.
