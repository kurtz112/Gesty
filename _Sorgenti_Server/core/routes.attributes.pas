unit routes.attributes;

interface

uses
  System.SysUtils,
  Web.HTTPApp;

type
  // Web.HTTPApp.TMethodType = (mtAny, mtGet, mtPut, mtPost, mtHead, mtDelete, mtPatch);
  TMethodTypes = set of TMethodType;
  TProtectionKind = (pkNone, pkJWT);

  RouteAttribute = class(TCustomAttribute)
  private
    FPath: string;
    FMethods: TMethodTypes;
    FProtectionKind: TProtectionKind;
    function GetMethodsAsString: string;
  public
    constructor Create(const aMethods: TMethodTypes; const aPath: string; aProtectionKind: TProtectionKind);
    property Methods: TMethodTypes read FMethods;
    property MethodsAsString: string read GetMethodsAsString;
    property Path: string read FPath write FPath;
    property ProtectionKind: TProtectionKind read FProtectionKind write FProtectionKind;
  end;

  ANYAttribute = class(RouteAttribute)
  public
    constructor Create(const aPath: string; const aProtectionKind: TProtectionKind);
  end;

  GETAttribute = class(RouteAttribute)
  public
    constructor Create(const aPath: string; const aProtectionKind: TProtectionKind);
  end;

  PUTAttribute = class(RouteAttribute)
  public
    constructor Create(const aPath: string; const aProtectionKind: TProtectionKind);
  end;

  POSTAttribute = class(RouteAttribute)
  public
    constructor Create(const aPath: string; const aProtectionKind: TProtectionKind);
  end;

  HEADAttribute = class(RouteAttribute)
  public
    constructor Create(const aPath: string; const aProtectionKind: TProtectionKind);
  end;

  DELETEAttribute = class(RouteAttribute)
  public
    constructor Create(const aPath: string; const aProtectionKind: TProtectionKind);
  end;

  PATCHAttribute = class(RouteAttribute)
  public
    constructor Create(const aPath: string; const aProtectionKind: TProtectionKind);
  end;

  //

  PathAttribute = class(TCustomAttribute)
  private
    FPath: string;
  public
    constructor Create(const aPath: string);
    property Path: string read FPath write FPath;
  end;


  // LoginRequiredAttribute = class(TCustomAttribute);

  // RequiresAuthenticationAttribute = class(TCustomAttribute);

  // SkipJWTAttribute = class(TCustomAttribute);

  // MVCRequiresAuthenticationAttribute
  // AcceptAttribute= class(TCustomAttribute);
  // ProducesAttribute= class(TCustomAttribute);
  // MVCConsumesAttribute

  // MVCProducesAttribute = class(MVCStringAttribute)
  // private
  // FCharset: string;
  // protected
  // { protected declarations }
  // public
  // constructor Create(const AValue: string); overload;
  // constructor Create(const AValue: string; const ACharset: string); overload;
  // property Charset: string read FCharset;
  // end;

  // [MVCPath('/role1')]
  // [MVCProduces('text/html')]
  // [MVCHTTPMethod([httpGET])]
  // [MVCConsumes('text/html')]

implementation

uses
  System.TypInfo,
  System.Rtti;

/// //////////////////////////////////////////////////////////////////////

constructor PathAttribute.Create(const aPath: string);
begin
  inherited Create;
  FPath := aPath;
end;

constructor RouteAttribute.Create(const aMethods: TMethodTypes; const aPath: string; aProtectionKind: TProtectionKind);
begin
  inherited Create;
  FMethods := aMethods;
  FPath := aPath;
  FProtectionKind := aProtectionKind;
end;

function RouteAttribute.GetMethodsAsString: string;
var
  Method: TMethodType;
begin
  Result := '';

  for Method := low(TMethodType) to high(TMethodType) do
    if Method in Methods then
    begin

      if Result.isEmpty then
        Result := GetEnumName(TypeInfo(TMethodType), Ord(Method))
      else
        Result := Result + ',' + GetEnumName(TypeInfo(TMethodType), Ord(Method));
    end;

  if Result <> EmptyStr then
    Result := Result.Remove(0, 1)
  else
    Result := 'any';
end;

constructor ANYAttribute.Create(const aPath: string; const aProtectionKind: TProtectionKind);
begin
  inherited Create([mtAny], aPath, aProtectionKind);
end;

constructor GETAttribute.Create(const aPath: string; const aProtectionKind: TProtectionKind);
begin
  inherited Create([mtGET], aPath, aProtectionKind);
end;

constructor PUTAttribute.Create(const aPath: string; const aProtectionKind: TProtectionKind);
begin
  inherited Create([mtPUT], aPath, aProtectionKind);
end;

constructor POSTAttribute.Create(const aPath: string; const aProtectionKind: TProtectionKind);
begin
  inherited Create([mtPOST], aPath, aProtectionKind);
end;

constructor HEADAttribute.Create(const aPath: string; const aProtectionKind: TProtectionKind);
begin
  inherited Create([mtHEAD], aPath, aProtectionKind);
end;

constructor DELETEAttribute.Create(const aPath: string; const aProtectionKind: TProtectionKind);
begin
  inherited Create([mtDELETE], aPath, aProtectionKind);
end;

constructor PATCHAttribute.Create(const aPath: string; const aProtectionKind: TProtectionKind);
begin
  inherited Create([mtPATCH], aPath, aProtectionKind);
end;

end.
