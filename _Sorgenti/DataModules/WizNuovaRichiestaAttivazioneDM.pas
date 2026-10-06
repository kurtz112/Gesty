unit WizNuovaRichiestaAttivazioneDM;

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
  dbMaster,
  Base_DataModule,
  zFbDataSet,
  zCodiceFiscale,
  zDbViewDlg;

type
  TTipoRisorsa = (trPersonale, trAzienda);

  TWizNuovaRichiestaAttivazione = class(TBaseDataModule)
    RichiestaAttivazioneSrc: TDataSource;
    RichiestaAttivazione: TzFbDataSet;
    CompetenzeSrc: TDataSource;
    Competenze: TzFbDataSet;
    SettoriSrc: TDataSource;
    Settori: TzFbDataSet;
    FornitureSrc: TDataSource;
    Forniture: TzFbDataSet;
    lkFornitureDlg: TzDbViewDlg;
    lkForniture: TzFbDataSet;
    lkSettoriDlg: TzDbViewDlg;
    lkSettori: TzFbDataSet;
    lkCompetenzeDlg: TzDbViewDlg;
    lkCompetenze: TzFbDataSet;
    lkTestiEsigenzeDlg: TzDbViewDlg;
    lkTestiEsigenze: TzFbDataSet;
    lkRichiedenti: TzFbDataSet;
    lkRichiedentiSrc: TDataSource;
    AllegatiSrc: TDataSource;
    Allegati: TzFbDataSet;
    procedure SalvaRichiestaAttivazione(DataSet: TDataSet);
    procedure RichiestaAttivazioneAfterInsert(DataSet: TDataSet);
    procedure RichiestaAttivazioneAfterPost(DataSet: TDataSet);
    procedure RichiestaAttivazioneBeforeOpen(DataSet: TDataSet);
  private
  private
    FidRichiestaAttivazione: integer;
    FTipoRisorsa: TTipoRisorsa;
    function GetidRichiestaAttivazione: integer;
    function GetTipoRisorsaStr: string;
  public
    function ConfermaAnnulla: boolean;
    function ConfermaChiusura: boolean;
    function GetRiepilogo: string;
    procedure SetRequiredFields;
    function GetInquadramentoDefault: string;
  public
    constructor Create(aOwner: TComponent); override;

    procedure InitRichiesta(const aCodiceFiscale, aPartitaIVA: string; idRichiedente: integer; Esigenza: TStrings);
    procedure VerificaCodiceFiscale(CodiceFiscale, PartitaIVA: string);

    procedure AggiungiForniture;
    procedure AggiungiSettori;
    procedure AggiungiCompetenze;
    procedure AggiungiTestoEsigenza(Esigenza: TStrings);

    procedure SetTipoAllegatoRequired;
    function VerificaAllegati: boolean;
  public
    property idRichiestaAttivazione: integer read GetidRichiestaAttivazione;
    property TipoRisorsa: TTipoRisorsa read FTipoRisorsa write FTipoRisorsa;
    property TipoRisorsaStr: string read GetTipoRisorsaStr;
  end;

var
  WizNuovaRichiestaAttivazione: TWizNuovaRichiestaAttivazione;

implementation

uses
  System.DateUtils, Vcl.Dialogs, Gesty_StoredProcs, ConfigModule,
  SmartInspect.VCL.SiAuto, SmartInspect.VCL, zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TWizNuovaRichiestaAttivazione.Create(aOwner: TComponent);
begin
  inherited;
  FidRichiestaAttivazione := -1;
  FTipoRisorsa := trPersonale;
  //
  SetAutoCommit(false);
end;

function TWizNuovaRichiestaAttivazione.ConfermaAnnulla: boolean;
begin
  Rollback(false);
  result := True;
end;

function TWizNuovaRichiestaAttivazione.ConfermaChiusura: boolean;
begin
  result := VerificaAllegati;

  if result then
    Commit;
end;

function TWizNuovaRichiestaAttivazione.GetRiepilogo: string;
var
  StringList: TStringList;
