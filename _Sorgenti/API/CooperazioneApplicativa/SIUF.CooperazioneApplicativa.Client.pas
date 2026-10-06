unit SIUF.CooperazioneApplicativa.Client;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.NetEncoding,
  System.Net.HttpClient,
  System.Net.URLClient,
  SIUF.CooperazioneApplicativa.Types;

type
  TSiufCoopClient = class
  private
    FConfig: TSiufCoopConfig;
    function WrapBase64(const AInnerJson: string): string;
    function ParseEsito(const AResponseBody: string; AStatus: Integer): TSiufEsito;
    function ClassificaErrore(const AMessaggio: string): TSiufErroreTipo;
    function ParseDettaglioErrore(const AMessaggio: string; ATipo: TSiufErroreTipo): TSiufDettaglioErrore;
  public
    constructor Create(const AConfig: TSiufCoopConfig);
    /// Serializza, codifica, invia. Solleva ESiufCoopError su errore di trasporto.
    function Invia(APayload: TSiufPayload): TSiufEsito;
    /// Solo serializzazione+Base64, utile per debug/log senza inviare
    function BuildBody(APayload: TSiufPayload): string;
    /// JSON interno leggibile (NON Base64), per il dump su disco.
    function BuildReadableJson(APayload: TSiufPayload): string;
  end;

implementation

{ TSiufCoopClient }

constructor TSiufCoopClient.Create(const AConfig: TSiufCoopConfig);
begin
  inherited Create;
  FConfig := AConfig;
end;

function TSiufCoopClient.BuildReadableJson(APayload: TSiufPayload): string;
var
  Root, Item: TJSONObject;
  Arr: TJSONArray;
  Pres: TSiufPresenza;
begin
  Root := TJSONObject.Create;
  try
    Root.AddPair('codiceFiscaleUser', APayload.CodiceFiscaleUser);
    Root.AddPair('dataFine', APayload.DataFine);
    Root.AddPair('dataInizio', APayload.DataInizio);
    Root.AddPair('idSezione', TJSONNumber.Create(APayload.IdSezione));

    Arr := TJSONArray.Create;
    for Pres in APayload.ListaStudenti do
    begin
      Item := TJSONObject.Create;
      Item.AddPair('codiceFiscale', Pres.CodiceFiscale);
      Item.AddPair('codiceFiscaleDocente', Pres.CodiceFiscaleDocente);
      Item.AddPair('cognome', Pres.Cognome);
      Item.AddPair('nome', Pres.Nome);
      Item.AddPair('materia', Pres.Materia);
      Item.AddPair('contenutiMateria', Pres.ContenutiMateria);
      Item.AddPair('data', Pres.Data);
      Item.AddPair('oraFine', Pres.OraFine);
      Item.AddPair('oraInizio', Pres.OraInizio);
      Item.AddPair('oreAssenza', Pres.OreAssenza);
      Item.AddPair('oreAssenzaGiustificata', Pres.OreAssenzaGiustificata);
      Item.AddPair('orePresenza', Pres.OrePresenza);
      Item.AddPair('tipologia', TJSONNumber.Create(Pres.Tipologia));

      // Mantis #100 - 2026-09-11: il tracciato del canale ordinamentale
      // (paragrafo 1.4 delle specifiche IeFP) inserisce "sede" fra tipologia e
      // codocente, e aggiunge i tre campi di chiusura in coda. Sull'Extra
      // Obbligo questi campi non esistono: il paragrafo 1.4 EOB non li prevede
      // e l'invio oggi funziona senza, quindi non vanno serializzati.
      if APayload.Canale.HaCampiEstesi then
        Item.AddPair('sede', Pres.Sede);

      Item.AddPair('codiceFiscaleCoDocente', Pres.CodiceFiscaleCoDocente);

      if APayload.Canale.HaCampiEstesi then
      begin
        // I giorni di chiusura servono a non far scattare il "fuori limite"
        // sui termini di trasmissione (art. 6 del decreto). Quando non c'è una
        // chiusura da dichiarare i tre campi restano stringhe vuote, come
        // nell'esempio del paragrafo 1.6 delle specifiche IeFP.
        Item.AddPair('motivoChiusura', Pres.MotivoChiusura);
        Item.AddPair('dataInizioChiusura', Pres.DataInizioChiusura);
        Item.AddPair('dataFineChiusura', Pres.DataFineChiusura);
      end;

      Arr.AddElement(Item);
    end;
    Root.AddPair('listaStudenti', Arr);

    Result := Root.Format(4);
  finally
    Root.Free;
  end;
end;

function TSiufCoopClient.WrapBase64(const AInnerJson: string): string;
var
  B64: string;
  Outer: TJSONObject;
