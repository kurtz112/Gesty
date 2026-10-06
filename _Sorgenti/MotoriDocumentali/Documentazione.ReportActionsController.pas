unit Documentazione.ReportActionsController;

// PROPOSTA - Mantis #90 - 2026-09-05: versione modificata per la preanalisi.
// Base: Gesty/_Sorgenti/MotoriDocumentali/Documentazione.ReportActionsController.pas
// Non sostituisce il file sorgente (di sola lettura): va confrontata e
// riportata a mano nel repository dopo revisione in RAD Studio.
//
// Modifica: TipoDocumento/TipoAllegato restano property fisse (il default
// del controller, usato quando il template non dichiara nulla), ma
// TipoDocumentoRisolto/TipoAllegatoRisolto danno la precedenza a
// Contesto.TipoDocumento/Contesto.TipoAllegato quando non sono vuoti: due
// nuovi campi del contesto (zOffice.Reports.Controller.pas), valorizzati dal
// '.json' del template tramite zOffice.Reports.JsonConfig.pas/zOffice.Reports.pas
// (chiavi "tipoDocumento"/"tipoAllegato", stessa via gia' usata da "profilo"/
// "tipologiaDocumentale"). Serve perche' il controller e' condiviso da
// Contratti e Incarichi di Massima (dmRisorse aggancia lo stesso controller
// per entrambe le griglie): un valore fisso ('CON') non puo' distinguerli,
// va dichiarato dal template caricato in anteprima, non dedotto dal nome del
// file (versione precedente, piu' fragile, abbandonata).
// Richiede le tre patch generiche a zPack descritte in 90 - ANALISI.md,
// sezione "Codice proposto — versione 2026-09-05".

// Il controller delle azioni documentali di Gesty: l'anello che collega i
// viewer di zOffice.Reports (gruppo "Documento") ai ponti applicativi.
// Un solo aggancio: ReportsManager.ActionsController := <istanza>.
//
// I quattro gate sulla base astratta:
// 1. profilo   -> AzioniDelProfilo (OBJ_FILES_PROFILO_AZIONI_GET via ponte
// Firma; il JSON del template dichiara solo "profilo" e
// "tipologiaDocumentale")
// 2. permesso  -> zSystem.Authorizhed(REPORT_AZIONE_*)
// 3. catena    -> Firma.TipiVersioneInCatena (OBJ_FILES_VERSIONI)
// 4. registrazioni -> Firma.StatoFirmaPerCatena + StatoAzioneDaRegistrazione
//
// Tutto l'accesso al database passa dai ponti Documentazione.Bridge.Firma /
// Documentazione.Bridge.Messaggi / Documentazione.Bridge.Protocollo / Documentazione.Bridge.Conservazione:
// il controller non conosce stored procedure. Azioni ESEGUIBILI: Firma, Invia
// PEC, Protocolla e Conserva (se i rispettivi ponti sono assegnati e il
// fornitore e' operativo). NB: in Gesty non esiste una numerazione di protocollo
// interna (fornitore 'NESSUNO' non operativo) e la conservazione 'NESSUNO' e' un
// no-op: protocollazione e conservazione compaiono solo con un fornitore concreto
// (un protocollo esterno / un conservatore accreditato). Firmatari della busta,
// destinatari della PEC, soggetti della protocollazione e classe documentale
// della conservazione sono dell'applicazione: il chiamante li fornisce con
// OnRichiediFirmatari / OnRichiediInvioPec / OnRichiediProtocollazione /
// OnRichiediConservazione.

interface

uses
  System.SysUtils,
  System.Classes,
  zSystem,
  zOffice.Reports.types,
  zOffice.Reports.Azioni,
  zOffice.Reports.Controller,
  zDocumentale.Firma.types,
  zDocumentale.Messaggi.types,
  zDocumentale.Protocollo.types,
  Documentazione.Bridge.Firma,
  Documentazione.Bridge.Messaggi,
  Documentazione.Bridge.Protocollo,
  Documentazione.Bridge.Conservazione;

