unit dmAziende;

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
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TAziende = class(TBaseDataModule)
    lkEnti: TzFbDataSet;
    lkEntiSrc: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    FBloccaFiltri: boolean;
    FFiltroEnte: integer;
    FFiltroSettori: string;
    FFiltroPartitaIvaCodiceFiscale: string;
    FFiltroRagioneSociale: string;
    FFiltroCAP: string;
    FFiltroDisponibilita: string;
    procedure SetFiltroCAP(const Value: string);
    procedure SetFiltroEnte(const Value: integer);
    procedure SetFiltroPartitaIvaCodiceFiscale(const Value: string);
    procedure SetFiltroRagioneSociale(const Value: string);
    procedure SetFiltroSettori(const Value: string);
    procedure SetFiltroDisponibilita(const Value: string);
  private
    procedure ApplicaFiltri;
    procedure ApplicaFiltriDetails;
    procedure SetBloccaFiltri(const Value: boolean);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
    procedure AziendaBeforeOpen(DataSet: TDataSet);
    procedure DataSetBeforeOpen(DataSet: TDataSet);
  public
    property BloccaFiltri: boolean read FBloccaFiltri write SetBloccaFiltri;
    property FiltroSettori: string read FFiltroSettori write SetFiltroSettori;
    property FiltroDisponibilita: string read FFiltroDisponibilita write SetFiltroDisponibilita;
    property FiltroCAP: string read FFiltroCAP write SetFiltroCAP;
    property FiltroRagioneSociale: string read FFiltroRagioneSociale write SetFiltroRagioneSociale;
    property FiltroPartitaIvaCodiceFiscale: string read FFiltroPartitaIvaCodiceFiscale write SetFiltroPartitaIvaCodiceFiscale;
    property FiltroEnte: integer read FFiltroEnte write SetFiltroEnte;
  public
    procedure FillSettori(Settori: TStrings);
    procedure FillDisponibilita(Disponibilita: TStrings);
  end;

var
  Aziende: TAziende;

implementation

uses
  zBaseLib,
  zz.Vcl;

var
  siTest: TSiSession;

{$R *.dfm}

  { TAziende }
procedure TAziende.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FBloccaFiltri := false;
  FFiltroSettori := '';
  FFiltroDisponibilita := '';
  FFiltroCAP := '';
  FFiltroRagioneSociale := '';
  FFiltroPartitaIvaCodiceFiscale := '';
  FFiltroEnte := -1;
end;

procedure TAziende.SetFiltroCAP(const Value: string);
begin
  // Riapertura solo se il valore cambia davvero. I cinque editor di filtro
  // della form scattano anche al caricamento, con lo stesso valore vuoto
  // del costruttore: senza questo controllo Aziende veniva riaperto quattro
  // volte a ogni apertura della form (misurato: 600 ms in VPN).
  if FFiltroCAP = Value then
    Exit;

  FFiltroCAP := Value;
  ApplicaFiltri;
end;

procedure TAziende.SetFiltroEnte(const Value: integer);
begin
  if FFiltroEnte = Value then
    Exit;

  FFiltroEnte := Value;
  ApplicaFiltriDetails;
end;

procedure TAziende.SetFiltroPartitaIvaCodiceFiscale(const Value: string);
begin
  if FFiltroPartitaIvaCodiceFiscale = Value then
    Exit;

  FFiltroPartitaIvaCodiceFiscale := Value;
  ApplicaFiltri;
end;

procedure TAziende.SetFiltroRagioneSociale(const Value: string);
begin
  if FFiltroRagioneSociale = Value then
    Exit;

  FFiltroRagioneSociale := Value;
  ApplicaFiltri;
end;

procedure TAziende.SetFiltroSettori(const Value: string);
begin
  if FFiltroSettori = Value then
    Exit;

  FFiltroSettori := Value;
  ApplicaFiltri;
end;

procedure TAziende.ApplicaFiltri;
var
  Azienda: TzFbDataSet;
begin
  Azienda := GetDataSet('Aziende');

  StartWait('Attendere...', true);
  try
    Azienda.ReOpen();
  finally
    StopWait;
  end;
end;

