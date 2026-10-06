unit Gesty.AI.Resolvers;

{
  Logica di DOMINIO specifica di Gesty per il contesto AI.

  Qui vivono i dettagli che il layer AI generico (zAI.*) non deve conoscere:
  nomi di campo, codici di tipo soggetto, regole per dedurre minore eta' e
  natura del soggetto. Il builder generico chiama un TAIRecordContextResolver
  senza sapere come e' fatto; questa unit ne fornisce l'implementazione Gesty.

  Tenere SOLO conoscenza Gesty qui. Altri progetti (es. wintarif) avranno la
  propria unit di resolver coi propri campi.
}

interface

uses
  Data.DB,
  zAI.Types,              // TAISensitivity, TAIDataDisclosure
  zGdpr.Classifier,       // TGdprRecordContext, TGdprClassifier
  zAI.Context,            // TAIContextPolicy
  zAI.Context.Orchestrator, // TAIProviderConstraints, TAIUserConstraints
  zAI.Context.SmokeTest;  // TAIContextSetup

// Resolver Gesty completo: deduce minore eta' e natura del soggetto dai campi
// dell'anagrafica Gesty.
function AIRecordContextGesty(const ADataSet: TDataSet): TGdprRecordContext;

// Costruisce il setup di contesto AI con le scelte di Gesty: classificatore
// reale e resolver Gesty. Il livello-form (FormOptions.AIMinSensitivity) e
// provider/utente li fornisce il chiamante (la BaseForm di Gesty, che ha il DM
// in scope), cosi' questa unit non dipende dal datamodule.
function GestyAISetup(
  const AProvider: TAIProviderConstraints;
  const AUser: TAIUserConstraints;
  const AFormMinLevel: TAISensitivity): TAIContextSetup; overload;
// Variante con default di collaudo per provider/utente (permissivo / maschera,
// azioni off). Il livello-form resta a carico del chiamante.
function GestyAISetup(const AFormMinLevel: TAISensitivity): TAIContextSetup; overload;

implementation

const
  // Campi dell'anagrafica Gesty usati per la classificazione del soggetto.
  FLD_TIPO_RISORSA = 'TIPO_RISORSA';   // 'A' = azienda
  FLD_MAGGIORENNE  = 'MAGGIORENNE';    // boolean: True/False/NULL
  TIPO_AZIENDA     = 'A';

function IsLegalEntityGesty(const ADataSet: TDataSet): Boolean;
var
  F: TField;
begin
  Result := False;
  F := ADataSet.FindField(FLD_TIPO_RISORSA);
  if Assigned(F) and not F.IsNull then
    Result := (F.AsString = TIPO_AZIENDA);
end;

function IsMinorGesty(const ADataSet: TDataSet; const AIsLegalEntity: Boolean): Boolean;
var
  F: TField;
begin
  Result := False;

  // La minore eta' si applica SOLO alle persone fisiche: per un'azienda la
  // categoria non e' pertinente e non si tenta di dedurla.
  if AIsLegalEntity then
    Exit;

  F := ADataSet.FindField(FLD_MAGGIORENNE);
  // Minore = MAGGIORENNE esplicitamente False. Se NULL (persona senza data di
  // nascita, anagrafica incompleta) NON si deduce minore eta' da un dato
  // assente: si resta su False. Doppio guardrail (tipo soggetto + not IsNull).
  if Assigned(F) and not F.IsNull then
    Result := (F.AsBoolean = False);
end;

function AIRecordContextGesty(const ADataSet: TDataSet): TGdprRecordContext;
var
  legalEntity: Boolean;
begin
  Result := TGdprRecordContext.Empty;
  if not Assigned(ADataSet) or not ADataSet.Active then
    Exit;

  legalEntity := IsLegalEntityGesty(ADataSet);
  Result := TGdprRecordContext.Create(
    IsMinorGesty(ADataSet, legalEntity),
    legalEntity);
end;

function GestyAISetup(
  const AProvider: TAIProviderConstraints;
  const AUser: TAIUserConstraints;
  const AFormMinLevel: TAISensitivity): TAIContextSetup;
begin
  Result.Classifier := TGdprClassifier.Create;   // resolver di default su Base.GetDomain
  Result.RecordResolver := AIRecordContextGesty;
  Result.Provider := AProvider;
  Result.User := AUser;
  Result.FormMinLevel := AFormMinLevel;
end;

function GestyAISetup(const AFormMinLevel: TAISensitivity): TAIContextSetup;
begin
  // Default di collaudo: provider permissivo, utente che maschera, azioni off.
  // In produzione usare l'overload con provider/utente reali.
  Result := GestyAISetup(
    TAIProviderConstraints.Create(ddFull, False),
    TAIUserConstraints.Create(ddMasked, False),
    AFormMinLevel);
end;

end.
