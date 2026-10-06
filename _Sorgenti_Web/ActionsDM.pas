unit ActionsDM;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.RTTI,
  System.TypInfo,
  WEBLib.Modules,
  JS,
  Web,
  images;

type

{$M+}
  TActionAttribute = class(TCustomAttribute)
  private
    FGroup: string;
    FCaption: string;
    FIcon: string;
  public
    constructor Create(const aGroup, aCaption, aIcon: string);
  public
    property Group: string read FGroup write FGroup;
    property Caption: string read FCaption write FCaption;
    property Icon: string read FIcon write FIcon;
  end;

{$M+}

  TActions = class(TWebDataModule)
  private
    // RttiContext: TRttiContext;
    // RttiType: TRttiType;
    function EnumActions(const Group: string): TJSArray;
  private
    function item(Caption: string; Icon: string; EventHandler: THTMLClickEventHandler): TJSObject;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    // admin
    function Login(aEvent: TJSMouseEvent): boolean;
    function Logout(aEvent: TJSMouseEvent): boolean;
    function Registrazione(aEvent: TJSMouseEvent): boolean;
    function PasswordDimenticata(aEvent: TJSMouseEvent): boolean;
    function ModificaPassword(aEvent: TJSMouseEvent): boolean;
    function Profilo(aEvent: TJSMouseEvent): boolean;
    function Assistenza(aEvent: TJSMouseEvent): boolean;
  public
    // Menù Docenti
    function RegistroElettronico(aEvent: TJSMouseEvent): boolean;
  public
    // Menù Risorse
    function AgendaPersonale(aEvent: TJSMouseEvent): boolean;
    function ElencoIncarichi(aEvent: TJSMouseEvent): boolean;
    function ElencoOreRilevate(aEvent: TJSMouseEvent): boolean;
    function ElencoPresenze(aEvent: TJSMouseEvent): boolean;
    function OreRecupero(aEvent: TJSMouseEvent): boolean;
    function PrenotazioniAule(aEvent: TJSMouseEvent): boolean;
    function SchedaAnagrafica(aEvent: TJSMouseEvent): boolean;
  public
    // Menù Studenti
    function StudentePresenzeStage(aEvent: TJSMouseEvent): boolean;
    function StudenteDocumentazione(aEvent: TJSMouseEvent): boolean;
  public
    function TutorValidazionePresenze(aEvent: TJSMouseEvent): boolean;
    function TutorDocumentazione(aEvent: TJSMouseEvent): boolean;
    function TutorInvioFile(aEvent: TJSMouseEvent): boolean;
  public
    // Test
    [Action('Test', 'Azione Test', imageTest)]
    function Test(aEvent: TJSMouseEvent): boolean;
  private
    function DocentiItems: TJSArray;
    function RisorseItems: TJSArray;
    function StudentiItems: TJSArray;
    function TutorItems: TJSArray;
    function TestItems: TJSArray;
    /// ////////////////////////////////////////////////////////////////////////
  public
    function DrawerMenuItems: TJSArray;
    function AdminItems: TJSArray;
  end;

var
  Actions: TActions;

implementation

uses
  zz.Web.url,
  zz.Web.JS,
  zz.Web.user,
  zz.Web.html,
  DevExtreme.Utils,
  AdminDM,
  AppController;

{$R *.dfm}

constructor TActionAttribute.Create(const aGroup, aCaption, aIcon: string);
begin
  inherited;
  FGroup := aGroup;
  FCaption := aCaption;
  FIcon := aIcon;
end;

constructor TActions.Create(aOwner: TComponent);
begin
  inherited;
  // RttiContext := TRttiContext.Create;
  // RttiType := RttiContext.GetType(TController);
end;

destructor TActions.Destroy;
begin
  inherited;
  // RttiContext.Free;
end;

function TActions.item(Caption: string; Icon: string; EventHandler: THTMLClickEventHandler): TJSObject;
begin
  result := new([]);
  result['text'] := Caption;
  result['icon'] := Icon;
  result['onClick'] := EventHandler;
end;

/// ////////////////////////////////////////////////////////////////////

