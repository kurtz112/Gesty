unit DevExtreme.Validator;

interface

uses
  System.SysUtils,
  System.Classes,
  WEBLib.Controls,
  jsdelphisystem,
  JS,
  Web,
  libjquery,
  DevExtreme.CustomControl,
  DevExtreme.Types;

type
  TjdxValidator = class(TjdxCustomControl)
  private
    Fadapter: TJSObject;
    FelementAttr: TJSObject;
    Fheight_: JSValue;
    Fname_: string;
    FrtlEnabled: boolean;
    FvalidationGroup: string;
    FvalidationRules: TJSArray;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonValidated: TdxEventHandler;
  private
    procedure Set_adapter(const value: TJSObject);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_name_(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_validationGroup(const value: string);
    procedure Set_validationRules(const value: TJSArray);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onValidated(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property adapter: TJSObject read Fadapter write Set_adapter;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property validationRules: TJSArray read FvalidationRules write Set_validationRules;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property name_: string read Fname_ write Set_name_;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property validationGroup: string read FvalidationGroup write Set_validationGroup;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onValidated: TdxEventHandler read FonValidated write Set_onValidated;
  end;

implementation


constructor TjdxValidator.Create(aOwner: TComponent);
begin
  inherited;
  Fadapter := TJSObject.new;
  FelementAttr := TJSObject.new;
  Fheight_ := nil;
  Fname_ := '';
  FrtlEnabled := false;
  FvalidationGroup := '';
  FvalidationRules := TJSArray.new;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValidated := nil;
end;

procedure TjdxValidator.Set_adapter(const Value: TJSObject);
begin
  Fadapter := Value;
end;

procedure TjdxValidator.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxValidator.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxValidator.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxValidator.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxValidator.Set_validationGroup(const Value: string);
begin
  FvalidationGroup := Value;
end;

procedure TjdxValidator.Set_validationRules(const Value: TJSArray);
begin
  FvalidationRules := Value;
end;

procedure TjdxValidator.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxValidator.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxValidator.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxValidator.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxValidator.Set_onValidated(const Value: TdxEventHandler);
begin
  FonValidated := Value;
end;

end.
