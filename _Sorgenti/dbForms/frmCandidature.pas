unit frmCandidature;

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
  cxLabel,
  Vcl.StdActns,
  dxFileActions,
  dxUIAClasses;

type
  TFormCandidature = class(TBaseForm)
    ActionList: TActionList;
    GeneraRisorsa: TAction;
    ImportaFile: TdxFileOpen;
    procedure GeneraRisorsaExecute(Sender: TObject);
    procedure ImportaFileAccept(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormCandidature: TFormCandidature;

implementation

uses
  cxFilter,
  dmCandidature;

{$R *.dfm}

procedure TFormCandidature.CreateDataModule;
begin
  inherited;
  CreateDM(TCandidature, Candidature);
end;

procedure TFormCandidature.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Candidature);
end;

constructor TFormCandidature.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'Candidature';
  Caption := 'Candidature';
end;

procedure TFormCandidature.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Candidature') then
    // begin
      // Tools.AddFiltroBoolean(view, Candidature.GetDataSet(DataSetName), 'Risorse_Da_Generare', 'Risorse Da Generare', 'risorse da generare', true);
// 
      // view.AddAction(GeneraRisorsa, zDmImages.ImageList16);
      // view.InitToolActions;
    // end
    // else
      // if SameText(DataSetName, 'Candidature_Files') then
      // begin
        // view.AddAction(ImportaFile, zDmImages.ImageList16);
        // view.InitToolActions;
      // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormCandidature.GeneraRisorsaExecute(Sender: TObject);
begin
  inherited;
  Candidature.GeneraRisorsa;
end;

procedure TFormCandidature.ImportaFileAccept(Sender: TObject);
var
  id: Integer;
  view: TzDbView;
begin
  inherited;

  id := Candidature.ImportaFile(ImportaFile.Dialog.fileName);

  if id <> -1 then
  begin
    view := GetView('Candidature_Files');
    view.AddFilterCondition('ID_FILE_CANDIDATURE', foEqual, id);
  end;
end;

end.
