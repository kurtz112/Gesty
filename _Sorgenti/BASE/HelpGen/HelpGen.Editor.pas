unit HelpGen.Editor;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.ImageList,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.StdActns,
  Data.DB,
  dxCore,
  dxCoreClasses,
  cxGraphics,
  dxGDIPlusAPI,
  dxGDIPlusClasses,
  dxRichEdit.Types,
  dxRichEdit.Options,
  dxRichEdit.Control,
  dxRichEdit.Control.SpellChecker,
  dxRichEdit.Dialogs.EventArgs,
  dxBarBuiltInMenu,
  dxRichEdit.NativeApi,
  dxRichEdit.DOC,
  dxRichEdit.OpenXML,
  dxRichEdit.HTML,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  dxRibbonSkins,
  dxRibbonCustomizationForm,
  cxFontNameComboBox,
  cxDropDownEdit,
  dxRichEdit.Actions,
  dxActions,
  dxPrinting,
  dxBar,
  dxRibbon,
  dxGallery,
  dxRibbonGallery,
  dxRibbonColorGallery,
  cxBarEditItem,
  cxClasses,
  cxImageList,
  dxRichEdit.Platform.Win.Control,
  dxRichEdit.Control.Core,
  dxRibbonForm,
  dxStatusBar,
  dxRibbonStatusBar,
  cxContainer,
  cxEdit,
  cxTrackBar,
  dxZoomTrackBar,
  dxBarExtItems,
  dxPSGlbl,
  dxPSUtl,
  dxPSEngn,
  dxPrnPg,
  dxBkgnd,
  dxWrap,
  dxPrnDev,
  dxPSCompsProvider,
  dxPSFillPatterns,
  dxPSEdgePatterns,
  dxPSPDFExportCore,
  dxPSPDFExport,
  cxDrawTextUtils,
  dxPSPrVwStd,
  dxPSPrVwAdv,
  dxPSPrVwRibbon,
  dxPScxPageControlProducer,
  dxPSRichEditControlLnk,
  dxPScxEditorProducers,
  dxPScxExtEditorProducers,
  dxPSCore,
  dxShellDialogs,
  dxLayoutContainer,
  dxX509Certificate,
  dxPDFCore,
  dxPDFBase,
  dxPDFText,
  dxPDFRecognizedObject,
  dxPDFForm,
  dxPDFFormData,
  dxPDFDocument,
  dxPrintUtils,
  dxCustomPreview,
  dxPDFDocumentViewer,
  dxPDFViewer,
  dxLayoutControl,
  dxRichEdit.PlainText,
  dxRichEdit.DocumentServer,
  dxBarApplicationMenu,
  dxFileActions,
  cxCustomData,
  cxStyles,
  dxScrollbarAnnotations,
  cxTL,
  cxTextEdit,
  cxTLdxBarBuiltInMenu,
  cxInplaceContainer,
  dxPScxTLLnk,
  dxPScxSchedulerLnk,
  dxPSdxSpreadSheetLnk,
  dxRichEdit.DocumentModel.RichEditDocumentServer,
  dxRichEdit.DocumentModel.ParagraphFormatting,
  dxCharacters,
  cxSpinEdit,
  dxUIAClasses,
  HelpGen.Types,
  HelpGen.config,
  HelpGen.AI,
  HelpGen.Response.Classes,
  zProgressBox,
  zRestrictions,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  THelpGenEditor = class(TdxRibbonForm)
    dxRichEditControl: TdxRichEditControl;
    dxRibbon: TdxRibbon;
    dxBarManager: TdxBarManager;
    image16: TcxImageList;
    image32: TcxImageList;
    dxbStatusBarToolbar1: TdxBar;
    dxbStatusBarToolbar2: TdxBar;
    dxbStatusBarToolbar3: TdxBar;
    bsZoom: TdxBarStatic;
    bccZoom: TdxBarControlContainerItem;

    bbCursorLine: TdxBarButton;
    bbCursorColumn: TdxBarButton;
    bbLocked: TdxBarButton;
    bbModified: TdxBarButton;

    dxRichEditControlNewDocument: TdxRichEditControlNewDocument;
    dxRibbonTabFile: TdxRibbonTab;
    dxRichEditControlLoadDocument: TdxRichEditControlLoadDocument;
    SalvaGuida: TAction;
    dxRichEditControlSaveDocumentAs: TdxRichEditControlSaveDocumentAs;
    dxBarLargeButtonSaveAs: TdxBarLargeButton;
    dxRichEditControlPasteSelection: TdxRichEditControlPasteSelection;
    dxRibbonTabHome: TdxRibbonTab;
    dxBarClipboard: TdxBar;
    dxBarLargeButtonPaste: TdxBarLargeButton;
    dxRichEditControlCutSelection: TdxRichEditControlCutSelection;
    dxBarButtonCut: TdxBarButton;
    dxRichEditControlCopySelection: TdxRichEditControlCopySelection;
    dxBarButtonCopy: TdxBarButton;
    dxRichEditControlSelectAll: TdxRichEditControlSelectAll;
    dxBarButtonSelectAll: TdxBarButton;
    dxRichEditControlChangeFontName: TdxRichEditControlChangeFontName;
    dxBarFont: TdxBar;
    cxBarEditItemFont: TcxBarEditItem;
    dxRichEditControlChangeFontSize: TdxRichEditControlChangeFontSize;
    cxBarEditItemFontSize: TcxBarEditItem;
    dxRichEditControlIncreaseFontSize: TdxRichEditControlIncreaseFontSize;
    dxBarButtonGrowFont: TdxBarButton;
    dxRichEditControlDecreaseFontSize: TdxRichEditControlDecreaseFontSize;
    dxBarButtonShrinkFont: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxRichEditControlTextUpperCase: TdxRichEditControlTextUpperCase;
    dxBarLargeButtonUPPERCASE: TdxBarLargeButton;
    dxRichEditControlTextLowerCase: TdxRichEditControlTextLowerCase;
    dxBarLargeButtonlowercase: TdxBarLargeButton;
    dxRichEditControlToggleTextCase: TdxRichEditControlToggleTextCase;
    dxBarLargeButtontOGGLEcASE: TdxBarLargeButton;
    dxRichEditControlToggleFontBold: TdxRichEditControlToggleFontBold;
    dxBarButtonBold: TdxBarButton;
    dxRichEditControlToggleFontItalic: TdxRichEditControlToggleFontItalic;
    dxBarButtonItalic: TdxBarButton;
    dxRichEditControlToggleFontUnderline: TdxRichEditControlToggleFontUnderline;
    dxBarButtonUnderline: TdxBarButton;
    dxRichEditControlToggleFontDoubleUnderline: TdxRichEditControlToggleFontDoubleUnderline;
    dxBarButtonDoubleUnderline: TdxBarButton;
    dxRichEditControlToggleFontStrikeout: TdxRichEditControlToggleFontStrikeout;
    dxBarButtonStrikethrough: TdxBarButton;
    dxRichEditControlToggleFontDoubleStrikeout: TdxRichEditControlToggleFontDoubleStrikeout;
    dxBarButtonDoubleStrikethrough: TdxBarButton;
    dxRichEditControlToggleFontSubscript: TdxRichEditControlToggleFontSubscript;
    dxBarButtonSubscript: TdxBarButton;
    dxRichEditControlToggleFontSuperscript: TdxRichEditControlToggleFontSuperscript;
    dxBarButtonSuperscript: TdxBarButton;
    dxRichEditControlTextHighlight: TdxRichEditControlTextHighlight;
    dxRibbonColorGalleryItemTextHighlightColor: TdxRibbonColorGalleryItem;
    dxRichEditControlChangeFontColor: TdxRichEditControlChangeFontColor;
    dxRibbonColorGalleryItemFontColor: TdxRibbonColorGalleryItem;
    dxRichEditControlToggleBulletedList: TdxRichEditControlToggleBulletedList;
    dxBarParagraph: TdxBar;
    dxBarButtonBullets: TdxBarButton;
    dxRichEditControlToggleSimpleNumberingList: TdxRichEditControlToggleSimpleNumberingList;
    dxBarButtonNumbering: TdxBarButton;
    dxRichEditControlToggleMultiLevelList: TdxRichEditControlToggleMultiLevelList;
    dxBarButtonMultilevellist: TdxBarButton;
    dxRichEditControlDecrementIndent: TdxRichEditControlDecrementIndent;
    dxBarButtonDecreaseIndent: TdxBarButton;
    dxRichEditControlIncrementIndent: TdxRichEditControlIncrementIndent;
    dxBarButtonIncreaseIndent: TdxBarButton;
    dxRichEditControlToggleShowWhitespace: TdxRichEditControlToggleShowWhitespace;
    dxBarButtonShowHide: TdxBarButton;
    dxRichEditControlToggleParagraphAlignmentLeft: TdxRichEditControlToggleParagraphAlignmentLeft;
    dxBarButtonAlignTextLeft: TdxBarButton;
    dxRichEditControlToggleParagraphAlignmentCenter: TdxRichEditControlToggleParagraphAlignmentCenter;
    dxBarButtonCenter: TdxBarButton;
    dxRichEditControlToggleParagraphAlignmentRight: TdxRichEditControlToggleParagraphAlignmentRight;
    dxBarButtonAlignTextRight: TdxBarButton;
    dxRichEditControlToggleParagraphAlignmentJustify: TdxRichEditControlToggleParagraphAlignmentJustify;
    dxBarButtonJustify: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    dxRichEditControlSetSingleParagraphSpacing: TdxRichEditControlSetSingleParagraphSpacing;
    dxBarLargeButton10: TdxBarLargeButton;
    dxRichEditControlSetSesquialteralParagraphSpacing: TdxRichEditControlSetSesquialteralParagraphSpacing;
    dxBarLargeButton15: TdxBarLargeButton;
    dxRichEditControlSetDoubleParagraphSpacing: TdxRichEditControlSetDoubleParagraphSpacing;
    dxBarLargeButton20: TdxBarLargeButton;
    dxRichEditControlShowParagraphForm: TdxRichEditControlShowParagraphForm;
    dxBarLargeButtonParagraph: TdxBarLargeButton;
    dxRichEditControlQuickStylesGallery: TdxRichEditControlQuickStylesGallery;
    dxBarStyles: TdxBar;
    dxRibbonGalleryItemQuickStyles: TdxRibbonGalleryItem;
    dxRibbonGalleryItemQuickStylesGroup1: TdxRibbonGalleryGroup;
    dxRichEditControlSearchFind: TdxRichEditControlSearchFind;
    dxBarEditing: TdxBar;
    dxBarButtonFind: TdxBarButton;
    dxRichEditControlSearchReplace: TdxRichEditControlSearchReplace;
    dxBarButtonReplace: TdxBarButton;
    dxRichEditControlUndo: TdxRichEditControlUndo;
    dxBarLargeButtonUndo: TdxBarLargeButton;
    dxRichEditControlRedo: TdxRichEditControlRedo;
    dxBarLargeButtonRedo: TdxBarLargeButton;
    dxRichEditControlInsertPageBreak: TdxRichEditControlInsertPageBreak;
    dxRibbonTabInsert: TdxRibbonTab;
    dxBarPages: TdxBar;
    dxBarLargeButtonPage: TdxBarLargeButton;
    dxRichEditControlShowInsertTableForm: TdxRichEditControlShowInsertTableForm;
    dxBarTables: TdxBar;
    dxBarLargeButtonTable: TdxBarLargeButton;
    dxRichEditControlInsertPicture: TdxRichEditControlInsertPicture;
    dxBarIllustrations: TdxBar;
    dxBarLargeButtonInlinePicture: TdxBarLargeButton;
    dxRichEditControlInsertFloatingObjectPicture: TdxRichEditControlInsertFloatingObjectPicture;
    dxBarLargeButtonPicture: TdxBarLargeButton;
    dxRichEditControlShowBookmarkForm: TdxRichEditControlShowBookmarkForm;
    dxBarLinks: TdxBar;
    dxBarLargeButtonBookmark: TdxBarLargeButton;
    dxRichEditControlShowHyperlinkForm: TdxRichEditControlShowHyperlinkForm;
    dxBarLargeButtonHyperlink: TdxBarLargeButton;
    dxRichEditControlEditPageHeader: TdxRichEditControlEditPageHeader;
    dxBarHeaderFooter: TdxBar;
    dxBarLargeButtonHeader: TdxBarLargeButton;
    dxRichEditControlEditPageFooter: TdxRichEditControlEditPageFooter;
    dxBarLargeButtonFooter: TdxBarLargeButton;
    dxRichEditControlInsertPageNumberField: TdxRichEditControlInsertPageNumberField;
    dxBarLargeButtonPageNumber: TdxBarLargeButton;
    dxRichEditControlInsertPageCountField: TdxRichEditControlInsertPageCountField;
    dxBarLargeButtonPageCount: TdxBarLargeButton;
    dxRichEditControlInsertTextBox: TdxRichEditControlInsertTextBox;
    dxBarText: TdxBar;
    dxBarLargeButtonTextBox: TdxBarLargeButton;
    dxRichEditControlShowSymbolForm: TdxRichEditControlShowSymbolForm;
    dxBarSymbols: TdxBar;
    dxBarLargeButtonSymbol: TdxBarLargeButton;
    dxRichEditControlPageMarginsGallery: TdxRichEditControlPageMarginsGallery;
    dxRibbonTabPageLayout: TdxRibbonTab;
    dxBarPageSetup: TdxBar;
    dxRibbonGalleryItemMargins: TdxRibbonGalleryItem;
    dxRibbonGalleryItemMarginsGroup1: TdxRibbonGalleryGroup;
    dxRibbonGalleryItemMarginsGroup1Item1: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemMarginsGroup1Item2: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemMarginsGroup1Item3: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemMarginsGroup1Item4: TdxRibbonGalleryGroupItem;
    dxRichEditControlShowPageMarginsSetupForm: TdxRichEditControlShowPageMarginsSetupForm;
    dxBarLargeButtonCustomMargins: TdxBarLargeButton;
    dxBarSubItem3: TdxBarSubItem;
    dxRichEditControlSetPortraitPageOrientation: TdxRichEditControlSetPortraitPageOrientation;
    dxBarLargeButtonPortrait: TdxBarLargeButton;
    dxRichEditControlSetLandscapePageOrientation: TdxRichEditControlSetLandscapePageOrientation;
    dxBarLargeButtonLandscape: TdxBarLargeButton;
    dxRichEditControlPaperSizeGallery: TdxRichEditControlPaperSizeGallery;
    dxRibbonGalleryItemSize: TdxRibbonGalleryItem;
    dxRibbonGalleryItemSizeGroup1: TdxRibbonGalleryGroup;
    dxRibbonGalleryItemSizeGroup1Item1: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemSizeGroup1Item2: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemSizeGroup1Item3: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemSizeGroup1Item4: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemSizeGroup1Item5: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemSizeGroup1Item6: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemSizeGroup1Item7: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemSizeGroup1Item8: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemSizeGroup1Item9: TdxRibbonGalleryGroupItem;
    dxRibbonGalleryItemSizeGroup1Item10: TdxRibbonGalleryGroupItem;
    dxRichEditControlShowPagePaperSetupForm: TdxRichEditControlShowPagePaperSetupForm;
    dxBarLargeButtonMorePaperSizes: TdxBarLargeButton;
    dxBarSubItem4: TdxBarSubItem;
    dxRichEditControlSetSectionOneColumn: TdxRichEditControlSetSectionOneColumn;
    dxBarLargeButtonOne: TdxBarLargeButton;
    dxRichEditControlSetSectionTwoColumns: TdxRichEditControlSetSectionTwoColumns;
    dxBarLargeButtonTwo: TdxBarLargeButton;
    dxRichEditControlSetSectionThreeColumns: TdxRichEditControlSetSectionThreeColumns;
    dxBarLargeButtonThree: TdxBarLargeButton;
    dxRichEditControlShowColumnsSetupForm: TdxRichEditControlShowColumnsSetupForm;
    dxBarLargeButtonMoreColumns: TdxBarLargeButton;
    dxBarSubItem5: TdxBarSubItem;
    dxRichEditControlInsertColumnBreak: TdxRichEditControlInsertColumnBreak;
    dxBarLargeButtonColumn: TdxBarLargeButton;
    dxRichEditControlInsertSectionBreakNextPage: TdxRichEditControlInsertSectionBreakNextPage;
    dxBarLargeButtonSectionNextPage: TdxBarLargeButton;
    dxRichEditControlInsertSectionBreakEvenPage: TdxRichEditControlInsertSectionBreakEvenPage;
    dxBarLargeButtonSectionEvenPage: TdxBarLargeButton;
    dxRichEditControlInsertSectionBreakOddPage: TdxRichEditControlInsertSectionBreakOddPage;
    dxBarLargeButtonSectionOddPage: TdxBarLargeButton;
    dxBarSubItem6: TdxBarSubItem;
    dxRichEditControlSetSectionLineNumberingNone: TdxRichEditControlSetSectionLineNumberingNone;
    dxBarLargeButtonNone: TdxBarLargeButton;
    dxRichEditControlSetSectionLineNumberingContinuous: TdxRichEditControlSetSectionLineNumberingContinuous;
    dxBarLargeButtonContinuous: TdxBarLargeButton;
    dxRichEditControlSetSectionLineNumberingRestartNewPage: TdxRichEditControlSetSectionLineNumberingRestartNewPage;
    dxBarLargeButtonRestartEachPage: TdxBarLargeButton;
    dxRichEditControlSetSectionLineNumberingRestartNewSection: TdxRichEditControlSetSectionLineNumberingRestartNewSection;
    dxBarLargeButtonRestartEachSection: TdxBarLargeButton;
    dxRichEditControlShowLineNumberingForm: TdxRichEditControlShowLineNumberingForm;
    dxBarLargeButtonLineNumberingOptions: TdxBarLargeButton;
    dxRichEditControlChangePageColor: TdxRichEditControlChangePageColor;
    dxBarBackground: TdxBar;
    dxRibbonColorGalleryItemPageColor: TdxRibbonColorGalleryItem;
    dxRichEditControlInsertTableOfContents: TdxRichEditControlInsertTableOfContents;
    dxRibbonTabReferences: TdxRibbonTab;
    dxBarTableofContents: TdxBar;
    dxBarLargeButtonTableofContents: TdxBarLargeButton;
    dxRichEditControlUpdateTableOfContents: TdxRichEditControlUpdateTableOfContents;
    dxBarLargeButtonUpdateTable: TdxBarLargeButton;
    dxRichEditControlAddParagraphsToTableOfContentsPlaceholder: TdxRichEditControlAddParagraphsToTableOfContentsPlaceholder;
    dxBarLargeButtonAddText: TdxBarLargeButton;
    dxRibbonPopupMenu1: TdxRibbonPopupMenu;
    dxRichEditControlTableOfContentsSetParagraphBodyTextLevel: TdxRichEditControlTableOfContentsSetParagraphBodyTextLevel;
    dxBarLargeButtonDoNotShowinTableofContents: TdxBarLargeButton;
    dxRichEditControlTableOfContentsSetParagraphHeading1Level: TdxRichEditControlTableOfContentsSetParagraphHeading1Level;
    dxBarLargeButtonLevel1: TdxBarLargeButton;
    dxRichEditControlTableOfContentsSetParagraphHeading2Level: TdxRichEditControlTableOfContentsSetParagraphHeading2Level;
    dxBarLargeButtonLevel2: TdxBarLargeButton;
    dxRichEditControlTableOfContentsSetParagraphHeading3Level: TdxRichEditControlTableOfContentsSetParagraphHeading3Level;
    dxBarLargeButtonLevel3: TdxBarLargeButton;
    dxRichEditControlTableOfContentsSetParagraphHeading4Level: TdxRichEditControlTableOfContentsSetParagraphHeading4Level;
    dxBarLargeButtonLevel4: TdxBarLargeButton;
    dxRichEditControlTableOfContentsSetParagraphHeading5Level: TdxRichEditControlTableOfContentsSetParagraphHeading5Level;
    dxBarLargeButtonLevel5: TdxBarLargeButton;
    dxRichEditControlTableOfContentsSetParagraphHeading6Level: TdxRichEditControlTableOfContentsSetParagraphHeading6Level;
    dxBarLargeButtonLevel6: TdxBarLargeButton;
    dxRichEditControlTableOfContentsSetParagraphHeading7Level: TdxRichEditControlTableOfContentsSetParagraphHeading7Level;
    dxBarLargeButtonLevel7: TdxBarLargeButton;
    dxRichEditControlTableOfContentsSetParagraphHeading8Level: TdxRichEditControlTableOfContentsSetParagraphHeading8Level;
    dxBarLargeButtonLevel8: TdxBarLargeButton;
    dxRichEditControlTableOfContentsSetParagraphHeading9Level: TdxRichEditControlTableOfContentsSetParagraphHeading9Level;
    dxBarLargeButtonLevel9: TdxBarLargeButton;
    dxRichEditControlInsertCaptionPlaceholder: TdxRichEditControlInsertCaptionPlaceholder;
    dxBarCaptions: TdxBar;
    dxBarLargeButtonInsertCaption: TdxBarLargeButton;
    dxRibbonPopupMenu2: TdxRibbonPopupMenu;
    dxRichEditControlInsertFigureCaption: TdxRichEditControlInsertFigureCaption;
    dxBarLargeButtonFiguresCaption: TdxBarLargeButton;
    dxRichEditControlInsertTableCaption: TdxRichEditControlInsertTableCaption;
    dxBarLargeButtonTablesCaption: TdxBarLargeButton;
    dxRichEditControlInsertEquationCaption: TdxRichEditControlInsertEquationCaption;
    dxBarLargeButtonEquationsCaption: TdxBarLargeButton;
    dxRichEditControlInsertTableOfFiguresPlaceholder: TdxRichEditControlInsertTableOfFiguresPlaceholder;
    dxBarLargeButtonInsertTableofFigures: TdxBarLargeButton;
    dxRibbonPopupMenu3: TdxRibbonPopupMenu;
    dxRichEditControlInsertTableOfFigures: TdxRichEditControlInsertTableOfFigures;
    dxBarLargeButtonTableofFigures: TdxBarLargeButton;
    dxRichEditControlInsertTableOfTables: TdxRichEditControlInsertTableOfTables;
    dxBarLargeButtonTableofTables: TdxBarLargeButton;
    dxRichEditControlInsertTableOfEquations: TdxRichEditControlInsertTableOfEquations;
    dxBarLargeButtonTableofEquations: TdxBarLargeButton;
    dxRichEditControlUpdateTableOfFigures: TdxRichEditControlUpdateTableOfFigures;
    dxBarLargeButtonUpdateTable1: TdxBarLargeButton;
    dxBarLargeButtonViewMergedData: TdxBarLargeButton;
    dxRichEditControlCheckSpelling: TdxRichEditControlCheckSpelling;
    dxRibbonTabReview: TdxRibbonTab;
    dxBarProofing: TdxBar;
    dxBarLargeButtonSpelling: TdxBarLargeButton;
    dxRichEditControlProtectDocument: TdxRichEditControlProtectDocument;
    dxBarProtect: TdxBar;
    dxBarLargeButtonProtectDocument: TdxBarLargeButton;
    dxRichEditControlUnprotectDocument: TdxRichEditControlUnprotectDocument;
    dxBarLargeButtonUnprotectDocument: TdxBarLargeButton;
    dxRichEditControlShowRangeEditingPermissions: TdxRichEditControlShowRangeEditingPermissions;
    dxBarLargeButtonRangeEditingPermissions: TdxBarLargeButton;
    dxRichEditControlEncryptDocument: TdxRichEditControlEncryptDocument;
    dxBarLargeButtonEncryptwithPassword: TdxBarLargeButton;
    dxRichEditControlSwitchToSimpleView: TdxRichEditControlSwitchToSimpleView;
    dxRibbonTabView: TdxRibbonTab;
    dxBarDocumentViews: TdxBar;
    dxBarLargeButtonSimpleView: TdxBarLargeButton;
    dxRichEditControlSwitchToDraftView: TdxRichEditControlSwitchToDraftView;
    dxBarLargeButtonDraftView: TdxBarLargeButton;
    dxRichEditControlSwitchToPrintLayoutView: TdxRichEditControlSwitchToPrintLayoutView;
    dxBarLargeButtonPrintLayout: TdxBarLargeButton;
    dxRichEditControlToggleShowHorizontalRuler: TdxRichEditControlToggleShowHorizontalRuler;
    dxBarShow: TdxBar;
    dxBarLargeButtonHorizontalRuler: TdxBarLargeButton;
    dxRichEditControlToggleShowVerticalRuler: TdxRichEditControlToggleShowVerticalRuler;
    dxBarLargeButtonVerticalRuler: TdxBarLargeButton;
    dxRichEditControlZoomOut: TdxRichEditControlZoomOut;
    dxBarZoom: TdxBar;
    dxBarLargeButtonZoomOut: TdxBarLargeButton;
    dxRichEditControlZoomIn: TdxRichEditControlZoomIn;
    dxBarLargeButtonZoomIn: TdxBarLargeButton;
    dxRichEditControlGoToPageHeader: TdxRichEditControlGoToPageHeader;
    dxRibbonTabHeaderFooterDesign: TdxRibbonTab;
    dxBarNavigation: TdxBar;
    dxBarLargeButtonGotoHeader: TdxBarLargeButton;
    dxRichEditControlGoToPageFooter: TdxRichEditControlGoToPageFooter;
    dxBarLargeButtonGotoFooter: TdxBarLargeButton;
    dxRichEditControlGoToNextPageHeaderFooter: TdxRichEditControlGoToNextPageHeaderFooter;
    dxBarLargeButtonShowNext: TdxBarLargeButton;
    dxRichEditControlGoToPreviousPageHeaderFooter: TdxRichEditControlGoToPreviousPageHeaderFooter;
    dxBarLargeButtonShowPrevious: TdxBarLargeButton;
    dxRichEditControlToggleHeaderFooterLinkToPrevious: TdxRichEditControlToggleHeaderFooterLinkToPrevious;
    dxBarLargeButtonLinktoPrevious: TdxBarLargeButton;
    dxRichEditControlToggleDifferentFirstPage: TdxRichEditControlToggleDifferentFirstPage;
    dxBarOptions: TdxBar;
    dxBarLargeButtonDifferentFirstPage: TdxBarLargeButton;
    dxRichEditControlToggleDifferentOddAndEvenPages: TdxRichEditControlToggleDifferentOddAndEvenPages;
    dxBarLargeButtonDifferentOddEvenPages: TdxBarLargeButton;
    dxRichEditControlClosePageHeaderFooter: TdxRichEditControlClosePageHeaderFooter;
    dxBarClose: TdxBar;
    dxBarLargeButtonCloseHeaderandFooter: TdxBarLargeButton;
    dxRichEditControlToggleShowTableGridLines: TdxRichEditControlToggleShowTableGridLines;
    dxRibbonTabTableLayout: TdxRibbonTab;
    dxBarTable: TdxBar;
    dxBarLargeButtonViewGridlines: TdxBarLargeButton;
    dxRichEditControlShowTablePropertiesForm: TdxRichEditControlShowTablePropertiesForm;
    dxBarLargeButtonTableProperties: TdxBarLargeButton;
    dxBarRowColumns: TdxBar;
    dxBarSubItem7: TdxBarSubItem;
    dxRichEditControlShowDeleteTableCellsForm: TdxRichEditControlShowDeleteTableCellsForm;
    dxBarLargeButtonDeleteCells: TdxBarLargeButton;
    dxRichEditControlDeleteTableColumns: TdxRichEditControlDeleteTableColumns;
    dxBarLargeButtonDeleteColumns: TdxBarLargeButton;
    dxRichEditControlDeleteTableRows: TdxRichEditControlDeleteTableRows;
    dxBarLargeButtonDeleteRows: TdxBarLargeButton;
    dxRichEditControlDeleteTable: TdxRichEditControlDeleteTable;
    dxBarLargeButtonDeleteTable: TdxBarLargeButton;
    dxRichEditControlInsertTableRowAbove: TdxRichEditControlInsertTableRowAbove;
    dxBarLargeButtonInsertAbove: TdxBarLargeButton;
    dxRichEditControlInsertTableRowBelow: TdxRichEditControlInsertTableRowBelow;
    dxBarLargeButtonInsertBelow: TdxBarLargeButton;
    dxRichEditControlInsertTableColumnToTheLeft: TdxRichEditControlInsertTableColumnToTheLeft;
    dxBarLargeButtonInsertLeft: TdxBarLargeButton;
    dxRichEditControlInsertTableColumnToTheRight: TdxRichEditControlInsertTableColumnToTheRight;
    dxBarLargeButtonInsertRight: TdxBarLargeButton;
    dxRichEditControlMergeTableCells: TdxRichEditControlMergeTableCells;
    dxBarMerge: TdxBar;
    dxBarLargeButtonMergeCells: TdxBarLargeButton;
    dxRichEditControlShowSplitTableCellsForm: TdxRichEditControlShowSplitTableCellsForm;
    dxBarLargeButtonSplitCells: TdxBarLargeButton;
    dxRichEditControlSplitTable: TdxRichEditControlSplitTable;
    dxBarLargeButtonSplitTable: TdxBarLargeButton;
    dxBarCellSize: TdxBar;
    dxBarSubItem8: TdxBarSubItem;
    dxRichEditControlToggleTableAutoFitContents: TdxRichEditControlToggleTableAutoFitContents;
    dxBarLargeButtonAutoFitContents: TdxBarLargeButton;
    dxRichEditControlToggleTableAutoFitWindow: TdxRichEditControlToggleTableAutoFitWindow;
    dxBarLargeButtonAutoFitWindow: TdxBarLargeButton;
    dxRichEditControlToggleTableFixedColumnWidth: TdxRichEditControlToggleTableFixedColumnWidth;
    dxBarLargeButtonFixedColumnWidth: TdxBarLargeButton;
    dxRichEditControlToggleTableCellsTopLeftAlignment: TdxRichEditControlToggleTableCellsTopLeftAlignment;
    dxBarAlignment: TdxBar;
    dxBarButtonAlignTopLeft: TdxBarButton;
    dxRichEditControlToggleTableCellsTopCenterAlignment: TdxRichEditControlToggleTableCellsTopCenterAlignment;
    dxBarButtonAlignTopCenter: TdxBarButton;
    dxRichEditControlToggleTableCellsTopRightAlignment: TdxRichEditControlToggleTableCellsTopRightAlignment;
    dxBarButtonAlignTopRight: TdxBarButton;
    dxRichEditControlToggleTableCellsMiddleLeftAlignment: TdxRichEditControlToggleTableCellsMiddleLeftAlignment;
    dxBarButtonAlignCenterLeft: TdxBarButton;
    dxRichEditControlToggleTableCellsMiddleCenterAlignment: TdxRichEditControlToggleTableCellsMiddleCenterAlignment;
    dxBarButtonAlignCenter: TdxBarButton;
    dxRichEditControlToggleTableCellsMiddleRightAlignment: TdxRichEditControlToggleTableCellsMiddleRightAlignment;
    dxBarButtonAlignCenterRight: TdxBarButton;
    dxRichEditControlToggleTableCellsBottomLeftAlignment: TdxRichEditControlToggleTableCellsBottomLeftAlignment;
    dxBarButtonAlignBottomLeft: TdxBarButton;
    dxRichEditControlToggleTableCellsBottomCenterAlignment: TdxRichEditControlToggleTableCellsBottomCenterAlignment;
    dxBarButtonAlignBottomCenter: TdxBarButton;
    dxRichEditControlToggleTableCellsBottomRightAlignment: TdxRichEditControlToggleTableCellsBottomRightAlignment;
    dxBarButtonAlignBottomRight: TdxBarButton;
    dxRichEditControlTableStylesGallery: TdxRichEditControlTableStylesGallery;
    dxBarTableStyles: TdxBar;
    dxRibbonGalleryItemTableStyles: TdxRibbonGalleryItem;
    dxRibbonGalleryItemTableStylesGroup1: TdxRibbonGalleryGroup;
    dxBarSubItem9: TdxBarSubItem;
    dxRichEditControlToggleTableCellsBottomBorder: TdxRichEditControlToggleTableCellsBottomBorder;
    dxBarLargeButtonBottomBorder: TdxBarLargeButton;
    dxRichEditControlToggleTableCellsTopBorder: TdxRichEditControlToggleTableCellsTopBorder;
    dxBarLargeButtonTopBorder: TdxBarLargeButton;
    dxRichEditControlToggleTableCellsLeftBorder: TdxRichEditControlToggleTableCellsLeftBorder;
    dxBarLargeButtonLeftBorder: TdxBarLargeButton;
    dxRichEditControlToggleTableCellsRightBorder: TdxRichEditControlToggleTableCellsRightBorder;
    dxBarLargeButtonRightBorder: TdxBarLargeButton;
    dxRichEditControlResetTableCellsBorders: TdxRichEditControlResetTableCellsBorders;
    dxBarLargeButtonNoBorder: TdxBarLargeButton;
    dxRichEditControlToggleTableCellsAllBorders: TdxRichEditControlToggleTableCellsAllBorders;
    dxBarLargeButtonAllBorders: TdxBarLargeButton;
    dxRichEditControlToggleTableCellsOutsideBorder: TdxRichEditControlToggleTableCellsOutsideBorder;
    dxBarLargeButtonOutsideBorders: TdxBarLargeButton;
    dxRichEditControlToggleTableCellsInsideBorder: TdxRichEditControlToggleTableCellsInsideBorder;
    dxBarLargeButtonInsideBorders: TdxBarLargeButton;
    dxRichEditControlToggleTableCellsInsideHorizontalBorder: TdxRichEditControlToggleTableCellsInsideHorizontalBorder;
    dxBarLargeButtonInsideHorizontalBorder: TdxBarLargeButton;
    dxRichEditControlToggleTableCellsInsideVerticalBorder: TdxRichEditControlToggleTableCellsInsideVerticalBorder;
    dxBarLargeButtonInsideVerticalBorder: TdxBarLargeButton;
    dxRichEditControlChangeFloatingObjectFillColor: TdxRichEditControlChangeFloatingObjectFillColor;
    dxRibbonTabFormat: TdxRibbonTab;
    dxBarShapeStyles: TdxBar;
    dxRibbonColorGalleryItemShapeFill: TdxRibbonColorGalleryItem;
    dxRichEditControlChangeFloatingObjectOutlineColor: TdxRichEditControlChangeFloatingObjectOutlineColor;
    dxRibbonColorGalleryItemShapeOutline: TdxRibbonColorGalleryItem;
    dxBarArrange: TdxBar;
    dxBarSubItem10: TdxBarSubItem;
    dxRichEditControlSetFloatingObjectSquareTextWrapType: TdxRichEditControlSetFloatingObjectSquareTextWrapType;
    dxBarLargeButtonSquare: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectTightTextWrapType: TdxRichEditControlSetFloatingObjectTightTextWrapType;
    dxBarLargeButtonTight: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectThroughTextWrapType: TdxRichEditControlSetFloatingObjectThroughTextWrapType;
    dxBarLargeButtonThrough: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectTopAndBottomTextWrapType: TdxRichEditControlSetFloatingObjectTopAndBottomTextWrapType;
    dxBarLargeButtonTopandBottom: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectBehindTextWrapType: TdxRichEditControlSetFloatingObjectBehindTextWrapType;
    dxBarLargeButtonBehindText: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectInFrontOfTextWrapType: TdxRichEditControlSetFloatingObjectInFrontOfTextWrapType;
    dxBarLargeButtonInFrontofText: TdxBarLargeButton;
    dxBarSubItem11: TdxBarSubItem;
    dxRichEditControlSetFloatingObjectTopLeftAlignment: TdxRichEditControlSetFloatingObjectTopLeftAlignment;
    dxBarLargeButtonTopLeft: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectTopCenterAlignment: TdxRichEditControlSetFloatingObjectTopCenterAlignment;
    dxBarLargeButtonTopCenter: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectTopRightAlignment: TdxRichEditControlSetFloatingObjectTopRightAlignment;
    dxBarLargeButtonTopRight: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectMiddleLeftAlignment: TdxRichEditControlSetFloatingObjectMiddleLeftAlignment;
    dxBarLargeButtonMiddleLeft: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectMiddleCenterAlignment: TdxRichEditControlSetFloatingObjectMiddleCenterAlignment;
    dxBarLargeButtonMiddleCenter: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectMiddleRightAlignment: TdxRichEditControlSetFloatingObjectMiddleRightAlignment;
    dxBarLargeButtonMiddleRight: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectBottomLeftAlignment: TdxRichEditControlSetFloatingObjectBottomLeftAlignment;
    dxBarLargeButtonBottomLeft: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectBottomCenterAlignment: TdxRichEditControlSetFloatingObjectBottomCenterAlignment;
    dxBarLargeButtonBottomCenter: TdxBarLargeButton;
    dxRichEditControlSetFloatingObjectBottomRightAlignment: TdxRichEditControlSetFloatingObjectBottomRightAlignment;
    dxBarLargeButtonBottomRight: TdxBarLargeButton;
    dxBarSubItem12: TdxBarSubItem;
    dxRichEditControlFloatingObjectBringForward: TdxRichEditControlFloatingObjectBringForward;
    dxBarLargeButtonBringForward: TdxBarLargeButton;
    dxRichEditControlFloatingObjectBringToFront: TdxRichEditControlFloatingObjectBringToFront;
    dxBarLargeButtonBringtoFront: TdxBarLargeButton;
    dxRichEditControlFloatingObjectBringInFrontOfText: TdxRichEditControlFloatingObjectBringInFrontOfText;
    dxBarLargeButtonBringinFrontofText: TdxBarLargeButton;
    dxBarSubItem13: TdxBarSubItem;
    dxRichEditControlFloatingObjectSendBackward: TdxRichEditControlFloatingObjectSendBackward;
    dxBarLargeButtonSendBackward: TdxBarLargeButton;
    dxRichEditControlFloatingObjectSendToBack: TdxRichEditControlFloatingObjectSendToBack;
    dxBarLargeButtonSendtoBack: TdxBarLargeButton;
    dxRichEditControlFloatingObjectSendBehindText: TdxRichEditControlFloatingObjectSendBehindText;
    dxBarLargeButtonSendBehindText: TdxBarLargeButton;
    dxRichEditControlShowPrintForm: TdxRichEditControlShowPrintForm;
    dxBarPrint: TdxBar;
    dxRichEditControlShowPrintPreviewForm: TdxRichEditControlShowPrintPreviewForm;
    dxBarLargeButtonPrintPreview: TdxBarLargeButton;
    dxRichEditControlShowPageSetupForm: TdxRichEditControlShowPageSetupForm;
    StatusBar: TdxRibbonStatusBar;
    tbZoom: TdxZoomTrackBar;
    Printer: TdxComponentPrinter;
    RichEditPrinterLink: TdxRichEditControlReportLink;
    dxBarButton1: TdxBarButton;
    dxBarLargeButton1: TdxBarLargeButton;
    dxSaveFileDialog: TdxSaveFileDialog;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutControl: TdxLayoutControl;
    dxLayoutItemEditor: TdxLayoutItem;
    dxBarManagerBar1: TdxBar;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    dxBarManagerBarQuickAccess: TdxBar;
    dxBarLargeButton7: TdxBarLargeButton;
    ActionList: TActionList;
    SaveAs: TdxFileSaveAs;
    dxBarLargeButton13: TdxBarLargeButton;
    dxLayoutGroupEditor: TdxLayoutGroup;
    ApriConWord: TAction;
    dxBarButton2: TdxBarButton;
    ApriCartella: TAction;
    dxBarManagerBar7: TdxBar;
    dxBarLargeButton24: TdxBarLargeButton;
    Chiudi: TAction;
    dxBarButton3: TdxBarButton;
    dxBarButton10: TdxBarButton;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    dxBarManagerBar3: TdxBar;
    dxBarLargeButton4: TdxBarLargeButton;
    dxBarLargeButton5: TdxBarLargeButton;
    dxBarLargeButton8: TdxBarLargeButton;
    dxBarLargeButton6: TdxBarLargeButton;
    dxBarLargeButton9: TdxBarLargeButton;
    actNovita: TAction;
    dxBarManagerBarNovita: TdxBar;
    dxBarLargeButton11: TdxBarLargeButton;
    Pdf: TAction;
    dxBarLargeButton14: TdxBarLargeButton;
    dxBarLargeButton16: TdxBarLargeButton;
    GeneraGuida: TAction;
    dxBarManagerBarGenera: TdxBar;
    dxBarLargeButton17: TdxBarLargeButton;
    ProgressBox: TProgressBox;
    CompilaCHM: TAction;
    CopiaFileCHM: TAction;
    dxBarLargeButton18: TdxBarLargeButton;
    dxBarLargeButton19: TdxBarLargeButton;
    procedure actNovitaExecute(Sender: TObject);
    procedure ApriCartellaExecute(Sender: TObject);
    procedure ApriConWordExecute(Sender: TObject);
    procedure ApriConWordUpdate(Sender: TObject);
    procedure ChiudiExecute(Sender: TObject);
    procedure CompilaCHMExecute(Sender: TObject);
    procedure CopiaFileCHMExecute(Sender: TObject);
    procedure dxRichEditControlActiveViewChanged(Sender: TObject);
    procedure dxRichEditControlContentChanged(Sender: TObject);
    procedure dxRichEditControlSelectionChanged(Sender: TObject);
    procedure dxRichEditControlZoomChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveAsAccept(Sender: TObject);
    procedure tbZoomPropertiesChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GeneraGuidaExecute(Sender: TObject);
    procedure PdfExecute(Sender: TObject);
    procedure PdfUpdate(Sender: TObject);
    procedure SalvaGuidaExecute(Sender: TObject);
    procedure SalvaGuidaUpdate(Sender: TObject);
    procedure SaveAsBeforeExecute(Sender: TObject);
  private
    procedure UpdateZoom;
    procedure ImagesResize;
    procedure UpdateRibbonContexstsStates;
    procedure InitHints;
  private
  private
    FHelpSubject: IHelpSubject;
    FHelpFileName: String;
    RestrictionManager: TRestrictionManager;
    function GetRestrictionManager: TRestrictionManager;
  private
    // Servizio AI della guida, creato al primo uso: chi non genera guide non
    // paga nemmeno la lettura della configurazione
    FHelpGenAI: TzHelpGenAI;
    FHadSelection: Boolean;
    FTargetRange: IdxRichEditDocumentRange;

    function HelpGenAI: TzHelpGenAI;
    procedure HelpGenAIProcessingStart(Sender: TObject);
    procedure HelpGenAIDocumentazione(Sender: TObject; Documentazione: THelpGenResponseDocumentazione);
    procedure HelpGenAIError(Sender: TObject; const ErrorMessage: string);
    procedure HelpGenAITestoElaborato(Sender: TObject; const TestoElaborato: string);
    procedure InizializzaMenuAI;
    procedure DoAIAzioneTestoClick(Sender: TObject);
    procedure EseguiAzioneAITesto(AAzione: THelpGenAIAzioneTesto; const AIstruzione: string = '');
  private
    procedure ForceFileFolder(const FileName: string);
    procedure ExportPDF(const silent: Boolean = false);
    function GeneraFileName(HelpFileName: string): string;
    procedure GeneraHelpDefault;
    procedure GeneraHelpClaude;
    procedure doSalvaHelpFile;
  public
    constructor Create(aOwner: TComponent); Override;
  public
    procedure GeneraHelp(const aHelpFileName: string; HelpSubject: IHelpSubject);
    procedure Novita();

    property HelpFileName: String read FHelpFileName;
    property HelpSubject: IHelpSubject read FHelpSubject;
  end;

