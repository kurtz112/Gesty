unit frmCartellaProgetto;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  cxControls,
  StdCtrls,
  Buttons,
  Menus,
  ExtCtrls,
  ToolWin,
  ComCtrls,
  ImgList,
  StdActns,
  ActnList,
  dxCore,
  BaseFrm,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  cxGraphics,
  dxCoreClasses,
  dxHashUtils,
  dxSpreadSheetCore,
  dxSpreadSheetCoreHistory,
  dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules,
  dxSpreadSheetClasses,
  dxSpreadSheetContainers,
  dxSpreadSheetFormulas,
  dxSpreadSheetHyperlinks,
  dxSpreadSheetFunctions,
  dxSpreadSheetGraphics,
  dxSpreadSheetPrinting,
  dxSpreadSheetTypes,
  dxSpreadSheetUtils,
  dxBarBuiltInMenu,
  dxSpreadSheet,
  System.ImageList,
  System.Actions,
  cxFontNameComboBox,
  cxDropDownEdit,
  cxColorComboBox,
  dxPrinting,
  dxSpreadSheetActions,
  dxSpreadSheetConditionalFormattingRulesActions,
  cxBarEditItem,
  dxActions,
  dxRibbonSkins,
  dxRibbonCustomizationForm,
  dxRibbon,
  dxSpreadSheetFormattedTextUtils,
  cxImageList,
  Base_DataModule,
  dxSpreadSheetCoreStyles,
  dxSpreadSheetCoreStrs,
  dxSpreadSheetStyles, dxSpreadSheetCoreFormulas;