type
  // il chiamante valorizza i firmatari (False = annullato dall'operatore)
  TzRichiediFirmatariFunc = reference to function(const Contesto: TzDocumentoContesto; out Firmatari: TArray<TzFirmaFirmatario>): Boolean;

  // il chiamante valorizza oggetto, corpo e destinatari della PEC
  // (False = annullato dall'operatore)
  TzRichiediInvioPecFunc = reference to function(const Contesto: TzDocumentoContesto; out Oggetto, Corpo: string; out Destinatari: TArray<TzMessaggioDestinatario>): Boolean;

  // il chiamante valorizza direzione, oggetto e soggetti della protocollazione
  // (False = annullato dall'operatore)
  TzRichiediProtocollazioneFunc = reference to function(const Contesto: TzDocumentoContesto; out Direzione: TzProtocolloDirezione; out Oggetto: string; out Soggetti: TArray<TzProtocolloSoggetto>): Boolean;

  // il chiamante valorizza la classe documentale della conservazione
  // (False = annullato dall'operatore). Opzionale: se non assegnato si usa
  // il nome del report.
  TzRichiediConservazioneFunc = reference to function(const Contesto: TzDocumentoContesto; out ClasseDocumentale: string): Boolean;

  TDocumentazioneReportActionsController = class(TzDocumentActionsControllerBase)
  private
    FzSystem: TzSystem;
    FFirma: TDocumentazioneBridgeFirma;
    FPec: TDocumentazioneBridgeMessaggi;
    FProtocollo: TDocumentazioneBridgeProtocollo;
    FConservazione: TDocumentazioneBridgeConservazione;
    FTipoAllegato: string;
    FTipoDocumento: string;
    FFirmaConApprovazioneInterna: Boolean;
    FOnRichiediFirmatari: TzRichiediFirmatariFunc;
    FOnRichiediInvioPec: TzRichiediInvioPecFunc;
    FOnRichiediProtocollazione: TzRichiediProtocollazioneFunc;
    FOnRichiediConservazione: TzRichiediConservazioneFunc;
  protected
    function TipiVersioneInCatena(IdObjectFile: Int64): TArray<string>; override;
    function PermessoConcesso(Azione: TzAzioneDocumento): Boolean; override;
    function StatoRegistrazione(Azione: TzAzioneDocumento; const Contesto: TzDocumentoContesto): TzAzioneDocumentoStato; override;
    // Mantis #194 - 2026-09-29: era la ridefinizione di Estremi; la base la
    // chiama tramite la cache del documento corrente
    function EstremiRegistrazione(Azione: TzAzioneDocumento; const Contesto: TzDocumentoContesto): string; override;
  public
    function AzioniDelProfilo(const Profilo: string): TzJsonAzioniConfig; override;
    function AzioniDelDocumento(const IdObjectFile: Int64): TzJsonAzioniConfig; override;
    function PersistDocument(const Contesto: TzDocumentoContesto; const TempFileName: string): Int64; override;
    procedure Esegui(Azione: TzAzioneDocumento; const Contesto: TzDocumentoContesto); override;
    procedure AggiornaStato(Azione: TzAzioneDocumento; const Contesto: TzDocumentoContesto); override;

    // TIPO_DOCUMENTO/TIPO_ALLEGATO risolti per il contesto corrente: se il
    // '.json' del template dichiara "tipoDocumento"/"tipoAllegato"
    // (Contesto.TipoDocumento/Contesto.TipoAllegato non vuoti) vincono sul
    // valore fisso TipoDocumento/TipoAllegato del controller. Serve quando
    // lo stesso controller e' condiviso da piu' tipi di documento (es.
    // Contratti e Incarichi di Massima in dmRisorse): il tipo lo dichiara il
    // template caricato in anteprima, non un valore fisso sul controller.
    function TipoDocumentoRisolto(const Contesto: TzDocumentoContesto): string;
    function TipoAllegatoRisolto(const Contesto: TzDocumentoContesto): string;

    property zSystem: TzSystem read FzSystem write FzSystem;
    property Firma: TDocumentazioneBridgeFirma read FFirma write FFirma;
    property Pec: TDocumentazioneBridgeMessaggi read FPec write FPec;
    property Protocollo: TDocumentazioneBridgeProtocollo read FProtocollo write FProtocollo;
    property Conservazione: TDocumentazioneBridgeConservazione read FConservazione write FConservazione;
    // TIPO_ALLEGATO assegnato ai documenti persistiti dai report
    property TipoAllegato: string read FTipoAllegato write FTipoAllegato;
    // TIPO_DOCUMENTO della registrazione di firma (es. 'CON' per i
    // contratti); vuoto = nome del report
    property TipoDocumento: string read FTipoDocumento write FTipoDocumento;
    // True = la registrazione nasce in stato 'I' (approvazione interna:
    // e' il flusso dei contratti, l'invio avviene poi da dmContratti);
    // False = invio immediato al fornitore
    property FirmaConApprovazioneInterna: Boolean read FFirmaConApprovazioneInterna write FFirmaConApprovazioneInterna;
    property OnRichiediFirmatari: TzRichiediFirmatariFunc read FOnRichiediFirmatari write FOnRichiediFirmatari;
    property OnRichiediInvioPec: TzRichiediInvioPecFunc read FOnRichiediInvioPec write FOnRichiediInvioPec;
    property OnRichiediProtocollazione: TzRichiediProtocollazioneFunc read FOnRichiediProtocollazione write FOnRichiediProtocollazione;
    property OnRichiediConservazione: TzRichiediConservazioneFunc read FOnRichiediConservazione write FOnRichiediConservazione;
  end;

