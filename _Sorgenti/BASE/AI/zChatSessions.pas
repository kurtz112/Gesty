unit zChatSessions;

// Storicizzazione delle sessioni di chat (stile Claude/Gemini).
// Ogni sessione e' un file JSON in una cartella locale:
//   { id, title, updatedAt, messages: [ { authorId, authorName, text,
//     timestamp, attachments: [percorsi] } ] }
//
// Il titolo viene derivato dal primo messaggio dell'utente (come fanno
// Claude e Gemini); le sessioni senza messaggi utente non vengono salvate.
//
// Nota sul richiamo di una sessione: i motori AI sono STATELESS, quindi
// per proseguire una conversazione richiamata l'intero storico va
// ritrasmesso al motore a ogni richiesta (vedi TAI.RequestResponse).

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.IOUtils,
  System.DateUtils, System.Generics.Collections,
  zChatTypes, zChatControl;

type
  TzChatSessionInfo = class
  public
    Id: string;
    Title: string;
    UpdatedAt: TDateTime;
  end;

  TzChatSessionStore = class(TComponent)
  private
    FStorageFolder: string;
    function GetStorageFolder: string;
    function SessionFileName(const SessionId: string): string;
    function BuildTitle(Chat: TzChat): string;
    function HasUserMessages(Chat: TzChat): Boolean;
    function ReadSessionInfo(const FileName: string): TzChatSessionInfo;
  public
    function NewSessionId: string;
    { Riempie liste parallele (piu' recente per prima): Ids con gli
      identificativi, Titles con i titoli e, se fornita, Dates con le
      date formattate per la visualizzazione. }
    procedure ListSessions(Ids, Titles: TStrings; Dates: TStrings = nil);
    { Salva la conversazione corrente. False se non c'e' ancora alcun
      messaggio dell'utente (niente da storicizzare). }
    function SaveFromChat(Chat: TzChat; const SessionId: string): Boolean;
    { Ricostruisce nella chat la sessione salvata (utenti, messaggi,
      timestamp e allegati). False se il file non esiste o non e' valido. }
    function LoadIntoChat(Chat: TzChat; const SessionId: string): Boolean;
    procedure DeleteSession(const SessionId: string);
    { Cartella dei file sessione. Vuota = <AppData>\<NomeExe>\ChatSessions. }
    property StorageFolder: string read GetStorageFolder write FStorageFolder;
  end;

implementation

const
  MAX_TITLE_LENGTH = 40;

{ TzChatSessionStore }

function TzChatSessionStore.GetStorageFolder: string;
begin
  if FStorageFolder <> '' then
    Exit(FStorageFolder);
  Result := TPath.Combine(TPath.Combine(TPath.GetHomePath,
    TPath.GetFileNameWithoutExtension(ParamStr(0))), 'ChatSessions');
end;

function TzChatSessionStore.SessionFileName(const SessionId: string): string;
begin
  Result := TPath.Combine(StorageFolder, 'chat-' + SessionId + '.json');
end;

function TzChatSessionStore.NewSessionId: string;
var
  Guid: TGUID;
begin
  CreateGUID(Guid);
  // GUID senza parentesi graffe: adatto a comporre un nome file
  Result := Copy(GUIDToString(Guid), 2, 36);
end;

function TzChatSessionStore.HasUserMessages(Chat: TzChat): Boolean;
var
  Index: Integer;
begin
  for Index := 0 to Chat.Messages.Count - 1 do
    if Chat.Messages[Index].Author = Chat.User then
      Exit(True);
  Result := False;
end;

function TzChatSessionStore.BuildTitle(Chat: TzChat): string;
var
  Index: Integer;
begin
  // Come Claude/Gemini: il titolo e' il primo messaggio dell'utente
  for Index := 0 to Chat.Messages.Count - 1 do
    if Chat.Messages[Index].Author = Chat.User then
    begin
      Result := Trim(Chat.Messages[Index].Text);
      if Length(Result) > MAX_TITLE_LENGTH then
        Result := Copy(Result, 1, MAX_TITLE_LENGTH) + '...';
      if Result <> '' then
        Exit;
    end;
  Result := 'Chat del ' + FormatDateTime('dd/mm/yyyy hh:nn', Now);
end;

function TzChatSessionStore.ReadSessionInfo(
  const FileName: string): TzChatSessionInfo;
var
  Root: TJSONObject;
begin
  Result := nil;
  Root := TJSONObject.ParseJSONValue(
    TFile.ReadAllText(FileName, TEncoding.UTF8)) as TJSONObject;
  if Root = nil then
    Exit;
  try
    Result := TzChatSessionInfo.Create;
    Result.Id := Root.GetValue<string>('id', '');
    Result.Title := Root.GetValue<string>('title', '');
    try
      Result.UpdatedAt := ISO8601ToDate(
        Root.GetValue<string>('updatedAt', ''), False);
    except
      Result.UpdatedAt := 0;
    end;
  finally
    Root.Free;
  end;
end;

procedure TzChatSessionStore.ListSessions(Ids, Titles: TStrings;
  Dates: TStrings);
var
  Sessions: TObjectList<TzChatSessionInfo>;
  Info: TzChatSessionInfo;
  FileName: string;
  Index, InsertAt: Integer;
begin
  Ids.BeginUpdate;
  Titles.BeginUpdate;
  try
    Ids.Clear;
    Titles.Clear;
    if Dates <> nil then
      Dates.Clear;
    if not TDirectory.Exists(StorageFolder) then
      Exit;

    Sessions := TObjectList<TzChatSessionInfo>.Create(True);
    try
      // Inserimento ordinato per data decrescente (la piu' recente in cima)
      for FileName in TDirectory.GetFiles(StorageFolder, 'chat-*.json') do
      begin
        Info := ReadSessionInfo(FileName);
        if (Info = nil) or (Info.Id = '') then
        begin
          Info.Free;
          Continue;
        end;
        InsertAt := 0;
        while (InsertAt < Sessions.Count)
          and (Sessions[InsertAt].UpdatedAt > Info.UpdatedAt) do
          Inc(InsertAt);
        Sessions.Insert(InsertAt, Info);
      end;

      for Index := 0 to Sessions.Count - 1 do
      begin
        Ids.Add(Sessions[Index].Id);
        Titles.Add(Sessions[Index].Title);
        if Dates <> nil then
          Dates.Add(FormatDateTime('dd/mm/yyyy hh:nn',
            Sessions[Index].UpdatedAt));
      end;
    finally
      Sessions.Free;
    end;
  finally
    Ids.EndUpdate;
    Titles.EndUpdate;
  end;
end;

function TzChatSessionStore.SaveFromChat(Chat: TzChat;
  const SessionId: string): Boolean;
var
  Root: TJSONObject;
  MessagesArray, AttachmentsArray: TJSONArray;
  MessageObject: TJSONObject;
  Msg: TzChatMessage;
  Index, AttIndex: Integer;
begin
  Result := False;
  if (Chat = nil) or (SessionId = '') or not HasUserMessages(Chat) then
    Exit;

  ForceDirectories(StorageFolder);
  Root := TJSONObject.Create;
  try
    Root.AddPair('id', SessionId);
    Root.AddPair('title', BuildTitle(Chat));
    Root.AddPair('updatedAt', DateToISO8601(Now, False));

    MessagesArray := TJSONArray.Create;
    Root.AddPair('messages', MessagesArray);
    for Index := 0 to Chat.Messages.Count - 1 do
    begin
      Msg := Chat.Messages[Index];
      MessageObject := TJSONObject.Create;
      if Msg.Author <> nil then
      begin
        MessageObject.AddPair('authorId', Msg.Author.Id);
        MessageObject.AddPair('authorName', Msg.Author.Name);
      end;
      MessageObject.AddPair('text', Msg.Text);
      MessageObject.AddPair('timestamp', DateToISO8601(Msg.Timestamp, False));
      if Msg.Attachments.Count > 0 then
      begin
        AttachmentsArray := TJSONArray.Create;
        for AttIndex := 0 to Msg.Attachments.Count - 1 do
          AttachmentsArray.Add(Msg.Attachments[AttIndex].FilePath);
        MessageObject.AddPair('attachments', AttachmentsArray);
      end;
      MessagesArray.AddElement(MessageObject);
    end;

    TFile.WriteAllText(SessionFileName(SessionId), Root.ToJSON,
      TEncoding.UTF8);
    Result := True;
  finally
    Root.Free;
  end;
end;

function TzChatSessionStore.LoadIntoChat(Chat: TzChat;
  const SessionId: string): Boolean;
var
  Root: TJSONObject;
  MessagesArray, AttachmentsArray: TJSONArray;
  MessageValue, AttachmentValue: TJSONValue;
  MessageObject: TJSONObject;
  Author: TzChatUser;
  NewMessage: TzChatMessage;
  AuthorId, AuthorName: string;
begin
  Result := False;
  if not FileExists(SessionFileName(SessionId)) then
    Exit;

  Root := TJSONObject.ParseJSONValue(TFile.ReadAllText(
    SessionFileName(SessionId), TEncoding.UTF8)) as TJSONObject;
  if Root = nil then
    Exit;
  try
    Chat.Clear;
    MessagesArray := Root.GetValue('messages') as TJSONArray;
    if MessagesArray <> nil then
      for MessageValue in MessagesArray do
      begin
        MessageObject := MessageValue as TJSONObject;

        { Autore: riusa l'utente esistente con lo stesso Id (cosi' i
          messaggi dell'utente corrente tornano a destra), altrimenti
          lo ricrea dal salvataggio. }
        AuthorId := MessageObject.GetValue<string>('authorId', '');
        AuthorName := MessageObject.GetValue<string>('authorName', '');
        Author := Chat.Users.FindById(AuthorId);
        if Author = nil then
          Author := Chat.AddUser(AuthorId, AuthorName);

        NewMessage := Chat.AddMessage(Author,
          MessageObject.GetValue<string>('text', ''));
        try
          NewMessage.Timestamp := ISO8601ToDate(
            MessageObject.GetValue<string>('timestamp', ''), False);
        except
          // Timestamp non valido: resta quello di creazione
        end;

        AttachmentsArray := MessageObject.GetValue('attachments') as TJSONArray;
        if AttachmentsArray <> nil then
        begin
          for AttachmentValue in AttachmentsArray do
            NewMessage.Attachments.Add(AttachmentValue.Value);
          // Gli allegati cambiano l'altezza della bolla gia' misurata
          NewMessage.InvalidateMeasure;
        end;
      end;

    Chat.Scroller.ScrollToBottom;
    Result := True;
  finally
    Root.Free;
  end;
end;

procedure TzChatSessionStore.DeleteSession(const SessionId: string);
begin
  if FileExists(SessionFileName(SessionId)) then
    TFile.Delete(SessionFileName(SessionId));
end;

end.
