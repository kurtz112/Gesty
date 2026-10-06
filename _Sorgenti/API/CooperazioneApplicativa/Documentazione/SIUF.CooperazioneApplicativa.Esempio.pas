unit SIUF.CooperazioneApplicativa.Esempio;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Data.DB,
  SIUF.CooperazioneApplicativa.Types,
  SIUF.CooperazioneApplicativa.Validator;

type

  /// Esempio: dataset GRS_EXPORT già aperto -> validazione -> invio presenze a SIUF EOB.
  /// Restituisce l'esito; solleva ESiufValidazione se la validazione fallisce,
  /// ESiufCoopError su errore di trasporto.
function InviaPresenzeSiuf(ADataset: TDataSet; const ACodiceFiscaleUser: string; AIdSezione: Integer; const ADataInizio, ADataFine: TDate): TSiufEsito;

implementation

uses
  SIUF.CooperazioneApplicativa.Builder,
  SIUF.CooperazioneApplicativa.Client;

function InviaPresenzeSiuf(ADataset: TDataSet; const ACodiceFiscaleUser: string; AIdSezione: Integer; const ADataInizio, ADataFine: TDate): TSiufEsito;
var
  Cfg: TSiufCoopConfig;
  Client: TSiufCoopClient;
  Payload: TSiufPayload;
  Violazioni: TList<TSiufViolazione>;
begin
  // Riaprire con idProgetto, data inizio/fine?

  // Parametri in funzione di Ente
  // --- configurazione endpoint/credenziali (ambiente di test) ---
  Cfg.Url := 'http://51.144.72.49:9080/geco/presenzecall/api/importaPresenze';
  Cfg.IdentificativoEnte := '486002520631';
  Cfg.Username := 'utente40';
  Cfg.Code := 'qKbvCSDEY3255!';

  Salvare al termine

  // Parametri in funzione di Progetto
  // AIdSezione

  // Parametri in funzione dell'utente di login
  // ACodiceFiscaleUser

  // Registrare esito

  ///////

  Payload := TSiufPayloadBuilder.Build(ADataset, ACodiceFiscaleUser, AIdSezione, ADataInizio, ADataFine);
  try
    // --- validazione client-side bloccante: raccoglie tutte le violazioni ---
    if not TSiufValidator.EValido(Payload, Violazioni) then
      try
        raise ESiufValidazione.CreateFromList(Violazioni);
      finally
        Violazioni.Free;
      end
    else
      Violazioni.Free;

    Client := TSiufCoopClient.Create(Cfg);
    try
      Result := Client.Invia(Payload);
    finally
      Client.Free;
    end;
  finally
    Payload.Free;
  end;
end;

end.