implementation

{ TDocumentazioneReportActionsController }

function TDocumentazioneReportActionsController.AzioniDelProfilo(const Profilo: string): TzJsonAzioniConfig;
begin
  // gate 1 dal database: il ponte interroga OBJ_FILES_PROFILO_AZIONI_GET
  result.Clear;
  if assigned(FFirma) then
    result := FFirma.AzioniDelProfilo(Profilo);
end;

function TDocumentazioneReportActionsController.AzioniDelDocumento(const IdObjectFile: Int64): TzJsonAzioniConfig;
begin
  // gate 1 per i documenti gia' persistiti (viewer, registri): il ponte
  // interroga OBJ_FILES_DOCUMENTO_AZIONI_GET, che risolve il profilo dalla
  // radice della catena
  result.Clear;
  if assigned(FFirma) then
    result := FFirma.AzioniDelDocumento(IdObjectFile);
end;

function TDocumentazioneReportActionsController.TipiVersioneInCatena(IdObjectFile: Int64): TArray<string>;
begin
  // generico (OBJ_FILES_VERSIONI): lo espongono entrambi i ponti, si usa
  // quello disponibile
  result := nil;
  if assigned(FFirma) then
    result := FFirma.TipiVersioneInCatena(IdObjectFile)
  else
    if assigned(FPec) then
      result := FPec.TipiVersioneInCatena(IdObjectFile)
    else
      if assigned(FProtocollo) then
        result := FProtocollo.TipiVersioneInCatena(IdObjectFile)
      else
        if assigned(FConservazione) then
          result := FConservazione.TipiVersioneInCatena(IdObjectFile);
end;

function TDocumentazioneReportActionsController.PermessoConcesso(Azione: TzAzioneDocumento): Boolean;
begin
  result := False;

  if not assigned(FzSystem) then
    exit;

  case Azione of
    adFirma:
      result := FzSystem.Authorizhed(REPORT_AZIONE_FIRMA_PERMISSION);
    adProtocolla:
      result := FzSystem.Authorizhed(REPORT_AZIONE_PROTOCOLLA_PERMISSION);
    adConserva:
      result := FzSystem.Authorizhed(REPORT_AZIONE_CONSERVA_PERMISSION);
    adInviaPec:
      result := FzSystem.Authorizhed(REPORT_AZIONE_INVIA_PEC_PERMISSION);
    adInviaMail:
      result := FzSystem.Authorizhed(REPORT_AZIONE_INVIA_MAIL_PERMISSION);
  end;
end;

function TDocumentazioneReportActionsController.StatoRegistrazione(Azione: TzAzioneDocumento; const Contesto: TzDocumentoContesto): TzAzioneDocumentoStato;
begin
  result := adsDisponibile;

  case Azione of
    adFirma:
      begin
        // senza ponte o senza fornitore configurato la firma non compare
        if not assigned(FFirma) then
          exit(adsNonDisponibile);
        if FFirma.FornitoreAttivo.IsEmpty then
          exit(adsNonDisponibile);

        if Contesto.IdObjectFile <> 0 then
          result := StatoAzioneDaRegistrazione(adFirma, FFirma.StatoFirmaPerCatena(Contesto.IdObjectFile));
      end;

    adInviaPec:
      begin
        // senza ponte o senza casella configurata la PEC non compare
        if not assigned(FPec) then
          exit(adsNonDisponibile);
        if FPec.FornitoreAttivo.IsEmpty then
          exit(adsNonDisponibile);

        if Contesto.IdObjectFile <> 0 then
          result := StatoAzioneDaRegistrazione(adInviaPec, FPec.StatoMessaggioPerCatena(Contesto.IdObjectFile));
      end;

    adProtocolla:
      begin
        // senza ponte o senza fornitore operativo la protocollazione non compare
        if not assigned(FProtocollo) then
          exit(adsNonDisponibile);
        if FProtocollo.FornitoreAttivo.IsEmpty then
          exit(adsNonDisponibile);

        if Contesto.IdObjectFile <> 0 then
          result := StatoAzioneDaRegistrazione(adProtocolla, FProtocollo.StatoProtocolloPerCatena(Contesto.IdObjectFile));
      end;

    adConserva:
      begin
        // senza ponte o senza conservatore operativo la conservazione non compare
        if not assigned(FConservazione) then
          exit(adsNonDisponibile);
        if FConservazione.FornitoreAttivo.IsEmpty then
          exit(adsNonDisponibile);

        if Contesto.IdObjectFile <> 0 then
          result := StatoAzioneDaRegistrazione(adConserva, FConservazione.StatoConservazionePerCatena(Contesto.IdObjectFile));
      end;
  end;
