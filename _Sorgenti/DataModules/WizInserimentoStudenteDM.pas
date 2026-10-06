unit WizInserimentoStudenteDM;

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
  SmartInspect.VCL.SiAuto,
  SmartInspect.VCL,
  System.Generics.Collections;

type
  TWizInserimentoStudente = class(TBaseDataModule)
    StudentiSrc: TDataSource;
    Studenti: TzFbDataSet;
    GenitoriSrc: TDataSource;
    Genitori: TzFbDataSet;
    StudentiFilesSrc: TDataSource;
    StudentiFiles: TzFbDataSet;
    GenitoriFilesSrc: TDataSource;
    GenitoriFiles: TzFbDataSet;
    ProgettiSrc: TDataSource;
    Progetti: TzFbDataSet;
    BisogniEd: TzFbDataSet;
    BisogniEdSrc: TDataSource;
    Lingue: TzFbDataSet;
    LingueSrc: TDataSource;
    Esperienze: TzFbDataSet;
    EsperienzeSrc: TDataSource;
    DispOrari: TzFbDataSet;
    DispOrariSrc: TDataSource;
    ContiCorrenti: TzFbDataSet;
    ContiCorrentiSrc: TDataSource;
    FigureProfessionali: TzFbDataSet;
    FigureProfessionaliSrc: TDataSource;
    procedure GenitoriAfterInsert(DataSet: TDataSet);
    procedure ProgettiNewRecord(DataSet: TDataSet);
    procedure ProgettiBeforePost(DataSet: TDataSet);
    procedure StudentiAfterPost(DataSet: TDataSet);
    procedure StudentiBeforeOpen(DataSet: TDataSet);
    procedure StudentiAfterCreateFields(DataSet: TDataSet);
    procedure StudentiFillCache(DataSet: TDataSet);
    procedure StudentiAfterOpen(DataSet: TDataSet);
  private
    FIdStudente: Integer;
  protected
    ResidenzaValues: TDictionary<string, variant>;
    procedure StudentiRecapitoFieldChange(Field: TField);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init;
    function ConfermaAnnulla: boolean;
    function ConfermaChiusura: boolean;
    function GetRiepilogo: string;

    property IdStudente: Integer read FIdStudente write FIdStudente;
  end;

var
  WizInserimentoStudente: TWizInserimentoStudente;

implementation

uses
  Gesty_StoredProcs,
  ConfigModule,
  zCodiceFiscale,
  zBaseLib,
  System.Variants,
  dmCommon;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TWizInserimentoStudente.Create(aOwner: TComponent);
begin
  inherited;
  FIdStudente := -1;

  SetAutoCommit(false);
  ResidenzaValues := TDictionary<string, variant>.Create();
end;

destructor TWizInserimentoStudente.Destroy;
begin
  FreeAndNil(ResidenzaValues);
  inherited;
end;

function TWizInserimentoStudente.ConfermaAnnulla: boolean;
begin
  Rollback(false);
  result := true;
end;

function TWizInserimentoStudente.ConfermaChiusura: boolean;
begin
  Commit;
  result := true;
end;

function TWizInserimentoStudente.GetRiepilogo: string;
var
  StringList: TStringList;
begin
  result := '';

  StringList := TStringList.Create;
  try
    StringList.Add('Id Studente: ' + IdStudente.ToString);

    result := StringList.Text;
  finally
    FreeAndNil(StringList);
  end;
end;

procedure TWizInserimentoStudente.StudentiAfterPost(DataSet: TDataSet);
begin
  inherited;
  FIdStudente := Studenti.FieldByName('ID_STUDENTE').asInteger;
end;

procedure TWizInserimentoStudente.StudentiBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Studenti.ParamByName('ID_STUDENTE').asInteger := IdStudente;
end;

procedure TWizInserimentoStudente.GenitoriAfterInsert(DataSet: TDataSet);
begin
  inherited;
  //
  Genitori.FieldByName('ID_STUDENTE').asInteger := Studenti.FieldByName('ID_STUDENTE').asInteger;
  Genitori.FieldByName('COGNOME').asString := Studenti.FieldByName('COGNOME').asString;
  Genitori.FieldByName('NOME').clear; // settato in CopyMasterFields di zFbDataSet
  Genitori.FieldByName('CODICE_FISCALE').clear; // settato in CopyMasterFields di zFbDataSet
  Genitori.FieldByName('TELEFONO_1').asString := Studenti.FieldByName('TELEFONO_1').asString;
  Genitori.FieldByName('TELEFONO_2').asString := Studenti.FieldByName('TELEFONO_2').asString;
  Genitori.FieldByName('E_MAIL').asString := Studenti.FieldByName('E_MAIL').asString;
  Genitori.FieldByName('RESIDENZA_INDIRIZZO').asString := Studenti.FieldByName('RESIDENZA_INDIRIZZO').asString;
  Genitori.FieldByName('RESIDENZA_NUMERO_CIVICO').asString := Studenti.FieldByName('RESIDENZA_NUMERO_CIVICO').asString;
  Genitori.FieldByName('RESIDENZA_CAP').asString := Studenti.FieldByName('RESIDENZA_CAP').asString;
  Genitori.FieldByName('RESIDENZA_CITTA').asString := Studenti.FieldByName('RESIDENZA_CITTA').asString;
  Genitori.FieldByName('RESIDENZA_PROVINCIA').asString := Studenti.FieldByName('RESIDENZA_PROVINCIA').asString;
  Genitori.FieldByName('RESIDENZA_LOCALITA').asString := Studenti.FieldByName('RESIDENZA_LOCALITA').asString;
