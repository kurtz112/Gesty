unit mainFrm;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Vcl.Controls,
  Vcl.StdCtrls,

  JS,
  Web,
  libjquery,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  WEBLib.JSON,
  WEBLib.StdCtrls,
  WEBLib.WebTools;

type
  TMain = class(TWebForm)
    procedure WebFormDestroy(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
  private
    pages: TList<string>;
    currentPage: String;
    function currentPageIndex: integer;

    procedure SetPageVisibility(const id: string; visible: boolean);
    procedure ShowPage(const id: string);
    procedure HidePage(const id: string);

    function NextAvailPage: string;
    function CanNextPage: boolean;
    procedure GotoNextPage;

    function PrevAvailPage: string;
    function CanPrevPage: boolean;
    procedure GotoPrevPage;
    procedure UpdateButtons;
    function PageCompleted: boolean;
    function IsLastQuestionPage: boolean;
    function IsConfirmPage: boolean;

    function PrecedenteClick(aEvent: TJSMouseEvent): boolean;
    function SuccessivoClick(aEvent: TJSMouseEvent): boolean;
  private
    isPhone: boolean;
    SpaceBetweenButtons: integer;
    starSize: integer;
    PageIndexContainerWidth: string;
    PageIndexWidth: string;
    PageProgressWidth: string;
    FontSize_1: string;
    FontSize_2: string;
    FontSize_4: string;
    FontSize_5: string;
    CardPadding: string;
    CardMarginTop: string;
    CardMarginBottom: string;
    WizContainerWidth: string;
    WizContainerMarginTop: string;
    procedure PrepareMediaQuery;
  private
    function CreateWizContainer: TJSHTMLElement;

    function CreateCard(parent: TJSHTMLElement; const id, css: string): TJSHTMLElement;
    function CreatePage(parent: TJSHTMLElement; const id: string; const header: string; legenda: string): TJSHTMLElement;

    procedure CreateStatusbar(parent: TJSHTMLElement);
    procedure UpdateStatusbar;
    procedure HideStatusbar;

    procedure CreateTitolo(parent: TJSHTMLElement; const Titolo: string);
    procedure CreateWizard;

    function CreateVociSezione(parent: TJSHTMLElement; SezioneIdx: integer; Sezione: TJSObject): TJSHTMLElement;
    procedure CreateSuggerimenti(parent: TJSHTMLElement);

    procedure CreateLoader(parent: TJSHTMLElement);
    procedure CreateFinale(parent: TJSHTMLElement);
  private
    function CreateSceltaMultipla(parent: TJSHTMLElement; id: string; items: TJSArray): TJSHTMLElement;
    function CreateSceltaSingola(parent: TJSHTMLElement; id: string; items: TJSArray): TJSHTMLElement;
  public
    function CreateCheckBox(parent: TJSHTMLElement; id: string; caption: string; item: TJSObject): TJSHTMLElement;
    function CreateRadio(parent: TJSHTMLElement; id, caption: string; items: TJSArray; item: TJSObject): TJSHTMLElement;
    function CreateStarRating(parent: TJSHTMLElement; id: string; item: TJSObject): TJSHTMLElement;
  private
    questionario: TJSObject;
    sezioni: TJSObject;

    function BaseUrl: string;
    procedure Load;
    procedure Send;
  private
  end;

var
  Main: TMain;

implementation

uses
  zz.Web.JsonResponse,
  zz.Web.JS,
  zz.Web.html,
  common;

const
  UtenteHaRisposto = '_rated_';

{$R *.dfm}

procedure TMain.WebFormCreate(Sender: TObject);
begin
  currentPage := '';
  pages := TList<string>.Create;

  PrepareMediaQuery;

  Load;
end;

procedure TMain.WebFormDestroy(Sender: TObject);
begin
  FreeAndNil(pages);
end;

function TMain.CreateCard(parent: TJSHTMLElement; const id, css: string): TJSHTMLElement;
begin
  result := _DIV(parent, 'container_' + id);
  result['class'] := css;
  // result.style.setProperty('margin', 'auto');
  result.style.setProperty('width', '100%');
  result.style.setProperty('padding', CardPadding);
  result.style.setProperty('margin-top', CardMarginTop);
  result.style.setProperty('margin-bottom', CardMarginBottom);
end;

function TMain.CreatePage(parent: TJSHTMLElement; const id: string; const header: string; legenda: string): TJSHTMLElement;
var
  card, h2, h4: TJSHTMLElement;
begin
  result := _DIV(parent, 'page_' + id);
  result.style.setProperty('width', '100%');
  result.style.setProperty('height', '100%');
  result.style.setProperty('display', 'none');

  if not header.IsEmpty then
  begin
    card := CreateCard(result, 'card_' + id, 'w3-card-2');

    h2 := CreateHTMLElement('HEADER', card, '', 'w3-container w3-indigo');
    _H2(h2, header, '', FontSize_2);
    h2.style.setProperty('height', 'auto');

    if not legenda.IsEmpty then
    begin
      h4 := CreateHTMLElement('HEADER', card, '', '');
      _H4(h4, legenda, '', FontSize_4);
      h4.style.setProperty('height', 'auto');
    end;
  end;

  pages.add(id);
end;

procedure TMain.SetPageVisibility(const id: string; visible: boolean);
var
  el: TJSHTMLElement;
begin
  el := TJSHTMLElement(document.getElementById('page_' + id));

  if visible then
    el.style.setProperty('display', 'block')
  else
    el.style.setProperty('display', 'none');
end;

procedure TMain.HidePage(const id: string);
begin
  SetPageVisibility(id, false);
end;

function TMain.IsConfirmPage: boolean;
begin
  result := currentPageIndex = pages.Count - 1;
end;

function TMain.IsLastQuestionPage: boolean;
begin
  // result := currentPageIndex = pages.Count - 2; // la -1 è la pagina di conferma
  result := currentPage = 'suggerimenti';
end;

procedure TMain.ShowPage(const id: string);
begin
  if not currentPage.IsEmpty then
    HidePage(currentPage);

  SetPageVisibility(id, true);

  currentPage := id;

  if IsConfirmPage then
    HideStatusbar
  else
  begin
    UpdateButtons;
    UpdateStatusbar;
  end;

  // For Safari
  document.body.scrollTop := 0;
  // For Chrome, Firefox, IE and Opera
  document.documentElement.scrollTop := 0;
end;

function TMain.NextAvailPage: string;
var
  idx: integer;
begin
  result := '';

  idx := pages.indexOf(currentPage);

  if idx <> -1 then
    if idx < pages.Count - 1 then
      result := pages[idx + 1];
end;

function TMain.BaseUrl: string;
begin
  // http://192.168.1.4/GestyServer/questionari/questionario?identificativo=A4129B13-C8FB-4244-8E2E-CC01DDE207E0

  result := JS.ToString(window['_URL']);

  if not result.EndsWith('/') then
    result := result + '/';
end;

function TMain.CanNextPage: boolean;
begin
  result := NextAvailPage <> '';
end;

procedure TMain.GotoNextPage;
begin

  if CanNextPage then
  begin
    if IsLastQuestionPage then
    begin
      if Confirm('Confermi l''invio del questionario?') then
        Send
      else
        exit;
    end
    else
      ShowPage(NextAvailPage);
  end;
end;

function TMain.PrevAvailPage: string;
var
  idx: integer;
begin
  result := '';

  idx := pages.indexOf(currentPage);

  if idx <> -1 then
    if idx > 0 then
      result := pages[idx - 1];
end;

function TMain.CanPrevPage: boolean;
begin
  result := PrevAvailPage <> '';
end;

procedure TMain.GotoPrevPage;
begin

  if CanPrevPage then
    ShowPage(PrevAvailPage);
end;

function TMain.CreateWizContainer: TJSHTMLElement;
begin
  result := _DIV(container, 'wizard');
  result.style.setProperty('margin', 'auto');
  result.style.setProperty('width', WizContainerWidth);
  result.style.setProperty('height', 'auto');
  result.style.setProperty('margin-top', WizContainerMarginTop);
end;

procedure TMain.CreateStatusbar(parent: TJSHTMLElement);
  procedure CreateButtons(parent: TJSHTMLElement);
  var
    button: TJSHTMLElement;
  begin
    button := CreateHTMLElement('BUTTON', parent, 'btnPrev', 'w3-button w3-indigo w3-ripple w3-left ' + FontSize_5);
    button.innerText := 'Indietro';
    button.OnClick := PrecedenteClick;

    button := CreateHTMLElement('BUTTON', parent, 'btnNext', 'w3-button w3-indigo w3-ripple w3-left ' + FontSize_5);
    button.innerText := 'Avanti';
    button.OnClick := SuccessivoClick;
    button.style.setProperty('margin-left', SpaceBetweenButtons.ToString + 'px');
  end;

  procedure CreateProgress(parent: TJSHTMLElement);
  var
    eOuter, eInner, pageBar, pageStr: TJSHTMLElement;
  begin
    // <div style="display: flex; height: 20px">
    //
    // <div style="height: 10px; width: 100%; margin-top: 5px; background-color: #ddd;">
    // <div id="pageBar" style="height: 100%; width: 1%; background-color: #04AA6D;"></div>
    // </div>
    //
    // <div style="width: 200px; height: 100%; margin-left: 20px;">
    // <p id="pageStr" style="margin: 0">Pagina 10 di 10</p>
    // </div>
    //
    // </div>

    eOuter := _DIV(parent, '');
    eOuter['class'] := 'w3-right';
    eOuter.style.setProperty('height', '43px');
    eOuter.style.setProperty('width', PageIndexContainerWidth);
    eOuter.style.setProperty('display', 'flex');
    eOuter.style.setProperty('flex-direction', 'row');
    eOuter.style.setProperty('align-items', 'center'); // allinemaneto verticale


    // ///////////////  pageBar

    eInner := _DIV(eOuter, '');
    eInner['class'] := 'w3-grey';
    eInner.style.setProperty('height', '20px');
    eInner.style.setProperty('width', PageProgressWidth);
    // @@    eInner.style.setProperty('margin-top', '12px');

    pageBar := _DIV(eInner, 'pageBar');
    pageBar['class'] := 'w3-indigo';
    // @@    pageBar.style.setProperty('height', '100%');
    pageBar.style.setProperty('width', '1%');

    // /////////////// pageStr

    eInner := _DIV(eOuter, '');
    // @@    eInner.style.setProperty('height', '100%');

    eInner.style.setProperty('width', PageIndexWidth);
    eInner.style.setProperty('margin-left', '10px');
    // @@eInner.style.setProperty('margin-top', '11px');
    eInner.style.setProperty('align', 'rigth');

    pageStr := _SPAN(eInner, 'Pagina 1 di 1', 'pageStr');
    pageStr['class'] := FontSize_5 + ' w3-right';
    pageStr.style.setProperty('margin', '0');
  end;

var
  e: TJSHTMLElement;
begin
  e := _DIV(parent, 'StatusBar');
  e.style.setProperty('width', '100%');
  e.style.setProperty('height', '50px');

  /// ////////////////////////////////
  CreateButtons(e);
  UpdateButtons;
  /// ////////////////////////////////
  CreateProgress(e);
end;

procedure TMain.CreateSuggerimenti(parent: TJSHTMLElement);
var
  card, p, textArea: TJSHTMLElement;
begin
  // <P>
  // <textarea name="textarea" style="width:80%;height:150px;">
  card := CreateCard(parent, 'card_suggerimenti', 'w3-card-2');
  p := CreateHTMLElement('P', card, '', '');
  textArea := CreateHTMLElement('textarea', p, 'text_suggerimenti', 'w3-border-0 ' + FontSize_5);
  textArea.style.setProperty('width', '100%');
  textArea.style.setProperty('height', '400px');

  textArea.onchange := function(Event: TEventListenerEvent): boolean
    begin
      questionario['SUGGERIMENTI'] := Event.target['value'];
    end;
end;

procedure TMain.CreateTitolo(parent: TJSHTMLElement; const Titolo: string);
var
  card, h1: TJSHTMLElement;
begin
  card := CreateCard(parent, 'card_titolo', 'w3-card-2');
  h1 := CreateHTMLElement('HEADER', card, '', 'w3-container'); // w3-indigo
  _H1(h1, Titolo, '', FontSize_1);

  h1.style.setProperty('height', 'auto');
end;

procedure TMain.CreateWizard;
var
  i: integer;
  Sezione: TJSObject;
  Titolo, descQuestionario, legenda: string;
  wizard, pageContainer, page: TJSHTMLElement;
begin
  Titolo := JS.ToString(questionario['TITOLO_QUESTIONARIO']);
  descQuestionario := JS.ToString(questionario['DESC_QUESTIONARIO']);
  legenda := JS.ToString(questionario['LEGENDA_VALUTAZIONI']);

  wizard := CreateWizContainer;
  CreateTitolo(wizard, Titolo);
  pageContainer := _DIV(wizard, 'pageContainer');
  pageContainer.style.setProperty('width', '100%');
  pageContainer.style.setProperty('height', 'auto');

  for i := 0 to JS.ToArray(sezioni['data']).length - 1 do
  begin
    Sezione := JS.ToObject(JS.ToArray(sezioni['data'])[i]);
    page := CreatePage(pageContainer, 'sezione_' + i.ToString, JS.ToString(Sezione['TITOLO_SEZIONE']), legenda);
    CreateVociSezione(page, i, Sezione);
  end;

  // finale
  page := CreatePage(pageContainer, 'suggerimenti', 'SEGNALAZIONI E SUGGERIMENTI che vorresti proporci', '');
  CreateSuggerimenti(page);

  // loader
  page := CreatePage(pageContainer, 'loader', '', '');
  CreateLoader(page);

  // finale
  page := CreatePage(pageContainer, 'finale', '', '');
  CreateFinale(page);

  // status
  CreateStatusbar(wizard);

  // init
  ShowPage(pages[0]);
end;

function TMain.CreateCheckBox(parent: TJSHTMLElement; id: string; caption: string; item: TJSObject): TJSHTMLElement;
var
  interesse: string;
  idInteresse: String;
  p, check, lbl: TJSHTMLElement;
begin
  p := CreateHTMLElement('P', parent, '', '');
  lbl := CreateHTMLElement('LABEL', p, '', FontSize_2);

  check := CreateHTMLElement('INPUT', lbl, id, 'w3-check');
  check['type'] := 'checkbox';
  check.style.setProperty('margin-right', '10px');

  check.onchange := function(Event: TEventListenerEvent): boolean
    begin
      item[UtenteHaRisposto] := true;
      item['CHECKED'] := Event.target['checked'];
      UpdateButtons;
    end;

  lbl.append(caption);
end;

function TMain.CreateRadio(parent: TJSHTMLElement; id, caption: string; items: TJSArray; item: TJSObject): TJSHTMLElement;
var
  interesse: string;
  idInteresse: String;
  p, radio, lbl: TJSHTMLElement;
begin
  p := CreateHTMLElement('P', parent, '', '');

  lbl := CreateHTMLElement('LABEL', p, '', FontSize_2);

  radio := CreateHTMLElement('INPUT', lbl, id, 'w3-radio');
  radio['type'] := 'radio';
  radio.name := id;
  radio['value'] := caption;
  radio.style.setProperty('margin-right', '10px');

  radio.onchange := function(Event: TEventListenerEvent): boolean
    begin
      // ZZ mail Serena 16.11.2023 resetta tutti gli altri items a false
      items.forEach(
        function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
        var
          item: TJSObject;
        begin
          item := JS.ToObject(element);
          item['CHECKED'] := false;
        end);

      item[UtenteHaRisposto] := true;
      item['CHECKED'] := Event.target['checked'];
      UpdateButtons;
    end;

  lbl.append(caption);
end;

function TMain.CreateStarRating(parent: TJSHTMLElement; id: string; item: TJSObject): TJSHTMLElement;
var
  e: TJSHTMLElement;
  options: TJSObject;
begin
  e := _DIV(parent, id);
  e['class'] := 'jq-stars';

  options := TJSObject.new;
  options['starSize'] := starSize;
  options['totalStars'] := 10;
  options['initialRating'] := 0;
  options['useFullStars'] := true;
  // options['starShape'] := 'rounded';
  options['useGradient'] := false;

  options['hoverColor'] := 'salmon';
  options['activeColor'] := 'cornflowerblue';
  // options['emptyColor'] := 'gold';
  options['ratedColor'] := 'gold!important';
  options['disableAfterRate'] := false;
  options['forceRoundUp'] := false;
  options['callback'] := procedure(rating: integer; e: TJSHTMLElement)
    begin
      item[UtenteHaRisposto] := true;
      item['VALUTAZIONE'] := rating;
      UpdateButtons;
    end;

  /// ///////////////////////////
  asm
    $("#" + id).starRating(options);
  end;
end;

function TMain.CreateVociSezione(parent: TJSHTMLElement; SezioneIdx: integer; Sezione: TJSObject): TJSHTMLElement;
var
  TipoSezione: TTipoSezione;
  TipoRisposta: TTipoRisposta;
  SezioneStr: string;
  voci: TJSArray;
  item: TJSObject;
begin
  SezioneStr := JS.ToString(Sezione['TITOLO_SEZIONE']);

  TipoSezione := TipoSezioneFromString(JS.ToString(Sezione['TIPO_SEZIONE']));
  TipoRisposta := TipoRispostaFromString(JS.ToString(Sezione['TIPO_RISPOSTA']));

  if Sezione.hasOwnProperty('Voci') then
  begin
    voci := JS.ToArray(Sezione['Voci']);

    voci.forEach(
      function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
      var
        item: TJSObject;
        idVoce: integer;
        voce: string;
        descVoce: string;
        card, h2, h4: TJSHTMLElement;
        tagVoce: String;
        e: TJSHTMLElement;
        vociItems: TJSArray;
      begin
        item := JS.ToObject(element);

        idVoce := JS.ToInteger(item['ID_VOCE']);
        voce := JS.ToString(item['VOCE']);
        descVoce := JS.ToString(item['DESC_VOCE']);

        card := CreateCard(parent, 'card_Sezione' + SezioneIdx.ToString + '_Voce_' + idVoce.ToString, 'w3-card-2');

        h2 := CreateHTMLElement('HEADER', card, '', '');
        _H2(h2, voce, '', FontSize_2);

        h4 := CreateHTMLElement('HEADER', card, '', '');
        _H4(h4, descVoce, '', FontSize_4);

        //
        tagVoce := '_Sezione' + SezioneIdx.ToString + '_Voce_' + idVoce.ToString;
        //
        case TipoRisposta of
          trValutazione:
            begin
              CreateStarRating(card, tagVoce, item);
            end;
          trSceltaSingola:
            begin
              vociItems := JS.ToArray(item['VociItems']);
              CreateSceltaSingola(card, tagVoce, vociItems);
            end;
          trSceltaMultipla:
            begin
              item[UtenteHaRisposto] := true; // si da per non required
              vociItems := JS.ToArray(item['VociItems']);
              CreateSceltaMultipla(card, tagVoce, vociItems);
            end;
        end;
      end);
  end;
end;

procedure TMain.CreateFinale(parent: TJSHTMLElement);
var
  card: TJSHTMLElement;
  p, lbl: TJSHTMLElement;
begin
  card := CreateCard(parent, 'card_Finale', 'w3-card-2');

  p := CreateHTMLElement('P', card, '', '');

  lbl := CreateHTMLElement('LABEL', p, '', FontSize_2);
  lbl.innerHTML := 'Gentile Studente' + '<br>' + 'le tue risposte sono state registrate correttamente.' + '<br>' + '<br>' + 'Ti ringraziamo per l’attenzione e il contributo espresso.' + '<br>';
end;

procedure TMain.CreateLoader(parent: TJSHTMLElement);
var
  card: TJSHTMLElement;
  p, lbl: TJSHTMLElement;
begin
  card := CreateCard(parent, 'card_Loader', 'w3-card-2');
  _DIV(card, 'loader');
end;

function TMain.CreateSceltaMultipla(parent: TJSHTMLElement; id: string; items: TJSArray): TJSHTMLElement;
var
  item: TJSObject;
  card: TJSHTMLElement;
begin
  card := CreateCard(parent, id, 'w3-card-2');

  items.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item: TJSObject;
      idVoce: string;
      interesse: string;
    begin
      item := JS.ToObject(element);
      idVoce := id + '_' + index.ToString;
      interesse := JS.ToString(item['RISPOSTA']);
      CreateCheckBox(card, id, interesse, item);
    end);