end;

function TDocumentazioneReportActionsController.TipoDocumentoRisolto(const Contesto: TzDocumentoContesto): string;
begin
  // il '.json' del template ("tipoDocumento") vince sul default fisso del
  // controller: serve quando lo stesso controller e' condiviso da piu' tipi
  // di documento (es. Contratti e Incarichi di Massima in dmRisorse)
  if not Contesto.TipoDocumento.IsEmpty then
    result := Contesto.TipoDocumento
  else
    result := FTipoDocumento;
end;

function TDocumentazioneReportActionsController.TipoAllegatoRisolto(const Contesto: TzDocumentoContesto): string;
begin
  if not Contesto.TipoAllegato.IsEmpty then
    result := Contesto.TipoAllegato
  else
    result := FTipoAllegato;
end;

function TDocumentazioneReportActionsController.PersistDocument(const Contesto: TzDocumentoContesto; const TempFileName: string): Int64;
begin
  if not assigned(FFirma) then
    raise EzAzioneDocumentoBloccata.Create('Ponte Documentazione.Bridge.Firma non assegnato al controller');
  if Contesto.Oid = 0 then
    raise EzAzioneDocumentoBloccata.Create('OID non impostato: il chiamante deve usare ReportsManager.WithOid(...) prima dell''anteprima');

  // tipologia e profilo del contesto (chiavi JSON del template) finiscono
  // sulla riga OBJ_FILES: il profilo esplicito vince sul default della
  // tipologia dentro OBJ_FILES_ADD
  result := FFirma.PersistiDocumentoReport(Contesto.Oid, TipoAllegatoRisolto(Contesto), TempFileName, Contesto.ReportName, Contesto.TipologiaDocumentale, Contesto.Profilo);
end;

procedure TDocumentazioneReportActionsController.Esegui(Azione: TzAzioneDocumento; const Contesto: TzDocumentoContesto);
var
  Firmatari: TArray<TzFirmaFirmatario>;
  tipoDocumentoFirma: string;
  Destinatari: TArray<TzMessaggioDestinatario>;
  Oggetto: string;
  Corpo: string;
  Direzione: TzProtocolloDirezione;
  Soggetti: TArray<TzProtocolloSoggetto>;
  ClasseDocumentale: string;
