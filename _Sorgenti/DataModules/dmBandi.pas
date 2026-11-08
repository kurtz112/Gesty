unit dmBandi;

interface

uses
  System.SysUtils, System.Classes, Base_DataModule, dbMaster;

type
  // Progettazione bandi (specifica _Specifiche\Progettazione bandi.md). Regole, stati e
  // permessi stanno nel database: qui si raccolgono solo i dati dei comandi.
  TBandi = class(TBaseDataModule)
  private
    // Le procedure del modulo si chiamano con una query diretta, senza i wrapper TSP_*,
    // e con una transazione propria: il Commit del modulo salverebbe anche le modifiche
    // ancora aperte nella schermata
    procedure EseguiParere(const IdBando: Int64; const Livello, Esito, Motivazione: string);
    procedure EseguiRiapertura(const IdBando: Int64; const Motivo: string);
    procedure EsprimiParere(const Esito, Titolo, Domanda: string);
  public
    procedure ParereFavorevole;
    procedure ParereContrario;
    procedure RiapriValutazione;
  end;

var
  Bandi: TBandi;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  Data.DB,
  Vcl.Dialogs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.DApt,
  FireDAC.Comp.Client,
  ConfigModule,
  zFbDataSet,
  zMsg;

{$R *.dfm}

const
  DATASET_DA_VALUTARE = 'Da_Valutare';
  DATASET_BANDI = 'Bandi';

procedure EseguiInTransazione(Query: TFDQuery);
var
  Transazione: TFDTransaction;
begin
  Transazione := TFDTransaction.Create(nil);
  try
    Transazione.Connection := Config.Database;
    Query.Connection := Config.Database;
    Query.Transaction := Transazione;
    Transazione.StartTransaction;
    try
      Query.ExecSQL;
      Transazione.Commit;
    except
      if Transazione.Active then
        Transazione.Rollback;
      raise;
    end;
  finally
    Query.Transaction := nil;
    FreeAndNil(Transazione);
  end;
end;

procedure TBandi.EseguiParere(const IdBando: Int64; const Livello, Esito, Motivazione: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.SQL.Text := 'EXECUTE PROCEDURE BANDO_PARERE(:ID_BANDO, :LIVELLO_VALUTAZIONE, :ESITO, :MOTIVAZIONE)';
    Query.ParamByName('ID_BANDO').DataType := ftLargeint;
    Query.ParamByName('ID_BANDO').AsLargeInt := IdBando;
    Query.ParamByName('LIVELLO_VALUTAZIONE').DataType := ftString;
    Query.ParamByName('LIVELLO_VALUTAZIONE').AsString := Livello;
    Query.ParamByName('ESITO').DataType := ftString;
    Query.ParamByName('ESITO').AsString := Esito;
    Query.ParamByName('MOTIVAZIONE').DataType := ftString;
    Query.ParamByName('MOTIVAZIONE').AsString := Motivazione;
    EseguiInTransazione(Query);
  finally
    FreeAndNil(Query);
  end;
end;

procedure TBandi.EseguiRiapertura(const IdBando: Int64; const Motivo: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.SQL.Text := 'EXECUTE PROCEDURE BANDO_RIAPRI_VALUTAZIONE(:ID_BANDO, :MOTIVO)';
    Query.ParamByName('ID_BANDO').DataType := ftLargeint;
    Query.ParamByName('ID_BANDO').AsLargeInt := IdBando;
    Query.ParamByName('MOTIVO').DataType := ftString;
    Query.ParamByName('MOTIVO').AsString := Motivo;
    EseguiInTransazione(Query);
  finally
    FreeAndNil(Query);
  end;
end;

procedure TBandi.EsprimiParere(const Esito, Titolo, Domanda: string);
var
  DataSet: TzFbDataSet;
  Motivazione: TStringList;
begin
  DataSet := GetDataSet(DATASET_DA_VALUTARE);
  if DataSet.IsEmpty then
  begin
    ConfirmOk('Nessun bando da valutare selezionato.');
    Exit;
  end;

  Motivazione := TStringList.Create;
  try
    if not InputMemo(Titolo, Format('%s (%s)', [Domanda, DataSet.FieldByName('DESC_LIVELLO_VALUTAZIONE').AsString]), Motivazione) then
      Exit;

    // L'obbligo lo controlla anche BANDO_PARERE; qui si anticipa per dare un avviso
    // invece della finestra d'errore con la richiesta di assistenza
    if SameText(Esito, 'NEG') and (Trim(Motivazione.Text) = '') then
    begin
      ConfirmOk('La motivazione ' + #232 + ' obbligatoria per un parere contrario.', mtWarning);
      Exit;
    end;

    EseguiParere(DataSet.FieldByName('ID_BANDO').AsLargeInt, DataSet.FieldByName('LIVELLO_VALUTAZIONE').AsString, Esito, Trim(Motivazione.Text));
  finally
    FreeAndNil(Motivazione);
  end;

  RefreshDataSets;
end;

procedure TBandi.ParereFavorevole;
begin
  EsprimiParere('POS', 'Parere favorevole', 'Eventuale motivazione del parere favorevole');
end;

procedure TBandi.ParereContrario;
begin
  EsprimiParere('NEG', 'Parere contrario', 'Motivazione del parere contrario');
end;

procedure TBandi.RiapriValutazione;
var
  DataSet: TzFbDataSet;
  Motivo: TStringList;
begin
  DataSet := GetDataSet(DATASET_BANDI);
  if DataSet.IsEmpty then
  begin
    ConfirmOk('Nessun bando selezionato.');
    Exit;
  end;

  Motivo := TStringList.Create;
  try
    if not InputMemo('Riapri valutazione', 'Motivo della riapertura: i pareri gi' + #224 + ' espressi restano nello storico ma non contano pi' + #249, Motivo) then
      Exit;

    if Trim(Motivo.Text) = '' then
    begin
      ConfirmOk('Il motivo della riapertura ' + #232 + ' obbligatorio.', mtWarning);
      Exit;
    end;

    EseguiRiapertura(DataSet.FieldByName('ID_BANDO').AsLargeInt, Trim(Motivo.Text));
  finally
    FreeAndNil(Motivo);
  end;

  RefreshDataSets;
end;

end.
