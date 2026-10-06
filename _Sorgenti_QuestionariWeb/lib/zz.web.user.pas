unit zz.web.user;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TRuolo = (trOnnipotente, trSoftline, trEnteGestore, trComune, trIntestatario, trOperatoreGera, trSistema);

  TRuoloHelper = record helper for TRuolo
  public
    function ToString(): string;
  end;

  TUser = record
    UserName: string;
    UserID: integer;
    Nominativo: String;
    Ruolo: TRuolo;
    Onnipotente: boolean;
    DataScadenzaPassword: TDate;
    IdSessione: integer;
    IdIntestatario: integer;
    IdOperatore: integer;
    OperatoreIsImpiegato: boolean;
    OperatoreIsOperaio: boolean;
    OperatoreIsAutoriparatore: boolean;
  public
    procedure Clear;
    procedure ClearStorage;
    procedure LoadFromStorage;
    procedure SaveToStorage;

    procedure SetRuolo(const value: String);
  end;

var
  User: TUser;

implementation

uses
  System.StrUtils,
  WEBLib.Storage,
  zz.web.JS,
  JS,
  web;

{ TRuoloHelper }

function TRuoloHelper.ToString: string;
begin
  case self of
    trOnnipotente:
      result := 'A';
    trSoftline:
      result := 'S';
    trEnteGestore:
      result := 'E';
    trComune:
      result := 'C';
    trIntestatario:
      result := 'I';
    trOperatoreGera:
      result := 'O';
    trSistema:
      result := 'X';
  end;
end;

function RuoloFromString(const value: string): TRuolo;
begin
  result := trSistema;

  if value = 'A' then
    result := trOnnipotente
  else
    if value = 'S' then
      result := trSoftline
    else
      if value = 'E' then
        result := trEnteGestore
      else
        if value = 'C' then
          result := trComune
        else
          if value = 'I' then
            result := trIntestatario
          else
            if value = 'O' then
              result := trOperatoreGera
            else
              if value = 'X' then
                result := trSistema;
end;

procedure TUser.Clear;
begin
  UserName := '';
  UserID := -1;
  Onnipotente := false;
  Ruolo := trSistema;
  DataScadenzaPassword := 0;
  IdSessione := -1;
  IdIntestatario := -1; // intestatario con scadenza insolute
  IdOperatore := -1;
  Nominativo := '';
  OperatoreIsImpiegato := false;
  OperatoreIsOperaio := false;
  OperatoreIsAutoriparatore := false;
end;

procedure TUser.ClearStorage;
begin
  TLocalStorage.RemoveKey('WtWeb_UserName');
  TLocalStorage.RemoveKey('WtWeb_UserID');
  TLocalStorage.RemoveKey('WtWeb_Nominativo');
  TLocalStorage.RemoveKey('WtWeb_Ruolo');
  TLocalStorage.RemoveKey('WtWeb_Admin');
  TLocalStorage.RemoveKey('WtWeb_IdSessione');
  TLocalStorage.RemoveKey('WtWeb_IdIntestatario');
  TLocalStorage.RemoveKey('WtWeb_IdOperatore');
  TLocalStorage.RemoveKey('WtWeb_OperatoreIsImpiegato');
  TLocalStorage.RemoveKey('WtWeb_OperatoreIsOperaio');
  TLocalStorage.RemoveKey('WtWeb_OperatoreIsAutoriparatore');
end;

procedure TUser.LoadFromStorage;
begin
  Clear;

  if TLocalStorage.getValue('WtWeb_UserID').IsEmpty then
    Exit;

  UserName := TLocalStorage.getValue('WtWeb_UserName');
  UserID := TLocalStorage.getValue('WtWeb_UserID').ToInteger;
  Nominativo := TLocalStorage.getValue('WtWeb_Nominativo');
  SetRuolo(TLocalStorage.getValue('WtWeb_Ruolo'));
  Onnipotente := TLocalStorage.getValue('WtWeb_Admin').ToBoolean;
  IdIntestatario := TLocalStorage.getValue('WtWeb_IdIntestatario').ToInteger;
  IdSessione := TLocalStorage.getValue('WtWeb_IdSessione').ToInteger;
  IdOperatore := TLocalStorage.getValue('WtWeb_IdOperatore').ToInteger;

  OperatoreIsImpiegato := TLocalStorage.getValue('WtWeb_OperatoreIsImpiegato').ToBoolean;
  OperatoreIsOperaio := TLocalStorage.getValue('WtWeb_OperatoreIsOperaio').ToBoolean;
  OperatoreIsAutoriparatore := TLocalStorage.getValue('WtWeb_OperatoreIsAutoriparatore').ToBoolean;
end;

procedure TUser.SaveToStorage;
begin
  TLocalStorage.setValue('WtWeb_UserName', UserName);
  TLocalStorage.setValue('WtWeb_UserID', UserID.ToString);
  TLocalStorage.setValue('WtWeb_Nominativo', Nominativo);
  TLocalStorage.setValue('WtWeb_Ruolo', Ruolo.ToString);
  TLocalStorage.setValue('WtWeb_Admin', Onnipotente.ToString);
  TLocalStorage.setValue('WtWeb_IdSessione', IdSessione.ToString);
  TLocalStorage.setValue('WtWeb_IdIntestatario', IdIntestatario.ToString);
  TLocalStorage.setValue('WtWeb_IdOperatore', IdOperatore.ToString);
  TLocalStorage.setValue('WtWeb_OperatoreIsImpiegato', OperatoreIsImpiegato.ToString);
  TLocalStorage.setValue('WtWeb_OperatoreIsOperaio', OperatoreIsOperaio.ToString);
  TLocalStorage.setValue('WtWeb_OperatoreIsAutoriparatore', OperatoreIsAutoriparatore.ToString);
end;

procedure TUser.SetRuolo(const value: String);
begin
  Ruolo := RuoloFromString(value);
end;

initialization

User.Clear;

end.
