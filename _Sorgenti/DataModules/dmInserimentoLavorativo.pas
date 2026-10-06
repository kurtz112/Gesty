unit dmInserimentoLavorativo;

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
  zDbViewDlg;

type
  TInserimentoLavorativo = class(TBaseDataModule)
    dlgProfili: TzDbViewDlg;
    lkProfili: TzFbDataSet;
  private
    function RichiestaCorrente: Integer;
  public
    procedure RicercaProfili;
    function ProponiProfiloCorrente: boolean;
  end;

var
  InserimentoLavorativo: TInserimentoLavorativo;

implementation

uses
  frmRicercaProfili;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TInserimentoLavorativo }

function TInserimentoLavorativo.RichiestaCorrente: Integer;
var
  richieste: TzFbDataSet;
begin
  Result := -1;

  richieste := GetDataSet('Richieste_Personale');

  richieste.CheckBrowseMode;

  if not richieste.IsEmpty then
    Result := richieste.FieldByName('ID_RICHIESTA_PERSONALE').asInteger;
end;

function TInserimentoLavorativo.ProponiProfiloCorrente: boolean;
var
  profili, candidati: TzFbDataSet;
begin
  // TODO Implementare
  Result := false;

  profili := GetDataSet('Richieste_Pers_Profili');

  if profili.IsEmpty then
    Exit;

  candidati := GetDataSet('Richieste_Pers_Candidature');

  candidati.Append;
  candidati.FieldByName('ID_PROFILO').asInteger := profili.FieldByName('ID_PROFILO').asInteger;
  Result := True;
end;

procedure TInserimentoLavorativo.RicercaProfili;
var
  idRichiesta: Integer;
  profili, richieste: TzFbDataSet;
begin
  idRichiesta := RichiestaCorrente;
  if idRichiesta = -1 then
    Exit;

  profili := GetDataSet('Richieste_Pers_Profili');

  lkProfili.RevertSQL(false);
  lkProfili.ParamByName('ID_RICHIESTA_PERSONALE').asInteger := RichiestaCorrente;
  lkProfili.Active := True;
  try
    dlgProfili.Execute(
      procedure
      begin
        profili.Append;
        profili.FieldByName('ID_PROFILO').asInteger := lkProfili.FieldByName('ID_ANAGRAFICA').asInteger;
        profili.Post;
      end);
  finally
    lkProfili.Active := false;
  end;

  profili.ReOpen();
end;

end.
