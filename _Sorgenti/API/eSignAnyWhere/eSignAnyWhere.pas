unit eSignAnyWhere;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Generics.Collections,
  System.NetEncoding,
  System.IOUtils,
  System.UITypes,
  Vcl.Forms,
  Vcl.Dialogs,
  REST.JSON,
  REST.Types,
  REST.Authenticator.OAuth.WebForm.Win,
  REST.Client,
  REST.Authenticator.OAuth,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  zz.JSON.DTO,

  eSignAnyWhere.Classes.Prepare,
  eSignAnyWhere.Classes.PrepareResponse,
  eSignAnyWhere.Classes.FindRequest,
  eSignAnyWhere.Classes.EnvelopeResponse,
  eSignAnyWhere.Classes.EnvelopeFiles,
  eSignAnyWhere.Classes.Envelope,
  eSignAnyWhere.Params,
  eSignAnyWhere.Utils,

  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TeSignAnyWhereEngine = class(TDataModule)
    OAuth2Authenticator: TOAuth2Authenticator;
    RESTResponse: TRESTResponse;
    restClient: TRESTClient;
    reqValidate: TRESTRequest;
    reqVersion: TRESTRequest;
    reqWhoAmI: TRESTRequest;
    reqAutomaticProfile: TRESTRequest;
    reqUpload: TRESTRequest;
    reqSend: TRESTRequest;
    restPrepare: TRESTRequest;
    reqEnvelope: TRESTRequest;
    reqFind: TRESTRequest;
    reqFile: TRESTRequest;
    reqEnvelopeFile: TRESTRequest;
    procedure RESTRequestAfterExecute(Sender: TCustomRESTRequest);
  private
    FAuthToken: string;
    FBaseUrl: string;
    FParams: TeSignAnyWhereParams;
  private
    procedure SetParams(const Value: TeSignAnyWhereParams);
  private
    procedure InitEnvelope(Envelope: TEnvelope);

    function CreateActivityOTP(PrepareResponse: TPrepareResponse; out Activity: TActivities): boolean;
    function CreateActivityRemoteSign(PrepareResponse: TPrepareResponse; const PlaceHolder: string; const IdentificativoFirmaRemota: string; out Activity: TActivities): boolean;

    function ConvertPreparedSignature(preparedSignature: eSignAnyWhere.Classes.PrepareResponse.TSignatures): TSignatures;
    function ConvertPreparedRemoteSignature(VisibleSignature: eSignAnyWhere.Classes.PrepareResponse.TVisibleSignatures): TVisibleSignatures;
    procedure SetAuthToken(const Value: string);
    procedure SetBaseUrl(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
  public
    function Validate: boolean;
    function WhoAmI: boolean;
    function Version: boolean;
    function AutomaticProfile: boolean;
  private
    procedure CheckForResponseError();
  public
    function Upload(const FileName: string): string;
    function Prepare: TPrepareResponse;
  public
    function Firma(const FileName: String): string;

    function Envelope(): TEnvelopeResponse;
    function EnvelopeCompleted(): boolean;
    function EnvelopeStatus(): string;

    function DownloadFiles(const FileNameSigned, FileNameAudit: string): string;

    function Find(): string;
  public
    property BaseUrl: string read FBaseUrl write SetBaseUrl;
    property AuthToken: string read FAuthToken write SetAuthToken;

    property Params: TeSignAnyWhereParams read FParams write SetParams;
  end;

var
  eSignAnyWhereEngine: TeSignAnyWhereEngine;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TOpenApi }

constructor TeSignAnyWhereEngine.Create(AOwner: TComponent);
var
  comp: TComponent;
begin
  inherited;
  BaseUrl := 'https://demo.esignanywhere.net/Api/V6/'; // props, non fields, devono inizializzare
  AuthToken := 'wymp7uysd1jued94hhhe5jl4ly2ki5eciccwy5kzappe4gxq4ixd5su39rb9dwmg';

  Params.Init;
  restClient.BaseUrl := BaseUrl;
  OAuth2Authenticator.AccessToken := AuthToken;

  for comp in self do
    if comp is TRESTRequest then
      TRESTRequest(comp).OnAfterExecute := RESTRequestAfterExecute;

  ForceDirectories(JsonFolder);
end;

