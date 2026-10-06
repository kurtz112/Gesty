unit frmStagePresenze;

interface

uses
  System.SysUtils,
  System.Classes,
  JS,
  Web,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  Vcl.StdCtrls,
  WEBLib.StdCtrls,
  Vcl.Controls,
  WEBLib.WebCtrls,
  DevExtreme.Data,
  DevExtreme.CustomControl,
  DevExtreme.Scheduler.JS,
  DevExtreme.Toolbar.JS,
  DevExtreme.DateBox.JS,
  DevExtreme.Form.JS,
  DevExtreme.Popup.JS,
  zz.Web.DataRequest,
  zz.Web.JSClasses,
  BaseWebFrm;

type
  TFormStagePresenze = class(TBaseWebForm)
    Presenze: TjdxDataSource;
    Contenuti: TjdxDataSource;
    Orari: TjdxDataSource;
    Stage: TjdxDataSource;
    procedure WebFormResize(Sender: TObject);
  private type
    TStage = record
    public
      IdTirocinio: integer;
      DescTirocinio: string;
      Nominativo: string;
      Titolo: string;
      Didascalia: string;
      DataInizio: TDateTime;
      DataFine: TDateTime;
      DurataOre: integer;
      MaxOreGiornaliere: integer;
      MaxOreSettimanali: integer;
      Ora_Min: integer;
      Ora_Max: integer;
      IntervalloOrario: integer;
      procedure Init;
    end;
  private
    Scheduler: TdxScheduler;
    Toolbar: TdxToolbar;
  private
    selectedID: integer;
    selectedData: TDateTime;
    ElencoStage: TJSArray;
    currentStage: TStage;
    selectedAppointment: TJSObject;

    ElencoContenuti: TJSArray;
    ElencoOrari: TJSArray;
  private
    [async]
    procedure CheckOperation(e: TJSObject; IUD: TIUD);
    procedure BeforePost(Appointment: TJSObject);
    function getAppointment(e: TJSObject): TJSObject;
    function ExtractDataFromAppointment(Appointment: TJSObject): TDateTime;
  private
    function overlaps(e: TJSObject): boolean;
    function SchedulerDate: TDateTime;
  private
    procedure aggiungiPresenza;
    procedure deletePresenzaSelezionata;
  private
    PresenzeApprovate: boolean;
    procedure ConfermaPresenze(conferma: boolean);
    procedure AbilitaPulsantiApprovazione(const aPresenzeApprovate: boolean);
    procedure AbilitaPulsantiModifica(const ModificheAbilitate: boolean);
    procedure SetButtonVisible(const buttonId: string; const Visible: boolean);
  private
    procedure LoadStage(obj: TJSObject);
    procedure LoadPresenze;
    procedure LoadElencoContenuti;
    procedure LoadOrari;
    procedure ReloadScheduler;
    procedure SelectStage(const IdTirocinio: integer);
  private
    function SchedulerHeight: string;
    procedure SetSchedulerHeight;
  private
    function IsTutor: boolean;
  private
    function ToolbarItems(items: TJSArray): TJSArray;
    procedure CreateScheduler;
    function SchedulerItems(Appointment: TJSObject): TJSArray;
  public
    [async]
    procedure AfterCreate(const id: integer = -1); override;
  end;

var
  FormStagePresenze: TFormStagePresenze;

implementation

uses
  libjquery,
  DevExtreme.utils,
  DevExtreme.Types,
  DevExtreme.base,
  DevExtreme.factory,
  DevExtreme.Options,
  DevExtreme.Toolbar,
  zz.Web.user,
  zz.Web.JS,
  zz.Web.fetch,
  zz.Web.url;

{$R *.dfm}

procedure TFormStagePresenze.TStage.Init;
begin
  IdTirocinio := -1;
  DescTirocinio := '';
  Nominativo := '';
  Titolo := '';
  Didascalia := '';
  DataInizio := 0;
  DataFine := 0;
  DurataOre := -1;
  MaxOreGiornaliere := -1;
  MaxOreSettimanali := -1;
  Ora_Min := -1;
  Ora_Max := -1;
  IntervalloOrario := -1;
end;

procedure TFormStagePresenze.AfterCreate(const id: integer);
var
  Options: TJSObject;
  fields: TJSArray;
  o: TJSObject;
