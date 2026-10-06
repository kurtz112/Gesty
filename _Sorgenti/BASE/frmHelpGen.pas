unit frmHelpGen;

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
  zRestrictions,
  zReports,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  dxPScxTLLnk,
  dxPScxSchedulerLnk,
  dxPSdxSpreadSheetLnk,
  dxRichEdit.DocumentModel.RichEditDocumentServer,
  dxRichEdit.DocumentModel.ParagraphFormatting,
  dxCharacters,
  BaseFrm,
  cxSpinEdit,
  dxUIAClasses;

type
  TFormHelpGen = class(TdxRibbonForm)
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
    SalvaTemplate: TAction;
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
    OpenAI: TAction;
    dxBarManagerBar2: TdxBar;
    dxBarLargeButton12: TdxBarLargeButton;
    procedure actNovitaExecute(Sender: TObject);
    procedure ApriCartellaExecute(Sender: TObject);
    procedure ApriConWordExecute(Sender: TObject);
    procedure ChiudiExecute(Sender: TObject);
    procedure dxRichEditControlActiveViewChanged(Sender: TObject);
    procedure dxRichEditControlContentChanged(Sender: TObject);
    procedure dxRichEditControlSelectionChanged(Sender: TObject);
    procedure dxRichEditControlZoomChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveAsAccept(Sender: TObject);
    procedure tbZoomPropertiesChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OpenAIExecute(Sender: TObject);
    procedure SalvaTemplateExecute(Sender: TObject);
    procedure SalvaTemplateUpdate(Sender: TObject);
  private
    procedure UpdateZoom;
    procedure ImagesResize;
    procedure UpdateRibbonContexstsStates;
    procedure InitHints;
  private
  private
    FBaseForm: TBaseForm;
    FHelpFileName: String;
    FHelpFolder: String;
    FTemplateFileName: string;
    RestrictionManager: TRestrictionManager;
    function GetRestrictionManager: TRestrictionManager;
  private
    function GeneraFileName(HelpFileName: string): string;
    procedure GeneraHelpDefault;
    procedure doSalvaHelpFile;
  public
    constructor Create(aOwner: TComponent); Override;
  public
    procedure GeneraHelp(const aHelpFileName: string; BaseForm: TBaseForm);
    procedure Novita;

    property BaseForm: TBaseForm read FBaseForm;

    property HelpFileName: String read FHelpFileName;
    property HelpFolder: String read FHelpFolder;
    property TemplateFileName: string read FTemplateFileName;
  end;

var
  FormHelpGen: TFormHelpGen;

procedure GeneraHelp(const HelpFileName: string; BaseForm: TBaseForm);
procedure Novita;

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
  frmOpenAI;

{$R *.dfm}

type
  TdxRichEditControlAccess = class(TdxRichEditControl);

procedure GeneraHelp(const HelpFileName: string; BaseForm: TBaseForm);
begin

  if not assigned(FormHelpGen) then
    Application.CreateForm(TFormHelpGen, FormHelpGen);

  FormHelpGen.GeneraHelp(HelpFileName, BaseForm);
end;

procedure Novita;
begin
  { TODO : Pulsante per aggiungere una novità }

  if not assigned(FormHelpGen) then
    Application.CreateForm(TFormHelpGen, FormHelpGen);

  FormHelpGen.Novita;
end;

constructor TFormHelpGen.Create(aOwner: TComponent);
var
  TemplateFolder: string;
begin
  inherited;
  FBaseForm := nil;
  FHelpFileName := '';

  dx.InitLayoutControl(dxLayoutControl);
  dx.InitPrinter(Printer);

  FHelpFolder := config.zSystem.rootFolder('DOCUMENTAZIONE', 'Documentazione');
  TemplateFolder := config.zSystem.rootFolder('DOCUMENTAZIONE_TEMPLATE', 'Documentazione Template');
  FTemplateFileName := TemplateFolder + 'Template documentazione.docx';

  try
    ForceDirectories(HelpFolder);
    ForceDirectories(TemplateFolder);
  except
  end;
