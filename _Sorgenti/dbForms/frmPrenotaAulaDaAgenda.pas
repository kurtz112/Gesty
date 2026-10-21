// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-21
// ---------------------------------------------------------------------------
unit frmPrenotaAulaDaAgenda;

// Prenotazione di un'aula dall'agenda personale, in due modi:
// - Aule libere: data e ore scelte nel calendario, elenco delle aule libere;
// - Quando e' libera un'aula: aula e periodo scelti, elenco degli orari in
//   cui sono liberi l'aula e la persona.
// Le ricerche sono AULE_CERCA_SLOT_LIBERI_RISORSA (dataset Agenda.AuleLibere e
// Agenda.SlotLiberiAula); la prenotazione si apre con la scheda di sempre
// (SchedulerTools.ApriEvento) gia' compilata con data, ore e aula della riga.

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ActnList,
  Vcl.Menus,
  Data.DB,
  dxCore,
  dxForms,
  dxLayoutContainer,
  dxLayoutcxEditAdapters,
  dxLayoutControlAdapters,
  dxLayoutControl,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  cxDateUtils,
  cxSpinEdit,
  cxTimeEdit,
  cxCheckBox,
  cxButtons,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBExtLookupComboBox,
  zFbDataSet,
  zDbView;

type
  TModoRicercaAula = (mraAuleLibere, mraOrariAula);

  TFormPrenotaAulaDaAgenda = class(TdxForm)
    dxLayoutControl: TdxLayoutControl;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutGroupModi: TdxLayoutGroup;
    dxLayoutGroupAuleLibere: TdxLayoutGroup;
    dxLayoutGroupFiltriAuleLibere: TdxLayoutGroup;
    dxLayoutGroupOrariAula: TdxLayoutGroup;
    dxLayoutGroupOrariAulaAula: TdxLayoutGroup;
    dxLayoutGroupOrariAulaPeriodo: TdxLayoutGroup;
    dxLayoutGroupOrariAulaFascia: TdxLayoutGroup;
    dxLayoutGroupOrariAulaCerca: TdxLayoutGroup;
    dxLayoutGroupPulsanti: TdxLayoutGroup;
    edData: TcxDateEdit;
    edDalleOre: TcxTimeEdit;
    edAlleOre: TcxTimeEdit;
    btnCercaAuleLibere: TcxButton;
    viewAuleLibere: TzDbView;
    edAula: TcxExtLookupComboBox;
    edDalGiorno: TcxDateEdit;
    edAlGiorno: TcxDateEdit;
    edDalleOreAula: TcxTimeEdit;
    edAlleOreAula: TcxTimeEdit;
    edDurata: TcxSpinEdit;
    edPasso: TcxSpinEdit;
    chkFineSettimana: TcxCheckBox;
    btnCercaOrariAula: TcxButton;
    viewSlotLiberiAula: TzDbView;
    btnPrenota: TcxButton;
    btnChiudi: TcxButton;
    dxLayoutItemData: TdxLayoutItem;
    dxLayoutItemDalleOre: TdxLayoutItem;
    dxLayoutItemAlleOre: TdxLayoutItem;
    dxLayoutItemCercaAuleLibere: TdxLayoutItem;
    dxLayoutItemAuleLibere: TdxLayoutItem;
    dxLayoutItemAula: TdxLayoutItem;
    dxLayoutItemDalGiorno: TdxLayoutItem;
    dxLayoutItemAlGiorno: TdxLayoutItem;
    dxLayoutItemDalleOreAula: TdxLayoutItem;
    dxLayoutItemAlleOreAula: TdxLayoutItem;
    dxLayoutItemDurata: TdxLayoutItem;
    dxLayoutItemPasso: TdxLayoutItem;
    dxLayoutItemFineSettimana: TdxLayoutItem;
    dxLayoutItemCercaOrariAula: TdxLayoutItem;
    dxLayoutItemSlotLiberiAula: TdxLayoutItem;
    dxLayoutItemPrenota: TdxLayoutItem;
    dxLayoutItemChiudi: TdxLayoutItem;
    Actions: TActionList;
    CercaAuleLibere: TAction;
    CercaOrariAula: TAction;
    Prenota: TAction;
    Chiudi: TAction;
    procedure FormCreate(Sender: TObject);
    procedure CercaAuleLibereExecute(Sender: TObject);
    procedure CercaOrariAulaExecute(Sender: TObject);
    procedure PrenotaExecute(Sender: TObject);
    procedure PrenotaUpdate(Sender: TObject);
    procedure ChiudiExecute(Sender: TObject);
    procedure viewRisultatiDblClick(Sender: TObject);
    procedure edAulaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FPrenotato: boolean;
    function Risultati: TzFbDataSet;
  public
    // Apre la finestra sul modo richiesto, con data e ore di partenza (dalla
    // selezione del calendario) e la fascia lavorativa per il modo B.
    // Vero se almeno una prenotazione e' stata salvata
    class function Esegui(Modo: TModoRicercaAula; Data: TDate; DalleOre, AlleOre, InizioLavoro, FineLavoro: TTime): boolean;
  end;

implementation

uses
  System.DateUtils,
  ConfigModule,
  zDX,
  zMsg,
  zBaseLib,
  dmAgenda;

{$R *.dfm}

const
  DurataPredefinita = 60;
  PassoPredefinito = 30;
  GiorniPredefiniti = 30;

class function TFormPrenotaAulaDaAgenda.Esegui(Modo: TModoRicercaAula; Data: TDate; DalleOre, AlleOre, InizioLavoro, FineLavoro: TTime): boolean;
var
  Form: TFormPrenotaAulaDaAgenda;