begin
  inherited;

  PresenzeApprovate := false;
  Scheduler := nil;
  Toolbar := nil;

  user.TipoUser.Check([tuTutor, tuStudente]);

  selectedID := -1;
  selectedData := 0;

  currentStage.Init;
  selectedAppointment := nil;
  ElencoContenuti := TJSArray.new;

  Stage.load()._then(
    function(aValue: JSValue): JSValue
    var
      PrimoStage: TJSObject;
    begin
      console.log('ElencoStage', aValue);
      ElencoStage := JS.toArray(aValue);

      if ElencoStage.length = 0 then
      begin
        Close;
        ShowMessage('Presenze', 'Nessun tirocinio/stage attivo.');
      end;

      PrimoStage := JS.toObject(ElencoStage[0]);
      LoadStage(PrimoStage);

      CreateScheduler;
    end);
end;

procedure TFormStagePresenze.LoadStage(obj: TJSObject);
begin
  currentStage.Init;

  if not assigned(obj) then
    exit;

  currentStage.IdTirocinio := JS.toInteger(obj['ID_TIROCINIO']);
  currentStage.DescTirocinio := JS.ToString(obj['DESC_TIROCINIO']);
  currentStage.Nominativo := JS.ToString(obj['NOMINATIVO']);
  currentStage.Titolo := JS.ToString(obj['TITOLO']);
  currentStage.Didascalia := JS.ToString(obj['DIDASCALIA']);
  currentStage.DataInizio := ISO8601ToDate(JS.ToString(obj['DATA_INIZIO']));
  currentStage.DataFine := ISO8601ToDate(JS.ToString(obj['DATA_FINE']));
  currentStage.DurataOre := JS.toInteger(obj['DURATA_ORE']);
  currentStage.MaxOreGiornaliere := JS.toInteger(obj['MAX_ORE_GIORNALIERE']);
  currentStage.MaxOreSettimanali := JS.toInteger(obj['MAX_ORE_SETTIMANALI']);
  currentStage.Ora_Min := JS.toInteger(obj['ORA_MIN']);
  currentStage.Ora_Max := JS.toInteger(obj['ORA_MAX']);
  currentStage.IntervalloOrario := JS.toInteger(obj['INTERVALLO_ORARIO']);

  LoadOrari;
  LoadElencoContenuti;
end;

procedure TFormStagePresenze.LoadPresenze;
var
  DalGiorno, AlGiorno: TDateTime;
begin
  PresenzeApprovate := true;

  DalGiorno := JSDateToDateTime(Scheduler.getStartViewDate);
  AlGiorno := JSDateToDateTime(Scheduler.getEndViewDate);

  Presenze.SetParam('ID_TIROCINIO', currentStage.IdTirocinio.ToString);
  Presenze.SetParam('DAL_GIORNO', DateToISO8601(DalGiorno));
  Presenze.SetParam('AL_GIORNO', DateToISO8601(AlGiorno));

  Presenze.reload()._then(
    function(aValue: JSValue): JSValue
    var
      Data: TJSArray;
    begin
      console.log('Presenze', aValue);
      Data := JS.toArray(aValue);

      TdxUtils.Notify('Loaded: ' + Data.length.ToString);

      if Data.length = 0 then
        PresenzeApprovate := false
      else
        Data.forEach(
          function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
          var
            rec: TJSObject;
          begin
            rec := JS.toObject(element);
            rec['disabled'] := rec['VALIDATO'];

            if JS.toBoolean(rec['VALIDATO']) = false then
              PresenzeApprovate := false;
          end);

      Scheduler.repaint;

      if not IsTutor then
        AbilitaPulsantiModifica(not PresenzeApprovate);

      if IsTutor then
        AbilitaPulsantiApprovazione(PresenzeApprovate);
    end);
end;

procedure TFormStagePresenze.LoadElencoContenuti;
begin
  ElencoContenuti := TJSArray.new; // se già esistente lo sovrascrive

  Contenuti.params.Clear;
  Contenuti.SetParam('ID_TIROCINIO', currentStage.IdTirocinio.ToString);
  Contenuti.reload._then(
    function(aValue: JSValue): JSValue
    var
      Data: TJSArray;
    begin
      console.log('Contenuti', aValue);
      Data := JS.toArray(aValue);

      Data.forEach(
        function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
        begin
          ElencoContenuti.push(JS.toObject(element)['CONTENUTI']);
        end);
    end);
end;

