unit dmContratti;

// COPIA MODIFICATA (svuotamento sul motore generico).
// Il ciclo di firma - conferma, barra di avanzamento, annullo, giro
// sull'elenco - non sta piu' qui: e' in dmDocumentazioneFirmaElettronica,
// uguale per qualunque oggetto. Le quattro azioni restano con lo stesso nome
// e la stessa firma, quindi frmContratti NON cambia di una riga.
//
// Cosa resta qui, perche' e' dei contratti e solo loro:
//   - le tre code (ContrattiDaApprovare, ContrattiDaInviare, ElencoContratti)
//     e quali ricaricare dopo un'azione;
//   - i tre firmatari (CaricaFirmatari), risolti sui dati vivi al momento
//     dell'invio: Direttore e Legale Rappresentante da firma remota, Docente
//     via OTP dal dettaglio del contratto;
//   - le etichette dei messaggi ("il contratto selezionato").
//
// Il ponte Documentazione.Bridge.Firma non viene piu' chiamato direttamente:
// ci parla il motore. Restano validi i comportamenti gia' acquisiti -
// doScaricaFileFirmati non esiste (firmato e audit arrivano con
// l'aggiornamento di stato), la configurazione della busta la legge il
// provider, gli errori li registra il ponte.
//
// Dataset: 'ElencoContratti' e 'ContrattiDaVerificare' vanno ripuntati alle
// nuove SQL (vista OBJ_FILES_FIRMA_CONTRATTI_ELENCO, SEZIONE 4 dello script
// 06). 'DocumentiDaScaricare' e' obsoleto e va eliminato.

interface

uses
  WinApi.Windows, WinApi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Generics.Collections, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Data.DB, Base_DataModule, dbMaster,
  zDocumentale.Firma.Types, dmDocumentazioneFirmaElettronica;

type
  TContratti = class(TBaseDataModule)
  private
    FMotoreFirma: TDocumentazioneFirmaElettronica;
    function MotoreFirma: TDocumentazioneFirmaElettronica;
    function Etichette: TEtichetteFirma;
    function RegistrazioniDaVerificare: TList<Integer>;
    function CaricaFirmatari(IdFirmaRegistrazione: Integer): TArray<TzFirmaFirmatario>;
  public
    procedure Approva(contratti: TList<Integer>);
    procedure Respingi(contratti: TList<Integer>);
    procedure Invia(contratti: TList<Integer>);
    procedure AggiornaStato;
  end;

var
  contratti: TContratti;

implementation

uses
  Gesty_StoredProcs, zFbDataSet;

{$R *.dfm}

{ TContratti }

function TContratti.MotoreFirma: TDocumentazioneFirmaElettronica;
begin
  // il motore puo' non essere aperto: la griglia generica di firma e' un'altra
  // postazione e l'operatore contratti non la apre. Se manca lo si crea qui,
  // di proprieta' di questo DataModule (muore con lui). Non si tocca la
  // variabile globale DocumentazioneFirmaElettronica: quella appartiene alla
  // sua form, e liberarla da qui la lascerebbe appesa.
  if not Assigned(FMotoreFirma) then
    FMotoreFirma := TDocumentazioneFirmaElettronica.Create(Self);

  result := FMotoreFirma;
end;

function TContratti.Etichette: TEtichetteFirma;
begin
  result := TEtichetteFirma.Crea('il contratto selezionato',
    'i %d contratti selezionati', 'Contratti');
end;

procedure TContratti.Approva(contratti: TList<Integer>);
begin
  MotoreFirma.Approva(contratti, Etichette);
  RefreshDataSets;
end;

procedure TContratti.Respingi(contratti: TList<Integer>);
begin
  MotoreFirma.Respingi(contratti, Etichette);
  RefreshDataSets;
end;

procedure TContratti.Invia(contratti: TList<Integer>);
begin
  // i firmatari NON salgono nel motore: sono la parte di dominio dei contratti
  MotoreFirma.Invia(contratti, Etichette,
    function(IdFirmaRegistrazione: Integer): TArray<TzFirmaFirmatario>
    begin
      result := CaricaFirmatari(IdFirmaRegistrazione);
    end);

  RefreshDataSets;
end;

procedure TContratti.AggiornaStato;
var
  daVerificare: TList<Integer>;
begin
  // quali registrazioni interrogare lo dice il dataset dei contratti: il
  // motore riceve gia' l'elenco degli identificativi
  daVerificare := RegistrazioniDaVerificare;
  try
    MotoreFirma.AggiornaStato(daVerificare, Etichette);
  finally
    FreeAndNil(daVerificare);
  end;

  RefreshDataSet('ElencoContratti');
  RefreshDataSet('ElencoContrattiAllegati');
end;

function TContratti.RegistrazioniDaVerificare: TList<Integer>;
var
  contrattiDaVerificare: TzFbDataSet;
begin
  // l'elenco si legge tutto prima di partire: il cursore non resta aperto
  // durante le chiamate al fornitore, che sono lente
  result := TList<Integer>.Create;
  try
    contrattiDaVerificare := getDataSet('ContrattiDaVerificare');

    contrattiDaVerificare.Active := true;
    try
      contrattiDaVerificare.First;
      while not contrattiDaVerificare.eof do
      begin
        result.Add(contrattiDaVerificare.FieldByName('ID_FIRMA_REGISTRAZIONE').asInteger);
        contrattiDaVerificare.Next;
      end;
    finally
      contrattiDaVerificare.Active := false;
    end;
  except
    on e: exception do
    begin
      result.free;
      raise;
    end;
  end;
end;

function TContratti.CaricaFirmatari(IdFirmaRegistrazione: Integer): TArray<TzFirmaFirmatario>;
var
  sp: TSP_OBJ_FILES_FIRMA_CONTRATTI_FIRMATARI;
  firmatario: TzFirmaFirmatario;
begin
  // firmatari risolti dai dati vivi al momento dell'invio (la SP valida
  // anche lo stato della pratica: deve essere approvata)
  result := nil;

  sp := GetSP<TSP_OBJ_FILES_FIRMA_CONTRATTI_FIRMATARI>();
  try
    sp.Id_Firma_Registrazione := IdFirmaRegistrazione;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    sp.Open;
    while not sp.EOF do
    begin
      firmatario.Clear;
      firmatario.Ruolo := sp.Ruolo;
      firmatario.Cognome := sp.Cognome;
      firmatario.Nome := sp.Nome;
      firmatario.Email := sp.Email;
      firmatario.Telefono := sp.Telefono;
      firmatario.Placeholder := sp.Placeholder;
      firmatario.IdentificativoFirmaRemota := sp.Identificativo_Esterno;
      result := result + [firmatario];
      sp.Next;
    end;
  finally
    sp.Close;
    FreeAndNil(sp);
  end;
end;

end.
