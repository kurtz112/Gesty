unit dmCalendarioAvvioCorsi;

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  dbMaster,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  zFbDataSet;

type
  TCalendarioAvvioCorsi = class(TBaseDataModule)
    GiorniSrc: TDataSource;
    Giorni: TzFbDataSet;
    lkProgettiSrc: TDataSource;
    lkProgetti: TzFbDataSet;
    DateChiusuraSrc: TDataSource;
    DateChiusura: TzFbDataSet;
    ElencoPerReport: TzFbDataSet;
    procedure DateChiusuraBeforeOpen(DataSet: TDataSet);
  private
    FIdProgetto: integer;
    FCodiceCorso: string;
    FCodiceSezione: string;
    FIdSezione: string;
    FTipoAnnualita: string;
    FTitoloCorso: string;
    FAlGiorno: TDateTime;
    FDalGiorno: TDateTime;
    FDomenica: boolean;
    FGiovedi: boolean;
    FLunedi: boolean;
    FMartedi: boolean;
    FMercoledi: boolean;
    FModalitaOperativa: string;
    FOraFine1_Domenica: TDateTime;
    FOraFine1_Giovedi: TDateTime;
    FOraFine1_Lunedi: TDateTime;
    FOraFine1_Martedi: TDateTime;
    FOraFine1_Mercoledi: TDateTime;
    FOraFine1_Sabato: TDateTime;
    FOraFine1_Venerdi: TDateTime;
    FOraFine2_Domenica: TDateTime;
    FOraFine2_Giovedi: TDateTime;
    FOraFine2_Lunedi: TDateTime;
    FOraFine2_Martedi: TDateTime;
    FOraFine2_Mercoledi: TDateTime;
    FOraFine2_Sabato: TDateTime;
    FOraFine2_Venerdi: TDateTime;
    FOraInizio1_Domenica: TDateTime;
    FOraInizio1_Giovedi: TDateTime;
    FOraInizio1_Lunedi: TDateTime;
    FOraInizio1_Martedi: TDateTime;
    FOraInizio1_Mercoledi: TDateTime;
    FOraInizio1_Sabato: TDateTime;
    FOraInizio1_Venerdi: TDateTime;
    FOraInizio2_Domenica: TDateTime;
    FOraInizio2_Giovedi: TDateTime;
    FOraInizio2_Lunedi: TDateTime;
    FOraInizio2_Martedi: TDateTime;
    FOraInizio2_Mercoledi: TDateTime;
    FOraInizio2_Sabato: TDateTime;
    FOraInizio2_Venerdi: TDateTime;
    FSabato: boolean;
    FTotaleOreDomenica: double;
    FTotaleOreGiovedi: double;
    FTotaleOreLunedi: double;
    FTotaleOreMartedi: double;
    FTotaleOreMercoledi: double;
    FTotaleOreSabato: double;
    FTotaleOreVenerdi: double;
    FVenerdi: boolean;
  private
    function ModelloFileName: string;
    procedure SetIdProgetto(const Value: integer);
  public
    constructor Create(aOwner: TComponent); override;

    procedure SvuotaTemp;
    procedure CalcolaTotali;
    procedure Verifica;
    procedure Genera;
  public
    property IdProgetto: integer read FIdProgetto write SetIdProgetto;

    property TitoloCorso: string read FTitoloCorso write FTitoloCorso;
    property CodiceCorso: string read FCodiceCorso write FCodiceCorso;
    property TipoAnnualita: string read FTipoAnnualita write FTipoAnnualita;
    property IdSezione: string read FIdSezione write FIdSezione;
    property CodiceSezione: string read FCodiceSezione write FCodiceSezione;

    property DalGiorno: TDateTime read FDalGiorno write FDalGiorno;
    property AlGiorno: TDateTime read FAlGiorno write FAlGiorno;
    property ModalitaOperativa: string read FModalitaOperativa write FModalitaOperativa;

    property Lunedi: boolean read FLunedi write FLunedi;
    property OraInizio1_Lunedi: TDateTime read FOraInizio1_Lunedi write FOraInizio1_Lunedi;
    property OraFine1_Lunedi: TDateTime read FOraFine1_Lunedi write FOraFine1_Lunedi;
    property OraInizio2_Lunedi: TDateTime read FOraInizio2_Lunedi write FOraInizio2_Lunedi;
    property OraFine2_Lunedi: TDateTime read FOraFine2_Lunedi write FOraFine2_Lunedi;

    property Martedi: boolean read FMartedi write FMartedi;
    property OraInizio1_Martedi: TDateTime read FOraInizio1_Martedi write FOraInizio1_Martedi;
    property OraFine1_Martedi: TDateTime read FOraFine1_Martedi write FOraFine1_Martedi;
    property OraInizio2_Martedi: TDateTime read FOraInizio2_Martedi write FOraInizio2_Martedi;
    property OraFine2_Martedi: TDateTime read FOraFine2_Martedi write FOraFine2_Martedi;

    property Mercoledi: boolean read FMercoledi write FMercoledi;
    property OraInizio1_Mercoledi: TDateTime read FOraInizio1_Mercoledi write FOraInizio1_Mercoledi;
    property OraFine1_Mercoledi: TDateTime read FOraFine1_Mercoledi write FOraFine1_Mercoledi;
    property OraInizio2_Mercoledi: TDateTime read FOraInizio2_Mercoledi write FOraInizio2_Mercoledi;
    property OraFine2_Mercoledi: TDateTime read FOraFine2_Mercoledi write FOraFine2_Mercoledi;

    property Giovedi: boolean read FGiovedi write FGiovedi;
    property OraInizio1_Giovedi: TDateTime read FOraInizio1_Giovedi write FOraInizio1_Giovedi;
    property OraFine1_Giovedi: TDateTime read FOraFine1_Giovedi write FOraFine1_Giovedi;
    property OraInizio2_Giovedi: TDateTime read FOraInizio2_Giovedi write FOraInizio2_Giovedi;
    property OraFine2_Giovedi: TDateTime read FOraFine2_Giovedi write FOraFine2_Giovedi;

    property Venerdi: boolean read FVenerdi write FVenerdi;
    property OraInizio1_Venerdi: TDateTime read FOraInizio1_Venerdi write FOraInizio1_Venerdi;
    property OraFine1_Venerdi: TDateTime read FOraFine1_Venerdi write FOraFine1_Venerdi;
    property OraInizio2_Venerdi: TDateTime read FOraInizio2_Venerdi write FOraInizio2_Venerdi;
    property OraFine2_Venerdi: TDateTime read FOraFine2_Venerdi write FOraFine2_Venerdi;

    property Sabato: boolean read FSabato write FSabato;
    property OraInizio1_Sabato: TDateTime read FOraInizio1_Sabato write FOraInizio1_Sabato;
    property OraFine1_Sabato: TDateTime read FOraFine1_Sabato write FOraFine1_Sabato;
    property OraInizio2_Sabato: TDateTime read FOraInizio2_Sabato write FOraInizio2_Sabato;
    property OraFine2_Sabato: TDateTime read FOraFine2_Sabato write FOraFine2_Sabato;

    property Domenica: boolean read FDomenica write FDomenica;
    property OraInizio1_Domenica: TDateTime read FOraInizio1_Domenica write FOraInizio1_Domenica;
    property OraFine1_Domenica: TDateTime read FOraFine1_Domenica write FOraFine1_Domenica;
    property OraInizio2_Domenica: TDateTime read FOraInizio2_Domenica write FOraInizio2_Domenica;
    property OraFine2_Domenica: TDateTime read FOraFine2_Domenica write FOraFine2_Domenica;
  public
    property TotaleOreLunedi: double read FTotaleOreLunedi;
    property TotaleOreMartedi: double read FTotaleOreMartedi;
    property TotaleOreMercoledi: double read FTotaleOreMercoledi;
    property TotaleOreGiovedi: double read FTotaleOreGiovedi;
    property TotaleOreVenerdi: double read FTotaleOreVenerdi;
    property TotaleOreSabato: double read FTotaleOreSabato;
    property TotaleOreDomenica: double read FTotaleOreDomenica;
  end;

