unit dmCAPAC;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  lib.Context,
  route,
  routes.Attributes,
  SmartInspect.VCL.SiAuto,
  SmartInspect.VCL,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent;

type

  [Path('capac')]
  TCAPAC = class(TRoute)
    NetHTTPClient: TNetHTTPClient;
  public
    ///
    [ANY('dump', pkNone)]
    procedure Dump(ctx: TzContext);

    [ANY('info', pkNone)]
    procedure RichiestaInformazioni(ctx: TzContext);

    [ANY('cv', pkNone)]
    procedure InserimentoCandidatura(ctx: TzContext);
  end;

var
  CAPAC: TCAPAC;

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
  zz.SmartInspect,
  FireDAC.Comp.Client;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TCAPAC.Dump(ctx: TzContext);
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

procedure TCAPAC.RichiestaInformazioni(ctx: TzContext);
var
  id: Integer;
  sp: TFDStoredproc;
begin
  SiMain.EnterMethod(Self, 'RichiestaInformazioni');
  SiMain.LogStringList('ContentFields', ctx.Request.ContentFields);

  AdminConnect;
  try
    StartTrans;
    try
      // CREATE OR ALTER PROCEDURE WEB_RICHIESTE_INFORMAZIONI_ADD (
      // DATA_RICHIESTA DATA,
      // ORA_RICHIESTA  ORA,
      // COGNOME        COGNOME,
      // NOME           NOME,
      // E_MAIL         E_MAIL,
      // RICHIESTA      MEMO,
      // CONTENT_FIELDS MEMO)

      sp := CreateStoredProc('WEB_RICHIESTE_INFORMAZIONI_ADD');
      try
        sp.ParamByName('DATA_RICHIESTA').AsDate := Date;
        sp.ParamByName('ORA_RICHIESTA').AsTime := Now;

        // SetParam(sp.ParamByName('PAGINA'), ctx.Request.ContentFields.Values['previus_page_hid']);
        SetParam(sp.ParamByName('PAGINA'), ctx.Request.ContentFields.Values['Pagina precedente']);

        if sp.ParamByName('PAGINA').IsNull then
          SetParam(sp.ParamByName('PAGINA'), ctx.Request.ContentFields.Values['Titolo Corso']);

        SetParam(sp.ParamByName('CODICE_FISCALE'), ctx.Request.ContentFields.Values['Codice Fiscale']);
        SetParam(sp.ParamByName('PARTITA_IVA'), ctx.Request.ContentFields.Values['Partita Iva']);

        SetParam(sp.ParamByName('COGNOME'), ctx.Request.ContentFields.Values['Cognome']);
        SetParam(sp.ParamByName('NOME'), ctx.Request.ContentFields.Values['Nome']);

        SetParam(sp.ParamByName('TELEFONO'), ctx.Request.ContentFields.Values['Numero di telefono']);

        if sp.ParamByName('TELEFONO').IsNull then
          SetParam(sp.ParamByName('TELEFONO'), ctx.Request.ContentFields.Values['Telefono']);

        SetParam(sp.ParamByName('E_MAIL'), ctx.Request.ContentFields.Values['Email']);
        SetParam(sp.ParamByName('RICHIESTA'), ctx.Request.ContentFields.Values['Richiesta informazioni per: ']);
        sp.ParamByName('MESSAGGIO').AsString := ctx.Request.ContentFields.Values['Messaggio'];
        sp.ParamByName('CONTENT_FIELDS').AsString := ctx.Request.ContentFields.Text;
        sp.ExecProc;
        try
          id := sp.ParamByName('ID_RICHIESTA_INFORMAZIONI_WEB').asInteger;

          SiMain.LogInteger('Result', id);
        finally
          sp.Close;
        end;
      finally
        FreeAndNil(sp);
      end;

      Commit;

      ctx.Response.Render200;
    except
      on E: Exception do
      begin
        Rollback;
        raise;
      end;
    end;
  finally;
    Disconnect;
  end;
  SiMain.LeaveMethod(Self, 'RichiestaInformazioni');
end;

procedure TCAPAC.InserimentoCandidatura(ctx: TzContext);

  function GetFileName(const URL: string): string;
  var
    idx: Integer;
  begin
    idx := URL.LastIndexOf('/');
    result := URL.Substring(idx + 1);
  end;

  function DownloadFile(const URL, DestFileName: String): boolean;
  var
    FileStream: TStream;
  begin
    FileStream := TFileStream.Create(DestFileName, fmCreate);
    try
      NetHTTPClient.Get(URL, FileStream);
    finally
      FreeAndNil(FileStream);
    end;
  end;

var
  folder: string;
  id: Integer;
  sp: TFDStoredproc;
  urlFile, tmpFileName, FileName, fullFileName: string;
