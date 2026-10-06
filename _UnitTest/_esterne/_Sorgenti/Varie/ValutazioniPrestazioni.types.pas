unit ValutazioniPrestazioni.types;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.Db,
  zz.GenericCollection;

type
  TCampoValutazione = (cvNull, cvIdRisorsa, cvTipoRisorsa, cvNominativo, cvTipologiaFornitore, cvDescTipologiaFornitore, cvDataAttivazione, cvDataDisattivazione, cvDataInizioValiditaInquadramento,
    cvDataFineValiditaInquadramento, cvTipoInquadramento, cvTipoContratto, cvBloccaIncarichi, cvStatoRisorsa, cvDescStatoRisorsa, cvIdValutazione, cvAnnoValutazione, cvDataValutazione, cvValutazione,
    cvDescValutazione);

  // PERSONA = P
  // AZIENDA = A
  TTipoRisorsa = (trPersona, trAzienda);

  TTipoRisorsaHelper = record helper for TTipoRisorsa
  private
    function GetAsString: string;
    function GetDescription: String;
    procedure SetAsString(const Value: string);
  public
    property AsString: string read GetAsString write SetAsString;
    property Description: String read GetDescription;
  end;

  // Collaboratori e società per l’erogazione dei servizi = C
  // Professionisti e società per supporto professionale = P
  // Prodotti e servizi accessori per l’erogazione dei servizi = S
  // Beni e servizi di funzionamento = B
  TTipologiaFornitore = (tfCollaborazioni, tfProfessionisti, tfProdottiServizi, tfBeniServizi);

  TTipologiaFornitoreHelper = record helper for TTipologiaFornitore
  private
    function GetAsString: string;
    function GetDescription: String;
    procedure SetAsString(const Value: string);
  public
    property AsString: string read GetAsString write SetAsString;
    property Description: String read GetDescription;
  end;

  // DIPENDENTE =D
  // PARTITA IVA=P
  // OCCASIONALE=O
  // INTERINALE =I
  // AZIENDA    =A
  TTipoContratto = (tcDipendente, tcPartitaIva, tcOccasionale, tcInterinale, tcAzienda);

  TTipoContrattoHelper = record helper for TTipoContratto
  private
    function GetAsString: string;
    function GetDescription: String;
    procedure SetAsString(const Value: string);
  public
    property AsString: string read GetAsString write SetAsString;
    property Description: String read GetDescription;
  end;

  // ATTIVA    = A
  // SOSPESA   = S
  // ELIMINATA = E
  TStatoRisorsa = (srAttiva, srSospesa, srEliminata);

  TStatoRisorsaHelper = record helper for TStatoRisorsa
  private
    function GetAsString: string;
    function GetDescription: String;
    procedure SetAsString(const Value: string);
  public
    property AsString: string read GetAsString write SetAsString;
    property Description: String read GetDescription;
  end;

implementation

procedure TTipoRisorsaHelper.SetAsString(const Value: string);
begin
  if SameText(Value, 'A') then
    Self := trAzienda
  else
    if SameText(Value, 'P') then
      Self := trPersona;
end;

function TTipoRisorsaHelper.GetAsString: string;
begin
  case Self of
    trPersona:
      Result := 'P';
    trAzienda:
      Result := 'A';
  end;
end;

function TTipoRisorsaHelper.GetDescription: String;
begin
  case Self of
    trPersona:
      Result := 'Persona';
    trAzienda:
      Result := 'Azienda';
  end;
end;

{ TTipologiaFornitoreHelper }

procedure TTipologiaFornitoreHelper.SetAsString(const Value: string);
begin
  if SameText(Value, 'C') then
    Self := tfCollaborazioni
  else
    if SameText(Value, 'P') then
      Self := tfProfessionisti
    else
      if SameText(Value, 'S') then
        Self := tfProdottiServizi
      else
        if SameText(Value, 'B') then
          Self := tfBeniServizi;
end;

function TTipologiaFornitoreHelper.GetAsString: string;
begin
  case Self of
    tfCollaborazioni:
      Result := 'C';
    tfProfessionisti:
      Result := 'P';
    tfProdottiServizi:
      Result := 'S';
    tfBeniServizi:
      Result := 'B';
  end;
end;

function TTipologiaFornitoreHelper.GetDescription: String;
begin
  case Self of
    tfCollaborazioni:
      Result := 'Collaboratori e società per l’erogazione dei servizi';
    tfProfessionisti:
      Result := 'Professionisti e società per supporto professionale';
    tfProdottiServizi:
      Result := 'Prodotti e servizi accessori per l’erogazione dei servizi';
    tfBeniServizi:
      Result := 'Beni e servizi di funzionamento';
  end;
end;

{ TTipoContrattoHelper }

procedure TTipoContrattoHelper.SetAsString(const Value: string);
begin
  if SameText(Value, 'D') then
    Self := tcDipendente
  else
    if SameText(Value, 'P') then
      Self := tcPartitaIva
    else
      if SameText(Value, 'O') then
        Self := tcOccasionale
      else
        if SameText(Value, 'I') then
          Self := tcInterinale
        else
          if SameText(Value, 'A') then
            Self := tcAzienda;
end;

function TTipoContrattoHelper.GetAsString: string;
begin
  case Self of
    tcDipendente:
      Result := 'D';
    tcPartitaIva:
      Result := 'P';
    tcOccasionale:
      Result := 'O';
    tcInterinale:
      Result := 'I';
    tcAzienda:
      Result := 'A';
  end;
end;

function TTipoContrattoHelper.GetDescription: String;
begin
  case Self of
    tcDipendente:
      Result := 'Dipendente';
    tcPartitaIva:
      Result := 'Partita Iva';
    tcOccasionale:
      Result := 'Occasionale';
    tcInterinale:
      Result := 'Interinale';
    tcAzienda:
      Result := 'Azienda';
  end;
end;

{ TStatoRisorsaHelper }

procedure TStatoRisorsaHelper.SetAsString(const Value: string);
begin
  if SameText(Value, 'A') then
    Self := srAttiva
  else
    if SameText(Value, 'S') then
      Self := srSospesa
    else
      if SameText(Value, 'E') then
        Self := srEliminata;
end;

function TStatoRisorsaHelper.GetAsString: string;
begin
  case Self of
    srAttiva:
      Result := 'A';
    srSospesa:
      Result := 'S';
    srEliminata:
      Result := 'E';
  end;
end;

function TStatoRisorsaHelper.GetDescription: String;
begin
  case Self of
    srAttiva:
      Result := 'Attiva';
    srSospesa:
      Result := 'Sospesa';
    srEliminata:
      Result := 'Eliminata';
  end;
end;

end.
