unit dmAccordoStatoRegioni;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Base_DataModule,
  zFbDataSet,
  dbMaster,
  zDbViewDlg,
  QImport3,
  QImport3XMLBased,
  QImport3Xlsx,
  QImport3XLS,
  cxMemo;

type
  TAccordoStatoRegioni = class(TBaseDataModule)
    ImportStudentiDlg: TzDbViewDlg;
    QImport3Xlsx: TQImport3Xlsx;
    ImportNoteDlg: TzDbViewDlg;
    ImportAnagrafeDlg: TzDbViewDlg;
    procedure QImport3XlsxUserDefinedImport(Sender: TObject; Row: TQImportRow);
  private
    ImportLines: TStrings;
    function CleanImportString(const s: string): string;
    procedure PrepareImportMapXLSX;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure NuovoIncarico;
    procedure ImportaFileIscrizioni(const FileName: string);
    procedure ImportaStudenti;
    procedure ImportaAnagrafe;

    procedure ImportNote(const LookupDataSet: string; memo: TcxMemo);
  end;

var
  AccordoStatoRegioni: TAccordoStatoRegioni;

implementation

uses
  WizInserimentoIncaricoFrm,
  Gesty_StoredProcs,
  zBaseLib,
  QImport3Common,
  zSystem,
  Gesty_Filters;

{$R *.dfm}

constructor TAccordoStatoRegioni.Create(aOwner: TComponent);
begin
  inherited;
  ImportLines := TStringList.Create;
end;

destructor TAccordoStatoRegioni.Destroy;
begin
  FreeAndNil(ImportLines);
  inherited;
end;

{ TAccordoStatoRegioni }

procedure TAccordoStatoRegioni.NuovoIncarico;
var
  dataset: TzFbDataSet;
  IdProgetto: integer;
  IdCorso: integer;
  TotaleOreAttribuite: double;
begin
  dataset := getDataSet('Progetti_Asr_Sicurezza');

  if dataset.isempty then
    exit;

  IdProgetto := dataset.fieldByName('ID_PROGETTO').asInteger;

  if dataset.fieldByName('ID_CORSO').isNull then
    IdCorso := -1
  else
    IdCorso := dataset.fieldByName('ID_CORSO').asInteger;

  TotaleOreAttribuite := dataset.fieldByName('ORE_TOTALI').AsFloat;

  if ApriInserimentoASR(IdProgetto, IdCorso, TotaleOreAttribuite) <> -1 then
  begin
    RefreshDataSet('Progetti_Asr_Sicurezza');
    ReopenDataSet('Progetti_Asr_Sicurezza_Incarichi_Elenco');
  end;
end;

procedure TAccordoStatoRegioni.ImportaFileIscrizioni(const FileName: string);
var
  progetto: TzFbDataSet;
  sp: TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_PARTECIPANTI;
begin
  progetto := getDataSet('Progetti_Asr_Sicurezza');

  if progetto.isempty then
    exit;

  ImportLines.Clear;
  PrepareImportMapXLSX;
  QImport3Xlsx.FileName := FileName;
  if not QImport3Xlsx.Execute then
    exit;

  StartWait('Attendere...', true);
  try
    sp := getsp<TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_PARTECIPANTI>;
    try
      sp.Id_Progetto_Asr := progetto.fieldByName('ID_PROGETTO_ASR').value;
      sp.File_Csv.Assign(ImportLines);
      sp.ExecuteAndCommit;

    finally
      FreeAndNil(sp);
    end;
    ReopenDataSet('Partecipanti');
  finally
    StopWait;
  end;
end;

procedure TAccordoStatoRegioni.ImportaStudenti;
var
  progetto, lkStudenti: TzFbDataSet;
  sp: TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_STUDENTE;
begin
  progetto := getDataSet('Progetti_Asr_Sicurezza');
  lkStudenti := getDataSet('lkStudenti');

  if progetto.isempty then
    exit;

  lkStudenti.RevertSQL(False);
  lkStudenti.ParamByName('ID_PROGETTO_ASR').value := progetto.fieldByName('ID_PROGETTO_ASR').value;
  lkStudenti.Active := true;
  try
    sp := getsp<TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_STUDENTE>;
    try
      sp.Id_Progetto_Asr := progetto.fieldByName('ID_PROGETTO_ASR').value;

      ImportStudentiDlg.dataset := lkStudenti;
      ImportStudentiDlg.Execute(
        procedure
        begin
          sp.Id_Studente_Progetto := lkStudenti.fieldByName('ID_STUDENTE_PROGETTO').value;
          sp.ExecuteAndCommit;
        end);
    finally
      FreeAndNil(sp);
    end;

    ReopenDataSet('Partecipanti');
  finally
    lkStudenti.Active := False;
  end;
