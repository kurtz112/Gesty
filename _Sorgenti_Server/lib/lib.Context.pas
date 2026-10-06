unit lib.Context;

interface

uses
  Web.HTTPApp;

type
  TzContext = record
    App: String;
    SessionID: integer;
    UserID: integer;
    Username: string;
    Password: string;
    ConnectionName: string;
    Request: TWebRequest;
    Response: TWebResponse;
    procedure Init(aRequest: TWebRequest; aResponse: TWebResponse);
  end;

implementation

procedure TzContext.Init(aRequest: TWebRequest; aResponse: TWebResponse);
begin
  App := '';
  SessionID := -1;
  UserID := -1;
  Username := '';
  Password := '';
  ConnectionName := '';
  Request := aRequest;
  Response := aResponse;
end;

end.
