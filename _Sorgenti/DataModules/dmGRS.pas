unit dmGRS;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Vcl.Dialogs,
  Vcl.Controls,
  Vcl.Forms,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Base_DataModule,
  dbMaster,
  zBaseLib,
  zFbDataSet,
  QExport4,
  QExport4Xlsx,
  QExport4Types,
  QExport4Dialog,
  QImport3XMLBased,
  QImport3Xlsx,
  QImport3ASCII,
  QImport3,
  QImport3XLS,
  QImport3XMLDoc,
   zProgressBox,
  SIUF.CooperazioneApplicativa.Types,
  SIUF.CooperazioneApplicativa.Validator;

type
  TGRS = class(TBaseDataModule)
    lkEnti: TzFbDataSet;
    lkEntiSrc: TDataSource;
    lkProgetti: TzFbDataSet;
    lkProgettiSrc: TDataSource;
    lkCorsi: TzFbDataSet;
    lkCorsiSrc: TDataSource;
    lkStudenti: TzFbDataSet;
    lkStudentiSrc: TDataSource;
    QExport4Xlsx: TQExport4Xlsx;
    QImport3Xlsx: TQImport3Xlsx;
    QImport3XLS: TQImport3XLS;
    ProgressBox: TProgressBox;
    QImport3Xlsx_SIUF: TQImport3Xlsx;
    QImport3XLsx_GOL: TQImport3Xlsx;
    procedure QExport4XlsxBeforeExportRow(Sender: TObject; Row: TQExportRow; var Accept: Boolean);
    procedure QExport4XlsxCustomFormat(Sender: TObject; Field: TField; var Value: qeString);
    procedure QImport3XlsxUserDefinedImport(Sender: TObject; Row: TQImportRow);
  private
    ImportLines: TStrings;
    procedure PrepareImportMap(Map: TStrings);
    procedure PrepareImportMapXLS;
    procedure PrepareImportMapXLSX;
    procedure ImportaFileXML(const FileName: string);
    function CleanImportString(const s: string): string;
    function ImportStringEmpty(const s: string): Boolean;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure Esporta(const SelectedDataSetName, FileName: string);
    procedure CooperazioneApplicativa(const DataSetName: string);
  public
    function ImportaGRS(const FileName: string): integer;
    function ImportaSIUF(const FileName: string): integer;
    function ImportaGOL(const FileName: string): integer;

    procedure ElaboraFileImport;
    procedure EliminaFileImport;
  public
    procedure GeneraIncaricoMancante;
    procedure GeneraRilevamentiMancanti(orari: TList<integer>);
  public
    procedure ElaboraRigheImportNonValide;
  end;

var
  GRS: TGRS;

implementation

uses
  Winapi.ShellAPI,
  System.DateUtils,
  QImport3Common,
  Excel_FoglioDiCalcoloXML2003,
  zMsg,
  WizInserimentoIncaricoFrm,
  Gesty_StoredProcs,
  SIUF.CooperazioneApplicativa.Builder,
  SIUF.CooperazioneApplicativa.Client,
  dmSIUF_CooperazioneApplicativa;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TGRS.Create(aOwner: TComponent);
begin
  inherited;
  ImportLines := TStringList.Create;
end;

destructor TGRS.Destroy;
begin
  FreeAndNil(ImportLines);
  inherited;
end;

procedure TGRS.QExport4XlsxBeforeExportRow(Sender: TObject; Row: TQExportRow; var Accept: Boolean);
var
  i: integer;
begin
  inherited;

  for i := 0 to Row.Columns.Count - 1 do
    Row.Columns[i].ColType := ectString;
end;

procedure TGRS.QExport4XlsxCustomFormat(Sender: TObject; Field: TField; var Value: qeString);
begin
  inherited;

  if SameText(Field.FieldName, 'ORE_PRESENZA') or SameText(Field.FieldName, 'ORE_ASSENZA') or SameText(Field.FieldName, 'ORE_ASSENZA_GIUSTIFICATA') then
  begin
    Value := HourOf(Field.asDateTime).ToString;

    if MinuteOf(Field.asDateTime) > 0 then
      Value := Value + '.' + MinuteOf(Field.asDateTime).ToString.PadLeft(2, '0');
  end;
