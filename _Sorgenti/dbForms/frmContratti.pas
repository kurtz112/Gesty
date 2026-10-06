unit frmContratti;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  System.Actions,
  Vcl.ActnList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  zDbView,
  BaseFrm;

type
  TFormContratti = class(TBaseForm)
    ActionList: TActionList;
    Approva: TAction;
    Respingi: TAction;
    Invia: TAction;
    AggiornaStato: TAction;
    procedure AggiornaStatoExecute(Sender: TObject);
    procedure ApprovaExecute(Sender: TObject);
    procedure InviaExecute(Sender: TObject);
    procedure RespingiExecute(Sender: TObject);
  private
    function GetSelected(const DataSetName: string): TList<Integer>;
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormContratti: TFormContratti;

implementation

uses
  zDm_Images, dmContratti, zMsg;

{$R *.dfm}

procedure TFormContratti.CreateDataModule;
begin
  inherited;
  CreateDM(TContratti, Contratti);
end;

procedure TFormContratti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Contratti);
end;

constructor TFormContratti.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'Contratti';
  Caption := 'Contratti';
end;

procedure TFormContratti.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'ContrattiDaApprovare') then
    // begin
      // view.AddAction(Approva, zDmImages.ImageList16);
      // view.AddAction(Respingi, zDmImages.ImageList16);
      // view.InitToolActions;
    // end
    // else
      // if SameText(DataSetName, 'ContrattiDaInviare') then
      // begin
        // view.AddAction(Invia, zDmImages.ImageList16);
        // view.InitToolActions;
      // end
      // else
        // if SameText(DataSetName, 'ElencoContratti') then
        // begin
          // view.AddAction(AggiornaStato, zDmImages.ImageList16);
          // view.InitToolActions;
        // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

function TFormContratti.GetSelected(const DataSetName: string): TList<Integer>;
var
  view: TzDbView;
begin
  view := GetView(DataSetName);

  result := TList<Integer>.Create;

  view.GetSelectedRows('ID_FIRMA_REGISTRAZIONE', result);

  if result.Count = 0 then
  begin
    ConfirmOk('Nessun contratto selezionato.');
    FreeAndNil(result);
  end;
end;

procedure TFormContratti.ApprovaExecute(Sender: TObject);
var
  lista: TList<Integer>;
begin
  inherited;

  lista := GetSelected('ContrattiDaApprovare');

  if assigned(lista) then
    Contratti.Approva(lista);
end;

procedure TFormContratti.RespingiExecute(Sender: TObject);
var
  lista: TList<Integer>;
begin
  inherited;

  lista := GetSelected('ContrattiDaApprovare');

  if assigned(lista) then
    Contratti.Respingi(lista);
end;

procedure TFormContratti.InviaExecute(Sender: TObject);
var
  lista: TList<Integer>;
begin
  inherited;

  lista := GetSelected('ContrattiDaInviare');

  if assigned(lista) then
    Contratti.Invia(lista);
end;

procedure TFormContratti.AggiornaStatoExecute(Sender: TObject);
begin
  inherited;
  Contratti.AggiornaStato;
end;

end.
