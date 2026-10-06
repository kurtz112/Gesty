unit zz.web.actions;

interface

uses
  System.SysUtils,
  System.Classes,
  JS,
  WEBLib.Controls;

type
  TExecuteEvent = procedure(e: TJSObject) of object;

  TWebAction = class(TCollectionItem)
  private
    FCaption: string;
    FIcon: string;
    FName: String;
    FOnExecute: TExecuteEvent;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Name: String read FName write FName;
    property Caption: string read FCaption write FCaption;
    property Icon: string read FIcon write FIcon;
    property OnExecute: TExecuteEvent read FOnExecute write FOnExecute;
  end;

  TWebActions = class(TOwnedCollection)
  type
    TCollectionEnumerator = class
    private
      index: Integer;
      Collection: TWebActions;
    public
      constructor Create(ACollection: TWebActions);
      function GetCurrent: TWebAction;
      function MoveNext: Boolean;
      property Current: TWebAction read GetCurrent;
    end;
  private
    function GetItem(index: Integer): TWebAction;
    procedure SetItem(index: Integer; const Value: TWebAction);
  public
    function GetEnumerator: TCollectionEnumerator;
    function Add: TWebAction;
    function Insert(index: Integer): TWebAction;
    property Items[index: Integer]: TWebAction read GetItem write SetItem; default;
  end;

  TWebActionList = class(TComponent)
  private
    FActions: TWebActions;
    procedure SetActions(const Value: TWebActions);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property actions: TWebActions read FActions write SetActions;
  end;

implementation

constructor TWebAction.Create(Collection: TCollection);
begin
  inherited;
  FName := '';
  FCaption := '';
  FIcon := '';
  FOnExecute := nil;
end;

procedure TWebAction.Assign(Source: TPersistent);
var
  item: TWebAction;
begin

  if Source is TWebAction then
  begin
    item := TWebAction(Source);
    FName := item.Name;
    FCaption := item.Caption;
    FIcon := item.Icon;
    FOnExecute := item.OnExecute;
  end
  else
    inherited;
end;

{ TWebActions }

function TWebActions.GetEnumerator: TCollectionEnumerator;
begin
  Result := TCollectionEnumerator.Create(Self);
end;

function TWebActions.Add: TWebAction;
begin
  Result := TWebAction(inherited Add);
end;

function TWebActions.Insert(index: Integer): TWebAction;
begin
  Result := TWebAction(inherited Insert(index));
end;

function TWebActions.GetItem(index: Integer): TWebAction;
begin
  Result := TWebAction(inherited Items[index]);
end;

procedure TWebActions.SetItem(index: Integer; const Value: TWebAction);
begin
  Items[index].Assign(Value);
end;

{ TWebActions.TCollectionEnumerator }

constructor TWebActions.TCollectionEnumerator.Create(ACollection: TWebActions);
begin
  inherited Create;
  index := -1;
  Collection := ACollection;
end;

function TWebActions.TCollectionEnumerator.GetCurrent: TWebAction;
begin
  Result := Collection.Items[index];
end;

function TWebActions.TCollectionEnumerator.MoveNext: Boolean;
begin
  Result := index < Collection.Count - 1;

  if Result then
    Inc(index);
end;

{ TWebActionList }

constructor TWebActionList.Create(aOwner: TComponent);
begin
  inherited;
  FActions := TWebActions.Create(Self, TWebAction);
end;

destructor TWebActionList.Destroy;
begin
  inherited;
  FreeAndNil(FActions);
end;

procedure TWebActionList.SetActions(const Value: TWebActions);
begin
  FActions.Assign(Value);
end;

end.

  function dxAction
(Caption: string; Icon: string; ClickEventHandler: THTMLClickEventHandler): TJSObject; begin Result := TJSObject.new; Result['text'] := Caption; Result['icon'] := Icon;
Result['onClick'] := ClickEventHandler; end;

System.actions taction
