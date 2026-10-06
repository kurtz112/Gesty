unit dmStudenti;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Base_DataModule,
  zFbDataSet,
  dbMaster,
  zBaseLib,
  zCodiceFiscale,
  zz.Tuples,
   zProgressBox;

type
  TStudenti = class(TBaseDataModule)
    ProgressBox: TProgressBox;
  private
    procedure Studenti_CorsiNewRecord(Dataset: TDataset);
    procedure Studenti_GenitoriAfterPost(Dataset: TDataset);
    procedure CustomizeDataSet(Dataset: TDataset);

    // Mantis #73 - 2026-09-06: gli attestati sicurezza di fonte interna
    // (FONTE = 'INT') sono di proprieta' della procedura
    // STUDENTI_PROGETTI_ATTESTATI_ASR_GENERA: non si modificano ne' si
    // eliminano a mano. L'operatore inserisce solo attestati esterni ('EST').
    procedure Studenti_Attestati_Sicurezza_NewRecord(Dataset: TDataset);
    procedure Studenti_Attestati_Sicurezza_BeforeEdit(Dataset: TDataset);
    procedure Studenti_Attestati_Sicurezza_BeforeDelete(Dataset: TDataset);
  protected
    procedure AfterCreateDataSet(const DataSetName: string; Dataset: TzFbDataSet); override;
  public
    procedure RettificaDataIscrizione;
    procedure RegistraRitiroStudente;

    procedure ImportSidi(const FileName: string);
    procedure ImportSpaggiari(const FileName: string);

    function ImportDomandeIscrizione(const FileName: string): Integer;
    procedure ElaboraDomandeIscrizione;
  public
    procedure CreaUtenteSistema;
    procedure CreaUtentiSistema(ElencoStudenti: TList < TTuple < Integer, string, string >> );
  end;

var
  Studenti: TStudenti;

implementation

uses
  Gesty_StoredProcs,
  zMsg,

  dmCommon;

{$R *.dfm}

procedure TStudenti.ImportSidi(const FileName: string);
var
  sp: TSP_STUDENTI_IMPORT_SIDI;
begin
  StartWait('Attendere...', true);
  try
    sp := TSP_STUDENTI_IMPORT_SIDI.Create(WriteTrans);
    try
      sp.Nome_File := FileNameNoExt(ExtractFileName(FileName));
      sp.File_Originale.LoadFromFile(FileName);
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    // ReopenDataSet('Studenti');
    RefreshDataSets;
  finally
    StopWait;
  end;
end;

procedure TStudenti.ImportSpaggiari(const FileName: string);
var
  sp: TSP_STUDENTI_IMPORT_SPAGGIARI;
begin
  StartWait('Attendere...', true);
  try
    sp := TSP_STUDENTI_IMPORT_SPAGGIARI.Create(WriteTrans);
    try
      sp.Nome_File := FileNameNoExt(ExtractFileName(FileName));
      sp.File_Originale.LoadFromFile(FileName);
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    // ReopenDataSet('Studenti');
    RefreshDataSets;
  finally
    StopWait;
  end;
end;

procedure TStudenti.RettificaDataIscrizione;
var
  DataIscrizione: TDate;
  idProgetto: Integer;
  idStudente: Integer;
  sp: TSP_STUDENTI_RETTIFICA_DATA_ISCRIZ;
  Dataset: TzFbDataSet;
begin
  Dataset := getDataSet('Studenti_Corsi');

  if Dataset.IsEmpty then
    Exit;

  idProgetto := Dataset.FieldByName('ID_PROGETTO').asInteger;
  idStudente := Dataset.FieldByName('ID_STUDENTE').asInteger;
  DataIscrizione := Date;

  if not InputDate('Data Iscrizione', 'Data Iscrizione', DataIscrizione) then
    Exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_STUDENTI_RETTIFICA_DATA_ISCRIZ.Create(WriteTrans);
    try
      sp.Id_Studente := idStudente;
      sp.Id_Progetto := idProgetto;
      sp.Data_Iscrizione := DataIscrizione;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    Dataset.ReOpen(true);
  finally
    StopWait;
  end;
end;

procedure TStudenti.RegistraRitiroStudente;
var
  DataRitiro: TDate;
  idProgetto: Integer;
  idStudente: Integer;
  sp: TSP_STUDENTI_REGISTRA_RITIRO;
  Dataset: TzFbDataSet;
