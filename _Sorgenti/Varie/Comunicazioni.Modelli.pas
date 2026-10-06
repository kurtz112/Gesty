// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-16
// ---------------------------------------------------------------------------
unit Comunicazioni.Modelli;

// Motore dei modelli di comunicazione (tabella COMUNICAZIONI_MODELLI).
// Unit riusabile: nessuna dipendenza da unit applicative (WT.Globals, Gesty.Globals, ConfigModule, dmCommon).
// Il modello contiene segnaposto nella forma {{CHIAVE}}; la sostituzione ignora maiuscole e minuscole
// e lascia intatto un segnaposto per cui non e' stato fornito un valore, cosi' l'operatore lo vede
// nell'anteprima invece di spedire un testo con un buco silenzioso.

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Data.DB;

type
  // Chiavi documentate nel COMMENT ON TABLE COMUNICAZIONI_MODELLI: tenerle allineate
  TComunicazioniSegnaposto = class
  public const
    Nominativo = 'NOMINATIVO';
    Nome = 'NOME';
    Cognome = 'COGNOME';
    Corso = 'CORSO';
    AnnoFormativo = 'ANNO_FORMATIVO';
    Attivita = 'ATTIVITA';
    DataAttivita = 'DATA_ATTIVITA';
    OraAttivita = 'ORA_ATTIVITA';
    Luogo = 'LUOGO';
    Scadenza = 'SCADENZA';
    Operatore = 'OPERATORE';
    Ente = 'ENTE';
    DataOggi = 'DATA_OGGI';
  end;

  TComunicazioneValori = TDictionary<string, string>;

  TComunicazioneModello = record
  private
    FIdModello: Int64;
    FCodice: string;
    FDescrizione: string;
    FOggetto: string;
    FCorpoHtml: string;
    FCorpoTesto: string;
    FConfermaSingoloInvio: boolean;
  public
    // Legge il record corrente di un dataset aperto su COMUNICAZIONI_MODELLI
    class function DaDataSet(DataSet: TDataSet): TComunicazioneModello; static;

    // Sostituisce i segnaposto {{CHIAVE}} con i valori forniti
    class function Render(const Testo: string; Valori: TComunicazioneValori): string; static;

    function OggettoRenderizzato(Valori: TComunicazioneValori): string;
    function CorpoHtmlRenderizzato(Valori: TComunicazioneValori): string;
    function CorpoTestoRenderizzato(Valori: TComunicazioneValori): string;

    // Elenco dei segnaposto presenti nel modello a cui manca un valore: da mostrare prima dell'invio
    function SegnapostoMancanti(Valori: TComunicazioneValori): string;

    property IdModello: Int64 read FIdModello;
    property Codice: string read FCodice;
    property Descrizione: string read FDescrizione;
    property Oggetto: string read FOggetto;
    property CorpoHtml: string read FCorpoHtml;
    property CorpoTesto: string read FCorpoTesto;
    property ConfermaSingoloInvio: boolean read FConfermaSingoloInvio;
  end;

implementation

uses
  System.StrUtils;

{ TComunicazioneModello }

class function TComunicazioneModello.DaDataSet(DataSet: TDataSet): TComunicazioneModello;
begin
  if not Assigned(DataSet) or DataSet.IsEmpty then
    raise Exception.Create('Nessun modello di comunicazione selezionato.');

  Result.FIdModello := DataSet.FieldByName('ID_MODELLO_COMUNICAZIONE').AsLargeInt;
  Result.FCodice := DataSet.FieldByName('CODICE').AsString;
  Result.FDescrizione := DataSet.FieldByName('DESCRIZIONE').AsString;
  Result.FOggetto := DataSet.FieldByName('OGGETTO').AsString;
  Result.FCorpoHtml := DataSet.FieldByName('CORPO_HTML').AsString;
  Result.FCorpoTesto := DataSet.FieldByName('CORPO_TESTO').AsString;
  Result.FConfermaSingoloInvio := DataSet.FieldByName('CONFERMA_SINGOLO_INVIO').AsBoolean;

  if (Trim(Result.FCorpoHtml) = '') and (Trim(Result.FCorpoTesto) = '') then
    raise Exception.CreateFmt('Il modello "%s" non ha un corpo del messaggio.', [Result.FCodice]);
end;

class function TComunicazioneModello.Render(const Testo: string; Valori: TComunicazioneValori): string;
var
  Coppia: TPair<string, string>;
begin
  Result := Testo;

  if not Assigned(Valori) then
    exit;

  for Coppia in Valori do
    Result := ReplaceText(Result, '{{' + Coppia.Key + '}}', Coppia.Value);
end;

function TComunicazioneModello.OggettoRenderizzato(Valori: TComunicazioneValori): string;
begin
  Result := Render(FOggetto, Valori);
end;

function TComunicazioneModello.CorpoHtmlRenderizzato(Valori: TComunicazioneValori): string;
begin
  Result := Render(FCorpoHtml, Valori);
end;

function TComunicazioneModello.CorpoTestoRenderizzato(Valori: TComunicazioneValori): string;
begin
  Result := Render(FCorpoTesto, Valori);
end;

function TComunicazioneModello.SegnapostoMancanti(Valori: TComunicazioneValori): string;
var
  TestoCompleto: string;
  PosizioneApertura: integer;
  PosizioneChiusura: integer;
  Chiave: string;
  Mancanti: TStringList;
begin
  TestoCompleto := FOggetto + ' ' + FCorpoHtml + ' ' + FCorpoTesto;

  Mancanti := TStringList.Create;
  try
    Mancanti.Duplicates := dupIgnore;
    Mancanti.Sorted := True;

    PosizioneApertura := Pos('{{', TestoCompleto);
    while PosizioneApertura > 0 do
    begin
      PosizioneChiusura := PosEx('}}', TestoCompleto, PosizioneApertura + 2);
      if PosizioneChiusura = 0 then
        break;

      Chiave := Copy(TestoCompleto, PosizioneApertura + 2, PosizioneChiusura - PosizioneApertura - 2);

      if not Assigned(Valori) or not Valori.ContainsKey(UpperCase(Chiave)) then
        Mancanti.Add(UpperCase(Chiave));

      PosizioneApertura := PosEx('{{', TestoCompleto, PosizioneChiusura + 2);
    end;

    Result := Mancanti.CommaText;
  finally
    FreeAndNil(Mancanti);
  end;
end;

end.
