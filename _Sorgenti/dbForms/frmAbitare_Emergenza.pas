unit frmAbitare_Emergenza;

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
  cxStyles,
  cxGridCustomTableView,
  cxGridDBTableView,
  dxUIAClasses;

type
  TFormAbitareEmergenza = class(TBaseForm)
    ActionList: TActionList;
    DuplicaProntoIntervento: TAction;
    ProntoInterventoCoperture: TAction;
    DuplicaProgetto: TAction;
    ProgettoCoperture: TAction;
    BloccaImportiProntoIntervento: TAction;
    SbloccaImportiProntoIntervento: TAction;
    BloccaImportiProgetto: TAction;
    SbloccaImportiProgetto: TAction;
    procedure DuplicaProgettoExecute(Sender: TObject);
    procedure ProntoInterventoCopertureExecute(Sender: TObject);
    procedure DuplicaProntoInterventoExecute(Sender: TObject);
    procedure ProgettoCopertureExecute(Sender: TObject);
    procedure BloccaImportiProntoInterventoExecute(Sender: TObject);
    procedure SbloccaImportiProntoInterventoExecute(Sender: TObject);
    procedure BloccaImportiProgettoExecute(Sender: TObject);
    procedure SbloccaImportiProgettoExecute(Sender: TObject);
    procedure BloccaImportiProntoInterventoUpdate(Sender: TObject);
    procedure SbloccaImportiProntoInterventoUpdate(Sender: TObject);
    procedure BloccaImportiProgettoUpdate(Sender: TObject);
    procedure SbloccaImportiProgettoUpdate(Sender: TObject);
  private
    FStileDisallineato: TcxStyle;
    procedure AggiornaComandoBlocco(Sender: TObject; const DataSetName: string; const RichiedeBloccato: Boolean);
    function StileDisallineato: TcxStyle;
    function Disallineato(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; const CampoDisallineamento: string): Boolean;
    procedure ProntoInterventoGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
    procedure ProgettiGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetPK(const Value: Variant); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAbitareEmergenza: TFormAbitareEmergenza;

implementation

uses
  dmAbitare_Emergenza,
  zHyperLinks,
  cxFilter,
  Gesty_Filters;

{$R *.dfm}

procedure TFormAbitareEmergenza.CreateDataModule;
begin
  inherited;
  CreateDM(TAbitareEmergenza, AbitareEmergenza);
end;

procedure TFormAbitareEmergenza.DestroyDataModule;
begin
  inherited;
  FreeAndNil(AbitareEmergenza);
end;

constructor TFormAbitareEmergenza.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'AbitareEmergenza';
  Caption := 'AbitareEmergenza';
end;