procedure TFormStagePresenze.LoadOrari;
begin
  ElencoOrari := TJSArray.new; // se già esistente lo sovrascrive

  Orari.params.Clear;
  Orari.SetParam('ID_TIROCINIO', currentStage.IdTirocinio.ToString);
  Orari.reload._then(
    function(aValue: JSValue): JSValue
    var
      Data: TJSArray;
    begin
      console.log('Orari', aValue);
      Data := JS.toArray(aValue);

      Data.forEach(
        function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
        begin
          ElencoOrari.push(JS.toObject(element)['ORA']);
        end);
    end);

end;

procedure TFormStagePresenze.aggiungiPresenza;
var
  Data, startDate, endDate: TJSDate;
  schedulerData: TJSArray;
  Appointment: TJSObject;
  selectedCellData: JSValue;
begin
  Data := TJSDate(Scheduler.option('currentDate'));

  selectedCellData := Scheduler.option('selectedCellData');

  if assigned(selectedCellData) then
  begin
    asm
      startDate = selectedCellData[0].startDate;
      endDate = selectedCellData[selectedCellData.length-1].endDate;
    end;
  end
  else
  begin
    startDate := Data;
    endDate := Data;
  end;

  schedulerData := JS.toArray(Scheduler.option('dataSource'));

  Appointment := new([]);
  Appointment['ID_STAGE_PRESENZA_WEB'] := -1;
  Appointment['ID_TIROCINIO'] := currentStage.IdTirocinio;
  Appointment['SMART_WORKING'] := false;
  Appointment['DATA_LEZIONE'] := DateToISO8601(JSDateToDateTime(Data));
  Appointment['ORA_INIZIO'] := startDate;
  Appointment['ORA_FINE'] := endDate;
  Appointment['CONTENUTI'] := '';

  Scheduler.showAppointmentPopup(Appointment, true, new([]));
end;

procedure TFormStagePresenze.deletePresenzaSelezionata;
begin

  if selectedID = -1 then
    TdxUtils.Alert('Nessuna presenza selezionata.', 'Cancellazione')
  else
  begin

    TdxUtils.Confirm('Eliminare la presenza selezionata?', 'Eliminare la presenza selezionata?')._then(
      function(aValue: JSValue): JSValue
      begin
        Scheduler.deleteAppointment(selectedAppointment);
      end);
  end;
end;

function TFormStagePresenze.ToolbarItems(items: TJSArray): TJSArray;

  function toolButton(const caption, hint, icon, id: string; Visible: boolean; hideCaptionIfIsPhone: boolean; onClick: TdxEventHandlerFunc): TJSObject;
  var
    Options: TJSObject;
    elementAttr: TJSObject;
  begin
    Options := TJSObject.new;
    Options['icon'] := icon;
    Options['hint'] := hint;
    Options['onClick'] := onClick;
    Options['visible'] := Visible;

    if caption.IsEmpty or (TdxUtils.isPhone and hideCaptionIfIsPhone) then
      Options['width'] := 25
    else
    begin
      Options['text'] := caption;
      Options['width'] := 'auto';
    end;

    if not id.IsEmpty then
    begin
      elementAttr := TJSObject.new;
      elementAttr['id'] := id;
      Options['elementAttr'] := elementAttr;
    end;

    result := TJSObject.new;
    result['location'] := 'before';
    result['locateInMenu'] := 'auto';
    result['widget'] := 'dxButton';
    result['options'] := Options;
  end;

  function ComboStage(): TJSObject;
  var
    editorOptions: TJSObject;
    inputAttr: TJSObject;
  begin
    editorOptions := TJSObject.new;
    editorOptions['width'] := '100%';
    editorOptions['acceptCustomValue'] := true;
    editorOptions['openOnFieldClick'] := true;
    editorOptions['showDropDownButton'] := true;
    editorOptions['searchEnabled'] := true;
    editorOptions['items'] := ElencoStage;
    editorOptions['displayExpr'] := 'NOMINATIVO';
    editorOptions['valueExpr'] := 'ID_TIROCINIO';
    editorOptions['value'] := currentStage.IdTirocinio;
    editorOptions['width'] := 300;
    editorOptions['onValueChanged'] := function(e: TJSObject): JSValue
      var
        id: integer;
      begin
        id := JS.toInteger(e['value']);
        SelectStage(id);
      end;

    result := TJSObject.new;
    result['location'] := 'before';
    result['locateInMenu'] := 'auto';
    result['widget'] := 'dxSelectBox';
    result['options'] := editorOptions;
  end;