var
  HelpGenEditor: THelpGenEditor;

procedure GeneraHelp(HelpFileName: string; HelpSubject: IHelpSubject);
procedure Novita();

implementation

uses
  Winapi.ShlObj,
  Winapi.ShellAPI,
  System.Rtti,
  System.IOUtils,
  System.DateUtils,
  Vcl.Clipbrd,
  Vcl.Menus,
  cxGeometry,
  zz.Vcl,
  zDX,
  ConfigModule,
  zBaseLib,
  zRestrictions.Types,
  zMsg,
  HelpGen.Generator,
  HelpGen.HelpCompiler,
  System.Types;

{$R *.dfm}

type
  TdxRichEditControlAccess = class(TdxRichEditControl);

procedure GeneraHelp(HelpFileName: string; HelpSubject: IHelpSubject);
begin

  if not assigned(HelpGenEditor) then
    Application.CreateForm(THelpGenEditor, HelpGenEditor);

  Application.ProcessMessages;

  HelpGenEditor.GeneraHelp(HelpFileName, HelpSubject);
end;

procedure Novita;
begin

  if not assigned(HelpGenEditor) then
    Application.CreateForm(THelpGenEditor, HelpGenEditor);

  HelpGenEditor.Novita();
end;

constructor THelpGenEditor.Create(aOwner: TComponent);
begin
  inherited;
  FHelpFileName := '';
  FHelpSubject := nil;
  FHadSelection := false;
  FTargetRange := nil;

  dx.InitLayoutControl(dxLayoutControl);
  dx.InitPrinter(Printer);

  InizializzaMenuAI;
