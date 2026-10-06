unit dmExportRegione;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  dbMaster,
  zBaseLib,
  zFbDataSet,
  QExport4,
  QExport4Xlsx,
  QExport4Types,
  QExport4Dialog,
  Data.DB;

type
  TExportRegione = class(TBaseDataModule)
    QExport4Xlsx: TQExport4Xlsx;
    procedure QExport4XlsxBeforeExportRow(Sender: TObject; Row: TQExportRow; var Accept: Boolean);
    procedure QExport4XlsxCustomFormat(Sender: TObject; Field: TField; var Value: WideString);
  private
    { Private declarations }
  public
    procedure ApriExportRegione(DalGiorno, AlGiorno: TDateTime);
    procedure Esporta(const FileName: string);
  end;

var
  ExportRegione: TExportRegione;

implementation

uses
  Winapi.ShellAPI,
  System.DateUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TExportRegione.ApriExportRegione(DalGiorno, AlGiorno: TDateTime);
var
  DataSet: TzFbDataSet;

begin
  DataSet := GetDataSet('Export_Regione_Lombardia');

  DataSet.ParamByName('DAL_GIORNO').asDateTime := DalGiorno;
  DataSet.ParamByName('AL_GIORNO').asDateTime := AlGiorno;

  StartWait('Attendere...', True);
  try
    DataSet.ReOpen();
  finally
    StopWait;
  end;
end;

procedure TExportRegione.Esporta(const FileName: string);
var
  StringList: TStringList;
  DataSet: TzFbDataSet;
  i: Integer;
begin
  DataSet := GetDataSet('Export_Regione_Lombardia');

  QExport4Xlsx.DataSet := DataSet;
  QExport4Xlsx.FileName := FileName;
  //
  QExport4Xlsx.ExportedFields.Clear;
  QExport4Xlsx.ExportedFields.Add('CODICE_FISCALE');
  QExport4Xlsx.ExportedFields.Add('COGNOME');
  QExport4Xlsx.ExportedFields.Add('NOME');
  QExport4Xlsx.ExportedFields.Add('DATA_LEZIONE');
  QExport4Xlsx.ExportedFields.Add('ORA_INIZIO');
  QExport4Xlsx.ExportedFields.Add('ORA_FINE');
  QExport4Xlsx.ExportedFields.Add('ORE_PRESENZA');
  QExport4Xlsx.ExportedFields.Add('ORE_ASSENZA');
  QExport4Xlsx.ExportedFields.Add('ORE_ASSENZA_GIUSTIFICATA');
  QExport4Xlsx.ExportedFields.Add('CODICE_REGIONALE');
  QExport4Xlsx.ExportedFields.Add('TIPOLOGIA_FORMAZIONE');
  //
  QExport4Xlsx.Captions.Clear;
  QExport4Xlsx.Captions.Add('CODICE_FISCALE=Codice fiscale studente');
  QExport4Xlsx.Captions.Add('COGNOME=Cognome');
  QExport4Xlsx.Captions.Add('NOME=Nome');
  QExport4Xlsx.Captions.Add('DATA_LEZIONE=Data');
  QExport4Xlsx.Captions.Add('ORA_INIZIO=Ora inizio');
  QExport4Xlsx.Captions.Add('ORA_FINE=Ora fine');
  QExport4Xlsx.Captions.Add('ORE_PRESENZA=Ore Presenza');
  QExport4Xlsx.Captions.Add('ORE_ASSENZA=Ore Assenza');
  QExport4Xlsx.Captions.Add('ORE_ASSENZA_GIUSTIFICATA=Ore Assenza Giustificata');
  QExport4Xlsx.Captions.Add('CODICE_REGIONALE=Rif. Evento Formativo');
  QExport4Xlsx.Captions.Add('TIPOLOGIA_FORMAZIONE=Tipologia');
  //

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

procedure TExportRegione.QExport4XlsxBeforeExportRow(Sender: TObject; Row: TQExportRow; var Accept: Boolean);
var
  i: Integer;
begin
  inherited;

  for i := 0 to Row.Columns.Count - 1 do
    Row.Columns[i].ColType := ectString;
end;

procedure TExportRegione.QExport4XlsxCustomFormat(Sender: TObject; Field: TField; var Value: WideString);
begin
  inherited;

  if SameText(Field.FieldName, 'ORE_PRESENZA') or SameText(Field.FieldName, 'ORE_ASSENZA') or SameText(Field.FieldName, 'ORE_ASSENZA_GIUSTIFICATA') then
  begin
    Value := HourOf(Field.asDateTime).ToString;

    if MinuteOf(Field.asDateTime) > 0 then
      Value := Value + '.' + MinuteOf(Field.asDateTime).ToString.PadLeft(2, '0');
  end;
end;

end.