begin
  result := items; // TJSArray.new;

  if IsTutor then
    result.push(ComboStage);

  result.push(TdxToolbar.Separator);

  result.push(toolButton('Aggiungi', 'aggiungi presenza', 'plus', 'btnAggiungiPresenza', true, false,
    function(e: TJSObject): JSValue
    begin
      aggiungiPresenza;
    end));

  result.push(toolButton('Elimina', 'elimina presenza', 'minus', 'btnEliminaPresenza', true, false,
    function(e: TJSObject): JSValue
    begin
      deletePresenzaSelezionata;
    end));

  if IsTutor then
    result.push(TdxToolbar.Separator);

  if IsTutor then
    result.push(toolButton('Conferma Presenze', 'conferma le presenze della settimana', 'check', 'btnConferma', not PresenzeApprovate, true,
      function(e: TJSObject): JSValue
      begin

        Confirm('Conferma Presenze', 'Confermare le presenze della settimana?',
          procedure
          begin
            ConfermaPresenze(true);
          end, nil);
      end));

  if IsTutor then
    result.push(toolButton('Annulla Presenze', 'annulla la conferma delle presenze', 'clear', 'btnAnnulla', PresenzeApprovate, true,
      function(e: TJSObject): JSValue
      begin

        Confirm('Annulla Presenze', 'Annullare la conferma delle presenze della settimana?',
          procedure
          begin
            ConfermaPresenze(false);
          end, nil);
      end));
end;

procedure TFormStagePresenze.CreateScheduler;
var
  Options: TJSObject;
  views: TJSArray;