end;

procedure THelpGenEditor.UpdateZoom;
begin
  if dxRichEditControl.ActiveView.ZoomFactor > 5 then
    dxRichEditControl.ActiveView.ZoomFactor := 5;
  tbZoom.Position := Round(dxRichEditControl.ActiveView.ZoomFactor * 100);
end;

procedure THelpGenEditor.tbZoomPropertiesChange(Sender: TObject);
begin
  bsZoom.Caption := Format('%3d %%', [tbZoom.Position]);
  dxRichEditControl.ActiveView.ZoomFactor := tbZoom.Position / 100;
end;

procedure THelpGenEditor.dxRichEditControlActiveViewChanged(Sender: TObject);
begin
  UpdateZoom;
end;

procedure THelpGenEditor.dxRichEditControlZoomChanged(Sender: TObject);
begin
  UpdateZoom;
end;

procedure THelpGenEditor.dxRichEditControlContentChanged(Sender: TObject);
begin
  // bbCursorLine.Caption := 'Linea: ' + dxRichEditControl.ActiveView.CaretPosition.LayoutPosition.Row.LineNumber.ToString;
  // bbCursorColumn.Caption := 'Colonna: ' +   dxRichEditControl.ActiveView.CaretPosition.LayoutPosition.Column.colLineNumber.ToString;
