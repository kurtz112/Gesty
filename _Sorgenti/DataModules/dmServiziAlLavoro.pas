unit dmServiziAlLavoro;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  zDbViewDlg;

type
  TServiziAlLavoro = class(TBaseDataModule)
    lkServiziDlg: TzDbViewDlg;
  public
    procedure AggiungiServizi;
  end;

var
  ServiziAlLavoro: TServiziAlLavoro;

implementation

{$R *.dfm}
{ TServiziAlLavoro }

procedure TServiziAlLavoro.AggiungiServizi;
var
  Sal_Utenti_Servizi, lkServizi: TzFbDataSet;
begin
  Sal_Utenti_Servizi := getDataSet('Sal_Utenti_Servizi');
  lkServizi := getDataSet('lkServizi');

  lkServizi.RevertSQL(false);
  lkServizi.ParamByName('ID_UTENTE_SAL').AsInteger := Sal_Utenti_Servizi.ParamByName('ID_UTENTE_SAL').AsInteger;
  lkServizi.Active := true;
  try
    lkServiziDlg.DataSet := lkServizi;
    lkServiziDlg.Execute(
      procedure
      begin
        Sal_Utenti_Servizi.Append;
        Sal_Utenti_Servizi.FieldByName('DATA_SERVIZIO').AsDateTime := Date;
        Sal_Utenti_Servizi.FieldByName('SERVIZIO_SAL').AsString := lkServizi.FieldByName('SERVIZIO_SAL').AsString;
        Sal_Utenti_Servizi.Post;
      end);
  finally
    lkServizi.Active := false;
  end;
end;

end.
