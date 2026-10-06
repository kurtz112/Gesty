unit zz.web.user;

interface

uses
  System.SysUtils,
  System.Classes;

type
  // SYSTEM          = #
  // SUPER           = X
  // DOCENTE         = D
  // PERSONALE       = P
  // TUTOR AZIENDALE = T
  // STUDENTE        = S
  // GENITORE        = G
  TTipoUser = (tuSystem, tuSuper, tuDocente, tuPersonale, tuTutor, tuStudente, tuGenitore);
  TTipiUser = set of TTipoUser;

  TTipoUserHelper = record helper for TTipoUser
  private
    function GetAsString: String;
    procedure SetAsString(const Value: String);
  public
    procedure Check(allowedTipoUser: TTipoUser); overload;
    procedure Check(allowedTipiUser: TTipiUser); overload;
    property AsString: String read GetAsString write SetAsString;
  end;

  TUser = record
  public const
    AppSection = 'GestyWeb_Personale_';
  private
    FAnnoFormativo: integer;
    FAnnoFormativoDesc: string;
    FDarkTheme: boolean;
    FUserName: string;
    FUserID: integer;
    FNominativo: String;
    FOnnipotente: boolean;
    FDataScadenzaPassword: TDate;
    FIdRisorsa: integer;
    FIdSessione: integer;
    FTipoUser: TTipoUser;
    function GetOnnipotente: boolean;
  public
    procedure Clear;
    procedure ClearStorage;
    procedure LoadFromStorage;
    procedure SaveToStorage;
    function IsStored: boolean;
    function PasswordScaduta: boolean;
  public
    property UserName: string read FUserName write FUserName;
    property UserID: integer read FUserID write FUserID;
    property Nominativo: String read FNominativo write FNominativo;
    property TipoUser: TTipoUser read FTipoUser write FTipoUser;
    property Onnipotente: boolean read GetOnnipotente write FOnnipotente;
    property DataScadenzaPassword: TDate read FDataScadenzaPassword write FDataScadenzaPassword;
    property IdSessione: integer read FIdSessione write FIdSessione;
    //
    property IdRisorsa: integer read FIdRisorsa write FIdRisorsa;
    property AnnoFormativo: integer read FAnnoFormativo write FAnnoFormativo;
    property AnnoFormativoDesc: string read FAnnoFormativoDesc write FAnnoFormativoDesc;
    { TODO : User: può essere anche Tutor o Studente }
    // TipoUtente
    // IdAnagrafica
  public
    property DarkTheme: boolean read FDarkTheme write FDarkTheme;
  end;

var
  user: TUser;

implementation

uses
  System.StrUtils,
  WEBLib.Storage,
  zz.web.JS,
  JS,
  web;

procedure TUser.Clear;
begin
  FUserName := '';
  FUserID := -1;
  FOnnipotente := false;
  FDataScadenzaPassword := 0;
  FIdSessione := -1;
  FNominativo := '';
  FTipoUser.AsString := 'R';
  //
  FIdRisorsa := -1;
  FAnnoFormativo := -1;
  FAnnoFormativoDesc := '';
  //
  FDarkTheme := true;
end;

procedure TUser.ClearStorage;
begin
  TLocalStorage.RemoveKey(AppSection + 'UserName');
  TLocalStorage.RemoveKey(AppSection + 'UserID');
  TLocalStorage.RemoveKey(AppSection + 'Nominativo');
  TLocalStorage.RemoveKey(AppSection + 'TipoUser');
  TLocalStorage.RemoveKey(AppSection + 'Admin');
  TLocalStorage.RemoveKey(AppSection + 'IdSessione');
  ///
  TLocalStorage.RemoveKey(AppSection + 'IdRisorsa');
  TLocalStorage.RemoveKey(AppSection + 'AnnoFormativo');
  TLocalStorage.RemoveKey(AppSection + 'AnnoFormativoDesc');
  //
  TLocalStorage.RemoveKey(AppSection + 'DarkTheme');