end;

procedure TGRS.Esporta(const SelectedDataSetName, FileName: string);
var
  StringList: TStringList;
  DataSet: TzFbDataSet;
  i: integer;
begin
  DataSet := GetDataSet(SelectedDataSetName);

  QExport4Xlsx.DataSet := DataSet;
  QExport4Xlsx.FileName := FileName;
  //
  QExport4Xlsx.ExportedFields.Clear;
  QExport4Xlsx.ExportedFields.Add('CODICE_FISCALE_STUDENTE');
  QExport4Xlsx.ExportedFields.Add('COGNOME');
  QExport4Xlsx.ExportedFields.Add('NOME');
  QExport4Xlsx.ExportedFields.Add('DATA');
  QExport4Xlsx.ExportedFields.Add('ORA_INIZIO');
  QExport4Xlsx.ExportedFields.Add('ORA_FINE');
  QExport4Xlsx.ExportedFields.Add('ORE_PRESENZA');
  QExport4Xlsx.ExportedFields.Add('ORE_ASSENZA');
  QExport4Xlsx.ExportedFields.Add('ORE_ASSENZA_GIUSTIFICATA');
  QExport4Xlsx.ExportedFields.Add('RIF_EVENTO_FORMATIVO');
  QExport4Xlsx.ExportedFields.Add('TIPOLOGIA');
  QExport4Xlsx.ExportedFields.Add('CODICE_FISCALE_DOCENTE');
  QExport4Xlsx.ExportedFields.Add('MATERIA');
  QExport4Xlsx.ExportedFields.Add('CONTENUTI_MATERIA');
  QExport4Xlsx.ExportedFields.Add('SEDE_FISICA_O_VIRTUALE');
  QExport4Xlsx.ExportedFields.Add('CODICE_FISCALE_CODOCENTE');
  QExport4Xlsx.ExportedFields.Add('MOTIVO_CHIUSURA');
  QExport4Xlsx.ExportedFields.Add('DATA_INIZIO_CHIUSURA');
  QExport4Xlsx.ExportedFields.Add('DATA_FINE_CHIUSURA');
  //
  QExport4Xlsx.Captions.Clear;
  QExport4Xlsx.Captions.Add('CODICE_FISCALE_STUDENTE=Codice fiscale studente');
  QExport4Xlsx.Captions.Add('COGNOME=Cognome');
  QExport4Xlsx.Captions.Add('NOME=Nome');
  QExport4Xlsx.Captions.Add('DATA=Data');
  QExport4Xlsx.Captions.Add('ORA_INIZIO=Ora inizio');
  QExport4Xlsx.Captions.Add('ORA_FINE=Ora fine');
  QExport4Xlsx.Captions.Add('ORE_PRESENZA=Ore Presenza');
  QExport4Xlsx.Captions.Add('ORE_ASSENZA=Ore Assenza');
  QExport4Xlsx.Captions.Add('ORE_ASSENZA_GIUSTIFICATA=Ore Assenza Giustificata');
  QExport4Xlsx.Captions.Add('RIF_EVENTO_FORMATIVO=Rif. Evento Formativo');
  QExport4Xlsx.Captions.Add('TIPOLOGIA=Tipologia');
  QExport4Xlsx.Captions.Add('CODICE_FISCALE_DOCENTE=Codice fiscale docente');
  QExport4Xlsx.Captions.Add('MATERIA=Materia');
  QExport4Xlsx.Captions.Add('CONTENUTI_MATERIA=Contenuti materia');
  QExport4Xlsx.Captions.Add('SEDE_FISICA_O_VIRTUALE=Sede fisica/virtuale');
  QExport4Xlsx.Captions.Add('CODICE_FISCALE_CODOCENTE=Codice fiscale codocente');
  QExport4Xlsx.Captions.Add('MOTIVO_CHIUSURA=Motivo chiusura');
  QExport4Xlsx.Captions.Add('DATA_INIZIO_CHIUSURA=Data inizio chiusura');
  QExport4Xlsx.Captions.Add('DATA_FINE_CHIUSURA=Data fine chiusura');
  //
  StartWait('Attendere...', True);
  try
    QExport4Xlsx.Execute;
  finally
    StopWait;
  end;

  /// //////////////////////////////////////////
  // eliminare
  exit;

  StartWait('Attendere...', True);
  try
    StringList := TStringList.Create;
    try
      DataSet.DisableControls;
      try
        DataSet.First;
        while not DataSet.Eof do
        begin
          StringList.Add(DataSet.FieldByName('RIGA_EXPORT').asString);
          DataSet.Next;
        end;
        StringList.SaveToFile(FileName);
      finally
        DataSet.EnableControls;
      end;
    finally
      FreeAndNil(StringList);
    end;
  finally
    StopWait;
  end;

  // riga ExportRiga
  ShellExecute(0, PCHAR('open'), PCHAR(ExtractFilePath(FileName)), nil, nil, SW_RESTORE);
