unit dmStudentiRilevamentoPresenzeAssenze;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
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
  zFbDataSet;

type
  TStudentiRilevamentoPresenzeAssenze = class(TBaseDataModule)
    lkProgetti: TzFbDataSet;
    lkProgettiSrc: TDataSource;
    Presenti: TzFbDataSet;
    PresentiSrc: TDataSource;
    Assenti: TzFbDataSet;
    AssentiSrc: TDataSource;
    OreLezione: TzFbDataSet;
    OreLezioneSrc: TDataSource;
    Individuali: TzFbDataSet;
    IndividualiSrc: TDataSource;
    lkMaterie: TzFbDataSet;
    lkMaterieSrc: TDataSource;
    procedure AssentiAfterPost(DataSet: TDataSet);
    procedure AssentiBeforeOpen(DataSet: TDataSet);
    procedure IndividualiBeforeOpen(DataSet: TDataSet);
    procedure OreLezioneBeforeOpen(DataSet: TDataSet);
    procedure PresentiBeforeOpen(DataSet: TDataSet);
  private
  private
    FData: TDate;
    FIdProgetto: integer;
    procedure SetData(const Value: TDate);
    procedure SetIdProgetto(const Value: integer);
  private
    procedure RiapriDataSet;
  public
    constructor Create(aOwner: TComponent); override;

    procedure RegistraPresenze;
    procedure EliminaPresenze;
    procedure RegistraAssenze(Assenti: TList<integer>);
    procedure RegistraAttivitaIndividuali(Studenti: TList<integer>);

    property IdProgetto: integer read FIdProgetto write SetIdProgetto;
    property Data: TDate read FData write SetData;
  end;

var
  StudentiRilevamentoPresenzeAssenze: TStudentiRilevamentoPresenzeAssenze;

implementation

uses
  System.DateUtils,
  System.UITypes,
  Vcl.Dialogs,
  zOffice.Reports,
   
  zMsg,
  zBaseLib,
  Gesty_StoredProcs,
  frmStudentiRilevamentoAttivitaIndividuali,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TStudentiRilevamentoPresenzeAssenze.Create(aOwner: TComponent);
begin
  inherited;
  FData := Date;
  FIdProgetto := -1;
end;

procedure TStudentiRilevamentoPresenzeAssenze.AssentiBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Assenti.ParamByName('ID_PROGETTO').AsInteger := IdProgetto;
  Assenti.ParamByName('DATA').AsDate := Data;
end;

procedure TStudentiRilevamentoPresenzeAssenze.PresentiBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Presenti.ParamByName('ID_PROGETTO').AsInteger := IdProgetto;
  Presenti.ParamByName('DATA').AsDate := Data;
end;

procedure TStudentiRilevamentoPresenzeAssenze.RiapriDataSet;
begin
  OreLezione.ReOpen();
  Presenti.ReOpen();
  Assenti.ReOpen();
  Individuali.ReOpen();
end;

procedure TStudentiRilevamentoPresenzeAssenze.SetData(const Value: TDate);
begin
  FData := Value;
  RiapriDataSet;
end;

procedure TStudentiRilevamentoPresenzeAssenze.SetIdProgetto(const Value: integer);
begin
  FIdProgetto := Value;
  RiapriDataSet;
end;

procedure TStudentiRilevamentoPresenzeAssenze.RegistraPresenze;
var
  sp: TSP_STUDENTI_REGISTRA_ORE_LEZIONE;
  ore: Double;
begin

  if not InputDouble('Ore lezione', 'Ore lezione', ore) then
    Exit;

  sp := TSP_STUDENTI_REGISTRA_ORE_LEZIONE.Create(WriteTrans);
  try
    sp.Id_Progetto := IdProgetto;
    sp.Data_Lezione := Data;
    sp.Ore_Lezione := ore;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  RiapriDataSet;
end;

procedure TStudentiRilevamentoPresenzeAssenze.EliminaPresenze;
var
  sp: TSP_STUDENTI_ELIMINA_LEZIONE;
begin

  if not ConfirmYesNo('Annullare le ore di frequenza e le assenze?') then
    Exit;

  sp := TSP_STUDENTI_ELIMINA_LEZIONE.Create(WriteTrans);
  try
    sp.Id_Progetto := IdProgetto;
    sp.Data_Lezione := Data;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;
  RiapriDataSet;
end;

procedure TStudentiRilevamentoPresenzeAssenze.AssentiAfterPost(DataSet: TDataSet);
begin
  inherited;
  RiapriDataSet;
end;

procedure TStudentiRilevamentoPresenzeAssenze.OreLezioneBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  OreLezione.ParamByName('ID_PROGETTO').AsInteger := IdProgetto;
  OreLezione.ParamByName('DATA').AsDate := Data;
end;

procedure TStudentiRilevamentoPresenzeAssenze.RegistraAssenze(Assenti: TList<integer>);
var
  sp: TSP_STUDENTI_REGISTRA_ASSENZA;
  id: integer;
begin

  sp := TSP_STUDENTI_REGISTRA_ASSENZA.Create(WriteTrans);
  try
    for id in Assenti do
    begin
      sp.Id_Studente := id;
      sp.Id_Progetto := IdProgetto;
      sp.Data_Assenza := Data;
      sp.ExecuteAndCommit;
    end;
  finally
    FreeAndNil(sp);
  end;
  RiapriDataSet;
end;

procedure TStudentiRilevamentoPresenzeAssenze.IndividualiBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Individuali.ParamByName('ID_PROGETTO').AsInteger := IdProgetto;
  Individuali.ParamByName('DATA_LEZIONE').AsDate := Data;
end;

procedure TStudentiRilevamentoPresenzeAssenze.RegistraAttivitaIndividuali(Studenti: TList<integer>);
var
  ore: Double;
  Materia: string;
  id: integer;
  sp: TSP_STUDENTI_REGISTRA_ATT_INDIVID;
begin
  if Studenti.Count = 0 then
    Exit;

  if not ApriFormStudentiRilevamentoAttivitaIndividuali(ore, Materia) then
    Exit;

  StartWait('Attendere...', true);
  try

    sp := TSP_STUDENTI_REGISTRA_ATT_INDIVID.Create(WriteTrans);
    try
      sp.Id_Progetto := IdProgetto;
      sp.Data_Lezione := Data;
      sp.Ore_Lezione := ore;
      sp.Materia := Materia;

      for id in Studenti do
      begin
        sp.Id_Studente := id;
        sp.ExecuteAndCommit;
      end;
    finally
      FreeAndNil(sp);
    end;

    Individuali.ReOpen;
  finally
    StopWait;
  end;
end;

end.