end;

procedure TFormHelpGen.UpdateZoom;
begin
  if dxRichEditControl.ActiveView.ZoomFactor > 5 then
    dxRichEditControl.ActiveView.ZoomFactor := 5;
  tbZoom.Position := Round(dxRichEditControl.ActiveView.ZoomFactor * 100);
end;

procedure TFormHelpGen.tbZoomPropertiesChange(Sender: TObject);
begin
  bsZoom.Caption := Format('%3d %%', [tbZoom.Position]);
  dxRichEditControl.ActiveView.ZoomFactor := tbZoom.Position / 100;
end;

procedure TFormHelpGen.dxRichEditControlActiveViewChanged(Sender: TObject);
begin
  UpdateZoom;
end;

procedure TFormHelpGen.dxRichEditControlZoomChanged(Sender: TObject);
begin
  UpdateZoom;
end;

procedure TFormHelpGen.dxRichEditControlContentChanged(Sender: TObject);
begin
  // bbCursorLine.Caption := 'Linea: ' + dxRichEditControl.ActiveView.CaretPosition.LayoutPosition.Row.LineNumber.ToString;
  // bbCursorColumn.Caption := 'Colonna: ' +   dxRichEditControl.ActiveView.CaretPosition.LayoutPosition.Column.colLineNumber.ToString;
end;

procedure TFormHelpGen.dxRichEditControlSelectionChanged(Sender: TObject);
begin
  UpdateRibbonContexstsStates;
  // bbCursorLine.Caption := 'Linea: ' + dxRichEditControl.ActiveView.CaretPosition.LayoutPosition.Row.LineNumber.ToString;
  // bbCursorColumn.Caption := 'Colonna: ' + dxRichEditControl.ActiveView.CaretPosition.LayoutPosition.Column.colLineNumber.ToString;
  // bbCursorColumn.Caption := 'Colonna: ' + dxRichEditControl.ActiveView.CaretPosition.LayoutPosition.LeftOffset.ToString;
end;

procedure TFormHelpGen.FormShow(Sender: TObject);
begin
  //

  if dx.SkinActive then
    dxRibbon.ColorSchemeName := 'UserSkin'
  else
    // dxRibbon.ColorSchemeName := 'Colorful';
    dxRibbon.ColorSchemeName := 'White';
end;

procedure TFormHelpGen.SaveAsAccept(Sender: TObject);
begin
  FHelpFileName := SaveAs.Dialog.FileName;
  dxRichEditControl.SaveDocument(HelpFileName);

  dxRichEditControl.Options.DocumentSaveOptions.CurrentFileName := HelpFileName;
  dxRichEditControl.Options.DocumentSaveOptions.CurrentFormat := dxRichEditControl.DocumentModel.AutodetectDocumentFormat(HelpFileName);
end;

procedure TFormHelpGen.ApriCartellaExecute(Sender: TObject);
begin
  ShellExecute(0, PCHAR('open'), PCHAR(ExtractFilePath(HelpFileName)), nil, nil, SW_RESTORE);
end;

procedure TFormHelpGen.ApriConWordExecute(Sender: TObject);
begin
  doSalvaHelpFile;
  ShellExecute(0, PCHAR('open'), PCHAR(HelpFileName), nil, nil, SW_RESTORE);
end;

procedure TFormHelpGen.ChiudiExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormHelpGen.doSalvaHelpFile;
var
  backupFile: string;
  backupFolder: string;
begin

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

procedure TFormHelpGen.ImagesResize;

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

procedure TFormHelpGen.SalvaTemplateExecute(Sender: TObject);
begin
  doSalvaHelpFile;
end;

procedure TFormHelpGen.SalvaTemplateUpdate(Sender: TObject);
begin
  SalvaTemplate.Enabled := dxRichEditControl.DocumentModelModified;
end;

procedure TFormHelpGen.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;

  if dxRichEditControl.DocumentModelModified then
  begin
    case MessageDlg('Salvo le modifiche al template?', mtInformation, [mbYes, mbNo, mbCancel], 0) of
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

