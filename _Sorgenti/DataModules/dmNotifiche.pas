unit dmNotifiche;

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
  zDbCardDlg;

type
  TNotifiche = class(TBaseDataModule)
    dlgAssegnaTicket: TzDbCardDlg;
  private
    procedure NotificheInviateNewRecord(DataSet: TDataSet);
    procedure Front_Office_ContattiAfterCreateFields(DataSet: TDataSet);
    procedure Front_Office_ContattiAfterCreateFieldsDATA_RISPOSTAChanged(Sender: TField);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    procedure AssegnaTicket;
    procedure SegnaComeLetto;
  end;

var
  Notifiche: TNotifiche;

implementation

uses
  ConfigModule,
  Gesty_StoredProcs,
  dmCommon;

{$R *.dfm}
{ TNotifiche }

procedure TNotifiche.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'NotificheInviate') then
    DataSet.OnNewRecord := NotificheInviateNewRecord
  else
    if SameText(DataSetName, 'Front_Office_Contatti') then
      DataSet.OnNewRecord := Front_Office_ContattiAfterCreateFields;
end;

procedure TNotifiche.NotificheInviateNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('NOTIFICA').AsString := 'NOTIFICA_GENERICA';
  DataSet.FieldByName('OGGETTO').Clear;
  DataSet.FieldByName('USER_ID_MITTENTE').AsInteger := Config.ExecIntFunc('CURRENT_USER_ID');
end;

procedure TNotifiche.SegnaComeLetto;
var
  sp: TSP_NOTIFICHE_SEGNA_TUTTE_COME_LETTA;
begin
  sp := TSP_NOTIFICHE_SEGNA_TUTTE_COME_LETTA.Create(WriteTrans);
  try
    sp.executeAndCommit;
  finally
    FreeAndNil(sp);
  end;

  Config.NotificheLette;
  RefreshDataSet('NoficheRicevute');
end;

procedure TNotifiche.AssegnaTicket;
var
  DataSet: TzFbDataSet;
  idContatto: integer;
begin
  DataSet := GetDataSet('Front_Office_Contatti');

  if DataSet.IsEmpty then
    exit;

  idContatto := DataSet.FieldByName('ID_CONTATTO_FRONT_OFFICE').AsInteger;

  DataSet.Append;
  DataSet.FieldByName('ID_CONTATTO_FRONT_OFFICE').Value := idContatto;
  DataSet.FieldByName('ID_OPERATORE_SEGNALATORE').Value := Common.CurrentIdRisorsa;
  DataSet.FieldByName('DATA_ORA_ASSEGNAZIONE').AsDateTime := Now;

  dlgAssegnaTicket.DataSet := DataSet;

  if dlgAssegnaTicket.Execute then
    ReopenDataSet('Front_Office_Contatti');
end;

procedure TNotifiche.Front_Office_ContattiAfterCreateFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('DATA_RISPOSTA').OnChange := Front_Office_ContattiAfterCreateFieldsDATA_RISPOSTAChanged;
end;

procedure TNotifiche.Front_Office_ContattiAfterCreateFieldsDATA_RISPOSTAChanged(Sender: TField);
var
  DataSet: TzFbDataSet;
begin
  DataSet := Sender.DataSet as TzFbDataSet;
  DataSet.SetFieldValue('FORNITA_RISPOSTA', not Sender.IsNull);
end;

end.

  Notifiche.Front_Office_Contatti