begin
  Form := TFormPrenotaAulaDaAgenda.Create(Application);
  try
    Form.edData.Date := Data;
    Form.edDalleOre.Time := DalleOre;
    Form.edAlleOre.Time := AlleOre;

    Form.edDalGiorno.Date := Data;
    Form.edAlGiorno.Date := IncDay(Data, GiorniPredefiniti);
    Form.edDalleOreAula.Time := InizioLavoro;
    Form.edAlleOreAula.Time := FineLavoro;

    if Modo = mraAuleLibere then
    begin
      Form.dxLayoutGroupModi.ItemIndex := 0;
      // data e ore vengono dal calendario: la ricerca parte subito
      Form.CercaAuleLibere.Execute;
    end
    else
      Form.dxLayoutGroupModi.ItemIndex := 1;

    Form.ShowModal;
    result := Form.FPrenotato;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFormPrenotaAulaDaAgenda.FormCreate(Sender: TObject);
begin
  Width := 760;
  Height := 560;
  FPrenotato := False;

  dx.InitLayoutControl(dxLayoutControl);

  viewAuleLibere.zSystem := Config.zSystem;
  viewAuleLibere.zDataSet := Agenda.AuleLibere;

  viewSlotLiberiAula.zSystem := Config.zSystem;
  viewSlotLiberiAula.zDataSet := Agenda.SlotLiberiAula;

  Agenda.ElencoAule.Active := true;
  dx.InitLookup('', edAula, Agenda.ElencoAule, Agenda.GetDataSource(Agenda.ElencoAule), 'AULA', 'AULA');

  edDurata.Value := DurataPredefinita;
  edPasso.Value := PassoPredefinito;
  chkFineSettimana.Checked := False;
end;

function TFormPrenotaAulaDaAgenda.Risultati: TzFbDataSet;
begin
  if dxLayoutGroupModi.ItemIndex = 0 then
    result := Agenda.AuleLibere
  else
    result := Agenda.SlotLiberiAula;
end;

procedure TFormPrenotaAulaDaAgenda.CercaAuleLibereExecute(Sender: TObject);
var
  Data: TDate;
  DalleOre, AlleOre: TTime;
begin
  if DateNull(edData.Date) then
  begin
    ConfirmOk('Indicare il giorno.');
    exit;
  end;

  Data := edData.Date;
  DalleOre := TimeOf(edDalleOre.Time);
  AlleOre := TimeOf(edAlleOre.Time);

  if AlleOre <= DalleOre then
  begin
    ConfirmOk('L''ora di fine deve essere dopo l''ora di inizio.');
    exit;
  end;

  Agenda.CercaAuleLibere(Data, DalleOre, AlleOre);

  // la ricerca esclude gli orari in cui la persona e' impegnata: un elenco
  // vuoto senza spiegazione farebbe pensare che non ci siano aule
  if Agenda.AuleLibere.IsEmpty then
    if not Agenda.PersonaLibera(Data, DalleOre, AlleOre) then
      ConfirmOk('In questo orario hai gia'' un impegno in agenda: nessuna aula proposta.')
    else
      ConfirmOk('Nessuna aula libera in questo orario.');
end;

procedure TFormPrenotaAulaDaAgenda.CercaOrariAulaExecute(Sender: TObject);
var
  Aula: string;
begin
  if VarIsNull(edAula.EditValue) then
    Aula := ''
  else
    Aula := VarToStr(edAula.EditValue);

  if Aula.IsEmpty then
  begin
    ConfirmOk('Scegliere l''aula.');
    exit;
  end;

  if DateNull(edDalGiorno.Date) or DateNull(edAlGiorno.Date) or (edAlGiorno.Date < edDalGiorno.Date) then
  begin
    ConfirmOk('Periodo non valido.');
    exit;
  end;

  if TimeOf(edAlleOreAula.Time) <= TimeOf(edDalleOreAula.Time) then
  begin
    ConfirmOk('L''ora di fine deve essere dopo l''ora di inizio.');
    exit;
  end;

  Agenda.CercaSlotLiberiAula(Aula, edDalGiorno.Date, edAlGiorno.Date, TimeOf(edDalleOreAula.Time), TimeOf(edAlleOreAula.Time), edDurata.Value, edPasso.Value, chkFineSettimana.Checked);

  if Agenda.SlotLiberiAula.IsEmpty then
    ConfirmOk('Nessun orario in cui siano liberi sia l''aula sia tu.');
end;

procedure TFormPrenotaAulaDaAgenda.PrenotaExecute(Sender: TObject);
var
  PrenotazioniAccese: boolean;
begin
  if not Agenda.PrenotaDaRicerca(Risultati, PrenotazioniAccese) then
    exit;

  FPrenotato := true;

  if PrenotazioniAccese then
    ConfirmOk('Nell''agenda e'' stata attivata la visualizzazione delle prenotazioni aule, per mostrare quella appena fatta.');

  // si ripete la ricerca: l'orario appena preso sparisce dall'elenco
  if dxLayoutGroupModi.ItemIndex = 0 then
    CercaAuleLibere.Execute
  else
    CercaOrariAula.Execute;
end;

procedure TFormPrenotaAulaDaAgenda.PrenotaUpdate(Sender: TObject);
begin
  Prenota.Enabled := Risultati.Active and not Risultati.IsEmpty;
end;

procedure TFormPrenotaAulaDaAgenda.ChiudiExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormPrenotaAulaDaAgenda.viewRisultatiDblClick(Sender: TObject);
begin
  Prenota.Execute;
end;

procedure TFormPrenotaAulaDaAgenda.edAulaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if edAula.EditingText = '' then
  begin
    edAula.Clear;
    edAula.PostEditValue;
  end;
end;

end.
