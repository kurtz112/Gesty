// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-14
// ---------------------------------------------------------------------------

unit AI.Strumenti;

// Strumenti che l'assistente AI di Gesty puo' chiamare (function calling).
//
// Qui e SOLO qui vivono database, transazioni e Config: il motore
// (zAI.Engine), gli strumenti (zAI.Tools) e il protocollo (zAI.Protocol.*)
// sono unit di libreria e di Firebird non sanno nulla. E' la stessa divisione
// del ponte AI.Bridge, da cui questa unit prende la forma: un TBaseDataModule
// con esemplare condiviso creato al primo uso.
//
// Ogni strumento e' un metodo che riceve gli argomenti scelti dal modello
// (TJSONObject) e restituisce un TJSONObject. Gira sul thread principale.
//
// REGOLA DI RISERVATEZZA. Quello che uno strumento restituisce viene spedito
// al fornitore AI, perche' e' il modello a doverlo leggere. Gli strumenti di
// questa prima serie restituiscono soltanto dati NON personali: data e ora,
// anno formativo, denominazioni e numeri dei progetti. Niente STUDENTI,
// ANAGRAFE, docenti o tutor: sono categorie particolari (salute, sostegno,
// servizi sociali) e la loro uscita verso un fornitore esterno va decisa con
// AI_UTILIZZI.LIVELLO_DATI, non aggiunta qui a cuor leggero. Quando quel
// livello verra' letto (AI.Bridge.Carica lo carica gia'), gli strumenti che
// toccano persone si registreranno solo se il livello lo consente.
//
// Per aggiungere uno strumento: un metodo privato con la firma di
// TzAIToolHandler, una riga in Registra. Nome in minuscolo con i trattini
// bassi, descrizione in italiano che dica al modello QUANDO usarlo e cosa
// ottiene: e' l'unica cosa che il modello legge per decidere.

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  zAI.Tools;

type
  TAIStrumenti = class(TBaseDataModule)
  private
    function NuovaQuery(const Sql: string): TzFbDataSet;
    function DataOraCorrente(const Args: TJSONObject): TJSONObject;
    function AnnoFormativoCorrente(const Args: TJSONObject): TJSONObject;
    function CercaProgetti(const Args: TJSONObject): TJSONObject;
  public
    { Registra tutti gli strumenti nell'insieme del motore. Solleva
      EArgumentException se una dichiarazione e' sbagliata (nome non valido,
      doppione): chi chiama decide se spegnere gli strumenti o fermarsi. }
    procedure Registra(ATools: TzAIToolSet);
  end;