begin
  Dataset := getDataSet('Studenti_Corsi');

  if Dataset.IsEmpty then
    Exit;

  idProgetto := Dataset.FieldByName('ID_PROGETTO').asInteger;
  idStudente := Dataset.FieldByName('ID_STUDENTE').asInteger;
  DataRitiro := Date;

  if not InputDate('Data Ritiro', 'Data Ritiro', DataRitiro) then
    Exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_STUDENTI_REGISTRA_RITIRO.Create(WriteTrans);
    try
      sp.Id_Studente := idStudente;
      sp.Id_Progetto := idProgetto;
      sp.Data_Ritiro := DataRitiro;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    Dataset.ReOpen(true);
  finally
    StopWait;
  end;
end;

procedure TStudenti.CreaUtenteSistema;
var
  Studenti: TzFbDataSet;
  idStudente: Integer;
  UserName: String;
begin
  Studenti := getDataSet('Studenti');

  if not Assigned(Studenti) then
    Exit;

  if Studenti.FieldExists('USER_NAME') then
    if not Studenti.FieldByName('USER_NAME').IsNull then
    begin
      ConfirmOk('Utente già generato per lo studente selezionato.');
      Exit;
    end;

  idStudente := Studenti.FieldByName('ID_STUDENTE').asInteger;
  UserName := Copy(Studenti.FieldByName('NOME').asString, 1, 1) + Studenti.FieldByName('COGNOME').asString;

  if Common.CreaUtenteSistema(UserName, idStudente) then
  begin
    Studenti.RefreshRecord();
    ConfirmOk('Utente di sistema generato.');
  end;
end;

procedure TStudenti.CreaUtentiSistema(ElencoStudenti: TList < TTuple < Integer, string, string >> );
var
  studente: TTuple<Integer, string, string>;
  idStudente: Integer;
  UserName: String;
begin

  if ElencoStudenti.count = 0 then
    Exit;

  if not ConfirmYesNo('Si desidera generare gli utenti di sistema?') then
    Exit;

  ProgressBox.Show(ElencoStudenti.count, 'Generazione Utenti Sistema', 'Generazione Utenti Sistema', 'Attendere...');
  try

    for studente in ElencoStudenti do
    begin
      idStudente := studente.Value1;
      UserName := Common.CalcUserName(studente.Value2, studente.Value3);
      ProgressBox.IncProgress(studente.Value3 + ' ' + studente.Value2, UserName);

      if ProgressBox.Cancelled then
        Exit;

      Common.CreaUtenteSistema(UserName, idStudente, false);
    end;

    ReopenDataSet('Studenti');
  finally
    ProgressBox.Close;
  end;
end;

function TStudenti.ImportDomandeIscrizione(const FileName: string): Integer;
var
  Dataset: TzFbDataSet;
  sp: TSP_STUDENTI_DOMANDE_ISCRIZIONE_FILES_ADD;
begin
  result := -1;

  StartWait('Attendere...', true);
  try
    sp := getsp<TSP_STUDENTI_DOMANDE_ISCRIZIONE_FILES_ADD>;
    try
      sp.Nome_File := ExtractFileName(FileName);
      sp.File_Originale.LoadFromFile(FileName);
      sp.ExecuteAndCommit;
      result := sp.Id_File_Import_Domande_Iscrizione;
    finally
      FreeAndNil(sp);
    end;

    ReopenDataSet('Studenti_Domande_Iscrizione_Files');
    ReopenDataSet('Studenti_Domande_Iscrizione');
    ReopenDataSet('Miur_Progetti');
  finally
    StopWait;
  end;
end;

procedure TStudenti.ElaboraDomandeIscrizione;
var
  Dataset: TzFbDataSet;
  sp: TSP_studenti_Domande_Iscrizione_Files_Elabora;
begin
  Dataset := getDataSet('Studenti_Domande_Iscrizione_Files');

  if Dataset.IsEmpty then
    Exit;

  if not ConfirmOkCancel('Si desidera elaborare il file selezionato?') then
    Exit;

  StartWait('Attendere...', true);
  try
    sp := getsp<TSP_studenti_Domande_Iscrizione_Files_Elabora>;
    try
      sp.Id_File_Import_Domande_Iscrizione := Dataset.FieldByName('ID_FILE_IMPORT_DOMANDE_ISCRIZIONE').value;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    Dataset.ReOpen();
    ReopenDataSet('Studenti_Domande_Iscrizione');
    ReopenDataSet('Miur_Progetti');
  finally
    StopWait;
  end;
