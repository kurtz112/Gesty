// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-14
// ---------------------------------------------------------------------------

unit zAI.Driver.Ollama;

// Driver Ollama con l'invio grezzo di un JSON (ExecuteJSONRequest).
//
// Il driver SmartCoreAI di Ollama (TAIOllamaDriver) dichiara
// ExecuteJSONRequest ma il corpo si limita a sollevare "JSON Structured
// generation is not supported" (SmartCoreAI.Driver.Ollama.pas, riga 749).
// Senza quel canale il function calling non ha modo di raggiungere
// /api/chat, che e' l'unico endpoint di Ollama che accetta gli strumenti:
// il driver parla solo con /api/generate.
//
// Questa sottoclasse sovrascrive il solo ExecuteJSONRequest, con la stessa
// forma di quello del driver OpenAI: registra la richiesta (BeginRequest),
// crea il client HTTP con l'adattatore dei tempi di attesa
// (FHttpClientCustomizer), spedisce nel thread di lavoro (Run) e consegna al
// ricevitore la risposta intera, oppure l'errore. Tutto il resto (Chat,
// elenco dei modelli, prova di connessione, parametri) resta del driver
// SmartCoreAI.
//
// Il motore (zAI.Engine, DriverClassOf) crea questa classe al posto di
// TAIOllamaDriver quando il fornitore configurato e' 'Ollama'. Il nome del
// driver resta 'Ollama': lo restituisce InternalGetDriverName della base.

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  SmartCoreAI.Types,
  SmartCoreAI.Driver.Ollama;

type
  TzAIOllamaDriver = class(TAIOllamaDriver)
  public
    // AEndpoint e' relativo a BaseURL ('/chat'). AParams e' il corpo JSON.
    // Il ricevitore viene richiamato sul thread scelto da SynchronizeEvents,
    // con la risposta intera (DoSuccess) o con l'errore (DoError)
    function ExecuteJSONRequest(const AEndpoint: string; const AParams: string;
      const ACallback: IAIJSONCallback): TGUID; override;
  end;

implementation

uses
  System.Net.HttpClient,
  SmartCoreAI.Consts,
  SmartCoreAI.Exceptions,
  SmartCoreAI.HttpClientConfig;

const
  JsonContentType = 'application/json';

resourcestring
  MsgRicevitoreMancante = 'Nessun ricevitore per la richiesta JSON al driver Ollama.';
  MsgIndirizzoMancante = 'Indirizzo del servizio Ollama non configurato.';
  MsgErroreHttp = 'HTTP Error %d: %s';
  MsgRispostaNonJson = 'Il servizio Ollama ha risposto con un contenuto che non e'' JSON.';

{ TzAIOllamaDriver }

function TzAIOllamaDriver.ExecuteJSONRequest(const AEndpoint: string;
  const AParams: string; const ACallback: IAIJSONCallback): TGUID;
var
  HttpClient: THTTPClient;
  RequestId: TGUID;
  State: TAIRequestState;
  BaseURL: string;
begin
  State := BeginRequest(RequestId);
  Result := RequestId;

  // I parametri si leggono coi nomi di SmartCoreAI.Consts: sono gli stessi
  // che il motore scrive in Params. Gli aiuti AsPath/AsString della classe
  // dei parametri sono protetti, quindi si passa da Values
  BaseURL := Trim(Params.Values[cOllama_FldName_BaseURL]);

  if BaseURL = '' then
    BaseURL := cOllama_BaseURL;

  if not Assigned(ACallback) then
  begin
    EndRequest(RequestId);
    raise EAIException.Create(MsgRicevitoreMancante);
  end;

  if BaseURL = '' then
  begin
    EndRequest(RequestId);
    InvokeEvent(procedure begin ACallback.DoError(MsgIndirizzoMancante); end);
    Exit;
  end;

  HttpClient := TAIHttpClientConfig.CreateClient(FHttpClientCustomizer);
  Run(State, RequestId, HttpClient,
    procedure
    var
      Response: IHTTPResponse;
      Body: TStringStream;
      Url: string;
      ResponseText: string;
      ResponseJson: TJSONValue;
      ResponseObject: TJSONObject;
    begin
      Url := TAIUtil.GetSafeFullURL(BaseURL, [AEndpoint]);
      HttpClient.ContentType := JsonContentType;

      Body := TStringStream.Create(AParams, TEncoding.UTF8);
      try
        try
          Response := HttpClient.Post(Url, Body);
        except
          on E: Exception do
          begin
            InvokeEvent(procedure begin ACallback.DoError(E.Message); end);
            Exit;
          end;
        end;
      finally
        Body.Free;
      end;

      if State.Cancelled then
        Exit;

      ResponseText := Response.ContentAsString(TEncoding.UTF8);

      if not TAIUtil.IsSuccessfulResponse(Response) then
      begin
        // Ollama mette il motivo in {"error": "..."}: si passa il testo
        // intero, che il protocollo sa leggere, preceduto dal codice HTTP
        InvokeEvent(
          procedure
          begin
            ACallback.DoError(Format(MsgErroreHttp, [Response.StatusCode, Response.StatusText]) +
              sLineBreak + TAIUtil.TryExtractError(Response));
          end);
        Exit;
      end;

      ResponseJson := TJSONObject.ParseJSONValue(ResponseText);
      try
        if not (ResponseJson is TJSONObject) then
        begin
          InvokeEvent(procedure begin ACallback.DoError(MsgRispostaNonJson); end);
          Exit;
        end;

        ResponseObject := TJSONObject(ResponseJson);

        // Stessa sequenza degli altri driver: prima PopulateDataset, poi
        // DoSuccess con il testo intero. Il testo si copia PRIMA di
        // accodare l'evento, perche' l'oggetto muore col finally
        if ACallback.PopulateDataset(ResponseObject) then
        begin
          ResponseText := ResponseObject.ToJSON;
          InvokeEvent(procedure begin ACallback.DoSuccess(ResponseText); end);
        end
        else
          InvokeEvent(procedure begin ACallback.DoError(TAIUtil.TryExtractError(Response)); end);
      finally
        ResponseJson.Free;
      end;
    end);
end;

end.
