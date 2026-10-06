unit dmGestioneUtenti;

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
  zFbDataSet,
  dbMaster,
  Base_DataModule,
  zDbViewDlg,
  MainForm;

type
  TGestioneUtenti = class(TBaseDataModule)
    ClonaUtenteDlg: TzDbViewDlg;
    lkClonaUtente: TzFbDataSet;
    dlgUtenti: TzDbViewDlg;
  private
  public
    procedure ClonaUtente;
    function ImpersonaUtenteSelezionato: Boolean;
    procedure RicaricaImpostazioniUtente;
  public
    procedure AggiungiUtenti;
  public
    procedure InizializzaSettings;
    procedure InizializzaAutorizzazioni;
    procedure InizializzaHyperLinks;
    procedure InizializzaNotifiche;
  public
    procedure CreaUtenteDominio;
  end;

var
  GestioneUtenti: TGestioneUtenti;

implementation

uses
  ConfigModule, zsystem, Gesty_StoredProcs, zBaseLib, zHyperLinks, dmCommon,
  zMsg;
{$R *.dfm}

function TGestioneUtenti.ImpersonaUtenteSelezionato: Boolean;
var
  DataSet: TzFbDataSet;
  sp: TSP_usr_Impersona_Utente;
  UserName: string;
begin
  result := False;

  DataSet := getDataset('Usr_Utenti');

  if not assigned(DataSet) then
    exit;

  if DataSet.IsEmpty then
    exit;

  UserName := DataSet.FieldByName('USER_NAME').AsString;

  if not ConfirmYesNo('Si desidera impersonare l''utente ' + UserName + '?') then
    exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_usr_Impersona_Utente.Create(WriteTrans);
    try
      sp.User_Name := UserName;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    Config.ResetAdmin;
    Main.AfterLogin;
    result := true;
  finally
    StopWait;
  end;
end;

procedure TGestioneUtenti.InizializzaAutorizzazioni;
var
  sp: TSP_usr_Authorizations_Init;
begin
  sp := TSP_usr_Authorizations_Init.Create(WriteTrans);
  try
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  RefreshDataSets;

  ConfirmOk('Tabella usr_Authorizations inizializzata.');
end;

procedure TGestioneUtenti.InizializzaSettings;
var
  sp: TSP_usr_Settings_Init;
begin
  sp := TSP_usr_Settings_Init.Create(WriteTrans);
  try
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  RefreshDataSets;

  ConfirmOk('Tabella usr_Settings inizializzata.');
end;

procedure TGestioneUtenti.RicaricaImpostazioniUtente;
begin
  Config.RicaricaImpostazioni;
  RefreshDataSets;
end;

procedure TGestioneUtenti.ClonaUtente;
var
  DataSet: TzFbDataSet;
  sp: TSP_usr_Utenti_Clona;
  User_Id_Dest: Integer;
  User_Id_Src: Integer;
begin
  DataSet := getDataset('Usr_Utenti');

  if not assigned(DataSet) then
    exit;

  User_Id_Dest := DataSet.FieldByName('USER_ID').asInteger;

  User_Id_Src := -1;

  lkClonaUtente.RevertSQL(False);
  lkClonaUtente.ParamByName('USER_ID').asInteger := User_Id_Dest;
  lkClonaUtente.Active := true;
  try
    if ClonaUtenteDlg.Execute then
      User_Id_Src := lkClonaUtente.FieldByName('USER_ID').asInteger;
  finally
    lkClonaUtente.Active := False;
  end;

  if User_Id_Src = -1 then
    exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_usr_Utenti_Clona.Create(WriteTrans);
    try
      sp.User_Id_Src := User_Id_Src;
      sp.User_Id_Dest := User_Id_Dest;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSets;
  finally
    StopWait;
  end;

  ConfirmOk('Impostazioni utente copiate.');
end;

procedure TGestioneUtenti.InizializzaHyperLinks;
var
  s: string;
  StringList: TStrings;
  sp: TSP_usr_Hyperlinks_Add;
begin

  StringList := TStringList.Create;
  try
    HyperLinks.EnumHyperlinks(StringList);

    sp := TSP_usr_Hyperlinks_Add.Create(WriteTrans);
    try
      for s in StringList do
      begin
        sp.Hyperlink := s;
        sp.ExecuteAndCommit;
      end;
    finally
      FreeAndNil(sp);
    end;
  finally
    FreeAndNil(StringList);
  end;

  RefreshDataSets;

  ConfirmOk('Tabella usr_Hyperlinks inizializzata.');
end;

procedure TGestioneUtenti.AggiungiUtenti;
var
  Gruppi, GruppiUtenti, lkUtenti: TzFbDataSet;
begin

  Gruppi := getDataset('Usr_Gruppi');

  if Gruppi.IsEmpty then
    exit;

  GruppiUtenti := getDataset('Gruppi_Utenti');
  lkUtenti := getDataset('lkUtenti');

  lkUtenti.RevertSQL(False);
  lkUtenti.ParamByName('GRUPPO').AsString := Gruppi.FieldByName('GRUPPO').AsString;
  lkUtenti.Active := true;
  try
    dlgUtenti.DataSet := lkUtenti;
    if dlgUtenti.Execute(
      procedure
      begin
        GruppiUtenti.Append;
        GruppiUtenti.FieldByName('GRUPPO').AsString := Gruppi.FieldByName('GRUPPO').AsString;
        GruppiUtenti.FieldByName('USER_ID').asInteger := lkUtenti.FieldByName('USER_ID').asInteger;
        try
          GruppiUtenti.Post;
        except
          GruppiUtenti.Cancel;
        end;
      end) then
      GruppiUtenti.ReOpen();
  finally
    lkUtenti.Active := False;
  end;
end;

procedure TGestioneUtenti.InizializzaNotifiche;
var
  sp: TSP_ZZ_NOTIFICHE_INIT;
begin
  sp := TSP_ZZ_NOTIFICHE_INIT.Create(WriteTrans);
  try
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  RefreshDataSets;

  ConfirmOk('Tabella zz_Notifiche inizializzata.');
end;

procedure TGestioneUtenti.CreaUtenteDominio;
var
  utenti: TzFbDataSet;
  UserName: string;
  idAnagrafica: Integer;
begin
  utenti := getDataset('Usr_Utenti');

  if utenti.IsEmpty then
    exit;

  if utenti.FieldByName('').IsNull then
  begin
    ConfirmOk('Id Anagrafica non valorizzato.');
    exit;
  end;

  idAnagrafica := utenti.FieldByName('ID_ANAGRAFICA').asInteger;
  UserName := utenti.FieldByName('USER_NAME').AsString;

  Common.CreaUtenteDominio(UserName, idAnagrafica, true);
end;

end.
