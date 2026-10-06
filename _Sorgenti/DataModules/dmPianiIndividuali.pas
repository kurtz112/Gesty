unit dmPianiIndividuali;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Base_DataModule,
  dbMaster,
  zFbDataSet;

type
  TPianiIndividuali = class(TBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    Presenze_IndividualiDisabilitaFieldChanged: Boolean;

    procedure Presenze_IndividualiNewRecord(DataSet: TDataSet);
    procedure Presenze_IndividualiAfterCreateFields(DataSet: TDataSet);
    procedure Presenze_IndividualiCalcolaOraFine(Sender: TField);
    procedure Presenze_IndividualiDataChanged(Sender: TField);
    procedure Presenze_IndividualiRicalcolaIncarico(Sender: TField);

    procedure Presenze_IndividualiCalcolaIncarico;
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    function NuovoPianoIndividuale: Boolean;
    function NuovoIncarico: Boolean;
  end;

var
  PianiIndividuali: TPianiIndividuali;

implementation

uses
  System.DateUtils,
  zBaseLib,
  WizInserimentoPianiPersonalizzatiFrm,
  WizInserimentoIncaricoFrm,
  Gesty_StoredProcs;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TPianiIndividuali }

procedure TPianiIndividuali.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Presenze_IndividualiDisabilitaFieldChanged := False;
end;

procedure TPianiIndividuali.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Presenze_Individuali') then
  begin
    DataSet.OnAfterCreateFields := Presenze_IndividualiAfterCreateFields;
    DataSet.OnNewRecord := Presenze_IndividualiNewRecord;
  end;
end;

procedure TPianiIndividuali.Presenze_IndividualiNewRecord(DataSet: TDataSet);
var
  PianiIndividuali: TzFbDataSet;
  Presenze_Individuali: TzFbDataSet;
begin
  PianiIndividuali := GetDataSet('PianiIndividuali');
  Presenze_Individuali := GetDataSet('Presenze_Individuali');

  Presenze_Individuali.FieldByName('ID_STUDENTE').asInteger := PianiIndividuali.FieldByName('ID_STUDENTE').asInteger;
end;

procedure TPianiIndividuali.Presenze_IndividualiAfterCreateFields(DataSet: TDataSet);
var
  Field: TField;
begin
  // PIP
  Field := DataSet.FindField('ID_RISORSA');
  if Assigned(Field) then
    Field.OnChange := Presenze_IndividualiRicalcolaIncarico;

  Field := DataSet.FindField('ID_PROGETTO');
  if Assigned(Field) then
    Field.OnChange := Presenze_IndividualiRicalcolaIncarico;
  Field := DataSet.FindField('TIPO_INCARICO');
  if Assigned(Field) then
    Field.OnChange := Presenze_IndividualiRicalcolaIncarico;

  Field := DataSet.FindField('ID_PIANO_PERSONALIZZATO');
  if Assigned(Field) then
    Field.OnChange := Presenze_IndividualiRicalcolaIncarico;

  Field := DataSet.FindField('SERVIZIO_EROGATO');
  if Assigned(Field) then
    Field.OnChange := Presenze_IndividualiRicalcolaIncarico;

  Field := DataSet.FindField('MATERIA');
  if Assigned(Field) then
    Field.OnChange := Presenze_IndividualiRicalcolaIncarico;

  Field := DataSet.FindField('ID_INCARICO');
  if Assigned(Field) then
    Field.OnChange := Presenze_IndividualiRicalcolaIncarico;

  Field := DataSet.FindField('DATA_LEZIONE');
  if Assigned(Field) then
    Field.OnChange := Presenze_IndividualiDataChanged;

  // calcolo ora fine
  Field := DataSet.FindField('ORA_INIZIO');
  if Assigned(Field) then
    Field.OnChange := Presenze_IndividualiCalcolaOraFine;

  Field := DataSet.FindField('DURATA');
  if Assigned(Field) then
    Field.OnChange := Presenze_IndividualiCalcolaOraFine;
end;

procedure TPianiIndividuali.Presenze_IndividualiCalcolaOraFine(Sender: TField);
var
  DataSet: TzFbDataSet;
  Inizio, Fine, Durata: TField;
begin
  // PIP
  DataSet := GetDataSet('Presenze_Individuali');

  Inizio := DataSet.FieldByName('ORA_INIZIO');
  Durata := DataSet.FieldByName('DURATA');
  Fine := DataSet.FieldByName('ORA_FINE');

  if (Inizio.IsNull or Durata.IsNull) then
    Fine.Clear
  else
    Fine.Value := IncMinute(Inizio.asDateTime, Durata.asInteger);
end;

procedure TPianiIndividuali.Presenze_IndividualiDataChanged(Sender: TField);
begin
  if DateOf(Sender.asDateTime) > Date then
    raise exception.Create('Data non valida.');

  Presenze_IndividualiCalcolaIncarico;
end;

procedure TPianiIndividuali.Presenze_IndividualiRicalcolaIncarico(Sender: TField);
begin

  if Presenze_IndividualiDisabilitaFieldChanged then
    exit;

  Presenze_IndividualiDisabilitaFieldChanged := True;
  try
    if SameText(Sender.FieldName, 'ID_PROGETTO') then
    begin
      Sender.DataSet.FieldByName('TIPO_INCARICO').Clear;
      Sender.DataSet.FieldByName('ID_INCARICO').Clear;
    end
    else
      if SameText(Sender.FieldName, 'TIPO_INCARICO') then
      begin
        Sender.DataSet.FieldByName('ID_INCARICO').Clear;
      end;

    Presenze_IndividualiCalcolaIncarico;
  finally
    Presenze_IndividualiDisabilitaFieldChanged := False;
  end;