begin
  result := '';

  StringList := TStringList.Create;
  try
    StringList.Add('Id RichiestaAttivazione: ' + RichiestaAttivazione.FieldByName('ID_RICHIESTA_ATTIVAZIONE').asString);
    StringList.Add('Nominativo: ' + RichiestaAttivazione.FieldByName('NOMINATIVO').asString);
    StringList.Add('Codice Fiscale: ' + RichiestaAttivazione.FieldByName('CODICE_FISCALE').asString);

    result := StringList.Text;
  finally
    FreeAndNil(StringList);
  end;
end;

procedure TWizNuovaRichiestaAttivazione.RichiestaAttivazioneAfterInsert(DataSet: TDataSet);
begin
  inherited;
  // setta modified
  RichiestaAttivazione.FieldByName('DIPENDENTE_PUBBLICO').AsBoolean := false;
end;

procedure TWizNuovaRichiestaAttivazione.RichiestaAttivazioneAfterPost(DataSet: TDataSet);
begin
  inherited;
  FidRichiestaAttivazione := RichiestaAttivazione.FieldByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger;
end;

procedure TWizNuovaRichiestaAttivazione.RichiestaAttivazioneBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  RichiestaAttivazione.ParamByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger := idRichiestaAttivazione;
end;

procedure TWizNuovaRichiestaAttivazione.AggiungiCompetenze;
begin
  lkCompetenze.RevertSQL(false);
  lkCompetenze.ParamByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger := idRichiestaAttivazione;
  lkCompetenze.Active := True;
  try
    lkCompetenzeDlg.Execute(
      procedure
      begin
        Competenze.Append;
        Competenze.FieldByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger := idRichiestaAttivazione;
        Competenze.FieldByName('COMPETENZA').asString := lkCompetenze.FieldByName('COMPETENZA').asString;
        Competenze.Post;
      end);
  finally
    lkCompetenze.Active := false;
  end;
end;

procedure TWizNuovaRichiestaAttivazione.AggiungiForniture;
begin

  lkForniture.RevertSQL(false);
  lkForniture.ParamByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger := idRichiestaAttivazione;
  lkForniture.Active := True;
  try

    lkFornitureDlg.Execute(
      procedure
      begin
        Forniture.Append;
        Forniture.FieldByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger := idRichiestaAttivazione;
        Forniture.FieldByName('TIPO_FORNITURA').asString := lkForniture.FieldByName('TIPO_FORNITURA').asString;
        // Forniture.FieldByName('DATA_INIZIO_VALIDITA').AsDateTime := Date;
        // Forniture.FieldByName('DATA_FINE_VALIDITA').AsDateTime := EncodeDate(9999, 12, 31);
        Forniture.Post;
      end);
  finally
    lkForniture.Active := false;
  end;
end;

procedure TWizNuovaRichiestaAttivazione.AggiungiSettori;
begin
  lkSettori.RevertSQL(false);
  lkSettori.ParamByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger := idRichiestaAttivazione;
  lkSettori.Active := True;
  try
    lkSettoriDlg.Execute(
      procedure
      begin
        Settori.Append;
        Settori.FieldByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger := idRichiestaAttivazione;
        Settori.FieldByName('SETTORE').asString := lkSettori.FieldByName('SETTORE').asString;
        Settori.Post;
      end);
  finally
    lkSettori.Active := false;
  end;
end;

procedure TWizNuovaRichiestaAttivazione.AggiungiTestoEsigenza(Esigenza: TStrings);
begin
  lkTestiEsigenze.RevertSQL(false);
  lkTestiEsigenze.Active := True;
  try
    lkTestiEsigenzeDlg.Execute(
      procedure
      begin
        Esigenza.Add(lkTestiEsigenze.FieldByName('ESIGENZA').asString);
      end);
  finally
    lkTestiEsigenze.Active := false;
  end;
end;

function TWizNuovaRichiestaAttivazione.GetInquadramentoDefault: string;
var
  sp: TSP_GET_INQUADRAMENTO_DEFAULT;
begin
  result := '';

  sp := TSP_GET_INQUADRAMENTO_DEFAULT.Create(WriteTrans);
  try
    sp.Tipo_Risorsa := TipoRisorsaStr;
    sp.ExecuteWithoutCommit;
    result := sp.Tipo_Inquadramento;
  finally
    FreeAndNil(sp);
  end;
