unit frmNotifiche;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.ActnList,
  Data.DB,
  dxBar,
  dxBarExtItems,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxLabel,
  zDbView,
  BaseFrm,
  dxUIAClasses;

type
  TFormNotifiche = class(TBaseForm)
    TimerSegnaComeLetta: TTimer;
    ActionList: TActionList;
    RiassegnaTicket: TAction;
    procedure RiassegnaTicketExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerSegnaComeLettaTimer(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure SetPK(const Value: Variant); override;

    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormNotifiche: TFormNotifiche;

implementation

uses
  zDm_Images,
  dmNotifiche,
  zHyperLinks,
  cxFilter;

{$R *.dfm}

procedure TFormNotifiche.CreateDataModule;
begin
  inherited;
  CreateDM(TNotifiche, Notifiche);
end;

procedure TFormNotifiche.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Notifiche);
end;

constructor TFormNotifiche.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'Notifiche';
  Caption := 'Notifiche';
end;

procedure TFormNotifiche.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
// begin
// inherited;
//
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'Front_Office_Contatti') then
// begin
// view.AddAction(RiassegnaTicket, zDmImages.ImageList16);
// view.InitToolActions;
// Tools.AddFiltroPickList('FRONT_OFFICE_STATO_RISPOSTA', view, Notifiche.GetDataSet(DataSetName), 'STATO_RISPOSTA', 'Stato Risposta', 'stato risposta', 'A', True, 'Tutti', 150);
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormNotifiche.FormShow(Sender: TObject);
begin
  inherited;
  Refresh;
  TimerSegnaComeLetta.Enabled := false;
  TimerSegnaComeLetta.Enabled := True;
end;

procedure TFormNotifiche.TimerSegnaComeLettaTimer(Sender: TObject);
begin
  inherited;
  TimerSegnaComeLetta.Enabled := false;
  Notifiche.SegnaComeLetto;
end;

procedure TFormNotifiche.RiassegnaTicketExecute(Sender: TObject);
begin
  inherited;
  Notifiche.AssegnaTicket;
end;

procedure TFormNotifiche.SetPK(const Value: Variant);
var
  view: TzDbView;
begin
  inherited;

  if SameText(PkField, 'ID_NOTIFICA') then
  begin
    view := getView('NoficheRicevute'); // nome dataset/vista da confermare, vedi nota
    if Assigned(view) then
    begin
      view.ClearFilter(false);
      view.AddFilterCondition(PkField, foEqual, Value);
    end;
  end
  else
    if SameText(PkField, 'TICKET') then
    begin
      view := getView('Front_Office_Contatti'); // nome dataset/vista da confermare, vedi nota
      if Assigned(view) then
      begin
        view.ClearFilter(false);
        view.AddFilterCondition('ID_CONTATTO_FRONT_OFFICE_TICKET', foEqual, Value);
      end;
    end;
end;

initialization

HyperLinks.RegisterHandler('ID_NOTIFICA', TFormNotifiche);
HyperLinks.RegisterHandler('TICKET', TFormNotifiche);

end.