begin
  SiMain.EnterMethod(Self, 'InserimentoCandidatura');
  SiMain.LogStringList('ContentFields', ctx.Request.ContentFields);

  urlFile := ctx.Request.ContentFields.Values['Allega il Curricululm Vitae (è consentito solo file .pdf e con una dimensione massima di 20MB)'];
  SiMain.LogString('urlFile', urlFile);

  FileName := GetFileName(urlFile);
  SiMain.LogString('FileName', FileName);

  // scaricare il file in un temporaneo
  tmpFileName := TPath.GetTempFileName;
  try
    if not urlFile.IsEmpty then
      DownloadFile(urlFile, tmpFileName);

    AdminConnect;
    try
      StartTrans;
      try
        // CREATE OR ALTER PROCEDURE WEB_CANDIDATURE_ADD (
        // DATA_CANDIDATURA     DATA,
        // ORA_CANDIDATURA      ORA,
        // CODICE_FISCALE       CODICE_FISCALE,
        // COGNOME              COGNOME,
        // NOME                 NOME,
        // E_MAIL               E_MAIL,
        // AREA_DI_INTERESSE    DESCRIZIONE,
        // AREA_DI_INSEGNAMENTO DESCRIZIONE,
        // ALTRO                DESCRIZIONE,
        // URL_CV               URL,
        // FILE_NAME_CV         FILE_NAME,
        // CONTENT_FIELDS       MEMO)
        // RETURNS (
        // ID_CANDIDATURA_WEB ID,
        // FULL_FILE_NAME     FILE_NAME)

        sp := CreateStoredProc('WEB_CANDIDATURE_ADD');
        try
          sp.ParamByName('DATA_CANDIDATURA').AsDate := Date;
          sp.ParamByName('ORA_CANDIDATURA').AsTime := Now;

          SetParam(sp.ParamByName('CODICE_FISCALE'), ctx.Request.ContentFields.Values['Codice Fiscale']);

          SetParam(sp.ParamByName('COGNOME'), ctx.Request.ContentFields.Values['Cognome']);
          SetParam(sp.ParamByName('NOME'), ctx.Request.ContentFields.Values['Nome']);
          SetParam(sp.ParamByName('E_MAIL'), ctx.Request.ContentFields.Values['Email']);

          SetParam(sp.ParamByName('AREA_DI_INTERESSE'), ctx.Request.ContentFields.Values['Area di interesse']);
          SetParam(sp.ParamByName('AREA_DI_INSEGNAMENTO'), ctx.Request.ContentFields.Values['Area di insegnamento (da compilare solo se si è selezionato "formatore" in "area di interesse")']);
          SetParam(sp.ParamByName('ALTRO'), ctx.Request.ContentFields.Values['da compliare solo se hai selezionato "Altro"']);
          SetParam(sp.ParamByName('URL_CV'), urlFile);
          SetParam(sp.ParamByName('FILE_NAME_CV'), FileName);

          sp.ParamByName('CONTENT_FIELDS').AsString := ctx.Request.ContentFields.Text;
          sp.ExecProc;
          try
            id := sp.ParamByName('ID_CANDIDATURA_WEB').asInteger;
            fullFileName := sp.ParamByName('FULL_FILE_NAME').AsString;

            SiMain.LogInteger('Result', id);
            SiMain.LogString('fullFileName', fullFileName);
          finally
            sp.Close;
          end;
        finally
          FreeAndNil(sp);
        end;

        if not fullFileName.IsEmpty then
        begin
          SiMain.LogVerbose('Copia file in corso...');
          folder := ExpandUNCFileName(ExcludeTrailingPathDelimiter(ExtractFilePath(fullFileName)));
          SiMain.LogString('Cartella Destinazione', folder);

          if System.SysUtils.ForceDirectories(folder) then
          begin
            SiMain.LogVerbose('Cartella destinazione creata');

            TFile.Copy(tmpFileName, fullFileName, True);
            SiMain.LogVerbose('File copiato.');
          end
          else
          begin
            SiMain.LogVerbose('Cartella destinazione NON creata');
            SiMain.LogString('SysErrorMessage', SysErrorMessage(GetLastError));
            SiMain.LogInteger('GetLastError', GetLastError);

            raise Exception.Create('Impossibile creare la cartella di destinazione.');
          end;
        end;

        Commit;

        ctx.Response.Render200;
      except
        on E: Exception do
        begin
          Rollback;
          raise;
        end;
      end;
    finally;
      Disconnect;
    end;
  finally
    if TFile.Exists(tmpFileName) then
      TFile.Delete(tmpFileName);
  end;
  SiMain.LeaveMethod(Self, 'InserimentoCandidatura');
end;

initialization

RegisterClass(TCAPAC);

end.
