unit common;

interface

type
  // GENERALE       = G
  // DOCENTI        = D
  // TIROCINIO      = T
  // TUTOR/SOSTEGNO = S
  // FAD            = F
  TTipoSezione = (tsGenerale, tsDocenti, tsTirocini, tsTutor, tsFAD);

  // VALUTAZIONE     = V
  // SCELTA SINGOLA  = S
  // SCELTA MULTIPLA = M

  TTipoRisposta = (trValutazione, trSceltaSingola, trSceltaMultipla);

  //
function TipoSezioneFromString(s: String): TTipoSezione;
function TipoRispostaFromString(s: String): TTipoRisposta;

implementation

{ TTipoSezioneHelper }

function TipoSezioneFromString(s: String): TTipoSezione;
begin
  // GENERALE       = G
  // DOCENTI        = D
  // TIROCINIO      = T
  // TUTOR/SOSTEGNO = S
  // FAD            = F

  result := tsGenerale;

  if s = 'G' then
    result := tsGenerale
  else
    if s = 'D' then
      result := tsDocenti
    else
      if s = 'T' then
        result := tsTirocini
      else
        if s = 'S' then
          result := tsTutor
        else
          if s = 'F' then
            result := tsFAD;
end;

{ TTipoRispostaHelper }

function TipoRispostaFromString(s: String): TTipoRisposta;
begin
  // VALUTAZIONE     = V
  // SCELTA SINGOLA  = S
  // SCELTA MULTIPLA = M

  result := trValutazione;

  if s = 'V' then
    result := trValutazione
  else
    if s = 'S' then
      result := trSceltaSingola
    else
      if s = 'M' then
        result := trSceltaMultipla;
end;

end.
