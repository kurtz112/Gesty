unit frmPianiIndividuali;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Data.DB,
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
  cxFilter,
  zFormController,
  zFileViewer,
  zDbView, dxUIAClasses;

type
  TFormPianiIndividuali = class(TBaseForm)
    ActionList: TActionList;
    NuovoPianoIndividuale: TAction;
    InserimentoIncarico: TAction;
    GeneraDocumentazione: TAction;
    procedure FormCreate(Sender: TObject);
    procedure GeneraDocumentazioneExecute(Sender: TObject);
    procedure InserimentoIncaricoExecute(Sender: TObject);
    procedure NuovoPianoIndividualeExecute(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetPK(const Value: Variant); override;
  public
  end;

var
  FormPianiIndividuali: TFormPianiIndividuali;

implementation

uses
  System.IOUtils,
  dmPianiIndividuali,
  zDm_Images,
  zHyperLinks,
  Files.Lib;

{$R *.dfm}

procedure TFormPianiIndividuali.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Piani Individuali';
  Caption := 'Piani Individuali';
end;

procedure TFormPianiIndividuali.CreateDataModule;
begin
  inherited;
  CreateDM(TPianiIndividuali, PianiIndividuali);
end;

procedure TFormPianiIndividuali.DestroyDataModule;
begin
  inherited;
  FreeAndNil(PianiIndividuali);
end;

procedure TFormPianiIndividuali.SetPK(const Value: Variant);
var
  view: TzDbView;
begin
  inherited;
  //
  if pkMode then
  begin
    view := getView('PianiIndividuali');
    if assigned(view) then
    begin
      view.ClearFilter(false);
      view.AddFilterCondition('ID_PIANO_PERSONALIZZATO', foEqual, pk);
    end;
  end;
end;

procedure TFormPianiIndividuali.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'PianiIndividuali') then
    // begin
      // view.AddAction(NuovoPianoIndividuale, zDmImages.ImageList16);
      // view.AddAction(GeneraDocumentazione, zDmImages.ImageList16);
      // view.InitToolActions;
      // Tools.AddFiltroEnte(view, PianiIndividuali.GetDataSet('PianiIndividuali'));
      // Tools.AddFiltroAnnoFormativo(view, PianiIndividuali.GetDataSet('PianiIndividuali'));
    // end
    // else
      // if SameText(DataSetName, 'Incarichi') then
      // begin
        // view.AddAction(InserimentoIncarico, zDmImages.ImageList16);
        // view.InitToolActions;
      // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormPianiIndividuali.NuovoPianoIndividualeExecute(Sender: TObject);
begin
  inherited;
  PianiIndividuali.NuovoPianoIndividuale;
end;

procedure TFormPianiIndividuali.InserimentoIncaricoExecute(Sender: TObject);
begin
  inherited;
  PianiIndividuali.NuovoIncarico;
end;

procedure TFormPianiIndividuali.GeneraDocumentazioneExecute(Sender: TObject);
const
  FolderName = 'Piani Individuali';
  DataSetName = 'PianiIndividuali';
begin
  inherited;
  Print(FolderName, DataSetName);
end;

initialization

HyperLinks.RegisterHandler('ID_PIANO_PERSONALIZZATO', TFormPianiIndividuali);

end.

  zdx