var
  CalendarioAvvioCorsi: TCalendarioAvvioCorsi;

implementation

uses
  System.DateUtils,
  System.Variants,
  dxSpreadSheetCore,
  dxSpreadSheetReportDesigner,
  cxDateUtils,
  zBaseLib,
  Gesty_StoredProcs,
  zOffice.Reports;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TCalendarioAvvioCorsi.Create(aOwner: TComponent);
begin
  inherited;

  FIdProgetto := -1;
  /// //////////////
  FTitoloCorso := '';
  FCodiceCorso := '';
  FTipoAnnualita := 'Annualità unica';
  FIdSezione := '';
  FCodiceSezione := 'Annualità unica';

  FDalGiorno := 0;
  FAlGiorno := 0;
  FModalitaOperativa := 'Aula';

  FLunedi := false;
  FMartedi := false;
  FMercoledi := false;
  FGiovedi := false;
  FVenerdi := false;
  FSabato := false;
  FDomenica := false;

  FTotaleOreLunedi := 0;
  FTotaleOreMartedi := 0;
  FTotaleOreMercoledi := 0;
  FTotaleOreGiovedi := 0;
  FTotaleOreVenerdi := 0;
  FTotaleOreSabato := 0;
  FTotaleOreDomenica := 0;

  FOraInizio1_Lunedi := 0;
  FOraFine1_Lunedi := 0;
  FOraInizio2_Lunedi := 0;
  FOraFine2_Lunedi := 0;

  FOraInizio1_Martedi := 0;
  FOraFine1_Martedi := 0;
  FOraInizio2_Martedi := 0;
  FOraFine2_Martedi := 0;

  FOraInizio1_Mercoledi := 0;
  FOraFine1_Mercoledi := 0;
  FOraInizio2_Mercoledi := 0;
  FOraFine2_Mercoledi := 0;

  FOraInizio1_Giovedi := 0;
  FOraFine1_Giovedi := 0;
  FOraInizio2_Giovedi := 0;
  FOraFine2_Giovedi := 0;

  FOraInizio1_Venerdi := 0;
  FOraFine1_Venerdi := 0;
  FOraInizio2_Venerdi := 0;
  FOraFine2_Venerdi := 0;

  FOraInizio1_Sabato := 0;
  FOraFine1_Sabato := 0;
  FOraInizio2_Sabato := 0;
  FOraFine2_Sabato := 0;

  FOraInizio1_Domenica := 0;
  FOraFine1_Domenica := 0;
  FOraInizio2_Domenica := 0;
  FOraFine2_Domenica := 0;

  ReportsManager.OnGetVariable := function(VariableName: String): variant
    begin
      result := null;

      if SameText(VariableName, 'TitoloCorso') then
        result := TitoloCorso
      else
        if SameText(VariableName, 'CodiceCorso') then
          result := CodiceCorso
        else
          if SameText(VariableName, 'TipoAnnualita') then
            result := TipoAnnualita
          else
            if SameText(VariableName, 'IdSezione') then
              result := IdSezione
            else
              if SameText(VariableName, 'CodiceSezione') then
                result := CodiceSezione;
    end;

  SvuotaTemp;
