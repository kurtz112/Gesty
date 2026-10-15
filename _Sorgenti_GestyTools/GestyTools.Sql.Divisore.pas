// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-15
// ---------------------------------------------------------------------------
unit GestyTools.Sql.Divisore;

// COPIA di zToolsAI\zFbScript\_src\zFbScript.Divisore.pas (2026-10-03),
// identica salvo il nome della unit: le correzioni vanno fatte in tutte e
// due finche' il motore non passa in una sottocartella di zPack.
//
// Divide il testo di uno script nelle singole istruzioni, come fanno isql e
// IBExpert.
//
// Regole:
//  - un'istruzione finisce al terminatore corrente (all'inizio ";") quando
//    il terminatore e' fuori da stringhe, identificatori fra virgolette e
//    commenti;
//  - SET TERM <nuovo> cambia il terminatore e non diventa un'istruzione:
//    e' cosi' che i corpi di procedure, trigger ed EXECUTE BLOCK, pieni di
//    ";", arrivano interi al server;
//  - stringhe '...' con l'apice raddoppiato, identificatori "..." con le
//    virgolette raddoppiate, stringhe alternative q'{...}' di Firebird 3;
//  - commenti "--" fino a fine riga e "/* ... */"; quelli in testa a
//    un'istruzione si tolgono, perche' la classificazione guarda la prima
//    parola, quelli interni restano;
//  - il testo dopo l'ultimo terminatore, se non e' vuoto, e' l'ultima
//    istruzione: uno script che dimentica il ";" finale non perde la coda.

interface

uses
  System.SysUtils;

type
  TIstruzione = record
    Testo: string;
    // Riga dello script (da 1) in cui comincia il testo dell'istruzione,
    // commenti iniziali esclusi: e' quella che si indica negli errori.
    Riga: Integer;
  end;

  TIstruzioni = TArray<TIstruzione>;

function DividiScript(const Testo: string): TIstruzioni;

// Testo senza i commenti e gli spazi iniziali.
function TogliCommentiIniziali(const Testo: string): string;

implementation

uses
  System.Generics.Collections,
  System.RegularExpressions;

function ChiusuraQ(Apertura: Char): Char;
begin
  case Apertura of
    '(':
      Result := ')';
    '[':
      Result := ']';
    '{':
      Result := '}';
    '<':
      Result := '>';
  else
    Result := Apertura;
  end;
end;

function CarattereIdentificatore(Carattere: Char): Boolean;
begin
  Result := CharInSet(Carattere, ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '_', '$']);
end;

// Posizione (da 1) del primo carattere utile dopo spazi e commenti, a
// partire da Inizio; Length + 1 se non ce n'e'.
function SaltaSpaziECommenti(const Testo: string; Inizio: Integer): Integer;
var
  Lunghezza: Integer;
