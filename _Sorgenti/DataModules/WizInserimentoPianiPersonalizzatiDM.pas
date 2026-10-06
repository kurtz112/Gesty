unit WizInserimentoPianiPersonalizzatiDM;

interface

uses
  System.SysUtils,
  System.Classes,
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
  zFbDataSet,
  zDbCardDlg,
  zDbViewDlg;

type
  TWizInserimentoPianiPersonalizzati = class(TBaseDataModule)
    PianoSrc: TDataSource;
    Piano: TzFbDataSet;
    ServiziSrc: TDataSource;
    Servizi: TzFbDataSet;
    StudentiProgettiSrc: TDataSource;
    StudentiProgetti: TzFbDataSet;
    cardStudentiProgetti: TzDbCardDlg;
    lkServizi: TzFbDataSet;
    dlgServizi: TzDbViewDlg;
    procedure PianoAfterPost(DataSet: TDataSet);
    procedure PianoBeforeOpen(DataSet: TDataSet);
  private
    FIdPianoPersonalizzato: integer;
    FidProgetto: integer;
    FDataInizioProgetto: TDate;
  protected
  public
    constructor Create(aOwner: TComponent); override;
    function ConfermaAnnulla: boolean;
    function ConfermaChiusura: boolean;
    function GetRiepilogo: string;
    procedure Init(aProgetto: integer; aDataInizioProgetto: TDateTime);
    function AggiungiStudente: boolean;
    procedure AggiungiServizi;
  public
    property idProgetto: integer read FidProgetto write FidProgetto;
    property IdPianoPersonalizzato: integer read FIdPianoPersonalizzato;
    property DataInizioProgetto: TDate read FDataInizioProgetto;
  end;

var
  WizInserimentoPianiPersonalizzati: TWizInserimentoPianiPersonalizzati;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TFormVariazioneWizard }

constructor TWizInserimentoPianiPersonalizzati.Create(aOwner: TComponent);
begin
  inherited;

  FidProgetto := -1;
  FIdPianoPersonalizzato := -1;
  FDataInizioProgetto := 0;
  SetAutoCommit(false);
end;

function TWizInserimentoPianiPersonalizzati.ConfermaAnnulla: boolean;
begin
  Rollback(false);
  result := True;
end;

function TWizInserimentoPianiPersonalizzati.ConfermaChiusura: boolean;
begin
  Commit;
  result := True;
end;

procedure TWizInserimentoPianiPersonalizzati.Init(aProgetto: integer; aDataInizioProgetto: TDateTime);
begin
  FidProgetto := aProgetto;
  FDataInizioProgetto := aDataInizioProgetto;

  OpenDataSets;

  Piano.Insert;

  if idProgetto <> -1 then
    Piano.FieldByName('ID_PROGETTO').AsInteger := idProgetto;
end;

procedure TWizInserimentoPianiPersonalizzati.PianoAfterPost(DataSet: TDataSet);
begin
  inherited;
  FIdPianoPersonalizzato := Piano.FieldByName('ID_PIANO_PERSONALIZZATO').AsInteger;
end;

procedure TWizInserimentoPianiPersonalizzati.PianoBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Piano.ParamByName('ID_PIANO_PERSONALIZZATO').AsInteger := IdPianoPersonalizzato;
end;

function TWizInserimentoPianiPersonalizzati.GetRiepilogo: string;
var
  StringList: TStringList;
begin
  result := '';

  StringList := TStringList.Create;
  try
    StringList.Add('Id Piano: ' + Piano.FieldByName('ID_PIANO_PERSONALIZZATO').asString);
    StringList.Add('Studente: ' + Piano.FieldByName('NOMINATIVO_STUDENTE').asString);
    StringList.Add('Progetto: ' + Piano.FieldByName('DENOMINAZIONE_PROGETTO').asString);
    StringList.Add('');
    StringList.Add('Servizi: ');

    Servizi.First;
    while not Servizi.Eof do
    begin
      StringList.Add(Servizi.FieldByName('SERVIZIO_EROGATO').asString);
      Servizi.Next;
    end;

    result := StringList.Text;
  finally
    FreeAndNil(StringList);
  end;
end;

function TWizInserimentoPianiPersonalizzati.AggiungiStudente: boolean;
begin
  result := false;

  StudentiProgetti.RevertSql(True);
  try
    StudentiProgetti.Insert;
    StudentiProgetti.FieldByName('ID_PROGETTO').AsInteger := idProgetto;
    StudentiProgetti.FieldByName('DATA_ISCRIZIONE').AsDateTime := DataInizioProgetto;
    StudentiProgetti.FieldByName('DATA_RITIRO').AsDateTime := EncodeDate(9999, 12, 31);

    result := cardStudentiProgetti.Execute;

    if result then
    begin
      StudentiProgetti.CheckBrowseMode;
      Piano.FieldByName('ID_STUDENTE').AsInteger := StudentiProgetti.FieldByName('ID_STUDENTE').AsInteger;
      Piano.FieldByName('IDENTIFICATIVO').asString := StudentiProgetti.FieldByName('IDENTIFICATIVO_DOTE').asString;
    end;

  finally
    StudentiProgetti.Active := false;
  end;
end;

procedure TWizInserimentoPianiPersonalizzati.AggiungiServizi;
begin
  lkServizi.Active := false;
  lkServizi.ParamByName('ID_PIANO_PERSONALIZZATO').AsInteger := Piano.FieldByName('ID_PIANO_PERSONALIZZATO').AsInteger;
  lkServizi.ParamByName('ID_PROGETTO').AsInteger := Piano.FieldByName('ID_PROGETTO').AsInteger;
  lkServizi.Active := True;
  try
    dlgServizi.Execute(
      procedure
      begin
        Servizi.Append;
        Servizi.FieldByName('ID_PIANO_PERSONALIZZATO').AsInteger := Piano.FieldByName('ID_PIANO_PERSONALIZZATO').AsInteger;
        Servizi.FieldByName('ID_PROGETTO').AsInteger := Piano.FieldByName('ID_PROGETTO').AsInteger;
        Servizi.FieldByName('SERVIZIO_EROGATO').asString := lkServizi.FieldByName('SERVIZIO_EROGATO').asString;
        Servizi.FieldByName('DATA_INIZIO').AsDateTime := Piano.FieldByName('DATA_INIZIO').AsDateTime;
        Servizi.FieldByName('DATA_FINE').AsDateTime := Piano.FieldByName('DATA_FINE').AsDateTime;
        Servizi.FieldByName('ORE_PIP').AsFloat := 1;
        Servizi.FieldByName('ORE_NON_SVOLTE').AsFloat := 0;
        Servizi.FieldByName('PARAMETRO_DOTE').AsFloat := 0;
        Servizi.Post;
      end);
  finally
    lkServizi.Active := false;
  end;
end;

end.
