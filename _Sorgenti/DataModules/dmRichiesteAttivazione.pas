unit dmRichiesteAttivazione;

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
  zFbDataSet,
   zProgressBox,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  zDbCardDlg;

type
  TRichiesteAttivazione = class(TBaseDataModule)
    FilesDaCopiare: TzFbDataSet;
    ProgressBox: TProgressBox;
    Inquadramento: TzFbDataSet;
    cardInquadramento: TzDbCardDlg;
  private
    procedure CopiaAllegatiDaRichiestaAttivazioneInRisorsa(const idRichiesta: integer);
    // Mantis #107 - 2026-10-07: avviso sull'e-mail non utilizzabile per la firma elettronica
    procedure RichiestaAfterCreateFields(DataSet: TDataSet);
    procedure RichiestaEMailChange(Field: TField);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    procedure RicopiaAllegatiRisorsa;
    function ConvalidaRichiestaAttivazione: Boolean;
    procedure RichiestaAttivazioneNonValida;
    function ApprovaRichiestaAttivazione: Boolean;
    procedure RespingiRichiestaAttivazione;
    function GeneraRisorsa: Boolean;
  end;

var
  RichiesteAttivazione: TRichiesteAttivazione;

implementation

uses
  System.IOUtils,
  ConfigModule,
  Gesty_StoredProcs,
  zMemoDialog,
  zMsg;

{$R *.dfm}

procedure TRichiesteAttivazione.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  // Mantis #107 - 2026-10-07
  if SameText(DataSetName, 'Richieste_Attivazione') or SameText(DataSetName, 'RichiesteDaApprovare') then
    DataSet.OnAfterCreateFields := RichiestaAfterCreateFields;
end;

procedure TRichiesteAttivazione.RichiestaAfterCreateFields(DataSet: TDataSet);
var
  Campo: TField;
begin
  // Mantis #107 - 2026-10-07
  Campo := DataSet.FindField('E_MAIL');
  if Assigned(Campo) then
    Campo.OnChange := RichiestaEMailChange;
end;

procedure TRichiesteAttivazione.RichiestaEMailChange(Field: TField);
var
  Esito: Variant;
  TipoRisorsa: TField;
begin
  // Mantis #107 - 2026-10-07: sulla richiesta non c'e' il flag (lo decide il trigger alla generazione
  // della persona, con la stessa regola): qui si avvisa subito che l'e-mail non servira' per la firma.
  // Stessa regola della funzione E_MAIL_VALIDA, applicata al testo sanificato come fa l'invio
  TipoRisorsa := Field.DataSet.FindField('TIPO_RISORSA');
  if Assigned(TipoRisorsa) and (TipoRisorsa.AsString <> 'P') then
    Exit;

  if Trim(Field.AsString) = '' then
    Exit;

  Esito := Config.Database.ExecSQLScalar('SELECT E_MAIL_VALIDA(SANIFICATION.SANIFICA_TESTO(:EMAIL)) FROM RDB$DATABASE', [Field.AsString]);
  if VarIsNull(Esito) or (Esito <> True) then
    ConfirmOk('L''indirizzo e-mail non è valido per la firma elettronica (formato richiesto dal fornitore di firma): la persona, una volta attivata, non potrà essere usata per le firme elettroniche e il flag firma elettronica nascerà spento.', mtWarning);
end;

function TRichiesteAttivazione.ApprovaRichiestaAttivazione: Boolean;
var
  DataSet: TzFbDataSet;
  sp: TSP_richiesta_Attivazione_Approva;
  note: TStringList;
  idRichiesta: integer;
  TipoRisorsa: string;
  Data: TDateTime;
  src: string;
  Dest: string;
