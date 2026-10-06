unit dmAssistenzaScolastica;

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
  cxDBExtLookupComboBox,
  cxSpinEdit,
  cxImageComboBox,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  zDbCardDlg,
  zDbViewDlg,
  Gesty.types,
   zProgressBox,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TAssistenzaScolastica = class(TBaseDataModule)
    cardUtenteAS: TzDbCardDlg;
    dlgUtenti: TzDbViewDlg;
    ProgressBox: TProgressBox;
    lkAnniFormativi: TzFbDataSet;
    lkAnniFormativiSrc: TDataSource;
  private type
    TDuplicazioneParams = record
      IdIntervento: integer;
      TipoIntervento: TASTipoIntervento;
      CodiceFiscale: string;
      procedure Clear;
    end;
  private
    procedure InterventiAS_AfterScroll(DataSet: TDataSet);
    procedure InterventiAES_AfterScroll(DataSet: TDataSet);
    procedure InterventiADH_AfterScroll(DataSet: TDataSet);
    procedure Rendicontazioni_AS_AfterPost(DataSet: TDataSet);

    procedure ClonazioneInterventoAfterPost(DataSet: TDataSet);
  private
    DuplicazioneParams: TDuplicazioneParams;
    procedure ClonaAllegati(const oidSrc, oidDest: integer);
  private
    procedure InterventiAES_AfterCreateFields(DataSet: TDataSet);
    procedure InterventiAES_FieldChanged(Sender: TField);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    InterventiAS_AfterScrollProc: TProc;
    InterventiAES_AfterScrollProc: TProc;
    InterventiADH_AfterScrollProc: TProc;
  public
    Constructor Create(aOwner: TComponent); override;

    procedure MostaSchedaAnagraficaUtente(const DataSetName: string);

    procedure AggiungiUtentiAGruppoSelezionato;

    function DuplicaUtente(const DataSetName: string): Boolean;

    procedure ImpostaCostoOrario;
  end;

var
  AssistenzaScolastica: TAssistenzaScolastica;

implementation

uses
  System.IOUtils,
  Gesty_StoredProcs,
  zCodiceFiscale,
  zSystem,
  zFrmParams,
  zBaseLib,
  zDX,
  zMsg;

{$R *.dfm}
{ TAssistenzaScolastica.TDuplicazioneParams }

procedure TAssistenzaScolastica.TDuplicazioneParams.Clear;
begin
  IdIntervento := -1;
  TipoIntervento := tiNull;
  CodiceFiscale := '';
end;

procedure TAssistenzaScolastica.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'AS_INTERVENTI_AS') then
  begin
    DataSet.AfterScroll := InterventiAS_AfterScroll;
    DataSet.AfterPost := ClonazioneInterventoAfterPost;
  end
  else
    if SameText(DataSetName, 'AS_INTERVENTI_AES') then
    begin
      DataSet.AfterScroll := InterventiAES_AfterScroll;
      DataSet.AfterPost := ClonazioneInterventoAfterPost;
      DataSet.OnAfterCreateFields := InterventiAES_AfterCreateFields;
    end
    else
      if SameText(DataSetName, 'AS_INTERVENTI_ADH') then
      begin
        DataSet.AfterScroll := InterventiADH_AfterScroll;
        DataSet.AfterPost := ClonazioneInterventoAfterPost;
      end
      else
        if SameText(DataSetName, 'Rendicontazioni_AS') then
          DataSet.AfterPost := Rendicontazioni_AS_AfterPost;
end;

constructor TAssistenzaScolastica.Create(aOwner: TComponent);
begin
  inherited;
  InterventiAS_AfterScrollProc := nil;
  InterventiAES_AfterScrollProc := nil;
  InterventiADH_AfterScrollProc := nil;
  DuplicazioneParams.Clear;
end;

