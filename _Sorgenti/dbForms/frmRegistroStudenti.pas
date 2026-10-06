unit frmRegistroStudenti;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  dxBarExtItems,
  cxClasses,
  ActnList,
  cxLabel,
  zDbView,
  System.Actions,
  zFormController,
  zFileViewer,
  Base_DataModule,
  dxLayoutContainer,
  dxLayoutControl,
  dxLayoutcxEditAdapters,
  cxStyles,
  cxSchedulerStorage,
  cxSchedulerCustomControls,
  cxSchedulerDateNavigator,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cxDateNavigator,
  cxCustomData,
  dxScrollbarAnnotations,
  cxTL,
  cxTLdxBarBuiltInMenu,
  cxInplaceContainer,
  cxCheckBox,
  frame_RegistroCollettivo,
  Vcl.StdActns,
  zSystem,
  dxLayoutControlAdapters,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  cxCalendar,
  dxFileActions;

type
  TFormRegistroStudenti = class(TBaseForm)
    ActionList: TActionList;
    InserimentoStudente: TAction;
    RegistraRitiroStudente: TAction;
    RettificaDataIscrizione: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FrameRegistroCollettivo: TFrameRegistroCollettivo;
    function FormControllerTabChanging(group: TdxLayoutGroup; ANewTabIndex: integer): boolean;
  protected
    procedure Aggiorna; override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;

    procedure AfterCreateControls; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  public
    procedure OpenRegistro(DataLezione: TDateTime; const IdProgetto, IdCorso: integer);
  end;

var
  FormRegistroStudenti: TFormRegistroStudenti;

implementation

uses
  dmRegistroStudenti, zDm_Images, zDX,   cxFilter, System.DateUtils,
  zMsg;

{$R *.dfm}

procedure TFormRegistroStudenti.CreateDataModule;
begin
  inherited;
  CreateDM(TRegistroStudenti, RegistroStudenti);
end;

procedure TFormRegistroStudenti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(RegistroStudenti);
end;

procedure TFormRegistroStudenti.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'RegistroStudenti';
  Caption := 'Registro Studenti';

  FrameRegistroCollettivo := TFrameRegistroCollettivo.Create(Self);
  FrameRegistroCollettivo.Visible := False;

  FormController.LayoutController.TabChangingProc := FormControllerTabChanging;

  RegistroStudenti.callbackCloseQuery := Procedure(DatiSalvati: boolean)
    begin
      // sul frame direttamente, se viene chiamata form.aggiorna va giustamente in overflow
      FrameRegistroCollettivo.Aggiorna;
    end;
end;

procedure TFormRegistroStudenti.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Progetti_Elenco') then
    // begin
      // Tools.AddFiltroEnte(view, RegistroStudenti.GetDataSet('Progetti_Elenco'));
      // Tools.AddFiltroAnnoFormativo(view, RegistroStudenti.GetDataSet('Progetti_Elenco'));
    // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormRegistroStudenti.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(FrameRegistroCollettivo, 'RegistroCollettivo', False);
end;

procedure TFormRegistroStudenti.Aggiorna;
begin
  inherited;
  FrameRegistroCollettivo.Aggiorna;
end;

function TFormRegistroStudenti.FormControllerTabChanging(group: TdxLayoutGroup; ANewTabIndex: integer): boolean;
begin
  result := true;

  if group.ItemIndex = 0 then
    if RegistroStudenti.RegistroCollettivo.PresenzeModificate then
    begin
      case ConfirmYesNoCancel('Salvo le modifiche al registro collettivo?') of
        mrCancel:
          result := False;
        mrYes:
          FrameRegistroCollettivo.SalvaRegistro;
        mrNo:
          begin
            Annulla(true, true);
            FrameRegistroCollettivo.Aggiorna;
          end;
      end;
    end;
end;

procedure TFormRegistroStudenti.FormShow(Sender: TObject);
begin
  inherited;
  FrameRegistroCollettivo.AggiornaAltezzaTreeMaterie;
end;

procedure TFormRegistroStudenti.OpenRegistro(DataLezione: TDateTime; const IdProgetto, IdCorso: integer);
begin
  FrameRegistroCollettivo.OpenRegistro(DataLezione, IdProgetto, IdCorso);
end;

end.

  BaseFrm
