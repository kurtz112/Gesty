unit dmAbitare_Sostegno;

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
  dbMaster,
  zFbDataSet,
   zProgressBox,
  System.Net.HttpClient;

type
  TAbitareSostegno = class(TBaseDataModule)
    ProgressBox: TProgressBox;
  private
  protected
  public
    procedure ApriSchedaSostegno(const Inserting: boolean);
    //
    procedure DownloadAllegati;
  end;

var
  AbitareSostegno: TAbitareSostegno;

implementation

uses
  System.DateUtils,
  frmAbitare_Sostegno_Scheda;

{$R *.dfm}

procedure TAbitareSostegno.ApriSchedaSostegno(const Inserting: boolean);
var
  Richieste: TzFbDataSet;
  IdRichiesta: Integer;
begin
  Richieste := GetDataSet('ElencoRichieste');

  if Inserting then
    IdRichiesta := -1
  else
    IdRichiesta := Richieste.FieldByName('ID_RICHIESTA_SOSTEGNO').AsInteger;

  if ApriRichiesta(IdRichiesta) then
    if Inserting then
    begin
      // La richiesta appena creata non e' nel risultato gia' aperto: l'elenco
      // va riletto e riposizionato su di essa, altrimenti l'operatore non vede
      // quello che ha appena inserito.
      Richieste.ReOpen(True);
      Richieste.Locate('ID_RICHIESTA_SOSTEGNO', IdRichiesta, []);
    end
    else
      Richieste.RefreshRecord(False);
end;

/// ////////////////////////////////////////////////////////////////////////////

procedure TAbitareSostegno.DownloadAllegati;

var
  allegati: TzFbDataSet;
  id, src, dest: string;
  log: TStringList;

  function download(id, src, dest: string): boolean;
  var
    FileStream: TStream;
    HttpClient: THTTPClient;
    Risposta: IHTTPResponse;
  begin
    result := True;

    ForceDirectories(ExtractFilePath(dest));
    FileStream := TFileStream.Create(dest, fmCreate);

    try
      try
        HttpClient := THTTPClient.Create;
        try
          Risposta := HttpClient.Get(src, FileStream);
          if Risposta.StatusCode >= 300 then
            raise Exception.CreateFmt('Errore HTTP %d', [Risposta.StatusCode]);
        finally
          FreeAndNil(HttpClient);
        end;
      except
        log.AddPair(id, src);
      end;
    finally
      FreeAndNil(FileStream);
    end;

    result := FileExists(dest);
  end;

begin
  allegati := GetDataSet('lkDownloadAllegati');
  allegati.Active := True;

  ProgressBox.Show(allegati.RecordCountFromServer(), 'Download Allegati', 'Attendere...', 'Attendere...');
  try
    log := TStringList.Create;
    try
      allegati.First;
      while not allegati.Eof do
      begin
        id := allegati.FieldByName('ID_RICHIESTA_SOSTEGNO').asString;
        src := allegati.FieldByName('URL').asString;
        dest := allegati.FieldByName('FULL_FILE_NAME').asString;

        ProgressBox.IncProgress(src);
        if ProgressBox.Cancelled then
          break;

        download(id, src, dest);

        allegati.Next;
      end;
      log.SaveToFile(ChangeFileExt(Application.ExeName, 'logAllegati'));
    finally
      FreeAndNil(log);
    end;
  finally
    ProgressBox.Close;
  end;
end;

end.
