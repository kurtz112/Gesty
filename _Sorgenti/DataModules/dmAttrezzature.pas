unit dmAttrezzature;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Base_DataModule,
  dbMaster,
  zFbDataSet;

type
  TAttrezzature = class(TBaseDataModule)
  private
  protected
    procedure Risorse_DotazioniAfterPost(DataSet: TDataSet);
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    procedure InviaMail;
  end;

var
  Attrezzature: TAttrezzature;

implementation

uses
  System.DateUtils, Vcl.Dialogs, zOffice, zOffice.types,  
  Gesty_StoredProcs, dmCommon, zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TAttrezzature }

procedure TAttrezzature.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
var
  Field: TField;
begin
  inherited;
  if SameText(DataSetName, 'Risorse_Dotazioni') then
    DataSet.AfterPost := Risorse_DotazioniAfterPost;
end;

procedure TAttrezzature.Risorse_DotazioniAfterPost(DataSet: TDataSet);
begin
  RefreshRecord('Attrezzature');
end;

procedure TAttrezzature.InviaMail;
var
  sp: TSP_RISORSE_DOTAZIONI_PREPARA_MAIL;
  Mail: TMail;
  DataSet: TzFbDataSet;
  idDotazione: Integer;
begin
  /// ////////////////////////////

  DataSet := GetDataSet('Risorse_Dotazioni');

  if DataSet.isEmpty then
  begin
    ConfirmOk('Nessun assegnamento da segnalare.');
    Exit;
  end;

  idDotazione := DataSet.FieldByName('ID_DOTAZIONE_RISORSA').asInteger;

  CheckSMTPServerParams;

  sp := TSP_RISORSE_DOTAZIONI_PREPARA_MAIL.Create(WriteTrans);
  try
    sp.ID_DOTAZIONE_RISORSA := idDotazione;
    sp.executeAndCommit;

    Mail.Init;
    Mail.A := sp.A;
    Mail.CC := sp.CC;
    Mail.CCN := sp.CCN;
    Mail.Oggetto := sp.Oggetto;
    Mail.CorpoTxt := sp.Corpo.Text;
  finally
    FreeAndNil(sp);
  end;

  WriteMail(Mail, SMTPServerParams, Common.GetMailRisorse);
end;

end.