procedure TeSignAnyWhereEngine.RESTRequestAfterExecute(Sender: TCustomRESTRequest);
begin
  SiMain.LogSeparator;
  SiMain.LogColored(TColors.Lightseagreen, 'Chiamata REST');
  SiMain.LogString('FullRequestURI', RESTResponse.FullRequestURI);
  SiMain.LogString('RootElement', RESTResponse.RootElement);

  SiMain.LogString('StatusText', RESTResponse.StatusText);
  SiMain.LogInteger('StatusCode', RESTResponse.StatusCode);
  SiMain.LogString('Content', RESTResponse.Content);

  if not RESTResponse.JSONText.IsEmpty then
    SiMain.LogString('JSONText', RESTResponse.JSONText);

  if not RESTResponse.ErrorMessage.IsEmpty then
    SiMain.LogString('ErrorMessage', RESTResponse.ErrorMessage);
end;

procedure TeSignAnyWhereEngine.SetParams(const Value: TeSignAnyWhereParams);
begin
  FParams.Assign(Value);
end;

/// ////////////////////////////////////////////////////////////////////////////

function TeSignAnyWhereEngine.Validate: boolean;
begin
  reqValidate.Execute;
end;

function TeSignAnyWhereEngine.WhoAmI: boolean;
begin
  reqWhoAmI.Execute;
end;

function TeSignAnyWhereEngine.Version: boolean;
begin
  reqVersion.Execute;
end;

function TeSignAnyWhereEngine.AutomaticProfile: boolean;
begin
  reqAutomaticProfile.Execute;
end;

function TeSignAnyWhereEngine.ConvertPreparedRemoteSignature(VisibleSignature: eSignAnyWhere.Classes.PrepareResponse.TVisibleSignatures): TVisibleSignatures;
begin
  Result := TVisibleSignatures.Create;
  Result.DocumentNumber := VisibleSignature.DocumentNumber;
  Result.UseExternalTimestampServer := VisibleSignature.UseExternalTimestampServer;

  Result.FieldDefinition := TFieldDefinition.Create;
  Result.FieldDefinition.Position.PageNumber := VisibleSignature.FieldDefinition.Position.PageNumber;
  Result.FieldDefinition.Position.X := VisibleSignature.FieldDefinition.Position.X;
  Result.FieldDefinition.Position.Y := VisibleSignature.FieldDefinition.Position.Y;
  Result.FieldDefinition.Size.Height := 50; // preparedSignature.FieldDefinition.Size.Height;
  Result.FieldDefinition.Size.Width := 200; // preparedSignature.FieldDefinition.Size.Width;
  //
  Result.FieldDefinition.TextFormat.Bold := True;
  Result.FieldDefinition.TextFormat.Bold := True;
  Result.FieldDefinition.TextFormat.FontName := 'Times New Roman';
  Result.FieldDefinition.TextFormat.FontSizeInPt := 14;
  Result.FieldDefinition.TextFormat.Italic := false;
  // Result.FieldDefinition.TextFormat.TextAlign: string;
  // Result.FieldDefinition.TextFormat.TextColor: string;
end;

function TeSignAnyWhereEngine.Upload(const FileName: string): string;
begin
  Result := '';

  if FileName.IsEmpty then
    raise Exception.Create('FileName non specificato.');

  if not TFile.Exists(FileName) then
    raise Exception.Create('File non trovato: ' + FileName);

  //
  reqUpload.Params.ParameterByName('File').Value := FileName;
  reqUpload.Execute;

  if RESTResponse.GetSimpleValue('FileId', Result) then
    Params.FileId := Result;
end;

function TeSignAnyWhereEngine.Prepare: TPrepareResponse;
var
  PrepareRequest: TPrepareRequest;
  SigStringConfiguration: TSigStringConfigurations;