begin
  Options := dxOptions.Scheduler('scheduler');

  Options['timeZone'] := 'Europe/Rome';
  Options['dateSerializationFormat'] := 'yyyy-MM-ddTHH:mm:ss';
  Options['dataSource'] := Presenze.DataSource;

  views := TJSArray.new;
  views.push('week');
  views.push('day');
  Options['views'] := views;

  if IsTutor then
    Options['currentView'] := 'week'
  else
    Options['currentView'] := 'day';

  Options['currentDate'] := DateTimeToJSDate(Date); // oggi
  Options['startDayHour'] := currentStage.Ora_Min;
  Options['endDayHour'] := currentStage.Ora_Max;
  Options['cellDuration'] := currentStage.IntervalloOrario;
  Options['showAllDayPanel'] := false;
  Options['adaptivityEnabled'] := true;
  Options['useDropDownViewSwitcher'] := false;
  Options['crossScrollingEnabled'] := true;
  Options['startDateExpr'] := 'ORA_INIZIO';
  Options['endDateExpr'] := 'ORA_FINE';
  Options['textExpr'] := 'CONTENUTI';
  Options['width'] := '100%';
  Options['height'] := SchedulerHeight;
  /// /

  Options['onInitialized'] := function(e: TJSObject): JSValue
    begin
      Scheduler := TdxScheduler(e['component']);
    end;

  Options['onContentReady'] := function(e: TJSObject): JSValue
    var
      items: TJSArray;
      item: JSValue;
      tb: TdxToolbar;
    begin

      asm
        e.component.getWorkSpaceScrollable().option('showScrollbar', 'always');
        try {
        tb = e.element.find('.dx-toolbar').dxToolbar('instance');
         }
        catch {
        tb = null;
         }
      end;

      if assigned(tb) then
      begin
        Toolbar := tb;
        Toolbar.beginUpdate;
        try
          items := JS.toArray(Toolbar.option('items'));

          // se trova il bottone aggiungi evita di riassegnare i bottoni
          item := items.find(
            function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
            var
              item, Options: TJSObject;
            begin
              result := false;
              item := JS.toObject(element);

              if item.hasOwnProperty('options') then
              begin
                Options := JS.toObject(item['options']);

                if Options.hasOwnProperty('text') then
                  if JS.ToString(Options['text']) = 'Aggiungi' then
                    result := true;
              end;
            end);

          if not assigned(item) then
            Toolbar.option('items', ToolbarItems(items));
        finally
          Toolbar.endUpdate;
        end;
      end;
    end;

  Options['onOptionChanged'] := function(e: TJSObject): JSValue
    var
      propertyName: string;
    begin
      propertyName := JS.ToString(e['fullName']);

      if (propertyName = 'currentDate') or (propertyName = 'currentView') then
      begin

        selectedID := -1;
        selectedData := 0;
        selectedAppointment := nil;

        window.setTimeout(
          procedure
          begin
            LoadPresenze; // ReloadScheduler;    end, 50);
          end);
      end;
    end;

  Options['onCellClick'] := function(e: TJSObject): JSValue
    var
      cellData: TJSObject;
      startDate: TJSDate;
    begin
      //
      selectedID := -1;
      selectedData := 0;
      selectedAppointment := nil;

      cellData := JS.toObject(e['cellData']);

      if assigned(cellData) then
      begin
        startDate := TJSDate(cellData['startDate']);
        selectedData := JSDateToDateTime(startDate);
      end;
    end;

  // Options['onAppointmentClick'] := function(e: TJSObject): JSValue
  Options['onAppointmentTooltipShowing'] := function(e: TJSObject): JSValue
    var
      id: integer;
      appointmentData: TJSObject;
    begin
      e['cancel'] := true; // evita l'apertura del tooltip

      asm
        appointmentData = e.appointments[0].appointmentData;
        id = appointmentData.ID_STAGE_PRESENZA_WEB;
      end;

      selectedID := id;
      selectedAppointment := appointmentData;

      selectedData := ExtractDataFromAppointment(selectedAppointment);
    end;

  Options['appointmentTemplate'] := function(Data: TJSObject; index: integer; element: TJSElement): JSValue
    var
      Appointment: TJSObject;
      Contenuti: string;
    begin
      Appointment := getAppointment(Data);
      Contenuti := JS.ToString(Appointment['CONTENUTI']);

      element.innerHTML := '';
      result := Contenuti;
    end;

  Options['onAppointmentAdding'] := function(e: TJSObject): JSValue
    begin

      if PresenzeApprovate then
        e['cancel'] := true
      else
        CheckOperation(e, iudInsert);
    end;

  Options['onAppointmentAdded'] := function(e: TJSObject): JSValue
    begin
      ReloadScheduler;
      LoadElencoContenuti;
    end;

  Options['onAppointmentUpdating'] := function(e: TJSObject): JSValue
    begin
      if PresenzeApprovate then
        e['cancel'] := true
      else
        CheckOperation(e, iudUpdate);
    end;

  Options['onAppointmentUpdated'] := function(e: TJSObject): JSValue
    begin
      ReloadScheduler;
      LoadElencoContenuti;
    end;

  Options['onAppointmentDeleting'] := function(e: TJSObject): JSValue
    begin

      if PresenzeApprovate then
        e['cancel'] := true
      else
        CheckOperation(e, iudDelete);
    end;

  Options['onAppointmentDeleted'] := function(e: TJSObject): JSValue
    begin
      ReloadScheduler;
    end;

  Options['onAppointmentFormOpening'] := function(e: TJSObject): JSValue
    var
      Popup: TdxPopup;
      Form: TdxForm;
      ToolbarItems: TJSArray;
      Appointment: TJSObject;
      validata: boolean;
    begin
      Appointment := getAppointment(e);

      if assigned(Appointment) then
        validata := JS.toBoolean(Appointment['VALIDATO'])
      else
        validata := false;

      if IsTutor then // consentite le modifiche
        validata := false;

      Popup := TdxPopup(e['popup']);
      Popup.option('showTitle', true);
      Popup.option('title', currentStage.Titolo);
      Popup.option('minWidth', 600);

      Form := TdxForm(e['form']);
      Form.option('colCount', 3);
      Form.option('colCountByScreen', null);
      Form.option('items', SchedulerItems(Appointment));

      ToolbarItems := JS.toArray(Popup.option('toolbarItems'));
      ToolbarItems.forEach(
        function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
        var
          obj, Options: TJSObject;
          shortcut: string;
        begin
          obj := JS.toObject(element);
          shortcut := JS.ToString(obj['shortcut']);

          Options := JS.toObject(obj['options']);
          if not assigned(Options) then
          begin
            Options := TJSObject.new;
            obj['options'] := Options;
          end;

          if sameText(shortcut, 'done') then
          begin
            Options['visible'] := not validata;
          end
          else
            if sameText(shortcut, 'cancel') then
            begin

              if validata then
                Options['text'] := 'Chiudi'
              else
                Options['text'] := 'Annulla';
            end
        end);
      Popup.option('toolbarItems', ToolbarItems);
    end;

  dxFactory.Scheduler('#scheduler', Options);
end;

procedure TFormStagePresenze.WebFormResize(Sender: TObject);
begin
  inherited;
  SetSchedulerHeight;
end;

procedure TFormStagePresenze.ReloadScheduler;
begin
  Presenze.reload;
  Scheduler.repaint;
end;