begin
  siMain.EnterMethod('ApprovaRichiestaAttivazione');

  Result := False;

  DataSet := GetDataSet('RichiesteDaApprovare');

  if DataSet.IsEmpty then
    Exit;

  idRichiesta := DataSet.FieldByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger;

  if idRichiesta = -1 then
    Exit;

  DataSet.CheckBrowseMode;

  TipoRisorsa := DataSet.FieldByName('TIPO_RISORSA').asString;

  // Mantis #132 - 2026-09-17: la data attivazione indicata dall'operatore sulla richiesta
  // ha la precedenza e non viene piu' sovrascritta dal calcolo automatico
  if not DataSet.FieldByName('DATA_ATTIVAZIONE').IsNull then
    Data := DataSet.FieldByName('DATA_ATTIVAZIONE').AsDateTime
  else
  // mail Raffaella 27.03.2023
  if DataSet.FieldByName('DATA_APPROVAZIONE').IsNull then
  begin
    if DataSet.FieldByName('DATA_LIMITE_APPROVAZIONE').IsNull then
      Data := Date
    else
      Data := DataSet.FieldByName('DATA_LIMITE_APPROVAZIONE').AsDateTime;

    // Richiesta Raffaella 07.06.2023
    // if not InputDate('Data Attivazione', 'Data Attivazione', Data) then
    // Exit;
  end
  else
    Data := DataSet.FieldByName('DATA_APPROVAZIONE').AsDateTime;

  note := TStringList.Create;
  try
    if not zExecuteMemoDialog(note, 'Esito valutazione') then
      Exit;

    Result := true; // permette la chuisura della card

    sp := TSP_richiesta_Attivazione_Approva.Create(WriteTrans);
    try
      sp.Id_Richiesta_Attivazione := idRichiesta;
      sp.Approvata := true;
      sp.Data_Attivazione := Data;
      sp.Esito_Approvazione := note;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;
  finally
    FreeAndNil(note);
  end;

  DataSet.ReOpen(true);
  siMain.EnterMethod('ApprovaRichiestaAttivazione');
end;

function TRichiesteAttivazione.ConvalidaRichiestaAttivazione: Boolean;
var
  DataSet: TzFbDataSet;
  sp: TSP_richiesta_Attivazione_Convalida;
  note: TStringList;
  idRichiesta: integer;
begin
  siMain.EnterMethod('ConvalidaRichiestaAttivazione');

  Result := False;

  DataSet := GetDataSet('RichiesteDaValidare');

  if DataSet.IsEmpty then
    Exit;

  idRichiesta := DataSet.FieldByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger;

  if idRichiesta = -1 then
    Exit;

  DataSet.CheckBrowseMode;

  note := TStringList.Create;
  try
    if not zExecuteMemoDialog(note, 'Esito valutazione') then
      Exit;

    Result := true; // permette la chuisura della card

    sp := TSP_richiesta_Attivazione_Convalida.Create(WriteTrans);
    try
      sp.Id_Richiesta_Attivazione := idRichiesta;
      sp.Valida := true;
      sp.Esito_Valutazione := note;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;
  finally
    FreeAndNil(note);
  end;

  DataSet.ReOpen(true);
  siMain.EnterMethod('ConvalidaRichiestaAttivazione');
end;

procedure TRichiesteAttivazione.CopiaAllegatiDaRichiestaAttivazioneInRisorsa(const idRichiesta: integer);
var
  src: string;
  Dest: string;
begin
  ProgressBox.show(1, 'Copia Allegati', 'Copia allegati', 'Attendere...');
  try
    FilesDaCopiare.RevertSQL(False);
    FilesDaCopiare.ParamByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger := idRichiesta;
    FilesDaCopiare.Active := true;
    try
      ProgressBox.MaxValue := FilesDaCopiare.RecordCountFromServer();
      FilesDaCopiare.First;
      while not FilesDaCopiare.Eof do
      begin
        src := FilesDaCopiare.FieldByName('SRC_FILE_NAME').asString;
        Dest := FilesDaCopiare.FieldByName('DEST_FILE_NAME').asString;
        siMain.LogString('FileSorgente', src);
        siMain.LogString('FileDestinazione', Dest);

        ProgressBox.IncProgress('Copia di ' + src, 'Destinazione ' + Dest);

        if TFile.Exists(src) then
        begin

          try
            ForceDirectories(ExtractFilePath(Dest));
          except
            on e: exception do
            begin
              ConfirmOk('Impossibile creare la cartella: ' + ExtractFilePath(Dest));
              raise;
            end;
          end;

          if not TFile.Exists(Dest) then
            TFile.Copy(src, Dest);
        end;

        FilesDaCopiare.next;
      end;
    finally
      FilesDaCopiare.Active := False;
    end;

  finally
    ProgressBox.Close;
  end;
end;

procedure TRichiesteAttivazione.RespingiRichiestaAttivazione;
var
  DataSet: TzFbDataSet;
  sp: TSP_richiesta_Attivazione_Approva;
  note: TStringList;
  idRichiesta: integer;
