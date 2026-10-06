unit DevExtreme.Actions;

interface

uses
  System.SysUtils,
  System.Classes,
  WEBLib.Controls,
  JS,
  DevExtreme.Types;

type
  // TExecuteEvent = procedure(e: TJSObject) of object;

  TdxAction = class(TCollectionItem)
  private
    FCaption: string;
    FIcon: string;
    FName: String;
    FOnExecute: TdxEventHandler;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Name: String read FName write FName;
    property Caption: string read FCaption write FCaption;
    property Icon: string read FIcon write FIcon;
    property OnExecute: TdxEventHandler read FOnExecute write FOnExecute;
  end;

  TdxActions = class(TOwnedCollection)
  type
    TCollectionEnumerator = class
    private
      index: Integer;
      Collection: TdxActions;
    public
      constructor Create(ACollection: TdxActions);
      function GetCurrent: TdxAction;
      function MoveNext: Boolean;
      property Current: TdxAction read GetCurrent;
    end;
  private
    function GetItem(index: Integer): TdxAction;
    procedure SetItem(index: Integer; const Value: TdxAction);
  public
    function GetEnumerator: TCollectionEnumerator;
    function Add: TdxAction;
    function Insert(index: Integer): TdxAction;
    property Items[index: Integer]: TdxAction read GetItem write SetItem; default;
  end;

  [ComponentPlatforms(TMSWebPlatform)]
  TdxActionList = class(TComponent)
  private
    FActions: TdxActions;
    procedure SetActions(const Value: TdxActions);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Actions: TdxActions read FActions write SetActions;
  end;

implementation

constructor TdxAction.Create(Collection: TCollection);
begin
  inherited;
  FName := '';
  FCaption := '';
  FIcon := '';
  FOnExecute := nil;
end;

procedure TdxAction.Assign(Source: TPersistent);
var
  item: TdxAction;
begin

  if Source is TdxAction then
  begin
    item := TdxAction(Source);
    FName := item.Name;
    FCaption := item.Caption;
    FIcon := item.Icon;
    FOnExecute := item.OnExecute;
  end
  else
    inherited;
end;

{ TWebActions }

function TdxActions.GetEnumerator: TCollectionEnumerator;
begin
  Result := TCollectionEnumerator.Create(Self);
end;

function TdxActions.Add: TdxAction;
begin
  Result := TdxAction(inherited Add);
end;

function TdxActions.Insert(index: Integer): TdxAction;
begin
  Result := TdxAction(inherited Insert(index));
end;

function TdxActions.GetItem(index: Integer): TdxAction;
begin
  Result := TdxAction(inherited Items[index]);
end;

procedure TdxActions.SetItem(index: Integer; const Value: TdxAction);
begin
  Items[index].Assign(Value);
end;

{ TWebActions.TCollectionEnumerator }

constructor TdxActions.TCollectionEnumerator.Create(ACollection: TdxActions);
begin
  inherited Create;
  index := -1;
  Collection := ACollection;
end;

function TdxActions.TCollectionEnumerator.GetCurrent: TdxAction;
begin
  Result := Collection.Items[index];
end;

function TdxActions.TCollectionEnumerator.MoveNext: Boolean;
begin
  Result := index < Collection.Count - 1;

  if Result then
    Inc(index);
end;

{ TWebActionList }

constructor TdxActionList.Create(aOwner: TComponent);
begin
  inherited;
  FActions := TdxActions.Create(Self, TdxAction);
end;

destructor TdxActionList.Destroy;
begin
  inherited;
  FreeAndNil(FActions);
end;

procedure TdxActionList.SetActions(const Value: TdxActions);
begin
  FActions.Assign(Value);
end;

end.

