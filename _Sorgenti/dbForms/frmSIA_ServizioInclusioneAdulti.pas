unit frmSIA_ServizioInclusioneAdulti;

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
  dxUIAClasses,
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
  TFormSIA_ServizioInclusioneAdulti = class(TBaseForm)
    ActionList: TActionList;
    AggiungiDestinatarioEffettivo: TAction;
    InterventiCoperture: TAction;
    RettificaAnagrafica: TAction;
    procedure AggiungiDestinatarioEffettivoExecute(Sender: TObject);
    procedure InterventiCopertureExecute(Sender: TObject);
    procedure RettificaAnagraficaExecute(Sender: TObject);
    procedure RettificaAnagraficaUpdate(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetPK(const Value: Variant); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormSIA_ServizioInclusioneAdulti: TFormSIA_ServizioInclusioneAdulti;

implementation

uses
  dmSIA_ServizioInclusioneAdulti,
  zHyperLinks,
  cxFilter;

{$R *.dfm}

procedure TFormSIA_ServizioInclusioneAdulti.CreateDataModule;
begin
  inherited;
  CreateDM(TSIA_ServizioInclusioneAdulti, SIA_ServizioInclusioneAdulti);
end;

procedure TFormSIA_ServizioInclusioneAdulti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(SIA_ServizioInclusioneAdulti);
end;

constructor TFormSIA_ServizioInclusioneAdulti.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'SIA_ServizioInclusioneAdulti';
  Caption := 'SIA_ServizioInclusioneAdulti';
end;

procedure TFormSIA_ServizioInclusioneAdulti.SetPK(const Value: Variant);
var
  view: TzDbView;
begin
  inherited;
  //
  if pkMode then
  begin
    SelectedDataSetName := 'Sia_Interventi';

    view := getView('Sia_Interventi');
    if Assigned(view) then
    begin
      view.ClearFilter(False);
      view.AddFilterCondition('ID_INTERVENTO_SIA', foEqual, pk);
    end;
  end;
end;

procedure TFormSIA_ServizioInclusioneAdulti.AggiungiDestinatarioEffettivoExecute(Sender: TObject);
begin
  inherited;
  SIA_ServizioInclusioneAdulti.AggiungiDestinatarioEffettivo;
end;

procedure TFormSIA_ServizioInclusioneAdulti.InterventiCopertureExecute(Sender: TObject);
begin
  inherited;
  SIA_ServizioInclusioneAdulti.InterventiCoperture;
end;

// Azione agganciata dal dizionario LZ alla barra della griglia
// SIA_ServizioInclusioneAdulti.Intestatari_Voucher: l'aggancio e' per nome,
// il nome dell'azione deve restare questo.
procedure TFormSIA_ServizioInclusioneAdulti.RettificaAnagraficaExecute(Sender: TObject);
begin
  inherited;
  SIA_ServizioInclusioneAdulti.RettificaAnagrafica;
end;

procedure TFormSIA_ServizioInclusioneAdulti.RettificaAnagraficaUpdate(Sender: TObject);
var
  DataSet: TDataSet;
begin
  DataSet := nil;

  // FindDataSet e non GetDataSet: l'OnUpdate scatta a ogni battito
  // dell'ActionList, e GetDataSet crea il dataset e lo registra nei report.
  if Assigned(SIA_ServizioInclusioneAdulti) then
    DataSet := SIA_ServizioInclusioneAdulti.FindDataSet('Intestatari_Voucher');

  TAction(Sender).Enabled := Assigned(DataSet) and DataSet.Active and (not DataSet.IsEmpty) and (DataSet.State = dsBrowse);
end;

procedure TFormSIA_ServizioInclusioneAdulti.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
// 
  // Sia_Interventi
  // Sia_Interventi_Rendicontazioni
  // Sia_Interventi_Rendicontazioni_Elenco
  // Sia_Interventi_Fatture
  // Sia_Interventi_Fatture_Elenco
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
    // Sia_Interventi
    // Sia_Interventi_Rendicontazioni
    // Sia_Interventi_Rendicontazioni_Elenco
// 
    // if SameText(DataSetName, 'Sia_Interventi') then
    // begin
      // view.AddAction(AggiungiDestinatarioEffettivo, zDmImages.ImageList16);
      // view.AddAction(InterventiCoperture, zDmImages.ImageList16);
      // view.InitToolActions;
// 
//      Tools.AddFiltroData(view, AbitareEmergenza.GetDataSet(DataSetName), 'ALLA_DATA', 'Fatturato Al', 'fatturato alla data', Date,
//        procedure(paramName: string; Value: Variant)
//        begin
//
//          if not varIsNull(Value) then
//            AbitareEmergenza.ProntoInterventoImpostaFiltroFatturato(Value);
//        end);
//
//      Tools.AddFiltroBoolean(view, AbitareEmergenza.GetDataSet(DataSetName), 'INTERVENTO_CONCLUSO', 'Concluso', 'intervento concluso', '');
//      Tools.AddFiltroAbitareEmergenza_Comuni(view, AbitareEmergenza.GetDataSet(DataSetName));
//      Tools.AddFiltroPickList('ABITARE_EMERGENZA_STATO_COPERTURA', view, GetDataSet(DataSetName), 'STATO_COPERTURA', 'Stato Copertura', 'stato copertura', null, true, 'Tutti', 180);
    // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

initialization

HyperLinks.RegisterHandler('ID_INTERVENTO_SIA', TFormSIA_ServizioInclusioneAdulti);

end.




