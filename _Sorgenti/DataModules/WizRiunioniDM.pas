unit WizRiunioniDM;

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  dbMaster;

type
  TWizRiunioni = class(TBaseDataModule)
  private

  public
    procedure Init;
    function ConfermaAnnulla: boolean;
    function ConfermaChiusura: boolean;
    function GetRiepilogo: string;
  end;

var
  WizRiunioni: TWizRiunioni;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TWizRiunioni }

procedure TWizRiunioni.Init;
begin

end;

function TWizRiunioni.ConfermaAnnulla: boolean;
begin
  result := true;
end;

function TWizRiunioni.ConfermaChiusura: boolean;
begin
  result := true;
end;

function TWizRiunioni.GetRiepilogo: string;
begin
  result := '';
end;

end.
