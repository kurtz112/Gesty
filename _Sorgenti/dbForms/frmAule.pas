unit frmAule;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  System.Actions,
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  zDbView;

type
  TFormAule = class(TBaseForm)
    ActionList: TActionList;
    Autorizza: TAction;
    procedure AutorizzaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetPK(const Value: Variant); override;
  end;

var
  FormAule: TFormAule;

implementation

uses
  cxFilter,
  dmAule,
  zDm_Images,
  zHyperLinks;

{$R *.dfm}

procedure TFormAule.CreateDataModule;
begin
  inherited;
  CreateDM(TAule, Aule);
end;

procedure TFormAule.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Aule);
end;

procedure TFormAule.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Aule';
  ReportGroup := 'Aule';
end;

procedure TFormAule.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Autorizzazioni') then
    // begin
      // view.AddAction(Autorizza, zDmImages.ImageList16);
      // view.InitToolActions;
    // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormAule.AutorizzaExecute(Sender: TObject);
var
  Prenotazioni: TList<integer>;
  view: TzDbView;
begin
  Prenotazioni := TList<integer>.Create;
  try
    view := getView('Autorizzazioni');
    view.GetSelectedRows('ID_PRENOTAZIONE_AULA', Prenotazioni);
    Aule.Autorizza(Prenotazioni);
  finally
    FreeAndNil(Prenotazioni);
  end;
end;

procedure TFormAule.SetPK(const Value: Variant);
var
  Aula: string;
  view: TzDbView;
begin
  inherited;

  Aula := Value;

  if not Aula.IsEmpty then
  begin
    view := getView('Aule');
    if Assigned(view) then
    begin
      view.ClearFilter(False);
      view.AddFilterCondition('AULA', foEqual, Aula);
    end;
  end;
end;

initialization

HyperLinks.RegisterHandler('AULA', TFormAule);

end.