procedure TAssistenzaScolastica.InterventiAS_AfterScroll(DataSet: TDataSet);
begin
  if assigned(InterventiAS_AfterScrollProc) then
    InterventiAS_AfterScrollProc();
end;

procedure TAssistenzaScolastica.InterventiAES_AfterScroll(DataSet: TDataSet);
begin
  if assigned(InterventiAES_AfterScrollProc) then
    InterventiAES_AfterScrollProc();
end;

procedure TAssistenzaScolastica.InterventiADH_AfterScroll(DataSet: TDataSet);
begin
  if assigned(InterventiADH_AfterScrollProc) then
    InterventiADH_AfterScrollProc();
end;

procedure TAssistenzaScolastica.MostaSchedaAnagraficaUtente(const DataSetName: string);
var
  Intervento: TzFbDataSet;
  Utente: TzFbDataSet;
begin
  Intervento := getDataSet(DataSetName);
  Utente := getDataSet('As_Utenti_Elenco');

  Utente.RevertSQL(false);
  Utente.ParamByName('ID_UTENTE_AS').AsInteger := Intervento.FieldByName('ID_UTENTE_AS').AsInteger;

  Utente.Active := true;
  try
    cardUtenteAS.DataSet := Utente;

    if cardUtenteAS.Execute then
      Intervento.RefreshRecord(false);
  finally
    Utente.Active := false;
  end;
end;

procedure TAssistenzaScolastica.Rendicontazioni_AS_AfterPost(DataSet: TDataSet);
var
  As_Interventi_AS: TzFbDataSet;
begin
  As_Interventi_AS := getDataSet('As_Interventi_AS');
  As_Interventi_AS.RefreshRecord(false);
end;

procedure TAssistenzaScolastica.AggiungiUtentiAGruppoSelezionato;
var
  Gruppi, Utenti_Gruppi, lkDataSet: TzFbDataSet;
begin
  Gruppi := getDataSet('As_Gruppi');
  Utenti_Gruppi := getDataSet('As_Utenti_Gruppi_Studenti');
  lkDataSet := getDataSet('lkUtenti');

  if Gruppi.IsEmpty then
    exit;

  lkDataSet.RevertSQL(false);
  lkDataSet.ParamByName('ID_GRUPPO_AS').AsInteger := Gruppi.FieldByName('ID_GRUPPO_AS').AsInteger;
  lkDataSet.ParamByName('BELFIORE').AsString := Gruppi.FieldByName('BELFIORE').AsString;
  lkDataSet.Active := true;
  try
    dlgUtenti.DataSet := lkDataSet;
    if dlgUtenti.Execute(
      procedure
      begin
        Utenti_Gruppi.Append;
        Utenti_Gruppi.FieldByName('ID_GRUPPO_AS').AsInteger := Gruppi.FieldByName('ID_GRUPPO_AS').AsInteger;
        Utenti_Gruppi.FieldByName('ID_INTERVENTO_OBJ').AsInteger := lkDataSet.FieldByName('ID_INTERVENTO_OBJ').AsInteger;
        Utenti_Gruppi.Post;
      end) then
    begin
      Gruppi.RefreshRecord();
      Utenti_Gruppi.ReOpen();
    end;
  finally
    lkDataSet.Active := false;
  end;
end;

procedure TAssistenzaScolastica.ClonazioneInterventoAfterPost(DataSet: TDataSet);
var
  oidSrc, oidDest: integer;
begin

  if DuplicazioneParams.TipoIntervento <> tiNull then
    if DuplicazioneParams.IdIntervento <> -1 then
    begin
      oidSrc := DuplicazioneParams.IdIntervento;

      case DuplicazioneParams.TipoIntervento of
        tiNull:
          oidDest := -1;
        tiAS:
          oidDest := DataSet.FieldByName('ID_INTERVENTO_AS').value;
        tiAES:
          oidDest := DataSet.FieldByName('ID_INTERVENTO_AES').value;
        tiADH:
          oidDest := DataSet.FieldByName('ID_INTERVENTO_ADH').value;
      end;

      if oidDest <> -1 then
        ClonaAllegati(oidSrc, oidDest);

      DuplicazioneParams.Clear;
    end;
