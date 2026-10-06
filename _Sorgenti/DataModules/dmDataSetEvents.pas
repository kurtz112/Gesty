unit dmDataSetEvents;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  Data.DB;

type
  TDataSetEvents = class(TBaseDataModule)
  private
    DatasetEvents: TDictionary<string, TDataSetNotifyEvent>;
    procedure RegisterDataSetEvent(const EventName: string; Event: TDataSetNotifyEvent);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure AssignDataSetEvent(DataSet: TzFbDataSet; DataSetEventKind: TDataSetEventKind; const EventName: string);
  public
  end;

var
  DatasetEvents: TDataSetEvents;

implementation

uses
  Vcl.Dialogs,
  zCodiceFiscale,
  Gesty_StoredProcs,
  SmartInspect.Vcl,
  SmartInspect.Vcl.SiAuto;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TDataSetEvents.Create(aOwner: TComponent);
begin
  inherited;
  DatasetEvents := TDictionary<string, TDataSetNotifyEvent>.Create;
end;

destructor TDataSetEvents.Destroy;
begin
  FreeAndNil(DatasetEvents);
  inherited;
end;

procedure TDataSetEvents.RegisterDataSetEvent(const EventName: string; Event: TDataSetNotifyEvent);
begin
  DatasetEvents.Add(EventName, Event);
end;

procedure TDataSetEvents.AssignDataSetEvent(DataSet: TzFbDataSet; DataSetEventKind: TDataSetEventKind; const EventName: string);
begin
  siMain.LogString('AssignDataSetEvent', DataSetEventKind.ToString);
  siMain.LogString('AssignDataSetEvent', EventName);

end;

end.

