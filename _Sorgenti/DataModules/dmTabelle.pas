unit dmTabelle;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Data.DB,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Base_DataModule,
  zFbDataSet,
  dbMaster,
  zBaseLib,
  zDbViewDlg;

type
  TTabelle = class(TBaseDataModule)
    lkContenutiDlg: TzDbViewDlg;
  private
  public
    procedure AggiungiContenuti;
  end;

var
  Tabelle: TTabelle;

implementation

{$R *.dfm}
{ TTabelle }

procedure TTabelle.AggiungiContenuti;
var
  Ambiti, Contenuti, lkContenuti: TzFbDataSet;
  ambito: string;
begin
  Ambiti := GetDataSet('Zz_Ambiti_Inserimento');
  if Ambiti.IsEmpty then
    exit;

  ambito := Ambiti.FieldByName('AMBITO_INSERIMENTO').AsString;

  Contenuti := GetDataSet('Zz_Ambiti_Inserimento_Contenuti');
  lkContenuti := GetDataSet('lkContenutiPerAmbiti');

  lkContenuti.RevertSQL(false);
  lkContenuti.ParamByName('AMBITO_INSERIMENTO').AsString := ambito;
  lkContenuti.active := true;
  try
    lkContenutiDlg.DataSet := lkContenuti;
    lkContenutiDlg.Execute(
      procedure
      begin
        Contenuti.Append;
        Contenuti.FieldByName('CONTENUTI').AsString := lkContenuti.FieldByName('CONTENUTI').AsString;
        Contenuti.post;
      end);
  finally
    lkContenuti.active := false;
  end;
end;

end.