end;

function TMain.CreateSceltaSingola(parent: TJSHTMLElement; id: string; items: TJSArray): TJSHTMLElement;
var
  item: TJSObject;
  card: TJSHTMLElement;
begin
  card := CreateCard(parent, id, 'w3-card-2');

  items.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item: TJSObject;
      idVoce: string;
      interesse: string;
    begin
      item := JS.ToObject(element);
      idVoce := id + '_' + index.ToString;
      interesse := JS.ToString(item['RISPOSTA']);

      CreateRadio(card, id, interesse, items, item);
    end);
end;

procedure TMain.Load;
var
  url: string;
  JQXHR: TJQXHR;
  questionari: TJSObject;
begin
  // http://192.168.1.4/GestyServer/questionari/questionario?identificativo=A4129B13-C8FB-4244-8E2E-CC01DDE207E0

  url := BaseUrl + 'questionari/questionario?identificativo=' + GetQueryParam('IDENTIFICATIVO');

  /// //////////////////////////////////////////////////

  AjaxSetup('');
  AjaxPost(url, '')._then(
    function(value: JSValue): JSValue
    var
      o: TJSObject;
    begin
      o := JS.ToObject(value);
      questionari := JS.ToObject(o['Questionario']);
      questionario := JS.ToObject(JS.ToArray(questionari['data'])[0]);

      sezioni := JS.ToObject(o['Sezioni']);
      questionario['SUGGERIMENTI'] := '';

      CreateWizard;
    end,
    function(value: JSValue): JSValue
    var
      ErrorMsg: String;
    begin
      ErrorMsg := JS.ToString(value);
      raise Exception.Create(ErrorMsg);
    end);
