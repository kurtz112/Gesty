unit zHyperLinks;

interface

uses
  Sysutils,
  Classes,
  MDI_Lib,
  BaseFrm,
  generics.Collections,
  SmartInspect.Vcl,
  SmartInspect.Vcl.SiAuto;

type
  TzHyperLinks = class
  private
    Handlers: TDictionary<string, TBaseFormClass>;
    function HyperLinkEnabled(const FieldName: string): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    //
    procedure EnumHyperlinks(Hyperlinks: TStrings);
    procedure RegisterHandler(const FieldName: string; FormClass: TBaseFormClass);
    procedure doHyperLink(Sender: TObject; FieldName: string; PK: Variant);
  end;

function Hyperlinks: TzHyperLinks;

implementation

uses
  Vcl.Dialogs, zSystem, zMsg;

var
  _HyperLinks: TzHyperLinks = nil;

function Hyperlinks: TzHyperLinks;
begin
  if not Assigned(_HyperLinks) then
    _HyperLinks := TzHyperLinks.Create;

  result := _HyperLinks;
end;

constructor TzHyperLinks.Create;
begin
  inherited;
  Handlers := TDictionary<string, TBaseFormClass>.Create;
end;

destructor TzHyperLinks.Destroy;
begin
  FreeAndNil(Handlers);
  inherited;
end;

procedure TzHyperLinks.RegisterHandler(const FieldName: string; FormClass: TBaseFormClass);
begin
  SiMain.EnterMethod(Self, 'RegisterHandler');
  Handlers.Add(FieldName, FormClass);
  SiMain.LeaveMethod(Self, 'RegisterHandler');
end;

procedure TzHyperLinks.doHyperLink(Sender: TObject; FieldName: string; PK: Variant);
var
  FormClass: TBaseFormClass;
  pair: TPair<string, TBaseFormClass>;
begin
  SiMain.EnterMethod(Self, 'doHyperLink');
  if Handlers.TryGetValue(FieldName, FormClass) then
  begin

    if HyperLinkEnabled(FieldName) then
      FormCollection.CreateForm(FormClass, FieldName, PK)
    else
      ConfirmOk('Permessi insufficienti per questa operazione.');
  end
  else
  begin
    SiMain.LogSeparator;
    SiMain.LogString('Hyperlink non trovato', FieldName);
    for pair in Handlers do
      SiMain.LogString('Gestori registrati', pair.Key);

    ConfirmOk('Gestore hyperlink non trovato per il campo ' + FieldName);
  end;
  SiMain.LeaveMethod(Self, 'doHyperLink');
end;

procedure TzHyperLinks.EnumHyperlinks(Hyperlinks: TStrings);
var
  pair: TPair<string, TBaseFormClass>;
begin
  Assert(Assigned(Hyperlinks));

  for pair in Handlers do
    Hyperlinks.Add(pair.Key);
end;

function TzHyperLinks.HyperLinkEnabled(const FieldName: string): boolean;
begin
  result := true;

  if Base.zSecurity.LoginParams.Hyperlinks.Count > 0 then
    result := Base.zSecurity.LoginParams.Hyperlinks.IndexOf(FieldName) <> -1;
end;

initialization

finalization

FreeAndNil(_HyperLinks);

end.
