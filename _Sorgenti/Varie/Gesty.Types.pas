unit Gesty.Types;

// Copia con i fix ai bug #1 (TTipoTirocinioHelper.FromString) e
// #2 (TFirmaTipoDocHelper.FromString): entrambe inizializzano Result e
// TTipoTirocinio gestisce anche 'F'/'A'. Vedi correzioni_bug.md.

interface

uses
  System.SysUtils,
  System.Classes,
  Data.Db;

type
  TStatoPresenza = (spPresente, spAssente, spGiustificato, spOraBuca);

  TStatoPresenzaHelper = record helper for TStatoPresenza
  public
    function ToString: string;
    class function FromString(const s: String): TStatoPresenza; static;
  end;

  TTipoTirocinio = (ttCurriculare, ttExtraCurriculare, ttInclusione, ttFormazioneInterna, ttAltro);

  TTipoTirocinioHelper = record helper for TTipoTirocinio
  public
    function Description: string;
    function ToString: string;
    class function FromString(const s: String): TTipoTirocinio; static;
  end;

  TSchedulerTipoEvento = (teNull, teOrarioLezione, teOreRilevamento, teRiunione, teAgendaPersonale, tePrenotazioneAule, teInagibilitaAula, teChiusuraSede, tePresenzaPersonale, teScadenza,
    teAttivitaFuoriSede);
  TSchedulerTipoEventi = set of TSchedulerTipoEvento;

  TSchedulerTipoEventoHelper = record helper for TSchedulerTipoEvento
  public
    function Description: string;
    function ToString: string;
    function IdFieldName: string;
    function CanIntersect(other: TSchedulerTipoEvento): boolean;
    class function FromString(const s: String): TSchedulerTipoEvento; static;
  end;

  TStatoRiunione = (srInserita, srProgrammata, srVerbalizzata, srContabilizzata, srAnnullata);

  TStatoRiunioneHelper = record helper for TStatoRiunione
  public
    function ToString: string;
    class function FromString(const s: String): TStatoRiunione; static;
  end;

  TFirmaTipoDoc = (ftContratto, ftIncaricoDiMassima);

  TFirmaTipoDocHelper = record helper for TFirmaTipoDoc
  public
    function ToString: string;
    class function FromString(const s: String): TFirmaTipoDoc; static;
  end;

  TASTipoIntervento = (tiNull, tiAS, tiAES, tiADH);

  TASTipoInterventoHelper = record helper for TASTipoIntervento
  public
    function ToString: string;
    class function FromString(const s: String): TASTipoIntervento; static;
  end;

implementation

{ TStatoPresenzaHelper }

class function TStatoPresenzaHelper.FromString(

  const s: String): TStatoPresenza;
begin
  Result := spPresente;

  if s = 'P' then
    Result := spPresente
  else
    if s = 'A' then
      Result := spAssente
    else
      if s = 'G' then
        Result := spGiustificato
      else
        if s = 'B' then
          Result := spOraBuca;
end;

function TStatoPresenzaHelper.ToString: string;
begin
  case Self of
    spPresente:
      Result := 'P';
    spAssente:
      Result := 'A';
    spGiustificato:
      Result := 'G';
    spOraBuca:
      Result := 'B';
  end;
end;

// FIX bug #1: inizializza Result e gestisce anche 'F'/'A' (round-trip completo)
class function TTipoTirocinioHelper.FromString(const s: String): TTipoTirocinio;
begin
  // Default per stringhe non riconosciute: evita un Result non inizializzato
  Result := ttAltro;

  if s = 'C' then
    Result := ttCurriculare
  else
    if s = 'X' then
      Result := ttExtraCurriculare
    else
      if s = 'I' then
        Result := ttInclusione
      else
        if s = 'F' then
          Result := ttFormazioneInterna
        else
          if s = 'A' then
            Result := ttAltro;
end;

function TTipoTirocinioHelper.ToString: string;
begin
  case Self of
    ttCurriculare:
      Result := 'C';
    ttExtraCurriculare:
      Result := 'X';
    ttInclusione:
      Result := 'I';
    ttFormazioneInterna:
      Result := 'F';
    ttAltro:
      Result := 'A';
  end;
end;

function TTipoTirocinioHelper.Description: string;
begin
  case Self of
    ttCurriculare:
      Result := 'Curriculare';
    ttExtraCurriculare:
      Result := 'ExtraCurriculare';
    ttInclusione:
      Result := 'Inclusione';
    ttFormazioneInterna:
      Result := 'Formazione Interna';
    ttAltro:
      Result := 'Altro';
  end;
end;

function TSchedulerTipoEventoHelper.CanIntersect(other: TSchedulerTipoEvento): boolean;
const
  allowed = [teAgendaPersonale, teScadenza];
begin
  Result := (Self in allowed) or (other in allowed);
end;

{ TSchedulerTipoEventoHelper }

