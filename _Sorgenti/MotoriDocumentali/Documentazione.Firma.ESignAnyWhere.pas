unit Documentazione.Firma.ESignAnyWhere;

// Provider di firma eSignAnyWhere (busta/envelope) per Gesty.
// Avvolge il transport esistente TeSignAnyWhereEngine (eSignAnyWhere.pas),
// che NON viene modificato, dietro il contratto IzFirmaProvider di
// zDocumentale. Il provider non tocca mai il database: le versioni
// FIR/RIC nascono dalla callback OnCreaVersione (agganciata da Documentazione.Bridge.Firma a
// OBJ_FILES_VERSIONE_ADD) e il log passa da OnLogRequest/OnLogResponse.
//
// Mappatura firmatari -> slot dell'engine (vincolo attuale del transport,
// tre slot fissi): i firmatari con IdentificativoFirmaRemota valorizzato
// occupano FirmaRemota1 e FirmaRemota2 (nell'ordine), quello senza
// identificativo diventa FirmaOTP. Piu' di due firme remote o piu' di una
// OTP sollevano EzFirmaErrore: il limite e' del transport, non del modello
// (punto aperto n.13 dell'analisi).
//
// Auto-registrazione: basta includere questa unit nel .dpr.

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.IOUtils,
  zDocumentale.Firma.Types,
  zDocumentale.Firma.Intf,
  zDocumentale.Firma.ProviderBase,
  zDocumentale.Firma.Factory,
  ESignAnyWhere;

const
  FIRMA_FORNITORE_ESIGNANYWHERE = 'ESIGNANYWHERE';

type
  TzFirmaESignAnyWhereProvider = class(TzFirmaProviderBase)
  private
    procedure ApplicaConfigurazioneEngine;
    procedure ApplicaFirmatariEngine(const Documento: TzFirmaDocumento);
    function StatoDaEnvelopeStatus(const EnvelopeStatus: string): string;
  public
    function Nome: string; override;
    function Funzionalita: TzFirmaFunzionalitaSet; override;
    procedure TestConnessione; override;

    // invia la busta: ritorna Stato 'D' (in firma) con l'envelope id
    function Firma(const Documento: TzFirmaDocumento): TzFirmaEsito; override;

    // polling: se la busta risulta completata scarica firmato + audit
    // creando le versioni FIR/RIC via OnCreaVersione
    function AggiornaEstremi(const Documento: TzFirmaDocumento; const IdDocumentoEsterno: string): TzFirmaEsito; override;
  end;

implementation

uses
  ESignAnyWhere.params;

function TzFirmaESignAnyWhereProvider.Nome: string;
begin
  result := FIRMA_FORNITORE_ESIGNANYWHERE;
end;

function TzFirmaESignAnyWhereProvider.Funzionalita: TzFirmaFunzionalitaSet;
begin
  result := [ffFirma];
end;

procedure TzFirmaESignAnyWhereProvider.TestConnessione;
begin
  ApplicaConfigurazioneEngine;

  if not eSignAnyWhereEngine.Validate then
    raise EzFirmaErrore.Create('eSignAnyWhere: validazione della connessione fallita');
end;

procedure TzFirmaESignAnyWhereProvider.ApplicaConfigurazioneEngine;

  function ParametroBoolean(const Chiave: string; const Default: Boolean): Boolean;
  begin
    result := SameText(FConfigurazione.Parametro(Chiave, IfThen(Default, 'S', 'N')), 'S');
  end;

  function ParametroIntero(const Chiave: string; const Default: Integer): Integer;
  begin
    result := StrToIntDef(FConfigurazione.Parametro(Chiave, Default.ToString), Default);
  end;

