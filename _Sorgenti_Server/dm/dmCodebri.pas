unit dmCodebri;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  lib.Context,
  route,
  routes.Attributes;

type

  [Path('codebri')]
  TCodebri = class(TRoute)
  private
  public
    ///
    [ANY('dump', pkNone)]
    procedure Dump(ctx: TzContext);
    [ANY('cv', pkNone)]
    procedure InserimentoCandidatura(ctx: TzContext);

    [ANY('info', pkNone)]
    procedure RichiestaInformazioni(ctx: TzContext);
  end;

var
  Codebri: TCodebri;

implementation

uses
  System.JSON,
  System.IOUtils,
  System.DateUtils,
  System.StrUtils,
  System.Math,
  System.NetEncoding,
  lib.JsonRest,
  lib.Consts,
  lib.Config,
  zz.Folders,
  zz.SmartInspect;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TCodebri.Dump(ctx: TzContext);
var
  dumpfile: TStringList;
  FileName: string;
begin
  SiMain.LogSeparator;
  SiMain.LogVerbose('Dump');

  SiMain.LogStringList('ContentFields', ctx.Request.ContentFields);
  SiMain.LogStringList('QueryFields', ctx.Request.QueryFields);
  SiMain.LogStringList('CookieFields', ctx.Request.CookieFields);

  SiMain.LogString('Method', ctx.Request.Method);
  SiMain.LogString('ProtocolVersion', ctx.Request.ProtocolVersion);
  SiMain.LogString('URL', ctx.Request.URL);
  SiMain.LogString('Query', ctx.Request.Query);
  SiMain.LogString('PathInfo', ctx.Request.PathInfo);
  SiMain.LogString('PathTranslated', ctx.Request.PathTranslated);
  SiMain.LogString('Authorization', ctx.Request.Authorization);

  SiMain.LogString('CacheControl', ctx.Request.CacheControl);
  SiMain.LogString('Cookie', ctx.Request.Cookie);
  SiMain.LogDateTime('Date', ctx.Request.Date);

  SiMain.LogString('Accept', ctx.Request.Accept);
  SiMain.LogString('From', ctx.Request.From);
  SiMain.LogString('Host', ctx.Request.Host);
  SiMain.LogDateTime('IfModifiedSince', ctx.Request.IfModifiedSince);
  SiMain.LogString('Referer', ctx.Request.Referer);
  SiMain.LogString('UserAgent', ctx.Request.UserAgent);
  SiMain.LogString('ContentEncoding', ctx.Request.ContentEncoding);
  SiMain.LogString('ContentType', ctx.Request.ContentType);
  SiMain.LogInt64('ContentType', ctx.Request.ContentLength);

  SiMain.LogString('ContentVersion', ctx.Request.ContentVersion);
  // siMain.LogString( 'RawContent',ctx.Request.RawContent);
  SiMain.LogString('Content', ctx.Request.Content);
  SiMain.LogString('Connection', ctx.Request.Connection);
  SiMain.LogString('DerivedFrom', ctx.Request.DerivedFrom);
  SiMain.LogDateTime('Expires', ctx.Request.Expires);
  SiMain.LogString('Title', ctx.Request.Title);
  SiMain.LogString('RemoteAddr', ctx.Request.RemoteAddr);
  SiMain.LogString('ScriptName', ctx.Request.ScriptName);
  SiMain.LogInt64('ServerPort', ctx.Request.ServerPort);
  SiMain.LogString('InternalPathInfo', ctx.Request.InternalPathInfo);
  SiMain.LogString('RawPathInfo', ctx.Request.RawPathInfo);
  SiMain.LogInteger('Files.Count', ctx.Request.Files.Count);
  SiMain.LogSeparator;

  // su file

  dumpfile := TStringList.Create;
  try
    dumpfile.AddPair('ContentFields', ctx.Request.ContentFields.Text);
    dumpfile.add('');
    dumpfile.AddPair('QueryFields', ctx.Request.QueryFields.Text);
    dumpfile.add('');
    dumpfile.AddPair('CookieFields', ctx.Request.CookieFields.Text);
    dumpfile.add('');

    dumpfile.AddPair('Method', ctx.Request.Method);
    dumpfile.AddPair('ProtocolVersion', ctx.Request.ProtocolVersion);
    dumpfile.AddPair('URL', ctx.Request.URL);
    dumpfile.AddPair('Query', ctx.Request.Query);
    dumpfile.AddPair('PathInfo', ctx.Request.PathInfo);
    dumpfile.AddPair('PathTranslated', ctx.Request.PathTranslated);
    dumpfile.AddPair('Authorization', ctx.Request.Authorization);

    dumpfile.AddPair('CacheControl', ctx.Request.CacheControl);
    dumpfile.AddPair('Cookie', ctx.Request.Cookie);
    dumpfile.AddPair('Date', ctx.Request.Date.ToString);

    dumpfile.AddPair('Accept', ctx.Request.Accept);
    dumpfile.AddPair('From', ctx.Request.From);
    dumpfile.AddPair('Host', ctx.Request.Host);
    dumpfile.AddPair('IfModifiedSince', ctx.Request.IfModifiedSince.ToString);
    dumpfile.AddPair('Referer', ctx.Request.Referer);
    dumpfile.AddPair('UserAgent', ctx.Request.UserAgent);
    dumpfile.AddPair('ContentEncoding', ctx.Request.ContentEncoding);
    dumpfile.AddPair('ContentType', ctx.Request.ContentType);
    dumpfile.AddPair('ContentType', ctx.Request.ContentLength.ToString);

    dumpfile.AddPair('ContentVersion', ctx.Request.ContentVersion);
    dumpfile.AddPair('Content', ctx.Request.Content);
    dumpfile.AddPair('Connection', ctx.Request.Connection);
    dumpfile.AddPair('DerivedFrom', ctx.Request.DerivedFrom);
    dumpfile.AddPair('Expires', ctx.Request.Expires.ToString);
    dumpfile.AddPair('Title', ctx.Request.Title);
    dumpfile.AddPair('RemoteAddr', ctx.Request.RemoteAddr);
    dumpfile.AddPair('ScriptName', ctx.Request.ScriptName);
    dumpfile.AddPair('ServerPort', ctx.Request.ServerPort.ToString);
    dumpfile.AddPair('InternalPathInfo', ctx.Request.InternalPathInfo);
    dumpfile.AddPair('RawPathInfo', ctx.Request.RawPathInfo);
    dumpfile.AddPair('Files.Count', ctx.Request.Files.Count.ToString);
    //

    FileName := TFolders.WorkingSubFolder('dump', True) + 'dump_' + FormatDateTime('yyyymmdd hh nn', Now) + '.log';
    dumpfile.SaveToFile(FileName);
  finally
    FreeAndNil(dumpfile);
  end;

  // Response

  ctx.Response.RenderOk;
end;

procedure TCodebri.RichiestaInformazioni(ctx: TzContext);
begin
  Dump(ctx);
end;

procedure TCodebri.InserimentoCandidatura(ctx: TzContext);
begin
  Dump(ctx);
end;


initialization

RegisterClass(TCodebri);

end.