begin
  Result := nil;

  Params.CheckFileId;

  PrepareRequest := TPrepareRequest.Create;
  try
    PrepareRequest.FileIds.Add(Params.FileId);
    PrepareRequest.ClearAdvancedDocumentTags := True;

    SigStringConfiguration := TSigStringConfigurations.Create;
    SigStringConfiguration.StartPattern := '{{';
    SigStringConfiguration.EndPattern := '}}';
    SigStringConfiguration.ClearSigString := True;
    SigStringConfiguration.SearchEntireWordOnly := True;
    PrepareRequest.SigStringConfigurations.Add(SigStringConfiguration);
    //
    __JSONLog(Params, 'Prepare.Request', PrepareRequest.AsJson);
    //
    restPrepare.AddBody(PrepareRequest);
    restPrepare.Execute;
  finally
    FreeAndNil(PrepareRequest);
  end;

  __JSONLog(Params, 'Prepare.Response', RESTResponse.Content);

  Result := TPrepareResponse.Create;
  try
    Result.AsJson := RESTResponse.Content;

    if Result.UnassignedElements.Signatures.Count = 0 then
      raise Exception.Create('Documento non valido: nessuna firma trovata.');
  except
    on e: Exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

procedure TeSignAnyWhereEngine.InitEnvelope(Envelope: TEnvelope);
begin
  Envelope.Name := Params.EnvelopeName;
  Envelope.AddDocumentTimestamp := Params.AddDocumentTimestamp;
  Envelope.ShareWithTeam := Params.ShareWithTeam;
  Envelope.ReminderConfiguration.Enabled := Params.Reminder;
  Envelope.ReminderConfiguration.FirstReminderInDays := Params.FirstReminderInDays;
  Envelope.ReminderConfiguration.ReminderResendIntervalInDays := Params.ReminderResendIntervalInDays;
  Envelope.ReminderConfiguration.BeforeExpirationInDays := Params.BeforeExpirationInDays;
  Envelope.ExpirationConfiguration.ExpirationInSecondsAfterSending := Params.ExpirationInSecondsAfterSending;

  Envelope.EmailConfiguration.Subject := Params.EmailConfigurationSubject;
  Envelope.EmailConfiguration.Message := Params.EmailConfigurationMessage; { TODO : Configurare }
end;

function TeSignAnyWhereEngine.ConvertPreparedSignature(preparedSignature: eSignAnyWhere.Classes.PrepareResponse.TSignatures): TSignatures;
begin
  Result := TSignatures.Create;
  Result.AllowedSignatureTypes.OneTimePassword.UseExternalSignatureImage := preparedSignature.AllowedSignatureTypes.OneTimePassword.UseExternalSignatureImage;
  Result.DisplayName := preparedSignature.DisplayName;
  Result.DocumentNumber := preparedSignature.DocumentNumber;
  Result.ElementId := preparedSignature.ElementId;
  //
  Result.FieldDefinition.Position.PageNumber := preparedSignature.FieldDefinition.Position.PageNumber;
  Result.FieldDefinition.Position.X := preparedSignature.FieldDefinition.Position.X;
  Result.FieldDefinition.Position.Y := preparedSignature.FieldDefinition.Position.Y;
  Result.FieldDefinition.Size.Height := 50; // preparedSignature.FieldDefinition.Size.Height;
  Result.FieldDefinition.Size.Width := 200; // preparedSignature.FieldDefinition.Size.Width;
  //
  Result.FieldDefinition.TextFormat.Bold := True;
  Result.FieldDefinition.TextFormat.Bold := True;
  Result.FieldDefinition.TextFormat.FontName := 'Times New Roman';
  Result.FieldDefinition.TextFormat.FontSizeInPt := 14;
  Result.FieldDefinition.TextFormat.Italic := false;
  // Result.FieldDefinition.TextFormat.TextAlign: string;
  // Result.FieldDefinition.TextFormat.TextColor: string;
  //

  Result.Required := True; // preparedSignature.Required;
  Result.UseExternalTimestampServer := false;
  Result.TaskConfiguration.BatchGroup := '1';

  Result.AllowedSignatureTypes.OneTimePassword.Preferred := false;
  Result.AllowedSignatureTypes.OneTimePassword.StampImprintConfiguration.DisplayPhoneNumber := false;
  Result.AllowedSignatureTypes.OneTimePassword.StampImprintConfiguration.DisplayName := True;
  Result.AllowedSignatureTypes.OneTimePassword.StampImprintConfiguration.DisplayExtraInformation := True;
  Result.AllowedSignatureTypes.OneTimePassword.StampImprintConfiguration.DisplaySignatureDate := True;
  Result.AllowedSignatureTypes.OneTimePassword.StampImprintConfiguration.FontName := 'Times New Roman';
  Result.AllowedSignatureTypes.OneTimePassword.StampImprintConfiguration.FontSizeInPt := 14;
  Result.AllowedSignatureTypes.OneTimePassword.UseExternalSignatureImage := 'Disabled';
