unit dmMeta;

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
  lib.Context,
  lib.widgetOptions,
  Route,
  Routes.Attributes;

type

  [Path('api/meta')]
  TMeta = class(TRoute)
  public
    /// /////////////////
    [POST('getOptions', pkJWT)]
    procedure GetOptions(ctx: TzContext);

    [POST('setOptions', pkJWT)]
    procedure SetOptions(ctx: TzContext);
  end;

var
  Meta: TMeta;

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

procedure TMeta.SetOptions(ctx: TzContext);
var
  widgetOptions: TWidgetOptions;
  StoredProc: TFDStoredProc;
  key: string;
begin
  SiMain.EnterMethod('SetOptions');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  /// //////////////////////////////////////////////////////////////////////////

  widgetOptions := ctx.Request.widgetOptions;
  try
    key := WidgetKey(widgetOptions.dm, widgetOptions.id, widgetOptions.widget);
    SiMain.LogColored(TColors.Yellow, 'TMeta.SetOptions: ' + key);
    SiMain.LogObject(TWebRequest.identOptionsRequest, widgetOptions);

    /// //////////////////////////////////////////////////////////////////////////

    Connect(ctx);
    try
      StoredProc := CreateStoredProc('ZZ_WIDGET_OPTIONS_SET');
      try
        StoredProc.Prepare;
        StoredProc.ParamByName('WIDGET_TYPE').Value := widgetOptions.widget;
        StoredProc.ParamByName('WIDGET_FORM').Value := widgetOptions.dm;
        StoredProc.ParamByName('WIDGET_NAME').Value := widgetOptions.id;
        StoredProc.ParamByName('OPTIONS').Value := widgetOptions.options;
        StoredProc.ParamByName('IS_CUSTOM').Value := widgetOptions.isCustom;
        StoredProc.ExecProc;

        cacheWidgets.LoadFromDataSet(ctx.App, widgetOptions.dm, widgetOptions.id, StoredProc);

        StoredProc.Close;
      finally
        FreeAndNil(StoredProc);
      end;
    finally
      Disconnect;
    end;
  finally
    FreeAndNil(widgetOptions);
  end;

  /// //////////////////////////////////////////////////////////////////////////

  ctx.Response.RenderOk;

  /// //////////////////////////////////////////////////////////////////////////
  ///
  SiMain.leaveMethod('SetOptions');
end;

procedure TMeta.GetOptions(ctx: TzContext);
var
  widgetOptions, tmp: TWidgetOptions;
  JSONObject: TJSONObject;
  StoredProc: TFDStoredProc;
  key: string;
begin
  SiMain.EnterMethod('GetOptions');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  /// /////////////////////////////////////////////////////////////
  tmp := nil; // evita problemi con il freeAndNil finale

  widgetOptions := ctx.Request.widgetOptions;
  try
    key := WidgetKey(widgetOptions.dm, widgetOptions.id, widgetOptions.widget);

    if not cacheWidgets.GetWidget(key, tmp) then
    begin
      key := WidgetKey(widgetOptions.dm, widgetOptions.id, widgetOptions.widget);
      SiMain.LogColored(TColors.Yellow, 'GetOptions: ' + key);
      SiMain.LogObject(TWebRequest.identOptionsRequest, widgetOptions);

      /// /////////////////////////////////////////////////////////////

      if not cacheWidgets.GetWidget(key, tmp) then
      begin
        Connect(ctx);
        try
          StoredProc := CreateStoredProc('ZZ_WIDGET_OPTIONS_GET');
          try
            StoredProc.Prepare;
            // StoredProc.ParamByName('PARAM_APP').AsString := ctx.App;
            StoredProc.ParamByName('WIDGET_TYPE').Value := widgetOptions.widget;
            StoredProc.ParamByName('WIDGET_FORM').Value := widgetOptions.dm;
            StoredProc.ParamByName('WIDGET_NAME').Value := widgetOptions.id;
            StoredProc.ExecProc;

            tmp := cacheWidgets.LoadFromDataSet(ctx.App, widgetOptions.dm, widgetOptions.id, StoredProc);

            StoredProc.Close;
          finally
            FreeAndNil(StoredProc);
          end;
        finally
          Disconnect;
        end;
      end;
    end;

    /// //////////////////////////////////////////////////////////////////////////

    /// /////////////////////////////////////////////////////////////

    if not tmp.options.IsEmpty then
    begin
      JSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(tmp.options), 0) as TJSONObject;
      SiMain.LogString(TWebRequest.identOptionsRequest, JSONObject.ToJSON);
      ctx.Response.Render(true, JSONObject); // direttamente il json
    end
    else
    begin
      SiMain.LogString(TWebRequest.identOptionsRequest, 'Vuoto');
      ctx.Response.Render(false, TJSONNull.Create); // direttamente il json
    end;

  finally
    FreeAndNil(widgetOptions);
    FreeAndNil(tmp);
  end;

  SiMain.leaveMethod('GetOptions');
end;

initialization

RegisterClass(TMeta);

end.