end;

function TGRS.ImportaGRS(const FileName: string): integer;
var
  sp: TSP_GRS_IMPORT_FILES_ADD;
begin
  result := -1;

  ImportLines.Clear;

  if SameText(ExtractFileExt(FileName), '.CSV') then
    ImportLines.LoadFromFile(FileName)
  else
    if SameText(ExtractFileExt(FileName), '.XLSX') then
    begin
      PrepareImportMapXLSX;
      QImport3Xlsx.FileName := FileName;
      QImport3Xlsx.Execute;
    end
    else
      if SameText(ExtractFileExt(FileName), '.XLS') then
      begin
        PrepareImportMapXLS;
        QImport3XLS.FileName := FileName;
        QImport3XLS.Execute;
      end
      else
        if SameText(ExtractFileExt(FileName), '.XML') then
          ImportaFileXML(FileName);

  StartWait('Attendere...', True);
  try
    try
      sp := TSP_GRS_IMPORT_FILES_ADD.Create(WriteTrans);
      try
        sp.Nome_File := ExtractFileName(FileName);
        sp.File_Originale.Assign(ImportLines);
        sp.ExecuteAndCommit;
        result := sp.Id_Grs_Import_File;
        ImportLines.Clear;
      finally
        FreeAndNil(sp);
      end;
    finally
      StopWait;
    end;
  finally
    RefreshDataSet('GRS_FILES');
  end;
end;

procedure TGRS.ElaboraFileImport;
var
  sp: TSP_GRS_IMPORT_FILES_ELABORA;
  DataSet: TzFbDataSet;
  id: integer;
begin
  DataSet := GetDataSet('GRS_FILES');

  if DataSet.IsEmpty then
  begin
    ConfirmOk('Nessun file di import selezionato.');
    exit;
  end;

  if not ConfirmYesNo('Si desidera elaborare il file di import selezionato?') then
    exit;

  id := DataSet.FieldByName('ID_GRS_IMPORT_FILE').AsInteger;
  /// ///////
  StartWait('Attendere...', True);
  try
    sp := TSP_GRS_IMPORT_FILES_ELABORA.Create(WriteTrans);
    try
      sp.Id_Grs_Import_File := id;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSets;
    DataSet.LocateNonSQL('ID_GRS_IMPORT_FILE', id, []);
  finally
    StopWait;
  end;
end;

