unit dmBase;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  Data.DB,
  Data.DBCommon,
  Web.HTTPApp,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  lib.DataRequest,
  lib.widgetOptions,
  lib.Context,
  Route,
  Routes.Attributes;

type

  [Path('api/base')]
  TBase = class(TRoute)
  public
    /// /////////////////
    [POST('getOptions', pkJWT)]
    procedure GetOptions(ctx: TzContext);

    [POST('setOptions', pkJWT)]
    procedure SetOptions(ctx: TzContext);
  end;

var
  Base: TBase;

implementation

uses
  System.UITypes,
  System.IOUtils,
  fib.SqlTxtRtns,
  zz.SmartInspect,
  zz.Folders,
  lib.JsonRest,
  lib.Config,
  lib.DateISO,
  Server_Module;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TBase.GetOptions(ctx: TzContext);
var
  WidgetProps: TWidgetProps;
  JSONObject: TJSONObject;
  StoredProc: TFDStoredProc;
  tmp: string;
begin
  SiMain.EnterMethod('GetDatasetRequest');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  WidgetProps := ctx.Request.WidgetProps;
  try
    SiMain.LogColored(TColors.Yellow, 'GetOptions: ' + WidgetProps.id);
    SiMain.LogObject(TWebRequest.identOptionsRequest, WidgetProps);

    /// /////////////////////////////////////////////////////////////

    if OptionsDictionary.TryGetValue(WidgetProps.id, tmp) then
      WidgetProps.options := tmp
    else
    begin
      Connect(ctx);
      try
        StoredProc := CreateStoredProc('ZZ_WEB_WIDGETS_GET');
        try
          StoredProc.Prepare;
          StoredProc.ParamByName('WIDGET').Value := WidgetProps.id;
          StoredProc.ParamByName('WIDGET_TYPE').Value := WidgetProps.widget;
          StoredProc.ExecProc;
          WidgetProps.options := StoredProc.ParamByName('OPTIONS').asString;
          WidgetProps.isCustom := StoredProc.ParamByName('IS_CUSTOM').asBoolean;
          StoredProc.Close;
        finally
          FreeAndNil(StoredProc);
        end;
      finally
        Disconnect;
      end;
    end;

    /// //////////////////////////////////////////////////////////////////////////

    TMonitor.Enter(OptionsDictionary);
    try
      OptionsDictionary.AddOrSetValue(WidgetProps.id, WidgetProps.options);
    finally
      TMonitor.Exit(OptionsDictionary);
    end;

    /// /////////////////////////////////////////////////////////////

    if not WidgetProps.options.IsEmpty then
    begin
      JSONObject := TJSONObject.ParseJSONValue(WidgetProps.options) as TJSONObject;
      SiMain.LogString(TWebRequest.identOptionsRequest, JSONObject.ToJSON);
      ctx.Response.Render(JSONObject); // direttamente il json
    end
    else
    begin
      SiMain.LogString(TWebRequest.identOptionsRequest, 'Vuoto');
      ctx.Response.Render(TJSONNull.Create); // direttamente il json
    end;
  finally
    FreeAndNil(WidgetProps);
  end;

  SiMain.leaveMethod('GetDatasetRequest');
end;

procedure TBase.SetOptions(ctx: TzContext);
var
  WidgetProps: TWidgetProps;
  StoredProc: TFDStoredProc;
begin
  SiMain.EnterMethod('SetDatasetRequest');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  WidgetProps := ctx.Request.WidgetProps;
  try
    SiMain.LogColored(TColors.Yellow, 'SetOptions: ' + WidgetProps.id);
    SiMain.LogObject(TWebRequest.identOptionsRequest, WidgetProps);

    /// //////////////////////////////////////////////////////////////////////////

    Connect(ctx);
    try
      StoredProc := CreateStoredProc('ZZ_WEB_WIDGETS_SET');
      try
        StoredProc.Prepare;
        StoredProc.ParamByName('WIDGET').Value := WidgetProps.id;
        StoredProc.ParamByName('WIDGET_TYPE').Value := WidgetProps.widget;
        StoredProc.ParamByName('OPTIONS').Value := WidgetProps.options;
        StoredProc.ParamByName('IS_CUSTOM').Value := WidgetProps.isCustom;
        StoredProc.ExecProc;
        StoredProc.Close;
      finally
        FreeAndNil(StoredProc);
      end;
    finally
      Disconnect;
    end;

    /// //////////////////////////////////////////////////////////////////////////

    TMonitor.Enter(OptionsDictionary);
    try
      OptionsDictionary.AddOrSetValue(WidgetProps.id, WidgetProps.options);
    finally
      TMonitor.Exit(OptionsDictionary);
    end;

    /// /////////////////////////////////////////////////////////////

    ctx.Response.RenderOk;
  finally
    FreeAndNil(WidgetProps);
  end;

  SiMain.leaveMethod('SetDatasetRequest');
end;

initialization

RegisterClass(TBase);

// cache.CreateDictionaries;

finalization

// cache.DestroyDictionaries;

end.
