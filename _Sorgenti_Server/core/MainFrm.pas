unit MainFrm;

interface

uses
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Menus,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.AppEvnts,
  Vcl.StdCtrls,
  Data.DB,
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
  IdHTTPWebBrokerBridge,
  IdContext,
  Web.HTTPApp,
  cxImageList,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxButtons,
  dxUIAClasses;

type
  TMainForm = class(TForm)
    ButtonStart: TcxButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents: TApplicationEvents;
    ButtonOpenBrowser: TcxButton;
    logMemo: TMemo;
    cbLogRequest: TCheckBox;
    cbLogResponse: TCheckBox;
    cbSkipVerifyToken: TCheckBox;
    Image1: TImage;
    lblHostName: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblIpAddress: TLabel;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    ImageList: TcxImageList;
    ActionList: TActionList;
    Start: TAction;
    Stop: TAction;
    OpenBrowser: TAction;
    OpenFolder: TAction;
    ClearLog: TAction;
    Start1: TMenuItem;
    Stop1: TMenuItem;
    OpenBrowser1: TMenuItem;
    N1: TMenuItem;
    OpenFolder1: TMenuItem;
    N2: TMenuItem;
    OpenIni: TAction;
    ClearLog1: TMenuItem;
    Action11: TMenuItem;
    ButtonStop: TcxButton;
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
    procedure cbSkipVerifyTokenClick(Sender: TObject);
    procedure ClearLogExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OpenBrowserExecute(Sender: TObject);
    procedure OpenFolderExecute(Sender: TObject);
    procedure OpenIniExecute(Sender: TObject);
    procedure StartExecute(Sender: TObject);
    procedure StartUpdate(Sender: TObject);
    procedure StopExecute(Sender: TObject);
    procedure StopUpdate(Sender: TObject);
  private
    Server: TIdHTTPWebBrokerBridge;
    procedure StartServer;
  private
    procedure BeforeRequestLog(Request: TWebRequest; Response: TWebResponse);
    procedure AfterRequestLog(Request: TWebRequest; Response: TWebResponse);
    procedure DoParseAuthentication(AContext: TIdContext; const AAuthType, AAuthData: String; var VUsername, VPassword: String; var VHandled: Boolean);
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  Winapi.ShellApi,
  Winapi.WinSock,
  idGlobal,
  IdStack,
  Web.WebReq,
  Server_Module,
  zz.Folders,
  zz.SmartInspect,
  lib.Config,
  routes,
  SmartInspect.Core.SiAuto,
  SmartInspect.Core,
  lib.datasetProps,
  lib.widgetOptions;

