// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-11-10
// ---------------------------------------------------------------------------
unit Files.ImportErrors;

// Messaggi dell'importazione di un file PDF come allegato (Files.Lib.ImportObjFile).
// Unit senza dipendenze dall'applicazione, cosi' la classificazione degli errori
// si prova con un test automatico.
//
// Mantis #338 - 2026-11-10: un file che non si riesce ad aprire (spostato,
// rinominato, percorso di rete non raggiungibile) non e' un "PDF non valido":
// i due casi hanno messaggi diversi, perche' chi legge deve capire dove cercare.

interface

uses
  System.SysUtils,
  System.Classes;

// True se l'eccezione dice che il file non si e' potuto aprire o trovare
// (apertura, creazione, ingresso/uscita), False se riguarda il contenuto
function ErroreAperturaFile(const Errore: Exception): Boolean;

// Messaggio per un file che non esiste o non e' raggiungibile (controllo preliminare)
function MessaggioFileNonRaggiungibile(const NomeFile: string): string;

// Messaggio per l'eccezione sollevata leggendo il PDF: distingue l'errore di apertura
// del file dal PDF danneggiato
function MessaggioErroreImportazionePdf(const NomeFile: string; const Errore: Exception): string;

implementation

function ErroreAperturaFile(const Errore: Exception): Boolean;
begin
  Result := (Errore is EFOpenError) or (Errore is EFCreateError) or (Errore is EInOutError);
end;

function MessaggioFileNonRaggiungibile(const NomeFile: string): string;
begin
  Result := Format('Impossibile importare "%s": il file non e'' raggiungibile (%s). ' +
    'Verificare che esista ancora, che la cartella di rete sia accessibile e che il nome non contenga spazi prima dell''estensione.',
    [ExtractFileName(NomeFile), NomeFile]);
end;

function MessaggioErroreImportazionePdf(const NomeFile: string; const Errore: Exception): string;
begin
  if ErroreAperturaFile(Errore) then
    Result := Format('Impossibile importare "%s": il file non si riesce ad aprire (%s). ' +
      'Verificare che esista ancora, che la cartella di rete sia accessibile e che il nome non contenga spazi prima dell''estensione.',
      [ExtractFileName(NomeFile), Errore.Message])
  else
    Result := Format('Impossibile importare "%s": il file non e'' un PDF valido o e'' danneggiato (%s).',
      [ExtractFileName(NomeFile), Errore.Message]);
end;

end.