type
  TStyleValue = (svAlign, svFontName, svSize, svBold, svItalic, svUnderline, svStrikeOut);
  TStyleValueSet = set of TStyleValue;

  TFormCartellaProgetto = class(TBaseForm)
    dxSpreadSheet: TdxSpreadSheet;
    ActionList1: TActionList;
    cxImageList1: TcxImageList;
    cxImageList2: TcxImageList;
    dxSpreadSheetNewDocument: TdxSpreadSheetNewDocument;
    dxBarCommon: TdxBar;
    dxBarButtonNew: TdxBarButton;
    dxSpreadSheetOpenDocument: TdxSpreadSheetOpenDocument;
    dxBarButtonOpen: TdxBarButton;
    dxSpreadSheetSaveDocumentAs: TdxSpreadSheetSaveDocumentAs;
    dxBarButtonSaveAs: TdxBarButton;
    dxSpreadSheetPasteSelection: TdxSpreadSheetPasteSelection;
    dxBarClipboard: TdxBar;
    dxBarButtonPaste: TdxBarButton;
    dxSpreadSheetCutSelection: TdxSpreadSheetCutSelection;
    dxBarButtonCut: TdxBarButton;
    dxSpreadSheetCopySelection: TdxSpreadSheetCopySelection;
    dxBarButtonCopy: TdxBarButton;
    dxSpreadSheetChangeFontName: TdxSpreadSheetChangeFontName;
    dxBarFont: TdxBar;
    cxBarEditItemFontName: TcxBarEditItem;
    dxSpreadSheetChangeFontSize: TdxSpreadSheetChangeFontSize;
    cxBarEditItemFontSize: TcxBarEditItem;
    dxSpreadSheetIncreaseFontSize: TdxSpreadSheetIncreaseFontSize;
    dxBarButtonIncreaseFontSize: TdxBarButton;
    dxSpreadSheetDecreaseFontSize: TdxSpreadSheetDecreaseFontSize;
    dxBarButtonDecreaseFontSize: TdxBarButton;
    dxSpreadSheetToggleFontBold: TdxSpreadSheetToggleFontBold;
    dxBarButtonBold: TdxBarButton;
    dxSpreadSheetToggleFontItalic: TdxSpreadSheetToggleFontItalic;
    dxBarButtonItalic: TdxBarButton;
    dxSpreadSheetToggleFontUnderline: TdxSpreadSheetToggleFontUnderline;
    dxBarButtonUnderline: TdxBarButton;
    dxSpreadSheetToggleFontStrikeout: TdxSpreadSheetToggleFontStrikeout;
    dxBarButtonStrikeout: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxSpreadSheetBordersBottom: TdxSpreadSheetBordersBottom;
    dxBarButtonBottomBorder: TdxBarButton;
    dxSpreadSheetBordersTop: TdxSpreadSheetBordersTop;
    dxBarButtonTopBorder: TdxBarButton;
    dxSpreadSheetBordersLeft: TdxSpreadSheetBordersLeft;
    dxBarButtonLeftBorder: TdxBarButton;
    dxSpreadSheetBordersRight: TdxSpreadSheetBordersRight;
    dxBarButtonRightBorder: TdxBarButton;
    dxSpreadSheetBordersNone: TdxSpreadSheetBordersNone;
    dxBarButtonNoBorder: TdxBarButton;
    dxSpreadSheetBordersAll: TdxSpreadSheetBordersAll;
    dxBarButtonAllBorders: TdxBarButton;
    dxSpreadSheetBordersOutside: TdxSpreadSheetBordersOutside;
    dxBarButtonOutsideBorders: TdxBarButton;
    dxSpreadSheetBordersOutsideThick: TdxSpreadSheetBordersOutsideThick;
    dxBarButtonThickBoxBorder: TdxBarButton;
    dxSpreadSheetBordersBottomDouble: TdxSpreadSheetBordersBottomDouble;
    dxBarButtonBottomDoubleBorder: TdxBarButton;
    dxSpreadSheetBordersBottomThick: TdxSpreadSheetBordersBottomThick;
    dxBarButtonThickBottomBorder: TdxBarButton;
    dxSpreadSheetBordersTopAndBottom: TdxSpreadSheetBordersTopAndBottom;
    dxBarButtonTopandBottomBorder: TdxBarButton;
    dxSpreadSheetBordersTopAndBottomThick: TdxSpreadSheetBordersTopAndBottomThick;
    dxBarButtonTopandThickBottomBorder: TdxBarButton;
    dxSpreadSheetBordersTopAndBottomDouble: TdxSpreadSheetBordersTopAndBottomDouble;
    dxBarButtonTopandDoubleBottomBorder: TdxBarButton;
    dxSpreadSheetBordersMore: TdxSpreadSheetBordersMore;
    dxBarButtonMore: TdxBarButton;
    dxSpreadSheetChangeFillColor: TdxSpreadSheetChangeFillColor;
    cxBarEditItemFillColor: TcxBarEditItem;
    dxSpreadSheetChangeFontColor: TdxSpreadSheetChangeFontColor;
    cxBarEditItemFontColor: TcxBarEditItem;
    dxSpreadSheetAlignVerticalTop: TdxSpreadSheetAlignVerticalTop;
    dxBarAlignment: TdxBar;
    dxBarButtonTopAlign: TdxBarButton;
    dxSpreadSheetAlignVerticalCenter: TdxSpreadSheetAlignVerticalCenter;
    dxBarButtonMiddleAlign: TdxBarButton;
    dxSpreadSheetAlignVerticalBottom: TdxSpreadSheetAlignVerticalBottom;
    dxBarButtonBottomAlign: TdxBarButton;
    dxSpreadSheetAlignHorizontalLeft: TdxSpreadSheetAlignHorizontalLeft;
    dxBarButtonAlignTextLeft: TdxBarButton;
    dxSpreadSheetAlignHorizontalCenter: TdxSpreadSheetAlignHorizontalCenter;
    dxBarButtonAlignTextCenter: TdxBarButton;
    dxSpreadSheetAlignHorizontalRight: TdxSpreadSheetAlignHorizontalRight;
    dxBarButtonAlignTextRight: TdxBarButton;
    dxSpreadSheetTextIndentDecrease: TdxSpreadSheetTextIndentDecrease;
    dxBarButtonDecreaseIndent: TdxBarButton;
    dxSpreadSheetTextIndentIncrease: TdxSpreadSheetTextIndentIncrease;
    dxBarButtonIncreaseIndent: TdxBarButton;
    dxSpreadSheetTextWrap: TdxSpreadSheetTextWrap;
    dxBarButtonWrapText: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    dxSpreadSheetMergeCellsAndCenter: TdxSpreadSheetMergeCellsAndCenter;
    dxBarButtonMergeandCenter: TdxBarButton;
    dxSpreadSheetMergeCellsAcross: TdxSpreadSheetMergeCellsAcross;
    dxBarButtonMergeAcross: TdxBarButton;
    dxSpreadSheetMergeCells: TdxSpreadSheetMergeCells;
    dxBarButtonMergeCells: TdxBarButton;
    dxSpreadSheetUnmergeCells: TdxSpreadSheetUnmergeCells;
    dxBarButtonUnmergeCells: TdxBarButton;
    dxBarCells: TdxBar;
    dxBarSubItem3: TdxBarSubItem;
    dxSpreadSheetInsertRows: TdxSpreadSheetInsertRows;
    dxBarButtonInsertSheetRows: TdxBarButton;
    dxSpreadSheetInsertColumns: TdxSpreadSheetInsertColumns;
    dxBarButtonInsertSheetColumns: TdxBarButton;
    dxSpreadSheetInsertSheet: TdxSpreadSheetInsertSheet;
    dxBarButtonInsertSheet: TdxBarButton;
    dxBarSubItem4: TdxBarSubItem;
    dxSpreadSheetDeleteRows: TdxSpreadSheetDeleteRows;
    dxBarButtonDeleteSheetRows: TdxBarButton;
    dxSpreadSheetDeleteColumns: TdxSpreadSheetDeleteColumns;
    dxBarButtonDeleteSheetColumns: TdxBarButton;
    dxSpreadSheetDeleteSheet: TdxSpreadSheetDeleteSheet;
    dxBarButtonDeleteSheet: TdxBarButton;
    dxBarSubItem5: TdxBarSubItem;
    dxSpreadSheetAutoFitRowHeight: TdxSpreadSheetAutoFitRowHeight;
    dxBarButtonAutoFitRowHeight: TdxBarButton;
    dxSpreadSheetAutoFitColumnWidth: TdxSpreadSheetAutoFitColumnWidth;
    dxBarButtonAutoFitColumnWidth: TdxBarButton;
    dxBarSubItem6: TdxBarSubItem;
    dxSpreadSheetHideRows: TdxSpreadSheetHideRows;
    dxBarButtonHideRows: TdxBarButton;
    dxSpreadSheetHideColumns: TdxSpreadSheetHideColumns;
    dxBarButtonHideColumns: TdxBarButton;
    dxSpreadSheetHideSheet: TdxSpreadSheetHideSheet;
    dxBarButtonHideSheet: TdxBarButton;
    dxSpreadSheetUnhideRows: TdxSpreadSheetUnhideRows;
    dxBarButtonUnhideRows: TdxBarButton;
    dxSpreadSheetUnhideColumns: TdxSpreadSheetUnhideColumns;
    dxBarButtonUnhideColumns: TdxBarButton;
    dxSpreadSheetUnhideSheet: TdxSpreadSheetUnhideSheet;
    dxBarButtonUnhideSheet: TdxBarButton;
    dxBarEditing: TdxBar;
    dxBarSubItem7: TdxBarSubItem;
    dxSpreadSheetClearAll: TdxSpreadSheetClearAll;
    dxBarButtonClearAll: TdxBarButton;
    dxSpreadSheetClearFormats: TdxSpreadSheetClearFormats;
    dxBarButtonClearFormats: TdxBarButton;
    dxSpreadSheetClearContents: TdxSpreadSheetClearContents;
    dxBarButtonClearContents: TdxBarButton;
    dxSpreadSheetUndo: TdxSpreadSheetUndo;
    dxBarButtonUndo: TdxBarButton;
    dxSpreadSheetRedo: TdxSpreadSheetRedo;
    dxBarButtonRedo: TdxBarButton;
    dxSpreadSheetFindAndReplace: TdxSpreadSheetFindAndReplace;
    dxBarButtonFindReplace: TdxBarButton;
    dxSpreadSheetInsertPicture: TdxSpreadSheetInsertPicture;
    dxBarIllustrations: TdxBar;
    dxBarButtonPicture: TdxBarButton;
    dxSpreadSheetShowHyperlinkEditor: TdxSpreadSheetShowHyperlinkEditor;
    dxBarLinks: TdxBar;
    dxBarButtonHyperlink: TdxBarButton;
    dxSpreadSheetSortAscending: TdxSpreadSheetSortAscending;
    dxBarSortFilter: TdxBar;
    dxBarButtonSortAtoZ: TdxBarButton;
    dxSpreadSheetSortDescending: TdxSpreadSheetSortDescending;
    dxBarButtonSortZtoA: TdxBarButton;
    dxBarGrouping: TdxBar;
    dxBarSubItem8: TdxBarSubItem;
    dxSpreadSheetGroupColumns: TdxSpreadSheetGroupColumns;
    dxBarButtonGroupColumns: TdxBarButton;
    dxSpreadSheetGroupRows: TdxSpreadSheetGroupRows;
    dxBarButtonGroupRows: TdxBarButton;
    dxBarSubItem9: TdxBarSubItem;
    dxSpreadSheetUngroupColumns: TdxSpreadSheetUngroupColumns;
    dxBarButtonUngroupColumns: TdxBarButton;
    dxSpreadSheetUngroupRows: TdxSpreadSheetUngroupRows;
    dxBarButtonUngroupRows: TdxBarButton;
    dxSpreadSheetNewComment: TdxSpreadSheetNewComment;
    dxBarComments: TdxBar;
    dxBarButtonNewComment: TdxBarButton;
    dxSpreadSheetEditComment: TdxSpreadSheetEditComment;
    dxBarButtonEditComment: TdxBarButton;
    dxSpreadSheetDeleteComments: TdxSpreadSheetDeleteComments;
    dxBarButtonDeleteComments: TdxBarButton;
    dxSpreadSheetPreviousComment: TdxSpreadSheetPreviousComment;
    dxBarButtonPreviousComment: TdxBarButton;
    dxSpreadSheetNextComment: TdxSpreadSheetNextComment;
    dxBarButtonNextComment: TdxBarButton;
    dxSpreadSheetShowHideComments: TdxSpreadSheetShowHideComments;
    dxBarButtonShowHideComments: TdxBarButton;
    dxSpreadSheetProtectSheet: TdxSpreadSheetProtectSheet;
    dxBarChanges: TdxBar;
    dxBarButtonProtectSheet: TdxBarButton;
    dxSpreadSheetProtectWorkbook: TdxSpreadSheetProtectWorkbook;
    dxBarButtonProtectWorkbook: TdxBarButton;
    dxSpreadSheetZoomOut: TdxSpreadSheetZoomOut;
    dxBarZoom: TdxBar;
    dxBarButtonZoomOut: TdxBarButton;
    dxSpreadSheetZoomIn: TdxSpreadSheetZoomIn;
    dxBarButtonZoomIn: TdxBarButton;
    dxSpreadSheetZoomDefault: TdxSpreadSheetZoomDefault;
    dxBarButton100: TdxBarButton;
    dxBarFreezePanes: TdxBar;
    dxBarSubItem10: TdxBarSubItem;
    dxSpreadSheetFreezePanes: TdxSpreadSheetFreezePanes;
    dxBarButtonFreezePanes: TdxBarButton;
    dxSpreadSheetUnfreezePanes: TdxSpreadSheetUnfreezePanes;
    dxBarButtonUnfreezePanes: TdxBarButton;
    dxSpreadSheetFreezeTopRow: TdxSpreadSheetFreezeTopRow;
    dxBarButtonFreezeTopRow: TdxBarButton;
    dxSpreadSheetFreezeFirstColumn: TdxSpreadSheetFreezeFirstColumn;
    dxBarButtonFreezeFirstColumn: TdxBarButton;
    dxSpreadSheetShowConditionalFormattingRulesManager: TdxSpreadSheetShowConditionalFormattingRulesManager;
    dxBarConditionalFormatting: TdxBar;
    dxBarButtonManageRules: TdxBarButton;
    dxSpreadSheetShowPrintForm: TdxSpreadSheetShowPrintForm;
    dxBarPrint: TdxBar;
    dxBarButtonPrint: TdxBarButton;
    dxSpreadSheetShowPrintPreviewForm: TdxSpreadSheetShowPrintPreviewForm;
    dxBarButtonPrintPreview: TdxBarButton;
    dxSpreadSheetShowPageSetupForm: TdxSpreadSheetShowPageSetupForm;
    dxBarButtonPageSetup: TdxBarButton;
    procedure FormCreate(Sender: TObject);
    procedure actOpenSpreadSheetExecute(Sender: TObject);
  private
    FSummaryItemHeight: Integer;
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OpenSpreadSheet;
  public
  end;