end;

function TeSignAnyWhereEngine.CreateActivityOTP(PrepareResponse: TPrepareResponse; out Activity: TActivities): boolean;
var
  VisibilityOption: TVisibilityOptions;
  preparedSignature: eSignAnyWhere.Classes.PrepareResponse.TSignatures;
begin
  Result := false;

  Activity := eSignAnyWhere.Classes.Envelope.TActivities.Create;
  try
    VisibilityOption := TVisibilityOptions.Create;
    VisibilityOption.DocumentNumber := 1;
    VisibilityOption.IsHidden := false;
    Activity.VisibilityOptions.Add(VisibilityOption);

    Activity.Action.Sign := TSign.Create;
    Activity.Action.Sign.SequenceMode := Params.FirmaOTP.SequenceMode;
    Activity.Action.Sign.SigningGroup := Params.FirmaOTP.SigningGroup;

    Activity.Action.Sign.BatchConfiguration.Mode := 'OptOut'; // 'Basic';
    Activity.Action.Sign.BatchConfiguration.RequireScrollingOverAllSignaturesBeforeSigning := True;

    Activity.Action.Sign.RecipientConfiguration.AllowAccessAfterFinish := Params.FirmaOTP.AllowAccessAfterFinish;
    Activity.Action.Sign.RecipientConfiguration.AllowDelegation := Params.FirmaOTP.AllowDelegation;

    Activity.Action.Sign.RecipientConfiguration.IncludedEmailAppLinks.AndroId := Params.FirmaOTP.AppLinks_AndroId;
    Activity.Action.Sign.RecipientConfiguration.IncludedEmailAppLinks.IOS := Params.FirmaOTP.AppLinks_IOS;
    Activity.Action.Sign.RecipientConfiguration.IncludedEmailAppLinks.Windows := Params.FirmaOTP.AppLinks_Windows;

    Activity.Action.Sign.RecipientConfiguration.RequireViewContentBeforeFormFilling := Params.FirmaOTP.RequireViewContentBeforeFormFilling;
    Activity.Action.Sign.RecipientConfiguration.ContactInformation.LanguageCode := Params.FirmaOTP.LanguageCode;
    Activity.Action.Sign.RecipientConfiguration.NotificationChannel := Params.FirmaOTP.NotificationChannel;

    Activity.Action.Sign.RecipientConfiguration.ContactInformation.givenName := Params.FirmaOTP.cognome;
    Activity.Action.Sign.RecipientConfiguration.ContactInformation.surName := Params.FirmaOTP.nome;
    Activity.Action.Sign.RecipientConfiguration.ContactInformation.email := Params.FirmaOTP.email;
    Activity.Action.Sign.RecipientConfiguration.ContactInformation.phoneNumber := Params.FirmaOTP.telefono;

    // firme
    for preparedSignature in PrepareResponse.UnassignedElements.Signatures do
      if preparedSignature.ElementId.StartsWith(Params.FirmaOTP.PlaceHolder, True) then
        Activity.Action.Sign.Elements.Signatures.Add(ConvertPreparedSignature(preparedSignature));

    // se non ha firme => free
    Result := Activity.Action.Sign.Elements.Signatures.Count > 0;

    if not Result then
      Activity.Free;
  except
    on e: Exception do
    begin
      Activity.Free;
      raise;
    end;
  end;
end;

function TeSignAnyWhereEngine.CreateActivityRemoteSign(PrepareResponse: TPrepareResponse; const PlaceHolder: string; const IdentificativoFirmaRemota: string; out Activity: TActivities): boolean;
var
  VisibilityOption: TVisibilityOptions;
  preparedSignature: eSignAnyWhere.Classes.PrepareResponse.TSignatures;
  preparedActivity: eSignAnyWhere.Classes.PrepareResponse.TActivities;
  VisibleSignature: eSignAnyWhere.Classes.PrepareResponse.TVisibleSignatures;
