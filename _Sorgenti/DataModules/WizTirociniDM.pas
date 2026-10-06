unit WizTirociniDM;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
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
  zDbViewDlg;

type
  TWizTirocini = class(TBaseDataModule)
    dlgStudentiStage: TzDbViewDlg;
    lkStudentiStage: TzFbDataSet;
  private
  public
    procedure AggiungiStudentiStage;
    function NuovaAziendaOspitante: integer;
  end;

var
  WizTirocini: TWizTirocini;

implementation

uses
  Gesty_StoredProcs, WizNuovaAziendaOspitanteFrm, zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TWizTirocini.AggiungiStudentiStage;
var
  idProgettoFormativo: integer;
  Id_Azienda_Ospitante: integer;
  Progetti_Formativi, Aziende_Ospitanti, Studenti: TzFbDataSet;
  sp: TSP_PROGETTI_FORMATIVI_ADD_STUDENTE;
begin
  Progetti_Formativi := GetDataSet('Progetti_Formativi');
  Aziende_Ospitanti := GetDataSet('Progetti_Formativi_Aziende');

  if not Assigned(Progetti_Formativi) or Progetti_Formativi.IsEmpty then
    exit;

  if not Assigned(Aziende_Ospitanti) or Aziende_Ospitanti.IsEmpty then
    exit;

  idProgettoFormativo := Progetti_Formativi.FieldByName('ID_PROGETTO_FORMATIVO').AsInteger;
  Id_Azienda_Ospitante := Aziende_Ospitanti.FieldByName('ID_AZIENDA_OSPITANTE').AsInteger;

  sp := TSP_PROGETTI_FORMATIVI_ADD_STUDENTE.Create(WriteTrans);
  try
    lkStudentiStage.RevertSQL(False);
    lkStudentiStage.ParamByName('ID_PROGETTO_FORMATIVO').AsInteger := idProgettoFormativo;
    lkStudentiStage.ParamByName('ID_AZIENDA_OSPITANTE').AsInteger := Id_Azienda_Ospitante;

    lkStudentiStage.Active := True;
    try
      dlgStudentiStage.Execute(
        procedure
        begin
          sp.Id_Progetto_Formativo := idProgettoFormativo;
          sp.Id_Azienda_Ospitante := Id_Azienda_Ospitante;
          sp.Id_Studente := lkStudentiStage.FieldByName('ID_STUDENTE').AsInteger;
          sp.ExecuteAndCommit;
        end)
    finally
      lkStudentiStage.Active := False;
    end;

  finally
    FreeAndNil(sp);
  end;

  Studenti := GetDataSet('Studenti_Stage');
  if Assigned(Studenti) then
    Studenti.Reopen(True);
end;

function TWizTirocini.NuovaAziendaOspitante: integer;
var
  DataSet: TzFbDataSet;
begin
  Result := -1;

  DataSet := GetDataSet('Progetti_Formativi');
  if DataSet.IsEmpty then
  begin
    ConfirmOk('Nessun progetto formativo selezionato.');
    exit;
  end;

  Result := InserisciNuovaAziendaOspitante;

  if Result <> -1 then
  begin
    DataSet := GetDataSet('Progetti_Formativi_Aziende');
    DataSet.Append;
    DataSet.FieldByName('ID_AZIENDA_OSPITANTE').AsInteger := Result;
  end;
end;

end.