begin
  DataSet := GetDataSet('RichiesteDaApprovare');

  if DataSet.IsEmpty then
    Exit;

  idRichiesta := DataSet.FieldByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger;

  if idRichiesta = -1 then
    Exit;

  note := TStringList.Create;
  try
    if not zExecuteMemoDialog(note, 'Motivazione respingimento') then
      Exit;

    sp := TSP_richiesta_Attivazione_Approva.Create(WriteTrans);
    try
      sp.Id_Richiesta_Attivazione := idRichiesta;
      sp.Approvata := False;
      sp.Data_Attivazione.clear;
      sp.Esito_Approvazione := note;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    DataSet.ReOpen(true)
  finally
    FreeAndNil(note);
  end;
end;

procedure TRichiesteAttivazione.RichiestaAttivazioneNonValida;
var
  DataSet: TzFbDataSet;
  sp: TSP_richiesta_Attivazione_Convalida;
  note: TStringList;
  idRichiesta: integer;
begin
  DataSet := GetDataSet('RichiesteDaValidare');

  if DataSet.IsEmpty then
    Exit;

  idRichiesta := DataSet.FieldByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger;

  if idRichiesta = -1 then
    Exit;

  note := TStringList.Create;
  try
    if not zExecuteMemoDialog(note, 'Motivazione respingimento') then
      Exit;

    sp := TSP_richiesta_Attivazione_Convalida.Create(WriteTrans);
    try
      sp.Id_Richiesta_Attivazione := idRichiesta;
      sp.Valida := False;
      sp.Esito_Valutazione := note;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    DataSet.ReOpen(true)
  finally
    FreeAndNil(note);
  end;
end;

procedure TRichiesteAttivazione.RicopiaAllegatiRisorsa;
var
  DataSet: TzFbDataSet;
  idRichiesta: integer;
  sp: TSP_RICHIESTE_ATTIV_COPIA_FILE;
begin
  //
  DataSet := GetDataSet('RichiesteDaGenerare');
  idRichiesta := DataSet.FieldByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger;

  if ConfirmYesNo('Si desidera copiare gli allegati della richiesta di attivazione nella scheda risorsa?') then
  begin
    //
    sp := TSP_RICHIESTE_ATTIV_COPIA_FILE.Create(WriteTrans);
    try
      sp.Id_Richiesta_Attivazione := idRichiesta;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;
    //
    CopiaAllegatiDaRichiestaAttivazioneInRisorsa(idRichiesta);
    ConfirmOk('File copiati.');
  end;
end;

function TRichiesteAttivazione.GeneraRisorsa: Boolean;
var
  DataSet: TzFbDataSet;
  sp: TSP_RICHIESTA_ATTIVAZIONE_GENERA;
  note: TStringList;
  idRichiesta: integer;
  idRisorsa: integer;
  TipoRisorsa: string;
  Data: TDateTime;
  src: string;
  Dest: string;
begin
  siMain.EnterMethod('GeneraRisorsa');

  Result := False;

  if not ConfirmYesNo('Si desidera generare la risorsa selezionata?') then
    Exit;

  DataSet := GetDataSet('RichiesteDaGenerare');

  if DataSet.IsEmpty then
    Exit;

  idRichiesta := DataSet.FieldByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger;

  if idRichiesta = -1 then
    Exit;

  DataSet.CheckBrowseMode;

  Result := true; // permette la chiusura della card

  sp := TSP_RICHIESTA_ATTIVAZIONE_GENERA.Create(WriteTrans);
  try
    sp.Id_Richiesta_Attivazione := idRichiesta;
    sp.ExecuteAndCommit;
    idRisorsa := sp.Id_Risorsa;
  finally
    FreeAndNil(sp);
  end;

  /// //////////////////////////////////
  /// copia dei pdf
  ///
  CopiaAllegatiDaRichiestaAttivazioneInRisorsa(idRichiesta);
  ///
  /// //////////////////////////////////
  Inquadramento.Active := False;
  Inquadramento.ParamByName('ID_RISORSA').AsInteger := idRisorsa;
  Inquadramento.Active := true;
  try
    cardInquadramento.Execute;
  finally
    Inquadramento.Active := False;;
  end;
  /// //////////////////////////////////

  DataSet.ReOpen(true);
  siMain.EnterMethod('GeneraRisorsa');
end;

end.