begin
  // Il JSON interno va codificato Base64 (UTF-8) e messo nella proprietà "payload"
  B64 := TNetEncoding.Base64.EncodeBytesToString(TEncoding.UTF8.GetBytes(AInnerJson));

  Outer := TJSONObject.Create;
  try
    Outer.AddPair('payload', B64);
    Result := Outer.ToJSON;
  finally
    Outer.Free;
  end;
end;

function TSiufCoopClient.BuildBody(APayload: TSiufPayload): string;
begin
  Result := WrapBase64(BuildReadableJson(APayload));
end;

// Estrae una sottostringa compresa tra AStart e AEnd (ricerca case-insensitive, mantiene case originale)
function ExtractBetween(const AText, AStart, AEnd: string): string;
var
  PStart, PEnd: Integer;
  TempText, TempStart, TempEnd: string;
  Temp: string;
begin
  Result := '';
  TempText := LowerCase(AText);
  TempStart := LowerCase(AStart);
  PStart := Pos(TempStart, TempText);
  if PStart > 0 then
  begin
    PStart := PStart + Length(AStart);
    if AEnd = '' then
      Result := Trim(Copy(AText, PStart, MaxInt))
    else
    begin
      Temp := Copy(AText, PStart, MaxInt);
      TempText := LowerCase(Temp);
      TempEnd := LowerCase(AEnd);
      PEnd := Pos(TempEnd, TempText);
      if PEnd > 0 then
        Result := Trim(Copy(Temp, 1, PEnd - 1));
    end;
  end;
end;

function TSiufCoopClient.ClassificaErrore(const AMessaggio: string): TSiufErroreTipo;
var
  M: string;
begin
  // Classificazione best-effort dell'errore server
  M := LowerCase(AMessaggio);
  if M = '' then
    Exit(setNessuno);

  if Pos('user inserito non esiste', M) > 0 then
    Result := setUserNonEsiste
  else
    if Pos('intervallo di date di più di 3 giorni', M) > 0 then
      Result := setIntervalloDateTroppoAmpio
    else
      if Pos('non risulta appartenere a nessun canale', M) > 0 then
        Result := setSezioneInesistente
      else
        if Pos('non risulta censito nel sistema', M) > 0 then
          Result := setStudenteNonCensito
        else
          if Pos('non risulta assegnato alla lezione', M) > 0 then
            Result := setStudenteNonInLezione
          else
            if Pos('non risulta essere un docente del corso', M) > 0 then
              Result := setDocenteNonDelCorso
            else
              if Pos('non risulta essere associato alla lezione', M) > 0 then
                Result := setDocenteNonInLezione
              else
                if Pos('non sono state trovate lezioni', M) > 0 then
                  Result := setLezioneNonTrovata
                else
                  if (Pos('precedente al campo datainizio', M) > 0) or (Pos('successivo al campo datafine', M) > 0) then
                    Result := setDataFuoriIntervallo
                  else
                    if Pos('non corrispondono i minuti assegnati', M) > 0 then
                      Result := setMinutiNonCorrispondenti
                    else
                      if Pos('assenze giustificate', M) > 0 then
                        Result := setAssenzaGiustificataNonZero
                      else
                        Result := setAltro;
end;