procedure TFormAbitareEmergenza.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
// begin
// inherited;
//
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'Abitare_Emergenza_Pronto_Intervento_Elenco') then
// begin
// view.AddAction(DuplicaProntoIntervento, zDmImages.ImageList16);
// view.AddAction(ProntoInterventoCoperture, zDmImages.ImageList16).HideInView;
// view.InitToolActions;
//
// Tools.AddFiltroData(view, AbitareEmergenza.GetDataSet(DataSetName), 'ALLA_DATA', 'Fatturato Al', 'fatturato alla data', Date,
// procedure(paramName: string; Value: Variant)
// begin
//
// if not varIsNull(Value) then
// AbitareEmergenza.ProntoInterventoImpostaFiltroFatturato(Value);
// end);
//
// Tools.AddFiltroBoolean(view, AbitareEmergenza.GetDataSet(DataSetName), 'INTERVENTO_CONCLUSO', 'Concluso', 'intervento concluso', '');
// Tools.AddFiltroAbitareEmergenza_Comuni(view, AbitareEmergenza.GetDataSet(DataSetName));
// Tools.AddFiltroPickList('ABITARE_EMERGENZA_STATO_COPERTURA', view, GetDataSet(DataSetName), 'STATO_COPERTURA', 'Stato Copertura', 'stato copertura', null, true, 'Tutti', 180);
// end
// else
// if SameText(DataSetName, 'Abitare_Emergenza_Progetti_Elenco') then
// begin
// view.AddAction(DuplicaProgetto, zDmImages.ImageList16);
// view.AddAction(ProgettoCoperture, zDmImages.ImageList16).HideInView;
// view.InitToolActions;
//
// Tools.AddFiltroData(view, AbitareEmergenza.GetDataSet(DataSetName), 'ALLA_DATA', 'Fatturato Al', 'fatturato alla data', Date,
// procedure(paramName: string; Value: Variant)
// begin
//
// if not varIsNull(Value) then
// AbitareEmergenza.ProgettiImpostaFiltroFatturato(Value);
// end);
//
// Tools.AddFiltroBoolean(view, AbitareEmergenza.GetDataSet(DataSetName), 'INTERVENTO_CONCLUSO', 'Concluso', 'intervento concluso', '');
// Tools.AddFiltroAbitareEmergenza_Comuni(view, AbitareEmergenza.GetDataSet(DataSetName));
// Tools.AddFiltroPickList('ABITARE_EMERGENZA_STATO_COPERTURA', view, GetDataSet(DataSetName), 'STATO_COPERTURA', 'Stato Copertura', 'stato copertura', null, true, 'Tutti', 180);
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormAbitareEmergenza.ProntoInterventoCopertureExecute(Sender: TObject);
begin
  inherited;
  AbitareEmergenza.ProntoInterventoCoperture;
end;