function GetHostName: AnsiString;
type
  TaPInAddr = array [0 .. 10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  WSAData: TWSAData;
  HostName: array [0 .. 255] of AnsiChar;
begin
  Result := '';
  if WSAStartup($101, WSAData) = 0 then
    try
      Winapi.WinSock.GetHostName(@HostName[0], SizeOf(HostName));
      Result := HostName;
    finally
      WSACleanup;
    end;
end;

// function GetIPAddress: string;
// type
// TaPInAddr = array [0 .. 10] of PInAddr;
// PaPInAddr = ^TaPInAddr;
// var
// WSAData: TWSAData;
// pHe: PHostEnt;
// pPtr: PaPInAddr;
// HostName: array [0 .. 255] of AnsiChar;
// begin
// Result := '';
// if WSAStartup($101, WSAData) = 0 then
// try
// WinSock.GetHostName(@HostName[0], SizeOf(HostName));
// pHe := GetHostByName(@HostName[0]);
// if pHe <> nil then
// begin
// pPtr := PaPInAddr(pHe^.h_addr_list);
// if pPtr^[0] <> nil then
// begin
// if string(inet_ntoa(pPtr^[0]^)) = '10.10.10.10' then
// if pPtr^[1] <> nil then
// Result := string(inet_ntoa(pPtr^[1]^))
// else
// Result := '127.0.0.1'
// else
// Result := string(inet_ntoa(pPtr^[0]^));
// end
// else
// Result := '127.0.0.1';
// end
// finally
// WSACleanup;
// end;
// end;

Function GetIPAddress(const Mask: string): String;
var
  I: Integer;
  IdStackLocalAddressList: TIdStackLocalAddressList;
begin
  Result := '';

  TIdStack.IncUsage;
  try
    IdStackLocalAddressList := TIdStackLocalAddressList.Create;
    try
      GStack.GetLocalAddressList(IdStackLocalAddressList);

      for I := 0 to IdStackLocalAddressList.Count - 1 do
      begin
        if IdStackLocalAddressList[I].IPVersion = Id_IPv4 then
          if IdStackLocalAddressList[I].IPAddress.StartsWith(Mask) then
            Exit(IdStackLocalAddressList[I].IPAddress);
      end;
    finally
      FreeAndNil(IdStackLocalAddressList);
    end;
  finally
    TIdStack.DecUsage;
  end;
end;

procedure TMainForm.ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
begin
  EditPort.Enabled := not Server.Active;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  si.Enabled := True;
  Server := TIdHTTPWebBrokerBridge.Create(Self);
  Server.OnParseAuthentication := DoParseAuthentication;

  logMemo.Lines.Clear;

  Server_Module.BeforeRequestLogProcedure := BeforeRequestLog;
  Server_Module.AfterRequestLogProcedure := AfterRequestLog;

  lblHostName.Caption := GetHostName;
  lblIpAddress.Caption := GetIPAddress('192.168.1');
  Caption := Caption + ' (' + lblIpAddress.Caption + ')';

  cbSkipVerifyToken.Checked := ConfigProps.SkipVerifyToken;
end;

procedure TMainForm.DoParseAuthentication(AContext: TIdContext; const AAuthType, AAuthData: String; var VUsername, VPassword: String; var VHandled: Boolean);
begin

  if AAuthType.Equals('Bearer') then
  begin
    // recuperare il JWT?      TIdBearerAuthentication
    VHandled := True;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Start.Execute;
end;

procedure TMainForm.StartServer;
begin
  if not Server.Active then
  begin
    ConfigProps.Load;
    Server.Bindings.Clear;
    Server.DefaultPort := StrToInt(EditPort.Text);
    Server.Active := True;
  end;
end;

procedure TMainForm.BeforeRequestLog(Request: TWebRequest; Response: TWebResponse);
begin
  if cbLogRequest.Checked then
    logMemo.Lines.Add(TimeToStr(now) + ' ' + Request.Method + ' Request - ' + Request.PathInfo);
end;

procedure TMainForm.AfterRequestLog(Request: TWebRequest; Response: TWebResponse);
begin
  if cbLogResponse.Checked then
    logMemo.Lines.Add(TimeToStr(now) + ' Response - ' + Response.Content);

  // separatore
  logMemo.Lines.Add('');
end;

procedure TMainForm.ApplicationEventsException(Sender: TObject; E: Exception);
begin
  logMemo.Lines.Add(''.PadLeft(80, '_'));
  logMemo.Lines.Add(E.Message);
  logMemo.Lines.Add(''.PadLeft(80, '_'));
end;

procedure TMainForm.ClearLogExecute(Sender: TObject);
begin
  logMemo.Clear;
end;

procedure TMainForm.OpenBrowserExecute(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  LURL := Format('http://' + GetIPAddress('192.168.1') + ':%s', [EditPort.Text]);
  ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TMainForm.StartExecute(Sender: TObject);
begin
  StartServer;
end;

procedure TMainForm.StartUpdate(Sender: TObject);
begin
  Start.Enabled := not Server.Active;
end;

procedure TMainForm.StopExecute(Sender: TObject);
var
  I: Integer;
begin
  Server.Active := False;
  Server.Bindings.Clear;

  cacheDatasets.Clear;
  cacheWidgets.Clear;

  // Web.WebReq.FreeWebModules;
  //
  // for I := FDManager.ConnectionCount - 1 downto 0 do
  // FDManager.DeleteConnectionDef(FDManager.Connections[I].Name);
end;

procedure TMainForm.StopUpdate(Sender: TObject);
begin
  Stop.Enabled := Server.Active;
end;

procedure TMainForm.OpenFolderExecute(Sender: TObject);
var
  Folder: string;
begin
  Folder := TFolders.SubFolder(ConfigProps.CartellaFiles, 'SQL');
  ShellExecute(0, nil, PChar(Folder), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TMainForm.OpenIniExecute(Sender: TObject);
begin
  ShellExecute(0, nil, PChar(TFolders.IniFileName), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TMainForm.cbSkipVerifyTokenClick(Sender: TObject);
begin
  Web.WebReq.FreeWebModules;
  ConfigProps.SkipVerifyToken := cbSkipVerifyToken.Checked;
end;

initialization

finalization

Web.WebReq.FreeWebModules;

end.