end;

procedure TAccordoStatoRegioni.QImport3XlsxUserDefinedImport(Sender: TObject; Row: TQImportRow);
var
  s: String;
  i: integer;
begin
  s := '';

  for i := 0 to Row.Count - 1 do
    s := s + CleanImportString(Row.Items[i].value) + ';';

  ImportLines.Add(s);
end;

function TAccordoStatoRegioni.CleanImportString(const s: string): string;

  function StripChars(const text: string; const NonValidChars: System.SysUtils.TSysCharSet): string;
  var
    i, j, zbsAdj: integer;
  begin
    SetLength(result, Length(text)); // Preallocate result maximum length
    j := 0; // Resulting string length counter
    zbsAdj := 1 - Low(String); // Handles zero based string offset
    for i := Low(text) to High(text) do
    begin
      if not CharInSet(text[i], NonValidChars) then
      begin
        Inc(j);
        result[j - zbsAdj] := text[i];
      end;
    end;
    SetLength(result, j); // Set result actual length
  end;

begin
  result := s;
  result := result.Replace(';', ',', [rfReplaceAll]);
  result := result.Replace(sLineBreak, ' ', [rfReplaceAll]);
  result := result.Replace(#160, ' ', [rfReplaceAll]);
  result := StripChars(result, [#0 .. #31]);
  result := result.trim;
end;

procedure TAccordoStatoRegioni.PrepareImportMapXLSX;
begin
  QImport3Xlsx.ImportDestination := qidUserDefined;
  QImport3Xlsx.SkipFirstRows := 1;
  QImport3Xlsx.SheetName := '';

  QImport3Xlsx.Map.Clear;
  QImport3Xlsx.Map.Add('AZIENDA=A');
  QImport3Xlsx.Map.Add('PIVA=B');
  QImport3Xlsx.Map.Add('COGNOME=C');
  QImport3Xlsx.Map.Add('NOME=D');
  QImport3Xlsx.Map.Add('CODICE FISCALE=E');
end;

procedure TAccordoStatoRegioni.ImportNote(const LookupDataSet: string; memo: TcxMemo);
var
  dataset, lookup: TzFbDataSet;
begin
  dataset := getDataSet('Progetti_Asr_Sicurezza');
  lookup := getDataSet(LookupDataSet);

  dataset.CheckEditMode;

  lookup.RevertSQL(False);
  lookup.Active := true;
  try
    ImportNoteDlg.dataset := lookup;
    ImportNoteDlg.Execute(
      procedure
      begin
        memo.lines.Add(lookup.fieldByName('NOTA').AsString);
      end);
  finally
    lookup.Active := False;
  end;
end;

procedure TAccordoStatoRegioni.ImportaAnagrafe;
var
  progetto, lkAnagrafe: TzFbDataSet;
  sp: TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_ANAGRAFICA;
begin
  progetto := getDataSet('Progetti_Asr_Sicurezza');
  lkAnagrafe := getDataSet('lkAnagrafe');

  if progetto.isempty then
    exit;

  lkAnagrafe.RevertSQL(False);
  lkAnagrafe.ParamByName('ID_PROGETTO_ASR').value := progetto.fieldByName('ID_PROGETTO_ASR').value;
  lkAnagrafe.Active := true;
  try
    sp := getsp<TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_ANAGRAFICA>;
    try
      sp.Id_Progetto_Asr := progetto.fieldByName('ID_PROGETTO_ASR').value;

      ImportAnagrafeDlg.dataset := lkAnagrafe;
      ImportAnagrafeDlg.Execute(
        procedure
        begin
          sp.Id_Anagrafica := lkAnagrafe.fieldByName('ID_ANAGRAFICA').value;
          sp.Id_Azienda := -1;
          sp.ExecuteAndCommit;
        end);
    finally
      FreeAndNil(sp);
    end;

    ReopenDataSet('Partecipanti');
  finally
    lkAnagrafe.Active := False;
  end;
end;

end.