procedure TGRS.EliminaFileImport;
var
  sp: TSP_GRS_IMPORT_FILES_ELIMINA;
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('GRS_FILES');

  if DataSet.IsEmpty then
  begin
    ConfirmOk('Nessun file di import selezionato.');
    exit;
  end;

  if not ConfirmYesNo('Si desidera eliminare il file di import selezionato?') then
    exit;

  if not ConfirmYesNo('Attenzione: ' + #13#10 + 'verranno eliminate anche presenze e rilevamenti generati.' + #13#10#13#10 + 'Si desidera procedere?', mtWarning) then
    exit;

  /// ///////
  StartWait('Attendere...', True);
  try
    sp := TSP_GRS_IMPORT_FILES_ELIMINA.Create(WriteTrans);
    try
      sp.Id_Grs_Import_File := DataSet.FieldByName('ID_GRS_IMPORT_FILE').AsInteger;
      sp.Delete_File := True;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    DataSet.ReOpen();
    ReopenDataSet('Grs_Files_Righe');
  finally
    StopWait;
  end;
end;

procedure TGRS.ImportaFileXML(const FileName: string);
var
  WorkBook: IXMLWorkbookType;
  r, c: integer;
  s: string;
begin
  ImportLines.Clear;

  WorkBook := LoadWorkbook(FileName);

  for r := 0 to WorkBook.Worksheet.Table.Count - 1 do
  begin
    s := '';
    for c := 0 to WorkBook.Worksheet.Table.Row[r].Count - 1 do
      s := s + WorkBook.Worksheet.Table.Row[r].cell[c].Data.text + ';';

    ImportLines.Add(s);
  end;
end;

procedure TGRS.PrepareImportMap(Map: TStrings);
begin
  Map.Clear;
  Map.Add('Codice fiscale studente=A');
  Map.Add('Cognome=B');
  Map.Add('Nome=C');
  Map.Add('Data=D');
  Map.Add('Ora inizio=E');
  Map.Add('Ora fine=F');
  Map.Add('Ore Presenza=G');
  Map.Add('Ore Assenza=H');
  Map.Add('Ore Assenza Giustificata=I');
  Map.Add('Rif. Evento Formativo=J');
  Map.Add('Tipologia=K');
  Map.Add('Codice fiscale docente=L');
  Map.Add('Materia=M');
  Map.Add('Contenuti materia=N');
  Map.Add('Sede fisica/virtuale=O');
  Map.Add('Codice fiscale codocente=P');
end;

procedure TGRS.PrepareImportMapXLSX;
begin
  QImport3Xlsx.ImportDestination := qidUserDefined;
  QImport3Xlsx.SkipFirstRows := 1;
  QImport3Xlsx.SheetName := '';
  PrepareImportMap(QImport3Xlsx.Map);
end;

procedure TGRS.PrepareImportMapXLS;
begin
  QImport3XLS.ImportDestination := qidUserDefined;
  QImport3XLS.SkipFirstRows := 1;
  PrepareImportMap(QImport3XLS.Map);
end;

procedure TGRS.GeneraIncaricoMancante;
var
  DataSet: TzFbDataSet;
  idIncarico: integer;
  idOrario: integer;
  sp: TSP_GRS_IMPORT_AGGANCIA_INCARICO;
begin
  DataSet := GetDataSet('IncarichiMancanti');

  if DataSet.IsEmpty then
    exit;

  idOrario := DataSet.FieldByName('ID_ORARIO').AsInteger;

  idIncarico := ApriInserimentoIncaricoDaOrario(idOrario);
  if idIncarico <> -1 then
  begin
    sp := TSP_GRS_IMPORT_AGGANCIA_INCARICO.Create(WriteTrans);
    try
      sp.ID_ORARIO := idOrario;
      sp.ID_INCARICO := idIncarico;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    DataSet.ReOpen(True);
  end;
end;

procedure TGRS.GeneraRilevamentiMancanti(orari: TList<integer>);
var
  id: integer;
  sp: TSP_GRS_IMPORT_AGGANCIA_RILEVAMENTO;
begin
  if orari.Count = 0 then
    exit;

  if not ConfirmYesNo('Si desidera generare i rilevamenti per gli orari selezionati?') then
    exit;

  ProgressBox.show(orari.Count, 'Generazione Rilevamenti Orari', 'Generazione Rilevamenti Orari', 'Attendere...');
  try
    sp := TSP_GRS_IMPORT_AGGANCIA_RILEVAMENTO.Create(WriteTrans);
    try
      for id in orari do
      begin
        ProgressBox.IncProgress;
        if ProgressBox.Cancelled then
          exit;

        sp.ID_ORARIO := id;
        sp.ID_RILEVAMENTO_ORE := -1; // genera e aggancia
        sp.ExecuteAndCommit;
      end;
    finally
      FreeAndNil(sp);
    end;

    ReopenDataSet('RilevamentiMancanti');
  finally
    ProgressBox.Close;
  end
end;

procedure TGRS.ElaboraRigheImportNonValide;
var
  sp: TSP_GRS_IMPORT_FILES_ELABORA_RIGHE_NON_VALIDE;
begin

  if not ConfirmYesNo('Si desidera rielaborare le righe non valide?') then
    exit;

  StartWait('Attendere...', True);
  try
    sp := TSP_GRS_IMPORT_FILES_ELABORA_RIGHE_NON_VALIDE.Create(WriteTrans);
    try
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSet('RigheNonValide');
  finally
    StopWait;
  end;
end;

procedure TGRS.QImport3XlsxUserDefinedImport(Sender: TObject; Row: TQImportRow);
var
  s: String;
  i: integer;
begin
  s := '';

  for i := 0 to Row.Count - 1 do
    s := s + CleanImportString(Row.Items[i].Value) + ';';

  if not ImportStringEmpty(s) then
    ImportLines.Add(s);
end;

function TGRS.CleanImportString(const s: string): string;

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

function TGRS.ImportaSIUF(const FileName: string): integer;
var
  sp: TSP_GRS_IMPORT_FILES_ADD;
begin
  result := -1;

  ImportLines.Clear;

  QImport3Xlsx_SIUF.ImportDestination := qidUserDefined;
  QImport3Xlsx_SIUF.SkipFirstRows := 1;

  QImport3Xlsx_SIUF.Map.Clear;
  // Ordine dei campi in SIUF
  // CODICE_FISCALE
  // NOME
  // COGNOME
  // DATA_PRESENZA
  // ORA_INIZIO
  // ORA_FINE
  // N_ORE_PRESENZA
  // ASSENZA_GIUSTIFICATA
  // ASSENZA
  // ID_SEZIONE
  // TIPOLOGIA
  // DOCENTE
  // MATERIA
  // CONTENUTI
  // INSERITO_ENTRO_LIMITI
  // DATA_INSERIMENTO
  // DATA_MODIFICA
  // STATO_CONVALIDA

  QImport3Xlsx_SIUF.Map.Add('Codice fiscale studente=A');
  QImport3Xlsx_SIUF.Map.Add('Cognome=C');
  QImport3Xlsx_SIUF.Map.Add('Nome=B');
  QImport3Xlsx_SIUF.Map.Add('Data=D');
  QImport3Xlsx_SIUF.Map.Add('Ora inizio=E');
  QImport3Xlsx_SIUF.Map.Add('Ora fine=F');
  QImport3Xlsx_SIUF.Map.Add('Ore Presenza=G');
  QImport3Xlsx_SIUF.Map.Add('Ore Assenza=I');
  QImport3Xlsx_SIUF.Map.Add('Ore Assenza Giustificata=H');
  QImport3Xlsx_SIUF.Map.Add('Rif. Evento Formativo=J');
  QImport3Xlsx_SIUF.Map.Add('Tipologia=K');
  QImport3Xlsx_SIUF.Map.Add('Codice fiscale docente=L');
  QImport3Xlsx_SIUF.Map.Add('Materia=M');
  QImport3Xlsx_SIUF.Map.Add('Contenuti materia=N');
  // QImport3Xlsx_SIUF.Map.Add('Sede fisica/virtuale=O');
  // QImport3Xlsx_SIUF.Map.Add('Codice fiscale codocente=P');

  QImport3Xlsx_SIUF.FileName := FileName;
  QImport3Xlsx_SIUF.Execute;

  StartWait('Attendere...', True);
  try
    try
      sp := TSP_GRS_IMPORT_FILES_ADD.Create(WriteTrans);
      try
        sp.Nome_File := ExtractFileName(FileName);
        sp.File_Originale.Assign(ImportLines);
        sp.ExecuteAndCommit;
        result := sp.Id_Grs_Import_File;
        ImportLines.Clear;
      finally
        FreeAndNil(sp);
      end;
    finally
      StopWait;
    end;
  finally
    RefreshDataSet('GRS_FILES');
  end;
end;

function TGRS.ImportaGOL(const FileName: string): integer;
var
  sp: TSP_GRS_IMPORT_FILES_ADD;
begin
  result := -1;

  ImportLines.Clear;

  QImport3XLsx_GOL.ImportDestination := qidUserDefined;
  QImport3XLsx_GOL.SkipFirstRows := 1;

  QImport3XLsx_GOL.Map.Clear;
  // Ordine dei campi in GOL
  /// ///////////////////////
  // A = ID_SEZIONE
  // B = CODICE_FISCALE
  // C = NOME
  // D = COGNOME
  // E = DATA_PRESENZA
  // F = ORA_INIZIO
  // G = ORA_FINE
  // H = N_ORE_PRESENZA
  // I = ASSENZA_GIUSTIFICATA
  // J = ASSENZA
  // K = TIPOLOGIA
  // L = DOCENTE
  // M = MATERIA
  // N = CONTENUTI
  // O = VALIDATA
  // P = CODOCENTE

  QImport3XLsx_GOL.Map.Add('Codice fiscale studente=B');
  QImport3XLsx_GOL.Map.Add('Cognome=D');
  QImport3XLsx_GOL.Map.Add('Nome=C');
  QImport3XLsx_GOL.Map.Add('Data=E');
  QImport3XLsx_GOL.Map.Add('Ora inizio=F');
  QImport3XLsx_GOL.Map.Add('Ora fine=G');
  QImport3XLsx_GOL.Map.Add('Ore Presenza=H');
  QImport3XLsx_GOL.Map.Add('Ore Assenza=J');
  QImport3XLsx_GOL.Map.Add('Ore Assenza Giustificata=I');
  QImport3XLsx_GOL.Map.Add('Rif. Evento Formativo=A');
  QImport3XLsx_GOL.Map.Add('Tipologia=K');
  QImport3XLsx_GOL.Map.Add('Codice fiscale docente=L');
  QImport3XLsx_GOL.Map.Add('Materia=M');
  QImport3XLsx_GOL.Map.Add('Contenuti materia=N');
  // QImport3XLs_GOL.Map.Add('Sede fisica/virtuale=O');
  QImport3XLsx_GOL.Map.Add('Codice fiscale codocente=P');

  QImport3XLsx_GOL.FileName := FileName;
  QImport3XLsx_GOL.Execute;

  StartWait('Attendere...', True);
  try
    try
      sp := TSP_GRS_IMPORT_FILES_ADD.Create(WriteTrans);
      try
        sp.Nome_File := ExtractFileName(FileName);
        sp.File_Originale.Assign(ImportLines);
        sp.ExecuteAndCommit;
        result := sp.Id_Grs_Import_File;
        ImportLines.Clear;
      finally
        FreeAndNil(sp);
      end;
    finally
      StopWait;
    end;
  finally
    RefreshDataSet('GRS_FILES');
  end;
end;

procedure TGRS.CooperazioneApplicativa(const DataSetName: string);
var
  SIUF_CooperazioneApplicativa: TSIUF_CooperazioneApplicativa;
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet(DataSetName);

  Application.CreateForm(TSIUF_CooperazioneApplicativa, SIUF_CooperazioneApplicativa);
  try
    SIUF_CooperazioneApplicativa.Invia(DataSet);

    RefreshDataSet('Siuf_Cooperazione_Applicativa_Invii');
  finally
    FreeAndNil(SIUF_CooperazioneApplicativa)
  end;
end;

function TGRS.ImportStringEmpty(const s: string): Boolean;
begin
  result := s.Replace(';', '', [rfReplaceAll]).trim.IsEmpty;
end;

end.


// CODICE_FISCALE
// NOME
// COGNOME
// DATA_PRESENZA
// ORA_INIZIO
// ORA_FINE
// N_ORE_PRESENZA
// ASSENZA_GIUSTIFICATA
// ASSENZA
// ID_SEZIONE
// TIPOLOGIA
// DOCENTE
// MATERIA
// CONTENUTI
// INSERITO_ENTRO_LIMITI
// DATA_INSERIMENTO
// DATA_MODIFICA
// STATO_CONVALIDA
