unit eSignAnyWhere.classes.FindRequest;

interface

uses
  system.SysUtils,
  system.classes,
  system.Generics.Collections,
  REST.Json.Types,
  zz.Json.DTO;

{$M+}

type
  TFindRequest = class(TJsonDTO)
  private
    FCompletedByRecipientWithEmail: string;
    [SuppressZero]
    FEndDate: TDateTime;
    FEnvelopeBulkParentId: string;
    FInStatusSinceDays: Integer;
    FRecipientEmail: string;
    FSearchText: string;
    FSenderEmail: string;
    [SuppressZero]
    FStartDate: TDateTime;
    FStatus: string;
    FWaitingForRecipientWithEmail: string;
  published
    property CompletedByRecipientWithEmail: string read FCompletedByRecipientWithEmail write FCompletedByRecipientWithEmail;
    property EndDate: TDateTime read FEndDate write FEndDate;
    property EnvelopeBulkParentId: string read FEnvelopeBulkParentId write FEnvelopeBulkParentId;
    property InStatusSinceDays: Integer read FInStatusSinceDays write FInStatusSinceDays;
    property RecipientEmail: string read FRecipientEmail write FRecipientEmail;
    property SearchText: string read FSearchText write FSearchText;
    property SenderEmail: string read FSenderEmail write FSenderEmail;
    property StartDate: TDateTime read FStartDate write FStartDate;
    property Status: string read FStatus write FStatus;
    property WaitingForRecipientWithEmail: string read FWaitingForRecipientWithEmail write FWaitingForRecipientWithEmail;
  end;

implementation

end.