begin
  Result := Inizio;
  Lunghezza := Length(Testo);

  while Result <= Lunghezza do
  begin
    if CharInSet(Testo[Result], [' ', #9, #10, #13, #12]) then
      Inc(Result)
    else if (Testo[Result] = '-') and (Result < Lunghezza) and (Testo[Result + 1] = '-') then
    begin
      while (Result <= Lunghezza) and not CharInSet(Testo[Result], [#10, #13]) do
        Inc(Result);
    end
    else if (Testo[Result] = '/') and (Result < Lunghezza) and (Testo[Result + 1] = '*') then
    begin
      Inc(Result, 2);

      while (Result < Lunghezza) and not((Testo[Result] = '*') and (Testo[Result + 1] = '/')) do
        Inc(Result);

      Inc(Result, 2);
    end
    else
      Break;
  end;
end;

function TogliCommentiIniziali(const Testo: string): string;
begin
  Result := Copy(Testo, SaltaSpaziECommenti(Testo, 1), MaxInt).TrimRight;
end;

function ContaRighe(const Testo: string; DaPosizione, APosizione: Integer; RigaIniziale: Integer): Integer;
var
  Indice: Integer;
begin
  Result := RigaIniziale;

  for Indice := DaPosizione to APosizione - 1 do
    if Testo[Indice] = #10 then
      Inc(Result);
end;

function DividiScript(const Testo: string): TIstruzioni;
var
  Elenco: TList<TIstruzione>;
  Terminatore: string;
  LunghezzaTerminatore: Integer;
  Posizione, Lunghezza: Integer;
  InizioIstruzione: Integer;
  // riga corrispondente a UltimaPosizioneContata, per non ricontare ogni
  // volta dall'inizio del testo
  RigaContata, UltimaPosizioneContata: Integer;
  Chiusura: Char;
  SetTerm: TRegEx;

  procedure ChiudiIstruzione(Fine: Integer);
  var
    Grezzo: string;
    InizioUtile: Integer;
    Istruzione: TIstruzione;
    Corrispondenza: TMatch;
  begin
    Grezzo := Copy(Testo, InizioIstruzione, Fine - InizioIstruzione);
    InizioUtile := SaltaSpaziECommenti(Grezzo, 1);
    Istruzione.Testo := Copy(Grezzo, InizioUtile, MaxInt).TrimRight;

    if Istruzione.Testo = '' then
      Exit;

    RigaContata := ContaRighe(Testo, UltimaPosizioneContata, InizioIstruzione + InizioUtile - 1, RigaContata);
    UltimaPosizioneContata := InizioIstruzione + InizioUtile - 1;
    Istruzione.Riga := RigaContata;

    Corrispondenza := SetTerm.Match(Istruzione.Testo);

    if Corrispondenza.Success then
    begin
      Terminatore := Corrispondenza.Groups[1].Value;
      Exit;
    end;

    Elenco.Add(Istruzione);
  end;

begin
  // SET TERM <nuovo>: il vecchio terminatore e' gia' stato tolto, quello
  // che resta e' il nuovo (uno o piu' caratteri qualunque)
  SetTerm := TRegEx.Create('^SET\s+TERM\s+(\S+)\s*$', [roIgnoreCase, roSingleLine]);

  Elenco := TList<TIstruzione>.Create;
  try
    Terminatore := ';';
    Lunghezza := Length(Testo);
    Posizione := 1;
    InizioIstruzione := 1;
    RigaContata := 1;
    UltimaPosizioneContata := 1;

    while Posizione <= Lunghezza do
    begin
      // commento di riga
      if (Testo[Posizione] = '-') and (Posizione < Lunghezza) and (Testo[Posizione + 1] = '-') then
      begin
        while (Posizione <= Lunghezza) and not CharInSet(Testo[Posizione], [#10, #13]) do
          Inc(Posizione);
        Continue;
      end;

      // commento di blocco
      if (Testo[Posizione] = '/') and (Posizione < Lunghezza) and (Testo[Posizione + 1] = '*') then
      begin
        Inc(Posizione, 2);

        while (Posizione < Lunghezza) and not((Testo[Posizione] = '*') and (Testo[Posizione + 1] = '/')) do
          Inc(Posizione);

        Inc(Posizione, 2);
        Continue;
      end;

      // stringa alternativa di Firebird 3: q'<d>...<d>'
      if CharInSet(Testo[Posizione], ['q', 'Q']) and (Posizione + 2 <= Lunghezza) and (Testo[Posizione + 1] = '''') and
        ((Posizione = 1) or not CarattereIdentificatore(Testo[Posizione - 1])) then
      begin
        Chiusura := ChiusuraQ(Testo[Posizione + 2]);
        Inc(Posizione, 3);

        while (Posizione < Lunghezza) and not((Testo[Posizione] = Chiusura) and (Testo[Posizione + 1] = '''')) do
          Inc(Posizione);

        Inc(Posizione, 2);
        Continue;
      end;

      // stringa o identificatore fra virgolette: il raddoppio e' un
      // carattere del testo, non la chiusura
      if CharInSet(Testo[Posizione], ['''', '"']) then
      begin
        Chiusura := Testo[Posizione];
        Inc(Posizione);

        while Posizione <= Lunghezza do
        begin
          if Testo[Posizione] = Chiusura then
          begin
            if (Posizione < Lunghezza) and (Testo[Posizione + 1] = Chiusura) then
              Inc(Posizione, 2)
            else
              Break;
          end
          else
            Inc(Posizione);
        end;

        Inc(Posizione);
        Continue;
      end;

      if (Testo[Posizione] = Terminatore[1]) and (Copy(Testo, Posizione, Length(Terminatore)) = Terminatore) then
      begin
        // la lunghezza va presa prima: se l'istruzione e' un SET TERM,
        // ChiudiIstruzione cambia il terminatore, e "SET TERM ; !!"
        // lascerebbe un "!" in testa all'istruzione successiva
        LunghezzaTerminatore := Length(Terminatore);
        ChiudiIstruzione(Posizione);
        Inc(Posizione, LunghezzaTerminatore);
        InizioIstruzione := Posizione;
        Continue;
      end;

      Inc(Posizione);
    end;

    if InizioIstruzione <= Lunghezza then
      ChiudiIstruzione(Lunghezza + 1);

    Result := Elenco.ToArray;
  finally
    Elenco.Free;
  end;
end;

end.