end;

procedure TMain.UpdateButtons;
begin
  JQuery('#btnNext').prop('disabled', not PageCompleted);

  if IsLastQuestionPage then
    JQuery('#btnNext').html('Invia')
  else
    JQuery('#btnNext').html('Avanti');
end;

procedure TMain.HideStatusbar;
begin
  if IsConfirmPage then
    JQuery('#StatusBar').css('visibility', 'hidden');
end;

function TMain.currentPageIndex: integer;
begin
  result := pages.indexOf(currentPage);
end;

procedure TMain.UpdateStatusbar;
var
  PageIndex: integer;
  s: string;
  perc: integer;
  e: TJSHTMLElement;
begin
  PageIndex := currentPageIndex + 1;

  s := 'Pagina ' + PageIndex.ToString + ' di ' + (pages.Count - 1).ToString;
  e := document.getElementById('pageStr') as TJSHTMLElement;
  e.innerHTML := s;

  perc := Trunc((PageIndex / (pages.Count - 1)) * 100);
  e := document.getElementById('pageBar') as TJSHTMLElement;
  e.style.setProperty('width', perc.ToString + '%');
end;

function TMain.PrecedenteClick(aEvent: TJSMouseEvent): boolean;
begin
  GotoPrevPage;
end;

function TMain.SuccessivoClick(aEvent: TJSMouseEvent): boolean;
begin
  GotoNextPage;
