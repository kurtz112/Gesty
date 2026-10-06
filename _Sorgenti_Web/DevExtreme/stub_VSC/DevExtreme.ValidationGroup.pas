unit DevExtreme.ValidationGroup;

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
  TjdxValidationGroup = class(TjdxCustomControl)
  private
    FelementAttr: TJSObject;
    Fheight_: JSValue;
    FrtlEnabled: boolean;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


constructor TjdxValidationGroup.Create(aOwner: TComponent);
begin
  inherited;
  FelementAttr := TJSObject.new;
  Fheight_ := nil;
  FrtlEnabled := false;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;

procedure TjdxValidationGroup.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxValidationGroup.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxValidationGroup.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxValidationGroup.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxValidationGroup.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxValidationGroup.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxValidationGroup.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

end.