end;

function TWizNuovaRichiestaAttivazione.GetTipoRisorsaStr: string;
begin
  case TipoRisorsa of
    trPersonale:
      result := 'P';
    trAzienda:
      result := 'A';
  end;
end;

/// ////////////////////////////////////////////////////////////////////////////

procedure TWizNuovaRichiestaAttivazione.VerificaCodiceFiscale(CodiceFiscale, PartitaIVA: string);
var
  sp: TSP_richieste_Attiv_Check_Cod_Fisc;
  ok: boolean;
begin
  sp := TSP_richieste_Attiv_Check_Cod_Fisc.Create(WriteTrans);
  try
    sp.Tipo_Risorsa := TipoRisorsaStr;
    sp.Codice_Fiscale := CodiceFiscale;
    sp.Partita_Iva := PartitaIVA;
    sp.ExecuteWithoutCommit;

    ok := sp.Valido;

    if not ok then
      ConfirmOk(sp.Msg_Errore)
    else
      ConfirmOk('Codice fiscale valido.');
  finally
    FreeAndNil(sp);
  end;
end;

procedure TWizNuovaRichiestaAttivazione.SetRequiredFields;
var
  sp: TSP_richieste_Attiv_Campi_Not_Null;
  Fields: TStringList;
  FieldName: string;
  Field: TField;
begin
  Fields := TStringList.Create;
  try
    Fields.Delimiter := ';';

    sp := TSP_richieste_Attiv_Campi_Not_Null.Create(WriteTrans);
    try
      sp.Tipo_Risorsa := TipoRisorsaStr;
      sp.ExecuteWithoutCommit;
      Fields.DelimitedText := sp.Campi;
    finally
      FreeAndNil(sp);
    end;

    RichiestaAttivazione.Active := True;
    for Field in RichiestaAttivazione.Fields do
      Field.Required := Fields.IndexOf(Field.FieldName) <> -1;
  finally
    FreeAndNil(Fields);
  end;
end;

procedure TWizNuovaRichiestaAttivazione.InitRichiesta(const aCodiceFiscale, aPartitaIVA: string; idRichiedente: integer; Esigenza: TStrings);
  function Coalesce(s1, s2: string): string;
  begin
    if s1.IsEmpty then
      result := s2
    else
      result := s1;
  end;

var
  Belfiore: string;
  ok: boolean;
  sp: TSP_richieste_Attiv_Check_Cod_Fisc;
  CodiceFiscale, PartitaIVA: string;
  spBelfiore: TSP_zz_Comuni_Get;