end;

function TMain.PageCompleted: boolean;
  function ratingsOk(items: TJSArray): boolean;
  var
    i: integer;
    item: TJSObject;
    voci: TJSArray;
    v: integer;
    voce: TJSObject;
    esisteVoceOk: boolean;
  begin
    result := true;

    /// //////////////////
    // exit;
    /// //////////////////

    for i := 0 to items.length - 1 do
    begin
      item := JS.ToObject(items[i]);

      // if not item.hasOwnProperty('VALUTAZIONE') then
      if not item.hasOwnProperty(UtenteHaRisposto) then
      begin

        if not item.hasOwnProperty('VociItems') then
        begin
          // Showmessage(TJSJSON.stringify(item));
          exit;
        end
        else
        begin
          voci := JS.ToArray(item['VociItems']);

          esisteVoceOk := false;
          for v := 0 to voci.length - 1 do
          begin
            voce := JS.ToObject(voci[v]);

            if voce.hasOwnProperty(UtenteHaRisposto) then
            begin
              esisteVoceOk := true;
              break;
            end;
          end;

          // se arriva qui vuol dire che non ha nessuna voce valida
          if not esisteVoceOk then
          begin
            // Showmessage(TJSJSON.stringify(item));
            result := false;
            exit;
          end;
        end;

      end;
    end;
  end;