begin
  Result := false;

  Activity := eSignAnyWhere.Classes.Envelope.TActivities.Create;
  try
    VisibilityOption := TVisibilityOptions.Create;
    VisibilityOption.DocumentNumber := 1;
    VisibilityOption.IsHidden := false;
    Activity.VisibilityOptions.Add(VisibilityOption);

    Activity.Action.SignAutomatic := TSignAutomatic.Create;
    Activity.Action.SignAutomatic.ProfileId := IdentificativoFirmaRemota;
    Activity.Action.SignAutomatic.RenderingLanguageCode := 'IT';

    for preparedSignature in PrepareResponse.UnassignedElements.Signatures do
      for preparedActivity in PrepareResponse.Activities do
        if preparedActivity.Action.SignAutomatic <> nil then
          for VisibleSignature in preparedActivity.Action.SignAutomatic.VisibleSignatures do
            if VisibleSignature.id.StartsWith(PlaceHolder, True) then // Filtra tra direttore/legale
              Activity.Action.SignAutomatic.VisibleSignatures.Add(ConvertPreparedRemoteSignature(VisibleSignature));

    // se non ha firme => free
    Result := Activity.Action.SignAutomatic.VisibleSignatures.Count > 0;

    Result := True;
    if not Result then
      Activity.Free;
  except
    on e: Exception do
    begin
      Activity.Free;
      raise;
    end;
  end;
end;

function TeSignAnyWhereEngine.Firma(const FileName: String): string;
var
  PrepareResponse: TPrepareResponse;
  Envelope: TEnvelope;
  doc: TDocuments;
  Activity: TActivities;

  Action: TAction;
  VisibilityOption: TVisibilityOptions;
  preparedSignatures: eSignAnyWhere.Classes.PrepareResponse.TSignatures;
begin
  Result := '';

  Upload(FileName);

  PrepareResponse := Prepare;
  try
    Envelope := TEnvelope.Create;
    try
      InitEnvelope(Envelope);

      // PDF
      doc := TDocuments.Create;
      doc.FileId := Params.FileId;
      doc.DocumentNumber := 1;
      Envelope.Documents.Add(doc);

      Activity := nil;
      if not Params.FirmaRemota1.IdentificativoFirmaRemota.IsEmpty then
        if CreateActivityRemoteSign(PrepareResponse, Params.FirmaRemota1.PlaceHolder, Params.FirmaRemota1.IdentificativoFirmaRemota, Activity) then
          Envelope.Activities.Add(Activity);

      Activity := nil;
      if not Params.FirmaRemota2.IdentificativoFirmaRemota.IsEmpty then
        if CreateActivityRemoteSign(PrepareResponse, Params.FirmaRemota2.PlaceHolder, Params.FirmaRemota2.IdentificativoFirmaRemota, Activity) then
          Envelope.Activities.Add(Activity);

      Activity := nil;
      if CreateActivityOTP(PrepareResponse, Activity) then
        Envelope.Activities.Add(Activity);

      __JSONLog(Params, 'Envelope_Sent.Request', Envelope.AsJson);

      reqSend.AddBody(Envelope);
      reqSend.Execute;

      __JSONLog(Params, 'Envelope_Sent.Response', RESTResponse.Content);

      CheckForResponseError();

      if RESTResponse.GetSimpleValue('EnvelopeId', Result) then
        Params.EnvelopeId := Result;
    finally
      FreeAndNil(Envelope);
    end;
  finally
    FreeAndNil(PrepareResponse);
  end;
end;

procedure TeSignAnyWhereEngine.CheckForResponseError;
var
  ErrorId, ErrorMsg: string;
begin

  if RESTResponse.GetSimpleValue('ErrorId', ErrorId) then
  begin
    if not RESTResponse.GetSimpleValue('Message', ErrorMsg) then
      ErrorMsg := 'Errore generico: ' + RESTResponse.StatusCode.ToString();

    raise Exception.Create(ErrorMsg);
  end;
end;

function TeSignAnyWhereEngine.Envelope: TEnvelopeResponse;
begin
  Result := nil;

  Params.CheckEnvelopeId;
  reqEnvelope.Params.ParameterByName('EnvelopeId').Value := Params.EnvelopeId;

  // reqEnvelope.Params.ParameterByName('EnvelopeId').Value := '05c94411-23c7-4225-a7cc-91424173e69a';

  reqEnvelope.Execute;

  __JSONLog(Params, 'Envelope.Response', RESTResponse.Content);

  Result := TEnvelopeResponse.Create;
  try
    // Result := RESTResponse.Content;
    Result.AsJson := RESTResponse.Content;
  except
    on e: Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

