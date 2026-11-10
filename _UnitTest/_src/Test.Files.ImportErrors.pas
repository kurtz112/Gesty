// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-11-10
// ---------------------------------------------------------------------------
unit Test.Files.ImportErrors;

// Test DUnitX per Files.ImportErrors.pas: classificazione degli errori
// dell'importazione di un PDF (errore di apertura del file e PDF non valido).
// Nessuna dipendenza da UI, database o rete.

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  DUnitX.TestFramework,
  Files.ImportErrors;

type
  [TestFixture]
  TTestFilesImportErrors = class
  public
    // Mantis #338 - 2026-11-10: errore di apertura (EFOpenError) -> messaggio di accesso al file
    [Test]
    procedure ErroreApertura_NonDiventaPdfNonValido;
    // Mantis #338 - 2026-11-10: EFCreateError (come nel log del ticket) -> messaggio di accesso al file
    [Test]
    procedure ErroreCreazioneStream_NonDiventaPdfNonValido;
    // Mantis #338 - 2026-11-10: contenuto non PDF -> messaggio "non e' un PDF valido"
    [Test]
    procedure ErroreDiLettura_RestaPdfNonValido;
    // Mantis #338 - 2026-11-10: file inesistente -> messaggio "non e' raggiungibile"
    [Test]
    procedure FileNonRaggiungibile_IndicaNomeEPercorso;
    // Mantis #338 - 2026-11-10: nome con spazio prima dell'estensione, in cartella locale
    [Test]
    procedure NomeConSpazioPrimaDellEstensione_ApribileInLocale;
  end;

implementation

procedure TTestFilesImportErrors.ErroreApertura_NonDiventaPdfNonValido;
var
  Errore: Exception;
  Messaggio: string;
begin
  Errore := EFOpenError.CreateFmt('%s', ['Impossibile trovare il file specificato']);
  try
    Assert.IsTrue(ErroreAperturaFile(Errore));
    Messaggio := MessaggioErroreImportazionePdf('C:\Dati\DELEGA AZIENDA .pdf', Errore);
  finally
    Errore.Free;
  end;
  Assert.IsFalse(Messaggio.Contains('PDF valido'), Messaggio);
  Assert.IsTrue(Messaggio.Contains('non si riesce ad aprire'), Messaggio);
  Assert.IsTrue(Messaggio.Contains('DELEGA AZIENDA .pdf'), Messaggio);
end;

procedure TTestFilesImportErrors.ErroreCreazioneStream_NonDiventaPdfNonValido;
var
  Errore: Exception;
  Messaggio: string;
begin
  Errore := EFCreateError.CreateFmt('%s', ['Impossibile creare il file']);
  try
    Assert.IsTrue(ErroreAperturaFile(Errore));
    Messaggio := MessaggioErroreImportazionePdf('C:\Dati\DELEGA AZIENDA .pdf', Errore);
  finally
    Errore.Free;
  end;
  Assert.IsFalse(Messaggio.Contains('PDF valido'), Messaggio);
end;

procedure TTestFilesImportErrors.ErroreDiLettura_RestaPdfNonValido;
var
  Errore: Exception;
  Messaggio: string;
begin
  Errore := Exception.Create('Struttura del documento non riconosciuta');
  try
    Assert.IsFalse(ErroreAperturaFile(Errore));
    Messaggio := MessaggioErroreImportazionePdf('C:\Dati\Prova.pdf', Errore);
  finally
    Errore.Free;
  end;
  Assert.IsTrue(Messaggio.Contains('non e'' un PDF valido'), Messaggio);
end;

procedure TTestFilesImportErrors.FileNonRaggiungibile_IndicaNomeEPercorso;
var
  Messaggio: string;
begin
  Messaggio := MessaggioFileNonRaggiungibile('\\dati\S02\Cartella\DELEGA AZIENDA .pdf');
  Assert.IsTrue(Messaggio.Contains('non e'' raggiungibile'), Messaggio);
  Assert.IsFalse(Messaggio.Contains('PDF valido'), Messaggio);
  Assert.IsTrue(Messaggio.Contains('\\dati\S02\Cartella\DELEGA AZIENDA .pdf'), Messaggio);
end;

procedure TTestFilesImportErrors.NomeConSpazioPrimaDellEstensione_ApribileInLocale;
var
  Cartella, NomeFile: string;
  Flusso: TFileStream;
begin
  Cartella := TPath.Combine(TPath.GetTempPath, 'GestyTests_338_' + TGUID.NewGuid.ToString.Substring(1, 8));
  TDirectory.CreateDirectory(Cartella);
  try
    NomeFile := TPath.Combine(Cartella, 'DELEGA AZIENDA .pdf');
    TFile.WriteAllText(NomeFile, '%PDF-1.4');
    Assert.IsTrue(TFile.Exists(NomeFile), 'il file con lo spazio prima di .pdf deve risultare esistente');
    Flusso := TFileStream.Create(NomeFile, fmOpenRead or fmShareDenyNone);
    try
      Assert.AreEqual(Int64(8), Flusso.Size);
    finally
      Flusso.Free;
    end;
  finally
    TDirectory.Delete(Cartella, True);
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestFilesImportErrors);

end.