function TFormStagePresenze.getAppointment(e: TJSObject): TJSObject;
begin
  result := nil;

  if e.hasOwnProperty('appointmentData') then
    result := JS.toObject(e['appointmentData'])
  else
    if e.hasOwnProperty('newData') then
      result := JS.toObject(e['newData'])
    else
      result := e;
end;

function TFormStagePresenze.IsTutor: boolean;
begin
  result := user.TipoUser = tuTutor;
end;

function TFormStagePresenze.ExtractDataFromAppointment(Appointment: TJSObject): TDateTime;
begin
  result := 0;

  if Appointment.hasOwnProperty('DATA_LEZIONE') then
    result := ISO8601ToDate(JS.ToString(Appointment['DATA_LEZIONE']))
  else
    if Appointment.hasOwnProperty('ORA_INIZIO') then
      result := ISO8601ToDate(JS.ToString(Appointment['ORA_INIZIO']))
    else
      if selectedData <> 0 then
        result := selectedData
      else
        result := SchedulerDate;
end;

procedure TFormStagePresenze.BeforePost(Appointment: TJSObject);
var
  Data: TJSDate;
  DataLezione: TDateTime;

  Inizio, Fine: TDateTime;
  Contenuti: string;
begin
  Appointment['ID_TIROCINIO'] := currentStage.IdTirocinio;

  if (not Appointment.hasOwnProperty('DATA_LEZIONE')) or (JS.ToString(Appointment['DATA_LEZIONE']) = '') then
  begin
    DataLezione := ExtractDataFromAppointment(Appointment);
    Appointment['DATA_LEZIONE'] := DateToISO8601(DataLezione);
  end;

  if not Appointment.hasOwnProperty('SMART_WORKING') then
    Appointment['SMART_WORKING'] := false
  else
    if JS.isNull(Appointment['SMART_WORKING']) then
      Appointment['SMART_WORKING'] := false;
end;

function TFormStagePresenze.overlaps(e: TJSObject): boolean;
var
  i: integer;
  newAppointment, currAppointment: TJSObject;
  schedulerData: TJSArray;
  range1Start, range1End, range2Start, range2End: NativeInt;

  function GetTime(j: JSValue): NativeInt;
  var
    Data: TJSDate;
  begin
    Data := TJSDate(j);
    result := Data.Time;
  end;

begin

  asm
    var newAppointment = e.newData || e.appointmentData;
    var schedulerData = e.component.option("dataSource");
  end;

  for i := 0 to schedulerData.length - 1 do
  begin
    currAppointment := JS.toObject(schedulerData[i]);

    if (JS.toInteger(currAppointment['ID']) <> JS.toInteger(newAppointment['ID'])) then
    begin
      range1Start := GetTime(newAppointment['ORA_INIZIO']);
      range1End := GetTime(newAppointment['ORA_FINE']);
      range2Start := GetTime(currAppointment['ORA_INIZIO']);
      range2End := GetTime(currAppointment['ORA_FINE']);

      if ((range1Start < range2End) and (range2Start < range1End)) then
      begin
        result := true;
        exit;
      end;
    end;
  end;

  result := false;
end;

procedure TFormStagePresenze.CheckOperation(e: TJSObject; IUD: TIUD);
var
  d: TDeferred;
  params: TJSObject;
  PostData: string;
  Appointment: TJSObject;
  s: String;
begin
  //
  // CREATE OR ALTER PROCEDURE WEB_STAGE_PRESENZE_IS_OK (
  // ID_SESSIONE_WEB       ID,
  // IUD                   IUD,
  // ID_STAGE_PRESENZA_WEB ID,
  // ID_TIROCINIO          ID,
  // DATA_LEZIONE          DATA,
  // ORA_INIZIO            ORA,
  // ORA_FINE              ORA,
  // CONTENUTI             CONTENUTI)
  // RETURNS (
  // OK        TRUE_FALSE,
  // MESSAGGIO DESCRIZIONE)
  //

  Appointment := getAppointment(e);
  BeforePost(Appointment);

  params := TJSObject.new;
  params['IUD'] := IUD.AsString;
  params['ID_STAGE_PRESENZA_WEB'] := Appointment['ID_STAGE_PRESENZA_WEB'];
  params['ID_TIROCINIO'] := Appointment['ID_TIROCINIO'];
  params['DATA_LEZIONE'] := Appointment['DATA_LEZIONE'];
  params['ORA_INIZIO'] := Appointment['ORA_INIZIO'];
  params['ORA_FINE'] := Appointment['ORA_FINE'];

  params['SMART_WORKING'] := Appointment['SMART_WORKING'];

  if JS.isNull(params['SMART_WORKING']) then
    params['SMART_WORKING'] := false;

  params['CONTENUTI'] := Appointment['CONTENUTI'];
  PostData := TDataRequest.GetDataRequest(rtExecSP, Stage.dm, 'WEB_STAGE_PRESENZE_VERIFICA', '', JSObjectToString(params), nil);

  d := deferred();
  e['cancel'] := d;

  fetch(TUrl.DataRequest, PostData)._then(
    function(value: JSValue): JSValue
    begin
      d.resolve(false); // è cancel, quindi false
    end,
    function(value: JSValue): JSValue
    var
      ErrorMsg: String;
    begin
      ErrorMsg := JS.ToString(value);
      TdxUtils.Alert('Errore', ErrorMsg);
      d.resolve(true); // cancel=true
    end);