{ Esemplare condiviso, creato al primo uso con Common come proprietario.
  Stessa scelta del ponte: nasce quando serve, non all'avvio. }
function AIStrumenti: TAIStrumenti;

implementation

uses
  System.DateUtils,
  Data.DB,
  ConfigModule,
  dmCommon;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

const
  // Quanti progetti al massimo tornano al modello: oltre, il risultato costa
  // e il modello si perde. Il risultato dice se l'elenco e' stato troncato
  MassimoProgetti = 20;
  FormatoData = 'yyyy-mm-dd';
  FormatoOra = 'hh:nn';

  GiorniSettimana: array [1 .. 7] of string = (
    'domenica', 'lunedi''', 'martedi''', 'mercoledi''', 'giovedi''', 'venerdi''', 'sabato');

var
  StrumentiCondivisi: TAIStrumenti = nil;

function AIStrumenti: TAIStrumenti;
begin

  if StrumentiCondivisi = nil then
    StrumentiCondivisi := TAIStrumenti.Create(Common);

  Result := StrumentiCondivisi;
end;

{ TAIStrumenti }

function TAIStrumenti.NuovaQuery(const Sql: string): TzFbDataSet;
begin
  Result := TzFbDataSet.Create(Self);
  Result.Connection := Config.Database;
  Result.Transaction := ReadTrans;
  Result.SQL.Text := Sql;
end;

procedure TAIStrumenti.Registra(ATools: TzAIToolSet);
begin
  ATools.Add('data_ora_corrente',
    'Restituisce data, ora e giorno della settimana correnti del computer dell''operatore. ' +
    'Usalo per qualunque domanda che riguardi "oggi", "adesso", scadenze o conteggi di giorni: ' +
    'non conosci la data di oggi senza chiamarlo.',
    DataOraCorrente);

  ATools.Add('anno_formativo_corrente',
    'Restituisce l''anno formativo corrente dell''ente nella forma "2026/2027". ' +
    'Usalo quando l''operatore parla di "quest''anno" o "anno in corso" a proposito di corsi e progetti.',
    AnnoFormativoCorrente);

  ATools.Add('cerca_progetti',
    'Cerca i progetti formativi (corsi) dell''ente di lavoro dell''operatore. ' +
    'Restituisce al massimo 20 progetti con identificativo, denominazione, tipo, anno formativo, ' +
    'date di inizio e fine, durata in ore e numero di partecipanti attesi ed effettivi. ' +
    'Non restituisce dati di persone.',
    CercaProgetti)
    .AddParameter('testo', ptString,
      'Parola o frase contenuta nella denominazione del progetto. Vuoto = tutti i progetti.', False)
    .AddParameter('anno_formativo', ptString,
      'Anno formativo nella forma "2026/2027". Vuoto = tutti gli anni.', False)
    .AddParameter('solo_in_corso', ptBoolean,
      'Vero per restituire solo i progetti in corso alla data odierna.', False);
end;

// --- strumenti ------------------------------------------------------------

function TAIStrumenti.DataOraCorrente(const Args: TJSONObject): TJSONObject;
var
  Adesso: TDateTime;
begin
  Adesso := Now;
  Result := TJSONObject.Create;
  Result.AddPair('data', FormatDateTime(FormatoData, Adesso));
  Result.AddPair('ora', FormatDateTime(FormatoOra, Adesso));
  Result.AddPair('giorno_settimana', GiorniSettimana[DayOfWeek(Adesso)]);
end;

function TAIStrumenti.AnnoFormativoCorrente(const Args: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('anno_formativo', Common.AnnoFormativoCorrente);
end;

function TAIStrumenti.CercaProgetti(const Args: TJSONObject): TJSONObject;
var
  Testo: string;
  AnnoFormativo: string;
  SoloInCorso: Boolean;
  Sql: TStringList;
  Query: TzFbDataSet;
  Progetti: TJSONArray;
  Progetto: TJSONObject;
  Quanti: Integer;
begin
  Testo := Trim(TzAITool.ArgString(Args, 'testo'));
  AnnoFormativo := Trim(TzAITool.ArgString(Args, 'anno_formativo'));
  SoloInCorso := TzAITool.ArgBoolean(Args, 'solo_in_corso');

  // Si chiede una riga in piu' del massimo: se arriva, l'elenco e' troncato e
  // il modello deve saperlo, altrimenti risponde "sono 20" a chi ne ha 200
  Sql := TStringList.Create;
  try
    Sql.Add(Format('SELECT FIRST %d', [MassimoProgetti + 1]));
    Sql.Add('    PROGETTI.ID_PROGETTO,');
    Sql.Add('    PROGETTI.DENOMINAZIONE_PROGETTO,');
    Sql.Add('    PROGETTI.TIPO_PROGETTO,');
    Sql.Add('    PROGETTI.ANNO_FORMATIVO,');
    Sql.Add('    PROGETTI.DATA_INIZIO_PROGETTO,');
    Sql.Add('    PROGETTI.DATA_FINE_PROGETTO,');
    Sql.Add('    PROGETTI.DURATA_ORE,');
    Sql.Add('    PROGETTI.NUMERO_PARTECIPANTI_ATTESI,');
    Sql.Add('    PROGETTI.NUMERO_PARTECIPANTI_EFFETTIVI');
    Sql.Add('FROM');
    Sql.Add('    PROGETTI');
    Sql.Add('WHERE');
    Sql.Add('    PROGETTI.ID_ENTE = :ID_ENTE');

    if Testo <> '' then
      Sql.Add('    AND UPPER(PROGETTI.DENOMINAZIONE_PROGETTO) LIKE :TESTO');

    if AnnoFormativo <> '' then
      Sql.Add('    AND PROGETTI.ANNO_FORMATIVO = :ANNO_FORMATIVO');

    if SoloInCorso then
      Sql.Add('    AND CURRENT_DATE BETWEEN PROGETTI.DATA_INIZIO_PROGETTO AND PROGETTI.DATA_FINE_PROGETTO');

    Sql.Add('ORDER BY');
    Sql.Add('    PROGETTI.DATA_INIZIO_PROGETTO DESC,');
    Sql.Add('    PROGETTI.DENOMINAZIONE_PROGETTO');

    Query := NuovaQuery(Sql.Text);
  finally
    Sql.Free;
  end;

  try
    Query.ParamByName('ID_ENTE').AsLargeInt := Common.EnteDefault;

    if Testo <> '' then
      Query.ParamByName('TESTO').AsString := '%' + AnsiUpperCase(Testo) + '%';

    if AnnoFormativo <> '' then
      Query.ParamByName('ANNO_FORMATIVO').AsString := AnnoFormativo;

    Query.Open;

    Progetti := TJSONArray.Create;
    Quanti := 0;

    while (not Query.Eof) and (Quanti < MassimoProgetti) do
    begin
      Progetto := TJSONObject.Create;
      Progetto.AddPair('id_progetto', TJSONNumber.Create(Query.FieldByName('ID_PROGETTO').AsLargeInt));
      Progetto.AddPair('denominazione', Query.FieldByName('DENOMINAZIONE_PROGETTO').AsString);
      Progetto.AddPair('tipo', Query.FieldByName('TIPO_PROGETTO').AsString);
      Progetto.AddPair('anno_formativo', Query.FieldByName('ANNO_FORMATIVO').AsString);
      Progetto.AddPair('data_inizio', FormatDateTime(FormatoData, Query.FieldByName('DATA_INIZIO_PROGETTO').AsDateTime));
      Progetto.AddPair('data_fine', FormatDateTime(FormatoData, Query.FieldByName('DATA_FINE_PROGETTO').AsDateTime));
      Progetto.AddPair('durata_ore', TJSONNumber.Create(Query.FieldByName('DURATA_ORE').AsLargeInt));
      Progetto.AddPair('partecipanti_attesi', TJSONNumber.Create(Query.FieldByName('NUMERO_PARTECIPANTI_ATTESI').AsInteger));
      Progetto.AddPair('partecipanti_effettivi', TJSONNumber.Create(Query.FieldByName('NUMERO_PARTECIPANTI_EFFETTIVI').AsInteger));
      Progetti.Add(Progetto);

      Inc(Quanti);
      Query.Next;
    end;

    Result := TJSONObject.Create;
    Result.AddPair('progetti', Progetti);
    Result.AddPair('quanti', TJSONNumber.Create(Quanti));
    // Se c'e' ancora una riga, ne esistono altri oltre il massimo
    Result.AddPair('elenco_troncato', TJSONBool.Create(not Query.Eof));

    if Quanti = 0 then
      Result.AddPair('nota', 'Nessun progetto corrisponde ai criteri indicati.');
  finally
    Query.Free;
  end;
end;

initialization

finalization

// L'esemplare condiviso ha Common come proprietario: lo distrugge la catena
// degli owner. Qui si azzera solo il riferimento.
StrumentiCondivisi := nil;

end.
