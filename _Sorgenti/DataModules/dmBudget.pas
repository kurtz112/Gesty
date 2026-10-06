unit dmBudget;

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  Vcl.Dialogs,
   zProgressBox;

type
  TBudget = class(TBaseDataModule)
    ProgressBox: TProgressBox;
  private
  public
    procedure ElaboraCostiRicavi;
  end;

var
  Budget: TBudget;

implementation

uses
  System.UITypes, zBaseLib, Gesty_StoredProcs, zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TBudget }

procedure TBudget.ElaboraCostiRicavi;
var
  sp: TSP_COAN_ELABORA;
begin

  if not ConfirmYesNo('Si desidera elaborare i costi / ricavi ?') then
    exit;

  StartWait('Attendere...', True);
  try
    sp := getSP<TSP_COAN_ELABORA>();
    try
      sp.executeAndCommit;
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

end.


zdbpivot