begin
  CodiceFiscale := Coalesce(aCodiceFiscale, aPartitaIVA);

  if TipoRisorsa = trAzienda then
    PartitaIVA := Coalesce(aPartitaIVA, CodiceFiscale)
  else
    PartitaIVA := Coalesce(aPartitaIVA, '');

  if idRichiedente = -1 then
    raise Exception.Create('Richiedente non specificato.');

  if Esigenza.Text.IsEmpty then
    raise Exception.Create('Esigenza non specificata.');
  /// //////////////////////////////////////////////////////////////////////

  sp := TSP_richieste_Attiv_Check_Cod_Fisc.Create(WriteTrans);
  try
    sp.Tipo_Risorsa := TipoRisorsaStr;
    sp.Codice_Fiscale := CodiceFiscale;
    sp.Partita_Iva := PartitaIVA;;
    sp.ExecuteWithoutCommit;

    ok := sp.Valido;

    if not ok then
      raise Exception.Create(sp.Msg_Errore);

    if sp.Id_Richiesta_Attivazione.isNull then
      FidRichiestaAttivazione := -1
    else
      FidRichiestaAttivazione := sp.Id_Richiesta_Attivazione;
  finally
    FreeAndNil(sp);
  end;

  /// //////////////////////////////////////////////////////////////////////
  ///

  SetRequiredFields;

  // il parametro determina se andrà in edit o append
  if idRichiestaAttivazione = -1 then
  begin
    RichiestaAttivazione.Append;
    RichiestaAttivazione.FieldByName('TIPO_RISORSA').asString := TipoRisorsaStr;
    RichiestaAttivazione.FieldByName('CODICE_FISCALE').asString := CodiceFiscale;

    if TipoRisorsa = trAzienda then
      if CodiceFiscale.IsEmpty then
        RichiestaAttivazione.FieldByName('CODICE_FISCALE').asString := PartitaIVA;

    if PartitaIVA.IsEmpty then
      RichiestaAttivazione.FieldByName('PARTITA_IVA').Clear
    else
      RichiestaAttivazione.FieldByName('PARTITA_IVA').asString := PartitaIVA;

    RichiestaAttivazione.FieldByName('TIPO_INQUADRAMENTO').asString := GetInquadramentoDefault;

    if TipoRisorsa = trPersonale then
      if CodiceFiscaleValido(CodiceFiscale) then
      begin
        RichiestaAttivazione.FieldByName('SESSO').asString := EstraiSessoDaCodiceFiscale(CodiceFiscale);
        RichiestaAttivazione.FieldByName('DATA_NASCITA').AsDateTime := EstraiDataNascitaDaCodiceFiscale(CodiceFiscale);

        Belfiore := EstraiBelfioreNascitaDaCodiceFiscale(CodiceFiscale);

        spBelfiore := TSP_zz_Comuni_Get.Create(WriteTrans);
        try
          spBelfiore.Belfiore := Belfiore;
          spBelfiore.ExecuteWithoutCommit;
          RichiestaAttivazione.FieldByName('LUOGO_NASCITA').asString := spBelfiore.Comune;
          RichiestaAttivazione.FieldByName('SIGLA_STATO_NASCITA').asString := spBelfiore.Sigla_Stato;
          RichiestaAttivazione.FieldByName('CITTADINANZA').asString := spBelfiore.Nazionalita;
        finally
          FreeAndNil(spBelfiore);
        end;
      end;
  end
  else
  begin
    RichiestaAttivazione.ReOpen; // parametro
    RichiestaAttivazione.Edit;
    RichiestaAttivazione.FieldByName('STATO_RICHIESTA').asString := 'I'; // in caso di reinserimento
  end;

  RichiestaAttivazione.FieldByName('ID_RICHIEDENTE').AsInteger := idRichiedente;
  RichiestaAttivazione.FieldByName('ESIGENZA').asString := Esigenza.Text;
  RichiestaAttivazione.FieldByName('DATA_RICHIESTA').AsDateTime := Date;
end;

function TWizNuovaRichiestaAttivazione.GetidRichiestaAttivazione: integer;
begin
  if FidRichiestaAttivazione = -1 then
    if RichiestaAttivazione.State = dsInsert then
      RichiestaAttivazione.CheckBrowseMode;

  result := FidRichiestaAttivazione;
end;

procedure TWizNuovaRichiestaAttivazione.SalvaRichiestaAttivazione(DataSet: TDataSet);
begin
  inherited;
  // RichiestaAttivazione.CheckBrowseMode;
end;

function TWizNuovaRichiestaAttivazione.VerificaAllegati: boolean;
var
  sp: TSP_richieste_Attiv_Verifica_Alleg;
  s: string;
begin
  result := True;

  sp := TSP_richieste_Attiv_Verifica_Alleg.Create(WriteTrans);
  try
    sp.Id_Richiesta_Attivazione := idRichiestaAttivazione;
    sp.Raise_Error := false;
    sp.ExecuteWithoutCommit;
    s := sp.Allegati_Mancanti.Text;
  finally
    FreeAndNil(sp);
  end;

  result := s.IsEmpty;

  if not result then
    ConfirmOk('Mancano i seguenti allegati: ' + #13 + s);
end;

procedure TWizNuovaRichiestaAttivazione.SetTipoAllegatoRequired;
var
  Field: TField;
begin
  inherited;
  // è facoltativo negli altri casi, necessario invece per le richieste di attivazione
  Field := Allegati.FindField('TIPO_ALLEGATO');
  if Assigned(Field) then
    Field.Required := True;
end;

end.

  zFbDataSet
