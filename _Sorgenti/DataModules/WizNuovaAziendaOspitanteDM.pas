unit WizNuovaAziendaOspitanteDM;

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

  TWizNuovaAziendaOspitante = class(TBaseDataModule)
    AziendeSrc: TDataSource;
    Aziende: TzFbDataSet;
    ContattiSrc: TDataSource;
    Contatti: TzFbDataSet;
    SediOperativeSrc: TDataSource;
    SediOperative: TzFbDataSet;
    ConvenzioniSrc: TDataSource;
    Convenzioni: TzFbDataSet;
    AmbitiSrc: TDataSource;
    Ambiti: TzFbDataSet;
    MansioniSrc: TDataSource;
    Mansioni: TzFbDataSet;
    procedure AziendeAfterPost(DataSet: TDataSet);
    procedure AziendeBeforeOpen(DataSet: TDataSet);
    procedure AziendeBeforePost(DataSet: TDataSet);
    procedure AziendeNewRecord(DataSet: TDataSet);
    procedure ConvenzioniNewRecord(DataSet: TDataSet);
  private
  private
    FIdAzienda: integer;
    function GetIdAzienda: integer;
  public
    function ConfermaAnnulla: boolean;
    function ConfermaChiusura: boolean;
    function GetRiepilogo: string;
  public
    constructor Create(aOwner: TComponent); override;
  public
    procedure InizializzaAzienda(const CodiceFiscale, PartitaIva: string; const Estero: boolean);
    procedure VerificaCodiceFiscale;

    property IdAzienda: integer read GetIdAzienda;
  end;

var
  WizNuovaAziendaOspitante: TWizNuovaAziendaOspitante;

implementation

uses
  System.DateUtils, System.UITypes, Vcl.Dialogs, Gesty_StoredProcs,
  ConfigModule,   SmartInspect.Vcl.SiAuto, SmartInspect.Vcl, dmCommon,
  zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TWizNuovaAziendaOspitante.Create(aOwner: TComponent);
begin
  inherited;
  FIdAzienda := -1;
  SetAutoCommit(false);
end;

function TWizNuovaAziendaOspitante.ConfermaAnnulla: boolean;
begin
  Rollback(false);
  result := True;
end;

function TWizNuovaAziendaOspitante.ConfermaChiusura: boolean;
begin
  result := false;

  Aziende.CheckBrowseMode;

  SediOperative.CheckBrowseMode;
  if SediOperative.IsEmpty then
  begin
    ConfirmOk('Nessuna sede operativa inserita.');
    Exit;
  end;

  result := True;

  if result then
    Commit;
end;

function TWizNuovaAziendaOspitante.GetRiepilogo: string;
var
  StringList: TStringList;
begin
  result := '';

  StringList := TStringList.Create;
  try
    StringList.Add('Id Azienda: ' + Aziende.FieldByName('ID_AZIENDA').asString);
    StringList.Add('Ragione Sociale: ' + Aziende.FieldByName('RAGIONE_SOCIALE').asString);
    StringList.Add('Codice Fiscale: ' + Aziende.FieldByName('CODICE_FISCALE').asString);

    result := StringList.Text;
  finally
    FreeAndNil(StringList);
  end;
end;

/// ////////////////////////////////////////////////////////////////////////////

procedure TWizNuovaAziendaOspitante.AziendeNewRecord(DataSet: TDataSet);
begin
  inherited;
  Aziende.FieldByName('TIPO_RISORSA').asString := 'A';
  Aziende.FieldByName('BENEFICIARIA_DI_SERVIZI').asBoolean := True;
  Aziende.FieldByName('FORNITRICE_DI_SERVIZI').asBoolean := True;
end;

procedure TWizNuovaAziendaOspitante.AziendeBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Aziende.ParamByName('ID_AZIENDA').AsInteger := IdAzienda;
end;

