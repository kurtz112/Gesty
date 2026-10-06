unit dmAllegati;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  Base_DataModule,
  dbMaster,
   zProgressBox,
  zFbDataSet;

type
  TAllegati = class(TBaseDataModule)
    ProgressBox: TProgressBox;
  public
    procedure IndicizzaAllegatiSenzaTesto;
    procedure IndicizzaAllegatoSelezionato;
  end;

var
  Allegati: TAllegati;

implementation

uses
  Gesty_StoredProcs,
  Files.Lib,
  zBaseLib;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TAllegati }

procedure TAllegati.IndicizzaAllegatiSenzaTesto;
var
  sp: TSP_OBJ_FILES_INDICIZZA;
  Dataset: TzFbDataSet;
  testo: string;
begin
  Dataset := GetDataSet('AllegatiDaIndicizzare');
  Dataset.Reopen;
  try
    ProgressBox.Show(Dataset.RecordCountFromServer, 'Indicizzazione allegati', 'Indicizzazione', 'Attendere...');
    try
      sp := TSP_OBJ_FILES_INDICIZZA.Create(WriteTrans);
      try
        Dataset.First;
        while not Dataset.EOF do
        begin
          ProgressBox.incProgress;
          if ProgressBox.Cancelled then
            Exit;

          testo := ExtractTextFromPDF(Dataset.FieldByName('FULL_FILE_NAME').asString);

          sp.Id_Object_File := Dataset.FieldByName('ID_OBJECT_FILE').asInteger;
          sp.testo.Text := testo;
          sp.ExecuteAndCommit;

          Dataset.Next;
        end;
      finally
        FreeAndNil(sp);
      end;

      RefreshDataSets;
    finally
      ProgressBox.Close;
    end;
  finally
    Dataset.Active := False;
  end;
end;

procedure TAllegati.IndicizzaAllegatoSelezionato;
var
  Dataset: TzFbDataSet;
  sp: TSP_OBJ_FILES_INDICIZZA;
  testo: string;
begin
  StartWait;
  try
    Dataset := GetDataSet('ElencoAllegatiRisorse');

    sp := TSP_OBJ_FILES_INDICIZZA.Create(WriteTrans);
    try
      testo := ExtractTextFromPDF(Dataset.FieldByName('FULL_FILE_NAME').asString);

      sp.Id_Object_File := Dataset.FieldByName('ID_OBJECT_FILE').asInteger;
      sp.testo.Text := testo;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    Dataset.RefreshRecord();
  finally
    StopWait;
  end;
end;

end.