end;

procedure TCalendarioAvvioCorsi.CalcolaTotali;
  function numero_ore(OraInizio1, OraFine1, OraInizio2, OraFine2: TTime): double;
  begin
    result := 0;

    if (OraInizio1 <> 0) and (OraFine1 <> 0) then
      result := MinutesBetween(OraInizio1, OraFine1);

    if (OraInizio2 <> 0) and (OraFine2 <> 0) then
      result := result + MinutesBetween(OraInizio2, OraFine2);

    result := result / 60.0;
  end;

begin
  FTotaleOreLunedi := numero_ore(OraInizio1_Lunedi, OraFine1_Lunedi, OraInizio2_Lunedi, OraFine2_Lunedi);
  FTotaleOreMartedi := numero_ore(OraInizio1_Martedi, OraFine1_Martedi, OraInizio2_Martedi, OraFine2_Martedi);
  FTotaleOreMercoledi := numero_ore(OraInizio1_Mercoledi, OraFine1_Mercoledi, OraInizio2_Mercoledi, OraFine2_Mercoledi);
  FTotaleOreGiovedi := numero_ore(OraInizio1_Giovedi, OraFine1_Giovedi, OraInizio2_Giovedi, OraFine2_Giovedi);
  FTotaleOreVenerdi := numero_ore(OraInizio1_Venerdi, OraFine1_Venerdi, OraInizio2_Venerdi, OraFine2_Venerdi);
  FTotaleOreSabato := numero_ore(OraInizio1_Sabato, OraFine1_Sabato, OraInizio2_Sabato, OraFine2_Sabato);
  FTotaleOreDomenica := numero_ore(OraInizio1_Domenica, OraFine1_Domenica, OraInizio2_Domenica, OraFine2_Domenica);