end;

procedure TAssistenzaScolastica.ClonaAllegati(const oidSrc, oidDest: integer);
var
  src: string;
  Dest: string;
  FilesDaCopiare: TzFbDataSet;
  sp: TSP_AS_INTERVENTI_ALLEGATI_CLONA;
begin
  // Crea gli allegati di destinazione
  sp := GetSP<TSP_AS_INTERVENTI_ALLEGATI_CLONA>;
  try
    sp.Oid_Src := oidSrc;
    sp.Oid_Dest := oidDest;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  //
  FilesDaCopiare := getDataSet('lkAs_Interventi_Allegati_Da_Clonare');

  ProgressBox.show(1, 'Copia Allegati', 'Copia allegati', 'Attendere...');
  try
    FilesDaCopiare.RevertSQL(false);
    FilesDaCopiare.ParamByName('OID_SRC').AsInteger := oidSrc;
    FilesDaCopiare.ParamByName('OID_DEST').AsInteger := oidDest;
    FilesDaCopiare.Active := true;
    try
      ProgressBox.MaxValue := FilesDaCopiare.RecordCountFromServer();
      FilesDaCopiare.First;
      while not FilesDaCopiare.Eof do
      begin
        src := FilesDaCopiare.FieldByName('SRC_FILE_NAME').AsString;
        Dest := FilesDaCopiare.FieldByName('DEST_FILE_NAME').AsString;
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
      FilesDaCopiare.Active := false;
    end;

  finally
    ProgressBox.Close;
  end;
end;

procedure TAssistenzaScolastica.InterventiAES_AfterCreateFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('ORE_RICHIESTE_IN_PORTALE').OnChange := InterventiAES_FieldChanged;
  DataSet.FieldByName('NUMERO_SETTIMANE_DI_INTERVENTO').OnChange := InterventiAES_FieldChanged;
  DataSet.FieldByName('IMPORTO_RIMBORSO_TRASPORTO').OnChange := InterventiAES_FieldChanged;
  DataSet.FieldByName('COSTO_OMNICOMPRENSIVO').OnChange := InterventiAES_FieldChanged;
end;

procedure TAssistenzaScolastica.InterventiAES_FieldChanged(Sender: TField);
var
  DataSet: TzFbDataSet;
  monteOre: integer;
  ore: integer;
  settimane: integer;
  trasporto: currency;
  omnicomprensivo: currency;
  assEducativa: currency;
  daFatturare: integer;
  daRendicontare: integer;
  Acconto: currency;
  Saldo: currency;
begin
  DataSet := getDataSet('AS_INTERVENTI_AES');

  ore := DataSet.FieldByName('ORE_RICHIESTE_IN_PORTALE').AsInteger;
  settimane := DataSet.FieldByName('NUMERO_SETTIMANE_DI_INTERVENTO').AsInteger;
  trasporto := DataSet.FieldByName('IMPORTO_RIMBORSO_TRASPORTO').AsCurrency;
  omnicomprensivo := DataSet.FieldByName('COSTO_OMNICOMPRENSIVO').AsCurrency;
  monteOre := ore * settimane;
  assEducativa := monteOre * omnicomprensivo;

  if omnicomprensivo = 0 then
    daFatturare := 0
  else
    daFatturare := trunc(assEducativa / omnicomprensivo);

  daRendicontare := monteOre - daFatturare;

  Acconto := trasporto / 2;
  Saldo := trasporto - Acconto;

  DataSet.FieldByName('MONTE_ORE_CALCOLATO_DA_RL').value := monteOre;
  DataSet.FieldByName('IMPORTO_ASSISTENZA_EDUCATIVA').value := assEducativa;
  DataSet.FieldByName('TOTALE_IMPORTO_INTERVENTO').value := assEducativa + trasporto;

  DataSet.FieldByName('MONTE_ORE_DIRETTE_DA_FATTURARE').value := daFatturare;
  DataSet.FieldByName('ORE_INDIRETTE_DA_RENDICONTARE').value := daRendicontare;

  DataSet.FieldByName('IMPORTO_ACCONTO').value := Acconto;
  DataSet.FieldByName('IMPORTO_SALDO').value := Saldo;
