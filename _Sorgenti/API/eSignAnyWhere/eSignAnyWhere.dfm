object eSignAnyWhereEngine: TeSignAnyWhereEngine
  Height = 415
  Width = 573
  object OAuth2Authenticator: TOAuth2Authenticator
    AccessToken = 'wymp7uysd1jued94hhhe5jl4ly2ki5eciccwy5kzappe4gxq4ixd5su39rb9dwmg'
    TokenType = ttBEARER
    Left = 64
    Top = 16
  end
  object RESTResponse: TRESTResponse
    Left = 64
    Top = 88
  end
  object restClient: TRESTClient
    Authenticator = OAuth2Authenticator
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://demo.esignanywhere.net/Api'
    Params = <>
    SecureProtocols = [TLS11, TLS12, TLS13]
    SynchronizedEvents = False
    Left = 200
    Top = 16
  end
  object reqValidate: TRESTRequest
    Client = restClient
    Params = <>
    Resource = 'authorization/validate'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 200
    Top = 88
  end
  object reqVersion: TRESTRequest
    Client = restClient
    Params = <>
    Resource = 'system/version'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 200
    Top = 232
  end
  object reqWhoAmI: TRESTRequest
    Client = restClient
    Params = <>
    Resource = 'authorization/whoami'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 200
    Top = 152
  end
  object reqAutomaticProfile: TRESTRequest
    Client = restClient
    Params = <>
    Resource = 'system/version'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 200
    Top = 288
  end
  object reqUpload: TRESTRequest
    Client = restClient
    Method = rmPOST
    Params = <
      item
        Kind = pkFILE
        Name = 'File'
        ContentTypeStr = 'application/pdf'
      end>
    Resource = 'file/upload'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 320
    Top = 88
  end
  object reqSend: TRESTRequest
    Client = restClient
    Method = rmPOST
    Params = <>
    Resource = 'envelope/send'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 320
    Top = 232
  end
  object restPrepare: TRESTRequest
    Client = restClient
    Method = rmPOST
    Params = <>
    Resource = 'file/prepare'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 320
    Top = 152
  end
  object reqEnvelope: TRESTRequest
    Client = restClient
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'EnvelopeId'
        Options = [poAutoCreated]
      end>
    Resource = 'envelope/{EnvelopeId}'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 400
    Top = 232
  end
  object reqFind: TRESTRequest
    Client = restClient
    Method = rmPOST
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'FileId'
      end>
    Resource = 'envelope/find'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 480
    Top = 232
  end
  object reqFile: TRESTRequest
    AssignedValues = [rvAccept]
    Accept = 'application/pdf'
    Client = restClient
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'fileId'
        Options = [poAutoCreated]
      end>
    Resource = 'file/{fileId}'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 400
    Top = 349
  end
  object reqEnvelopeFile: TRESTRequest
    AssignedValues = [rvAccept]
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    Client = restClient
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'EnvelopeId'
        Options = [poAutoCreated]
      end>
    Resource = 'envelope/{EnvelopeId}/files'
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 400
    Top = 288
  end
end
