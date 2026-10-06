unit DevExtreme.CustomControl;

interface

uses
  System.SysUtils,
  System.Classes,
  Types,
  WEBLib.Controls,
  JS,
  Web,
  libjquery,
  DevExtreme.Types;

type
  TGetIdEvent = procedure(Sender: TObject; out dm, id: string) of object;
  TGetDataSetIdEvent = procedure(Sender: TObject; out dm, dataset: string) of object;

  TjdxCustomControl = class(TjQueryCustomControl)
  private
    FDM: string;
    FId: string;
    FOnGetIdEvent: TGetIdEvent;
    FOnGetDataSetIdEvent: TGetDataSetIdEvent;
  protected
    procedure GetComponentId(out dm, name, className_: string); virtual;
    procedure GetDataSetId(out dm, dataset: string); virtual;
    procedure AfterEditSql; virtual;
  protected
    FIsLoaded: boolean;
    procedure InitJQuery; override;
  public
    procedure SetEvent(EventName: string; eventHandler: TdxEventHandler);
    procedure SetOption(name: string; optionValue: JSValue);
  public
    constructor Create(aOwner: TComponent); override;
    procedure CreateInitialize; override;
  public
    property IsLoaded: boolean read FIsLoaded;
  public
    procedure DownloadOptions;
    procedure UploadOptions;
    procedure EditOptions;
    [async]
    procedure EditSQL;

  published
    property _id: string read FId write FId;
    property _dm: string read FDM write FDM;
  published
    property OnGetIdEvent: TGetIdEvent read FOnGetIdEvent write FOnGetIdEvent;
    property OnGetDataSetIdEvent: TGetDataSetIdEvent read FOnGetDataSetIdEvent write FOnGetDataSetIdEvent;
  end;

implementation

uses
  DevExtreme.Base;

constructor TjdxCustomControl.Create(aOwner: TComponent);
begin
  inherited;
  FDM := '';
  FId := '';
  FOnGetIdEvent := nil;
  FOnGetDataSetIdEvent := nil;
end;

{ TjdxCustomControl }

procedure TjdxCustomControl.CreateInitialize;
begin
  inherited;
  FIsLoaded := False;
end;

procedure TjdxCustomControl.InitJQuery;
begin
  inherited;
end;

procedure TjdxCustomControl.SetEvent(EventName: string; eventHandler: TdxEventHandler);
begin

  if IsLoaded then
  begin
    if assigned(eventHandler) then
    begin
      asm
        this.instance().on(EventName, eventHandler);
      end;
    end
    else
    begin
      asm
        this.instance().off(EventName);
      end;
    end;
  end;
end;

procedure TjdxCustomControl.SetOption(name: string; optionValue: JSValue);
begin

  if IsLoaded then
  begin
    asm
      this.instance().option(name, optionValue);
    end;
  end;
end;

procedure TjdxCustomControl.DownloadOptions;
var
  dm, name, className_: string;
  o: TJSObject;
begin
  GetComponentId(dm, name, className_);

  Base.DownloadOptions(dm, name, className_)._then(
    function(value: JSValue): JSValue
    begin
      asm
        this.instance().option(value);
      end;
    end);
end;

procedure TjdxCustomControl.UploadOptions;
var
  dm, name, className_: string;
  o: TJSObject;
begin
  GetComponentId(dm, name, className_);

  asm
    o = this.instance().option();
  end;

  Base.UploadOptions(dm, name, className_, o);
end;

procedure TjdxCustomControl.EditOptions;
var
  options: TJSObject;
  self_: JSValue;
begin

  asm
    self_ = this.instance();
    options = self_.option();
  end;

  Base.EditOptions(options,
    function(options: TJSObject): JSValue
    begin
      asm
        self_.option(options);
      end;

      UploadOptions;
    end, nil);
end;

procedure TjdxCustomControl.EditSQL;
var
  dm, dataset: string;
begin
  GetDataSetId(dm, dataset);

  Base.EditSQL(dm, dataset,
    procedure
    begin
      AfterEditSql;
    end);
end;

procedure TjdxCustomControl.GetComponentId(out dm, name, className_: string);
begin

  if assigned(FOnGetIdEvent) then
    OnGetIdEvent(self, dm, name)
  else
  begin

    if not FDM.IsEmpty then
      dm := FDM
    else
      dm := '';

    if FId.IsEmpty then
      name := self.name
    else
      name := FId;
  end;

  /// ////////////////////////

  className_ := ClassName;

  if className_.StartsWith('Tjdx') then
    className_ := className_.Replace('Tjdx', '');
end;

procedure TjdxCustomControl.GetDataSetId(out dm, dataset: string);
var
  dummy: string;
begin

  if assigned(FOnGetDataSetIdEvent) then
    FOnGetDataSetIdEvent(self, dm, dataset)
  else
    // per default restituisce id/dm del componente
    GetComponentId(dm, dataset, dummy);
end;

procedure TjdxCustomControl.AfterEditSql;
begin

end;

end.