end;

function TFormStagePresenze.SchedulerItems(Appointment: TJSObject): TJSArray;

  function add(colSpan: integer; dataField, caption, editorType: string; editorOptions: TJSObject): TJSObject;
  var
    label_: TJSObject;
  begin
    result := new([]);
    result['colSpan'] := colSpan;
    result['name'] := dataField;
    result['dataField'] := dataField;
    result['editorType'] := editorType;
    result['editorOptions'] := editorOptions;

    label_ := new([]);
    label_['text'] := caption;
    result['label'] := label_;
  end;

  function OrarioOptions(): TJSObject;
  begin
    result := new([]);
    result['width'] := '100%';
    result['acceptCustomValue'] := false;
    result['openOnFieldClick'] := true;
    result['showDropDownButton'] := true;
    result['searchEnabled'] := true;
    result['dataSource'] := ElencoOrari;
  end;

  function jsTimeToStr(j: JSValue): string;
  var
    d: TJSDate;
    dateTime: TDateTime;
    h, m, s, ms: word;
  begin

    if JS.IsString(j) then
      d := TJSDate.new(JS.ToString(j))
    else
      d := TJSDate(j);

    // d.hours/minutes sembra non funzionare
    // result := d.Hours().ToString.PadLeft(2, '0') + ':' + d.Minutes().ToString.PadLeft(2, '0');

    dateTime := JSDateToDateTime(d);

    DecodeTime(dateTime, h, m, s, ms);

    result := h.ToString.PadLeft(2, '0') + ':' + m.ToString.PadLeft(2, '0');
  end;

var
  item, editorOptions: TJSObject;
  validata: boolean;
begin
  result := TJSArray.new;

  validata := false;
  if assigned(Appointment) then
    validata := JS.toBoolean(Appointment['VALIDATO']);
  //
  if not validata then
  begin
    item := new([]);
    item['colSpan'] := 3;
    item['template'] := function(Data: TJSObject; element: TJSElement): JSValue
      var
        e: TJSElement;
      begin
        e := document.CreateElement('DIV');
        e.innerHTML := currentStage.Didascalia;
        element.append(e);
      end;

    result.push(item);
  end;
  //
  editorOptions := OrarioOptions();
  editorOptions['readOnly'] := validata;
  editorOptions['isRequired'] := not validata;
  if assigned(Appointment) then
    editorOptions['value'] := jsTimeToStr(Appointment['ORA_INIZIO']);
  result.push(add(1, 'ORA_INIZIO', 'Ora Inizio', 'dxSelectBox', editorOptions));

  editorOptions := OrarioOptions();
  editorOptions['readOnly'] := validata;
  editorOptions['isRequired'] := not validata;
  if assigned(Appointment) then
    editorOptions['value'] := jsTimeToStr(Appointment['ORA_FINE']);
  result.push(add(1, 'ORA_FINE', 'Ora Fine', 'dxSelectBox', editorOptions));
  //
  editorOptions := new([]);
  editorOptions['readOnly'] := validata;
  editorOptions['isRequired'] := not validata;
  result.push(add(1, 'SMART_WORKING', 'Smart Working', 'dxCheckBox', editorOptions));
  //
  editorOptions := new([]);
  editorOptions['width'] := '100%';
  editorOptions['acceptCustomValue'] := true;
  editorOptions['openOnFieldClick'] := true;
  editorOptions['showDropDownButton'] := true;
  editorOptions['searchEnabled'] := true;
  editorOptions['dataSource'] := ElencoContenuti;
  editorOptions['maxLength'] := 200;
  editorOptions['readOnly'] := validata;
  editorOptions['isRequired'] := not validata;
  result.push(add(3, 'CONTENUTI', 'Attività Svolta', 'dxSelectBox', editorOptions));

  // Validata
  if validata then
  begin
    item := new([]);
    item['template'] := function(Data: TJSObject; element: TJSElement): JSValue
      var
        e: TJSElement;
      begin
        e := document.CreateElement('DIV');
        e.innerHTML := 'Attività validata';
        element.append(e);
      end;

    result.push(item);
  end;
  //