end;

procedure TWizInserimentoStudente.Init;
begin
  OpenDataSets;
  Studenti.Append;

  if false then
    if Config.zSystem.IsAdmin and Debug then
    begin
      Studenti.FieldByName('COGNOME').asString := 'ZEBRO';
      Studenti.FieldByName('NOME').asString := 'LUCA';
      Studenti.FieldByName('CODICE_FISCALE').asString := 'ZBRLCU71B11L872Z';
    end;
end;

procedure TWizInserimentoStudente.ProgettiNewRecord(DataSet: TDataSet);
begin
  inherited;
  Progetti.FieldByName('ID_REFERENTE_PRATICA').asInteger := Common.CurrentIdRisorsa;
end;

// Mantis #136 - 2026-09-18: fix errore "Valore non valido per il campo STUDENTI_PROGETTI.ID_STUDENTE,
// valore '*** null ***'" nel wizard di inserimento studente. Alla creazione della riga (ProgettiNewRecord)
// lo studente non ha ancora un identificativo, perche' il record master e' ancora in inserimento: il
// CopyMasterFields di zFbDataSet copia quindi un valore nullo. Qui, appena prima della scrittura, lo
// studente e' gia' stato salvato da PostAll (Studenti precede Progetti nell'ordine del DataModule),
// quindi l'identificativo e' disponibile e viene ricopiato solo se non era gia' stato valorizzato.
procedure TWizInserimentoStudente.ProgettiBeforePost(DataSet: TDataSet);
begin
  inherited;
  if Progetti.FieldByName('ID_STUDENTE').IsNull then
    Progetti.FieldByName('ID_STUDENTE').asInteger := Studenti.FieldByName('ID_STUDENTE').asInteger;
end;

procedure TWizInserimentoStudente.StudentiAfterCreateFields(DataSet: TDataSet);
begin
  // se il campo di residenza � stato variato, se old = Domicilio => domicilio = residenza
  DataSet.FieldByName('RESIDENZA_INDIRIZZO').OnChange := StudentiRecapitoFieldChange;
  DataSet.FieldByName('RESIDENZA_NUMERO_CIVICO').OnChange := StudentiRecapitoFieldChange;
  DataSet.FieldByName('RESIDENZA_BELFIORE').OnChange := StudentiRecapitoFieldChange;
  DataSet.FieldByName('RESIDENZA_CAP').OnChange := StudentiRecapitoFieldChange;
  DataSet.FieldByName('RESIDENZA_CITTA').OnChange := StudentiRecapitoFieldChange;
  DataSet.FieldByName('RESIDENZA_PROVINCIA').OnChange := StudentiRecapitoFieldChange;
  DataSet.FieldByName('RESIDENZA_LOCALITA').OnChange := StudentiRecapitoFieldChange;
  DataSet.FieldByName('RESIDENZA_SIGLA_STATO').OnChange := StudentiRecapitoFieldChange;
end;

procedure TWizInserimentoStudente.StudentiAfterOpen(DataSet: TDataSet);
begin
  inherited;
  // INSERT INTO ZZ_CUSTOM_DATASETS (DATASET, REQUIRED_FIELDS, REMOVE_DEFAULT_EXPRESSION) VALUES ('WizardInserimentoStudente', 'E_MAIL,TELEFONO_1', NULL);
  Common.CustomizeDataSet('WizardInserimentoStudente', TzFbDataSet(DataSet));
end;

procedure TWizInserimentoStudente.StudentiRecapitoFieldChange(Field: TField);
var
  domicilioField: TField;
  oldValue: variant;

  function FieldIsNull(Field: TField): boolean;
  begin
    result := false;

    if Field.IsNull then
      result := true
    else
      if VarIsClear(Field.Value) then
        result := true
      else
        if VarIsStr(Field.Value) then
          if VarToStr(Field.Value).IsEmpty then
            result := true;
  end;

begin
  // cerca il corrispondente campo di DOMICILIO_
  domicilioField := Field.DataSet.FindField(Field.FieldName.Replace('RESIDENZA_', 'DOMICILIO_', [rfIgnoreCase]));

  // se il campo di residenza � stato variato, se old = Domicilio => domicilio = residenza
  if Assigned(domicilioField) then
  begin

    if not ResidenzaValues.TryGetValue(Field.FieldName, oldValue) then
      oldValue := Field.oldValue;

    if VarSameValue(oldValue, domicilioField.Value) or FieldIsNull(domicilioField) then
      domicilioField.Value := Field.NewValue;
  end;

  ResidenzaValues.AddOrSetValue(Field.FieldName, Field.NewValue);
end;

procedure TWizInserimentoStudente.StudentiFillCache(DataSet: TDataSet);
  procedure Add2Cache(FieldName: String);
  var
    Field: TField;
  begin
    Field := Studenti.FieldByName(FieldName);
    ResidenzaValues.AddOrSetValue(Field.FieldName, Field.Value);
  end;

begin
  inherited;
  ResidenzaValues.clear;

  Add2Cache('RESIDENZA_INDIRIZZO');
  Add2Cache('RESIDENZA_NUMERO_CIVICO');
  Add2Cache('RESIDENZA_BELFIORE');
  Add2Cache('RESIDENZA_CAP');
  Add2Cache('RESIDENZA_CITTA');
  Add2Cache('RESIDENZA_PROVINCIA');
  Add2Cache('RESIDENZA_LOCALITA');
  Add2Cache('RESIDENZA_SIGLA_STATO');
end;

end.