end;

procedure THelpGenEditor.dxRichEditControlSelectionChanged(Sender: TObject);
begin
  UpdateRibbonContexstsStates;
  // bbCursorLine.Caption := 'Linea: ' + dxRichEditControl.ActiveView.CaretPosition.LayoutPosition.Row.LineNumber.ToString;
  // bbCursorColumn.Caption := 'Colonna: ' + dxRichEditControl.ActiveView.CaretPosition.LayoutPosition.Column.colLineNumber.ToString;
  // bbCursorColumn.Caption := 'Colonna: ' + dxRichEditControl.ActiveView.CaretPosition.LayoutPosition.LeftOffset.ToString;
end;

procedure THelpGenEditor.FormShow(Sender: TObject);
begin
  //

  if dx.SkinActive then
    dxRibbon.ColorSchemeName := 'UserSkin'
  else
    // dxRibbon.ColorSchemeName := 'Colorful';
    dxRibbon.ColorSchemeName := 'White';
end;

procedure THelpGenEditor.SaveAsAccept(Sender: TObject);
begin
  FHelpFileName := SaveAs.Dialog.FileName;

  ForceFileFolder(HelpFileName);

  dxRichEditControl.SaveDocument(HelpFileName);
  dxRichEditControl.DocumentModelModified := false;

  dxRichEditControl.Options.DocumentSaveOptions.CurrentFileName := HelpFileName;
  dxRichEditControl.Options.DocumentSaveOptions.CurrentFormat := dxRichEditControl.DocumentModel.AutodetectDocumentFormat(HelpFileName);