class function TSchedulerTipoEventoHelper.FromString(const s: String): TSchedulerTipoEvento;
begin
  Result := teNull;

  if SameText(s, 'X') then
    Result := teNull
  else
    if SameText(s, 'L') then
      Result := teOrarioLezione
    else
      if SameText(s, 'O') then
        Result := teOreRilevamento
      else
        if SameText(s, 'R') then
          Result := teRiunione
        else
          if SameText(s, 'A') then
            Result := teAgendaPersonale
          else
            if SameText(s, 'P') then
              Result := tePrenotazioneAule
            else
              if SameText(s, 'I') then
                Result := teInagibilitaAula
              else
                if SameText(s, 'C') then
                  Result := teChiusuraSede
                else
                  if SameText(s, 'E') then
                    Result := tePresenzaPersonale
                  else
                    if SameText(s, 'S') then
                      Result := teScadenza
                    else
                      if SameText(s, 'F') then
                        Result := teAttivitaFuoriSede;
end;

function TSchedulerTipoEventoHelper.ToString: string;
begin
  Result := '';

  case Self of
    teNull:
      Result := 'X';
    teOrarioLezione:
      Result := 'L';
    teOreRilevamento:
      Result := 'O';
    teRiunione:
      Result := 'R';
    teAgendaPersonale:
      Result := 'A';
    tePrenotazioneAule:
      Result := 'P';
    teInagibilitaAula:
      Result := 'I';
    teChiusuraSede:
      Result := 'C';
    tePresenzaPersonale:
      Result := 'E';
    teScadenza:
      Result := 'S';
    teAttivitaFuoriSede:
      Result := 'F';
  end;
end;

function TSchedulerTipoEventoHelper.Description: string;
begin
  Result := '';

  case Self of
    teOrarioLezione:
      Result := 'Orario Lezione';
    teOreRilevamento:
      Result := 'Ore Rilevamento';
    teRiunione:
      Result := 'Riunione';
    teAgendaPersonale:
      Result := 'Agenda Personale';
    tePrenotazioneAule:
      Result := 'Prenotazione Aule';
    teInagibilitaAula:
      Result := 'Inagibilità Aula';
    teChiusuraSede:
      Result := 'Chiusura Sede';
    tePresenzaPersonale:
      Result := 'Presenza Personale';
    teScadenza:
      Result := 'Scadenze';
    teAttivitaFuoriSede:
      Result := 'Attività Fuori Sede';
  end;
end;

function TSchedulerTipoEventoHelper.IdFieldName: string;
begin
  Result := '';

  case Self of
    teOrarioLezione:
      Result := 'ID_ORARIO';
    teOreRilevamento:
      Result := 'ID_RILEVAMENTO_ORE';
    teRiunione:
      Result := 'ID_RIUNIONE';
    teAgendaPersonale:
      Result := 'ID_AGENDA';
    tePrenotazioneAule:
      Result := 'ID_PRENOTAZIONE_AULA';
    teInagibilitaAula:
      Result := 'ID_INAGIBILITA_AULA';
    teChiusuraSede:
      Result := 'ID_GIORNO_CHIUSURA';
    tePresenzaPersonale:
      Result := 'ID_PRESENZA_PERSONALE';
    teScadenza:
      Result := 'ID_SCADENZA';
    teAttivitaFuoriSede:
      Result := 'ID_ATTIVITA_FUORI_SEDE';
  end;
end;

{ TStatoRiunioneHelper }

class function TStatoRiunioneHelper.FromString(

  const s: String): TStatoRiunione;
begin
  Result := srInserita;

  if s = 'I' then
    Result := srInserita
  else
    if s = 'P' then
      Result := srProgrammata
    else
      if s = 'V' then
        Result := srVerbalizzata
      else
        if s = 'C' then
          Result := srContabilizzata
        else
          if s = 'A' then
            Result := srAnnullata;
end;

function TStatoRiunioneHelper.ToString: string;
begin
  case Self of
    srInserita:
      Result := 'I';
    srProgrammata:
      Result := 'P';
    srVerbalizzata:
      Result := 'V';
    srContabilizzata:
      Result := 'C';
    srAnnullata:
      Result := 'A';
  end;
end;

{ TFirmaTipoDocHelper }

// FIX bug #2: inizializza Result (niente enum casuale su stringa ignota)
class function TFirmaTipoDocHelper.FromString(const s: String): TFirmaTipoDoc;
begin
  // Default per stringhe non riconosciute: evita un Result non inizializzato
  Result := ftContratto;

  if s = 'CON' then
    Result := ftContratto
  else
    if s = 'CDM' then
      Result := ftIncaricoDiMassima;
end;

function TFirmaTipoDocHelper.ToString: string;
begin
  case Self of
    ftContratto:
      Result := 'CON';
    ftIncaricoDiMassima:
      Result := 'CDM';
  end;
end;

{ TASTipoInterventoHelper }

class function TASTipoInterventoHelper.FromString(const s: String): TASTipoIntervento;
begin
  Result := tiNull;

  if s = 'AS' then
    Result := tiAS
  else
    if s = 'AES' then
      Result := tiAES
    else
      if s = 'ADH' then
        Result := tiADH;
end;

function TASTipoInterventoHelper.ToString: string;
begin
  case Self of
    tiNull:
      Result := '';
    tiAS:
      Result := 'AS';
    tiAES:
      Result := 'AES';
    tiADH:
      Result := 'ADH';
  end;
end;

end.