end;

procedure TStudenti.Studenti_CorsiNewRecord(Dataset: TDataset);
var
  sp: TSP_STUDENTI_GET_GENITORE_FIRMATARIO_ISCRIZIONE;
  Studenti: TDataset;
  idStudente: Integer;
  fieldGenitore: TField;
begin
  Studenti := getDataSet('STUDENTI');

  if Studenti.IsEmpty then
    Exit;

  idStudente := Studenti.FieldByName('ID_STUDENTE').asInteger;

  fieldGenitore := Dataset.FieldByName('ID_GENITORE_FIRMATARIO_ISCRIZIONE');

  sp := getsp<TSP_STUDENTI_GET_GENITORE_FIRMATARIO_ISCRIZIONE>;
  try
    sp.Id_Studente := idStudente;
    sp.ExecuteWithoutCommit;

    if not sp.Id_Gentitore.IsNull then
      fieldGenitore.value := sp.Id_Gentitore;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TStudenti.Studenti_GenitoriAfterPost(Dataset: TDataset);
begin
  RefreshDataSet('Studenti_Corsi');
end;

// ── Mantis #73 - attestati sicurezza ─────────────────────────────────────────

procedure TStudenti.Studenti_Attestati_Sicurezza_NewRecord(Dataset: TDataset);
begin
  // Ogni riga inserita a mano e' un attestato esterno, valido.
  Dataset.FieldByName('FONTE').AsString := 'EST';
  Dataset.FieldByName('STATO').AsString := 'VAL';
end;

procedure TStudenti.Studenti_Attestati_Sicurezza_BeforeEdit(Dataset: TDataset);
begin
  if Dataset.FieldByName('FONTE').AsString = 'INT' then
    raise Exception.Create(
      'Attestato generato dal corso della sezione Accordo Stato-Regioni: non e'' modificabile a mano.' + sLineBreak +
      'Per aggiornarlo interveni sul partecipante nella sezione Accordo Stato-Regioni.');
end;

procedure TStudenti.Studenti_Attestati_Sicurezza_BeforeDelete(Dataset: TDataset);
begin
  if Dataset.FieldByName('FONTE').AsString = 'INT' then
    raise Exception.Create(
      'Attestato generato dal corso della sezione Accordo Stato-Regioni: non e'' eliminabile a mano.');
end;

procedure TStudenti.AfterCreateDataSet(const DataSetName: string; Dataset: TzFbDataSet);
begin
  inherited;
  if SameText(DataSetName, 'Studenti') then
    Dataset.AfterOpen := CustomizeDataSet
  else
    if SameText(DataSetName, 'Studenti_Corsi') then
    begin
      Dataset.OnNewRecord := Studenti_CorsiNewRecord;
      Dataset.AfterOpen := CustomizeDataSet;
    end
    else
      if SameText(DataSetName, 'Studenti_Genitori') then
      begin
        Dataset.AfterPost := Studenti_GenitoriAfterPost;
        Dataset.AfterOpen := CustomizeDataSet;
      end
      else
        if SameText(DataSetName, 'Studenti_Certificazioni_Ats') then
          Dataset.AfterOpen := CustomizeDataSet
        else
          if SameText(DataSetName, 'Studenti_Scuole_Provenienza') then
            Dataset.AfterOpen := CustomizeDataSet
          else
            if SameText(DataSetName, 'Anagrafe_Attestati_Sicurezza_Elenco') then
            begin
              Dataset.OnNewRecord := Studenti_Attestati_Sicurezza_NewRecord;
              Dataset.BeforeEdit := Studenti_Attestati_Sicurezza_BeforeEdit;
              Dataset.BeforeDelete := Studenti_Attestati_Sicurezza_BeforeDelete;
              Dataset.AfterOpen := CustomizeDataSet;
            end;
end;

procedure TStudenti.CustomizeDataSet(Dataset: TDataset);
begin
  Common.CustomizeDataSet(Dataset.Name, Dataset as TzFbDataSet);
end;

end.