var
  items: TJSArray;
  Sezione: TJSObject;

begin
  result := true;

  if currentPage.IsEmpty then
    exit
  else
    if sameText(currentPage, 'suggerimenti') then // suggerimenti facoltativi
      exit
    else
      if sameText(currentPage, 'loader') then
        exit
      else
        if sameText(currentPage, 'finale') then // pagina finale
          exit
        else
        // if currentPageIndex < (pages.Count - 2) then // l'ultima pagina è dei suggerimenti
        begin
          // occhio: qualora si aggiungessero pagine di intro sarebbe da variare l'indice
          Sezione := JS.ToObject(JS.ToArray(sezioni['data'])[currentPageIndex]);

          if assigned(Sezione) then
            if Sezione.hasOwnProperty('Voci') then
            begin
              items := JS.ToArray(Sezione['Voci']);
              result := ratingsOk(items);
            end;
        end;
end;

procedure TMain.Send;
var
  url: string;
  JQXHR: TJQXHR;
  postData: string;
  risposta: TJSObject;
begin
  ShowPage('loader');

  if not questionario.hasOwnProperty('SUGGERIMENTI') then
    questionario['SUGGERIMENTI'] := '';

  risposta := TJSObject.new;
  risposta['IDENTIFICATIVO'] := GetQueryParam('IDENTIFICATIVO');
  risposta['QUESTIONARIO'] := questionario;
  risposta['SEZIONI'] := sezioni;

  postData := TJSJSON.stringify(risposta);

  url := BaseUrl + 'questionari/risposte?identificativo=' + GetQueryParam('IDENTIFICATIVO');

  AjaxSetup('');
  AjaxPost(url, postData)._then(
    function(value: JSValue): JSValue
    begin
      ShowPage('finale')
    end,
    function(value: JSValue): JSValue
    var
      ErrorMsg: String;
    begin
      ShowPage('suggerimenti');
      ErrorMsg := JS.ToString(value);
      Showmessage(ErrorMsg);
    end);
