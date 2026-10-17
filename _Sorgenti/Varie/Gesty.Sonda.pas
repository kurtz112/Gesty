// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-17
// ---------------------------------------------------------------------------

// ***************************************************************************
//
// Gesty.Sonda
//
// Il ponte fra la sonda di collaudo (zPack\zLibs\Sonda.*) e Gesty.
//
// SOLO NELLE VERSIONI DI COLLAUDO. Senza la direttiva SONDA questa unit
// contiene una procedura vuota e non usa le unit della sonda: l'eseguibile
// dei clienti non contiene ne' la sonda ne' il canale di comando. Per questo
// la unit sta sempre nella uses di Gesty.dpr, senza {$IFDEF} nel .dpr, che
// l'IDE riscrive e dove le direttive si perdono.
//
// Con SONDA, AvviaSondaGesty (nel .dpr dopo Application.Initialize, prima del
// login) accende la sonda solo se il programma riceve --sonda <pipe>, e le
// insegna tre cose di Gesty:
//
//   - il menu: le azioni di ActionList e ModuliActions della form principale,
//     cercate per nome, senza dipendere da MainForm;
//   - gli indirizzi per ruolo delle form generate dal dizionario LZ:
//     "vista:<Modulo>.<Dataset>" per un TzDbView, "scheda:..." per un
//     TzDbCard, "dataset:..." per un TzFbDataSet, con il nome LZ del dataset
//     (IdDataSet, o Owner.Name + '.' + Name come TzSystem.Get_IdDataSet). Il
//     Name dei frame lo sceglie il generatore e cambia col layout; il ruolo
//     no;
//   - le eccezioni le mostra gia' TzExceptionManager (TConfig.
//     ApplicationEventsException): la sonda le registra soltanto.
//
// Analisi: D:\AI\Analisi\COLLAUDO e
// D:\AI\OUT\20261017-collaudo-autonomo-win32\.
//
// ***************************************************************************

unit Gesty.Sonda;

interface

// Accende la sonda se il programma e' compilato con SONDA e riceve --sonda;
// altrimenti non fa niente.
procedure AvviaSondaGesty;

implementation

{$IFDEF SONDA}

uses
  System.SysUtils,
  System.Classes,
  System.Actions,
  System.Generics.Collections,
  Vcl.Forms,
  Vcl.ActnList,
  Data.DB,
  zFbDataSet,
  zDbView,
  zDbCard,
  Sonda.Server,
  Sonda.Ispezione;

const
  RuoloVista = 'vista';
  RuoloScheda = 'scheda';
  RuoloDataset = 'dataset';

// Nome LZ del dataset, come TzSystem.Get_IdDataSet: IdDataSet se il dataset
// lo ha gia' caricato dal dizionario, altrimenti Owner.Name + '.' + Name.
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

function RuoloComponente(Componente: TComponent): string;
begin
  Result := '';
  if Componente is TzDbView then
  begin
    if TzDbView(Componente).zDataSet <> nil then
      Result := RuoloVista + ':' + NomeLz(TzDbView(Componente).zDataSet);
  end
  else if Componente is TzDbCard then
  begin
    if TzDbCard(Componente).zDataSet <> nil then
      Result := RuoloScheda + ':' + NomeLz(TzDbCard(Componente).zDataSet);
  end
  else if Componente is TzFbDataSet then
    Result := RuoloDataset + ':' + NomeLz(TDataSet(Componente));
end;

function CercaRuolo(Contenitore: TComponent; const Atteso: string): TComponent;
var
  Indice: Integer;
begin
  for Indice := 0 to Contenitore.ComponentCount - 1 do
  begin
    if SameText(RuoloComponente(Contenitore.Components[Indice]), Atteso) then
      Exit(Contenitore.Components[Indice]);
    Result := CercaRuolo(Contenitore.Components[Indice], Atteso);
    if Result <> nil then
      Exit;
  end;
  Result := nil;
end;

function RisolviRuolo(Contenitore: TComponent; const Ruolo, Nome: string): TComponent;
begin
  Result := CercaRuolo(Contenitore, Ruolo + ':' + Nome);
end;

procedure AggiungiAzioni(Form: TComponent; const NomeLista: string; Azioni: TList<TBasicAction>);
var
  Lista: TComponent;
  Indice: Integer;
begin
  Lista := Form.FindComponent(NomeLista);
  if Lista is TCustomActionList then
    for Indice := 0 to TCustomActionList(Lista).ActionCount - 1 do
      Azioni.Add(TCustomActionList(Lista).Actions[Indice]);
end;

// Le voci del menu di TMain: ActionList (archivi, stampe, strumenti) e
// ModuliActions (moduli, con il controllo della licenza di CheckModulo).
function MenuGesty: TArray<TBasicAction>;
var
  Azioni: TList<TBasicAction>;
begin
  Result := [];
  if Application.MainForm = nil then
    Exit;
  Azioni := TList<TBasicAction>.Create;
  try
    AggiungiAzioni(Application.MainForm, 'ActionList', Azioni);
    AggiungiAzioni(Application.MainForm, 'ModuliActions', Azioni);
    Result := Azioni.ToArray;
  finally
    Azioni.Free;
  end;
end;

{$ENDIF}

procedure AvviaSondaGesty;
begin
{$IFDEF SONDA}
  MostraEccezioniSonda := False;
  FornitoreMenuSonda :=
      function: TArray<TBasicAction>
    begin
      Result := MenuGesty;
    end;
  RisolutoreRuoloSonda := RisolviRuolo;
  DescrittoreRuoloSonda := RuoloComponente;
  AvviaSonda;
{$ENDIF}
end;

end.