procedure TWizNuovaAziendaOspitante.AziendeAfterPost(DataSet: TDataSet);
begin
  inherited;
  FIdAzienda := Aziende.FieldByName('ID_AZIENDA').AsInteger;
end;

procedure TWizNuovaAziendaOspitante.AziendeBeforePost(DataSet: TDataSet);
begin
  inherited;
  VerificaCodiceFiscale;
end;

function TWizNuovaAziendaOspitante.GetIdAzienda: integer;
begin
  if FIdAzienda = -1 then
    if Aziende.State = dsInsert then
      Aziende.CheckBrowseMode;

  result := FIdAzienda;
end;

procedure TWizNuovaAziendaOspitante.VerificaCodiceFiscale;
var
  sp: TSP_AZIENDA_OSPIT_CHECK_COD_FISC;
begin
  inherited;
  sp := TSP_AZIENDA_OSPIT_CHECK_COD_FISC.Create(WriteTrans);
  try
    sp.id_Azienda := Aziende.FieldByName('ID_AZIENDA').AsInteger;
    sp.Codice_Fiscale := Aziende.FieldByName('CODICE_FISCALE').asString;
    sp.Partita_Iva := Aziende.FieldByName('PARTITA_IVA').asString;
    sp.ExecuteWithoutCommit;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TWizNuovaAziendaOspitante.InizializzaAzienda(const CodiceFiscale, PartitaIva: string; const Estero: boolean);
var
  sp: TSP_AZIENDA_OSPITANTE_GET;
begin
  inherited;

  FIdAzienda := -1;

  if not CodiceFiscale.IsEmpty then
    if not zCodiceFiscale.CodiceFiscaleValido(CodiceFiscale, Estero) then
      if not zCodiceFiscale.PartitaIvaValida(CodiceFiscale, Estero) then
      begin
        ConfirmOk('Codice fiscale non valido: ' + CodiceFiscale);
        Exit;
      end;

  if not PartitaIva.IsEmpty then
    if not zCodiceFiscale.PartitaIvaValida(PartitaIva, Estero) then
    begin
      ConfirmOk('Partita IVA non valida: ' + PartitaIva);
      Exit;
    end;

  /// ///////////

  sp := TSP_AZIENDA_OSPITANTE_GET.Create(WriteTrans);
  try
    sp.Codice_Fiscale := CodiceFiscale;
    sp.Partita_Iva := PartitaIva;
    sp.ExecuteWithoutCommit;
    FIdAzienda := sp.id_Azienda;
  finally
    FreeAndNil(sp);
  end;

  /// ///////////
  if Aziende.Active then
  begin
    if Aziende.State in dsEditModes then
      Aziende.Cancel;
  end
  else
    Aziende.Active := True;

  /// ///////////

  if FIdAzienda = -1 then
  begin

    if ConfirmYesNo('Nessuna azienda trovata per il codice fiscale/p.iva indicati.' + sLineBreak + sLineBreak + 'Si desidera inserire una nuova azienda?') then
    begin
      Aziende.Append;

      if not CodiceFiscale.IsEmpty then
        Aziende.FieldByName('CODICE_FISCALE').asString := CodiceFiscale;

      if not PartitaIva.IsEmpty then
        Aziende.FieldByName('PARTITA_IVA').asString := PartitaIva;
    end;
  end
  else
  begin
    Aziende.ReOpen(True); // apre il dataset sull'azienda selezionata
  end
end;

procedure TWizNuovaAziendaOspitante.ConvenzioniNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('ID_ENTE').Value := Common.EnteDefault;

  DataSet.FieldByName('ID_DELEGATO_FIRMA').Value := Aziende.FieldByName('ID_LEGALE_RAPPRESENTANTE').Value;

  if not DataSet.FieldByName('ID_DELEGATO_FIRMA').IsNull then
    DataSet.FieldByName('DELEGATO_FIRMA_QUALIFICA').Value := 'Titolare';
end;

end.

  zFbDataSet

  AZIENDA_OSPIT_CHECK_COD_FISC