end;

procedure TMain.PrepareMediaQuery;
begin
  isPhone := Width <= 500;

  if isPhone then
  begin
    starSize := 30;
    SpaceBetweenButtons := 7;
    PageIndexContainerWidth := '150px';
    PageIndexWidth := '220px';
    PageProgressWidth := '100%';
    FontSize_1 := 'zz-font-size-24';
    FontSize_2 := 'zz-font-size-20';
    FontSize_4 := 'zz-font-size-14';
    FontSize_5 := 'zz-font-size-12';

    CardPadding := '5px';
    CardMarginTop := '5px';
    CardMarginBottom := '10px';
    WizContainerWidth := '90%';
    WizContainerMarginTop := '30px';
  end
  else
  begin
    starSize := 40;
    SpaceBetweenButtons := 20;
    PageIndexContainerWidth := '300px';
    PageIndexWidth := '250px';
    PageProgressWidth := '100%';
    FontSize_1 := 'zz-font-size-36';
    FontSize_2 := 'zz-font-size-30';
    FontSize_4 := 'zz-font-size-20';
    FontSize_5 := 'zz-font-size-18';

    CardPadding := '10px';
    CardMarginTop := '20px';
    CardMarginBottom := '20px';
    WizContainerWidth := '80%';
    WizContainerMarginTop := '100px';
  end;
end;

// Mobile;
// Deploy_ServerApp;
// SaveQuestionario (lato wtServer):
end.