end;

function TAssistenzaScolastica.DuplicaUtente(const DataSetName: string): Boolean;
var
  NoCopyFields: string;
  DataSet: TzFbDataSet;
  DataSet_Obj: TzDataSet;

  procedure ClearField(const FieldName: string);
  var
    Field: TField;
  begin
    Field := DataSet.FindField(FieldName);

    if assigned(Field) then
    begin
      Field.Clear;
      DataSet.ApplyDefaultExpression(Field);
    end;
  end;

begin
  result := false;

  DataSet := getDataSet(DataSetName);

  if DataSet.IsEmpty then
    exit;

  if not ConfirmYesNo('Si desidera duplcare l''utente ' + DataSet.FieldByName('NOMINATIVO').AsString + '?', mtWarning) then
    exit;

  DataSet_Obj := Base.zDataSets.get(DataSet.IdDataSet, false);

  NoCopyFields := DataSet_Obj.NoCopyFields;

  DuplicazioneParams.Clear;
  DuplicazioneParams.TipoIntervento := TASTipoIntervento.FromString(DataSet.FieldByName('TIPO_INTERVENTO').AsString);

  case DuplicazioneParams.TipoIntervento of
    tiNull:
      DuplicazioneParams.IdIntervento := -1;
    tiAS:
      DuplicazioneParams.IdIntervento := DataSet.FieldByName('ID_INTERVENTO_AS').value;
    tiAES:
      DuplicazioneParams.IdIntervento := DataSet.FieldByName('ID_INTERVENTO_AES').value;
    tiADH:
      DuplicazioneParams.IdIntervento := DataSet.FieldByName('ID_INTERVENTO_ADH').value;
  end;
  DuplicazioneParams.CodiceFiscale := DataSet.FieldByName('CODICE_FISCALE').AsString;

  DataSet.DuplicateRecord(false, NoCopyFields);

  // ID_INTERVENTO_AS

  // Monitoraggio
  ClearField('ID_EDUCATORE_ASSEGNATO_1');
  ClearField('DATA_AVVIO_INTERVENTO_1');
  ClearField('DATA_FINE_INTERVENTO_1');
  ClearField('ID_EDUCATORE_ASSEGNATO_2');
  ClearField('DATA_AVVIO_INTERVENTO_2');
  ClearField('DATA_FINE_INTERVENTO_2');
  ClearField('NOTE_INTERVENTO');
  ClearField('DATA_CONSEGNA_PEI');
  ClearField('PEI');
  ClearField('ESITO_PEI');
  ClearField('NOTE_PEI');
  ClearField('DATA_CONSEGNA_VERIFICA');
  ClearField('VERIFICA');
  ClearField('ESITO_VERIFICA');
  ClearField('NOTE_VERIFICA');
  ClearField('NOTE_DA_ISTITUTO');
  ClearField('NOTE_SIEE');
  ClearField('NOTE_STORICO');
  // Rendicontazione
  ClearField('ORE_ASSEGNATE_ANNO_PRECEDENTE');
  ClearField('ORE_ASSEGNATE_ANNO_CORRENTE');
  ClearField('COSTO_ORARIO');
  ClearField('NOTE_ASSEGNAZIONE_ORE');
  ClearField('NUMERO_SETTIMANE_SET_DIC');
  ClearField('MONTE_ORE_SET_DIC');
  ClearField('COSTO_PREVENTIVO_SET_DIC');
  ClearField('ORE_RENDICONTATE_SET_DIC');
  ClearField('COSTO_CONSUNTIVO_SET_DIC');
  ClearField('NUMERO_SETTIMANE_GEN_AGO');
  ClearField('MONTE_ORE_GEN_AGO');
  ClearField('COSTO_PREVENTIVO_GEN_AGO');
  ClearField('ORE_RENDICONTATE_GEN_AGO');
  ClearField('COSTO_CONSUNTIVO_GEN_AGO');
  ClearField('NUMERO_SETTIMANE_TOTALI');
  ClearField('MONTE_ORE_TOTALI');
  ClearField('COSTO_PREVENTIVO_TOTALI');
  ClearField('ORE_USUFRUITE_TOTALI');
  ClearField('RESIDUO_ORE_DA_RENDICONTARE');
  ClearField('COSTO_CONSUNTIVO_TOTALI');
  ClearField('RESIDUO_COSTO_PREVENTIVO');
  ClearField('SETTEMBRE_ORE_DIRETTE');
  ClearField('SETTEMBRE_ORE_INDIRETTE');
  ClearField('SETTEMBRE_ORE_FORMAZIONE');
  ClearField('SETTEMBRE_ORE_TOTALI');
  ClearField('SETTEMBRE_IMPORTO');
  ClearField('SETTEMBRE_NOTE');
  ClearField('OTTOBRE_ORE_DIRETTE');
  ClearField('OTTOBRE_ORE_INDIRETTE');
  ClearField('OTTOBRE_ORE_FORMAZIONE');
  ClearField('OTTOBRE_ORE_TOTALI');
  ClearField('OTTOBRE_IMPORTO');
  ClearField('OTTOBRE_NOTE');
  ClearField('NOVEMBRE_ORE_DIRETTE');
  ClearField('NOVEMBRE_ORE_INDIRETTE');
  ClearField('NOVEMBRE_ORE_FORMAZIONE');
  ClearField('NOVEMBRE_ORE_TOTALI');
  ClearField('NOVEMBRE_IMPORTO');
  ClearField('NOVEMBRE_NOTE');
  ClearField('DICEMBRE_ORE_DIRETTE');
  ClearField('DICEMBRE_ORE_INDIRETTE');
  ClearField('DICEMBRE_ORE_FORMAZIONE');
  ClearField('DICEMBRE_ORE_TOTALI');
  ClearField('DICEMBRE_IMPORTO');
  ClearField('DICEMBRE_NOTE');
  ClearField('GENNAIO_ORE_DIRETTE');
  ClearField('GENNAIO_ORE_INDIRETTE');
  ClearField('GENNAIO_ORE_FORMAZIONE');
  ClearField('GENNAIO_ORE_TOTALI');
  ClearField('GENNAIO_IMPORTO');
  ClearField('GENNAIO_NOTE');
  ClearField('FEBBRAIO_ORE_DIRETTE');
  ClearField('FEBBRAIO_ORE_INDIRETTE');
  ClearField('FEBBRAIO_ORE_FORMAZIONE');
  ClearField('FEBBRAIO_ORE_TOTALI');
  ClearField('FEBBRAIO_IMPORTO');
  ClearField('FEBBRAIO_NOTE');
  ClearField('MARZO_ORE_DIRETTE');
  ClearField('MARZO_ORE_INDIRETTE');
  ClearField('MARZO_ORE_FORMAZIONE');
  ClearField('MARZO_ORE_TOTALI');
  ClearField('MARZO_IMPORTO');
  ClearField('MARZO_NOTE');
  ClearField('APRILE_ORE_DIRETTE');
  ClearField('APRILE_ORE_INDIRETTE');
  ClearField('APRILE_ORE_FORMAZIONE');
  ClearField('APRILE_ORE_TOTALI');
  ClearField('APRILE_IMPORTO');
  ClearField('APRILE_NOTE');
  ClearField('MAGGIO_ORE_DIRETTE');
  ClearField('MAGGIO_ORE_INDIRETTE');
  ClearField('MAGGIO_ORE_FORMAZIONE');
  ClearField('MAGGIO_ORE_TOTALI');
  ClearField('MAGGIO_IMPORTO');
  ClearField('MAGGIO_NOTE');
  ClearField('GIUGNO_ORE_DIRETTE');
  ClearField('GIUGNO_ORE_INDIRETTE');
  ClearField('GIUGNO_ORE_FORMAZIONE');
  ClearField('GIUGNO_ORE_TOTALI');
  ClearField('GIUGNO_IMPORTO');
  ClearField('GIUGNO_NOTE');
  ClearField('LUGLIO_ORE_DIRETTE');
  ClearField('LUGLIO_ORE_INDIRETTE');
  ClearField('LUGLIO_ORE_FORMAZIONE');
  ClearField('LUGLIO_ORE_TOTALI');
  ClearField('LUGLIO_IMPORTO');
  ClearField('LUGLIO_NOTE');
  ClearField('AGOSTO_ORE_DIRETTE');
  ClearField('AGOSTO_ORE_INDIRETTE');
  ClearField('AGOSTO_ORE_FORMAZIONE');
  ClearField('AGOSTO_ORE_TOTALI');
  ClearField('AGOSTO_IMPORTO');
  ClearField('AGOSTO_NOTE');
  ClearField('TOTALE_ORE_DIRETTE');
  ClearField('TOTALE_ORE_INDIRETTE');
  ClearField('TOTALE_ORE_FORMAZIONE');
  ClearField('TOTALE_ORE');
  ClearField('TOTALE_IMPORTO');

  result := true;
