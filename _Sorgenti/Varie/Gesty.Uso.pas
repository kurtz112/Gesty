// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-18
// ---------------------------------------------------------------------------

// ***************************************************************************
//
// Gesty.Uso
//
// Il ponte fra il registro delle azioni eseguite (zPack\zLibs\Utilizzo.Funzioni)
// e Gesty: dice come descrivere un'azione e dove scrivere i conteggi.
//
//   - Modulo: la voce del menu dei moduli (lista ModuliActions della finestra
//     principale), solo per l'azione che apre il modulo.
//   - Funzione: la classe della form o del frame che possiede la lista di
//     azioni; per le viste e le schede generate dal dizionario LZ, il ruolo
//     con il nome LZ del dataset ("vista:<Modulo>.<Dataset>"), perche' la
//     classe sarebbe sempre TzDbView.
//   - Scrittura: USR_UTILIZZI_FUNZIONI_REGISTRA, con una transazione propria.
//     Non si usa Config.DefaultWriteTrans: un commit li' chiuderebbe anche il
//     lavoro non ancora confermato di chi la sta usando. L'utente non viene
//     passato: lo legge la procedura da CURRENT_USER_ID().
//
// Si accende alla creazione della finestra principale, cioe' dopo il login: le
// azioni della finestra di accesso non appartengono a nessun utente. I conteggi
// si scrivono ogni cinque minuti e alla chiusura della finestra principale.
//
// Analisi: D:\AI\OUT\20261018-funzionalita-piu-usate-e-collaudo\
//
// ***************************************************************************

unit Gesty.Uso;

interface

// Accende il registro delle azioni. Da chiamare dopo il login.
procedure AvviaUsoGesty;

// Scrive subito i conteggi in sospeso (chiusura della finestra principale).
procedure ScriviUsoGesty;

// Spegne il registro; scrive prima quel che e' rimasto.
procedure FermaUsoGesty;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.Actions,
  Vcl.ActnList,
  Data.DB,
  FireDAC.Stan.Option,
  SmartInspect.Vcl.SiAuto,
  zFbDataSet,
  zDbView,
  zDbCard,
  zBaseLib,
  ConfigModule,
  Gesty_StoredProcs,
  Utilizzo.Funzioni;

const
  NomeApplicazione = 'GESTY';
  NomeListaModuli = 'ModuliActions';
  // Lunghezze delle colonne di USR_UTILIZZI_FUNZIONI: un testo piu lungo farebbe
  // fallire la scrittura di tutto il blocco.
  LunghezzaVersione = 50;
  LunghezzaModulo = 50;
  LunghezzaFunzione = 100;
  LunghezzaAzione = 50;

var
  Registro: TRegistroUtilizzi = nil;
  Transazione: TzFbTransaction = nil;
  ErroreSegnalato: Boolean = False;

// Nome LZ del dataset, come TzSystem.Get_IdDataSet: IdDataSet se il dataset lo
// ha gia' caricato dal dizionario, altrimenti Owner.Name + '.' + Name.
function NomeLz(DataSet: TDataSet): string;
begin
  Result := '';
  if DataSet = nil then
    Exit;
  if DataSet is TzFbDataSet then
    Result := TzFbDataSet(DataSet).IdDataSet;
  if (Result = '') and (DataSet.Owner <> nil) then
    Result := DataSet.Owner.Name + '.' + DataSet.Name;
end;

function NomeFunzione(Proprietario: TComponent): string;
begin
  Result := Proprietario.ClassName;
  if (Proprietario is TzDbView) and (TzDbView(Proprietario).zDataSet <> nil) then
    Result := 'vista:' + NomeLz(TzDbView(Proprietario).zDataSet)
  else if (Proprietario is TzDbCard) and (TzDbCard(Proprietario).zDataSet <> nil) then
    Result := 'scheda:' + NomeLz(TzDbCard(Proprietario).zDataSet);
end;

procedure DescriviAzione(Azione: TBasicAction; var Modulo, Funzione: string; var Registrare: Boolean);
var
  Contenuta: TContainedAction;
begin
  Registrare := False;
  if not(Azione is TContainedAction) then
    Exit;

  Contenuta := TContainedAction(Azione);
  // Un'azione fuori da ogni lista non ha una funzione a cui appartenere.
  if (Contenuta.ActionList = nil) or (Contenuta.ActionList.Owner = nil) then
    Exit;

  Funzione := Copy(NomeFunzione(Contenuta.ActionList.Owner), 1, LunghezzaFunzione);
  if SameText(Contenuta.ActionList.Name, NomeListaModuli) then
    Modulo := Copy(Contenuta.Name, 1, LunghezzaModulo);
  Registrare := True;
end;

procedure ScriviUtilizzo(const Utilizzo: TUtilizzoFunzione);
var
  Procedura: TSP_USR_UTILIZZI_FUNZIONI_REGISTRA;
begin
  // Prima del primo uso e dopo una perdita di connessione la transazione non
  // sa su quale connessione lavora.
  Transazione.Connection := Config.Database;

  Procedura := TSP_USR_UTILIZZI_FUNZIONI_REGISTRA.Create(Transazione);
  try
    Procedura.APP := NomeApplicazione;
    Procedura.VERSIONE := Copy(GetFileVersion, 1, LunghezzaVersione);
    Procedura.DATA_ORA := Utilizzo.Ora;
    Procedura.MODULO := Utilizzo.Modulo;
    Procedura.FUNZIONE := Utilizzo.Funzione;
    Procedura.AZIONE := Copy(Utilizzo.Azione, 1, LunghezzaAzione);
    Procedura.ESECUZIONI := Int64(Utilizzo.Esecuzioni);
    Procedura.ULTIMA_ESECUZIONE := Utilizzo.UltimaEsecuzione;
    try
      Procedura.ExecuteAndCommit;
    except
      on E: Exception do
      begin
        // Un database non ancora aggiornato fallirebbe a ogni scrittura: si
        // annota una volta sola. Il conteggio resta in memoria (il registro lo
        // rimette in coda) e non disturba l'operatore.
        if not ErroreSegnalato then
        begin
          ErroreSegnalato := True;
          siMain.LogException(E);
        end;
        raise;
      end;
    end;
  finally
    FreeAndNil(Procedura);
  end;
end;

procedure AvviaUsoGesty;
begin
  if Registro <> nil then
    Exit;

  Transazione := TzFbTransaction.Create(nil);
  Transazione.Options.Isolation := xiReadCommitted;
  Transazione.Connection := Config.Database;

  Registro := TRegistroUtilizzi.Create(DescriviAzione, ScriviUtilizzo);
end;

procedure ScriviUsoGesty;
begin
  if Registro <> nil then
    Registro.Scrivi;
end;

procedure FermaUsoGesty;
begin
  if Registro = nil then
    Exit;

  Registro.Scrivi;
  FreeAndNil(Registro);
  FreeAndNil(Transazione);
end;

end.
