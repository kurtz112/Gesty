unit dmSIA_ServizioInclusioneAdulti;

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
  TSIA_ServizioInclusioneAdulti = class(TBaseDataModule)
    dlgCoperture: TzDbViewDlg;
  private
    interventoDATA_INIZIO_INTERVENTO, interventoDATA_FINE_INTERVENTO, interventoNUMERO_SETTIMANE, interventoNUMERO_ORE_TOTALI, interventoPIANO_UTILIZZO_ORE_SETTIMANA: TField;
    procedure Sia_InterventiDateChanged(Sender: TField);
  private
    procedure Sia_InterventiAfterPost(DataSet: TDataSet);
    procedure Sia_InterventiAfterCreateFields(DataSet: TDataSet);

    procedure Sia_Interventi_CopertureAfterDelete(DataSet: TDataSet);
    procedure Sia_Interventi_CopertureAfterPost(DataSet: TDataSet);
    procedure Sia_Interventi_CopertureNewRecord(DataSet: TDataSet);

    procedure Sia_Rendicontazioni_DestinatariNewRecord(DataSet: TDataSet);
    procedure Sia_Rendicontazioni_DestinatariAfterDelete(DataSet: TDataSet);
    procedure Sia_Rendicontazioni_DestinatariAfterPost(DataSet: TDataSet);

    procedure Sia_Interventi_RendicontazioniNewRecord(DataSet: TDataSet);

    procedure Sia_Interventi_RendicontazioniAfterPost(DataSet: TDataSet);
    procedure Sia_Interventi_RendicontazioniAfterDelete(DataSet: TDataSet);

    procedure InternalAggiornaIntervento;
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    procedure AggiungiDestinatarioEffettivo;
    procedure InterventiCoperture;
  end;

var
  SIA_ServizioInclusioneAdulti: TSIA_ServizioInclusioneAdulti;

implementation

uses
  zBaseLib,
  Gesty_StoredProcs,
  zFrmParams,
  zMsg;

{$R *.dfm}

procedure TSIA_ServizioInclusioneAdulti.Sia_Interventi_RendicontazioniAfterDelete(DataSet: TDataSet);
begin
  InternalAggiornaIntervento;
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Interventi_RendicontazioniAfterPost(DataSet: TDataSet);
begin
  InternalAggiornaIntervento;
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Interventi_RendicontazioniNewRecord(DataSet: TDataSet);
var
  rendicontazioni, interventi: TzFbDataSet;
begin
  interventi := GetDataSet('Sia_Interventi');
  rendicontazioni := GetDataSet('Sia_Interventi_Rendicontazioni');

  rendicontazioni.FieldByName('ID_INTERVENTO_SIA').Value := interventi.FieldByName('ID_INTERVENTO_SIA').Value;
  rendicontazioni.FieldByName('ID_COOPERATIVA_SIA').Value := interventi.FieldByName('ID_COOPERATIVA_SIA').Value;
end;

procedure TSIA_ServizioInclusioneAdulti.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Sia_Interventi') then
  begin
    DataSet.OnAfterCreateFields := Sia_InterventiAfterCreateFields;
    DataSet.AfterPost := Sia_InterventiAfterPost;
  end
  else
    if SameText(DataSetName, 'Sia_Interventi_Rendicontazioni') then
    begin
      DataSet.OnNewRecord := Sia_Interventi_RendicontazioniNewRecord;
      DataSet.AfterPost := Sia_Interventi_RendicontazioniAfterPost;
      DataSet.AfterDelete := Sia_Interventi_RendicontazioniAfterDelete;
    end
    else
      if SameText(DataSetName, 'Sia_Interventi_Coperture') then
      begin
        DataSet.OnNewRecord := Sia_Interventi_CopertureNewRecord;
        DataSet.AfterPost := Sia_Interventi_CopertureAfterPost;
        DataSet.AfterDelete := Sia_Interventi_CopertureAfterDelete;
      end
      else
        if SameText(DataSetName, 'Sia_Rendicontazioni_Destinatari') then
        begin
          DataSet.OnNewRecord := Sia_Rendicontazioni_DestinatariNewRecord;
          DataSet.AfterPost := Sia_Rendicontazioni_DestinatariAfterPost;
          DataSet.AfterDelete := Sia_Rendicontazioni_DestinatariAfterDelete;
        end;
end;

procedure TSIA_ServizioInclusioneAdulti.AggiungiDestinatarioEffettivo;
var
  destinatari, interventi: TzFbDataSet;
  sp: TSP_SIA_INTERVENTI_DESTINATARI_EFFETTIVI_ADD_INTESTATARIO_VOUCHER;