begin
  eSignAnyWhereEngine.BaseUrl := FConfigurazione.UrlBase;
  eSignAnyWhereEngine.AuthToken := FConfigurazione.Parametro('AUTH_TOKEN');

  eSignAnyWhereEngine.params.LogResponse := ParametroBoolean('LOG_RESPONSE', False);
  eSignAnyWhereEngine.params.AddDocumentTimestamp := ParametroBoolean('ADD_DOCUMENT_TIMESTAMP', False);
  eSignAnyWhereEngine.params.ShareWithTeam := ParametroBoolean('SHARE_WITH_TEAM', False);
  eSignAnyWhereEngine.params.Reminder := ParametroBoolean('REMINDER', True);
  eSignAnyWhereEngine.params.FirstReminderInDays := ParametroIntero('FIRST_REMINDER_IN_DAYS', 1);
  eSignAnyWhereEngine.params.ReminderResendIntervalInDays := ParametroIntero('REMINDER_RESEND_INTERVAL_IN_DAYS', 1);
  eSignAnyWhereEngine.params.BeforeExpirationInDays := ParametroIntero('BEFORE_EXPIRATION_IN_DAYS', 3);
  eSignAnyWhereEngine.params.ExpirationInSecondsAfterSending := ParametroIntero('EXPIRATION_IN_SECONDS_AFTER_SENDING', 2419200);

  if not FConfigurazione.Parametro('EMAIL_CONFIGURATION_SUBJECT').IsEmpty then
    eSignAnyWhereEngine.params.EmailConfigurationSubject := FConfigurazione.Parametro('EMAIL_CONFIGURATION_SUBJECT');
  if not FConfigurazione.Parametro('EMAIL_CONFIGURATION_MESSAGE').IsEmpty then
    eSignAnyWhereEngine.params.EmailConfigurationMessage := FConfigurazione.Parametro('EMAIL_CONFIGURATION_MESSAGE');
end;

procedure TzFirmaESignAnyWhereProvider.ApplicaFirmatariEngine(const Documento: TzFirmaDocumento);

  procedure ApplicaFirmatario(var Slot: TeSignAnyWhereEmailParams; const Firmatario: TzFirmaFirmatario);
  begin
    Slot.Placeholder := Firmatario.Placeholder;
    Slot.Cognome := Firmatario.Cognome;
    Slot.Nome := Firmatario.Nome;
    Slot.Email := Firmatario.Email;
    Slot.Telefono := Firmatario.Telefono;
    Slot.IdentificativoFirmaRemota := Firmatario.IdentificativoFirmaRemota;
  end;

var
  Firmatario: TzFirmaFirmatario;
  SlotRemoto: TeSignAnyWhereEmailParams;
  IndiceRemoto: Integer;
  IndiceOtp: Integer;
begin
  IndiceRemoto := 0;
  IndiceOtp := 0;

  for Firmatario in Documento.Firmatari do
  begin
    if not Firmatario.IdentificativoFirmaRemota.IsEmpty then
    begin
      Inc(IndiceRemoto);
      case IndiceRemoto of
        1:
          begin
            SlotRemoto := eSignAnyWhereEngine.params.FirmaRemota1;
            ApplicaFirmatario(SlotRemoto, Firmatario);
            eSignAnyWhereEngine.params.FirmaRemota1 := SlotRemoto;
          end;
        2:
          begin
            SlotRemoto := eSignAnyWhereEngine.params.FirmaRemota2;
            ApplicaFirmatario(SlotRemoto, Firmatario);
            eSignAnyWhereEngine.params.FirmaRemota2 := SlotRemoto;
          end;
      else
        raise EzFirmaErrore.Create('eSignAnyWhere: il transport attuale gestisce al massimo due firme remote per busta');
      end;
    end
    else
    begin
      Inc(IndiceOtp);
      if IndiceOtp > 1 then
        raise EzFirmaErrore.Create('eSignAnyWhere: il transport attuale gestisce al massimo una firma OTP per busta');

      SlotRemoto := eSignAnyWhereEngine.params.FirmaOTP;
      ApplicaFirmatario(SlotRemoto, Firmatario);
      eSignAnyWhereEngine.params.FirmaOTP := SlotRemoto;
    end;
  end;
end;

function TzFirmaESignAnyWhereProvider.Firma(const Documento: TzFirmaDocumento): TzFirmaEsito;
var
  IdLogRequest: Int64;
