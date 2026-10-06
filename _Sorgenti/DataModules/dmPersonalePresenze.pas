unit dmPersonalePresenze;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.Db,
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
  zFbDataSet,
  zDbViewDlg;

type
  TPersonalePresenze = class(TBaseDataModule)
    Presenze: TzFbDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure PresenzeAfterPost(DataSet: TDataSet);
    procedure PresenzeNewRecord(DataSet: TDataSet);
  private
    LastIdPersonale: integer;
    LastData: TDateTime;
    function IdRisorsaSelezionata: integer;
    function Presenze_AnnoSelezionato: string;
    function Presenze_MeseSelezionato: integer;
  public
    function ImportaOmniaTime(Files: TStrings): integer;
    procedure ElaboraOmniaTime;
  end;

var
  PersonalePresenze: TPersonalePresenze;

implementation

uses
  System.DateUtils, System.Variants, Vcl.Dialogs, Vcl.Controls, Vcl.Forms,
  zOffice.Reports, Gesty_StoredProcs,   zBaseLib, dmCommon, zMsg;

{$R *.dfm}

procedure TPersonalePresenze.DataModuleCreate(Sender: TObject);
begin
  inherited;
  LastIdPersonale := -1;
  LastData := Date;

  ReportsManager.AddVariablesProc := procedure(ReportsManager: TzReportsManager)
    begin
      ReportsManager.AddVariable('Presenze_Id_Personale', IdRisorsaSelezionata);
      ReportsManager.AddVariable('Presenze_Anno', Presenze_AnnoSelezionato);
      ReportsManager.AddVariable('Presenze_Mese', Presenze_MeseSelezionato);
    end;
end;

function TPersonalePresenze.Presenze_AnnoSelezionato: string;
var
  DataSet: TzFbDataSet;
begin
  result := '0000/0000';

  DataSet := getDataSet('Presenze');

  if not DataSet.ParamByName('ANNO_FORMATIVO').IsNull then
    result := DataSet.ParamByName('ANNO_FORMATIVO').asString;
end;

function TPersonalePresenze.Presenze_MeseSelezionato: integer;
var
  DataSet: TzFbDataSet;
  mese: integer;
begin
  result := -1;

  DataSet := getDataSet('Presenze');

  if not DataSet.ParamByName('MESE').IsNull then
    result := DataSet.ParamByName('MESE').AsInteger;
end;

function TPersonalePresenze.IdRisorsaSelezionata: integer;
var
  DataSet: TzFbDataSet;
begin
  result := -1;

  DataSet := getDataSet('Presenze');

  if not DataSet.IsEmpty then
    result := DataSet.FieldByName('ID_PERSONALE').AsInteger;
end;

procedure TPersonalePresenze.PresenzeAfterPost(DataSet: TDataSet);
begin
  inherited;
  LastIdPersonale := Presenze.FieldByName('ID_PERSONALE').AsInteger;
  LastData := DateOf(Presenze.FieldByName('DATA_PRESENZA').AsDateTime);
end;

procedure TPersonalePresenze.PresenzeNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('TIPO_RILEVAMENTO').asString := 'M'; // manuale

  if LastIdPersonale <> -1 then
  begin
    DataSet.FieldByName('ID_PERSONALE').AsInteger := LastIdPersonale;
    DataSet.FieldByName('DATA_PRESENZA').AsDateTime := LastData;

    Common.FocusField(DataSet.FieldByName('ORA_ENTRATA'));
  end
  else
    Common.FocusField(DataSet.FieldByName('ID_PERSONALE'));
end;

function TPersonalePresenze.ImportaOmniaTime(Files: TStrings): integer;
var
  sp: TSP_OMNIATIME_FILES_ADD;
  FileName: string;
begin
  result := -1;

  StartWait('Attendere...', True);
  try
    sp := TSP_OMNIATIME_FILES_ADD.Create(WriteTrans);
    try

      for FileName in Files do
      begin
        sp.Nome_File := ExtractFileName(FileName);
        sp.File_Originale.loadFromFile(FileName);
        sp.ExecuteAndCommit;

        if Files.Count = 1 then
          result := sp.ID_OMNIATIME_FILE;
      end;
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

procedure TPersonalePresenze.ElaboraOmniaTime;
var
  id: integer;
  sp: TSP_OMNIATIME_FILES_ELABORA;
  DataSet: TzFbDataSet;
begin
  DataSet := getDataSet('OMNIATIME_FILES');

  if DataSet.IsEmpty then
    exit;

  if not ConfirmYesNo('Si desidera elaborare il file di import selezionato?') then
    exit;

  id := DataSet.FieldByName('ID_OMNIATIME_FILE').AsInteger;

  StartWait('Attendere...', True);
  try
    sp := TSP_OMNIATIME_FILES_ELABORA.Create(WriteTrans);
    try
      sp.ID_OMNIATIME_FILE := id;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    DataSet.Reopen();
    ReopenDataSet('Omniatime_Righe');
  finally
    StopWait;
  end;
end;

end.
