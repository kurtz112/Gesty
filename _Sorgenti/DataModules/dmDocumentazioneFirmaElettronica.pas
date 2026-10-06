// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-26
// ---------------------------------------------------------------------------
unit dmDocumentazioneFirmaElettronica;

// Motore di firma di Gesty: il ciclo di vita di una registrazione di firma,
// uguale per qualunque oggetto (contratti, contratti di fornitura, attestati,
// autorizzazioni di pagamento...). Qui stanno conferma, barra di avanzamento,
// annullo e giro sull'elenco; il resto lo fa il ponte Documentazione.Bridge.Firma.
//
// Cosa NON sta qui, perche' e' del dominio di chi chiama:
//   - chi sono i firmatari        -> parametro RisolviFirmatari
//   - quali documenti elencare    -> dataset del chiamante
//   - quali dataset ricaricare    -> dopo la chiamata, dal chiamante
//   - come si chiamano le cose    -> TEtichetteFirma
//
// Due utilizzatori:
//   - frmDocumentazioneFirmaElettronica, la griglia generica delle registrazioni;
//   - dmContratti, che ci inoltra le sue quattro azioni tenendosi il dominio
//     (le tre code dei contratti e i tre firmatari).
//
// Il giro di approvazione interna e' un parametro, non una scelta cablata:
// oggi lo decide il chiamante, domani arrivera' dal profilo del tipo documento
// (fornitore + approvazione si'/no per TIPO_DOCUMENTO).

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Base_DataModule,
  dbMaster,
   zProgressBox,
  zDocumentale.Firma.Types,
  Documentazione.Bridge.Firma;

type
  // risolve i firmatari di una registrazione al momento dell'invio, sui dati
  // vivi. Vale nil quando i firmatari sono gia' sulla busta o non servono
  // (fornitori a certificato remoto).
  TRisolutoreFirmatari = reference to function(IdFirmaRegistrazione: integer): TArray<TzFirmaFirmatario>;

  // come si chiama in interfaccia cio' che si sta firmando: le frasi le porta
  // il chiamante, cosi' i messaggi restano in buon italiano per qualunque
  // oggetto (il contratto / la richiesta / l'attestato).
  TEtichetteFirma = record
    Singolare: string; // 'il contratto selezionato'
    Plurale: string;   // 'i %d contratti selezionati'
    Titolo: string;    // 'Contratti' - intestazione della barra di avanzamento
    class function Crea(const Singolare, Plurale, Titolo: string): TEtichetteFirma; static;
  end;

  TDocumentazioneFirmaElettronica = class(TBaseDataModule)
    ProgressBox: TProgressBox;
    procedure DataModuleCreate(Sender: TObject);
  private
    function Ponte: TDocumentazioneBridgeFirma;
    function ComponiDomanda(const Verbo: string; const Etichette: TEtichetteFirma; const Quante: integer): string;
    procedure EseguiSuElenco(const Registrazioni: TList<integer>; const Domanda: string;
      const Titolo: string; const Azione: TProc<integer>);
  public
    // manda a firma una versione: e' il punto d'ingresso per un documento che
    // ancora non ha una registrazione. Con ConApprovazioneInterna la
    // registrazione nasce da approvare, altrimenti parte subito al fornitore.
    // Ritorna ID_FIRMA_REGISTRAZIONE.
    function FirmaDocumento(const Oid, IdObjectFile: Int64; const TipoDocumento: string;
      const ConApprovazioneInterna: boolean = false;
      const Firmatari: TArray<TzFirmaFirmatario> = nil): Int64;

    // le quattro azioni del ciclo, su un elenco di ID_FIRMA_REGISTRAZIONE
    procedure Approva(const Registrazioni: TList<integer>; const Etichette: TEtichetteFirma);
    procedure Respingi(const Registrazioni: TList<integer>; const Etichette: TEtichetteFirma;
      const Motivo: string = '');
    procedure Invia(const Registrazioni: TList<integer>; const Etichette: TEtichetteFirma;
      const RisolviFirmatari: TRisolutoreFirmatari = nil);
    procedure AggiornaStato(const Registrazioni: TList<integer>; const Etichette: TEtichetteFirma);
  end;

var
  DocumentazioneFirmaElettronica: TDocumentazioneFirmaElettronica;

implementation

uses
  dmCommon,      // Common.EnteDefault, ponte condiviso
  ConfigModule,  // Config.CurrentUserID
  zMsg;          // ConfirmYesNo

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TEtichetteFirma }

class function TEtichetteFirma.Crea(const Singolare, Plurale, Titolo: string): TEtichetteFirma;
begin
  result.Singolare := Singolare;
  result.Plurale := Plurale;
  result.Titolo := Titolo;
end;

{ TDocumentazioneFirmaElettronica }

procedure TDocumentazioneFirmaElettronica.DataModuleCreate(Sender: TObject);
begin
  // Qui va il TzFbDataSet delle registrazioni di firma dell'ente
  // (OBJ_FILES_FIRMA_REGISTRAZIONI per Common.EnteDefault), con il filtro
  // facoltativo su TIPO_DOCUMENTO. La griglia la aggiunge
  // frmDocumentazioneFirmaElettronica.
end;