procedure TAziende.ApplicaFiltriDetails;
begin
  StartWait('Attendere...', true);
  try
    ForEach<TzFbDataSet>(
      procedure(DataSet: TzFbDataSet)
      begin

        if DataSet.ParamExists('ID_ENTE') then
        begin
          siTest.logString('BeforeOpen', DataSet.Name);
          DataSet.disableControls;
          DataSet.ReOpen;
          DataSet.enablecontrols;

          siTest.logString('AfterOpen', DataSet.Name);
        end;
      end);
  finally
    StopWait;
  end;
end;

procedure TAziende.FillDisponibilita(Disponibilita: TStrings);
var
  DataSet: TzFbDataSet;
begin
  Disponibilita.Clear;

  DataSet := GetDataSet('lkDisponibilita');
  DataSet.Active := true;
  try
    while not DataSet.Eof do
    begin
      Disponibilita.Add(DataSet.FieldByName('DESC_TIPO_COLLABORAZIONE').asString);
      DataSet.Next;
    end;
  finally
    DataSet.Active := false;
  end;
end;

procedure TAziende.FillSettori(Settori: TStrings);
var
  DataSet: TzFbDataSet;
begin
  Settori.Clear;

  DataSet := GetDataSet('lkSettori');
  DataSet.Active := true;
  try
    while not DataSet.Eof do
    begin
      Settori.Add(DataSet.FieldByName('SETTORE').asString);
      DataSet.Next;
    end;
  finally
    DataSet.Active := false;
  end;
end;

procedure TAziende.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
var
  Field: TField;
begin
  inherited;
  if SameText(DataSetName, 'Aziende') then
    DataSet.BeforeOpen := AziendaBeforeOpen
  else
  begin
    DataSet.BeforeOpen := DataSetBeforeOpen;
    DataSet.UseSqlLocate := false;
  end;
end;

procedure TAziende.AziendaBeforeOpen(DataSet: TDataSet);

  procedure SetFiltro(zFbDataSet: TzFbDataSet; ParamName: string; ParamValue: string);
  var
    size: integer;
  begin
    if zFbDataSet.ParamExists(ParamName) then
      if not ParamValue.IsEmpty then
      begin
        size := zFbDataSet.ParamByName(ParamName).size;

        if size > 0 then
          zFbDataSet.ParamByName(ParamName).asString := ParamValue.Substring(0, zFbDataSet.ParamByName(ParamName).size)
        else
          zFbDataSet.ParamByName(ParamName).asString := ParamValue;
      end
      else
        zFbDataSet.ParamByName(ParamName).Clear;
  end;

var
  Azienda: TzFbDataSet;
begin

  if BloccaFiltri then
    exit;

  Azienda := TzFbDataSet(DataSet);
  SetFiltro(Azienda, 'SETTORI', FiltroSettori);
  SetFiltro(Azienda, 'DISPONIBILITA', FiltroDisponibilita);
  SetFiltro(Azienda, 'CAP', FiltroCAP);
  SetFiltro(Azienda, 'RAGIONE_SOCIALE', FiltroRagioneSociale);
  SetFiltro(Azienda, 'PIVA_COD_FISC', FiltroPartitaIvaCodiceFiscale);
end;

procedure TAziende.DataSetBeforeOpen(DataSet: TDataSet);
var
  zFbDataSet: TzFbDataSet;
begin
  zFbDataSet := TzFbDataSet(DataSet);

  if zFbDataSet.ParamExists('ID_ENTE') then
    if FiltroEnte <> -1 then
      zFbDataSet.ParamByName('ID_ENTE').Value := FiltroEnte
    else
      zFbDataSet.ParamByName('ID_ENTE').Clear;
end;

procedure TAziende.SetBloccaFiltri(const Value: boolean);
begin
  FBloccaFiltri := Value;
end;

procedure TAziende.SetFiltroDisponibilita(const Value: string);
begin
  if FFiltroDisponibilita = Value then
    Exit;

  FFiltroDisponibilita := Value;
  ApplicaFiltri;
end;

initialization

siTest := Si.AddSession('TEST', true);

finalization

siTest := nil;

end.

// Filtri:
// •	Settore (singolo o multiplo)
// •	CAP/Mappa
// •	Ragione Sociale/Nominativo (testo “contenuto”)
// •	P.IVA/C.F