end;

procedure THelpGenEditor.ApriConWordExecute(Sender: TObject);
begin
  doSalvaHelpFile;
  ShellExecute(0, PCHAR('open'), PCHAR(HelpFileName), nil, nil, SW_RESTORE);
end;

procedure THelpGenEditor.ChiudiExecute(Sender: TObject);
begin
  Close;
end;

procedure THelpGenEditor.doSalvaHelpFile;
var
  backupFile: string;
  backupFolder: string;
begin
  ForceFileFolder(HelpFileName);

  if TFile.Exists(HelpFileName) then
  begin
    backupFolder := IncludeTrailingPathDelimiter(TPath.GetDirectoryName(HelpFileName)) + '_backup\';
    ForceDirectories(backupFolder);
    backupFile := backupFolder + FormatDateTime('yyyymmdd hh nn ss', now) + ' - ' + TPath.GetFileName(HelpFileName);
    TFile.Copy(HelpFileName, backupFile);
  end;

  dxRichEditControl.Options.DocumentSaveOptions.CurrentFileName := HelpFileName;
  dxRichEditControl.Options.DocumentSaveOptions.CurrentFormat := dxRichEditControl.DocumentModel.AutodetectDocumentFormat(HelpFileName);
  dxRichEditControl.SaveDocument(HelpFileName);
  dxRichEditControl.DocumentModelModified := false;
end;

procedure THelpGenEditor.ImagesResize;

  procedure ResizeImages(Images: IdxRichEditDocumentImageCollection; MaxWidth: single);
  var
    image: IdxRichEditDocumentImage;
    I: Integer;
    s: string;
    w, h: double;
  begin
    for I := 0 to Images.Count - 1 do
    begin
      image := Images[I];

      if image.Size.cx > MaxWidth then
      begin
        image.ScaleX := MaxWidth / image.Size.cx;
        image.ScaleY := image.ScaleX;
      end;

      /// /////////////

      s := image.Uri.Substring(image.Uri.IndexOf('@') + 1);

      if not s.Trim.IsEmpty then
        if double.TryParse(s.Substring(0, s.IndexOf(':')), w) then
          if double.TryParse(s.Substring(s.IndexOf(':') + 1), h) then
            image.Size := TdxSizeF.Create(w, h);
    end;
  end;

var
  SubDoc: IdxRichEditSubDocument;
  MaxWidth: single;
begin
  exit; // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  MaxWidth := dxRichEditControl.Document.Sections[0].Page.Width - dxRichEditControl.Document.Sections[0].Margins.left - dxRichEditControl.Document.Sections[0].Margins.Right;

  SubDoc := dxRichEditControl.Document.Sections[0].BeginUpdateHeader();
  ResizeImages(SubDoc.Images, MaxWidth);
  dxRichEditControl.Document.Sections[0].EndUpdateHeader(SubDoc);

  ResizeImages(dxRichEditControl.Document.Images, MaxWidth);

  SubDoc := dxRichEditControl.Document.Sections[0].BeginUpdateFooter();
  ResizeImages(SubDoc.Images, MaxWidth);
  dxRichEditControl.Document.Sections[0].EndUpdateFooter(SubDoc);