end;

procedure TCalendarioAvvioCorsi.Verifica;
  procedure VerificaOre(Giorno: string; OraInizio1, OraFine1, OraInizio2, OraFine2: TTime);
  begin

    if (OraInizio1 <> 0) and (OraFine1 <> 0) and (OraInizio1 >= OraFine1) then
      raise Exception.Create(Giorno + ': data 1 inizio maggiore di data 1 fine.');

    if (OraInizio2 <> 0) and (OraFine2 <> 0) and (OraInizio2 >= OraFine2) then
      raise Exception.Create(Giorno + ': data 2 inizio maggiore di data 2 fine.');

    if (OraInizio1 <> 0) and (OraInizio2 <> 0) and (OraFine1 >= OraInizio2) then
      raise Exception.Create(Giorno + ': data 1 fine maggiore di data 2 inizio.');
  end;

begin

  if (DalGiorno = 0) or (DalGiorno = cxDateUtils.NullDate) then
    raise Exception.Create('Data Inizio non specificata');

  if (AlGiorno = 0) or (AlGiorno = cxDateUtils.NullDate) then
    raise Exception.Create('Data Fine non specificata');

  VerificaOre('Lunedì', OraInizio1_Lunedi, OraFine1_Lunedi, OraInizio2_Lunedi, OraFine2_Lunedi);
  VerificaOre('Martedì', OraInizio1_Martedi, OraFine1_Martedi, OraInizio2_Martedi, OraFine2_Martedi);
  VerificaOre('Mercoledì', OraInizio1_Mercoledi, OraFine1_Mercoledi, OraInizio2_Mercoledi, OraFine2_Mercoledi);
  VerificaOre('Giovedì', OraInizio1_Giovedi, OraFine1_Giovedi, OraInizio2_Giovedi, OraFine2_Giovedi);
  VerificaOre('Venerdì', OraInizio1_Venerdi, OraFine1_Venerdi, OraInizio2_Venerdi, OraFine2_Venerdi);
  VerificaOre('Sabato', OraInizio1_Sabato, OraFine1_Sabato, OraInizio2_Sabato, OraFine2_Sabato);
  VerificaOre('Domenica', OraInizio1_Domenica, OraFine1_Domenica, OraInizio2_Domenica, OraFine2_Domenica);
end;

procedure TCalendarioAvvioCorsi.Genera;
var
  sp: TSP_CALENDARIO_INIZIO_CORSO_GENERA;