begin
  interventi := GetDataSet('Sia_Interventi');
  destinatari := GetDataSet('Sia_Interventi_Destinatari_Effettivi');

  if not ConfirmYesNo('Si desidera inserire l''intestatario voucher dell''intervento come destinatario effettivo?') then
    exit;

  if interventi.IsEmpty then
    exit;

  StartWait('Attendere...', true);
  try
    sp := getSP<TSP_SIA_INTERVENTI_DESTINATARI_EFFETTIVI_ADD_INTESTATARIO_VOUCHER>;
    try
      sp.ID_INTERVENTO_SIA := interventi.FieldByName('ID_INTERVENTO_SIA').Value;
      sp.ExecuteAndCommit;
    finally
      freeAndNil(sp);
    end;

    destinatari.ReOpen();
  finally
    StopWait;
  end;

  ConfirmOk('Intestatario voucher aggiunto come destinatario effettivo.');
end;

procedure TSIA_ServizioInclusioneAdulti.InternalAggiornaIntervento;
begin
  RefreshRecord('Sia_Interventi');
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Interventi_CopertureAfterDelete(DataSet: TDataSet);
begin
  RefreshRecord('Sia_Interventi', false);
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Interventi_CopertureAfterPost(DataSet: TDataSet);
begin
  RefreshRecord('Sia_Interventi', false);
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Interventi_CopertureNewRecord(DataSet: TDataSet);
var
  Intervento, Coperture: TzFbDataSet;
begin
  Intervento := GetDataSet('Sia_Interventi');
  Coperture := GetDataSet('Sia_Interventi_Coperture');

  Coperture.FieldByName('ID_INTERVENTO_SIA').Value := Intervento.FieldByName('ID_INTERVENTO_SIA').Value;
  Coperture.FieldByName('IMPORTO_COPERTURA').Value := Intervento.FieldByName('RESIDUO_DA_COPRIRE').Value;
end;

procedure TSIA_ServizioInclusioneAdulti.InterventiCoperture;
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('Sia_Interventi_Coperture');

  dlgCoperture.DataSet := DataSet;
  try
    dlgCoperture.Execute();
  finally
    dlgCoperture.DataSet := nil;
  end;

  RefreshRecord('Sia_Interventi', false);
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Rendicontazioni_DestinatariAfterDelete(DataSet: TDataSet);
begin
  RefreshRecord('Sia_Interventi_Rendicontazioni');
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Rendicontazioni_DestinatariAfterPost(DataSet: TDataSet);
begin
  RefreshRecord('Sia_Interventi_Rendicontazioni');
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Rendicontazioni_DestinatariNewRecord(DataSet: TDataSet);
var
  Intervento, rendicontazioni: TzFbDataSet;
begin
  Intervento := GetDataSet('Sia_Interventi');
  rendicontazioni := GetDataSet('Sia_Rendicontazioni');

  rendicontazioni.FieldByName('ID_INTERVENTO_SIA').Value := Intervento.FieldByName('ID_INTERVENTO_SIA').Value;
  rendicontazioni.FieldByName('ID_RENDICONTAZIONE_SIA').Value := Intervento.FieldByName('ID_RENDICONTAZIONE_SIA').Value;
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_InterventiDateChanged(Sender: TField);
begin
  // NUMERO_SETTIMANE = WeeksBetween(inizio, fine) e NUMERO_ORE_TOTALI = NUMERO_SETTIMANE × PIANO_UTILIZZO_ORE_SETTIMANA
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_InterventiAfterPost(DataSet: TDataSet);
begin
  ReopenDataSet('Sia_Interventi_Coperture');
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_InterventiAfterCreateFields(DataSet: TDataSet);
begin
  interventoDATA_INIZIO_INTERVENTO := DataSet.FieldByName('DATA_INIZIO_INTERVENTO');
  interventoDATA_FINE_INTERVENTO := DataSet.FieldByName('DATA_FINE_INTERVENTO');
  interventoNUMERO_SETTIMANE := DataSet.FieldByName('NUMERO_SETTIMANE');
  interventoNUMERO_ORE_TOTALI := DataSet.FieldByName('NUMERO_ORE_TOTALI');
  interventoPIANO_UTILIZZO_ORE_SETTIMANA := DataSet.FieldByName('PIANO_UTILIZZO_ORE_SETTIMANA');
end;

end.