function TFormHelpGen.GetRestrictionManager: TRestrictionManager;
begin
  result := RestrictionManager;
end;

procedure TFormHelpGen.UpdateRibbonContexstsStates;
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
  SetRibbonContext('Mail Merge', true); // Config.IsAdmin); // { TODO : vedere }
  SetRibbonContext('Sistema', config.IsAdmin);
end;

procedure TFormHelpGen.InitHints;
begin

  ForEach<TContainedAction>(
    procedure(Action: TContainedAction)
    begin
      Action.Hint := '';
    end);
end;

function TFormHelpGen.GeneraFileName(HelpFileName: string): string;
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

  result := IncludeTrailingPathDelimiter(HelpFolder) + result + '.docx';
end;

procedure TFormHelpGen.GeneraHelpDefault;
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

  if not FileExists(TemplateFileName) then
    raise Exception.Create('File ' + TemplateFileName + ' non trovato.');

  dxRichEditControl.Document.LoadDocument(TemplateFileName, TdxRichEditDocumentFormat.Undefined);
  dxRichEditControl.Options.DocumentSaveOptions.CurrentFileName := HelpFileName;
  dxRichEditControl.Options.DocumentSaveOptions.CurrentFormat := dxRichEditControl.DocumentModel.AutodetectDocumentFormat(HelpFileName);

  AddParagraph('Title');
  AddText(BaseForm.Caption, false);

  AddParagraph('Normal');
  AddText('Breve descrizione');
  // Immagine (RIDIMENSIONARE)
  AddParagraph('Normal');
  dxSmartImage := TdxSmartImage.Create;
  try
    // dxSmartImage.LoadFromFile(ImageFileName);
    dxSmartImage.assign(BaseForm.ScreenShot);
    AddImage(dxSmartImage);
  finally
    FreeAndNil(dxSmartImage);
  end;
  NewLine;

  AddParagraph('Normal');
  AddText('Descrizione estesa');

  // aggiungere Azioni
  Actions := TList<TContainedAction>.Create;
  try
    BaseForm.EnumActionsForHelp(Actions);

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
  // Aggiungere "Come fare per"
  AddParagraph('Subtitle');
  AddText('Come fare per', false);
  AddParagraph('Normal');

  ImagesResize;
end;

procedure TFormHelpGen.GeneraHelp(const aHelpFileName: string; BaseForm: TBaseForm);
begin
  // https://docs.devexpress.com/WindowsForms/9709/controls-and-libraries/rich-text-editor/fields/field-codes

  /// /////////////////////////////
  dxBarManagerBarNovita.Visible := false;
  actNovita.Visible := false;

  FBaseForm := BaseForm;
  FHelpFileName := GeneraFileName(aHelpFileName);

  if FileExists(HelpFileName) then
    dxRichEditControl.Document.LoadDocument(HelpFileName, TdxRichEditDocumentFormat.Undefined)
  else
    GeneraHelpDefault;

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

procedure TFormHelpGen.Novita;
begin
  dxBarManagerBarNovita.Visible := true;
  actNovita.Visible := true;

  FBaseForm := nil;
  FHelpFileName := GeneraFileName('Gesty - Novità');

  if FileExists(HelpFileName) then
    dxRichEditControl.Document.LoadDocument(HelpFileName, TdxRichEditDocumentFormat.Undefined)
  else
    dxRichEditControl.Document.LoadDocument(TemplateFileName, TdxRichEditDocumentFormat.Undefined);

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

procedure TFormHelpGen.actNovitaExecute(Sender: TObject);
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

procedure TFormHelpGen.OpenAIExecute(Sender: TObject);
var
  s: string;
begin
  dxRichEditControl.Copy;

  s := Clipboard.AsText;

  if not s.IsEmpty then
    if ExecuteOpenAI(s) then
    begin
      Clipboard.AsText := s;
      dxRichEditControl.Paste;
    end;
end;

end.zSystem