end;

procedure THelpGenEditor.SalvaGuidaExecute(Sender: TObject);
begin
  doSalvaHelpFile;
end;

procedure THelpGenEditor.SalvaGuidaUpdate(Sender: TObject);
begin
  SalvaGuida.Enabled := (dxRichEditControl.DocumentModelModified) and (not HelpFileName.IsEmpty);
end;

procedure THelpGenEditor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;

  if dxRichEditControl.DocumentModelModified then
  begin
    case ConfirmYesNoCancel('Salvo le modifiche al template?') of
      mrCancel:
        CanClose := false;
      mrYes:
        doSalvaHelpFile;
      mrNo:
        begin
          // non fa nulla
        end;
    end;
  end;
end;

function THelpGenEditor.GetRestrictionManager: TRestrictionManager;
begin
  result := RestrictionManager;
end;

procedure THelpGenEditor.UpdateRibbonContexstsStates;
  procedure SetRibbonContext(Const RibbonContextName: string; Const Visible: Boolean);
  var
    dxRibbonContext: TdxRibbonContext;
  begin
    dxRibbonContext := dxRibbon.Contexts.Find(RibbonContextName);

    if assigned(dxRibbonContext) then
      dxRibbonContext.Visible := Visible;
  end;

begin
  SetRibbonContext('Forme', dxRichEditControl.IsFloatingObjectSelected);
  SetRibbonContext('Header & Footer', dxRichEditControl.IsSelectionInHeaderOrFooter);
  SetRibbonContext('Table', dxRichEditControl.IsSelectionInTable);
  SetRibbonContext('Mail Merge', config.IsAdmin);
  SetRibbonContext('Sistema', config.IsAdmin);
end;

procedure THelpGenEditor.InitHints;
begin

  ForEach<TContainedAction>(
    procedure(Action: TContainedAction)
    begin
      Action.Hint := '';
    end);
end;

function THelpGenEditor.GeneraFileName(HelpFileName: string): string;
var
  c: char;