end;

procedure TAssistenzaScolastica.ImpostaCostoOrario;
var
  sp: TSP_AS_INTERVENTI_PARTE_ECONOMICA_SET_COSTO_ORARIO;
  proc: TBeforeShowParamsProc;
begin

  sp := GetSP<TSP_AS_INTERVENTI_PARTE_ECONOMICA_SET_COSTO_ORARIO>;
  try
    sp.TIPO_INTERVENTO := '';
    sp.ANNO_FORMATIVO := '';
    sp.COSTO_ORARIO := 0;

    proc := procedure(zParamDialog: TzParamDialog)
      var
        lk: TcxExtLookupComboBox; //
        combo: TcxImageComboBox;
        spin: TcxSpinEdit;
      begin
        combo := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctPickList, 'TIPO_INTERVENTO', 'Tipo Intervento', '') as TcxImageComboBox;
        dx.InitPickList(combo.ActiveProperties, 'AS_TIPO_INTERVENTO');

        lk := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctLookupExt, 'ANNO_FORMATIVO', 'Anno Formativo', '') as TcxExtLookupComboBox;
        dx.InitLookup('', lk, lkAnniFormativi, lkAnniFormativiSrc, 'ANNO_FORMATIVO', 'ANNO_FORMATIVO');
        lkAnniFormativi.Active := true;

        spin := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctSpin, 'COSTO_ORARIO', 'Costo Orario', 0) as TcxSpinEdit;
        spin.ActiveProperties.ValueType := vtFloat;
        spin.ActiveProperties.DisplayFormat := '€ ###,##0.00';
        spin.ActiveProperties.EditFormat := '###,##0.00';

        //
        zParamDialog.zDialog.Width := 240;
        zParamDialog.zDialog.Height := 170;
      end;

    if not ShowParams('AssistenzaScolastica.ImpostaCostoOrario', sp, 'Costo Orario', false, proc, false, '') then
      exit;

    StartWait;
    try
      sp.ExecuteAndCommit;
    finally
      StopWait;
    end;

    RefreshDataSets;
  finally
    FreeAndNil(sp);
  end;
end;

end.