function TActions.Login(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Admin.Login;
end;

function TActions.Logout(aEvent: TJSMouseEvent): boolean;
begin
  TdxUtils.Confirm('Logout', 'Si desidera uscire dall''applicazione?',
    procedure
    begin
      Admin.Logout;
    end, nil);
end;

function TActions.ModificaPassword(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Admin.CambioPassword;
end;

function TActions.PasswordDimenticata(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Admin.PasswordDimenticata;
end;

function TActions.Registrazione(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Admin.Registrazione;
end;

function TActions.Profilo(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Admin.Profilo;
end;

function TActions.Assistenza(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Admin.MailAssistenza;
end;

/// ////////////////////////////////////////////////////////////////////

function TActions.ElencoIncarichi(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Risorse.ElencoIncarichi;
end;

function TActions.RegistroElettronico(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Docenti.RegistroElettronico;
end;

function TActions.AgendaPersonale(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Risorse.AgendaPersonale;
end;

function TActions.ElencoOreRilevate(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Risorse.ElencoOreRilevate;
end;

function TActions.ElencoPresenze(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Risorse.ElencoPresenze
end;

function TActions.PrenotazioniAule(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Risorse.PrenotazioniAule;
end;

function TActions.OreRecupero(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Risorse.OreRecupero;
end;

function TActions.SchedaAnagrafica(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Risorse.SchedaAnagrafica;
end;

function TActions.StudenteDocumentazione(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Studenti.Documentazione;
end;

function TActions.StudentePresenzeStage(aEvent: TJSMouseEvent): boolean;
begin
  Controller.Studenti.PresenzeStage;
end;

/// ////////////////////////////////////////////////////////////////////

function TActions.TutorDocumentazione(aEvent: TJSMouseEvent): boolean;
begin
  Controller.TutorAziendali.Documentazione;
end;

function TActions.TutorInvioFile(aEvent: TJSMouseEvent): boolean;
begin
  Controller.TutorAziendali.InvioFile;
end;

function TActions.TutorValidazionePresenze(aEvent: TJSMouseEvent): boolean;
begin
  Controller.TutorAziendali.ValidazionePresenze;
end;

function TActions.Test(aEvent: TJSMouseEvent): boolean;
begin
  TdxUtils.Alert('test', 'test');
end;

function TActions.EnumActions(const Group: string): TJSArray;
var
  RttiMethod: TRttiMethod;
  Attribute: TCustomAttribute;
  ActionAttribute: TActionAttribute;
  item: TJSObject;
  HTMLClickEventHandler: THTMLClickEventHandler;
  Handle: PTypeInfo;
begin
  // non assegna gli attributi ai metodi
  // result := TJSArray.new;
  //
  // Handle := RttiType.Handle;
  // console.log(Handle);
  //
  // RttiMethod := RttiType.GetMethod('dummy');
  //
  // for RttiMethod in RttiType.GetMethods do
  // begin
  // RttiMethod.GetAttributes;
  //
  // console.log(RttiMethod);
  //
  // for Attribute in RttiMethod.GetAttributes do
  // if Attribute is TActionAttribute then
  // begin
  // ActionAttribute := TActionAttribute(Attribute);
  //
  // item := new([]);
  // item['text'] := ActionAttribute.Caption;
  // item['icon'] := ActionAttribute.Icon;
  // HTMLClickEventHandler := nil;
  // item['onClick'] := HTMLClickEventHandler;
  //
  // result.Push(item);
  // end;
  // end;
end;

function TActions.AdminItems: TJSArray;
begin
  result := TJSArray.new;
  // result.Push(item('Profilo', imageProfilo, @Profilo));
  result.Push(item('Modifica Password', imageCambioPassword, @ModificaPassword));
  // result.Push(item('Assistenza', imageAssistenza, @Assistenza));
  result.Push(item('Logout', imageLogout, @Logout));
end;

function TActions.DocentiItems: TJSArray;
begin
  result := TJSArray.new;
  result.Push(item('Registro Elettronico', imageRegistroElettronico, @RegistroElettronico));
end;

function TActions.RisorseItems: TJSArray;
begin
  result := TJSArray.new;
  result.Push(item('Agenda Personale', imageAgendaPersonale, @AgendaPersonale));
  result.Push(item('Incarichi Assegnati', imageElencoIncarichi, @ElencoIncarichi));
  result.Push(item('Rilevamento/Timesheet', imageElencoOreRilevate, @ElencoOreRilevate));
  result.Push(item('Elenco Presenze', imageElencoPresenze, @ElencoPresenze));
  result.Push(item('Ore Recupero', imageElencoOreRecupero, @OreRecupero));
  result.Push(item('Prenotazioni Aule', imagePrenotazioniAule, @PrenotazioniAule));
  result.Push(item('Scheda Anagrafica', imageSchedaAnagrafica, @SchedaAnagrafica));
end;

function TActions.StudentiItems: TJSArray;
begin
  result := TJSArray.new;
  result.Push(item('Presenze', imageStudentePresenzeStage, @StudentePresenzeStage));
  // non ancora implementati
  // result.Push(item('Comunicazioni', imageStudenteComunicazioni, @StudenteDocumentazione));
  // result.Push(item('Allegati', imageStudenteAllegati, @StudenteAllegati));
end;

function TActions.TutorItems: TJSArray;
begin
  result := TJSArray.new;
  result.Push(item('Presenze', imageTutorPresenzeStagisti, @TutorValidazionePresenze));
  result.Push(item('Documentazione', imageTutorDocumentazione, @TutorDocumentazione));
  result.Push(item('Invio File', imageTutorInvioFile, @TutorInvioFile));
end;

function TActions.TestItems: TJSArray;
begin
  result := TJSArray.new;
  result.Push(item('Test', imageTest, @Test));
end;

function TActions.DrawerMenuItems: TJSArray;

  function Group(const Caption: string; Items: JSValue): TJSObject;
  begin
    result := TJSObject.new;
    result['key'] := Caption;
    result['items'] := Items;
  end;

begin
  /// ////////////////////////////////////////////////////////

  // result := EnumActions('Test');

  /// ////////////////////////////////////////////////////////

  result := TJSArray.new;

  if user.TipoUser = tuDocente then
    result.Push(Group('Docenza', DocentiItems));

  if user.TipoUser in [tuDocente, tuPersonale] then
    result.Push(Group('Personale', RisorseItems));

  if user.TipoUser = tuStudente then
    result.Push(Group('Stage', StudentiItems));

  if user.TipoUser = tuTutor then
    result.Push(Group('Tirocini', TutorItems));

  if user.Onnipotente then
    result.Push(Group('Test', TestItems));

  result.Push(Group('Sistema', AdminItems));
end;

/// ////////////////////////////////////////////////////////////////////

end.