end;

procedure TPianiIndividuali.Presenze_IndividualiCalcolaIncarico;
var
  sp: TSP_INCARICHI_GET_PRESENZE;
  Presenze_Individuali: TzFbDataSet;
  IdRisorsa, IdProgetto, Tipo_Incarico, IdStudente, ServizioErogato, Materia, IdIncarico, Data, OraInizio, OraFine: TField;
begin
  Presenze_Individuali := GetDataSet('Presenze_Individuali');

  IdRisorsa := Presenze_Individuali.FindField('ID_RISORSA'); // l'originale incaricato
  IdProgetto := Presenze_Individuali.FindField('ID_PROGETTO');
  Tipo_Incarico := Presenze_Individuali.FindField('TIPO_INCARICO');
  IdStudente := Presenze_Individuali.FindField('ID_PIANO_PERSONALIZZATO');
  ServizioErogato := Presenze_Individuali.FindField('SERVIZIO_EROGATO');
  Materia := Presenze_Individuali.FindField('MATERIA');
  IdIncarico := Presenze_Individuali.FindField('ID_INCARICO');
  Data := Presenze_Individuali.FindField('DATA_LEZIONE');
  OraInizio := Presenze_Individuali.FindField('ORA_INIZIO');
  OraFine := Presenze_Individuali.FindField('ORA_FINE');

  if not IdRisorsa.IsNull then
    if not IdProgetto.IsNull then
      if not Tipo_Incarico.IsNull then
        if not Data.IsNull then
          if not OraInizio.IsNull then
            if not OraFine.IsNull then
            begin
              sp := TSP_INCARICHI_GET_PRESENZE.Create(WriteTrans);
              try
                sp.Id_Personale := IdRisorsa.Value;
                sp.Id_Progetto := IdProgetto.Value;
                sp.Tipo_Incarico := Tipo_Incarico.Value;

                if IdStudente.IsNull then
                  sp.Id_Piano_Personalizzato.Clear
                else
                  sp.Id_Piano_Personalizzato := IdStudente.Value;

                if ServizioErogato.IsNull then
                  sp.Servizio_Erogato.Clear
                else
                  sp.Servizio_Erogato := ServizioErogato.Value;

                if Materia.IsNull then
                  sp.Materia.Clear
                else
                  sp.Materia := Materia.Value;

                if IdIncarico.IsNull then
                  sp.Id_Incarico_Current.Clear
                else
                  sp.Id_Incarico_Current := IdIncarico.asInteger;

                sp.Data := Data.Value;
                sp.Ora_Inizio := OraInizio.Value;
                sp.Ora_Fine := OraFine.Value;
                sp.ExecuteAndCommit;

                Presenze_Individuali.CheckEditMode;
                // RegistroIndividuale.FieldByName('ID_PRESENZA_PERSONALE').Value := sp.Id_Presenza_Personale;
                // RegistroIndividuale.FieldByName('DATA_PRESENZA').Value := sp.Data_Presenza;
                // RegistroIndividuale.FieldByName('ORA_ENTRATA').Value := sp.Ora_Entrata;
                // RegistroIndividuale.FieldByName('ORA_USCITA').Value := sp.Ora_Uscita;
                // RegistroIndividuale.FieldByName('TIPO_PRESENZA').Value := sp.Tipo_Presenza;
                Presenze_Individuali.FieldByName('ID_INCARICO').Value := sp.Id_Incarico;
                // RegistroIndividuale.FieldByName('TOTALE_ORE_ATTRIBUITE').Value := sp.Totale_Ore_Attribuite;
                // RegistroIndividuale.FieldByName('DATA_INIZIO_INCARICO').Value := sp.Data_Inizio_Incarico;
                // RegistroIndividuale.FieldByName('DATA_FINE_INCARICO').Value := sp.Data_Fine_Incarico;
              finally
                FreeAndNil(sp);
              end;
            end;
end;

function TPianiIndividuali.NuovoPianoIndividuale: Boolean;
begin
  result := ApriInserimentoPianoPersonalizzato(-1, nullDate);

  if result then
    ReopenDataSet('PianiIndividuali');
end;

function TPianiIndividuali.NuovoIncarico: Boolean;
var
  DataSet: TzFbDataSet;
  IdPersonale: integer;
  IdProgetto: integer;
  IdPianoPersonalizzato: integer;
  IdentificativoPIP: string;
  DataInizio, DataFine: TDateTime;
begin
  DataSet := GetDataSet('PianiIndividuali');
  IdPersonale := DataSet.FieldByName('ID_TUTOR').asInteger;
  IdProgetto := DataSet.FieldByName('ID_PROGETTO').asInteger;
  IdPianoPersonalizzato := DataSet.FieldByName('ID_PIANO_PERSONALIZZATO').asInteger;
  IdentificativoPIP := DataSet.FieldByName('IDENTIFICATIVO').asString;
  DataInizio := DataSet.FieldByName('DATA_INIZIO').asDateTime;
  DataFine := DataSet.FieldByName('DATA_FINE').asDateTime;

  result := ApriInserimentoIncaricoDaPIP(IdPersonale, IdProgetto, IdPianoPersonalizzato, IdentificativoPIP, DataInizio, DataFine) <> -1;

  if result then
    ReopenDataSet('Incarichi');
end;

end.


