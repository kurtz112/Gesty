unit lib.http;

interface

uses
  Web.HTTPApp;

type
  HttpStatus = record
  const
    Continue = 100;
    SwitchingProtocols = 101;
    OK = 200;
    Created = 201;
    Accepted = 202;
    NonAuthoritativeInformation = 203;
    NoContent = 204;
    ResetContent = 205;
    PartialContent = 206;
    MultipleChoices = 300;
    MovedPermanently = 301;
    MovedTemporarily = 302;
    SeeOther = 303;
    NotModified = 304;
    UseProxy = 305;
    BadRequest = 400;
    Unauthorized = 401;
    PaymentRequired = 402;
    Forbidden = 403;
    NotFound = 404;
    MethodNotAllowed = 405;
    NoneAcceptable = 406;
    ProxyAuthenticationRequired = 407;
    RequestTimeout = 408;
    Conflict = 409;
    Gone = 410;
    LengthRequired = 411;
    UnlessTrue = 412;
    InternalServerError = 500;
    NotImplemented = 501;
    BadGateway = 502;
    ServiceUnavailable = 503;
    GatewayTimeout = 504;
  end;

implementation

end.
