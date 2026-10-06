unit GestyTools.Config.Editor;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  dxLayoutContainer,
  dxLayoutControlAdapters,
  cxStyles,
  cxFilter,
  dxScrollbarAnnotations,
  cxEdit,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  cxInplaceContainer,
  cxVGrid,
  cxOI,
  cxClasses,
  dxLayoutControl, dxLayoutLookAndFeels;

type
  TFormConfig = class(TForm)
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutControl: TdxLayoutControl;
    cxRTTIInspector: TcxRTTIInspector;
    dxLayoutItem1: TdxLayoutItem;
    btnOk: TcxButton;
    dxLayoutItem2: TdxLayoutItem;
    btnCancel: TcxButton;
    dxLayoutItem3: TdxLayoutItem;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutLookAndFeelList: TdxLayoutLookAndFeelList;
    dxLayoutSkinLookAndFeel: TdxLayoutSkinLookAndFeel;
  private

  public
    function Edit: boolean;
  end;

function EditConfig: boolean;

implementation

uses
  GestyTools.Config;

{$R *.dfm}

function EditConfig: boolean;
var
  FormConfig: TFormConfig;
begin
  Result := false;

  Application.CreateForm(TFormConfig, FormConfig);
  try
    Result := FormConfig.Edit;
  finally
    FreeAndNil(FormConfig);
  end;
end;

{ TFormConfig }

function TFormConfig.Edit: boolean;
begin
  Config.Load;

  cxRTTIInspector.InspectedObject := Config;

  Result := ShowModal = mrOk;

  if Result then
  begin
    cxRTTIInspector.HideEdit;
    Config.Save;
  end;
end;

end.

zdx