function TDocumentazioneFirmaElettronica.Ponte: TDocumentazioneBridgeFirma;
begin
  // il ponte e' UNO solo per tutta l'applicazione: lo stesso che usa dmCommon
  // per le azioni documentali sulle anteprime. Nasce al primo utilizzo,
  // sull'ente di lavoro, e appartiene a dmCommon (vive quanto l'applicazione).
  if not Assigned(DocumentazioneBridgeFirma) then
  begin
    DocumentazioneBridgeFirma := TDocumentazioneBridgeFirma.Create(Common);
    DocumentazioneBridgeFirma.IdTenant := Common.EnteDefault;
  end;

  result := DocumentazioneBridgeFirma;
end;

function TDocumentazioneFirmaElettronica.ComponiDomanda(const Verbo: string;
  const Etichette: TEtichetteFirma; const Quante: integer): string;
begin
  if Quante = 1 then
    result := 'Si desidera ' + Verbo + ' ' + Etichette.Singolare + '?'
  else
    result := 'Si desidera ' + Verbo + ' ' + Format(Etichette.Plurale, [Quante]) + '?';
end;

procedure TDocumentazioneFirmaElettronica.EseguiSuElenco(const Registrazioni: TList<integer>;
  const Domanda: string; const Titolo: string; const Azione: TProc<integer>);
var
  idRegistrazione: integer;
begin
  if (Registrazioni = nil) or (Registrazioni.Count = 0) then
    Exit;

  if not ConfirmYesNo(Domanda) then
    Exit;

  ProgressBox.Show(Registrazioni.Count, Titolo, '', 'Attendere...');
  try
    for idRegistrazione in Registrazioni do
    begin
      ProgressBox.IncProgress(idRegistrazione.ToString);

      if ProgressBox.Cancelled then
        Exit;

      Azione(idRegistrazione);
    end;
  finally
    ProgressBox.Close;
  end;

  // il ricaricamento dei dataset NON e' qui: i dataset sono di chi chiama
end;

function TDocumentazioneFirmaElettronica.FirmaDocumento(const Oid, IdObjectFile: Int64;
  const TipoDocumento: string; const ConApprovazioneInterna: boolean;
  const Firmatari: TArray<TzFirmaFirmatario>): Int64;
var
  daFirmare: TArray<TzFirmaFirmatario>;
begin
  daFirmare := Firmatari;

  // senza firmatari espliciti si usano quelli standard dell'oggetto (Direttore,
  // Legale Rappresentante...); per i fornitori a certificato remoto la lista
  // puo' restare vuota
  if daFirmare = nil then
    daFirmare := Ponte.FirmatariStandard(Oid);

  result := Ponte.FirmaVersione(Oid, IdObjectFile, TipoDocumento, daFirmare, ConApprovazioneInterna);
end;

procedure TDocumentazioneFirmaElettronica.Approva(const Registrazioni: TList<integer>;
  const Etichette: TEtichetteFirma);
begin
  EseguiSuElenco(Registrazioni,
    ComponiDomanda('approvare', Etichette, Registrazioni.Count),
    Etichette.Titolo,
    procedure(IdFirmaRegistrazione: integer)
    begin
      Ponte.ApprovaRegistrazione(IdFirmaRegistrazione, Config.CurrentUserID.ToString);
    end);
end;

procedure TDocumentazioneFirmaElettronica.Respingi(const Registrazioni: TList<integer>;
  const Etichette: TEtichetteFirma; const Motivo: string);
begin
  EseguiSuElenco(Registrazioni,
    ComponiDomanda('respingere', Etichette, Registrazioni.Count),
    Etichette.Titolo,
    procedure(IdFirmaRegistrazione: integer)
    begin
      Ponte.RespingiRegistrazione(IdFirmaRegistrazione, Config.CurrentUserID.ToString, Motivo);
    end);
end;

procedure TDocumentazioneFirmaElettronica.Invia(const Registrazioni: TList<integer>;
  const Etichette: TEtichetteFirma; const RisolviFirmatari: TRisolutoreFirmatari);
begin
  EseguiSuElenco(Registrazioni,
    ComponiDomanda('inviare', Etichette, Registrazioni.Count),
    Etichette.Titolo,
    procedure(IdFirmaRegistrazione: integer)
    begin
      // con il risolutore i firmatari sono ricalcolati sui dati vivi e
      // viaggiano al fornitore completi di segnaposto e identificativi di
      // firma remota, che non stanno sulle righe firmatari
      if Assigned(RisolviFirmatari) then
        Ponte.InviaRegistrazioneConFirmatari(IdFirmaRegistrazione, RisolviFirmatari(IdFirmaRegistrazione))
      else
        Ponte.InviaRegistrazione(IdFirmaRegistrazione);
    end);
end;

procedure TDocumentazioneFirmaElettronica.AggiornaStato(const Registrazioni: TList<integer>;
  const Etichette: TEtichetteFirma);
var
  domanda: string;
begin
  // domanda a parte: "verificare lo stato" non si incastra con le frasi
  // singolare/plurale delle altre azioni senza storpiare l'italiano
  domanda := 'Si desidera verificare lo stato delle firme in corso?' + sLineBreak +
    Etichette.Titolo + ': ' + Registrazioni.Count.ToString;

  EseguiSuElenco(Registrazioni, domanda, Etichette.Titolo,
    procedure(IdFirmaRegistrazione: integer)
    begin
      // a busta completata il ponte fa creare al provider le versioni FIR/RIC
      // e scarica i file: non serve un passo di scaricamento separato
      Ponte.AggiornaStatoRegistrazione(IdFirmaRegistrazione);
    end);
end;

end.