begin
  result := '';

  for c in HelpFileName do
    if (c in ['<', '>', ':', '"', '/', '\', '|', '?', '*']) then
      result := result + ' '
    else
      result := result + c;

  result := result.Trim();

  { TODO : Cartelle per guide }
  result := zHelpConfig.HelpFolder + result + '.docx';
end;

procedure THelpGenEditor.GeneraHelp(const aHelpFileName: string; HelpSubject: IHelpSubject);
begin
  // https://docs.devexpress.com/WindowsForms/9709/controls-and-libraries/rich-text-editor/fields/field-codes

  /// /////////////////////////////
  dxBarManagerBarNovita.Visible := false;
  actNovita.Visible := false;

  FHelpSubject := HelpSubject;

  FHelpFileName := aHelpFileName;

  if FHelpFileName.IsEmpty then
    FHelpFileName := IncludeTrailingPathDelimiter(zHelpConfig.HelpFolder) + IncludeTrailingPathDelimiter(HelpSubject.HelpFolder) + ChangeFileExt(HelpSubject.HelpFileName, '.docx');

  SaveAs.Dialog.InitialDir := zHelpConfig.HelpFolder + HelpSubject.HelpFolder;
  SaveAs.Dialog.FileName := HelpFileName;

  if FileExists(HelpFileName) then
    dxRichEditControl.Document.LoadDocument(HelpFileName, TdxRichEditDocumentFormat.Undefined)
  else
  begin

    if FileExists(zHelpConfig.TemplateFileName) then
      dxRichEditControl.Document.LoadDocument(zHelpConfig.TemplateFileName, TdxRichEditDocumentFormat.Undefined);

    dxRichEditControl.Options.DocumentSaveOptions.CurrentFileName := HelpFileName;
    dxRichEditControl.Options.DocumentSaveOptions.CurrentFormat := dxRichEditControl.DocumentModel.AutodetectDocumentFormat(HelpFileName);
  end;

  dxRichEditControl.Options.DocumentSaveOptions.CurrentFileName := HelpFileName;
  dxRichEditControl.Options.DocumentSaveOptions.CurrentFormat := dxRichEditControl.DocumentModel.AutodetectDocumentFormat(HelpFileName);

  dxRichEditControl.DocumentModelModified := false;

  /// /////////////////////////////

  InitHints;

  dxRibbon.ActiveTab := dxRibbonTabFile;

  Caption := HelpFileName;

  WindowState := wsMaximized;

  if Visible then
    bringToFront
  else
    Show;
end;

procedure THelpGenEditor.Novita;
begin
  dxBarManagerBarNovita.Visible := true;
  actNovita.Visible := true;

  FHelpSubject := nil;
  FHelpFileName := GeneraFileName('Gesty - Novità');

  if FileExists(HelpFileName) then
    dxRichEditControl.Document.LoadDocument(HelpFileName, TdxRichEditDocumentFormat.Undefined)
  else
    if FileExists(zHelpConfig.TemplateFileName) then
      dxRichEditControl.Document.LoadDocument(zHelpConfig.TemplateFileName, TdxRichEditDocumentFormat.Undefined);

  dxRichEditControl.Options.DocumentSaveOptions.CurrentFileName := HelpFileName;
  dxRichEditControl.Options.DocumentSaveOptions.CurrentFormat := dxRichEditControl.DocumentModel.AutodetectDocumentFormat(HelpFileName);

  dxRichEditControl.DocumentModelModified := false;

  /// /////////////////////////////

  InitHints;
  dxRibbon.ActiveTab := dxRibbonTabFile;

  Caption := HelpFileName;

  WindowState := wsMaximized;

  if Visible then
    bringToFront
  else
    Show;
end;

procedure THelpGenEditor.actNovitaExecute(Sender: TObject);
  procedure NewLine;
  begin
    dxRichEditControl.Document.InsertText(dxRichEditControl.Document.CaretPosition, TdxCharacters.LineBreak);
  end;

  procedure AddParagraph(const styleName: string);
  var
    paragraph: IdxRichEditParagraph;
    style: IdxRichEditParagraphStyle;
  begin
    paragraph := dxRichEditControl.Document.InsertParagraph(dxRichEditControl.Document.CaretPosition);

    style := dxRichEditControl.Document.ParagraphStyles[styleName];
    if assigned(style) then
      paragraph.style := style
    else
      ConfirmOk('Stile ' + styleName + ' non trovato');

    paragraph.PageBreakBefore := false;
    paragraph.Alignment := TdxParagraphAlignment.left;
  end;

  procedure AddText(const text: string);
  begin
    dxRichEditControl.Document.InsertText(dxRichEditControl.Document.CaretPosition, text);
  end;

var
  FormatSettings: TFormatSettings;
begin
  GetLocaleFormatSettings(GetThreadLocale, FormatSettings);
  FormatSettings.ShortDateFormat := 'dd mmmm yyyy';

  dxRichEditControl.Document.InsertText(dxRichEditControl.Document.ActiveSubDocument.Range.Start, TdxCharacters.LineBreak);

  AddParagraph('Subtitle');
  AddText(Date.ToString(FormatSettings));

  AddParagraph('Normal');
  AddText('Novità');

  NewLine;
end;

procedure THelpGenEditor.PdfUpdate(Sender: TObject);
begin
  Pdf.Enabled := not HelpFileName.IsEmpty;
end;

procedure THelpGenEditor.ApriConWordUpdate(Sender: TObject);
begin
  ApriConWord.Enabled := not HelpFileName.IsEmpty;
end;

procedure THelpGenEditor.ApriCartellaExecute(Sender: TObject);
var
  folder: string;
begin

  if HelpFileName.IsEmpty then
    folder := extractFilePath(HelpFileName)
  else
    folder := HelpSubject.HelpFolder;

  ShellExecute(0, PCHAR('open'), PCHAR(folder), nil, nil, SW_RESTORE);
end;

procedure THelpGenEditor.PdfExecute(Sender: TObject);
begin
  ExportPDF;
end;

procedure THelpGenEditor.ExportPDF(const silent: Boolean = false);
var
  Options: TdxPSPDFReportExportOptions;
  FileName: string;
begin

  if HelpFileName.IsEmpty then
    exit;

  Pdf.Enabled := false;
  try
    FileName := ChangeFileExt(HelpFileName, '.pdf');

    Options := TdxPSPDFReportExportOptions.Create;
    try
      Options.Author := '';
      Options.Creator := '';
      Options.Keywords := '';
      Options.Subject := '';
      Options.Title := '';
      //
      Options.CompressStreams := true;
      Options.DefaultFileName := FileName;
      Options.OpenDocumentAfterExport := false; //
      // Options.SecurityOptions
      // Options.SignatureOptions

      Options.EmbedFonts := true;
      Options.UseCIDFonts := true;
      Options.UseJPEGCompression := true;

      StartWait('Attendere...', true);
      try
        Printer.ExportToPDF(FileName, false, Options);
      finally
        StopWait;
      end;
    finally
      FreeAndNil(Options);
    end;

    if not silent then
      ConfirmOk('File ' + ExtractFileName(FileName) + ' generato.');
  finally
    Pdf.Enabled := true;
  end;
end;

procedure THelpGenEditor.ForceFileFolder(const FileName: string);
var
  folder: string;
begin
  folder := extractFilePath(FileName);
  folder := IncludeTrailingPathDelimiter(folder);
  try
    ForceDirectories(extractFilePath(folder));
  except
  end;
end;

procedure THelpGenEditor.SaveAsBeforeExecute(Sender: TObject);
var
  folder: string;
begin
  folder := zHelpConfig.HelpFolder + HelpSubject.HelpFolder;

  try
    ForceDirectories(folder);
  except
  end;

  SetCurrentDir(folder);
end;

procedure THelpGenEditor.GeneraHelpDefault;
  procedure AddParagraph(const styleName: string);
  var
    paragraph: IdxRichEditParagraph;
    style: IdxRichEditParagraphStyle;
  begin
    paragraph := dxRichEditControl.Document.AppendParagraph;

    style := dxRichEditControl.Document.ParagraphStyles[styleName];
    if assigned(style) then
      paragraph.style := style
    else
      ConfirmOk('Stile ' + styleName + ' non trovato');

    paragraph.PageBreakBefore := false;
    paragraph.Alignment := TdxParagraphAlignment.left;
  end;

  procedure AddText(const text: string; const AddNewLine: Boolean = true);
  begin
    dxRichEditControl.Document.AppendSingleLineText(text);

    if AddNewLine then
      dxRichEditControl.Document.AppendSingleLineText(TdxCharacters.LineBreak);
  end;

  procedure NewLine;
  begin
    dxRichEditControl.Document.AppendSingleLineText(TdxCharacters.LineBreak);
  end;

  procedure AddImage(dxSmartImage: TdxSmartImage);
  var
    image: IdxRichEditDocumentImage;
    MaxWidth: single;
  begin
    image := dxRichEditControl.Document.AppendImage(dxSmartImage);

    MaxWidth := dxRichEditControl.Document.Sections[0].Page.Width - dxRichEditControl.Document.Sections[0].Margins.left - dxRichEditControl.Document.Sections[0].Margins.Right;
    if image.Size.cx > MaxWidth then
    begin
      image.ScaleX := MaxWidth / image.Size.cx;
      image.ScaleY := image.ScaleX;
    end;
  end;

  procedure AddAction(table: IdxRichEditTable; const Row: Integer; Action: TContainedAction);
  var
    bmp: TBitmap;
    ImageList: TCustomImageList;

    procedure ResetMargins(paragraph: IdxRichEditParagraph);
    var
      section: IdxRichEditSection;
    begin
      section := dxRichEditControl.Document.GetSection(paragraph.Range.Start);
      section.Margins.Top := 0;
      section.Margins.left := 0;
      section.Margins.Right := 0;
      section.Margins.Bottom := 0;
    end;

    procedure AddCellText(const Row, col: Integer; const text: string; const WordWrap: Boolean);
    var
      Range: IdxRichEditDocumentRange;
      paragraph: IdxRichEditParagraph;
      // cell:TdxTableCell;
    begin
      Range := dxRichEditControl.Document.InsertText(table.Cell(Row, col).Range.Start, text);
      table.Cell(Row, col).WordWrap := WordWrap;
      table.Cell(Row, col).VerticalAlignment := TdxRichEditTableCellVerticalAlignment.Center;

      table.Cell(Row, col).LeftPadding := 0.2;
      table.Cell(Row, col).RightPadding := 0;
      table.Cell(Row, col).TopPadding := 0.2;
      table.Cell(Row, col).BottomPadding := 0;

      paragraph := dxRichEditControl.Document.GetParagraph(Range.Start);
      paragraph.SpacingBefore := 0;
      paragraph.SpacingAfter := 0;
      paragraph.LineSpacingRule := TdxRichEditParagraphLineSpacing.Single;
    end;

  var
    Range: IdxRichEditDocumentRange;
    paragraph: IdxRichEditParagraph;
  begin
    // immagine posizione 0
    if Action.ImageIndex <> -1 then
      if Action is TCustomAction then
      begin
        ImageList := TCustomAction(Action).Images;

        if assigned(ImageList) then
          if Action.ImageIndex <= ImageList.Count - 1 then
          begin
            bmp := TBitmap.Create;
            try
              bmp.PixelFormat := pf32bit;
              bmp.AlphaFormat := afIgnored;
              ImageList.GetBitmap(Action.ImageIndex, bmp);
              Range := dxRichEditControl.Document.InsertImage(table.Cell(Row, 0).Range.Start, bmp).Range;

              paragraph := dxRichEditControl.Document.GetParagraph(Range.Start);
              paragraph.SpacingBefore := 0;
              paragraph.SpacingAfter := 0;
              table.Cell(Row, 0).LeftPadding := 0;
              table.Cell(Row, 0).RightPadding := 0;
              table.Cell(Row, 0).TopPadding := 0;
              table.Cell(Row, 0).BottomPadding := 0;

              paragraph.LineSpacingRule := TdxRichEditParagraphLineSpacing.Single;
              table.Cell(Row, 0).VerticalAlignment := TdxRichEditTableCellVerticalAlignment.Center;
            finally
              FreeAndNil(bmp);
            end;
          end;
      end;

    AddCellText(Row, 1, Action.Caption, false);
    AddCellText(Row, 2, ShortCutToText(Action.ShortCut), false);

    if Action.Hint.IsEmpty then
      AddCellText(Row, 3, Action.Caption, true)
    else
      AddCellText(Row, 3, Action.Hint, true);
  end;

  function CreateTable(const RowCount: Integer): IdxRichEditTable;
  var
    borderStyle: TdxRichEditTableBorderLineStyle;
  begin
    borderStyle := TdxRichEditTableBorderLineStyle.Dotted;

    result := dxRichEditControl.Document.Tables.Add(dxRichEditControl.Document.CaretPosition, RowCount, 4);

    result.Borders.InsideHorizontalBorder.LineStyle := borderStyle;
    result.Borders.InsideVerticalBorder.LineStyle := borderStyle;

    result.Borders.Top.LineStyle := borderStyle;
    result.Borders.left.LineStyle := borderStyle;
    result.Borders.Right.LineStyle := borderStyle;
    result.Borders.Bottom.LineStyle := borderStyle;
  end;

  function AddActions(Actions: TList<TContainedAction>): IdxRichEditTable;
  var
    Action: TContainedAction;
    Row: Integer;
  begin
    result := CreateTable(Actions.Count);

    Row := 0;

    for Action in Actions do
    begin
      AddAction(result, Row, Action);
      inc(Row);
    end;
  end;

var
  dxSmartImage: TdxSmartImage;
  table: IdxRichEditTable;
  Actions: TList<TContainedAction>;
begin

  if FileExists(zHelpConfig.TemplateFileName) then
    dxRichEditControl.Document.LoadDocument(zHelpConfig.TemplateFileName, TdxRichEditDocumentFormat.Undefined);

  dxRichEditControl.Options.DocumentSaveOptions.CurrentFileName := HelpFileName;
  dxRichEditControl.Options.DocumentSaveOptions.CurrentFormat := dxRichEditControl.DocumentModel.AutodetectDocumentFormat(HelpFileName);

  /// //////////////////////////////////////////////////////////////////////////
  // Titolo
  AddParagraph('Title');
  AddText(HelpSubject.HelpCaption, false);

  /// //////////////////////////////////////////////////////////////////////////
  // Breve descrizione
  AddParagraph('Normal');
  AddText('Breve descrizione'); { TODO : recuperare da AI }

  // Esempio di request:
  // Genera una breve descrizione in italiano (max 50 parole)
  // destinata ad essere inclusa in un manuale di un gestionale
  // destinato ai centri di formazione per il modulo gestione risorse.
  //
  // Le voci di menù realmente disponibili saranno:
  //
  // Risorse
  // Designazioni d'incarico
  // Incarichi Di Massima
  // Contratti
  // ....
  //
  /// //////////////////////////////////////////////////////////////////////////
  // Immagine
  AddParagraph('Normal');
  dxSmartImage := TdxSmartImage.Create;
  try
    // dxSmartImage.LoadFromFile(ImageFileName);
    dxSmartImage.assign(HelpSubject.HelpScreenShot);
    AddImage(dxSmartImage);
  finally
    FreeAndNil(dxSmartImage);
  end;

  NewLine;
  /// //////////////////////////////////////////////////////////////////////////
  // Descrizione estesa
  AddParagraph('Normal');
  AddText('Descrizione estesa'); { TODO : recuperare da AI; provare a passare la descrizione breve }

  // Esempio di request:
  // Espandi questo testo:
  // @ incollare la descrizione breve ricavata precedentemente
  // "Il modulo Gestione Risorse centralizza l'amministrazione del personale, docenti, fornitori e aziende partner. Gestisce contratti, incarichi, rilevamento presenze, competenze e autorizzazioni. Include funzioni di monitoraggio costi, controllo ore, valutazioni prestazioni e reportistica completa. Permette l'importazione dati e la gestione di convenzioni, tirocini e disponibilità aziendali."
  //
  // Questo testo è destinata ad essere inclusa inun manuale di un gestionale destinato ai centri di formazione.
  // Sono richieste da 200 a 250 parole. Non suddividere in sottosezioni.
  //
  // Le voci di menù realmente disponibili saranno:
  // Risorse
  // Designazioni d'incarico
  // Incarichi Di Massima
  // Contratti
  // ....
  //
  /// //////////////////////////////////////////////////////////////////////////
  /// PageControlController.Enum()
  HelpSubject.HelpInitGen; // nasconde le azioni Admin
  try
    // aggiungere Azioni
    Actions := TList<TContainedAction>.Create;
    try
      HelpSubject.HelpEnumActions(Actions);

      if Actions.Count > 0 then
      begin
        AddParagraph('Subtitle');
        AddText('Azioni', false);

        AddParagraph('Normal');
        table := AddActions(Actions);
        NewLine;
      end;
    finally
      FreeAndNil(Actions);
    end;
  finally
    HelpSubject.HelpDoneGen;
  end;

  /// //////////////////////////////////////////////////////////////////////////
  // Aggiungere "Come fare per"
  AddParagraph('Subtitle');
  AddText('Come fare per', false);
  AddParagraph('Normal');

  ImagesResize;
  /// //////////////////////////////////////////////////////////////////////////
end;

procedure THelpGenEditor.GeneraHelpClaude;
begin

  if FileExists(zHelpConfig.TemplateFileName) then
    dxRichEditControl.Document.LoadDocument(zHelpConfig.TemplateFileName, TdxRichEditDocumentFormat.Undefined);

  dxRichEditControl.Options.DocumentSaveOptions.CurrentFileName := HelpFileName;
  dxRichEditControl.Options.DocumentSaveOptions.CurrentFormat := dxRichEditControl.DocumentModel.AutodetectDocumentFormat(HelpFileName);
end;

procedure THelpGenEditor.CompilaCHMExecute(Sender: TObject);
var
  Compiler: THelpGenCompiler;
begin
  StartWait('Attendere...', true);
  try
    CompilaCHM.Enabled := false;
    try
      Compiler := THelpGenCompiler.Create(zHelpConfig.HelpFolder, zHelpConfig.HelpGenWorkingFolder);
      try
        Compiler.ProjectName := TPath.GetFileNameWithoutExtension(Application.ExeName);
        Compiler.Title := Application.Title;
        Compiler.DefaultTopic := 'index';

        // Compiler.logProc := procedure(s: string)
        // begin
        // memoLog.Lines.Add(s);
        // end;

        Compiler.GenerateFilesCHM;
        Compiler.CompileCHM;
      finally
        FreeAndNil(Compiler);
      end;
    finally
      CompilaCHM.Enabled := true;
    end;
  finally
    StopWait;
  end;
end;

procedure THelpGenEditor.CopiaFileCHMExecute(Sender: TObject);
var
  Compiler: THelpGenCompiler;
begin
  CopiaFileCHM.Enabled := false;
  try

    if not ConfirmOkCancel('Si desidera copiare il file CHM?') then
      exit;

    Compiler := THelpGenCompiler.Create(zHelpConfig.HelpFolder, zHelpConfig.HelpGenWorkingFolder);
    try
      Compiler.ProjectName := TPath.GetFileNameWithoutExtension(Application.ExeName);
      Compiler.Title := Application.Title;
      Compiler.DefaultTopic := 'index';

      StartWait('Attendere...', true);
      try
        Compiler.DeployCHM;
      finally
        StopWait;
      end;
    finally
      FreeAndNil(Compiler);
    end;

    ConfirmOk('File copiato.');
  finally
    CopiaFileCHM.Enabled := true;
  end;
end;

// Servizio AI della guida, creato al primo uso. Legge la propria
// configurazione (fornitore, modello, chiave) da HelpGen_AI.ini, nella stessa
// cartella dei modelli di richiesta: se il file non c'e' viene creato con i
// predefiniti, cosi' si vede subito dove mettere la chiave
function THelpGenEditor.HelpGenAI: TzHelpGenAI;
begin

  if not assigned(FHelpGenAI) then
  begin
    FHelpGenAI := TzHelpGenAI.Create(Self);
    FHelpGenAI.OnProcessingStart := HelpGenAIProcessingStart;
    FHelpGenAI.OnDocumentazione := HelpGenAIDocumentazione;
    FHelpGenAI.OnTestoElaborato := HelpGenAITestoElaborato;
    FHelpGenAI.OnError := HelpGenAIError;
  end;

  result := FHelpGenAI;
end;

procedure THelpGenEditor.GeneraGuidaExecute(Sender: TObject);
begin

  if not assigned(HelpSubject) then
    exit;

  // Una generazione alla volta: la seconda sovrascriverebbe il documento
  // mentre la prima e' ancora in volo
  if HelpGenAI.ResponseInProgress then
  begin
    ConfirmOk('Generazione della guida gia'' in corso.');
    exit;
  end;

  ProgressBox.Caption := 'Generazione Guida';
  ProgressBox.FirstLabel := 'Creazione della richiesta';
  ProgressBox.SecondLabel := 'Attendere...';
  ProgressBox.CancelEnabled := false;
  ProgressBox.Show;
  ProgressBox.ProgressDlg.ProgressBar.Properties.Marquee := true;
  Application.ProcessMessages;

  // Asincrona: il seguito sta in HelpGenAIDocumentazione o in HelpGenAIError,
  // che chiudono la finestra di attesa. Se la richiesta non parte nemmeno,
  // l'errore e' gia' passato da HelpGenAIError
  HelpGenAI.Richiedi(HelpSubject);
end;

procedure THelpGenEditor.HelpGenAIProcessingStart(Sender: TObject);
begin
  ProgressBox.FirstLabel := 'Attesa della risposta di ' + HelpGenAI.Configuration.DriverName;
  Application.ProcessMessages;
end;

procedure THelpGenEditor.HelpGenAIDocumentazione(Sender: TObject; Documentazione: THelpGenResponseDocumentazione);
var
  HelpGenGenerator: THelpGenGenerator;
begin
  ProgressBox.ProgressDlg.ProgressBar.Properties.Marquee := false;
  ProgressBox.Close;

  HelpGenGenerator.GeneraDocumentazione(dxRichEditControl, HelpSubject, Documentazione);

  doSalvaHelpFile;
  ExportPDF(true);
  dxRichEditControl.DocumentModelModified;
end;

procedure THelpGenEditor.HelpGenAIError(Sender: TObject; const ErrorMessage: string);
begin
  ProgressBox.ProgressDlg.ProgressBar.Properties.Marquee := false;
  ProgressBox.Close;
  FTargetRange := nil;

  // La risposta grezza resta in Response_Raw_<modulo>.txt nella cartella dei
  // modelli: e' li' che si guarda quando il JSON non torna
  ConfirmOk('Operazione del servizio AI non riuscita.' + sLineBreak + sLineBreak + ErrorMessage, mtError);
end;

procedure THelpGenEditor.InizializzaMenuAI;
var
  SubItemAI: TdxBarSubItem;

  procedure AggiungiComando(const ACaption: string; AAzione: THelpGenAIAzioneTesto; AShortCut: TShortCut);
  var
    Btn: TdxBarButton;
  begin
    Btn := TdxBarButton.Create(Self);
    Btn.Caption := ACaption;
    Btn.Tag := Ord(AAzione);
    Btn.OnClick := DoAIAzioneTestoClick;
    if AShortCut <> 0 then
      Btn.ShortCut := AShortCut;
    // TdxBarButton si registra da se' nel BarManager alla Create(Owner):
    // Items e' una property indicizzata di sola lettura, non ha .Add
    SubItemAI.ItemLinks.Add(Btn);
  end;

begin
  SubItemAI := TdxBarSubItem.Create(Self);
  SubItemAI.Caption := 'Assistente AI';
  // Idem per il sotto-menu: nessun .Items.Add, solo il collegamento alla barra
  dxBarManagerBarGenera.ItemLinks.Add(SubItemAI);

  AggiungiComando('Migliora / Riscrivi testo', atRiscrivi, 0);
  AggiungiComando('Espandi spiegazione', atEspandi, 0);
  AggiungiComando('Sintetizza testo', atSintetizza, 0);
  AggiungiComando('Formula note e avvertenze', atNoteAvvertenza, 0);
  AggiungiComando('Correggi grammatica e stile', atCorreggi, 0);
  AggiungiComando('Istruzione personalizzata...', atPromptLibero, Vcl.Menus.ShortCut(Ord('A'), [ssCtrl, ssShift]));
end;

procedure THelpGenEditor.DoAIAzioneTestoClick(Sender: TObject);
begin
  if (Sender is TComponent) and (TComponent(Sender).Tag >= Ord(Low(THelpGenAIAzioneTesto))) and (TComponent(Sender).Tag <= Ord(High(THelpGenAIAzioneTesto))) then
  begin
    EseguiAzioneAITesto(THelpGenAIAzioneTesto(TComponent(Sender).Tag));
  end;
end;

procedure THelpGenEditor.EseguiAzioneAITesto(AAzione: THelpGenAIAzioneTesto; const AIstruzione: string = '');
var
  TestoDaElaborare: string;
  Istruzione: string;
  Argomento: string;
begin
  if HelpGenAI.ResponseInProgress then
  begin
    ConfirmOk('Elaborazione AI gia'' in corso.');
    exit;
  end;

  FHadSelection := (dxRichEditControl.Document.Selections.Count > 0) and (dxRichEditControl.Document.Selection.Length > 0);

  if FHadSelection then
  begin
    FTargetRange := dxRichEditControl.Document.Selection;
    TestoDaElaborare := dxRichEditControl.Document.GetText(FTargetRange);
  end
  else
  begin
    FTargetRange := nil;
    TestoDaElaborare := '';
  end;

  if (not FHadSelection) and (AAzione in [atRiscrivi, atEspandi, atSintetizza, atCorreggi]) then
  begin
    ConfirmOk('Selezionare prima il testo del documento da elaborare con l''assistente AI.');
    exit;
  end;

  if AAzione = atPromptLibero then
  begin
    Istruzione := AIstruzione;
    if Istruzione.IsEmpty then
    begin
      if not InputQuery('Assistente AI - Istruzione personalizzata', 'Specificare l''istruzione per l''assistente AI (sul testo selezionato o per generare nuovo testo):', Istruzione) then
        exit;
      if Istruzione.Trim.IsEmpty then
        exit;
    end;

    ProgressBox.Caption := 'Assistente AI';
    ProgressBox.FirstLabel := 'Elaborazione istruzione personalizzata...';
    ProgressBox.SecondLabel := 'Attendere...';
    ProgressBox.CancelEnabled := false;
    ProgressBox.Show;
    ProgressBox.ProgressDlg.ProgressBar.Properties.Marquee := true;
    Application.ProcessMessages;

    HelpGenAI.ElaboraTesto(TestoDaElaborare, AAzione, Istruzione);
    exit;
  end;

  if (not FHadSelection) and (AAzione = atNoteAvvertenza) then
  begin
    Argomento := '';
    if not InputQuery('Assistente AI - Nota / Avvertenza', 'Inserire l''argomento o il contesto della nota di avvertenza:', Argomento) then
      exit;
    if Argomento.Trim.IsEmpty then
      exit;
    TestoDaElaborare := Argomento;
  end;

  ProgressBox.Caption := 'Assistente AI';
  ProgressBox.FirstLabel := 'Elaborazione testo in corso...';
  ProgressBox.SecondLabel := 'Attendere...';
  ProgressBox.CancelEnabled := false;
  ProgressBox.Show;
  ProgressBox.ProgressDlg.ProgressBar.Properties.Marquee := true;
  Application.ProcessMessages;

  HelpGenAI.ElaboraTesto(TestoDaElaborare, AAzione, AIstruzione);
end;

procedure THelpGenEditor.HelpGenAITestoElaborato(Sender: TObject; const TestoElaborato: string);
begin
  ProgressBox.ProgressDlg.ProgressBar.Properties.Marquee := false;
  ProgressBox.Close;

  if TestoElaborato.Trim.IsEmpty then
  begin
    FTargetRange := nil;
    exit;
  end;

  dxRichEditControl.Document.BeginUpdate;
  try
    if FHadSelection and assigned(FTargetRange) and (FTargetRange.Length > 0) then
    begin
      dxRichEditControl.Document.Replace(FTargetRange, TestoElaborato);
    end
    else
    begin
      dxRichEditControl.Document.InsertText(dxRichEditControl.Document.CaretPosition, TestoElaborato);
    end;
  finally
    dxRichEditControl.Document.EndUpdate;
    FTargetRange := nil;
  end;

  dxRichEditControl.DocumentModelModified := true;
end;

end.