var
  FormCartellaProgetto: TFormCartellaProgetto;

implementation

{$R *.dfm}

uses
  // FeatureChild,
  // FeatureModify,
  dmCartellaProgetto,
  zBaseLib;

procedure TFormCartellaProgetto.FormCreate(Sender: TObject);

var
  FileName: String;
begin
  inherited;
  ReportGroup := 'CartellaProgetto';
  Caption := 'CartellaProgetto';

  FileName := PAth + 'Cartella lavoro progetto.xls';
  if FileExists(FileName) then
    dxSpreadSheet.LoadFromFile(FileName);

  dxBarManager.ImageOptions.Images := cxImageList1;
  dxBarManager.ImageOptions.LargeImages := cxImageList2;
end;

procedure TFormCartellaProgetto.OpenSpreadSheet;
begin
  // if OpenDialog.Execute then
  // dxSpreadSheet.LoadFromFile(OpenDialog.FileName);
end;

procedure TFormCartellaProgetto.actOpenSpreadSheetExecute(Sender: TObject);
begin
  OpenSpreadSheet;
end;

procedure TFormCartellaProgetto.CreateDataModule;
begin
  inherited;
  CreateDM(TCartellaProgetto, CartellaProgetto);
end;

procedure TFormCartellaProgetto.DestroyDataModule;
begin
  inherited;
  FreeAndNil(CartellaProgetto);
end;

end.

  zsystem
