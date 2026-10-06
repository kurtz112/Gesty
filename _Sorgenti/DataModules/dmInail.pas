unit dmInail;

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  dbMaster;

type
  TInail = class(TBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;

var
  Inail: TInail;

implementation

uses
  dxSpreadSheetReportDesigner;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TInail.DataModuleCreate(Sender: TObject);
begin
  inherited;

//  ReportsManager.SpreadSheetProc := procedure(dxSpreadSheetReportDesigner: TdxSpreadSheetReportDesigner)
//    var
//      group: TdxSpreadSheetReportDataGroup;
//    begin
//      dxSpreadSheetReportDesigner.DataBinding.DataGroups.Clear;
//      dxSpreadSheetReportDesigner.DataBinding.DataGroups.Add;
//      dxSpreadSheetReportDesigner.DataBinding.DataGroups[0].FieldName := 'Denominazione Progetto';
//      dxSpreadSheetReportDesigner.DataBinding.DataGroups[0].SectionID := 1;
//    end;
end;

end.