begin
  // riverifica hard: vale anche per batch e chiamate dirette
  VerificaEseguibile(Azione, Contesto);

  case Azione of
    adFirma:
      begin
        Firmatari := nil;
        if assigned(FOnRichiediFirmatari) then
          if not FOnRichiediFirmatari(Contesto, Firmatari) then
            exit; // annullato dall'operatore

        tipoDocumentoFirma := TipoDocumentoRisolto(Contesto);
        if tipoDocumentoFirma.IsEmpty then
          tipoDocumentoFirma := Contesto.ReportName;

        FFirma.FirmaVersione(Contesto.Oid, Contesto.IdObjectFile, tipoDocumentoFirma, Firmatari, FFirmaConApprovazioneInterna);
      end;

    adInviaPec:
      begin
        // oggetto, corpo e destinatari sono dell'applicazione (nessuna
        // colonna li memorizza a priori): li fornisce il chiamante.
        // NB: si invia Contesto.IdObjectFile (il documento persistito); se
        // il template ha un "target" (es. FIR) l'invio della versione
        // specifica e' la rifinitura cross-azione ancora da fare.
        Destinatari := nil;
        Oggetto := '';
        Corpo := '';
        if not assigned(FOnRichiediInvioPec) then
          raise EzAzioneDocumentoBloccata.Create('Invio PEC non configurato: manca OnRichiediInvioPec');
        if not FOnRichiediInvioPec(Contesto, Oggetto, Corpo, Destinatari) then
          exit; // annullato dall'operatore

        FPec.InviaMessaggio(Contesto.Oid, Contesto.IdObjectFile, Oggetto, Corpo, Destinatari);
      end;

    adProtocolla:
      begin
        // direzione, oggetto e soggetti sono dell'applicazione: li fornisce il
        // chiamante (in Gesty di norma un documento in uscita)
        Direzione := pdUscita;
        Oggetto := '';
        Soggetti := nil;
        if not assigned(FOnRichiediProtocollazione) then
          raise EzAzioneDocumentoBloccata.Create('Protocollazione non configurata: manca OnRichiediProtocollazione');
        if not FOnRichiediProtocollazione(Contesto, Direzione, Oggetto, Soggetti) then
          exit; // annullato dall'operatore

        FProtocollo.ProtocollaDocumento(Contesto.Oid, Contesto.IdObjectFile, Direzione, Oggetto, Soggetti);
      end;

    adConserva:
      begin
        // la classe documentale la fornisce il chiamante (callback opzionale);
        // in mancanza si usa il TipoDocumento risolto o il nome del report
        ClasseDocumentale := TipoDocumentoRisolto(Contesto);
        if ClasseDocumentale.IsEmpty then
          ClasseDocumentale := Contesto.ReportName;
        if assigned(FOnRichiediConservazione) then
          if not FOnRichiediConservazione(Contesto, ClasseDocumentale) then
            exit; // annullato dall'operatore

        // sui documenti persistiti (viewer, registri) il nome del report
        // non esiste: la classe documentale deve arrivare da TipoDocumento
        // o dalla callback, altrimenti il conservatore riceverebbe un dato
        // vuoto
        if ClasseDocumentale.Trim.IsEmpty then
          raise EzAzioneDocumentoBloccata.Create('Classe documentale non determinabile: impostare TipoDocumento sul controller o fornire OnRichiediConservazione');

        FConservazione.ConservaDocumento(Contesto.Oid, Contesto.IdObjectFile, ClasseDocumentale);
      end;
  else
    raise EzAzioneDocumentoBloccata.CreateFmt('L''azione %s non e'' ancora attiva in questa applicazione', [DescrizioneAzioneDocumento(Azione)]);
  end;

  // lo stato del documento e' cambiato: la prossima interrogazione della UI
  // deve rileggerlo dal database
  InvalidaCacheDocumento;
end;

procedure TDocumentazioneReportActionsController.AggiornaStato(Azione: TzAzioneDocumento; const Contesto: TzDocumentoContesto);
begin
  if Contesto.IdObjectFile = 0 then
    exit;

  case Azione of
    adFirma:
      if assigned(FFirma) then
        FFirma.AggiornaStatoPerCatena(Contesto.IdObjectFile);
    adInviaPec:
      if assigned(FPec) then
        FPec.AggiornaStatoPerCatena(Contesto.IdObjectFile);
    adProtocolla:
      if assigned(FProtocollo) then
        FProtocollo.AggiornaStatoPerCatena(Contesto.IdObjectFile);
    adConserva:
      if assigned(FConservazione) then
        FConservazione.AggiornaStatoPerCatena(Contesto.IdObjectFile);
  end;

  // il polling puo' aver fatto avanzare lo stato: la UI deve rileggerlo
  InvalidaCacheDocumento;
end;

function TDocumentazioneReportActionsController.EstremiRegistrazione(Azione: TzAzioneDocumento; const Contesto: TzDocumentoContesto): string;
begin
  // Mantis #194 - 2026-09-29: chiamata dalla cache della base (Estremi), non
  // piu' a ogni OnUpdate dei bottoni
  result := '';

  if Contesto.IdObjectFile = 0 then
    exit;

  case Azione of
    adFirma:
      if assigned(FFirma) then
        result := FFirma.EstremiFirmaPerCatena(Contesto.IdObjectFile);
    adInviaPec:
      if assigned(FPec) then
        result := FPec.EstremiMessaggioPerCatena(Contesto.IdObjectFile);
    adProtocolla:
      if assigned(FProtocollo) then
        result := FProtocollo.EstremiProtocolloPerCatena(Contesto.IdObjectFile);
    adConserva:
      if assigned(FConservazione) then
        result := FConservazione.EstremiConservazionePerCatena(Contesto.IdObjectFile);
  end;
end;

end.