end;

procedure TFormStagePresenze.SetSchedulerHeight;
begin
  window.setTimeout(
    procedure
    begin

      if assigned(Scheduler) then
        Scheduler.option('height', SchedulerHeight);
    end, 50);
end;

function TFormStagePresenze.SchedulerDate: TDateTime;
var
  jData: TJSDate;
begin
  jData := TJSDate(Scheduler.option('currentDate'));
  result := JSDateToDateTime(jData);
end;

function TFormStagePresenze.SchedulerHeight: string;
// var
// winheight, header, footer, Toolbar, Main, drawer: integer;
// begin
// // occorre impostare l'altezza per lo scroll
//
// winheight := JQuery(window).height();
// header := JQuery('#toolbar').height();
// footer := JQuery('#footer').height();
// Toolbar := JQuery('#schedulerToolbar').height();
//
// if (Toolbar) = 0 then
// Toolbar := 50;
// //
// Main := winheight - header - footer - Toolbar;
// //
// result := (Main - 20).ToString + 'px';
// end;
var
  winheight, header, footer, Main, drawer: integer;
begin
  // occorre impostare l'altezza per lo scroll

  winheight := JQuery(window).height();
  header := JQuery('#toolbar').height();
  footer := JQuery('#footer').height();
  //
  Main := winheight - header - footer;

  result := (Main - 50 - 1).ToString + 'px';
end;

procedure TFormStagePresenze.AbilitaPulsantiModifica(const ModificheAbilitate: boolean);
begin
  SetButtonVisible('btnAggiungiPresenza', ModificheAbilitate);
  SetButtonVisible('btnEliminaPresenza', ModificheAbilitate);
end;

procedure TFormStagePresenze.SetButtonVisible(const buttonId: string; const Visible: boolean);
var
  e: TJSElement;
begin
  // https://supportcenter.devexpress.com/ticket/details/t719389/toolbar-widget-how-to-hide-show-buttons-dynamically-in-response-to-events
  // https://js.devexpress.com/jQuery/Documentation/ApiReference/UI_Components/dxButton/Methods/#getInstanceelement

  e := document.getElementById(buttonId);

  asm
    let instance = DevExpress.ui.dxButton.getInstance(e);
    instance.option('visible', Visible);
  end;
end;

procedure TFormStagePresenze.AbilitaPulsantiApprovazione(const aPresenzeApprovate: boolean);
begin
  PresenzeApprovate := aPresenzeApprovate;

  SetButtonVisible('btnConferma', not PresenzeApprovate);
  SetButtonVisible('btnAnnulla', PresenzeApprovate);
end;

procedure TFormStagePresenze.ConfermaPresenze(conferma: boolean);
var
  DataLezione: TDateTime;
  params: TJSObject;
begin
  DataLezione := SchedulerDate;
  PresenzeApprovate := conferma;
  //
  params := TJSObject.new;
  params['ID_TIROCINIO'] := currentStage.IdTirocinio;
  params['DATA_LEZIONE'] := DateToISO8601(DataLezione);
  params['APPROVATO'] := PresenzeApprovate;

  base.sp(Stage.dm, 'WEB_STAGE_PRESENZE_APPROVA', params, nil);

  //
  AbilitaPulsantiApprovazione(conferma);
end;

procedure TFormStagePresenze.SelectStage(const IdTirocinio: integer);
var
  idx: integer;
  Stage: TJSObject;
begin

  idx := ElencoStage.findIndex(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      o: TJSObject;
    begin
      o := JS.toObject(element);
      result := JS.toInteger(o['ID_TIROCINIO']) = IdTirocinio;
    end);

  if idx <> -1 then
  begin
    Stage := JS.toObject(ElencoStage[idx]);
    LoadStage(Stage);

    PresenzeApprovate := true;
    Presenze.SetParam('ID_TIROCINIO', currentStage.IdTirocinio.ToString);
    ReloadScheduler;

    console.log(Stage);
  end;
end;

end.
