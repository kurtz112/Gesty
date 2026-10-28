unit frmAnagrafiche;

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
  zDbView,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel;

type
  TFormAnagrafiche = class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure SetPK(const Value: Variant); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAnagrafiche: TFormAnagrafiche;

implementation

uses
  cxFilter,
  zDm_Images,
  dmAnagrafiche,
  zHyperLinks;

{$R *.dfm}

procedure TFormAnagrafiche.CreateDataModule;
begin
  inherited;
  CreateDM(TAnagrafiche, Anagrafiche);
end;

procedure TFormAnagrafiche.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Anagrafiche);
end;

constructor TFormAnagrafiche.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'Anagrafiche';
  Caption := 'Anagrafiche';
end;

procedure TFormAnagrafiche.SetPK(const Value: Variant);
var
  view: TzDbView;
begin
  inherited;
  //
  if pkMode then
  begin

    view := getView('Anagrafe');
    if Assigned(view) then
    begin
      view.ClearFilter(False);
      view.AddFilterCondition('ID_ANAGRAFICA', foEqual, pk);
    end;
  end;
end;

initialization

HyperLinks.RegisterHandler('ID_ANAGRAFICA', TFormAnagrafiche);
// Mantis #252 - 2026-10-28: il campo del Front Office apre la stessa scheda anagrafe
HyperLinks.RegisterHandler('ID_ANAGRAFICA_CONTATTO', TFormAnagrafiche);

end.

BaseWeb.Form (nella cartella BaseWeb)
frmFbMonitor (nella cartella FbTools)

