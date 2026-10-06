unit dmAS_Rendicontazione;

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
  dbMaster;

type
  TAS_Rendicontazione = class(TBaseDataModule)
  public
    function ImportTreEffe(const FileName: string): integer;
    procedure ElaboraTreEffeSelezionato;
  end;

var
  AS_Rendicontazione: TAS_Rendicontazione;

implementation

uses
  Gesty_StoredProcs, zFbDataSet, zBaseLib, zMsg;

{$R *.dfm}
{ TAS_Rendicontazione }

function TAS_Rendicontazione.ImportTreEffe(const FileName: string): integer;
var
  sp: TSP_AS_INTERVENTI_REND_TRE_EFFE_IMPORT;
begin
  result := -1;

  StartWait('Attendere...', true);
  try
    sp := TSP_AS_INTERVENTI_REND_TRE_EFFE_IMPORT.Create(WriteTrans);
    try
      sp.Nome_File := ExtractFileName(FileName);
      sp.File_Originale.loadFromFile(FileName);
      sp.ExecuteAndCommit;
      result := sp.ID_IMPORT_REND_TRE_EFFE_FILE;
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

procedure TAS_Rendicontazione.ElaboraTreEffeSelezionato;
var
  Files: TzFbDataSet;
  id: integer;
  sp: TSP_AS_INTERVENTI_REND_TRE_EFFE_IMPORT_FILE_ELABORA;
begin
  Files := GetDataSet('As_Interventi_Rend_Tre_Effe_Import_Files');

  if Files.IsEmpty then
    exit;

  if not ConfirmYesNo('Si desidera elaborare il file selezionato?') then
    exit;

  id := Files.FieldByName('ID_IMPORT_REND_TRE_EFFE_FILE').asInteger;

  StartWait('Attendere...', true);
  try
    sp := TSP_AS_INTERVENTI_REND_TRE_EFFE_IMPORT_FILE_ELABORA.Create(WriteTrans);
    try
      sp.ID_IMPORT_REND_TRE_EFFE_FILE := id;
      sp.ExecuteAndCommit;
      Files.ReOpen;
      ReopenDataSet('As_Interventi_Rend_Tre_Effe_Import_Righe');
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

end.
