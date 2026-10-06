unit Routes;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Generics.Collections,
  System.Rtti,
  Web.HTTPApp,
  lib.Context,
  Route,
  Routes.attributes;

type
  TRouteInfo = class
  private
    FPath: string;
    FLoginRequired: boolean;
    FRouteClass: TRouteClass;
    FResource: string;
  public
    constructor Create(aPath: string; aResource: string; aRouteClass: TRouteClass; aLoginRequired: boolean);

    property Path: string read FPath write FPath;
    property Resource: string read FResource write FResource;
    property RouteClass: TRouteClass read FRouteClass write FRouteClass;
    property LoginRequired: boolean read FLoginRequired write FLoginRequired;
  end;

  TRoutes = class
  private
    RttiContext: TRttiContext;
    Routes: TObjectDictionary<String, TRouteInfo>;
    procedure RegisterRoutes;

    function doHandleRequest(RouteInfo: TRouteInfo; Context: TzContext): boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function HandleRequest(Request: TWebRequest; Response: TWebResponse): boolean;
  end;

implementation

uses
  lib.JWT,
  lib.JsonRest,
  SmartInspect.Core.SiAuto,
  SmartInspect.Core,
  lib.Config,
  lib.ExceptionLogger;

{ TRouteInfo }

constructor TRouteInfo.Create(aPath: string; aResource: string; aRouteClass: TRouteClass; aLoginRequired: boolean);
begin
  inherited Create;

  FPath := aPath;
  FResource := aResource;
  FRouteClass := aRouteClass;
  FLoginRequired := aLoginRequired;
end;

/// //////////////////////////////////////////////////////////////////////
constructor TRoutes.Create;
begin
  inherited;
  RttiContext := TRttiContext.Create;
  Routes := TObjectDictionary<String, TRouteInfo>.Create([doOwnsValues]);
  RegisterRoutes;
end;

destructor TRoutes.Destroy;
begin
  RttiContext.Free;
  FreeAndNil(Routes);
  inherited;
end;

procedure TRoutes.RegisterRoutes;
var
  Route: string;
  RttiType: TRttiType;
  Attribute: TCustomAttribute;
  AttrLogin: TCustomAttribute;
  RttiInstanceType: TRttiInstanceType;
  RouteClass: TRouteClass;
  RouteMethod: TRttiMethod;
  fullPath: string;
  RouteInfo: TRouteInfo;
  LoginRequired: boolean;
begin

  for RttiType in RttiContext.GetTypes do
    if RttiType is TRttiInstanceType then
    begin
      RttiInstanceType := TRttiInstanceType(RttiType);

      if RttiInstanceType.MetaclassType.InheritsFrom(TRoute) then
      begin
        RouteClass := TRouteClass(RttiInstanceType.MetaclassType);

        // path
        Route := '';

        for Attribute in RttiInstanceType.GetAttributes do
          if Attribute is PathAttribute then
          begin
            Route := PathAttribute(Attribute).Path;
            Break;
          end;

        // elencare i metodi
        for RouteMethod in RttiInstanceType.GetMethods do
          for Attribute in RouteMethod.GetAttributes do
            if Attribute is RouteAttribute then
            begin

              if Route.IsEmpty then
                fullPath := RouteAttribute(Attribute).Path
              else
                fullPath := Route + '/' + RouteAttribute(Attribute).Path;

              LoginRequired := RouteAttribute(Attribute).ProtectionKind <> pkNone;

              if not Routes.ContainsKey(fullPath) then
              begin
                RouteInfo := TRouteInfo.Create(Route, RouteAttribute(Attribute).Path, RouteClass, LoginRequired);
                try
                  SiMain.LogString('RegisterRoute', fullPath.ToUpper);
                  Routes.Add(fullPath.ToUpper, RouteInfo);
                except
                  RouteInfo.Free;
                  raise
                end;
              end;
            end;
      end;
    end;
end;

function TRoutes.doHandleRequest(RouteInfo: TRouteInfo; Context: TzContext): boolean;
var
  Route: TRoute;
  RouteType: TRttiType;
  RouteMethod: TRttiMethod;
  Attribute: TCustomAttribute;

  function ValidForRequest(attr: RouteAttribute; const MethodType: TMethodType; const Resource: string): boolean;
  begin
    Result := ((MethodType in attr.Methods) or (mtAny in attr.Methods)) and SameText(attr.Path, Resource);
  end;

begin
  Result := false;

  /// ///////////////////

  if RouteInfo.LoginRequired then
  begin

    if VerifyRequest(Context) then
    begin
    end
    else
      if not ConfigProps.SkipVerifyToken then
      begin
        Context.Response.RenderError('Login required.');
        Context.Response.SendResponse;
        exit;
      end;
  end;

  /// ///////////////////

  Route := RouteInfo.RouteClass.Create(nil);
  try
    RouteType := RttiContext.GetType(Route.ClassInfo);

    for RouteMethod in RouteType.GetMethods do
      for Attribute in RouteMethod.GetAttributes do
        if Attribute is RouteAttribute then
          if ValidForRequest(RouteAttribute(Attribute), Context.Request.MethodType, RouteInfo.Resource) then
          begin
            Result := True;
            try
              RouteMethod.Invoke(Route, [TValue.From(Context)]);
            except
              on E: Exception do
              begin
                SiMain.LogSeparator;
                SiMain.LogException(E);
                SiMain.LogSeparator;
                SaveExceptionLog(E, Context.Request);
                Context.Response.RenderException(E);
              end;
            end;

            exit;
          end;

    // Se arriva qui ==> errore
    Context.Response.RenderError('Not Found');
  finally
    FreeAndNil(Route);
  end;
end;

function TRoutes.HandleRequest(Request: TWebRequest; Response: TWebResponse): boolean;
var
  RouteInfo: TRouteInfo;
  pathInfo: string;
  Context: TzContext;
begin
  Result := false;

  pathInfo := Request.pathInfo;

  if pathInfo.StartsWith('/') then
    pathInfo := pathInfo.Remove(0, 1);

  Result := Routes.TryGetValue(pathInfo.ToUpper, RouteInfo);

  if Result then // crea il context
  begin
    Context.Init(Request, Response);
    Result := doHandleRequest(RouteInfo, Context);
  end
  else
    Response.RenderNotFound;
end;

end.
