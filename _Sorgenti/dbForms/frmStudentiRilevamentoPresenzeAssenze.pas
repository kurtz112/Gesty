unit frmStudentiRilevamentoPresenzeAssenze;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
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
  Data.DB,
  Base_DataModule,
  dxLayoutcxEditAdapters,
  dxLayoutContainer,
  cxSpinEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  dxLayoutControl,
  dxLayoutControlAdapters,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  cxCalendar,
  zFormController,
  zDbView,
  cxStyles,
  cxSchedulerStorage,
  cxSchedulerCustomControls,
  cxSchedulerDateNavigator,
  cxDateNavigator,
  cxDBEdit, cxDBExtLookupComboBox, dxUIAClasses;

type
  TFormStudentiRilevamentoPresenzeAssenze = class(TBaseForm)
    layoutControlli: TdxLayoutControl;
    edProgetto: TcxExtLookupComboBox;
    layoutControlliGroup_Root: TdxLayoutGroup;
    dxLayoutItemProgetto: TdxLayoutItem;
    dxLayoutGroupTop: TdxLayoutGroup;
    viewPresenti: TzDbView;
    viewAssenti: TzDbView;
    cxDateNavigator: TcxDateNavigator;
    dxLayoutItemPresenti: TdxLayoutItem;
    dxLayoutItemNavigator: TdxLayoutItem;
    dxLayoutItemAssenti: TdxLayoutItem;
    dxLayoutGroupMain: TdxLayoutGroup;
    edOreSvolte: TcxDBTextEdit;
    dxLayoutItemOreSvolte: TdxLayoutItem;
    edOrePreviste: TcxDBTextEdit;
    dxLayoutItemOrePreviste: TdxLayoutItem;
    btnAnnullaFrequenza: TcxButton;
    dxLayoutItemAnnullaFrequenza: TdxLayoutItem;
    btnAssegnaFrequenza: TcxButton;
    dxLayoutItemAssegnaFrequenza: TdxLayoutItem;
    ActionList: TActionList;
    AssegnaFrequenza: TAction;
    AnnullaFrequenza: TAction;
    dxLayoutGroupNavigator: TdxLayoutGroup;
    dxLayoutGroupOre: TdxLayoutGroup;
    labelData: TcxLabel;
    dxLayoutItemData: TdxLayoutItem;
    dxLayoutSeparatorItem1: TdxLayoutSeparatorItem;
    RegistraAssenze: TAction;
    edDataInizioCorso: TcxDBTextEdit;
    edDataFineCorso: TcxDBTextEdit;
    edNumeroStudenti: TcxDBTextEdit;
    OreLezioneSrc: TDataSource;
    dxLayoutItemDataInizio: TdxLayoutItem;
    dxLayoutItemDataFine: TdxLayoutItem;
    dxLayoutItemNumeroStudenti: TdxLayoutItem;
    RegistraAttivitaIndividuali: TAction;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    dxLayoutItemIndividuali: TdxLayoutItem;
    viewIndividuali: TzDbView;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutSplitterItem1: TdxLayoutSplitterItem;
    procedure AnnullaFrequenzaExecute(Sender: TObject);
    procedure AssegnaFrequenzaExecute(Sender: TObject);
    procedure cxDateNavigatorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edProgettoPropertiesEditValueChanged(Sender: TObject);
    procedure RegistraAssenzeExecute(Sender: TObject);
    procedure RegistraAttivitaIndividualiExecute(Sender: TObject);
  private
    procedure SetData(Data: TDate);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  end;

implementation

uses
  dmStudentiRilevamentoPresenzeAssenze,
  zDX,
  System.Generics.Collections,
  zSystem, zBaseLib;

{$R *.dfm}

procedure TFormStudentiRilevamentoPresenzeAssenze.CreateDataModule;
begin
  inherited;
  CreateDM(TStudentiRilevamentoPresenzeAssenze, StudentiRilevamentoPresenzeAssenze);
end;

procedure TFormStudentiRilevamentoPresenzeAssenze.cxDateNavigatorClick(Sender: TObject);
begin
  inherited;
  SetData(cxDateNavigator.Date);
end;

procedure TFormStudentiRilevamentoPresenzeAssenze.DestroyDataModule;
begin
  inherited;
  FreeAndNil(StudentiRilevamentoPresenzeAssenze);
end;

procedure TFormStudentiRilevamentoPresenzeAssenze.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Rilevamento Assenze';
  Caption := 'Rilevamento Assenze';

  viewPresenti.zDataSet := StudentiRilevamentoPresenzeAssenze.Presenti;
  viewIndividuali.zDataSet := StudentiRilevamentoPresenzeAssenze.Individuali;
  viewAssenti.zDataSet := StudentiRilevamentoPresenzeAssenze.Assenti;

  dx.InitLookup('', edProgetto, StudentiRilevamentoPresenzeAssenze.lkProgetti, StudentiRilevamentoPresenzeAssenze.lkProgettiSrc, 'ID_PROGETTO', 'DENOMINAZIONE_PROGETTO');

  dx.SetEditability(edDataInizioCorso, edReadOnly);
  dx.SetEditability(edDataFineCorso, edReadOnly);
  dx.SetEditability(edNumeroStudenti, edReadOnly);

  dx.SetEditability(edOrePreviste, edReadOnly);
  dx.SetEditability(edOreSvolte, edReadOnly);

  OreLezioneSrc.DataSet := StudentiRilevamentoPresenzeAssenze.OreLezione;

  cxDateNavigator.Date := Date;
  SetData(Date);

  ActiveControl := edProgetto;
end;

procedure TFormStudentiRilevamentoPresenzeAssenze.SetData(Data: TDate);
begin
  labelData.Caption := FormatDateTime('dddd d mmmm yyyy', Data);
  StudentiRilevamentoPresenzeAssenze.Data := Data;
end;

procedure TFormStudentiRilevamentoPresenzeAssenze.edProgettoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  StudentiRilevamentoPresenzeAssenze.IdProgetto := dx.ValueInt(edProgetto);
end;

procedure TFormStudentiRilevamentoPresenzeAssenze.AssegnaFrequenzaExecute(Sender: TObject);
begin
  inherited;
  StudentiRilevamentoPresenzeAssenze.RegistraPresenze;
end;

procedure TFormStudentiRilevamentoPresenzeAssenze.AnnullaFrequenzaExecute(Sender: TObject);
begin
  inherited;
  StudentiRilevamentoPresenzeAssenze.EliminaPresenze;
end;

procedure TFormStudentiRilevamentoPresenzeAssenze.RegistraAssenzeExecute(Sender: TObject);
var
  Assenti: TList<Integer>;
begin
  inherited;

  Assenti := TList<Integer>.Create;
  try
    viewPresenti.GetSelectedRows('ID_STUDENTE', Assenti);
    StudentiRilevamentoPresenzeAssenze.RegistraAssenze(Assenti);
  finally
    FreeAndNil(Assenti);
  end;
end;

procedure TFormStudentiRilevamentoPresenzeAssenze.RegistraAttivitaIndividualiExecute(Sender: TObject);
var
  Studenti: TList<Integer>;
begin
  inherited;

  Studenti := TList<Integer>.Create;
  try
    viewPresenti.GetSelectedRows('ID_STUDENTE', Studenti);
    StudentiRilevamentoPresenzeAssenze.RegistraAttivitaIndividuali(Studenti);
  finally
    FreeAndNil(Studenti);
  end;
end;

end.