begin
  result.Clear;

  if Documento.FullFileName.IsEmpty or not TFile.Exists(Documento.FullFileName) then
    raise EzFirmaErrore.CreateFmt('File da firmare non trovato: "%s"', [Documento.FullFileName]);

  ApplicaConfigurazioneEngine;

  eSignAnyWhereEngine.params.EnvelopeName := ExtractFileName(Documento.FullFileName);
  eSignAnyWhereEngine.params.Ident := Documento.IdObjectFile.ToString;

  ApplicaFirmatariEngine(Documento);

  IdLogRequest := LogRequest('FIRMA', eSignAnyWhereEngine.BaseUrl, Documento.FullFileName + sLineBreak + 'AUTH_TOKEN length=' + eSignAnyWhereEngine.AuthToken).ToString.ToInteger();
  try
    result.IdDocumentoEsterno := eSignAnyWhereEngine.Firma(Documento.FullFileName);
  except
    on E: Exception do
    begin
      LogResponse(IdLogRequest, 0, eSignAnyWhereEngine.RESTResponse.Content, E.Message);
      raise;
    end;
  end;
  LogResponse(IdLogRequest, eSignAnyWhereEngine.RESTResponse.StatusCode, eSignAnyWhereEngine.RESTResponse.Content, '');

  result.Ok := True;
  result.Stato := FIRMA_STATO_IN_FIRMA; // 'D': busta inviata, in attesa dei firmatari
  result.StatoEsterno := 'Sent';
end;

function TzFirmaESignAnyWhereProvider.StatoDaEnvelopeStatus(const EnvelopeStatus: string): string;
begin
  if SameText(EnvelopeStatus, 'Completed') then
    result := FIRMA_STATO_FIRMATA
  else
    if SameText(EnvelopeStatus, 'Rejected') or SameText(EnvelopeStatus, 'Canceled') then
      result := FIRMA_STATO_RESPINTA
    else
      if SameText(EnvelopeStatus, 'Expired') then
        result := FIRMA_STATO_SCADUTA
      else
        result := FIRMA_STATO_IN_FIRMA;
end;

function TzFirmaESignAnyWhereProvider.AggiornaEstremi(const Documento: TzFirmaDocumento; const IdDocumentoEsterno: string): TzFirmaEsito;
var
  IdLogRequest: Int64;
  VersioneFirmata: TzFirmaVersioneCreata;
  VersioneAudit: TzFirmaVersioneCreata;
begin
  result.Clear;

  if IdDocumentoEsterno.IsEmpty then
    raise EzFirmaErrore.Create('eSignAnyWhere: envelope id mancante');

  ApplicaConfigurazioneEngine;
  eSignAnyWhereEngine.params.EnvelopeId := IdDocumentoEsterno;

  IdLogRequest := LogRequest('STATO', eSignAnyWhereEngine.BaseUrl, IdDocumentoEsterno);
  try
    result.StatoEsterno := eSignAnyWhereEngine.EnvelopeStatus;
  except
    on E: Exception do
    begin
      LogResponse(IdLogRequest, 0, eSignAnyWhereEngine.RESTResponse.Content, E.Message);
      raise;
    end;
  end;
  LogResponse(IdLogRequest, eSignAnyWhereEngine.RESTResponse.StatusCode, '', '');

  result.Ok := True;
  result.IdDocumentoEsterno := IdDocumentoEsterno;
  result.Stato := StatoDaEnvelopeStatus(result.StatoEsterno);

  if result.Stato <> FIRMA_STATO_FIRMATA then
    exit;

  // busta completata: le nuove versioni della catena nascono dalla
  // callback del ponte (id e path calcolati dal DB), poi il download
  // scrive i byte direttamente nelle posizioni definitive
  VersioneFirmata := CreaVersione(Documento.IdObjectFile, 'FIR', TPath.GetFileNameWithoutExtension(Documento.FullFileName) + '_firmato.pdf', '_firmato');
  VersioneAudit := CreaVersione(VersioneFirmata.IdObjectFile, 'RIC', TPath.GetFileNameWithoutExtension(Documento.FullFileName) + '_audit.pdf', '_audit');

  IdLogRequest := LogRequest('DOWNLOAD', eSignAnyWhereEngine.BaseUrl, IdDocumentoEsterno);
  try
    eSignAnyWhereEngine.DownloadFiles(VersioneFirmata.FullFileName, VersioneAudit.FullFileName);
  except
    on E: Exception do
    begin
      LogResponse(IdLogRequest, 0, eSignAnyWhereEngine.RESTResponse.Content, E.Message);
      raise;
    end;
  end;
  LogResponse(IdLogRequest, eSignAnyWhereEngine.RESTResponse.StatusCode, '', '');

  result.IdObjectFileFirmato := VersioneFirmata.IdObjectFile;
  result.IdObjectFileAudit := VersioneAudit.IdObjectFile;
end;

initialization

TzFirmaFactory.Registra(FIRMA_FORNITORE_ESIGNANYWHERE, TzFirmaESignAnyWhereProvider);

end.