begin
  Verifica;

  StartWait('Attendere...', True);
  try
    sp := TSP_CALENDARIO_INIZIO_CORSO_GENERA.Create(WriteTrans);
    try
      sp.ID_PROGETTO := IdProgetto;
      sp.MODALITA_OPERATIVA := ModalitaOperativa;
      /// ///////////////
      sp.Dal_Giorno := DalGiorno;
      sp.AL_GIORNO := AlGiorno;

      if Lunedi then
      begin
        sp.ORA_INIZIO_1_LUNEDI := OraInizio1_Lunedi;
        sp.ORA_FINE_1_LUNEDI := OraFine1_Lunedi;
        sp.ORA_INIZIO_2_LUNEDI := OraInizio2_Lunedi;
        sp.ORA_FINE_2_LUNEDI := OraFine2_Lunedi;
      end;

      if Martedi then
      begin
        sp.ORA_INIZIO_1_MARTEDI := OraInizio1_Martedi;
        sp.ORA_FINE_1_MARTEDI := OraFine1_Martedi;
        sp.ORA_INIZIO_2_MARTEDI := OraInizio2_Martedi;
        sp.ORA_FINE_2_MARTEDI := OraFine2_Martedi;
      end;

      if Mercoledi then
      begin
        sp.ORA_INIZIO_1_MERCOLEDI := OraInizio1_Mercoledi;
        sp.ORA_FINE_1_MERCOLEDI := OraFine1_Mercoledi;
        sp.ORA_INIZIO_2_MERCOLEDI := OraInizio2_Mercoledi;
        sp.ORA_FINE_2_MERCOLEDI := OraFine2_Mercoledi;
      end;

      if Giovedi then
      begin
        sp.ORA_INIZIO_1_GIOVEDI := OraInizio1_Giovedi;
        sp.ORA_FINE_1_GIOVEDI := OraFine1_Giovedi;
        sp.ORA_INIZIO_2_GIOVEDI := OraInizio2_Giovedi;
        sp.ORA_FINE_2_GIOVEDI := OraFine2_Giovedi;
      end;

      if Venerdi then
      begin
        sp.ORA_INIZIO_1_VENERDI := OraInizio1_Venerdi;
        sp.ORA_FINE_1_VENERDI := OraFine1_Venerdi;
        sp.ORA_INIZIO_2_VENERDI := OraInizio2_Venerdi;
        sp.ORA_FINE_2_VENERDI := OraFine2_Venerdi;
      end;

      if Sabato then
      begin
        sp.ORA_INIZIO_1_SABATO := OraInizio1_Sabato;
        sp.ORA_FINE_1_SABATO := OraFine1_Sabato;
        sp.ORA_INIZIO_2_SABATO := OraInizio2_Sabato;
        sp.ORA_FINE_2_SABATO := OraFine2_Sabato;
      end;

      if Domenica then
      begin
        sp.ORA_INIZIO_1_DOMENICA := OraInizio1_Domenica;
        sp.ORA_FINE_1_DOMENICA := OraFine1_Domenica;
        sp.ORA_INIZIO_2_DOMENICA := OraInizio2_Domenica;
        sp.ORA_FINE_2_DOMENICA := OraFine2_Domenica;
      end;

      sp.ExecuteAndCommit;

      Giorni.ReOpen();
      ElencoPerReport.ReOpen();
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

function TCalendarioAvvioCorsi.ModelloFileName: string;
begin
  result := Path + 'Modello calendario.xlsx';
  result := 'Modello calendario';
end;

procedure TCalendarioAvvioCorsi.DateChiusuraBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  DateChiusura.ParamByName('ID_PROGETTO').Value := IdProgetto;
end;

procedure TCalendarioAvvioCorsi.SetIdProgetto(const Value: integer);
begin
  if Value <> FIdProgetto then
  begin
    FIdProgetto := Value;
    SvuotaTemp;
    DateChiusura.ReOpen();
  end;
end;

procedure TCalendarioAvvioCorsi.SvuotaTemp;
var
  sp: TSP_CALENDARIO_INIZIO_CORSO_TMP_DEL;
begin
  sp := TSP_CALENDARIO_INIZIO_CORSO_TMP_DEL.Create(WriteTrans);
  try
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  if Giorni.Active then
    Giorni.ReOpen();
end;

end.



