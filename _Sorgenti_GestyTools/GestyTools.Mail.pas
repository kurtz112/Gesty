unit GestyTools.Mail;

interface

uses
  System.SysUtils,
  System.Classes,
  IdSSL,
  zNet.Tls,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  IdMessage,
  IdSASL,
  IdUserPassProvider;

type
  TMail = class(TDataModule)
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
  private
    // creato in SendMail dalla fabbrica registrata in zNet.Tls
    SocketTls: TIdSSLIOHandlerSocketBase;
    procedure InitMessage(IdMessage: TIdMessage);
    procedure SendMail(IdMessage: TIdMessage);
  public
    procedure SegnalaEccezione(e: exception);
    procedure InviaMail(Const Subject, Body: string);
  end;

var
  Mail: TMail;

implementation

uses
  IdText,
  IdMessageParts,
  IdGlobal,
  IdSASLLogin,
  IdEMailAddress,
  IdSASLAnonymous,
  IdSASLDigest,
  IdSASLOTP,
  IdSASL_CRAM_MD5,
  IdSASLPlain,
  IdSASL_CRAM_SHA1,
  IdSASLSKey,
  IdLogEvent,
  IdAttachmentFile,
  IdSASLUserPass,
  GestyTools.Log,
  GestyTools.Config;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

type
  TIdSASLClass = class of TIdSASL;

procedure TMail.SendMail(IdMessage: TIdMessage);
var
  IdSASLLogin: TIdSASLLogin;
  SASLAnonymous: TIdSASLAnonymous;
  SASLDigest: TIdSASLDigest;
  SASLLogin: TIdSASLLogin;
  SASLOTP: TIdSASLOTP;
  SASLMD5: TIdSASLCRAMMD5;
  SASLPlain: TIdSASLPlain;
  SASLSHA1: TIdSASLCRAMSHA1;
  SASLSkey: TIdSASLSKey;
  UserPassProvider: TIdUserPassProvider;
  AuthenticationType: TIdSMTPAuthenticationType;
  Password: string;
  UserName: string;

  procedure AddSASL(IdSASLClass: TIdSASLClass);
  var
    IdSASL: TIdSASL;
  begin
    IdSASL := IdSASLClass.Create(IdSMTP);
    IdSMTP.SASLMechanisms.Add.SASL := IdSASL;

    if IdSASL is TIdSASLUserPass then
      TIdSASLUserPass(IdSASL).UserPassProvider := UserPassProvider;
  end;

begin
  // recuperare da ini info (tipo capac/codebri/altri)
  UserName := 'zebro.it';
  Password := 'Tala**71';

  // handler creato dalla fabbrica registrata in zNet.Tls: oggi OpenSSL,
  // domani SChannel, senza toccare questa unit. Stessa versione fissa
  // (TLS 1.2) che il vecchio componente IdSSL imponeva nel .dfm
  FreeAndNil(SocketTls);
  SocketTls := CreaIOHandlerTls(Self, tlsVersione1_2);
  SocketTls.MaxLineAction := maException;

  IdSMTP.IOHandler := SocketTls;
  IdSMTP.ConnectTimeout := 30000;
  // IdSMTP.useTLS := ssl; // prima di settare la porta, potrebbe variarla
  // IdSMTP.Host := Host;
  // IdSMTP.Port := Port;
  IdSMTP.UserName := UserName;
  IdSMTP.Password := Password;
  IdSMTP.UseEhlo := True; // (https://stackoverflow.com/questions/17734414/using-indy-10-smtp-with-office365)

  UserPassProvider := TIdUserPassProvider.Create;
  UserPassProvider.UserName := UserName;
  UserPassProvider.Password := Password;

  // SASL mechanisms are declared and added in descending order of security
  // (as far as that can be known -- not all units give a value for FSecurityLevel).
  AddSASL(TIdSASLOTP);
  AddSASL(TIdSASLSKey);
  AddSASL(TIdSASLCRAMSHA1);
  AddSASL(TIdSASLCRAMMD5);
  AddSASL(TIdSASLLogin);
  AddSASL(TIdSASLDigest);
  AddSASL(TIdSASLPlain);
  AddSASL(TIdSASLAnonymous); // (least secure)

  IdSMTP.ValidateAuthLoginCapability := false;

  IdSMTP.Connect();
  try
    IdSMTP.Send(IdMessage);
  finally
    IdSMTP.Disconnect();
  end;
end;

procedure TMail.InitMessage(IdMessage: TIdMessage);
var
  IdEMailAddressItem: TIdEMailAddressItem;
begin
  IdMessage.Clear;
  IdEMailAddressItem := IdMessage.Recipients.Add;
  IdEMailAddressItem.Name := 'Assistenza';
  IdEMailAddressItem.Address := 'assistenza@zebro.it';
end;

procedure TMail.InviaMail(const Subject, Body: string);
begin
  InitMessage(IdMessage);
  IdMessage.Subject := Subject;
  IdMessage.Body.Text := Body;

  SendMail(IdMessage);
end;

procedure TMail.SegnalaEccezione(e: exception);
var
  Body: TStringList;
begin
  InitMessage(IdMessage);

  Body := TStringList.Create;
  try
    Body.Add('Errore Script');
    Body.Add('DB: ' + Config.Ente);
    Body.Add('');
    Body.Add(e.Message);

    InviaMail(Config.Ente + ' - Errore Script', Body.Text);
  finally
    FreeAndNil(Body);
  end;
end;

end.