procedure TFormAbitareEmergenza.DuplicaProntoInterventoExecute(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;
  view := GetView('Abitare_Emergenza_Pronto_Intervento_Elenco');

  if AbitareEmergenza.DuplicaProntoIntervento then
    view.ShowRecord(false);
end;

procedure TFormAbitareEmergenza.DuplicaProgettoExecute(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;
  view := GetView('Abitare_Emergenza_Progetti_Elenco');

  if AbitareEmergenza.DuplicaProgetto then
    view.ShowRecord(false);
end;

procedure TFormAbitareEmergenza.ProgettoCopertureExecute(Sender: TObject);
begin
  inherited;
  AbitareEmergenza.ProgettoCoperture;
end;

// ============================================================================
// Blocco degli importi
//
// Il lavoro vero lo fa il DataModule, che chiama le procedure
// ABITARE_EMERGENZA_BLOCCA_IMPORTI e _SBLOCCA_IMPORTI. Qui restano solo le
// azioni che il dizionario LZ aggancia alla barra strumenti delle due viste.
// L'aggancio e' per nome: i nomi delle azioni devono restare questi.
//
// Le due azioni si escludono a vicenda e si accendono guardando
// DATA_BLOCCO_IMPORTI: su un intervento gia' bloccato resta acceso solo
// Sblocca, su uno libero solo Blocca. Cosi' l'operatore vede dalla barra in
// che stato e' la pratica, senza aprire la scheda.
// ============================================================================

procedure TFormAbitareEmergenza.AggiornaComandoBlocco(Sender: TObject; const DataSetName: string; const RichiedeBloccato: Boolean);
var
  DataSet: TDataSet;
  Campo: TField;
  Bloccato: Boolean;
begin
  DataSet := nil;

  if Assigned(AbitareEmergenza) then
    DataSet := AbitareEmergenza.GetDataSet(DataSetName);

  // FindField e non FieldByName: se il database non ha ancora le colonne del
  // blocco, il comando resta spento invece di sollevare a ogni battito
  // dell'ActionList.
  Campo := nil;

  if Assigned(DataSet) and DataSet.Active and not DataSet.IsEmpty and (DataSet.State = dsBrowse) then
    Campo := DataSet.FindField('DATA_BLOCCO_IMPORTI');

  Bloccato := Assigned(Campo) and not Campo.IsNull;

  TAction(Sender).Enabled := Assigned(Campo) and (Bloccato = RichiedeBloccato);
end;

procedure TFormAbitareEmergenza.BloccaImportiProntoInterventoExecute(Sender: TObject);
begin
  inherited;
  AbitareEmergenza.BloccaImportiProntoIntervento;
end;

procedure TFormAbitareEmergenza.SbloccaImportiProntoInterventoExecute(Sender: TObject);
begin
  inherited;
  AbitareEmergenza.SbloccaImportiProntoIntervento;
end;

procedure TFormAbitareEmergenza.BloccaImportiProgettoExecute(Sender: TObject);
begin
  inherited;
  AbitareEmergenza.BloccaImportiProgetto;
end;

procedure TFormAbitareEmergenza.SbloccaImportiProgettoExecute(Sender: TObject);
begin
  inherited;
  AbitareEmergenza.SbloccaImportiProgetto;
end;

procedure TFormAbitareEmergenza.BloccaImportiProntoInterventoUpdate(Sender: TObject);
begin
  AggiornaComandoBlocco(Sender, 'Abitare_Emergenza_Pronto_Intervento_Elenco', false);
end;

procedure TFormAbitareEmergenza.SbloccaImportiProntoInterventoUpdate(Sender: TObject);
begin
  AggiornaComandoBlocco(Sender, 'Abitare_Emergenza_Pronto_Intervento_Elenco', true);
end;

procedure TFormAbitareEmergenza.BloccaImportiProgettoUpdate(Sender: TObject);
begin
  AggiornaComandoBlocco(Sender, 'Abitare_Emergenza_Progetti_Elenco', false);
end;

procedure TFormAbitareEmergenza.SbloccaImportiProgettoUpdate(Sender: TObject);
begin
  AggiornaComandoBlocco(Sender, 'Abitare_Emergenza_Progetti_Elenco', true);
end;

// ============================================================================
// Segnale di disallineamento
//
// Un importo imposto a mano non si aggiorna piu' da solo: se poi cambiano le
// date o gli importi unitari da cui nasceva, il totale che si vede non e' piu'
// il conto di quei dati. Le procedure _DETAIL lo dicono nelle colonne
// *_DISALLINEATA, confrontando il valore forzato con quello ricalcolato.
//
// In griglia la riga intera prende un fondo d'attenzione: il disallineamento
// si deve notare scorrendo l'elenco, senza aprire le schede una per una. Quale
// dei due importi sia fuori posto lo dice poi la scheda, dove ogni casella
// "Non Piu' Allineato" sta accanto al suo importo.
//
// Lo stile e' creato qui e non preso da dx.GetStyle: i colori di quella
// raccolta seguono l'aspetto scelto (sono i colori di contenuto e di
// selezione), e sotto un aspetto qualunque non si distinguerebbero da una riga
// normale. Un colore fisso resta un segnale.
// ============================================================================

function TFormAbitareEmergenza.StileDisallineato: TcxStyle;
begin

  if not Assigned(FStileDisallineato) then
  begin
    // Self come proprietario: lo libera la form, senza bisogno di distruggerlo a mano.
    FStileDisallineato := TcxStyle.Create(Self);
    FStileDisallineato.Color := $00C8EBFF; // ambra chiara
    FStileDisallineato.TextColor := $00004080;
  end;

  Result := FStileDisallineato;
end;

function TFormAbitareEmergenza.Disallineato(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  const CampoDisallineamento: string): Boolean;
var
  Colonna: TcxCustomGridTableItem;
  Valore: Variant;
begin
  Result := false;

  if not (Sender is TcxGridDBTableView) then
    Exit;

  // La colonna esiste anche se nascosta: la griglia crea un item per ogni campo
  // del dataset. Se un giorno il campo non ci fosse piu', qui non si segnala
  // niente invece di sollevare a ogni ridisegno.
  Colonna := TcxGridDBTableView(Sender).GetColumnByFieldName(CampoDisallineamento);

  if not Assigned(Colonna) then
    Exit;

  Valore := ARecord.Values[Colonna.Index];

  Result := not VarIsNull(Valore) and not VarIsEmpty(Valore) and Valore;
end;

procedure TFormAbitareEmergenza.ProntoInterventoGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin

  if Disallineato(Sender, ARecord, 'PREVISIONE_DI_SPESA_DISALLINEATA') or
     Disallineato(Sender, ARecord, 'TOTALE_SPESA_EFFETTIVA_DISALLINEATA') then
    AStyle := StileDisallineato;
end;

procedure TFormAbitareEmergenza.ProgettiGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin

  if Disallineato(Sender, ARecord, 'TOTALE_COSTI_INTERVENTO_PREVISTI_DISALLINEATI') or
     Disallineato(Sender, ARecord, 'TOTALE_COSTI_INTERVENTO_EFFETTIVI_DISALLINEATI') then
    AStyle := StileDisallineato;
end;

procedure TFormAbitareEmergenza.SetPK(const Value: Variant);
var
  view: TzDbView;
  id: integer;
begin
  inherited;

  if pkMode then
  begin

    if pkField = 'ID_PRONTO_INTERVENTO' then
    begin

      SelectedDataSetName := 'Abitare_Emergenza_Pronto_Intervento_Elenco';

      // punta alla risorsa corretta
      view := GetView('Abitare_Emergenza_Pronto_Intervento_Elenco');
      if Assigned(view) then
      begin
        view.ClearFilter(false);
        view.AddFilterCondition('ID_PRONTO_INTERVENTO', foEqual, pk);
      end;
    end
    else
      if pkField = 'ID_PROGETTO' then
      begin

        SelectedDataSetName := 'Abitare_Emergenza_Progetti_Elenco';

        // punta alla risorsa corretta
        view := GetView('Abitare_Emergenza_Progetti_Elenco');
        if Assigned(view) then
        begin
          view.ClearFilter(false);
          view.AddFilterCondition('ID_PROGETTO', foEqual, pk);
        end;
      end;
  end;
end;

procedure TFormAbitareEmergenza.SetupComponent(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
begin
  inherited;

  if Component is TzDbView then
  begin
    view := TzDbView(Component);
    { TODO : Porting TOOLS }
    if SameText(DataSetName, 'Abitare_Emergenza_Pronto_Intervento_Elenco') then
    begin

      TDateBarFilter.ApplyTo(view, AbitareEmergenza.GetDataSet(DataSetName), 'ALLA_DATA', 'Fatturato Al', 'fatturato alla data', Date,
        procedure(paramName: string; Value: Variant)
        begin
          if not varIsNull(Value) then
            AbitareEmergenza.ProntoInterventoImpostaFiltroFatturato(Value);
        end);

      view.cxGridDBTableView.Styles.OnGetContentStyle := ProntoInterventoGetContentStyle;
    end
    else
      if SameText(DataSetName, 'Abitare_Emergenza_Progetti_Elenco') then
      begin
        TDateBarFilter.ApplyTo(view, AbitareEmergenza.GetDataSet(DataSetName), 'ALLA_DATA', 'Fatturato Al', 'fatturato alla data', Date,
          procedure(paramName: string; Value: Variant)
          begin

            if not varIsNull(Value) then
              AbitareEmergenza.ProgettiImpostaFiltroFatturato(Value);
          end);

        view.cxGridDBTableView.Styles.OnGetContentStyle := ProgettiGetContentStyle;
      end;
  end;
end;

initialization

// HyperLinks.RegisterHandler('ID_PRONTO_INTERVENTO', TFormAbitareEmergenza);
// duplicato di progetti
// HyperLinks.RegisterHandler('ID_PROGETTO', TFormAbitareEmergenza);

end.

  zOffice.Reports.form

  zFormController
  zsystem