function TSiufCoopClient.ParseDettaglioErrore(const AMessaggio: string; ATipo: TSiufErroreTipo): TSiufDettaglioErrore;
begin
  Result := Default (TSiufDettaglioErrore);
  Result.TipoErrore := ATipo;
  Result.MessaggioOriginale := AMessaggio;

  case ATipo of
    setSezioneInesistente:
      begin
        Result.Sezione := ExtractBetween(AMessaggio, 'la sezione ', ' non risulta');
      end;
    setStudenteNonCensito:
      begin
        Result.Studente := ExtractBetween(AMessaggio, 'dello studente ', ', lo studente');
      end;
    setStudenteNonInLezione:
      begin
        Result.Studente := ExtractBetween(AMessaggio, 'dello studente ', ', lo studente');
        Result.CorsoLezione := ExtractBetween(AMessaggio, 'alla lezione ', '.');
      end;
    setDocenteNonDelCorso:
      begin
        Result.Studente := ExtractBetween(AMessaggio, 'dello studente ', ' il docente');
        Result.DocenteCoDocente := ExtractBetween(AMessaggio, 'docente o co-docente ', ' non risulta');
        Result.CorsoLezione := ExtractBetween(AMessaggio, 'del corso ', '');
      end;
    setDocenteNonInLezione:
      begin
        Result.Studente := ExtractBetween(AMessaggio, 'dello studente ', ' il docente');
        Result.Sezione := ExtractBetween(AMessaggio, 'della sezione ', ' , del giorno');
        Result.Data := ExtractBetween(AMessaggio, 'del giorno ', ' che inizia');
      end;
    setLezioneNonTrovata:
      begin
        Result.Studente := ExtractBetween(AMessaggio, 'dello studente ', ' per la sezione');
        Result.Sezione := ExtractBetween(AMessaggio, 'per la sezione ', ' non sono state');
        Result.Data := ExtractBetween(AMessaggio, 'in data ', ' con ora inizio');
      end;
    setDataFuoriIntervallo:
      begin
        Result.Studente := ExtractBetween(AMessaggio, 'dello studente ', ' il campo Data');
        Result.Data := ExtractBetween(AMessaggio, 'campo Data (', ') è precedente');
      end;
    setMinutiNonCorrispondenti:
      begin
        Result.Studente := ExtractBetween(AMessaggio, 'dello studente ', ' nella fascia oraria');
        Result.Data := ExtractBetween(AMessaggio, 'in data ', ' non corrispondono');
      end;
    setAssenzaGiustificataNonZero:
      begin
        Result.Studente := ExtractBetween(AMessaggio, 'dello studente ', ' in data');
        Result.Data := ExtractBetween(AMessaggio, 'in data ', ' risultano assenze');
      end;
  end;

  Result.Studente := Trim(Result.Studente);
  Result.Sezione := Trim(Result.Sezione);
  Result.DocenteCoDocente := Trim(Result.DocenteCoDocente);
  Result.CorsoLezione := Trim(Result.CorsoLezione);
  Result.Data := Trim(Result.Data);
end;

function TSiufCoopClient.ParseEsito(const AResponseBody: string; AStatus: Integer): TSiufEsito;
var
  JV: TJSONValue;
  JO: TJSONObject;
begin
  Result := Default (TSiufEsito);
  Result.HttpStatus := AStatus;
  Result.RawResponse := AResponseBody;
  Result.Tipo := setNessuno;

  JV := TJSONObject.ParseJSONValue(AResponseBody);
  try
    if JV is TJSONObject then
    begin
      JO := TJSONObject(JV);
      if JO.GetValue('esitoCaricamento') <> nil then
        Result.EsitoCaricamento := (JO.GetValue('esitoCaricamento') is TJSONTrue)
      else
        Result.EsitoCaricamento := (AStatus >= 200) and (AStatus < 300);

      if JO.GetValue('messaggio') <> nil then
        Result.Messaggio := JO.GetValue<string>('messaggio');
    end
    else
    begin
      Result.EsitoCaricamento := (AStatus >= 200) and (AStatus < 300);
      if not Result.EsitoCaricamento then
        Result.Messaggio := 'Risposta non valida dal server (HTTP ' + IntToStr(AStatus) + ')';
    end;
  finally
    JV.Free;
  end;

  if not Result.EsitoCaricamento then
  begin
    if Result.Messaggio = '' then
      Result.Messaggio := 'Errore sconosciuto (HTTP ' + IntToStr(AStatus) + ')';
    Result.Tipo := ClassificaErrore(Result.Messaggio);
    Result.DettaglioErrore := ParseDettaglioErrore(Result.Messaggio, Result.Tipo);
  end;
end;

function TSiufCoopClient.Invia(APayload: TSiufPayload): TSiufEsito;
var
  Http: THTTPClient;
  Body: TStringStream;
  Resp: IHTTPResponse;
  RespText: string;
begin
  Http := THTTPClient.Create;
  try
    Http.ContentType := 'application/json';
    Http.CustomHeaders['accept'] := '*/*';
    Http.CustomHeaders['IDENTIFICATIVO_ENTE'] := FConfig.IdentificativoEnte;
    Http.CustomHeaders['USERNAME'] := FConfig.Username;
    Http.CustomHeaders['CODE'] := FConfig.Code;

    // per test
    Http.ConnectionTimeout := 10000;

    Body := TStringStream.Create(BuildBody(APayload), TEncoding.UTF8);
    try
      try
        Resp := Http.Post(FConfig.Url, Body, nil, TNetHeaders.Create(TNameValuePair.Create('Content-Type', 'application/json')));
      except
        on E: Exception do
          raise Exception.CreateFmt('Errore di trasporto verso SIUF: %s', [E.Message]);
      end;

      RespText := Resp.ContentAsString(TEncoding.UTF8);
      Result := ParseEsito(RespText, Resp.StatusCode);
    finally
      Body.Free;
    end;
  finally
    Http.Free;
  end;
end;

end.
