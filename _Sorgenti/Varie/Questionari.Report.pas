unit Questionari.Report;

interface

Uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Forms,
  Data.DB;

type
  TQuestionarioReport = record
  private
    xls, Workbook: OLEVariant;
    FieldList: TStrings;
    FTemplateFolder: string;
    FTemplateFileName: string;

    function GetSheet(const SheetName: string): OLEVariant;
    procedure ClearSheet(WorkSheet: OLEVariant);
  private
    function DataSetToArray(DataSet: TDataSet): variant;
    procedure LoadFieldList(const DataSetName: string);
    function FieldCount: integer;
    function FieldAllowed(Field: TField): boolean;
    function FieldCaption(Field: TField): string;
    function FieldIndex(Field: TField): integer;
  public
    procedure Init(aTemplateFileName: string);
    procedure ExportDataSet(const DataSet: TDataSet; const DataSetName: string);
    procedure Save(const FileName: string);

    property TemplateFolder: string read FTemplateFolder;
    property TemplateFileName: String read FTemplateFileName;
  end;

var
  QuestionarioReport: TQuestionarioReport;

implementation

uses
  Vcl.OleAuto,
  ShellApi;

procedure TQuestionarioReport.Init(aTemplateFileName: string);
begin
  FTemplateFolder := IncludeTrailingPathDelimiter(ExtractFilePath(aTemplateFileName));
  FTemplateFileName := ExtractFileName(aTemplateFileName);

  xls := CreateOLEObject('Excel.Application');
  xls.DisplayAlerts := false;
  Workbook := xls.Workbooks.add(aTemplateFileName);
  FieldList := TStringList.Create;
end;

function TQuestionarioReport.GetSheet(const SheetName: string): OLEVariant;
var
  i: integer;
begin
  Result := Unassigned;

  for i := 1 to Workbook.WorkSheets.Count do
    if SameText(Workbook.WorkSheets[i].Name, SheetName) then
    begin
      Result := Workbook.WorkSheets[i];
      Exit;
    end;

  Result := Workbook.WorkSheets.add;
  Result.Name := SheetName;
end;

procedure TQuestionarioReport.LoadFieldList(const DataSetName: string);
var
  FileName: String;
begin
  FileName := TemplateFolder + DataSetName + '.txt';
  FieldList.LoadFromFile(FileName);
end;

function TQuestionarioReport.FieldIndex(Field: TField): integer;
begin
  Result := FieldList.IndexOf(Field.FieldName);
end;

function TQuestionarioReport.FieldAllowed(Field: TField): boolean;
begin
  Result := FieldIndex(Field) <> -1;
end;

function TQuestionarioReport.FieldCount: integer;
begin
  Result := FieldList.Count;
end;

function TQuestionarioReport.DataSetToArray(DataSet: TDataSet): variant;
var
  Field: TField;
  idx: integer;
  RowCount, ColCount, i: integer;
begin
  RowCount := DataSet.RecordCount + 2; // header
  ColCount := FieldCount;

  Result := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);

  DataSet.DisableControls;
  try
    // idx := 0;
    for Field in DataSet.Fields do // !
      if FieldAllowed(Field) then
      begin
        // inc(idx);
        idx := FieldIndex(Field) + 1;
        Result[1, idx] := FieldCaption(Field);
      end;

    DataSet.First;
    while not DataSet.Eof do
    begin
      // idx := 0;
      for Field in DataSet.Fields do // !
        if FieldAllowed(Field) then
        begin
          // inc(idx);
          idx := FieldIndex(Field) + 1;

          if Field.IsBlob and ((Field is TMemoField) or (Field is TWideMemoField)) then
            Result[DataSet.RecNo + 1, idx] := Field.asString
          else
            Result[DataSet.RecNo + 1, idx] := Field.Value;
        end;

      DataSet.Next;
    end;
  finally
    DataSet.EnableControls;
  end;
end;

procedure TQuestionarioReport.ExportDataSet(const DataSet: TDataSet; const DataSetName: string);
var
  WorkSheet, Range: OLEVariant;
  a: variant;
  RowCount, ColCount: integer;
begin
  LoadFieldList(DataSetName);
  RowCount := DataSet.RecordCount + 2; // header
  ColCount := FieldCount;

  a := DataSetToArray(DataSet);

  /// //////////////////////////////////
  WorkSheet := GetSheet(DataSetName);
  // WorkSheet.Select;
  ClearSheet(WorkSheet);

  Range := WorkSheet.Range[WorkSheet.Cells[1, 1], WorkSheet.Cells[RowCount, ColCount]];
  Range.Value := a;

  Range := WorkSheet.Usedrange;
  Range.Columns.AutoFit;

  // WorkSheet.Visible := false;

  WorkSheet := Unassigned;
end;

procedure TQuestionarioReport.Save(const FileName: string);
begin
  FreEAndNil(FieldList);
  Workbook.SaveAs(FileName);
  xls.Workbooks.Close;
  xls.DisplayAlerts := True;
  xls.Quit;

  Workbook := Unassigned;
  xls := Unassigned;

  ShellExecute(Application.Handle, 'open', PChar(FileName), nil, nil, SW_SHOW);
end;

procedure TQuestionarioReport.ClearSheet(WorkSheet: OLEVariant);
var
  Range, Usedrange: OLEVariant;
  RowCount, ColCount: integer;
begin
  Usedrange := WorkSheet.Usedrange;

  RowCount := Usedrange.Rows.Count;
  ColCount := Usedrange.Columns.Count;

  Range := WorkSheet.Range[WorkSheet.Cells[2, 1], WorkSheet.Cells[RowCount, ColCount]];
  Range.Value := Unassigned;
end;

function TQuestionarioReport.FieldCaption(Field: TField): string;
begin
  Result := FieldList.Values[Field.FieldName];

  if Result.IsEmpty then
    Result := Field.DisplayLabel;
end;

end.