end;

procedure TUser.LoadFromStorage;
begin
  Clear;

  if TLocalStorage.getValue(AppSection + 'UserID').IsEmpty then
    Exit;

  FUserName := TLocalStorage.getValue(AppSection + 'UserName');
  FUserID := TLocalStorage.getValue(AppSection + 'UserID').ToInteger;
  FNominativo := TLocalStorage.getValue(AppSection + 'Nominativo');
  FTipoUser.AsString := TLocalStorage.getValue(AppSection + 'TipoUser');
  FOnnipotente := TLocalStorage.getValue(AppSection + 'Admin').ToBoolean;
  FIdSessione := TLocalStorage.getValue(AppSection + 'IdSessione').ToInteger;
  //
  FIdRisorsa := TLocalStorage.getValue(AppSection + 'IdRisorsa').ToInteger;
  FAnnoFormativo := TLocalStorage.getValue(AppSection + 'AnnoFormativo').ToInteger;
  FAnnoFormativoDesc := TLocalStorage.getValue(AppSection + 'AnnoFormativoDesc');
  //
  FDarkTheme := TLocalStorage.getValue(AppSection + 'DarkTheme') = 'true';
end;

procedure TUser.SaveToStorage;
begin
  TLocalStorage.setValue(AppSection + 'UserName', UserName);
  TLocalStorage.setValue(AppSection + 'UserID', UserID.ToString);
  TLocalStorage.setValue(AppSection + 'Nominativo', Nominativo);
  TLocalStorage.setValue(AppSection + 'TipoUser', TipoUser.AsString);
  TLocalStorage.setValue(AppSection + 'Admin', Onnipotente.ToString);
  TLocalStorage.setValue(AppSection + 'IdSessione', IdSessione.ToString);
  ///
  TLocalStorage.setValue(AppSection + 'IdRisorsa', IdRisorsa.ToString);
  TLocalStorage.setValue(AppSection + 'AnnoFormativo', AnnoFormativo.ToString);
  TLocalStorage.setValue(AppSection + 'AnnoFormativoDesc', AnnoFormativoDesc);
  //
  if DarkTheme then
    TLocalStorage.setValue(AppSection + 'DarkTheme', 'true')
  else
    TLocalStorage.setValue(AppSection + 'DarkTheme', 'false');
end;

function TUser.IsStored: boolean;
begin
  Result := not TLocalStorage.getValue(AppSection + 'UserID').IsEmpty;
end;

function TUser.GetOnnipotente: boolean;
begin
  Result := FOnnipotente;
end;

function TUser.PasswordScaduta: boolean;
begin
  Result := DataScadenzaPassword < Date;
end;

function TTipoUserHelper.GetAsString: String;
begin
  case self of
    // SYSTEM          = #
    // SUPER           = X
    // DOCENTE         = D
    // PERSONALE       = P
    // TUTOR AZIENDALE = T
    // STUDENTE        = S
    // GENITORE        = G
    tuSystem:
      Result := '#';
    tuSuper:
      Result := 'X';
    tuDocente:
      Result := 'D';
    tuPersonale:
      Result := 'P';
    tuTutor:
      Result := 'T';
    tuStudente:
      Result := 'S';
    tuGenitore:
      Result := 'G';
  end;
end;

procedure TTipoUserHelper.SetAsString(const Value: String);
var
  i: integer;
begin
  i := IndexStr(Value, ['#', 'X', 'D', 'P', 'T', 'S', 'G']);
  self := TTipoUser(i);
end;

procedure TTipoUserHelper.Check(allowedTipoUser: TTipoUser);
begin
  if allowedTipoUser <> self then
    raise Exception.Create('Autorizzazione non valida.');
end;

procedure TTipoUserHelper.Check(allowedTipiUser: TTipiUser);
begin
  if not(self in allowedTipiUser) then
    raise Exception.Create('Autorizzazione non valida.');
end;

initialization

user.Clear;

end.
