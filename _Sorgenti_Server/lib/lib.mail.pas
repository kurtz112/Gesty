unit lib.mail;

interface

function SendMail(const ReplayAddress: string; const DestAddress: string; const Subject: string; const Body: string; const BodyHTML: string): Boolean;

implementation

uses
  System.SysUtils,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  IdMessage,
  IdText,
  IdSSL,
  zNet.Tls,
  IdGlobal,
  lib.Config,
  zz.SmartInspect;

function SendMail(const ReplayAddress: string; const DestAddress: string; const Subject: string; const Body: string; const BodyHTML: string): Boolean;
  function CreateSSLHandler: TIdSSLIOHandlerSocketBase;
  begin
    result := nil;

    if not ConfigProps.SMTPServer_SSL then
      Exit;

    // handler creato dalla fabbrica registrata in zNet.Tls: oggi OpenSSL,
    // domani SChannel, senza toccare questa unit. Stessa versione fissa
    // (TLS 1.0) che il vecchio componente imponeva
    result := CreaIOHandlerTls(nil, tlsVersione1_0);
    result.MaxLineAction := maException;
  end;

var
  SMTPServer: TIdSMTP;
  SSLHandler: TIdSSLIOHandlerSocketBase;
  mail: TIdMessage;
  IdText: TIdText;

begin
  result := false;
  try
    SSLHandler := CreateSSLHandler;
    try
      SMTPServer := TIdSMTP.Create(nil);
      try
        SMTPServer.Host := ConfigProps.SMTPServer_Host;
        SMTPServer.Port := ConfigProps.SMTPServer_Port;
        SMTPServer.UserName := ConfigProps.SMTPServer_UserName;
        SMTPServer.Password := ConfigProps.SMTPServer_Password;

        if ConfigProps.SMTPServer_SSL then
        begin
          SMTPServer.IOHandler := SSLHandler;
          SMTPServer.UseTLS := utUseExplicitTLS;
        end;

        mail := TIdMessage.Create;
        try
          mail.From.Address := ReplayAddress;
          mail.Recipients.EMailAddresses := DestAddress;
          mail.Subject := Subject;
          simain.LogString('EMailAddresses', mail.Recipients.EMailAddresses);

          if (Body = '') and (BodyHTML = '') then
            raise Exception.Create('Testo del messaggio non configurato.')
          else
            if Body = '' then // solo html
            begin
              simain.LogVerbose('Mail solo html');
              mail.Body.Text := BodyHTML;
              mail.ContentType := 'text/html';
            end
            else
              if BodyHTML = '' then // solo testo
              begin
                simain.LogVerbose('Mail solo testo');
                mail.Body.Text := Body;
                mail.ContentType := 'text/plain';
              end
              else
              begin // entrambe
                simain.LogVerbose('Mail html+testo');
                IdText := TIdText.Create(mail.MessageParts, nil);
                IdText.Body.Text := Body;
                IdText.ContentType := 'text/plain';

                IdText := TIdText.Create(mail.MessageParts, nil);
                IdText.Body.Text := BodyHTML;
                IdText.ContentType := 'text/html';

                mail.ContentType := 'multipart/alternative';
              end;

          SMTPServer.Connect;
          simain.LogVerbose('Server mail connesso');
          SMTPServer.Send(mail);
          simain.LogVerbose('Mail inviata');
          result := True;
        finally
          FreeAndNil(mail);
        end;
      finally
        FreeAndNil(SMTPServer);
      end;
    finally
      FreeAndNil(SSLHandler);
    end;
  Except
    on E: Exception do
    begin
      simain.LogException(E, 'Problema invio mail.');
      raise;
    end;
  end;
end;

end.