function TeSignAnyWhereEngine.EnvelopeStatus: string;
var
  EnvelopeResponse: TEnvelopeResponse;
begin
  Result := '';

  EnvelopeResponse := Envelope();
  try
    Result := EnvelopeResponse.EnvelopeStatus;
  finally
    FreeAndNil(EnvelopeResponse);
  end;
end;

function TeSignAnyWhereEngine.EnvelopeCompleted: boolean;
begin
  Result := SameText(EnvelopeStatus, 'Completed');
end;

function TeSignAnyWhereEngine.DownloadFiles(const FileNameSigned, FileNameAudit: string): string;
var
  EnvelopeFilesResponse: TEnvelopeFilesResponse;
  FileSignedId: string;
  FileAuditId: string;

  procedure SaveBytesToFile(const Data: TBytes; const FileName: string);
  var
    Stream: TFileStream;
  begin
    Stream := TFileStream.Create(FileName, fmCreate);
    try
      if Data <> nil then
        Stream.WriteBuffer(Data[0], Length(Data));
    finally
      Stream.Free;
    end;
  end;

begin
  Result := '';

  Params.CheckEnvelopeId;

  reqEnvelopeFile.Params.ParameterByName('EnvelopeId').Value := Params.EnvelopeId;
  reqEnvelopeFile.Execute;

  __JSONLog(Params, 'EnvelopeFiles.Response', RESTResponse.Content);

  // ottenimento dello storedFileId
  EnvelopeFilesResponse := TEnvelopeFilesResponse.Create;
  try
    EnvelopeFilesResponse.AsJson := RESTResponse.Content;

    FileSignedId := EnvelopeFilesResponse.Documents[0].FileId;
    FileAuditId := EnvelopeFilesResponse.AuditTrail.FileId;
    // AuditTrail.XmlFileId
  finally
    FreeAndNil(EnvelopeFilesResponse);
  end;

  // download
  reqFile.Params.ParameterByName('fileId').Value := FileSignedId;
  reqFile.Execute;
  SaveBytesToFile(RESTResponse.RawBytes, FileNameSigned);

  reqFile.Params.ParameterByName('fileId').Value := FileAuditId;
  reqFile.Execute;
  SaveBytesToFile(RESTResponse.RawBytes, FileNameAudit);
end;

function TeSignAnyWhereEngine.Find: string;
var
  FindRequest: TFindRequest;
begin
  Result := '';

  // https://confluence.namirial.com/display/eSign/Tutorial%3A+Hello+World#Tutorial:HelloWorld-Opentheenvelope

  FindRequest := TFindRequest.Create;
  try
    // "Message": "'$.status': Must specify valid information for parsing in the string.;
    // '$.StartDate': The field StartDate must be a string with a minimum length of 20 and a maximum length of 30.;
    // '$.EndDate': The field EndDate must be a string with a minimum length of 20 and a maximum length of 30.;
    // '$.EnvelopeBulkParentId': The field EnvelopeBulkParentId must be a string with a minimum length of 36 and a maximum length of 36.",


    // FindRequest.StartDate: "2024-06-29T09:13:51.438Z",
    // FindRequest.EndDate: "2024-06-29T09:13:51.438Z",
    // FindRequest.SearchText: "string",
    // FindRequest.Status": "Canceled",
    // FindRequest.InStatusSinceDays": 0,
    // FindRequest.SenderEmail": "string",
    // FindRequest.CompletedByRecipientWithEmail": "string",
    // FindRequest.RecipientEmail": "string",
    // FindRequest.WaitingForRecipientWithEmail": "string",
    // FindRequest.EnvelopeBulkParentId": "stringstringstringstringstringstr

    reqFind.AddBody(FindRequest);
    reqFind.Execute;
  finally
    FreeAndNil(FindRequest);
  end;

  Result := RESTResponse.Content;
end;

procedure TeSignAnyWhereEngine.SetBaseUrl(const Value: string);
begin
  FBaseUrl := Value;
  restClient.BaseUrl := BaseUrl;
end;

procedure TeSignAnyWhereEngine.SetAuthToken(const Value: string);
begin
  FAuthToken := Value;
  OAuth2Authenticator.AccessToken := AuthToken;
end;

end.
