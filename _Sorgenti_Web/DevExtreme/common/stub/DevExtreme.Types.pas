unit DevExtreme.Types;

interface

uses
  System.SysUtils,
  System.Classes,
  Types,
  jsdelphisystem,
  js,
  web;

type
  TdxEventHandler = function(e: TJSObject): boolean of object;
  TdxEventHandlerFunc = Reference to function(e: TJSObject): JSValue;
  TdxInitOptionsProc = Reference to Procedure(options: TJSObject);
  TdxOkCancelProc = Reference to Procedure(closeProc: TProc);
  TEditOptionsReturnProc = Reference to Procedure(options: TJSObject; callBack: TProc);
  TEditSqlReturnProc = Reference to Procedure(sql: string; callBack: TProc);

  TdxApplyValueMode = (avmInstantly, avmUseButtons);
  TdxButtonStyle = (bsContained, bsOutlined, bsText);
  TdxButtonType = (btBack, btDanger, btDefault, btNormal, btSuccess);
  TdxDataStructure = (dsPlain, dsTree);
  TdxDataType = (dtBoolean, dtDate, dtDatetime, dtNumber, dtObject, dtString);
  TdxDirection = (dBottom, dLeft, dRight, dTop);
  TdxDragDirection = (ddBoth, ddHorizontal, ddVertical);
  TdxDragHighlight = (dhIndicate, dhPush);
  TdxEditorStyle = (esFilled, esOutlined, esUnderlined);
  TdxExportFormat = (efGIF, efJPEG, efPDF, efPNG, efSVG);
  TdxFieldChooserLayout = (fcl0, fcl1, fcl2);
  TdxFirstDayOfWeek = (fdow0, fdow1, fdow2, fdow3, fdow4, fdow5, fdow6);
  TdxFloatingActionButtonDirection = (fabdAuto, fabdDown, fabdUp);
  TdxFormat = (fBillions, fCurrency, fDay, fDayOfWeek, fDecimal, fExponential, fFixedPoint, fHour, fLargeNumber, fLongDate, fLongDateLongTime, fLongTime, fMillions, fMillisecond, fMinute, fMonth,
    fMonthAndDay, fMonthAndYear, fPercent, fQuarter, fQuarterAndYear, fSecond, fShortDate, fShortDateShortTime, fShortTime, fThousands, fTrillions, fYear);
  TdxHorizontalAlignment = (haCenter, haLeft, haRight);
  TdxHorizontalEdge = (heLeft, heRight);
  TdxLabelMode = (lmFloating, lmHidden, lmStatic);
  TdxMaskMode = (mmAlways, mmOnFocus);
  TdxMode = (mAuto);
  TdxOrientation = (oHorizontal, oVertical);
  TdxPageLoadMode = (plmNextButton, plmScrollBottom);
  TdxPageOrientation = (poLandscape, poPortrait);
  TdxPosition = (pBottom, pLeft, pRight, pTop);
  TdxPositionAlignment = (paBottom, paCenter, paLeft, paLeftbottom, paLefttop, paRight, paRightbottom, paRighttop, paTop);
  TdxScrollbarMode = (smAlways, smNever, smOnHover, smOnScroll);
  TdxScrollDirection = (sdBoth, sdHorizontal, sdVertical);
  TdxScrollMode = (smStandard, smVirtual);
  TdxSearchMode = (smContains, smEquals, smStartswith);
  TdxSelectAllMode = (samAllPages, samPage);
  TdxSimplifiedSearchMode = (ssmContains, ssmStartswith);
  TdxSingleMultipleAllOrNone = (smaonAll, smaonMultiple, smaonNone, smaonSingle);
  TdxSingleMultipleOrNone = (smonMultiple, smonNone, smonSingle);
  TdxSingleOrMultiple = (somMultiple, somSingle);
  TdxSingleOrNone = (sonNone, sonSingle);
  TdxSliderValueChangeMode = (svcmOnHandleMove, svcmOnHandleRelease);
  TdxSortOrder = (soAsc, soDesc);
  TdxStoreType = (stArray, stLocal, stOdata);
  TdxSubmenuShowMode = (ssmOnClick, ssmOnHover);
  TdxTextBoxPredefinedButton = (tbpbClear);
  TdxTextEditorButtonLocation = (teblAfter, teblBefore);
  TdxToolbarItemComponent = (ticDxAutocomplete, ticDxButton, ticDxButtonGroup, ticDxCheckBox, ticDxDateBox, ticDxDropDownButton, ticDxMenu, ticDxSelectBox, ticDxTabs, ticDxTextBox);
  TdxToolbarItemLocation = (tilAfter, tilBefore, tilCenter);
  TdxTooltipShowMode = (tsmAlways, tsmOnHover);
  TdxValidationMessageMode = (vmmAlways, vmmAuto);
  TdxValidationRuleType = (vrtAsync, vrtCompare, vrtCustom, vrtEmail, vrtNumeric, vrtPattern, vrtRange, vrtRequired, vrtStringLength);
  TdxValidationStatus = (vsInvalid, vsPending, vsValid);
  TdxVerticalAlignment = (vaBottom, vaCenter, vaTop);
  TdxVerticalEdge = (veBottom, veTop);
  TCollectionWidgetSelectionMode = (cwsmAll, cwsmMultiple, cwsmNone, cwsmSingle);
  TdxTextBoxType = (tbtEmail, tbtPassword, tbtSearch, tbtTel, tbtText, tbtUrl);
  TdxDropDownPredefinedButton = (ddpbClear, ddpbDropDown);
  TdxGaugeIndicatorType = (gitCircle, gitRangeBar, gitRectangle, gitRectangleNeedle, gitRhombus, gitTextCloud, gitTriangleMarker, gitTriangleNeedle, gitTwoColorNeedle);
  TdxBoxDirection = (bdCol, bdRow);
  TdxCrosswiseDistribution = (cdCenter, cdEnd, cdStart, cdStretch);
  TdxDistribution = (dCenter, dEnd, dSpacearound, dSpacebetween, dStart);
  TdxCalendarZoomLevel = (czlCentury, czlDecade, czlMonth, czlYear);
  TdxWeekNumberRule = (wnrAuto, wnrFirstDay, wnrFirstFourDays, wnrFullWeek);
  TdxAggregatedPointsPosition = (appBetweenTicks, appCrossTicks);
  TdxChartBubbleSeriesAggregationMethod = (cbsamAvg, cbsamCustom);
  TdxChartFinancialSeriesAggregationMethod = (cfsamCustom, cfsamOhlc);
  TdxChartLabelDisplayMode = (cldmRotate, cldmStagger, cldmStandard);
  TdxChartRangeSeriesAggregationMethod = (crsamCustom, crsamRange);
  TdxChartSeriesAggregationMethod = (csamAvg, csamCount, csamCustom, csamMax, csamMin, csamOhlc, csamRange, csamSum);
  TdxChartSingleValueSeriesAggregationMethod = (csvsamAvg, csvsamCount, csvsamCustom, csvsamMax, csvsamMin, csvsamSum);
  TdxChartTooltipLocation = (ctlCenter, ctlEdge);
  TdxChartZoomAndPanMode = (czapmBoth, czapmNone, czapmPan, czapmZoom);
  TdxEventKeyModifier = (ekmAlt, ekmCtrl, ekmMeta, ekmShift);
  TdxFinancialChartReductionLevel = (fcrlClose, fcrlHigh, fcrlLow, fcrlOpen);
  TdxCircularGaugeElementOrientation = (cgeoCenter, cgeoInside, cgeoOutside);
  TdxCircularGaugeLabelOverlap = (cgloFirst, cgloLast);
  TdxContextSubmenuDirection = (csdAuto, csdLeft, csdRight);
  TdxDataGridCommandColumnType = (dgcctAdaptive, dgcctButtons, dgcctDetailExpand, dgcctDrag, dgcctGroupExpand, dgcctSelection);
  TdxDataGridExportFormat = (dgefPdf, dgefXlsx);
  TdxDataGridPredefinedColumnButton = (dgpcbCancel, dgpcbDelete, dgpcbEdit, dgpcbSave, dgpcbUndelete);
  TdxDataGridPredefinedToolbarItem = (dgptiAddRowButton, dgptiApplyFilterButton, dgptiColumnChooserButton, dgptiExportButton, dgptiGroupPanel, dgptiRevertButton, dgptiSaveButton, dgptiSearchPanel);
  TdxDataGridScrollMode = (dgsmInfinite, dgsmStandard, dgsmVirtual);
  TdxDatePickerType = (dptCalendar, dptList, dptNative, dptRollers);
  TdxDateType = (dttDate, dttDatetime, dttTime);
  TdxDiagramAutoZoomMode = (dazmDisabled, dazmFitContent, dazmFitWidth);
  TdxDiagramCommand = (dcBold, dcBringToFront, dcConnectorLineEnd, dcConnectorLineStart, dcConnectorLineType, dcCopy, dcCut, dcDelete, dcDeleteShapeImage, dcEditShapeImage, dcExportJpg, dcExportPng,
    dcExportSvg, dcFillColor, dcFontColor, dcFontName, dcFontSize, dcFullScreen, dcGridSize, dcInsertShapeImage, dcItalic, dcLayoutLayeredBottomToTop, dcLayoutLayeredLeftToRight,
    dcLayoutLayeredRightToLeft, dcLayoutLayeredTopToBottom, dcLayoutTreeBottomToTop, dcLayoutTreeLeftToRight, dcLayoutTreeRightToLeft, dcLayoutTreeTopToBottom, dcLineColor, dcLineStyle, dcLineWidth,
    dcLock, dcPageColor, dcPageOrientation, dcPageSize, dcPaste, dcRedo, dcSelectAll, dcSendToBack, dcSeparator, dcShowGrid, dcSimpleView, dcSnapToGrid, dcTextAlignCenter, dcTextAlignLeft,
    dcTextAlignRight, dcToolbox, dcUnderline, dcUndo, dcUnits, dcUnlock, dcZoomLevel);
  TdxDiagramConnectorLineEnd = (dcleArrow, dcleFilledTriangle, dcleNone, dcleOutlinedTriangle);
  TdxDiagramConnectorLineType = (dcltOrthogonal, dcltStraight);
  TdxDiagramConnectorPosition = (dcpEnd, dcpStart);
  TdxDiagramDataLayoutType = (ddltAuto, ddltLayered, ddltOff, ddltTree);
  TdxDiagramExportFormat = (defJpg, defPng, defSvg);
  TdxDiagramItemType = (ditConnector, ditShape);
  TdxDiagramModelOperation = (dmoAddShape, dmoAddShapeFromToolbox, dmoBeforeChangeConnectorText, dmoBeforeChangeShapeText, dmoChangeConnection, dmoChangeConnectorPoints, dmoChangeConnectorText,
    dmoChangeShapeText, dmoDeleteConnector, dmoDeleteShape, dmoMoveShape, dmoResizeShape);
  TdxDiagramPanelVisibility = (dpvAuto, dpvCollapsed, dpvDisabled, dpvVisible);
  TdxDiagramRequestEditOperationReason = (dreorCheckUIElementAvailability, dreorModelModification);
  TdxDiagramShapeCategory = (dscContainers, dscCustom, dscFlowchart, dscGeneral, dscOrgChart);
  TdxDiagramShapeType = (dstArrowBottom, dstArrowEastWest, dstArrowLeft, dstArrowNorthSouth, dstArrowRight, dstArrowTop, dstCardWithImageOnLeft, dstCardWithImageOnRight, dstCardWithImageOnTop,
    dstConnector, dstCross, dstData, dstDatabase, dstDecision, dstDelay, dstDiamond, dstDisplay, dstDocument, dstEllipse, dstHardDisk, dstHeart, dstHexagon, dstHorizontalContainer, dstInternalStorage,
    dstManualInput, dstManualOperation, dstMerge, dstMultipleDocuments, dstOctagon, dstOr, dstPaperTape, dstPentagon, dstPredefinedProcess, dstPreparation, dstProcess, dstRectangle, dstStar,
    dstStoredData, dstSummingJunction, dstTerminator, dstText, dstTriangle, dstVerticalContainer);
  TdxDiagramToolboxDisplayMode = (dtdmIcons, dtdmTexts);
  TdxDiagramUnits = (duCm, duIn, duPx);
  TdxOpenedStateMode = (osmOverlap, osmPush, osmShrink);
  TdxPanelLocation = (plAfter, plBefore, plBottom, plLeft, plRight, plTop);
  TdxRevealMode = (rmExpand, rmSlide);
  TdxDropDownBoxApplyValueMode = (ddbavmInstantly, ddbavmUseButtons);
  TdxFileManagerItemViewMode = (fmivmDetails, fmivmThumbnails);
  TdxFileManagerPredefinedContextMenuItem = (fmpcmiCopy, fmpcmiCreate, fmpcmiDelete, fmpcmiDownload, fmpcmiMove, fmpcmiRefresh, fmpcmiRename, fmpcmiUpload);
  TdxFileManagerPredefinedToolbarItem = (fmptiClearSelection, fmptiCopy, fmptiCreate, fmptiDelete, fmptiDownload, fmptiMove, fmptiRefresh, fmptiRename, fmptiSeparator, fmptiShowNavPane,
    fmptiSwitchView, fmptiUpload);
  TdxFileManagerViewArea = (fmvaItemView, fmvaNavPane);
  TdxFileUploadMode = (fumInstantly, fumUseButtons, fumUseForm);
  TdxUploadHttpMethod = (uhmPOST, uhmPUT);
  TdxGroupOperation = (goAnd, goNotAnd, goNotOr, goOr);
  TdxFormItemComponent = (ficDxAutocomplete, ficDxCalendar, ficDxCheckBox, ficDxColorBox, ficDxDateBox, ficDxDropDownBox, ficDxHtmlEditor, ficDxLookup, ficDxNumberBox, ficDxRadioGroup,
    ficDxRangeSlider, ficDxSelectBox, ficDxSlider, ficDxSwitch, ficDxTagBox, ficDxTextArea, ficDxTextBox);
  TdxFormItemType = (fitButton, fitEmpty, fitGroup, fitSimple, fitTabbed);
  TdxFormLabelMode = (flmFloating, flmHidden, flmOutside, flmStatic);
  TdxLabelLocation = (llLeft, llRight, llTop);
  TdxFunnelAlgorithm = (faDynamicHeight, faDynamicSlope);
  TdxGanttPdfExportDateRange = (gpedrAll, gpedrVisible);
  TdxGanttPdfExportMode = (gpemAll, gpemChart, gpemTreeList);
  TdxGanttPredefinedContextMenuItem = (gpcmiAddTask, gpcmiCollapseAll, gpcmiDeleteDependency, gpcmiDeleteTask, gpcmiExpandAll, gpcmiRedo, gpcmiResourceManager, gpcmiTaskDetails, gpcmiUndo,
    gpcmiZoomIn, gpcmiZoomOut);
  TdxGanttPredefinedToolbarItem = (gptiAddTask, gptiCollapseAll, gptiDeleteTask, gptiExpandAll, gptiFullScreen, gptiRedo, gptiResourceManager, gptiSeparator, gptiShowDependencies, gptiShowResources,
    gptiTaskDetails, gptiUndo, gptiZoomIn, gptiZoomOut);
  TdxGanttRenderScaleType = (grstDays, grstFiveYears, grstHours, grstMinutes, grstMonths, grstQuarters, grstSixHours, grstWeeks, grstYears);
  TdxGanttScaleType = (gstAuto, gstDays, gstHours, gstMinutes, gstMonths, gstQuarters, gstSixHours, gstWeeks, gstYears);
  TdxGanttTaskTitlePosition = (gttpInside, gttpNone, gttpOutside);
  TdxHtmlEditorFormat = (hefAlign, hefBackground, hefBlockquote, hefBold, hefCodeblock, hefColor, hefFont, hefHeader, hefIndent, hefItalic, hefLink, hefList, hefScript, hefSize, hefStrike,
    hefUnderline);
  TdxHtmlEditorImageUploadMode = (heiumBase64, heiumBoth, heiumServer);
  TdxHtmlEditorImageUploadTab = (heiutFile, heiutUrl);
  TdxHtmlEditorPredefinedContextMenuItem = (hepcmiAlignCenter, hepcmiAlignJustify, hepcmiAlignLeft, hepcmiAlignRight, hepcmiBackground, hepcmiBlockquote, hepcmiBold, hepcmiBulletList,
    hepcmiCellProperties, hepcmiClear, hepcmiCodeBlock, hepcmiColor, hepcmiDecreaseIndent, hepcmiDeleteColumn, hepcmiDeleteRow, hepcmiDeleteTable, hepcmiFont, hepcmiImage, hepcmiIncreaseIndent,
    hepcmiInsertColumnLeft, hepcmiInsertColumnRight, hepcmiInsertHeaderRow, hepcmiInsertRowAbove, hepcmiInsertRowBelow, hepcmiInsertTable, hepcmiItalic, hepcmiLink, hepcmiOrderedList, hepcmiRedo,
    hepcmiStrike, hepcmiSubscript, hepcmiSuperscript, hepcmiTableProperties, hepcmiUnderline, hepcmiUndo, hepcmiVariable);
  TdxHtmlEditorPredefinedToolbarItem = (heptiAlignCenter, heptiAlignJustify, heptiAlignLeft, heptiAlignRight, heptiBackground, heptiBlockquote, heptiBold, heptiBulletList, heptiCellProperties,
    heptiClear, heptiCodeBlock, heptiColor, heptiDecreaseIndent, heptiDeleteColumn, heptiDeleteRow, heptiDeleteTable, heptiFont, heptiHeader, heptiImage, heptiIncreaseIndent, heptiInsertColumnLeft,
    heptiInsertColumnRight, heptiInsertHeaderRow, heptiInsertRowAbove, heptiInsertRowBelow, heptiInsertTable, heptiItalic, heptiLink, heptiOrderedList, heptiRedo, heptiSeparator, heptiSize,
    heptiStrike, heptiSubscript, heptiSuperscript, heptiTableProperties, heptiUnderline, heptiUndo, heptiVariable);
  TdxMarkupType = (mtHtml, mtMarkdown);
  TdxItemDeleteMode = (idmContext, idmSlideButton, idmSlideItem, idmStatic, idmSwipe, idmToggle);
  TdxListMenuMode = (lmmContext, lmmSlide);
  TdxMapProvider = (mpBing, mpGoogle, mpGoogleStatic);
  TdxMapType = (mtHybrid, mtRoadmap, mtSatellite);
  TdxRouteMode = (rmDriving, rmWalking);
  TdxSubmenuDirection = (sdAuto, sdLeftOrTop, sdRightOrBottom);
  TdxNumberBoxPredefinedButton = (nbpbClear, nbpbSpins);
  TdxNumberBoxType = (nbtNumber, nbtTel, nbtText);
  TdxPieChartAnnotationLocation = (pcalCenter, pcalEdge);
  TdxPieChartLegendHoverMode = (pclhmAllArgumentPoints, pclhmNone);
  TdxPieChartSegmentDirection = (pcsdAnticlockwise, pcsdClockwise);
  TdxPieChartSeriesInteractionMode = (pcsimNone, pcsimOnlyPoint);
  TdxPieChartType = (pctDonut, pctDoughnut, pctPie);
  TdxSmallValuesGroupingMode = (svgmNone, svgmSmallValueThreshold, svgmTopN);
  TdxPivotGridArea = (pgaColumn, pgaData, pgaFilter, pgaRow);
  TdxPivotGridDataFieldArea = (pgdfaColumn, pgdfaRow);
  TdxPivotGridDataType = (pgdtDate, pgdtNumber, pgdtString);
  TdxPivotGridGroupInterval = (pggiDay, pggiDayOfWeek, pggiMonth, pggiQuarter, pggiYear);
  TdxPivotGridRowHeaderLayout = (pgrhlStandard, pgrhlTree);
  TdxPivotGridRunningTotalMode = (pgrtmColumn, pgrtmRow);
  TdxPivotGridSortBy = (pgsbDisplayText, pgsbNone, pgsbValue);
  TdxPivotGridStoreType = (pgstArray, pgstLocal, pgstOdata, pgstXmla);
  TdxPivotGridSummaryDisplayMode = (pgsdmAbsoluteVariation, pgsdmPercentOfColumnGrandTotal, pgsdmPercentOfColumnTotal, pgsdmPercentOfGrandTotal, pgsdmPercentOfRowGrandTotal, pgsdmPercentOfRowTotal,
    pgsdmPercentVariation);
  TdxPivotGridTotalDisplayMode = (pgtdmBoth, pgtdmColumns, pgtdmNone, pgtdmRows);
  TdxPolarChartSeriesType = (pcstArea, pcstBar, pcstLine, pcstScatter, pcstStackedbar);
  TdxValueAxisVisualRangeUpdateMode = (vavrumAuto, vavrumKeep, vavrumReset);
  TdxToolbarLocation = (tlBottom, tlTop);
  TdxAxisScale = (asContinuous, asDiscrete, asLogarithmic, asSemidiscrete);
  TdxBackgroundImageLocation = (bilCenter, bilCenterBottom, bilCenterTop, bilFull, bilLeftBottom, bilLeftCenter, bilLeftTop, bilRightBottom, bilRightCenter, bilRightTop);
  TdxChartAxisScale = (casContinuous, casLogarithmic);
  TdxValueChangedCallMode = (vccmOnMoving, vccmOnMovingComplete);
  TdxResizeHandle = (rhAll, rhBottom, rhLeft, rhRight, rhTop);
  TdxResizableStepPrecision = (rspSimple, rspStrict);
  TdxSankeyColorMode = (scmGradient, scmNone, scmSource, scmTarget);
  TdxAllDayPanelMode = (adpmAll, adpmAllDay, adpmHidden);
  TdxCellAppointmentsLimit = (calAuto, calUnlimited);
  TdxRecurrenceEditMode = (remDialog, remOccurrence, remSeries);
  TdxViewType = (vtAgenda, vtDay, vtMonth, vtTimelineDay, vtTimelineMonth, vtTimelineWeek, vtTimelineWorkWeek, vtWeek, vtWorkWeek);
  TdxScrollableShowScrollbar = (sssAlways, sssNever, sssOnHover, sssOnScroll);
  TdxSparklineType = (stArea, stBar, stLine, stSpline, stSplinearea, stSteparea, stStepline, stWinloss);
  TdxToastType = (ttCustom, ttError, ttInfo, ttSuccess, ttWarning);
  TdxLocateInMenuMode = (limmAlways, limmAuto, limmNever);
  TdxShowTextMode = (stmAlways, stmInMenu);
  TdxTreeListCommandColumnType = (tlcctAdaptive, tlcctButtons, tlcctDrag);
  TdxTreeListFilterMode = (tlfmFullBranch, tlfmMatchOnly, tlfmWithAncestors);
  TdxTreeListPredefinedColumnButton = (tlpcbAdd, tlpcbCancel, tlpcbDelete, tlpcbEdit, tlpcbSave, tlpcbUndelete);
  TdxTreeListPredefinedToolbarItem = (tlptiAddRowButton, tlptiApplyFilterButton, tlptiColumnChooserButton, tlptiRevertButton, tlptiSaveButton, tlptiSearchPanel);
  TdxTreeMapColorizerType = (tmctDiscrete, tmctGradient, tmctNone, tmctRange);
  TdxTreeMapLayoutAlgorithm = (tmlaSliceanddice, tmlaSquarified, tmlaStrip);
  TdxTreeMapLayoutDirection = (tmldLeftBottomRightTop, tmldLeftTopRightBottom, tmldRightBottomLeftTop, tmldRightTopLeftBottom);
  TdxTreeViewCheckBoxMode = (tvcbmNone, tvcbmNormal, tvcbmSelectAll);
  TdxTreeViewExpandEvent = (tveeClick, tveeDblclick);
  TdxVectorMapLayerType = (vmltArea, vmltLine, vmltMarker);
  TdxVectorMapMarkerShape = (vmmsCircle, vmmsSquare);
  TdxVectorMapMarkerType = (vmmtBubble, vmmtDot, vmmtImage, vmmtPie);
  TdxVectorMapProjection = (vmpEquirectangular, vmpLambert, vmpMercator, vmpMiller);

  TdxApplyValueModeHelper = record helper for TdxApplyValueMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxApplyValueMode; static;
  end;

  TdxButtonStyleHelper = record helper for TdxButtonStyle
  public
    function ToString: string;
    class function FromString(const value: string): TdxButtonStyle; static;
  end;

  TdxButtonTypeHelper = record helper for TdxButtonType
  public
    function ToString: string;
    class function FromString(const value: string): TdxButtonType; static;
  end;

  TdxDataStructureHelper = record helper for TdxDataStructure
  public
    function ToString: string;
    class function FromString(const value: string): TdxDataStructure; static;
  end;

  TdxDataTypeHelper = record helper for TdxDataType
  public
    function ToString: string;
    class function FromString(const value: string): TdxDataType; static;
  end;

  TdxDirectionHelper = record helper for TdxDirection
  public
    function ToString: string;
    class function FromString(const value: string): TdxDirection; static;
  end;

  TdxDragDirectionHelper = record helper for TdxDragDirection
  public
    function ToString: string;
    class function FromString(const value: string): TdxDragDirection; static;
  end;

  TdxDragHighlightHelper = record helper for TdxDragHighlight
  public
    function ToString: string;
    class function FromString(const value: string): TdxDragHighlight; static;
  end;

  TdxEditorStyleHelper = record helper for TdxEditorStyle
  public
    function ToString: string;
    class function FromString(const value: string): TdxEditorStyle; static;
  end;

  TdxExportFormatHelper = record helper for TdxExportFormat
  public
    function ToString: string;
    class function FromString(const value: string): TdxExportFormat; static;
  end;

  TdxFieldChooserLayoutHelper = record helper for TdxFieldChooserLayout
  public
    function ToString: string;
    class function FromString(const value: string): TdxFieldChooserLayout; static;
  end;

  TdxFirstDayOfWeekHelper = record helper for TdxFirstDayOfWeek
  public
    function ToString: string;
    class function FromString(const value: string): TdxFirstDayOfWeek; static;
  end;

  TdxFloatingActionButtonDirectionHelper = record helper for TdxFloatingActionButtonDirection
  public
    function ToString: string;
    class function FromString(const value: string): TdxFloatingActionButtonDirection; static;
  end;

  TdxFormatHelper = record helper for TdxFormat
  public
    function ToString: string;
    class function FromString(const value: string): TdxFormat; static;
  end;

  TdxHorizontalAlignmentHelper = record helper for TdxHorizontalAlignment
  public
    function ToString: string;
    class function FromString(const value: string): TdxHorizontalAlignment; static;
  end;

  TdxHorizontalEdgeHelper = record helper for TdxHorizontalEdge
  public
    function ToString: string;
    class function FromString(const value: string): TdxHorizontalEdge; static;
  end;

  TdxLabelModeHelper = record helper for TdxLabelMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxLabelMode; static;
  end;

  TdxMaskModeHelper = record helper for TdxMaskMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxMaskMode; static;
  end;

  TdxModeHelper = record helper for TdxMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxMode; static;
  end;

  TdxOrientationHelper = record helper for TdxOrientation
  public
    function ToString: string;
    class function FromString(const value: string): TdxOrientation; static;
  end;

  TdxPageLoadModeHelper = record helper for TdxPageLoadMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxPageLoadMode; static;
  end;

  TdxPageOrientationHelper = record helper for TdxPageOrientation
  public
    function ToString: string;
    class function FromString(const value: string): TdxPageOrientation; static;
  end;

  TdxPositionHelper = record helper for TdxPosition
  public
    function ToString: string;
    class function FromString(const value: string): TdxPosition; static;
  end;

  TdxPositionAlignmentHelper = record helper for TdxPositionAlignment
  public
    function ToString: string;
    class function FromString(const value: string): TdxPositionAlignment; static;
  end;

  TdxScrollbarModeHelper = record helper for TdxScrollbarMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxScrollbarMode; static;
  end;

  TdxScrollDirectionHelper = record helper for TdxScrollDirection
  public
    function ToString: string;
    class function FromString(const value: string): TdxScrollDirection; static;
  end;

  TdxScrollModeHelper = record helper for TdxScrollMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxScrollMode; static;
  end;

  TdxSearchModeHelper = record helper for TdxSearchMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxSearchMode; static;
  end;

  TdxSelectAllModeHelper = record helper for TdxSelectAllMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxSelectAllMode; static;
  end;

  TdxSimplifiedSearchModeHelper = record helper for TdxSimplifiedSearchMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxSimplifiedSearchMode; static;
  end;

  TdxSingleMultipleAllOrNoneHelper = record helper for TdxSingleMultipleAllOrNone
  public
    function ToString: string;
    class function FromString(const value: string): TdxSingleMultipleAllOrNone; static;
  end;

  TdxSingleMultipleOrNoneHelper = record helper for TdxSingleMultipleOrNone
  public
    function ToString: string;
    class function FromString(const value: string): TdxSingleMultipleOrNone; static;
  end;

  TdxSingleOrMultipleHelper = record helper for TdxSingleOrMultiple
  public
    function ToString: string;
    class function FromString(const value: string): TdxSingleOrMultiple; static;
  end;

  TdxSingleOrNoneHelper = record helper for TdxSingleOrNone
  public
    function ToString: string;
    class function FromString(const value: string): TdxSingleOrNone; static;
  end;

  TdxSliderValueChangeModeHelper = record helper for TdxSliderValueChangeMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxSliderValueChangeMode; static;
  end;

  TdxSortOrderHelper = record helper for TdxSortOrder
  public
    function ToString: string;
    class function FromString(const value: string): TdxSortOrder; static;
  end;

  TdxStoreTypeHelper = record helper for TdxStoreType
  public
    function ToString: string;
    class function FromString(const value: string): TdxStoreType; static;
  end;

  TdxSubmenuShowModeHelper = record helper for TdxSubmenuShowMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxSubmenuShowMode; static;
  end;

  TdxTextBoxPredefinedButtonHelper = record helper for TdxTextBoxPredefinedButton
  public
    function ToString: string;
    class function FromString(const value: string): TdxTextBoxPredefinedButton; static;
  end;

  TdxTextEditorButtonLocationHelper = record helper for TdxTextEditorButtonLocation
  public
    function ToString: string;
    class function FromString(const value: string): TdxTextEditorButtonLocation; static;
  end;

  TdxToolbarItemComponentHelper = record helper for TdxToolbarItemComponent
  public
    function ToString: string;
    class function FromString(const value: string): TdxToolbarItemComponent; static;
  end;

  TdxToolbarItemLocationHelper = record helper for TdxToolbarItemLocation
  public
    function ToString: string;
    class function FromString(const value: string): TdxToolbarItemLocation; static;
  end;

  TdxTooltipShowModeHelper = record helper for TdxTooltipShowMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxTooltipShowMode; static;
  end;

  TdxValidationMessageModeHelper = record helper for TdxValidationMessageMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxValidationMessageMode; static;
  end;

  TdxValidationRuleTypeHelper = record helper for TdxValidationRuleType
  public
    function ToString: string;
    class function FromString(const value: string): TdxValidationRuleType; static;
  end;

  TdxValidationStatusHelper = record helper for TdxValidationStatus
  public
    function ToString: string;
    class function FromString(const value: string): TdxValidationStatus; static;
  end;

  TdxVerticalAlignmentHelper = record helper for TdxVerticalAlignment
  public
    function ToString: string;
    class function FromString(const value: string): TdxVerticalAlignment; static;
  end;

  TdxVerticalEdgeHelper = record helper for TdxVerticalEdge
  public
    function ToString: string;
    class function FromString(const value: string): TdxVerticalEdge; static;
  end;

  TCollectionWidgetSelectionModeHelper = record helper for TCollectionWidgetSelectionMode
  public
    function ToString: string;
    class function FromString(const value: string): TCollectionWidgetSelectionMode; static;
  end;

  TdxTextBoxTypeHelper = record helper for TdxTextBoxType
  public
    function ToString: string;
    class function FromString(const value: string): TdxTextBoxType; static;
  end;

  TdxDropDownPredefinedButtonHelper = record helper for TdxDropDownPredefinedButton
  public
    function ToString: string;
    class function FromString(const value: string): TdxDropDownPredefinedButton; static;
  end;

  TdxGaugeIndicatorTypeHelper = record helper for TdxGaugeIndicatorType
  public
    function ToString: string;
    class function FromString(const value: string): TdxGaugeIndicatorType; static;
  end;

  TdxBoxDirectionHelper = record helper for TdxBoxDirection
  public
    function ToString: string;
    class function FromString(const value: string): TdxBoxDirection; static;
  end;

  TdxCrosswiseDistributionHelper = record helper for TdxCrosswiseDistribution
  public
    function ToString: string;
    class function FromString(const value: string): TdxCrosswiseDistribution; static;
  end;

  TdxDistributionHelper = record helper for TdxDistribution
  public
    function ToString: string;
    class function FromString(const value: string): TdxDistribution; static;
  end;

  TdxCalendarZoomLevelHelper = record helper for TdxCalendarZoomLevel
  public
    function ToString: string;
    class function FromString(const value: string): TdxCalendarZoomLevel; static;
  end;

  TdxWeekNumberRuleHelper = record helper for TdxWeekNumberRule
  public
    function ToString: string;
    class function FromString(const value: string): TdxWeekNumberRule; static;
  end;

  TdxAggregatedPointsPositionHelper = record helper for TdxAggregatedPointsPosition
  public
    function ToString: string;
    class function FromString(const value: string): TdxAggregatedPointsPosition; static;
  end;

  TdxChartBubbleSeriesAggregationMethodHelper = record helper for TdxChartBubbleSeriesAggregationMethod
  public
    function ToString: string;
    class function FromString(const value: string): TdxChartBubbleSeriesAggregationMethod; static;
  end;

  TdxChartFinancialSeriesAggregationMethodHelper = record helper for TdxChartFinancialSeriesAggregationMethod
  public
    function ToString: string;
    class function FromString(const value: string): TdxChartFinancialSeriesAggregationMethod; static;
  end;

  TdxChartLabelDisplayModeHelper = record helper for TdxChartLabelDisplayMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxChartLabelDisplayMode; static;
  end;

  TdxChartRangeSeriesAggregationMethodHelper = record helper for TdxChartRangeSeriesAggregationMethod
  public
    function ToString: string;
    class function FromString(const value: string): TdxChartRangeSeriesAggregationMethod; static;
  end;

  TdxChartSeriesAggregationMethodHelper = record helper for TdxChartSeriesAggregationMethod
  public
    function ToString: string;
    class function FromString(const value: string): TdxChartSeriesAggregationMethod; static;
  end;

  TdxChartSingleValueSeriesAggregationMethodHelper = record helper for TdxChartSingleValueSeriesAggregationMethod
  public
    function ToString: string;
    class function FromString(const value: string): TdxChartSingleValueSeriesAggregationMethod; static;
  end;

  TdxChartTooltipLocationHelper = record helper for TdxChartTooltipLocation
  public
    function ToString: string;
    class function FromString(const value: string): TdxChartTooltipLocation; static;
  end;

  TdxChartZoomAndPanModeHelper = record helper for TdxChartZoomAndPanMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxChartZoomAndPanMode; static;
  end;

  TdxEventKeyModifierHelper = record helper for TdxEventKeyModifier
  public
    function ToString: string;
    class function FromString(const value: string): TdxEventKeyModifier; static;
  end;

  TdxFinancialChartReductionLevelHelper = record helper for TdxFinancialChartReductionLevel
  public
    function ToString: string;
    class function FromString(const value: string): TdxFinancialChartReductionLevel; static;
  end;

  TdxCircularGaugeElementOrientationHelper = record helper for TdxCircularGaugeElementOrientation
  public
    function ToString: string;
    class function FromString(const value: string): TdxCircularGaugeElementOrientation; static;
  end;

  TdxCircularGaugeLabelOverlapHelper = record helper for TdxCircularGaugeLabelOverlap
  public
    function ToString: string;
    class function FromString(const value: string): TdxCircularGaugeLabelOverlap; static;
  end;

  TdxContextSubmenuDirectionHelper = record helper for TdxContextSubmenuDirection
  public
    function ToString: string;
    class function FromString(const value: string): TdxContextSubmenuDirection; static;
  end;

  TdxDataGridCommandColumnTypeHelper = record helper for TdxDataGridCommandColumnType
  public
    function ToString: string;
    class function FromString(const value: string): TdxDataGridCommandColumnType; static;
  end;

  TdxDataGridExportFormatHelper = record helper for TdxDataGridExportFormat
  public
    function ToString: string;
    class function FromString(const value: string): TdxDataGridExportFormat; static;
  end;

  TdxDataGridPredefinedColumnButtonHelper = record helper for TdxDataGridPredefinedColumnButton
  public
    function ToString: string;
    class function FromString(const value: string): TdxDataGridPredefinedColumnButton; static;
  end;

  TdxDataGridPredefinedToolbarItemHelper = record helper for TdxDataGridPredefinedToolbarItem
  public
    function ToString: string;
    class function FromString(const value: string): TdxDataGridPredefinedToolbarItem; static;
  end;

  TdxDataGridScrollModeHelper = record helper for TdxDataGridScrollMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxDataGridScrollMode; static;
  end;

  TdxDatePickerTypeHelper = record helper for TdxDatePickerType
  public
    function ToString: string;
    class function FromString(const value: string): TdxDatePickerType; static;
  end;

  TdxDateTypeHelper = record helper for TdxDateType
  public
    function ToString: string;
    class function FromString(const value: string): TdxDateType; static;
  end;

  TdxDiagramAutoZoomModeHelper = record helper for TdxDiagramAutoZoomMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramAutoZoomMode; static;
  end;

  TdxDiagramCommandHelper = record helper for TdxDiagramCommand
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramCommand; static;
  end;

  TdxDiagramConnectorLineEndHelper = record helper for TdxDiagramConnectorLineEnd
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramConnectorLineEnd; static;
  end;

  TdxDiagramConnectorLineTypeHelper = record helper for TdxDiagramConnectorLineType
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramConnectorLineType; static;
  end;

  TdxDiagramConnectorPositionHelper = record helper for TdxDiagramConnectorPosition
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramConnectorPosition; static;
  end;

  TdxDiagramDataLayoutTypeHelper = record helper for TdxDiagramDataLayoutType
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramDataLayoutType; static;
  end;

  TdxDiagramExportFormatHelper = record helper for TdxDiagramExportFormat
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramExportFormat; static;
  end;

  TdxDiagramItemTypeHelper = record helper for TdxDiagramItemType
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramItemType; static;
  end;

  TdxDiagramModelOperationHelper = record helper for TdxDiagramModelOperation
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramModelOperation; static;
  end;

  TdxDiagramPanelVisibilityHelper = record helper for TdxDiagramPanelVisibility
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramPanelVisibility; static;
  end;

  TdxDiagramRequestEditOperationReasonHelper = record helper for TdxDiagramRequestEditOperationReason
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramRequestEditOperationReason; static;
  end;

  TdxDiagramShapeCategoryHelper = record helper for TdxDiagramShapeCategory
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramShapeCategory; static;
  end;

  TdxDiagramShapeTypeHelper = record helper for TdxDiagramShapeType
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramShapeType; static;
  end;

  TdxDiagramToolboxDisplayModeHelper = record helper for TdxDiagramToolboxDisplayMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramToolboxDisplayMode; static;
  end;

  TdxDiagramUnitsHelper = record helper for TdxDiagramUnits
  public
    function ToString: string;
    class function FromString(const value: string): TdxDiagramUnits; static;
  end;

  TdxOpenedStateModeHelper = record helper for TdxOpenedStateMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxOpenedStateMode; static;
  end;

  TdxPanelLocationHelper = record helper for TdxPanelLocation
  public
    function ToString: string;
    class function FromString(const value: string): TdxPanelLocation; static;
  end;

  TdxRevealModeHelper = record helper for TdxRevealMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxRevealMode; static;
  end;

  TdxDropDownBoxApplyValueModeHelper = record helper for TdxDropDownBoxApplyValueMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxDropDownBoxApplyValueMode; static;
  end;

  TdxFileManagerItemViewModeHelper = record helper for TdxFileManagerItemViewMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxFileManagerItemViewMode; static;
  end;

  TdxFileManagerPredefinedContextMenuItemHelper = record helper for TdxFileManagerPredefinedContextMenuItem
  public
    function ToString: string;
    class function FromString(const value: string): TdxFileManagerPredefinedContextMenuItem; static;
  end;

  TdxFileManagerPredefinedToolbarItemHelper = record helper for TdxFileManagerPredefinedToolbarItem
  public
    function ToString: string;
    class function FromString(const value: string): TdxFileManagerPredefinedToolbarItem; static;
  end;

  TdxFileManagerViewAreaHelper = record helper for TdxFileManagerViewArea
  public
    function ToString: string;
    class function FromString(const value: string): TdxFileManagerViewArea; static;
  end;

  TdxFileUploadModeHelper = record helper for TdxFileUploadMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxFileUploadMode; static;
  end;

  TdxUploadHttpMethodHelper = record helper for TdxUploadHttpMethod
  public
    function ToString: string;
    class function FromString(const value: string): TdxUploadHttpMethod; static;
  end;

  TdxGroupOperationHelper = record helper for TdxGroupOperation
  public
    function ToString: string;
    class function FromString(const value: string): TdxGroupOperation; static;
  end;

  TdxFormItemComponentHelper = record helper for TdxFormItemComponent
  public
    function ToString: string;
    class function FromString(const value: string): TdxFormItemComponent; static;
  end;

  TdxFormItemTypeHelper = record helper for TdxFormItemType
  public
    function ToString: string;
    class function FromString(const value: string): TdxFormItemType; static;
  end;

  TdxFormLabelModeHelper = record helper for TdxFormLabelMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxFormLabelMode; static;
  end;

  TdxLabelLocationHelper = record helper for TdxLabelLocation
  public
    function ToString: string;
    class function FromString(const value: string): TdxLabelLocation; static;
  end;

  TdxFunnelAlgorithmHelper = record helper for TdxFunnelAlgorithm
  public
    function ToString: string;
    class function FromString(const value: string): TdxFunnelAlgorithm; static;
  end;

  TdxGanttPdfExportDateRangeHelper = record helper for TdxGanttPdfExportDateRange
  public
    function ToString: string;
    class function FromString(const value: string): TdxGanttPdfExportDateRange; static;
  end;

  TdxGanttPdfExportModeHelper = record helper for TdxGanttPdfExportMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxGanttPdfExportMode; static;
  end;

  TdxGanttPredefinedContextMenuItemHelper = record helper for TdxGanttPredefinedContextMenuItem
  public
    function ToString: string;
    class function FromString(const value: string): TdxGanttPredefinedContextMenuItem; static;
  end;

  TdxGanttPredefinedToolbarItemHelper = record helper for TdxGanttPredefinedToolbarItem
  public
    function ToString: string;
    class function FromString(const value: string): TdxGanttPredefinedToolbarItem; static;
  end;

  TdxGanttRenderScaleTypeHelper = record helper for TdxGanttRenderScaleType
  public
    function ToString: string;
    class function FromString(const value: string): TdxGanttRenderScaleType; static;
  end;

  TdxGanttScaleTypeHelper = record helper for TdxGanttScaleType
  public
    function ToString: string;
    class function FromString(const value: string): TdxGanttScaleType; static;
  end;

  TdxGanttTaskTitlePositionHelper = record helper for TdxGanttTaskTitlePosition
  public
    function ToString: string;
    class function FromString(const value: string): TdxGanttTaskTitlePosition; static;
  end;

  TdxHtmlEditorFormatHelper = record helper for TdxHtmlEditorFormat
  public
    function ToString: string;
    class function FromString(const value: string): TdxHtmlEditorFormat; static;
  end;

  TdxHtmlEditorImageUploadModeHelper = record helper for TdxHtmlEditorImageUploadMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxHtmlEditorImageUploadMode; static;
  end;

  TdxHtmlEditorImageUploadTabHelper = record helper for TdxHtmlEditorImageUploadTab
  public
    function ToString: string;
    class function FromString(const value: string): TdxHtmlEditorImageUploadTab; static;
  end;

  TdxHtmlEditorPredefinedContextMenuItemHelper = record helper for TdxHtmlEditorPredefinedContextMenuItem
  public
    function ToString: string;
    class function FromString(const value: string): TdxHtmlEditorPredefinedContextMenuItem; static;
  end;

  TdxHtmlEditorPredefinedToolbarItemHelper = record helper for TdxHtmlEditorPredefinedToolbarItem
  public
    function ToString: string;
    class function FromString(const value: string): TdxHtmlEditorPredefinedToolbarItem; static;
  end;

  TdxMarkupTypeHelper = record helper for TdxMarkupType
  public
    function ToString: string;
    class function FromString(const value: string): TdxMarkupType; static;
  end;

  TdxItemDeleteModeHelper = record helper for TdxItemDeleteMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxItemDeleteMode; static;
  end;

  TdxListMenuModeHelper = record helper for TdxListMenuMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxListMenuMode; static;
  end;

  TdxMapProviderHelper = record helper for TdxMapProvider
  public
    function ToString: string;
    class function FromString(const value: string): TdxMapProvider; static;
  end;

  TdxMapTypeHelper = record helper for TdxMapType
  public
    function ToString: string;
    class function FromString(const value: string): TdxMapType; static;
  end;

  TdxRouteModeHelper = record helper for TdxRouteMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxRouteMode; static;
  end;

  TdxSubmenuDirectionHelper = record helper for TdxSubmenuDirection
  public
    function ToString: string;
    class function FromString(const value: string): TdxSubmenuDirection; static;
  end;

  TdxNumberBoxPredefinedButtonHelper = record helper for TdxNumberBoxPredefinedButton
  public
    function ToString: string;
    class function FromString(const value: string): TdxNumberBoxPredefinedButton; static;
  end;

  TdxNumberBoxTypeHelper = record helper for TdxNumberBoxType
  public
    function ToString: string;
    class function FromString(const value: string): TdxNumberBoxType; static;
  end;

  TdxPieChartAnnotationLocationHelper = record helper for TdxPieChartAnnotationLocation
  public
    function ToString: string;
    class function FromString(const value: string): TdxPieChartAnnotationLocation; static;
  end;

  TdxPieChartLegendHoverModeHelper = record helper for TdxPieChartLegendHoverMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxPieChartLegendHoverMode; static;
  end;

  TdxPieChartSegmentDirectionHelper = record helper for TdxPieChartSegmentDirection
  public
    function ToString: string;
    class function FromString(const value: string): TdxPieChartSegmentDirection; static;
  end;

  TdxPieChartSeriesInteractionModeHelper = record helper for TdxPieChartSeriesInteractionMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxPieChartSeriesInteractionMode; static;
  end;

  TdxPieChartTypeHelper = record helper for TdxPieChartType
  public
    function ToString: string;
    class function FromString(const value: string): TdxPieChartType; static;
  end;

  TdxSmallValuesGroupingModeHelper = record helper for TdxSmallValuesGroupingMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxSmallValuesGroupingMode; static;
  end;

  TdxPivotGridAreaHelper = record helper for TdxPivotGridArea
  public
    function ToString: string;
    class function FromString(const value: string): TdxPivotGridArea; static;
  end;

  TdxPivotGridDataFieldAreaHelper = record helper for TdxPivotGridDataFieldArea
  public
    function ToString: string;
    class function FromString(const value: string): TdxPivotGridDataFieldArea; static;
  end;

  TdxPivotGridDataTypeHelper = record helper for TdxPivotGridDataType
  public
    function ToString: string;
    class function FromString(const value: string): TdxPivotGridDataType; static;
  end;

  TdxPivotGridGroupIntervalHelper = record helper for TdxPivotGridGroupInterval
  public
    function ToString: string;
    class function FromString(const value: string): TdxPivotGridGroupInterval; static;
  end;

  TdxPivotGridRowHeaderLayoutHelper = record helper for TdxPivotGridRowHeaderLayout
  public
    function ToString: string;
    class function FromString(const value: string): TdxPivotGridRowHeaderLayout; static;
  end;

  TdxPivotGridRunningTotalModeHelper = record helper for TdxPivotGridRunningTotalMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxPivotGridRunningTotalMode; static;
  end;

  TdxPivotGridSortByHelper = record helper for TdxPivotGridSortBy
  public
    function ToString: string;
    class function FromString(const value: string): TdxPivotGridSortBy; static;
  end;

  TdxPivotGridStoreTypeHelper = record helper for TdxPivotGridStoreType
  public
    function ToString: string;
    class function FromString(const value: string): TdxPivotGridStoreType; static;
  end;

  TdxPivotGridSummaryDisplayModeHelper = record helper for TdxPivotGridSummaryDisplayMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxPivotGridSummaryDisplayMode; static;
  end;

  TdxPivotGridTotalDisplayModeHelper = record helper for TdxPivotGridTotalDisplayMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxPivotGridTotalDisplayMode; static;
  end;

  TdxPolarChartSeriesTypeHelper = record helper for TdxPolarChartSeriesType
  public
    function ToString: string;
    class function FromString(const value: string): TdxPolarChartSeriesType; static;
  end;

  TdxValueAxisVisualRangeUpdateModeHelper = record helper for TdxValueAxisVisualRangeUpdateMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxValueAxisVisualRangeUpdateMode; static;
  end;

  TdxToolbarLocationHelper = record helper for TdxToolbarLocation
  public
    function ToString: string;
    class function FromString(const value: string): TdxToolbarLocation; static;
  end;

  TdxAxisScaleHelper = record helper for TdxAxisScale
  public
    function ToString: string;
    class function FromString(const value: string): TdxAxisScale; static;
  end;

  TdxBackgroundImageLocationHelper = record helper for TdxBackgroundImageLocation
  public
    function ToString: string;
    class function FromString(const value: string): TdxBackgroundImageLocation; static;
  end;

  TdxChartAxisScaleHelper = record helper for TdxChartAxisScale
  public
    function ToString: string;
    class function FromString(const value: string): TdxChartAxisScale; static;
  end;

  TdxValueChangedCallModeHelper = record helper for TdxValueChangedCallMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxValueChangedCallMode; static;
  end;

  TdxResizeHandleHelper = record helper for TdxResizeHandle
  public
    function ToString: string;
    class function FromString(const value: string): TdxResizeHandle; static;
  end;

  TdxResizableStepPrecisionHelper = record helper for TdxResizableStepPrecision
  public
    function ToString: string;
    class function FromString(const value: string): TdxResizableStepPrecision; static;
  end;

  TdxSankeyColorModeHelper = record helper for TdxSankeyColorMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxSankeyColorMode; static;
  end;

  TdxAllDayPanelModeHelper = record helper for TdxAllDayPanelMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxAllDayPanelMode; static;
  end;

  TdxCellAppointmentsLimitHelper = record helper for TdxCellAppointmentsLimit
  public
    function ToString: string;
    class function FromString(const value: string): TdxCellAppointmentsLimit; static;
  end;

  TdxRecurrenceEditModeHelper = record helper for TdxRecurrenceEditMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxRecurrenceEditMode; static;
  end;

  TdxViewTypeHelper = record helper for TdxViewType
  public
    function ToString: string;
    class function FromString(const value: string): TdxViewType; static;
  end;

  TdxScrollableShowScrollbarHelper = record helper for TdxScrollableShowScrollbar
  public
    function ToString: string;
    class function FromString(const value: string): TdxScrollableShowScrollbar; static;
  end;

  TdxSparklineTypeHelper = record helper for TdxSparklineType
  public
    function ToString: string;
    class function FromString(const value: string): TdxSparklineType; static;
  end;

  TdxToastTypeHelper = record helper for TdxToastType
  public
    function ToString: string;
    class function FromString(const value: string): TdxToastType; static;
  end;

  TdxLocateInMenuModeHelper = record helper for TdxLocateInMenuMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxLocateInMenuMode; static;
  end;

  TdxShowTextModeHelper = record helper for TdxShowTextMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxShowTextMode; static;
  end;

  TdxTreeListCommandColumnTypeHelper = record helper for TdxTreeListCommandColumnType
  public
    function ToString: string;
    class function FromString(const value: string): TdxTreeListCommandColumnType; static;
  end;

  TdxTreeListFilterModeHelper = record helper for TdxTreeListFilterMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxTreeListFilterMode; static;
  end;

  TdxTreeListPredefinedColumnButtonHelper = record helper for TdxTreeListPredefinedColumnButton
  public
    function ToString: string;
    class function FromString(const value: string): TdxTreeListPredefinedColumnButton; static;
  end;

  TdxTreeListPredefinedToolbarItemHelper = record helper for TdxTreeListPredefinedToolbarItem
  public
    function ToString: string;
    class function FromString(const value: string): TdxTreeListPredefinedToolbarItem; static;
  end;

  TdxTreeMapColorizerTypeHelper = record helper for TdxTreeMapColorizerType
  public
    function ToString: string;
    class function FromString(const value: string): TdxTreeMapColorizerType; static;
  end;

  TdxTreeMapLayoutAlgorithmHelper = record helper for TdxTreeMapLayoutAlgorithm
  public
    function ToString: string;
    class function FromString(const value: string): TdxTreeMapLayoutAlgorithm; static;
  end;

  TdxTreeMapLayoutDirectionHelper = record helper for TdxTreeMapLayoutDirection
  public
    function ToString: string;
    class function FromString(const value: string): TdxTreeMapLayoutDirection; static;
  end;

  TdxTreeViewCheckBoxModeHelper = record helper for TdxTreeViewCheckBoxMode
  public
    function ToString: string;
    class function FromString(const value: string): TdxTreeViewCheckBoxMode; static;
  end;

  TdxTreeViewExpandEventHelper = record helper for TdxTreeViewExpandEvent
  public
    function ToString: string;
    class function FromString(const value: string): TdxTreeViewExpandEvent; static;
  end;

  TdxVectorMapLayerTypeHelper = record helper for TdxVectorMapLayerType
  public
    function ToString: string;
    class function FromString(const value: string): TdxVectorMapLayerType; static;
  end;

  TdxVectorMapMarkerShapeHelper = record helper for TdxVectorMapMarkerShape
  public
    function ToString: string;
    class function FromString(const value: string): TdxVectorMapMarkerShape; static;
  end;

  TdxVectorMapMarkerTypeHelper = record helper for TdxVectorMapMarkerType
  public
    function ToString: string;
    class function FromString(const value: string): TdxVectorMapMarkerType; static;
  end;

  TdxVectorMapProjectionHelper = record helper for TdxVectorMapProjection
  public
    function ToString: string;
    class function FromString(const value: string): TdxVectorMapProjection; static;
  end;

  TLabelOption = (loLabelBold, loPlaceholder, loFloating);
  TLabelOptions = set of TLabelOption;

const
  DefaultLabelOptions = []; // [loFloating];

implementation

function TdxApplyValueModeHelper.ToString: string;
begin
  case self of
    avmInstantly:
      Result := 'instantly';
    avmUseButtons:
      Result := 'useButtons';
  end;
end;

class function TdxApplyValueModeHelper.FromString(const value: string): TdxApplyValueMode;
begin
  Result := avmInstantly;

  if value = 'instantly' then
    Result := avmInstantly
  else
    if value = 'useButtons' then
      Result := avmUseButtons;
end;

function TdxButtonStyleHelper.ToString: string;
begin
  case self of
    bsContained:
      Result := 'contained';
    bsOutlined:
      Result := 'outlined';
    bsText:
      Result := 'text';
  end;
end;

class function TdxButtonStyleHelper.FromString(const value: string): TdxButtonStyle;
begin
  Result := bsContained;

  if value = 'contained' then
    Result := bsContained
  else
    if value = 'outlined' then
      Result := bsOutlined
    else
      if value = 'text' then
        Result := bsText;
end;

function TdxButtonTypeHelper.ToString: string;
begin
  case self of
    btBack:
      Result := 'back';
    btDanger:
      Result := 'danger';
    btDefault:
      Result := 'default';
    btNormal:
      Result := 'normal';
    btSuccess:
      Result := 'success';
  end;
end;

class function TdxButtonTypeHelper.FromString(const value: string): TdxButtonType;
begin
  Result := btBack;

  if value = 'back' then
    Result := btBack
  else
    if value = 'danger' then
      Result := btDanger
    else
      if value = 'default' then
        Result := btDefault
      else
        if value = 'normal' then
          Result := btNormal
        else
          if value = 'success' then
            Result := btSuccess;
end;

function TdxDataStructureHelper.ToString: string;
begin
  case self of
    dsPlain:
      Result := 'plain';
    dsTree:
      Result := 'tree';
  end;
end;

class function TdxDataStructureHelper.FromString(const value: string): TdxDataStructure;
begin
  Result := dsPlain;

  if value = 'plain' then
    Result := dsPlain
  else
    if value = 'tree' then
      Result := dsTree;
end;

function TdxDataTypeHelper.ToString: string;
begin
  case self of
    dtBoolean:
      Result := 'boolean';
    dtDate:
      Result := 'date';
    dtDatetime:
      Result := 'datetime';
    dtNumber:
      Result := 'number';
    dtObject:
      Result := 'object';
    dtString:
      Result := 'string';
  end;
end;

class function TdxDataTypeHelper.FromString(const value: string): TdxDataType;
begin
  Result := dtBoolean;

  if value = 'boolean' then
    Result := dtBoolean
  else
    if value = 'date' then
      Result := dtDate
    else
      if value = 'datetime' then
        Result := dtDatetime
      else
        if value = 'number' then
          Result := dtNumber
        else
          if value = 'object' then
            Result := dtObject
          else
            if value = 'string' then
              Result := dtString;
end;

function TdxDirectionHelper.ToString: string;
begin
  case self of
    dBottom:
      Result := 'bottom';
    dLeft:
      Result := 'left';
    dRight:
      Result := 'right';
    dTop:
      Result := 'top';
  end;
end;

class function TdxDirectionHelper.FromString(const value: string): TdxDirection;
begin
  Result := dBottom;

  if value = 'bottom' then
    Result := dBottom
  else
    if value = 'left' then
      Result := dLeft
    else
      if value = 'right' then
        Result := dRight
      else
        if value = 'top' then
          Result := dTop;
end;

function TdxDragDirectionHelper.ToString: string;
begin
  case self of
    ddBoth:
      Result := 'both';
    ddHorizontal:
      Result := 'horizontal';
    ddVertical:
      Result := 'vertical';
  end;
end;

class function TdxDragDirectionHelper.FromString(const value: string): TdxDragDirection;
begin
  Result := ddBoth;

  if value = 'both' then
    Result := ddBoth
  else
    if value = 'horizontal' then
      Result := ddHorizontal
    else
      if value = 'vertical' then
        Result := ddVertical;
end;

function TdxDragHighlightHelper.ToString: string;
begin
  case self of
    dhIndicate:
      Result := 'indicate';
    dhPush:
      Result := 'push';
  end;
end;

class function TdxDragHighlightHelper.FromString(const value: string): TdxDragHighlight;
begin
  Result := dhIndicate;

  if value = 'indicate' then
    Result := dhIndicate
  else
    if value = 'push' then
      Result := dhPush;
end;

function TdxEditorStyleHelper.ToString: string;
begin
  case self of
    esFilled:
      Result := 'filled';
    esOutlined:
      Result := 'outlined';
    esUnderlined:
      Result := 'underlined';
  end;
end;

class function TdxEditorStyleHelper.FromString(const value: string): TdxEditorStyle;
begin
  Result := esFilled;

  if value = 'filled' then
    Result := esFilled
  else
    if value = 'outlined' then
      Result := esOutlined
    else
      if value = 'underlined' then
        Result := esUnderlined;
end;

function TdxExportFormatHelper.ToString: string;
begin
  case self of
    efGIF:
      Result := 'GIF';
    efJPEG:
      Result := 'JPEG';
    efPDF:
      Result := 'PDF';
    efPNG:
      Result := 'PNG';
    efSVG:
      Result := 'SVG';
  end;
end;

class function TdxExportFormatHelper.FromString(const value: string): TdxExportFormat;
begin
  Result := efGIF;

  if value = 'GIF' then
    Result := efGIF
  else
    if value = 'JPEG' then
      Result := efJPEG
    else
      if value = 'PDF' then
        Result := efPDF
      else
        if value = 'PNG' then
          Result := efPNG
        else
          if value = 'SVG' then
            Result := efSVG;
end;

function TdxFieldChooserLayoutHelper.ToString: string;
begin
  case self of
    fcl0:
      Result := '0';
    fcl1:
      Result := '1';
    fcl2:
      Result := '2';
  end;
end;

class function TdxFieldChooserLayoutHelper.FromString(const value: string): TdxFieldChooserLayout;
begin
  Result := fcl0;

  if value = '0' then
    Result := fcl0
  else
    if value = '1' then
      Result := fcl1
    else
      if value = '2' then
        Result := fcl2;
end;

function TdxFirstDayOfWeekHelper.ToString: string;
begin
  case self of
    fdow0:
      Result := '0';
    fdow1:
      Result := '1';
    fdow2:
      Result := '2';
    fdow3:
      Result := '3';
    fdow4:
      Result := '4';
    fdow5:
      Result := '5';
    fdow6:
      Result := '6';
  end;
end;

class function TdxFirstDayOfWeekHelper.FromString(const value: string): TdxFirstDayOfWeek;
begin
  Result := fdow0;

  if value = '0' then
    Result := fdow0
  else
    if value = '1' then
      Result := fdow1
    else
      if value = '2' then
        Result := fdow2
      else
        if value = '3' then
          Result := fdow3
        else
          if value = '4' then
            Result := fdow4
          else
            if value = '5' then
              Result := fdow5
            else
              if value = '6' then
                Result := fdow6;
end;

function TdxFloatingActionButtonDirectionHelper.ToString: string;
begin
  case self of
    fabdAuto:
      Result := 'auto';
    fabdDown:
      Result := 'down';
    fabdUp:
      Result := 'up';
  end;
end;

class function TdxFloatingActionButtonDirectionHelper.FromString(const value: string): TdxFloatingActionButtonDirection;
begin
  Result := fabdAuto;

  if value = 'auto' then
    Result := fabdAuto
  else
    if value = 'down' then
      Result := fabdDown
    else
      if value = 'up' then
        Result := fabdUp;
end;

function TdxFormatHelper.ToString: string;
begin
  case self of
    fBillions:
      Result := 'billions';
    fCurrency:
      Result := 'currency';
    fDay:
      Result := 'day';
    fDayOfWeek:
      Result := 'dayOfWeek';
    fDecimal:
      Result := 'decimal';
    fExponential:
      Result := 'exponential';
    fFixedPoint:
      Result := 'fixedPoint';
    fHour:
      Result := 'hour';
    fLargeNumber:
      Result := 'largeNumber';
    fLongDate:
      Result := 'longDate';
    fLongDateLongTime:
      Result := 'longDateLongTime';
    fLongTime:
      Result := 'longTime';
    fMillions:
      Result := 'millions';
    fMillisecond:
      Result := 'millisecond';
    fMinute:
      Result := 'minute';
    fMonth:
      Result := 'month';
    fMonthAndDay:
      Result := 'monthAndDay';
    fMonthAndYear:
      Result := 'monthAndYear';
    fPercent:
      Result := 'percent';
    fQuarter:
      Result := 'quarter';
    fQuarterAndYear:
      Result := 'quarterAndYear';
    fSecond:
      Result := 'second';
    fShortDate:
      Result := 'shortDate';
    fShortDateShortTime:
      Result := 'shortDateShortTime';
    fShortTime:
      Result := 'shortTime';
    fThousands:
      Result := 'thousands';
    fTrillions:
      Result := 'trillions';
    fYear:
      Result := 'year';
  end;
end;

class function TdxFormatHelper.FromString(const value: string): TdxFormat;
begin
  Result := fBillions;

  if value = 'billions' then
    Result := fBillions
  else
    if value = 'currency' then
      Result := fCurrency
    else
      if value = 'day' then
        Result := fDay
      else
        if value = 'dayOfWeek' then
          Result := fDayOfWeek
        else
          if value = 'decimal' then
            Result := fDecimal
          else
            if value = 'exponential' then
              Result := fExponential
            else
              if value = 'fixedPoint' then
                Result := fFixedPoint
              else
                if value = 'hour' then
                  Result := fHour
                else
                  if value = 'largeNumber' then
                    Result := fLargeNumber
                  else
                    if value = 'longDate' then
                      Result := fLongDate
                    else
                      if value = 'longDateLongTime' then
                        Result := fLongDateLongTime
                      else
                        if value = 'longTime' then
                          Result := fLongTime
                        else
                          if value = 'millions' then
                            Result := fMillions
                          else
                            if value = 'millisecond' then
                              Result := fMillisecond
                            else
                              if value = 'minute' then
                                Result := fMinute
                              else
                                if value = 'month' then
                                  Result := fMonth
                                else
                                  if value = 'monthAndDay' then
                                    Result := fMonthAndDay
                                  else
                                    if value = 'monthAndYear' then
                                      Result := fMonthAndYear
                                    else
                                      if value = 'percent' then
                                        Result := fPercent
                                      else
                                        if value = 'quarter' then
                                        Result := fQuarter
                                        else
                                        if value = 'quarterAndYear' then
                                        Result := fQuarterAndYear
                                        else
                                        if value = 'second' then
                                        Result := fSecond
                                        else
                                        if value = 'shortDate' then
                                        Result := fShortDate
                                        else
                                        if value = 'shortDateShortTime' then
                                        Result := fShortDateShortTime
                                        else
                                        if value = 'shortTime' then
                                        Result := fShortTime
                                        else
                                        if value = 'thousands' then
                                        Result := fThousands
                                        else
                                        if value = 'trillions' then
                                        Result := fTrillions
                                        else
                                        if value = 'year' then
                                        Result := fYear;
end;

function TdxHorizontalAlignmentHelper.ToString: string;
begin
  case self of
    haCenter:
      Result := 'center';
    haLeft:
      Result := 'left';
    haRight:
      Result := 'right';
  end;
end;

class function TdxHorizontalAlignmentHelper.FromString(const value: string): TdxHorizontalAlignment;
begin
  Result := haCenter;

  if value = 'center' then
    Result := haCenter
  else
    if value = 'left' then
      Result := haLeft
    else
      if value = 'right' then
        Result := haRight;
end;

function TdxHorizontalEdgeHelper.ToString: string;
begin
  case self of
    heLeft:
      Result := 'left';
    heRight:
      Result := 'right';
  end;
end;

class function TdxHorizontalEdgeHelper.FromString(const value: string): TdxHorizontalEdge;
begin
  Result := heLeft;

  if value = 'left' then
    Result := heLeft
  else
    if value = 'right' then
      Result := heRight;
end;

function TdxLabelModeHelper.ToString: string;
begin
  case self of
    lmFloating:
      Result := 'floating';
    lmHidden:
      Result := 'hidden';
    lmStatic:
      Result := 'static';
  end;
end;

class function TdxLabelModeHelper.FromString(const value: string): TdxLabelMode;
begin
  Result := lmFloating;

  if value = 'floating' then
    Result := lmFloating
  else
    if value = 'hidden' then
      Result := lmHidden
    else
      if value = 'static' then
        Result := lmStatic;
end;

function TdxMaskModeHelper.ToString: string;
begin
  case self of
    mmAlways:
      Result := 'always';
    mmOnFocus:
      Result := 'onFocus';
  end;
end;

class function TdxMaskModeHelper.FromString(const value: string): TdxMaskMode;
begin
  Result := mmAlways;

  if value = 'always' then
    Result := mmAlways
  else
    if value = 'onFocus' then
      Result := mmOnFocus;
end;

function TdxModeHelper.ToString: string;
begin
  case self of
    mAuto:
      Result := 'auto';
  end;
end;

class function TdxModeHelper.FromString(const value: string): TdxMode;
begin
  Result := mAuto;

  if value = 'auto' then
    Result := mAuto;
end;

function TdxOrientationHelper.ToString: string;
begin
  case self of
    oHorizontal:
      Result := 'horizontal';
    oVertical:
      Result := 'vertical';
  end;
end;

class function TdxOrientationHelper.FromString(const value: string): TdxOrientation;
begin
  Result := oHorizontal;

  if value = 'horizontal' then
    Result := oHorizontal
  else
    if value = 'vertical' then
      Result := oVertical;
end;

function TdxPageLoadModeHelper.ToString: string;
begin
  case self of
    plmNextButton:
      Result := 'nextButton';
    plmScrollBottom:
      Result := 'scrollBottom';
  end;
end;

class function TdxPageLoadModeHelper.FromString(const value: string): TdxPageLoadMode;
begin
  Result := plmNextButton;

  if value = 'nextButton' then
    Result := plmNextButton
  else
    if value = 'scrollBottom' then
      Result := plmScrollBottom;
end;

function TdxPageOrientationHelper.ToString: string;
begin
  case self of
    poLandscape:
      Result := 'landscape';
    poPortrait:
      Result := 'portrait';
  end;
end;

class function TdxPageOrientationHelper.FromString(const value: string): TdxPageOrientation;
begin
  Result := poLandscape;

  if value = 'landscape' then
    Result := poLandscape
  else
    if value = 'portrait' then
      Result := poPortrait;
end;

function TdxPositionHelper.ToString: string;
begin
  case self of
    pBottom:
      Result := 'bottom';
    pLeft:
      Result := 'left';
    pRight:
      Result := 'right';
    pTop:
      Result := 'top';
  end;
end;

class function TdxPositionHelper.FromString(const value: string): TdxPosition;
begin
  Result := pBottom;

  if value = 'bottom' then
    Result := pBottom
  else
    if value = 'left' then
      Result := pLeft
    else
      if value = 'right' then
        Result := pRight
      else
        if value = 'top' then
          Result := pTop;
end;

function TdxPositionAlignmentHelper.ToString: string;
begin
  case self of
    paBottom:
      Result := 'bottom';
    paCenter:
      Result := 'center';
    paLeft:
      Result := 'left';
    paLeftbottom:
      Result := 'leftbottom';
    paLefttop:
      Result := 'lefttop';
    paRight:
      Result := 'right';
    paRightbottom:
      Result := 'rightbottom';
    paRighttop:
      Result := 'righttop';
    paTop:
      Result := 'top';
  end;
end;

class function TdxPositionAlignmentHelper.FromString(const value: string): TdxPositionAlignment;
begin
  Result := paBottom;

  if value = 'bottom' then
    Result := paBottom
  else
    if value = 'center' then
      Result := paCenter
    else
      if value = 'left' then
        Result := paLeft
      else
        if value = 'leftbottom' then
          Result := paLeftbottom
        else
          if value = 'lefttop' then
            Result := paLefttop
          else
            if value = 'right' then
              Result := paRight
            else
              if value = 'rightbottom' then
                Result := paRightbottom
              else
                if value = 'righttop' then
                  Result := paRighttop
                else
                  if value = 'top' then
                    Result := paTop;
end;

function TdxScrollbarModeHelper.ToString: string;
begin
  case self of
    smAlways:
      Result := 'always';
    smNever:
      Result := 'never';
    smOnHover:
      Result := 'onHover';
    smOnScroll:
      Result := 'onScroll';
  end;
end;

class function TdxScrollbarModeHelper.FromString(const value: string): TdxScrollbarMode;
begin
  Result := smAlways;

  if value = 'always' then
    Result := smAlways
  else
    if value = 'never' then
      Result := smNever
    else
      if value = 'onHover' then
        Result := smOnHover
      else
        if value = 'onScroll' then
          Result := smOnScroll;
end;

function TdxScrollDirectionHelper.ToString: string;
begin
  case self of
    sdBoth:
      Result := 'both';
    sdHorizontal:
      Result := 'horizontal';
    sdVertical:
      Result := 'vertical';
  end;
end;

class function TdxScrollDirectionHelper.FromString(const value: string): TdxScrollDirection;
begin
  Result := sdBoth;

  if value = 'both' then
    Result := sdBoth
  else
    if value = 'horizontal' then
      Result := sdHorizontal
    else
      if value = 'vertical' then
        Result := sdVertical;
end;

function TdxScrollModeHelper.ToString: string;
begin
  case self of
    smStandard:
      Result := 'standard';
    smVirtual:
      Result := 'virtual';
  end;
end;

class function TdxScrollModeHelper.FromString(const value: string): TdxScrollMode;
begin
  Result := smStandard;

  if value = 'standard' then
    Result := smStandard
  else
    if value = 'virtual' then
      Result := smVirtual;
end;

function TdxSearchModeHelper.ToString: string;
begin
  case self of
    smContains:
      Result := 'contains';
    smEquals:
      Result := 'equals';
    smStartswith:
      Result := 'startswith';
  end;
end;

class function TdxSearchModeHelper.FromString(const value: string): TdxSearchMode;
begin
  Result := smContains;

  if value = 'contains' then
    Result := smContains
  else
    if value = 'equals' then
      Result := smEquals
    else
      if value = 'startswith' then
        Result := smStartswith;
end;

function TdxSelectAllModeHelper.ToString: string;
begin
  case self of
    samAllPages:
      Result := 'allPages';
    samPage:
      Result := 'page';
  end;
end;

class function TdxSelectAllModeHelper.FromString(const value: string): TdxSelectAllMode;
begin
  Result := samAllPages;

  if value = 'allPages' then
    Result := samAllPages
  else
    if value = 'page' then
      Result := samPage;
end;

function TdxSimplifiedSearchModeHelper.ToString: string;
begin
  case self of
    ssmContains:
      Result := 'contains';
    ssmStartswith:
      Result := 'startswith';
  end;
end;

class function TdxSimplifiedSearchModeHelper.FromString(const value: string): TdxSimplifiedSearchMode;
begin
  Result := ssmContains;

  if value = 'contains' then
    Result := ssmContains
  else
    if value = 'startswith' then
      Result := ssmStartswith;
end;

function TdxSingleMultipleAllOrNoneHelper.ToString: string;
begin
  case self of
    smaonAll:
      Result := 'all';
    smaonMultiple:
      Result := 'multiple';
    smaonNone:
      Result := 'none';
    smaonSingle:
      Result := 'single';
  end;
end;

class function TdxSingleMultipleAllOrNoneHelper.FromString(const value: string): TdxSingleMultipleAllOrNone;
begin
  Result := smaonAll;

  if value = 'all' then
    Result := smaonAll
  else
    if value = 'multiple' then
      Result := smaonMultiple
    else
      if value = 'none' then
        Result := smaonNone
      else
        if value = 'single' then
          Result := smaonSingle;
end;

function TdxSingleMultipleOrNoneHelper.ToString: string;
begin
  case self of
    smonMultiple:
      Result := 'multiple';
    smonNone:
      Result := 'none';
    smonSingle:
      Result := 'single';
  end;
end;

class function TdxSingleMultipleOrNoneHelper.FromString(const value: string): TdxSingleMultipleOrNone;
begin
  Result := smonMultiple;

  if value = 'multiple' then
    Result := smonMultiple
  else
    if value = 'none' then
      Result := smonNone
    else
      if value = 'single' then
        Result := smonSingle;
end;

function TdxSingleOrMultipleHelper.ToString: string;
begin
  case self of
    somMultiple:
      Result := 'multiple';
    somSingle:
      Result := 'single';
  end;
end;

class function TdxSingleOrMultipleHelper.FromString(const value: string): TdxSingleOrMultiple;
begin
  Result := somMultiple;

  if value = 'multiple' then
    Result := somMultiple
  else
    if value = 'single' then
      Result := somSingle;
end;

function TdxSingleOrNoneHelper.ToString: string;
begin
  case self of
    sonNone:
      Result := 'none';
    sonSingle:
      Result := 'single';
  end;
end;

class function TdxSingleOrNoneHelper.FromString(const value: string): TdxSingleOrNone;
begin
  Result := sonNone;

  if value = 'none' then
    Result := sonNone
  else
    if value = 'single' then
      Result := sonSingle;
end;

function TdxSliderValueChangeModeHelper.ToString: string;
begin
  case self of
    svcmOnHandleMove:
      Result := 'onHandleMove';
    svcmOnHandleRelease:
      Result := 'onHandleRelease';
  end;
end;

class function TdxSliderValueChangeModeHelper.FromString(const value: string): TdxSliderValueChangeMode;
begin
  Result := svcmOnHandleMove;

  if value = 'onHandleMove' then
    Result := svcmOnHandleMove
  else
    if value = 'onHandleRelease' then
      Result := svcmOnHandleRelease;
end;

function TdxSortOrderHelper.ToString: string;
begin
  case self of
    soAsc:
      Result := 'asc';
    soDesc:
      Result := 'desc';
  end;
end;

class function TdxSortOrderHelper.FromString(const value: string): TdxSortOrder;
begin
  Result := soAsc;

  if value = 'asc' then
    Result := soAsc
  else
    if value = 'desc' then
      Result := soDesc;
end;

function TdxStoreTypeHelper.ToString: string;
begin
  case self of
    stArray:
      Result := 'array';
    stLocal:
      Result := 'local';
    stOdata:
      Result := 'odata';
  end;
end;

class function TdxStoreTypeHelper.FromString(const value: string): TdxStoreType;
begin
  Result := stArray;

  if value = 'array' then
    Result := stArray
  else
    if value = 'local' then
      Result := stLocal
    else
      if value = 'odata' then
        Result := stOdata;
end;

function TdxSubmenuShowModeHelper.ToString: string;
begin
  case self of
    ssmOnClick:
      Result := 'onClick';
    ssmOnHover:
      Result := 'onHover';
  end;
end;

class function TdxSubmenuShowModeHelper.FromString(const value: string): TdxSubmenuShowMode;
begin
  Result := ssmOnClick;

  if value = 'onClick' then
    Result := ssmOnClick
  else
    if value = 'onHover' then
      Result := ssmOnHover;
end;

function TdxTextBoxPredefinedButtonHelper.ToString: string;
begin
  case self of
    tbpbClear:
      Result := 'clear';
  end;
end;

class function TdxTextBoxPredefinedButtonHelper.FromString(const value: string): TdxTextBoxPredefinedButton;
begin
  Result := tbpbClear;

  if value = 'clear' then
    Result := tbpbClear;
end;

function TdxTextEditorButtonLocationHelper.ToString: string;
begin
  case self of
    teblAfter:
      Result := 'after';
    teblBefore:
      Result := 'before';
  end;
end;

class function TdxTextEditorButtonLocationHelper.FromString(const value: string): TdxTextEditorButtonLocation;
begin
  Result := teblAfter;

  if value = 'after' then
    Result := teblAfter
  else
    if value = 'before' then
      Result := teblBefore;
end;

function TdxToolbarItemComponentHelper.ToString: string;
begin
  case self of
    ticDxAutocomplete:
      Result := 'dxAutocomplete';
    ticDxButton:
      Result := 'dxButton';
    ticDxButtonGroup:
      Result := 'dxButtonGroup';
    ticDxCheckBox:
      Result := 'dxCheckBox';
    ticDxDateBox:
      Result := 'dxDateBox';
    ticDxDropDownButton:
      Result := 'dxDropDownButton';
    ticDxMenu:
      Result := 'dxMenu';
    ticDxSelectBox:
      Result := 'dxSelectBox';
    ticDxTabs:
      Result := 'dxTabs';
    ticDxTextBox:
      Result := 'dxTextBox';
  end;
end;

class function TdxToolbarItemComponentHelper.FromString(const value: string): TdxToolbarItemComponent;
begin
  Result := ticDxAutocomplete;

  if value = 'dxAutocomplete' then
    Result := ticDxAutocomplete
  else
    if value = 'dxButton' then
      Result := ticDxButton
    else
      if value = 'dxButtonGroup' then
        Result := ticDxButtonGroup
      else
        if value = 'dxCheckBox' then
          Result := ticDxCheckBox
        else
          if value = 'dxDateBox' then
            Result := ticDxDateBox
          else
            if value = 'dxDropDownButton' then
              Result := ticDxDropDownButton
            else
              if value = 'dxMenu' then
                Result := ticDxMenu
              else
                if value = 'dxSelectBox' then
                  Result := ticDxSelectBox
                else
                  if value = 'dxTabs' then
                    Result := ticDxTabs
                  else
                    if value = 'dxTextBox' then
                      Result := ticDxTextBox;
end;

function TdxToolbarItemLocationHelper.ToString: string;
begin
  case self of
    tilAfter:
      Result := 'after';
    tilBefore:
      Result := 'before';
    tilCenter:
      Result := 'center';
  end;
end;

class function TdxToolbarItemLocationHelper.FromString(const value: string): TdxToolbarItemLocation;
begin
  Result := tilAfter;

  if value = 'after' then
    Result := tilAfter
  else
    if value = 'before' then
      Result := tilBefore
    else
      if value = 'center' then
        Result := tilCenter;
end;

function TdxTooltipShowModeHelper.ToString: string;
begin
  case self of
    tsmAlways:
      Result := 'always';
    tsmOnHover:
      Result := 'onHover';
  end;
end;

class function TdxTooltipShowModeHelper.FromString(const value: string): TdxTooltipShowMode;
begin
  Result := tsmAlways;

  if value = 'always' then
    Result := tsmAlways
  else
    if value = 'onHover' then
      Result := tsmOnHover;
end;

function TdxValidationMessageModeHelper.ToString: string;
begin
  case self of
    vmmAlways:
      Result := 'always';
    vmmAuto:
      Result := 'auto';
  end;
end;

class function TdxValidationMessageModeHelper.FromString(const value: string): TdxValidationMessageMode;
begin
  Result := vmmAlways;

  if value = 'always' then
    Result := vmmAlways
  else
    if value = 'auto' then
      Result := vmmAuto;
end;

function TdxValidationRuleTypeHelper.ToString: string;
begin
  case self of
    vrtAsync:
      Result := 'async';
    vrtCompare:
      Result := 'compare';
    vrtCustom:
      Result := 'custom';
    vrtEmail:
      Result := 'email';
    vrtNumeric:
      Result := 'numeric';
    vrtPattern:
      Result := 'pattern';
    vrtRange:
      Result := 'range';
    vrtRequired:
      Result := 'required';
    vrtStringLength:
      Result := 'stringLength';
  end;
end;

class function TdxValidationRuleTypeHelper.FromString(const value: string): TdxValidationRuleType;
begin
  Result := vrtAsync;

  if value = 'async' then
    Result := vrtAsync
  else
    if value = 'compare' then
      Result := vrtCompare
    else
      if value = 'custom' then
        Result := vrtCustom
      else
        if value = 'email' then
          Result := vrtEmail
        else
          if value = 'numeric' then
            Result := vrtNumeric
          else
            if value = 'pattern' then
              Result := vrtPattern
            else
              if value = 'range' then
                Result := vrtRange
              else
                if value = 'required' then
                  Result := vrtRequired
                else
                  if value = 'stringLength' then
                    Result := vrtStringLength;
end;

function TdxValidationStatusHelper.ToString: string;
begin
  case self of
    vsInvalid:
      Result := 'invalid';
    vsPending:
      Result := 'pending';
    vsValid:
      Result := 'valid';
  end;
end;

class function TdxValidationStatusHelper.FromString(const value: string): TdxValidationStatus;
begin
  Result := vsInvalid;

  if value = 'invalid' then
    Result := vsInvalid
  else
    if value = 'pending' then
      Result := vsPending
    else
      if value = 'valid' then
        Result := vsValid;
end;

function TdxVerticalAlignmentHelper.ToString: string;
begin
  case self of
    vaBottom:
      Result := 'bottom';
    vaCenter:
      Result := 'center';
    vaTop:
      Result := 'top';
  end;
end;

class function TdxVerticalAlignmentHelper.FromString(const value: string): TdxVerticalAlignment;
begin
  Result := vaBottom;

  if value = 'bottom' then
    Result := vaBottom
  else
    if value = 'center' then
      Result := vaCenter
    else
      if value = 'top' then
        Result := vaTop;
end;

function TdxVerticalEdgeHelper.ToString: string;
begin
  case self of
    veBottom:
      Result := 'bottom';
    veTop:
      Result := 'top';
  end;
end;

class function TdxVerticalEdgeHelper.FromString(const value: string): TdxVerticalEdge;
begin
  Result := veBottom;

  if value = 'bottom' then
    Result := veBottom
  else
    if value = 'top' then
      Result := veTop;
end;

function TCollectionWidgetSelectionModeHelper.ToString: string;
begin
  case self of
    cwsmAll:
      Result := 'all';
    cwsmMultiple:
      Result := 'multiple';
    cwsmNone:
      Result := 'none';
    cwsmSingle:
      Result := 'single';
  end;
end;

class function TCollectionWidgetSelectionModeHelper.FromString(const value: string): TCollectionWidgetSelectionMode;
begin
  Result := cwsmAll;

  if value = 'all' then
    Result := cwsmAll
  else
    if value = 'multiple' then
      Result := cwsmMultiple
    else
      if value = 'none' then
        Result := cwsmNone
      else
        if value = 'single' then
          Result := cwsmSingle;
end;

function TdxTextBoxTypeHelper.ToString: string;
begin
  case self of
    tbtEmail:
      Result := 'email';
    tbtPassword:
      Result := 'password';
    tbtSearch:
      Result := 'search';
    tbtTel:
      Result := 'tel';
    tbtText:
      Result := 'text';
    tbtUrl:
      Result := 'url';
  end;
end;

class function TdxTextBoxTypeHelper.FromString(const value: string): TdxTextBoxType;
begin
  Result := tbtEmail;

  if value = 'email' then
    Result := tbtEmail
  else
    if value = 'password' then
      Result := tbtPassword
    else
      if value = 'search' then
        Result := tbtSearch
      else
        if value = 'tel' then
          Result := tbtTel
        else
          if value = 'text' then
            Result := tbtText
          else
            if value = 'url' then
              Result := tbtUrl;
end;

function TdxDropDownPredefinedButtonHelper.ToString: string;
begin
  case self of
    ddpbClear:
      Result := 'clear';
    ddpbDropDown:
      Result := 'dropDown';
  end;
end;

class function TdxDropDownPredefinedButtonHelper.FromString(const value: string): TdxDropDownPredefinedButton;
begin
  Result := ddpbClear;

  if value = 'clear' then
    Result := ddpbClear
  else
    if value = 'dropDown' then
      Result := ddpbDropDown;
end;

function TdxGaugeIndicatorTypeHelper.ToString: string;
begin
  case self of
    gitCircle:
      Result := 'circle';
    gitRangeBar:
      Result := 'rangeBar';
    gitRectangle:
      Result := 'rectangle';
    gitRectangleNeedle:
      Result := 'rectangleNeedle';
    gitRhombus:
      Result := 'rhombus';
    gitTextCloud:
      Result := 'textCloud';
    gitTriangleMarker:
      Result := 'triangleMarker';
    gitTriangleNeedle:
      Result := 'triangleNeedle';
    gitTwoColorNeedle:
      Result := 'twoColorNeedle';
  end;
end;

class function TdxGaugeIndicatorTypeHelper.FromString(const value: string): TdxGaugeIndicatorType;
begin
  Result := gitCircle;

  if value = 'circle' then
    Result := gitCircle
  else
    if value = 'rangeBar' then
      Result := gitRangeBar
    else
      if value = 'rectangle' then
        Result := gitRectangle
      else
        if value = 'rectangleNeedle' then
          Result := gitRectangleNeedle
        else
          if value = 'rhombus' then
            Result := gitRhombus
          else
            if value = 'textCloud' then
              Result := gitTextCloud
            else
              if value = 'triangleMarker' then
                Result := gitTriangleMarker
              else
                if value = 'triangleNeedle' then
                  Result := gitTriangleNeedle
                else
                  if value = 'twoColorNeedle' then
                    Result := gitTwoColorNeedle;
end;

function TdxBoxDirectionHelper.ToString: string;
begin
  case self of
    bdCol:
      Result := 'col';
    bdRow:
      Result := 'row';
  end;
end;

class function TdxBoxDirectionHelper.FromString(const value: string): TdxBoxDirection;
begin
  Result := bdCol;

  if value = 'col' then
    Result := bdCol
  else
    if value = 'row' then
      Result := bdRow;
end;

function TdxCrosswiseDistributionHelper.ToString: string;
begin
  case self of
    cdCenter:
      Result := 'center';
    cdEnd:
      Result := 'end';
    cdStart:
      Result := 'start';
    cdStretch:
      Result := 'stretch';
  end;
end;

class function TdxCrosswiseDistributionHelper.FromString(const value: string): TdxCrosswiseDistribution;
begin
  Result := cdCenter;

  if value = 'center' then
    Result := cdCenter
  else
    if value = 'end' then
      Result := cdEnd
    else
      if value = 'start' then
        Result := cdStart
      else
        if value = 'stretch' then
          Result := cdStretch;
end;

function TdxDistributionHelper.ToString: string;
begin
  case self of
    dCenter:
      Result := 'center';
    dEnd:
      Result := 'end';
    dSpacearound:
      Result := 'spacearound';
    dSpacebetween:
      Result := 'spacebetween';
    dStart:
      Result := 'start';
  end;
end;

class function TdxDistributionHelper.FromString(const value: string): TdxDistribution;
begin
  Result := dCenter;

  if value = 'center' then
    Result := dCenter
  else
    if value = 'end' then
      Result := dEnd
    else
      if value = 'spacearound' then
        Result := dSpacearound
      else
        if value = 'spacebetween' then
          Result := dSpacebetween
        else
          if value = 'start' then
            Result := dStart;
end;

function TdxCalendarZoomLevelHelper.ToString: string;
begin
  case self of
    czlCentury:
      Result := 'century';
    czlDecade:
      Result := 'decade';
    czlMonth:
      Result := 'month';
    czlYear:
      Result := 'year';
  end;
end;

class function TdxCalendarZoomLevelHelper.FromString(const value: string): TdxCalendarZoomLevel;
begin
  Result := czlCentury;

  if value = 'century' then
    Result := czlCentury
  else
    if value = 'decade' then
      Result := czlDecade
    else
      if value = 'month' then
        Result := czlMonth
      else
        if value = 'year' then
          Result := czlYear;
end;

function TdxWeekNumberRuleHelper.ToString: string;
begin
  case self of
    wnrAuto:
      Result := 'auto';
    wnrFirstDay:
      Result := 'firstDay';
    wnrFirstFourDays:
      Result := 'firstFourDays';
    wnrFullWeek:
      Result := 'fullWeek';
  end;
end;

class function TdxWeekNumberRuleHelper.FromString(const value: string): TdxWeekNumberRule;
begin
  Result := wnrAuto;

  if value = 'auto' then
    Result := wnrAuto
  else
    if value = 'firstDay' then
      Result := wnrFirstDay
    else
      if value = 'firstFourDays' then
        Result := wnrFirstFourDays
      else
        if value = 'fullWeek' then
          Result := wnrFullWeek;
end;

function TdxAggregatedPointsPositionHelper.ToString: string;
begin
  case self of
    appBetweenTicks:
      Result := 'betweenTicks';
    appCrossTicks:
      Result := 'crossTicks';
  end;
end;

class function TdxAggregatedPointsPositionHelper.FromString(const value: string): TdxAggregatedPointsPosition;
begin
  Result := appBetweenTicks;

  if value = 'betweenTicks' then
    Result := appBetweenTicks
  else
    if value = 'crossTicks' then
      Result := appCrossTicks;
end;

function TdxChartBubbleSeriesAggregationMethodHelper.ToString: string;
begin
  case self of
    cbsamAvg:
      Result := 'avg';
    cbsamCustom:
      Result := 'custom';
  end;
end;

class function TdxChartBubbleSeriesAggregationMethodHelper.FromString(const value: string): TdxChartBubbleSeriesAggregationMethod;
begin
  Result := cbsamAvg;

  if value = 'avg' then
    Result := cbsamAvg
  else
    if value = 'custom' then
      Result := cbsamCustom;
end;

function TdxChartFinancialSeriesAggregationMethodHelper.ToString: string;
begin
  case self of
    cfsamCustom:
      Result := 'custom';
    cfsamOhlc:
      Result := 'ohlc';
  end;
end;

class function TdxChartFinancialSeriesAggregationMethodHelper.FromString(const value: string): TdxChartFinancialSeriesAggregationMethod;
begin
  Result := cfsamCustom;

  if value = 'custom' then
    Result := cfsamCustom
  else
    if value = 'ohlc' then
      Result := cfsamOhlc;
end;

function TdxChartLabelDisplayModeHelper.ToString: string;
begin
  case self of
    cldmRotate:
      Result := 'rotate';
    cldmStagger:
      Result := 'stagger';
    cldmStandard:
      Result := 'standard';
  end;
end;

class function TdxChartLabelDisplayModeHelper.FromString(const value: string): TdxChartLabelDisplayMode;
begin
  Result := cldmRotate;

  if value = 'rotate' then
    Result := cldmRotate
  else
    if value = 'stagger' then
      Result := cldmStagger
    else
      if value = 'standard' then
        Result := cldmStandard;
end;

function TdxChartRangeSeriesAggregationMethodHelper.ToString: string;
begin
  case self of
    crsamCustom:
      Result := 'custom';
    crsamRange:
      Result := 'range';
  end;
end;

class function TdxChartRangeSeriesAggregationMethodHelper.FromString(const value: string): TdxChartRangeSeriesAggregationMethod;
begin
  Result := crsamCustom;

  if value = 'custom' then
    Result := crsamCustom
  else
    if value = 'range' then
      Result := crsamRange;
end;

function TdxChartSeriesAggregationMethodHelper.ToString: string;
begin
  case self of
    csamAvg:
      Result := 'avg';
    csamCount:
      Result := 'count';
    csamCustom:
      Result := 'custom';
    csamMax:
      Result := 'max';
    csamMin:
      Result := 'min';
    csamOhlc:
      Result := 'ohlc';
    csamRange:
      Result := 'range';
    csamSum:
      Result := 'sum';
  end;
end;

class function TdxChartSeriesAggregationMethodHelper.FromString(const value: string): TdxChartSeriesAggregationMethod;
begin
  Result := csamAvg;

  if value = 'avg' then
    Result := csamAvg
  else
    if value = 'count' then
      Result := csamCount
    else
      if value = 'custom' then
        Result := csamCustom
      else
        if value = 'max' then
          Result := csamMax
        else
          if value = 'min' then
            Result := csamMin
          else
            if value = 'ohlc' then
              Result := csamOhlc
            else
              if value = 'range' then
                Result := csamRange
              else
                if value = 'sum' then
                  Result := csamSum;
end;

function TdxChartSingleValueSeriesAggregationMethodHelper.ToString: string;
begin
  case self of
    csvsamAvg:
      Result := 'avg';
    csvsamCount:
      Result := 'count';
    csvsamCustom:
      Result := 'custom';
    csvsamMax:
      Result := 'max';
    csvsamMin:
      Result := 'min';
    csvsamSum:
      Result := 'sum';
  end;
end;

class function TdxChartSingleValueSeriesAggregationMethodHelper.FromString(const value: string): TdxChartSingleValueSeriesAggregationMethod;
begin
  Result := csvsamAvg;

  if value = 'avg' then
    Result := csvsamAvg
  else
    if value = 'count' then
      Result := csvsamCount
    else
      if value = 'custom' then
        Result := csvsamCustom
      else
        if value = 'max' then
          Result := csvsamMax
        else
          if value = 'min' then
            Result := csvsamMin
          else
            if value = 'sum' then
              Result := csvsamSum;
end;

function TdxChartTooltipLocationHelper.ToString: string;
begin
  case self of
    ctlCenter:
      Result := 'center';
    ctlEdge:
      Result := 'edge';
  end;
end;

class function TdxChartTooltipLocationHelper.FromString(const value: string): TdxChartTooltipLocation;
begin
  Result := ctlCenter;

  if value = 'center' then
    Result := ctlCenter
  else
    if value = 'edge' then
      Result := ctlEdge;
end;

function TdxChartZoomAndPanModeHelper.ToString: string;
begin
  case self of
    czapmBoth:
      Result := 'both';
    czapmNone:
      Result := 'none';
    czapmPan:
      Result := 'pan';
    czapmZoom:
      Result := 'zoom';
  end;
end;

class function TdxChartZoomAndPanModeHelper.FromString(const value: string): TdxChartZoomAndPanMode;
begin
  Result := czapmBoth;

  if value = 'both' then
    Result := czapmBoth
  else
    if value = 'none' then
      Result := czapmNone
    else
      if value = 'pan' then
        Result := czapmPan
      else
        if value = 'zoom' then
          Result := czapmZoom;
end;

function TdxEventKeyModifierHelper.ToString: string;
begin
  case self of
    ekmAlt:
      Result := 'alt';
    ekmCtrl:
      Result := 'ctrl';
    ekmMeta:
      Result := 'meta';
    ekmShift:
      Result := 'shift';
  end;
end;

class function TdxEventKeyModifierHelper.FromString(const value: string): TdxEventKeyModifier;
begin
  Result := ekmAlt;

  if value = 'alt' then
    Result := ekmAlt
  else
    if value = 'ctrl' then
      Result := ekmCtrl
    else
      if value = 'meta' then
        Result := ekmMeta
      else
        if value = 'shift' then
          Result := ekmShift;
end;

function TdxFinancialChartReductionLevelHelper.ToString: string;
begin
  case self of
    fcrlClose:
      Result := 'close';
    fcrlHigh:
      Result := 'high';
    fcrlLow:
      Result := 'low';
    fcrlOpen:
      Result := 'open';
  end;
end;

class function TdxFinancialChartReductionLevelHelper.FromString(const value: string): TdxFinancialChartReductionLevel;
begin
  Result := fcrlClose;

  if value = 'close' then
    Result := fcrlClose
  else
    if value = 'high' then
      Result := fcrlHigh
    else
      if value = 'low' then
        Result := fcrlLow
      else
        if value = 'open' then
          Result := fcrlOpen;
end;

function TdxCircularGaugeElementOrientationHelper.ToString: string;
begin
  case self of
    cgeoCenter:
      Result := 'center';
    cgeoInside:
      Result := 'inside';
    cgeoOutside:
      Result := 'outside';
  end;
end;

class function TdxCircularGaugeElementOrientationHelper.FromString(const value: string): TdxCircularGaugeElementOrientation;
begin
  Result := cgeoCenter;

  if value = 'center' then
    Result := cgeoCenter
  else
    if value = 'inside' then
      Result := cgeoInside
    else
      if value = 'outside' then
        Result := cgeoOutside;
end;

function TdxCircularGaugeLabelOverlapHelper.ToString: string;
begin
  case self of
    cgloFirst:
      Result := 'first';
    cgloLast:
      Result := 'last';
  end;
end;

class function TdxCircularGaugeLabelOverlapHelper.FromString(const value: string): TdxCircularGaugeLabelOverlap;
begin
  Result := cgloFirst;

  if value = 'first' then
    Result := cgloFirst
  else
    if value = 'last' then
      Result := cgloLast;
end;

function TdxContextSubmenuDirectionHelper.ToString: string;
begin
  case self of
    csdAuto:
      Result := 'auto';
    csdLeft:
      Result := 'left';
    csdRight:
      Result := 'right';
  end;
end;

class function TdxContextSubmenuDirectionHelper.FromString(const value: string): TdxContextSubmenuDirection;
begin
  Result := csdAuto;

  if value = 'auto' then
    Result := csdAuto
  else
    if value = 'left' then
      Result := csdLeft
    else
      if value = 'right' then
        Result := csdRight;
end;

function TdxDataGridCommandColumnTypeHelper.ToString: string;
begin
  case self of
    dgcctAdaptive:
      Result := 'adaptive';
    dgcctButtons:
      Result := 'buttons';
    dgcctDetailExpand:
      Result := 'detailExpand';
    dgcctDrag:
      Result := 'drag';
    dgcctGroupExpand:
      Result := 'groupExpand';
    dgcctSelection:
      Result := 'selection';
  end;
end;

class function TdxDataGridCommandColumnTypeHelper.FromString(const value: string): TdxDataGridCommandColumnType;
begin
  Result := dgcctAdaptive;

  if value = 'adaptive' then
    Result := dgcctAdaptive
  else
    if value = 'buttons' then
      Result := dgcctButtons
    else
      if value = 'detailExpand' then
        Result := dgcctDetailExpand
      else
        if value = 'drag' then
          Result := dgcctDrag
        else
          if value = 'groupExpand' then
            Result := dgcctGroupExpand
          else
            if value = 'selection' then
              Result := dgcctSelection;
end;

function TdxDataGridExportFormatHelper.ToString: string;
begin
  case self of
    dgefPdf:
      Result := 'pdf';
    dgefXlsx:
      Result := 'xlsx';
  end;
end;

class function TdxDataGridExportFormatHelper.FromString(const value: string): TdxDataGridExportFormat;
begin
  Result := dgefPdf;

  if value = 'pdf' then
    Result := dgefPdf
  else
    if value = 'xlsx' then
      Result := dgefXlsx;
end;

function TdxDataGridPredefinedColumnButtonHelper.ToString: string;
begin
  case self of
    dgpcbCancel:
      Result := 'cancel';
    dgpcbDelete:
      Result := 'delete';
    dgpcbEdit:
      Result := 'edit';
    dgpcbSave:
      Result := 'save';
    dgpcbUndelete:
      Result := 'undelete';
  end;
end;

class function TdxDataGridPredefinedColumnButtonHelper.FromString(const value: string): TdxDataGridPredefinedColumnButton;
begin
  Result := dgpcbCancel;

  if value = 'cancel' then
    Result := dgpcbCancel
  else
    if value = 'delete' then
      Result := dgpcbDelete
    else
      if value = 'edit' then
        Result := dgpcbEdit
      else
        if value = 'save' then
          Result := dgpcbSave
        else
          if value = 'undelete' then
            Result := dgpcbUndelete;
end;

function TdxDataGridPredefinedToolbarItemHelper.ToString: string;
begin
  case self of
    dgptiAddRowButton:
      Result := 'addRowButton';
    dgptiApplyFilterButton:
      Result := 'applyFilterButton';
    dgptiColumnChooserButton:
      Result := 'columnChooserButton';
    dgptiExportButton:
      Result := 'exportButton';
    dgptiGroupPanel:
      Result := 'groupPanel';
    dgptiRevertButton:
      Result := 'revertButton';
    dgptiSaveButton:
      Result := 'saveButton';
    dgptiSearchPanel:
      Result := 'searchPanel';
  end;
end;

class function TdxDataGridPredefinedToolbarItemHelper.FromString(const value: string): TdxDataGridPredefinedToolbarItem;
begin
  Result := dgptiAddRowButton;

  if value = 'addRowButton' then
    Result := dgptiAddRowButton
  else
    if value = 'applyFilterButton' then
      Result := dgptiApplyFilterButton
    else
      if value = 'columnChooserButton' then
        Result := dgptiColumnChooserButton
      else
        if value = 'exportButton' then
          Result := dgptiExportButton
        else
          if value = 'groupPanel' then
            Result := dgptiGroupPanel
          else
            if value = 'revertButton' then
              Result := dgptiRevertButton
            else
              if value = 'saveButton' then
                Result := dgptiSaveButton
              else
                if value = 'searchPanel' then
                  Result := dgptiSearchPanel;
end;

function TdxDataGridScrollModeHelper.ToString: string;
begin
  case self of
    dgsmInfinite:
      Result := 'infinite';
    dgsmStandard:
      Result := 'standard';
    dgsmVirtual:
      Result := 'virtual';
  end;
end;

class function TdxDataGridScrollModeHelper.FromString(const value: string): TdxDataGridScrollMode;
begin
  Result := dgsmInfinite;

  if value = 'infinite' then
    Result := dgsmInfinite
  else
    if value = 'standard' then
      Result := dgsmStandard
    else
      if value = 'virtual' then
        Result := dgsmVirtual;
end;

function TdxDatePickerTypeHelper.ToString: string;
begin
  case self of
    dptCalendar:
      Result := 'calendar';
    dptList:
      Result := 'list';
    dptNative:
      Result := 'native';
    dptRollers:
      Result := 'rollers';
  end;
end;

class function TdxDatePickerTypeHelper.FromString(const value: string): TdxDatePickerType;
begin
  Result := dptCalendar;

  if value = 'calendar' then
    Result := dptCalendar
  else
    if value = 'list' then
      Result := dptList
    else
      if value = 'native' then
        Result := dptNative
      else
        if value = 'rollers' then
          Result := dptRollers;
end;

function TdxDateTypeHelper.ToString: string;
begin
  case self of
    dttDate:
      Result := 'date';
    dttDatetime:
      Result := 'datetime';
    dttTime:
      Result := 'time';
  end;
end;

class function TdxDateTypeHelper.FromString(const value: string): TdxDateType;
begin
  Result := dttDate;

  if value = 'date' then
    Result := dttDate
  else
    if value = 'datetime' then
      Result := dttDatetime
    else
      if value = 'time' then
        Result := dttTime;
end;

function TdxDiagramAutoZoomModeHelper.ToString: string;
begin
  case self of
    dazmDisabled:
      Result := 'disabled';
    dazmFitContent:
      Result := 'fitContent';
    dazmFitWidth:
      Result := 'fitWidth';
  end;
end;

class function TdxDiagramAutoZoomModeHelper.FromString(const value: string): TdxDiagramAutoZoomMode;
begin
  Result := dazmDisabled;

  if value = 'disabled' then
    Result := dazmDisabled
  else
    if value = 'fitContent' then
      Result := dazmFitContent
    else
      if value = 'fitWidth' then
        Result := dazmFitWidth;
end;

function TdxDiagramCommandHelper.ToString: string;
begin
  case self of
    dcBold:
      Result := 'bold';
    dcBringToFront:
      Result := 'bringToFront';
    dcConnectorLineEnd:
      Result := 'connectorLineEnd';
    dcConnectorLineStart:
      Result := 'connectorLineStart';
    dcConnectorLineType:
      Result := 'connectorLineType';
    dcCopy:
      Result := 'copy';
    dcCut:
      Result := 'cut';
    dcDelete:
      Result := 'delete';
    dcDeleteShapeImage:
      Result := 'deleteShapeImage';
    dcEditShapeImage:
      Result := 'editShapeImage';
    dcExportJpg:
      Result := 'exportJpg';
    dcExportPng:
      Result := 'exportPng';
    dcExportSvg:
      Result := 'exportSvg';
    dcFillColor:
      Result := 'fillColor';
    dcFontColor:
      Result := 'fontColor';
    dcFontName:
      Result := 'fontName';
    dcFontSize:
      Result := 'fontSize';
    dcFullScreen:
      Result := 'fullScreen';
    dcGridSize:
      Result := 'gridSize';
    dcInsertShapeImage:
      Result := 'insertShapeImage';
    dcItalic:
      Result := 'italic';
    dcLayoutLayeredBottomToTop:
      Result := 'layoutLayeredBottomToTop';
    dcLayoutLayeredLeftToRight:
      Result := 'layoutLayeredLeftToRight';
    dcLayoutLayeredRightToLeft:
      Result := 'layoutLayeredRightToLeft';
    dcLayoutLayeredTopToBottom:
      Result := 'layoutLayeredTopToBottom';
    dcLayoutTreeBottomToTop:
      Result := 'layoutTreeBottomToTop';
    dcLayoutTreeLeftToRight:
      Result := 'layoutTreeLeftToRight';
    dcLayoutTreeRightToLeft:
      Result := 'layoutTreeRightToLeft';
    dcLayoutTreeTopToBottom:
      Result := 'layoutTreeTopToBottom';
    dcLineColor:
      Result := 'lineColor';
    dcLineStyle:
      Result := 'lineStyle';
    dcLineWidth:
      Result := 'lineWidth';
    dcLock:
      Result := 'lock';
    dcPageColor:
      Result := 'pageColor';
    dcPageOrientation:
      Result := 'pageOrientation';
    dcPageSize:
      Result := 'pageSize';
    dcPaste:
      Result := 'paste';
    dcRedo:
      Result := 'redo';
    dcSelectAll:
      Result := 'selectAll';
    dcSendToBack:
      Result := 'sendToBack';
    dcSeparator:
      Result := 'separator';
    dcShowGrid:
      Result := 'showGrid';
    dcSimpleView:
      Result := 'simpleView';
    dcSnapToGrid:
      Result := 'snapToGrid';
    dcTextAlignCenter:
      Result := 'textAlignCenter';
    dcTextAlignLeft:
      Result := 'textAlignLeft';
    dcTextAlignRight:
      Result := 'textAlignRight';
    dcToolbox:
      Result := 'toolbox';
    dcUnderline:
      Result := 'underline';
    dcUndo:
      Result := 'undo';
    dcUnits:
      Result := 'units';
    dcUnlock:
      Result := 'unlock';
    dcZoomLevel:
      Result := 'zoomLevel';
  end;
end;

class function TdxDiagramCommandHelper.FromString(const value: string): TdxDiagramCommand;
begin
  Result := dcBold;

  if value = 'bold' then
    Result := dcBold
  else
    if value = 'bringToFront' then
      Result := dcBringToFront
    else
      if value = 'connectorLineEnd' then
        Result := dcConnectorLineEnd
      else
        if value = 'connectorLineStart' then
          Result := dcConnectorLineStart
        else
          if value = 'connectorLineType' then
            Result := dcConnectorLineType
          else
            if value = 'copy' then
              Result := dcCopy
            else
              if value = 'cut' then
                Result := dcCut
              else
                if value = 'delete' then
                  Result := dcDelete
                else
                  if value = 'deleteShapeImage' then
                    Result := dcDeleteShapeImage
                  else
                    if value = 'editShapeImage' then
                      Result := dcEditShapeImage
                    else
                      if value = 'exportJpg' then
                        Result := dcExportJpg
                      else
                        if value = 'exportPng' then
                          Result := dcExportPng
                        else
                          if value = 'exportSvg' then
                            Result := dcExportSvg
                          else
                            if value = 'fillColor' then
                              Result := dcFillColor
                            else
                              if value = 'fontColor' then
                                Result := dcFontColor
                              else
                                if value = 'fontName' then
                                  Result := dcFontName
                                else
                                  if value = 'fontSize' then
                                    Result := dcFontSize
                                  else
                                    if value = 'fullScreen' then
                                      Result := dcFullScreen
                                    else
                                      if value = 'gridSize' then
                                        Result := dcGridSize
                                      else
                                        if value = 'insertShapeImage' then
                                        Result := dcInsertShapeImage
                                        else
                                        if value = 'italic' then
                                        Result := dcItalic
                                        else
                                        if value = 'layoutLayeredBottomToTop' then
                                        Result := dcLayoutLayeredBottomToTop
                                        else
                                        if value = 'layoutLayeredLeftToRight' then
                                        Result := dcLayoutLayeredLeftToRight
                                        else
                                        if value = 'layoutLayeredRightToLeft' then
                                        Result := dcLayoutLayeredRightToLeft
                                        else
                                        if value = 'layoutLayeredTopToBottom' then
                                        Result := dcLayoutLayeredTopToBottom
                                        else
                                        if value = 'layoutTreeBottomToTop' then
                                        Result := dcLayoutTreeBottomToTop
                                        else
                                        if value = 'layoutTreeLeftToRight' then
                                        Result := dcLayoutTreeLeftToRight
                                        else
                                        if value = 'layoutTreeRightToLeft' then
                                        Result := dcLayoutTreeRightToLeft
                                        else
                                        if value = 'layoutTreeTopToBottom' then
                                        Result := dcLayoutTreeTopToBottom
                                        else
                                        if value = 'lineColor' then
                                        Result := dcLineColor
                                        else
                                        if value = 'lineStyle' then
                                        Result := dcLineStyle
                                        else
                                        if value = 'lineWidth' then
                                        Result := dcLineWidth
                                        else
                                        if value = 'lock' then
                                        Result := dcLock
                                        else
                                        if value = 'pageColor' then
                                        Result := dcPageColor
                                        else
                                        if value = 'pageOrientation' then
                                        Result := dcPageOrientation
                                        else
                                        if value = 'pageSize' then
                                        Result := dcPageSize
                                        else
                                        if value = 'paste' then
                                        Result := dcPaste
                                        else
                                        if value = 'redo' then
                                        Result := dcRedo
                                        else
                                        if value = 'selectAll' then
                                        Result := dcSelectAll
                                        else
                                        if value = 'sendToBack' then
                                        Result := dcSendToBack
                                        else
                                        if value = 'separator' then
                                        Result := dcSeparator
                                        else
                                        if value = 'showGrid' then
                                        Result := dcShowGrid
                                        else
                                        if value = 'simpleView' then
                                        Result := dcSimpleView
                                        else
                                        if value = 'snapToGrid' then
                                        Result := dcSnapToGrid
                                        else
                                        if value = 'textAlignCenter' then
                                        Result := dcTextAlignCenter
                                        else
                                        if value = 'textAlignLeft' then
                                        Result := dcTextAlignLeft
                                        else
                                        if value = 'textAlignRight' then
                                        Result := dcTextAlignRight
                                        else
                                        if value = 'toolbox' then
                                        Result := dcToolbox
                                        else
                                        if value = 'underline' then
                                        Result := dcUnderline
                                        else
                                        if value = 'undo' then
                                        Result := dcUndo
                                        else
                                        if value = 'units' then
                                        Result := dcUnits
                                        else
                                        if value = 'unlock' then
                                        Result := dcUnlock
                                        else
                                        if value = 'zoomLevel' then
                                        Result := dcZoomLevel;
end;

function TdxDiagramConnectorLineEndHelper.ToString: string;
begin
  case self of
    dcleArrow:
      Result := 'arrow';
    dcleFilledTriangle:
      Result := 'filledTriangle';
    dcleNone:
      Result := 'none';
    dcleOutlinedTriangle:
      Result := 'outlinedTriangle';
  end;
end;

class function TdxDiagramConnectorLineEndHelper.FromString(const value: string): TdxDiagramConnectorLineEnd;
begin
  Result := dcleArrow;

  if value = 'arrow' then
    Result := dcleArrow
  else
    if value = 'filledTriangle' then
      Result := dcleFilledTriangle
    else
      if value = 'none' then
        Result := dcleNone
      else
        if value = 'outlinedTriangle' then
          Result := dcleOutlinedTriangle;
end;

function TdxDiagramConnectorLineTypeHelper.ToString: string;
begin
  case self of
    dcltOrthogonal:
      Result := 'orthogonal';
    dcltStraight:
      Result := 'straight';
  end;
end;

class function TdxDiagramConnectorLineTypeHelper.FromString(const value: string): TdxDiagramConnectorLineType;
begin
  Result := dcltOrthogonal;

  if value = 'orthogonal' then
    Result := dcltOrthogonal
  else
    if value = 'straight' then
      Result := dcltStraight;
end;

function TdxDiagramConnectorPositionHelper.ToString: string;
begin
  case self of
    dcpEnd:
      Result := 'end';
    dcpStart:
      Result := 'start';
  end;
end;

class function TdxDiagramConnectorPositionHelper.FromString(const value: string): TdxDiagramConnectorPosition;
begin
  Result := dcpEnd;

  if value = 'end' then
    Result := dcpEnd
  else
    if value = 'start' then
      Result := dcpStart;
end;

function TdxDiagramDataLayoutTypeHelper.ToString: string;
begin
  case self of
    ddltAuto:
      Result := 'auto';
    ddltLayered:
      Result := 'layered';
    ddltOff:
      Result := 'off';
    ddltTree:
      Result := 'tree';
  end;
end;

class function TdxDiagramDataLayoutTypeHelper.FromString(const value: string): TdxDiagramDataLayoutType;
begin
  Result := ddltAuto;

  if value = 'auto' then
    Result := ddltAuto
  else
    if value = 'layered' then
      Result := ddltLayered
    else
      if value = 'off' then
        Result := ddltOff
      else
        if value = 'tree' then
          Result := ddltTree;
end;

function TdxDiagramExportFormatHelper.ToString: string;
begin
  case self of
    defJpg:
      Result := 'jpg';
    defPng:
      Result := 'png';
    defSvg:
      Result := 'svg';
  end;
end;

class function TdxDiagramExportFormatHelper.FromString(const value: string): TdxDiagramExportFormat;
begin
  Result := defJpg;

  if value = 'jpg' then
    Result := defJpg
  else
    if value = 'png' then
      Result := defPng
    else
      if value = 'svg' then
        Result := defSvg;
end;

function TdxDiagramItemTypeHelper.ToString: string;
begin
  case self of
    ditConnector:
      Result := 'connector';
    ditShape:
      Result := 'shape';
  end;
end;

class function TdxDiagramItemTypeHelper.FromString(const value: string): TdxDiagramItemType;
begin
  Result := ditConnector;

  if value = 'connector' then
    Result := ditConnector
  else
    if value = 'shape' then
      Result := ditShape;
end;

function TdxDiagramModelOperationHelper.ToString: string;
begin
  case self of
    dmoAddShape:
      Result := 'addShape';
    dmoAddShapeFromToolbox:
      Result := 'addShapeFromToolbox';
    dmoBeforeChangeConnectorText:
      Result := 'beforeChangeConnectorText';
    dmoBeforeChangeShapeText:
      Result := 'beforeChangeShapeText';
    dmoChangeConnection:
      Result := 'changeConnection';
    dmoChangeConnectorPoints:
      Result := 'changeConnectorPoints';
    dmoChangeConnectorText:
      Result := 'changeConnectorText';
    dmoChangeShapeText:
      Result := 'changeShapeText';
    dmoDeleteConnector:
      Result := 'deleteConnector';
    dmoDeleteShape:
      Result := 'deleteShape';
    dmoMoveShape:
      Result := 'moveShape';
    dmoResizeShape:
      Result := 'resizeShape';
  end;
end;

class function TdxDiagramModelOperationHelper.FromString(const value: string): TdxDiagramModelOperation;
begin
  Result := dmoAddShape;

  if value = 'addShape' then
    Result := dmoAddShape
  else
    if value = 'addShapeFromToolbox' then
      Result := dmoAddShapeFromToolbox
    else
      if value = 'beforeChangeConnectorText' then
        Result := dmoBeforeChangeConnectorText
      else
        if value = 'beforeChangeShapeText' then
          Result := dmoBeforeChangeShapeText
        else
          if value = 'changeConnection' then
            Result := dmoChangeConnection
          else
            if value = 'changeConnectorPoints' then
              Result := dmoChangeConnectorPoints
            else
              if value = 'changeConnectorText' then
                Result := dmoChangeConnectorText
              else
                if value = 'changeShapeText' then
                  Result := dmoChangeShapeText
                else
                  if value = 'deleteConnector' then
                    Result := dmoDeleteConnector
                  else
                    if value = 'deleteShape' then
                      Result := dmoDeleteShape
                    else
                      if value = 'moveShape' then
                        Result := dmoMoveShape
                      else
                        if value = 'resizeShape' then
                          Result := dmoResizeShape;
end;

function TdxDiagramPanelVisibilityHelper.ToString: string;
begin
  case self of
    dpvAuto:
      Result := 'auto';
    dpvCollapsed:
      Result := 'collapsed';
    dpvDisabled:
      Result := 'disabled';
    dpvVisible:
      Result := 'visible';
  end;
end;

class function TdxDiagramPanelVisibilityHelper.FromString(const value: string): TdxDiagramPanelVisibility;
begin
  Result := dpvAuto;

  if value = 'auto' then
    Result := dpvAuto
  else
    if value = 'collapsed' then
      Result := dpvCollapsed
    else
      if value = 'disabled' then
        Result := dpvDisabled
      else
        if value = 'visible' then
          Result := dpvVisible;
end;

function TdxDiagramRequestEditOperationReasonHelper.ToString: string;
begin
  case self of
    dreorCheckUIElementAvailability:
      Result := 'checkUIElementAvailability';
    dreorModelModification:
      Result := 'modelModification';
  end;
end;

class function TdxDiagramRequestEditOperationReasonHelper.FromString(const value: string): TdxDiagramRequestEditOperationReason;
begin
  Result := dreorCheckUIElementAvailability;

  if value = 'checkUIElementAvailability' then
    Result := dreorCheckUIElementAvailability
  else
    if value = 'modelModification' then
      Result := dreorModelModification;
end;

function TdxDiagramShapeCategoryHelper.ToString: string;
begin
  case self of
    dscContainers:
      Result := 'containers';
    dscCustom:
      Result := 'custom';
    dscFlowchart:
      Result := 'flowchart';
    dscGeneral:
      Result := 'general';
    dscOrgChart:
      Result := 'orgChart';
  end;
end;

class function TdxDiagramShapeCategoryHelper.FromString(const value: string): TdxDiagramShapeCategory;
begin
  Result := dscContainers;

  if value = 'containers' then
    Result := dscContainers
  else
    if value = 'custom' then
      Result := dscCustom
    else
      if value = 'flowchart' then
        Result := dscFlowchart
      else
        if value = 'general' then
          Result := dscGeneral
        else
          if value = 'orgChart' then
            Result := dscOrgChart;
end;

function TdxDiagramShapeTypeHelper.ToString: string;
begin
  case self of
    dstArrowBottom:
      Result := 'arrowBottom';
    dstArrowEastWest:
      Result := 'arrowEastWest';
    dstArrowLeft:
      Result := 'arrowLeft';
    dstArrowNorthSouth:
      Result := 'arrowNorthSouth';
    dstArrowRight:
      Result := 'arrowRight';
    dstArrowTop:
      Result := 'arrowTop';
    dstCardWithImageOnLeft:
      Result := 'cardWithImageOnLeft';
    dstCardWithImageOnRight:
      Result := 'cardWithImageOnRight';
    dstCardWithImageOnTop:
      Result := 'cardWithImageOnTop';
    dstConnector:
      Result := 'connector';
    dstCross:
      Result := 'cross';
    dstData:
      Result := 'data';
    dstDatabase:
      Result := 'database';
    dstDecision:
      Result := 'decision';
    dstDelay:
      Result := 'delay';
    dstDiamond:
      Result := 'diamond';
    dstDisplay:
      Result := 'display';
    dstDocument:
      Result := 'document';
    dstEllipse:
      Result := 'ellipse';
    dstHardDisk:
      Result := 'hardDisk';
    dstHeart:
      Result := 'heart';
    dstHexagon:
      Result := 'hexagon';
    dstHorizontalContainer:
      Result := 'horizontalContainer';
    dstInternalStorage:
      Result := 'internalStorage';
    dstManualInput:
      Result := 'manualInput';
    dstManualOperation:
      Result := 'manualOperation';
    dstMerge:
      Result := 'merge';
    dstMultipleDocuments:
      Result := 'multipleDocuments';
    dstOctagon:
      Result := 'octagon';
    dstOr:
      Result := 'or';
    dstPaperTape:
      Result := 'paperTape';
    dstPentagon:
      Result := 'pentagon';
    dstPredefinedProcess:
      Result := 'predefinedProcess';
    dstPreparation:
      Result := 'preparation';
    dstProcess:
      Result := 'process';
    dstRectangle:
      Result := 'rectangle';
    dstStar:
      Result := 'star';
    dstStoredData:
      Result := 'storedData';
    dstSummingJunction:
      Result := 'summingJunction';
    dstTerminator:
      Result := 'terminator';
    dstText:
      Result := 'text';
    dstTriangle:
      Result := 'triangle';
    dstVerticalContainer:
      Result := 'verticalContainer';
  end;
end;

class function TdxDiagramShapeTypeHelper.FromString(const value: string): TdxDiagramShapeType;
begin
  Result := dstArrowBottom;

  if value = 'arrowBottom' then
    Result := dstArrowBottom
  else
    if value = 'arrowEastWest' then
      Result := dstArrowEastWest
    else
      if value = 'arrowLeft' then
        Result := dstArrowLeft
      else
        if value = 'arrowNorthSouth' then
          Result := dstArrowNorthSouth
        else
          if value = 'arrowRight' then
            Result := dstArrowRight
          else
            if value = 'arrowTop' then
              Result := dstArrowTop
            else
              if value = 'cardWithImageOnLeft' then
                Result := dstCardWithImageOnLeft
              else
                if value = 'cardWithImageOnRight' then
                  Result := dstCardWithImageOnRight
                else
                  if value = 'cardWithImageOnTop' then
                    Result := dstCardWithImageOnTop
                  else
                    if value = 'connector' then
                      Result := dstConnector
                    else
                      if value = 'cross' then
                        Result := dstCross
                      else
                        if value = 'data' then
                          Result := dstData
                        else
                          if value = 'database' then
                            Result := dstDatabase
                          else
                            if value = 'decision' then
                              Result := dstDecision
                            else
                              if value = 'delay' then
                                Result := dstDelay
                              else
                                if value = 'diamond' then
                                  Result := dstDiamond
                                else
                                  if value = 'display' then
                                    Result := dstDisplay
                                  else
                                    if value = 'document' then
                                      Result := dstDocument
                                    else
                                      if value = 'ellipse' then
                                        Result := dstEllipse
                                      else
                                        if value = 'hardDisk' then
                                        Result := dstHardDisk
                                        else
                                        if value = 'heart' then
                                        Result := dstHeart
                                        else
                                        if value = 'hexagon' then
                                        Result := dstHexagon
                                        else
                                        if value = 'horizontalContainer' then
                                        Result := dstHorizontalContainer
                                        else
                                        if value = 'internalStorage' then
                                        Result := dstInternalStorage
                                        else
                                        if value = 'manualInput' then
                                        Result := dstManualInput
                                        else
                                        if value = 'manualOperation' then
                                        Result := dstManualOperation
                                        else
                                        if value = 'merge' then
                                        Result := dstMerge
                                        else
                                        if value = 'multipleDocuments' then
                                        Result := dstMultipleDocuments
                                        else
                                        if value = 'octagon' then
                                        Result := dstOctagon
                                        else
                                        if value = 'or' then
                                        Result := dstOr
                                        else
                                        if value = 'paperTape' then
                                        Result := dstPaperTape
                                        else
                                        if value = 'pentagon' then
                                        Result := dstPentagon
                                        else
                                        if value = 'predefinedProcess' then
                                        Result := dstPredefinedProcess
                                        else
                                        if value = 'preparation' then
                                        Result := dstPreparation
                                        else
                                        if value = 'process' then
                                        Result := dstProcess
                                        else
                                        if value = 'rectangle' then
                                        Result := dstRectangle
                                        else
                                        if value = 'star' then
                                        Result := dstStar
                                        else
                                        if value = 'storedData' then
                                        Result := dstStoredData
                                        else
                                        if value = 'summingJunction' then
                                        Result := dstSummingJunction
                                        else
                                        if value = 'terminator' then
                                        Result := dstTerminator
                                        else
                                        if value = 'text' then
                                        Result := dstText
                                        else
                                        if value = 'triangle' then
                                        Result := dstTriangle
                                        else
                                        if value = 'verticalContainer' then
                                        Result := dstVerticalContainer;
end;

function TdxDiagramToolboxDisplayModeHelper.ToString: string;
begin
  case self of
    dtdmIcons:
      Result := 'icons';
    dtdmTexts:
      Result := 'texts';
  end;
end;

class function TdxDiagramToolboxDisplayModeHelper.FromString(const value: string): TdxDiagramToolboxDisplayMode;
begin
  Result := dtdmIcons;

  if value = 'icons' then
    Result := dtdmIcons
  else
    if value = 'texts' then
      Result := dtdmTexts;
end;

function TdxDiagramUnitsHelper.ToString: string;
begin
  case self of
    duCm:
      Result := 'cm';
    duIn:
      Result := 'in';
    duPx:
      Result := 'px';
  end;
end;

class function TdxDiagramUnitsHelper.FromString(const value: string): TdxDiagramUnits;
begin
  Result := duCm;

  if value = 'cm' then
    Result := duCm
  else
    if value = 'in' then
      Result := duIn
    else
      if value = 'px' then
        Result := duPx;
end;

function TdxOpenedStateModeHelper.ToString: string;
begin
  case self of
    osmOverlap:
      Result := 'overlap';
    osmPush:
      Result := 'push';
    osmShrink:
      Result := 'shrink';
  end;
end;

class function TdxOpenedStateModeHelper.FromString(const value: string): TdxOpenedStateMode;
begin
  Result := osmOverlap;

  if value = 'overlap' then
    Result := osmOverlap
  else
    if value = 'push' then
      Result := osmPush
    else
      if value = 'shrink' then
        Result := osmShrink;
end;

function TdxPanelLocationHelper.ToString: string;
begin
  case self of
    plAfter:
      Result := 'after';
    plBefore:
      Result := 'before';
    plBottom:
      Result := 'bottom';
    plLeft:
      Result := 'left';
    plRight:
      Result := 'right';
    plTop:
      Result := 'top';
  end;
end;

class function TdxPanelLocationHelper.FromString(const value: string): TdxPanelLocation;
begin
  Result := plAfter;

  if value = 'after' then
    Result := plAfter
  else
    if value = 'before' then
      Result := plBefore
    else
      if value = 'bottom' then
        Result := plBottom
      else
        if value = 'left' then
          Result := plLeft
        else
          if value = 'right' then
            Result := plRight
          else
            if value = 'top' then
              Result := plTop;
end;

function TdxRevealModeHelper.ToString: string;
begin
  case self of
    rmExpand:
      Result := 'expand';
    rmSlide:
      Result := 'slide';
  end;
end;

class function TdxRevealModeHelper.FromString(const value: string): TdxRevealMode;
begin
  Result := rmExpand;

  if value = 'expand' then
    Result := rmExpand
  else
    if value = 'slide' then
      Result := rmSlide;
end;

function TdxDropDownBoxApplyValueModeHelper.ToString: string;
begin
  case self of
    ddbavmInstantly:
      Result := 'instantly';
    ddbavmUseButtons:
      Result := 'useButtons';
  end;
end;

class function TdxDropDownBoxApplyValueModeHelper.FromString(const value: string): TdxDropDownBoxApplyValueMode;
begin
  Result := ddbavmInstantly;

  if value = 'instantly' then
    Result := ddbavmInstantly
  else
    if value = 'useButtons' then
      Result := ddbavmUseButtons;
end;

function TdxFileManagerItemViewModeHelper.ToString: string;
begin
  case self of
    fmivmDetails:
      Result := 'details';
    fmivmThumbnails:
      Result := 'thumbnails';
  end;
end;

class function TdxFileManagerItemViewModeHelper.FromString(const value: string): TdxFileManagerItemViewMode;
begin
  Result := fmivmDetails;

  if value = 'details' then
    Result := fmivmDetails
  else
    if value = 'thumbnails' then
      Result := fmivmThumbnails;
end;

function TdxFileManagerPredefinedContextMenuItemHelper.ToString: string;
begin
  case self of
    fmpcmiCopy:
      Result := 'copy';
    fmpcmiCreate:
      Result := 'create';
    fmpcmiDelete:
      Result := 'delete';
    fmpcmiDownload:
      Result := 'download';
    fmpcmiMove:
      Result := 'move';
    fmpcmiRefresh:
      Result := 'refresh';
    fmpcmiRename:
      Result := 'rename';
    fmpcmiUpload:
      Result := 'upload';
  end;
end;

class function TdxFileManagerPredefinedContextMenuItemHelper.FromString(const value: string): TdxFileManagerPredefinedContextMenuItem;
begin
  Result := fmpcmiCopy;

  if value = 'copy' then
    Result := fmpcmiCopy
  else
    if value = 'create' then
      Result := fmpcmiCreate
    else
      if value = 'delete' then
        Result := fmpcmiDelete
      else
        if value = 'download' then
          Result := fmpcmiDownload
        else
          if value = 'move' then
            Result := fmpcmiMove
          else
            if value = 'refresh' then
              Result := fmpcmiRefresh
            else
              if value = 'rename' then
                Result := fmpcmiRename
              else
                if value = 'upload' then
                  Result := fmpcmiUpload;
end;

function TdxFileManagerPredefinedToolbarItemHelper.ToString: string;
begin
  case self of
    fmptiClearSelection:
      Result := 'clearSelection';
    fmptiCopy:
      Result := 'copy';
    fmptiCreate:
      Result := 'create';
    fmptiDelete:
      Result := 'delete';
    fmptiDownload:
      Result := 'download';
    fmptiMove:
      Result := 'move';
    fmptiRefresh:
      Result := 'refresh';
    fmptiRename:
      Result := 'rename';
    fmptiSeparator:
      Result := 'separator';
    fmptiShowNavPane:
      Result := 'showNavPane';
    fmptiSwitchView:
      Result := 'switchView';
    fmptiUpload:
      Result := 'upload';
  end;
end;

class function TdxFileManagerPredefinedToolbarItemHelper.FromString(const value: string): TdxFileManagerPredefinedToolbarItem;
begin
  Result := fmptiClearSelection;

  if value = 'clearSelection' then
    Result := fmptiClearSelection
  else
    if value = 'copy' then
      Result := fmptiCopy
    else
      if value = 'create' then
        Result := fmptiCreate
      else
        if value = 'delete' then
          Result := fmptiDelete
        else
          if value = 'download' then
            Result := fmptiDownload
          else
            if value = 'move' then
              Result := fmptiMove
            else
              if value = 'refresh' then
                Result := fmptiRefresh
              else
                if value = 'rename' then
                  Result := fmptiRename
                else
                  if value = 'separator' then
                    Result := fmptiSeparator
                  else
                    if value = 'showNavPane' then
                      Result := fmptiShowNavPane
                    else
                      if value = 'switchView' then
                        Result := fmptiSwitchView
                      else
                        if value = 'upload' then
                          Result := fmptiUpload;
end;

function TdxFileManagerViewAreaHelper.ToString: string;
begin
  case self of
    fmvaItemView:
      Result := 'itemView';
    fmvaNavPane:
      Result := 'navPane';
  end;
end;

class function TdxFileManagerViewAreaHelper.FromString(const value: string): TdxFileManagerViewArea;
begin
  Result := fmvaItemView;

  if value = 'itemView' then
    Result := fmvaItemView
  else
    if value = 'navPane' then
      Result := fmvaNavPane;
end;

function TdxFileUploadModeHelper.ToString: string;
begin
  case self of
    fumInstantly:
      Result := 'instantly';
    fumUseButtons:
      Result := 'useButtons';
    fumUseForm:
      Result := 'useForm';
  end;
end;

class function TdxFileUploadModeHelper.FromString(const value: string): TdxFileUploadMode;
begin
  Result := fumInstantly;

  if value = 'instantly' then
    Result := fumInstantly
  else
    if value = 'useButtons' then
      Result := fumUseButtons
    else
      if value = 'useForm' then
        Result := fumUseForm;
end;

function TdxUploadHttpMethodHelper.ToString: string;
begin
  case self of
    uhmPOST:
      Result := 'POST';
    uhmPUT:
      Result := 'PUT';
  end;
end;

class function TdxUploadHttpMethodHelper.FromString(const value: string): TdxUploadHttpMethod;
begin
  Result := uhmPOST;

  if value = 'POST' then
    Result := uhmPOST
  else
    if value = 'PUT' then
      Result := uhmPUT;
end;

function TdxGroupOperationHelper.ToString: string;
begin
  case self of
    goAnd:
      Result := 'and';
    goNotAnd:
      Result := 'notAnd';
    goNotOr:
      Result := 'notOr';
    goOr:
      Result := 'or';
  end;
end;

class function TdxGroupOperationHelper.FromString(const value: string): TdxGroupOperation;
begin
  Result := goAnd;

  if value = 'and' then
    Result := goAnd
  else
    if value = 'notAnd' then
      Result := goNotAnd
    else
      if value = 'notOr' then
        Result := goNotOr
      else
        if value = 'or' then
          Result := goOr;
end;

function TdxFormItemComponentHelper.ToString: string;
begin
  case self of
    ficDxAutocomplete:
      Result := 'dxAutocomplete';
    ficDxCalendar:
      Result := 'dxCalendar';
    ficDxCheckBox:
      Result := 'dxCheckBox';
    ficDxColorBox:
      Result := 'dxColorBox';
    ficDxDateBox:
      Result := 'dxDateBox';
    ficDxDropDownBox:
      Result := 'dxDropDownBox';
    ficDxHtmlEditor:
      Result := 'dxHtmlEditor';
    ficDxLookup:
      Result := 'dxLookup';
    ficDxNumberBox:
      Result := 'dxNumberBox';
    ficDxRadioGroup:
      Result := 'dxRadioGroup';
    ficDxRangeSlider:
      Result := 'dxRangeSlider';
    ficDxSelectBox:
      Result := 'dxSelectBox';
    ficDxSlider:
      Result := 'dxSlider';
    ficDxSwitch:
      Result := 'dxSwitch';
    ficDxTagBox:
      Result := 'dxTagBox';
    ficDxTextArea:
      Result := 'dxTextArea';
    ficDxTextBox:
      Result := 'dxTextBox';
  end;
end;

class function TdxFormItemComponentHelper.FromString(const value: string): TdxFormItemComponent;
begin
  Result := ficDxAutocomplete;

  if value = 'dxAutocomplete' then
    Result := ficDxAutocomplete
  else
    if value = 'dxCalendar' then
      Result := ficDxCalendar
    else
      if value = 'dxCheckBox' then
        Result := ficDxCheckBox
      else
        if value = 'dxColorBox' then
          Result := ficDxColorBox
        else
          if value = 'dxDateBox' then
            Result := ficDxDateBox
          else
            if value = 'dxDropDownBox' then
              Result := ficDxDropDownBox
            else
              if value = 'dxHtmlEditor' then
                Result := ficDxHtmlEditor
              else
                if value = 'dxLookup' then
                  Result := ficDxLookup
                else
                  if value = 'dxNumberBox' then
                    Result := ficDxNumberBox
                  else
                    if value = 'dxRadioGroup' then
                      Result := ficDxRadioGroup
                    else
                      if value = 'dxRangeSlider' then
                        Result := ficDxRangeSlider
                      else
                        if value = 'dxSelectBox' then
                          Result := ficDxSelectBox
                        else
                          if value = 'dxSlider' then
                            Result := ficDxSlider
                          else
                            if value = 'dxSwitch' then
                              Result := ficDxSwitch
                            else
                              if value = 'dxTagBox' then
                                Result := ficDxTagBox
                              else
                                if value = 'dxTextArea' then
                                  Result := ficDxTextArea
                                else
                                  if value = 'dxTextBox' then
                                    Result := ficDxTextBox;
end;

function TdxFormItemTypeHelper.ToString: string;
begin
  case self of
    fitButton:
      Result := 'button';
    fitEmpty:
      Result := 'empty';
    fitGroup:
      Result := 'group';
    fitSimple:
      Result := 'simple';
    fitTabbed:
      Result := 'tabbed';
  end;
end;

class function TdxFormItemTypeHelper.FromString(const value: string): TdxFormItemType;
begin
  Result := fitButton;

  if value = 'button' then
    Result := fitButton
  else
    if value = 'empty' then
      Result := fitEmpty
    else
      if value = 'group' then
        Result := fitGroup
      else
        if value = 'simple' then
          Result := fitSimple
        else
          if value = 'tabbed' then
            Result := fitTabbed;
end;

function TdxFormLabelModeHelper.ToString: string;
begin
  case self of
    flmFloating:
      Result := 'floating';
    flmHidden:
      Result := 'hidden';
    flmOutside:
      Result := 'outside';
    flmStatic:
      Result := 'static';
  end;
end;

class function TdxFormLabelModeHelper.FromString(const value: string): TdxFormLabelMode;
begin
  Result := flmFloating;

  if value = 'floating' then
    Result := flmFloating
  else
    if value = 'hidden' then
      Result := flmHidden
    else
      if value = 'outside' then
        Result := flmOutside
      else
        if value = 'static' then
          Result := flmStatic;
end;

function TdxLabelLocationHelper.ToString: string;
begin
  case self of
    llLeft:
      Result := 'left';
    llRight:
      Result := 'right';
    llTop:
      Result := 'top';
  end;
end;

class function TdxLabelLocationHelper.FromString(const value: string): TdxLabelLocation;
begin
  Result := llLeft;

  if value = 'left' then
    Result := llLeft
  else
    if value = 'right' then
      Result := llRight
    else
      if value = 'top' then
        Result := llTop;
end;

function TdxFunnelAlgorithmHelper.ToString: string;
begin
  case self of
    faDynamicHeight:
      Result := 'dynamicHeight';
    faDynamicSlope:
      Result := 'dynamicSlope';
  end;
end;

class function TdxFunnelAlgorithmHelper.FromString(const value: string): TdxFunnelAlgorithm;
begin
  Result := faDynamicHeight;

  if value = 'dynamicHeight' then
    Result := faDynamicHeight
  else
    if value = 'dynamicSlope' then
      Result := faDynamicSlope;
end;

function TdxGanttPdfExportDateRangeHelper.ToString: string;
begin
  case self of
    gpedrAll:
      Result := 'all';
    gpedrVisible:
      Result := 'visible';
  end;
end;

class function TdxGanttPdfExportDateRangeHelper.FromString(const value: string): TdxGanttPdfExportDateRange;
begin
  Result := gpedrAll;

  if value = 'all' then
    Result := gpedrAll
  else
    if value = 'visible' then
      Result := gpedrVisible;
end;

function TdxGanttPdfExportModeHelper.ToString: string;
begin
  case self of
    gpemAll:
      Result := 'all';
    gpemChart:
      Result := 'chart';
    gpemTreeList:
      Result := 'treeList';
  end;
end;

class function TdxGanttPdfExportModeHelper.FromString(const value: string): TdxGanttPdfExportMode;
begin
  Result := gpemAll;

  if value = 'all' then
    Result := gpemAll
  else
    if value = 'chart' then
      Result := gpemChart
    else
      if value = 'treeList' then
        Result := gpemTreeList;
end;

function TdxGanttPredefinedContextMenuItemHelper.ToString: string;
begin
  case self of
    gpcmiAddTask:
      Result := 'addTask';
    gpcmiCollapseAll:
      Result := 'collapseAll';
    gpcmiDeleteDependency:
      Result := 'deleteDependency';
    gpcmiDeleteTask:
      Result := 'deleteTask';
    gpcmiExpandAll:
      Result := 'expandAll';
    gpcmiRedo:
      Result := 'redo';
    gpcmiResourceManager:
      Result := 'resourceManager';
    gpcmiTaskDetails:
      Result := 'taskDetails';
    gpcmiUndo:
      Result := 'undo';
    gpcmiZoomIn:
      Result := 'zoomIn';
    gpcmiZoomOut:
      Result := 'zoomOut';
  end;
end;

class function TdxGanttPredefinedContextMenuItemHelper.FromString(const value: string): TdxGanttPredefinedContextMenuItem;
begin
  Result := gpcmiAddTask;

  if value = 'addTask' then
    Result := gpcmiAddTask
  else
    if value = 'collapseAll' then
      Result := gpcmiCollapseAll
    else
      if value = 'deleteDependency' then
        Result := gpcmiDeleteDependency
      else
        if value = 'deleteTask' then
          Result := gpcmiDeleteTask
        else
          if value = 'expandAll' then
            Result := gpcmiExpandAll
          else
            if value = 'redo' then
              Result := gpcmiRedo
            else
              if value = 'resourceManager' then
                Result := gpcmiResourceManager
              else
                if value = 'taskDetails' then
                  Result := gpcmiTaskDetails
                else
                  if value = 'undo' then
                    Result := gpcmiUndo
                  else
                    if value = 'zoomIn' then
                      Result := gpcmiZoomIn
                    else
                      if value = 'zoomOut' then
                        Result := gpcmiZoomOut;
end;

function TdxGanttPredefinedToolbarItemHelper.ToString: string;
begin
  case self of
    gptiAddTask:
      Result := 'addTask';
    gptiCollapseAll:
      Result := 'collapseAll';
    gptiDeleteTask:
      Result := 'deleteTask';
    gptiExpandAll:
      Result := 'expandAll';
    gptiFullScreen:
      Result := 'fullScreen';
    gptiRedo:
      Result := 'redo';
    gptiResourceManager:
      Result := 'resourceManager';
    gptiSeparator:
      Result := 'separator';
    gptiShowDependencies:
      Result := 'showDependencies';
    gptiShowResources:
      Result := 'showResources';
    gptiTaskDetails:
      Result := 'taskDetails';
    gptiUndo:
      Result := 'undo';
    gptiZoomIn:
      Result := 'zoomIn';
    gptiZoomOut:
      Result := 'zoomOut';
  end;
end;

class function TdxGanttPredefinedToolbarItemHelper.FromString(const value: string): TdxGanttPredefinedToolbarItem;
begin
  Result := gptiAddTask;

  if value = 'addTask' then
    Result := gptiAddTask
  else
    if value = 'collapseAll' then
      Result := gptiCollapseAll
    else
      if value = 'deleteTask' then
        Result := gptiDeleteTask
      else
        if value = 'expandAll' then
          Result := gptiExpandAll
        else
          if value = 'fullScreen' then
            Result := gptiFullScreen
          else
            if value = 'redo' then
              Result := gptiRedo
            else
              if value = 'resourceManager' then
                Result := gptiResourceManager
              else
                if value = 'separator' then
                  Result := gptiSeparator
                else
                  if value = 'showDependencies' then
                    Result := gptiShowDependencies
                  else
                    if value = 'showResources' then
                      Result := gptiShowResources
                    else
                      if value = 'taskDetails' then
                        Result := gptiTaskDetails
                      else
                        if value = 'undo' then
                          Result := gptiUndo
                        else
                          if value = 'zoomIn' then
                            Result := gptiZoomIn
                          else
                            if value = 'zoomOut' then
                              Result := gptiZoomOut;
end;

function TdxGanttRenderScaleTypeHelper.ToString: string;
begin
  case self of
    grstDays:
      Result := 'days';
    grstFiveYears:
      Result := 'fiveYears';
    grstHours:
      Result := 'hours';
    grstMinutes:
      Result := 'minutes';
    grstMonths:
      Result := 'months';
    grstQuarters:
      Result := 'quarters';
    grstSixHours:
      Result := 'sixHours';
    grstWeeks:
      Result := 'weeks';
    grstYears:
      Result := 'years';
  end;
end;

class function TdxGanttRenderScaleTypeHelper.FromString(const value: string): TdxGanttRenderScaleType;
begin
  Result := grstDays;

  if value = 'days' then
    Result := grstDays
  else
    if value = 'fiveYears' then
      Result := grstFiveYears
    else
      if value = 'hours' then
        Result := grstHours
      else
        if value = 'minutes' then
          Result := grstMinutes
        else
          if value = 'months' then
            Result := grstMonths
          else
            if value = 'quarters' then
              Result := grstQuarters
            else
              if value = 'sixHours' then
                Result := grstSixHours
              else
                if value = 'weeks' then
                  Result := grstWeeks
                else
                  if value = 'years' then
                    Result := grstYears;
end;

function TdxGanttScaleTypeHelper.ToString: string;
begin
  case self of
    gstAuto:
      Result := 'auto';
    gstDays:
      Result := 'days';
    gstHours:
      Result := 'hours';
    gstMinutes:
      Result := 'minutes';
    gstMonths:
      Result := 'months';
    gstQuarters:
      Result := 'quarters';
    gstSixHours:
      Result := 'sixHours';
    gstWeeks:
      Result := 'weeks';
    gstYears:
      Result := 'years';
  end;
end;

class function TdxGanttScaleTypeHelper.FromString(const value: string): TdxGanttScaleType;
begin
  Result := gstAuto;

  if value = 'auto' then
    Result := gstAuto
  else
    if value = 'days' then
      Result := gstDays
    else
      if value = 'hours' then
        Result := gstHours
      else
        if value = 'minutes' then
          Result := gstMinutes
        else
          if value = 'months' then
            Result := gstMonths
          else
            if value = 'quarters' then
              Result := gstQuarters
            else
              if value = 'sixHours' then
                Result := gstSixHours
              else
                if value = 'weeks' then
                  Result := gstWeeks
                else
                  if value = 'years' then
                    Result := gstYears;
end;

function TdxGanttTaskTitlePositionHelper.ToString: string;
begin
  case self of
    gttpInside:
      Result := 'inside';
    gttpNone:
      Result := 'none';
    gttpOutside:
      Result := 'outside';
  end;
end;

class function TdxGanttTaskTitlePositionHelper.FromString(const value: string): TdxGanttTaskTitlePosition;
begin
  Result := gttpInside;

  if value = 'inside' then
    Result := gttpInside
  else
    if value = 'none' then
      Result := gttpNone
    else
      if value = 'outside' then
        Result := gttpOutside;
end;

function TdxHtmlEditorFormatHelper.ToString: string;
begin
  case self of
    hefAlign:
      Result := 'align';
    hefBackground:
      Result := 'background';
    hefBlockquote:
      Result := 'blockquote';
    hefBold:
      Result := 'bold';
    hefCodeblock:
      Result := 'codeblock';
    hefColor:
      Result := 'color';
    hefFont:
      Result := 'font';
    hefHeader:
      Result := 'header';
    hefIndent:
      Result := 'indent';
    hefItalic:
      Result := 'italic';
    hefLink:
      Result := 'link';
    hefList:
      Result := 'list';
    hefScript:
      Result := 'script';
    hefSize:
      Result := 'size';
    hefStrike:
      Result := 'strike';
    hefUnderline:
      Result := 'underline';
  end;
end;

class function TdxHtmlEditorFormatHelper.FromString(const value: string): TdxHtmlEditorFormat;
begin
  Result := hefAlign;

  if value = 'align' then
    Result := hefAlign
  else
    if value = 'background' then
      Result := hefBackground
    else
      if value = 'blockquote' then
        Result := hefBlockquote
      else
        if value = 'bold' then
          Result := hefBold
        else
          if value = 'codeblock' then
            Result := hefCodeblock
          else
            if value = 'color' then
              Result := hefColor
            else
              if value = 'font' then
                Result := hefFont
              else
                if value = 'header' then
                  Result := hefHeader
                else
                  if value = 'indent' then
                    Result := hefIndent
                  else
                    if value = 'italic' then
                      Result := hefItalic
                    else
                      if value = 'link' then
                        Result := hefLink
                      else
                        if value = 'list' then
                          Result := hefList
                        else
                          if value = 'script' then
                            Result := hefScript
                          else
                            if value = 'size' then
                              Result := hefSize
                            else
                              if value = 'strike' then
                                Result := hefStrike
                              else
                                if value = 'underline' then
                                  Result := hefUnderline;
end;

function TdxHtmlEditorImageUploadModeHelper.ToString: string;
begin
  case self of
    heiumBase64:
      Result := 'base64';
    heiumBoth:
      Result := 'both';
    heiumServer:
      Result := 'server';
  end;
end;

class function TdxHtmlEditorImageUploadModeHelper.FromString(const value: string): TdxHtmlEditorImageUploadMode;
begin
  Result := heiumBase64;

  if value = 'base64' then
    Result := heiumBase64
  else
    if value = 'both' then
      Result := heiumBoth
    else
      if value = 'server' then
        Result := heiumServer;
end;

function TdxHtmlEditorImageUploadTabHelper.ToString: string;
begin
  case self of
    heiutFile:
      Result := 'file';
    heiutUrl:
      Result := 'url';
  end;
end;

class function TdxHtmlEditorImageUploadTabHelper.FromString(const value: string): TdxHtmlEditorImageUploadTab;
begin
  Result := heiutFile;

  if value = 'file' then
    Result := heiutFile
  else
    if value = 'url' then
      Result := heiutUrl;
end;

function TdxHtmlEditorPredefinedContextMenuItemHelper.ToString: string;
begin
  case self of
    hepcmiAlignCenter:
      Result := 'alignCenter';
    hepcmiAlignJustify:
      Result := 'alignJustify';
    hepcmiAlignLeft:
      Result := 'alignLeft';
    hepcmiAlignRight:
      Result := 'alignRight';
    hepcmiBackground:
      Result := 'background';
    hepcmiBlockquote:
      Result := 'blockquote';
    hepcmiBold:
      Result := 'bold';
    hepcmiBulletList:
      Result := 'bulletList';
    hepcmiCellProperties:
      Result := 'cellProperties';
    hepcmiClear:
      Result := 'clear';
    hepcmiCodeBlock:
      Result := 'codeBlock';
    hepcmiColor:
      Result := 'color';
    hepcmiDecreaseIndent:
      Result := 'decreaseIndent';
    hepcmiDeleteColumn:
      Result := 'deleteColumn';
    hepcmiDeleteRow:
      Result := 'deleteRow';
    hepcmiDeleteTable:
      Result := 'deleteTable';
    hepcmiFont:
      Result := 'font';
    hepcmiImage:
      Result := 'image';
    hepcmiIncreaseIndent:
      Result := 'increaseIndent';
    hepcmiInsertColumnLeft:
      Result := 'insertColumnLeft';
    hepcmiInsertColumnRight:
      Result := 'insertColumnRight';
    hepcmiInsertHeaderRow:
      Result := 'insertHeaderRow';
    hepcmiInsertRowAbove:
      Result := 'insertRowAbove';
    hepcmiInsertRowBelow:
      Result := 'insertRowBelow';
    hepcmiInsertTable:
      Result := 'insertTable';
    hepcmiItalic:
      Result := 'italic';
    hepcmiLink:
      Result := 'link';
    hepcmiOrderedList:
      Result := 'orderedList';
    hepcmiRedo:
      Result := 'redo';
    hepcmiStrike:
      Result := 'strike';
    hepcmiSubscript:
      Result := 'subscript';
    hepcmiSuperscript:
      Result := 'superscript';
    hepcmiTableProperties:
      Result := 'tableProperties';
    hepcmiUnderline:
      Result := 'underline';
    hepcmiUndo:
      Result := 'undo';
    hepcmiVariable:
      Result := 'variable';
  end;
end;

class function TdxHtmlEditorPredefinedContextMenuItemHelper.FromString(const value: string): TdxHtmlEditorPredefinedContextMenuItem;
begin
  Result := hepcmiAlignCenter;

  if value = 'alignCenter' then
    Result := hepcmiAlignCenter
  else
    if value = 'alignJustify' then
      Result := hepcmiAlignJustify
    else
      if value = 'alignLeft' then
        Result := hepcmiAlignLeft
      else
        if value = 'alignRight' then
          Result := hepcmiAlignRight
        else
          if value = 'background' then
            Result := hepcmiBackground
          else
            if value = 'blockquote' then
              Result := hepcmiBlockquote
            else
              if value = 'bold' then
                Result := hepcmiBold
              else
                if value = 'bulletList' then
                  Result := hepcmiBulletList
                else
                  if value = 'cellProperties' then
                    Result := hepcmiCellProperties
                  else
                    if value = 'clear' then
                      Result := hepcmiClear
                    else
                      if value = 'codeBlock' then
                        Result := hepcmiCodeBlock
                      else
                        if value = 'color' then
                          Result := hepcmiColor
                        else
                          if value = 'decreaseIndent' then
                            Result := hepcmiDecreaseIndent
                          else
                            if value = 'deleteColumn' then
                              Result := hepcmiDeleteColumn
                            else
                              if value = 'deleteRow' then
                                Result := hepcmiDeleteRow
                              else
                                if value = 'deleteTable' then
                                  Result := hepcmiDeleteTable
                                else
                                  if value = 'font' then
                                    Result := hepcmiFont
                                  else
                                    if value = 'image' then
                                      Result := hepcmiImage
                                    else
                                      if value = 'increaseIndent' then
                                        Result := hepcmiIncreaseIndent
                                      else
                                        if value = 'insertColumnLeft' then
                                        Result := hepcmiInsertColumnLeft
                                        else
                                        if value = 'insertColumnRight' then
                                        Result := hepcmiInsertColumnRight
                                        else
                                        if value = 'insertHeaderRow' then
                                        Result := hepcmiInsertHeaderRow
                                        else
                                        if value = 'insertRowAbove' then
                                        Result := hepcmiInsertRowAbove
                                        else
                                        if value = 'insertRowBelow' then
                                        Result := hepcmiInsertRowBelow
                                        else
                                        if value = 'insertTable' then
                                        Result := hepcmiInsertTable
                                        else
                                        if value = 'italic' then
                                        Result := hepcmiItalic
                                        else
                                        if value = 'link' then
                                        Result := hepcmiLink
                                        else
                                        if value = 'orderedList' then
                                        Result := hepcmiOrderedList
                                        else
                                        if value = 'redo' then
                                        Result := hepcmiRedo
                                        else
                                        if value = 'strike' then
                                        Result := hepcmiStrike
                                        else
                                        if value = 'subscript' then
                                        Result := hepcmiSubscript
                                        else
                                        if value = 'superscript' then
                                        Result := hepcmiSuperscript
                                        else
                                        if value = 'tableProperties' then
                                        Result := hepcmiTableProperties
                                        else
                                        if value = 'underline' then
                                        Result := hepcmiUnderline
                                        else
                                        if value = 'undo' then
                                        Result := hepcmiUndo
                                        else
                                        if value = 'variable' then
                                        Result := hepcmiVariable;
end;

function TdxHtmlEditorPredefinedToolbarItemHelper.ToString: string;
begin
  case self of
    heptiAlignCenter:
      Result := 'alignCenter';
    heptiAlignJustify:
      Result := 'alignJustify';
    heptiAlignLeft:
      Result := 'alignLeft';
    heptiAlignRight:
      Result := 'alignRight';
    heptiBackground:
      Result := 'background';
    heptiBlockquote:
      Result := 'blockquote';
    heptiBold:
      Result := 'bold';
    heptiBulletList:
      Result := 'bulletList';
    heptiCellProperties:
      Result := 'cellProperties';
    heptiClear:
      Result := 'clear';
    heptiCodeBlock:
      Result := 'codeBlock';
    heptiColor:
      Result := 'color';
    heptiDecreaseIndent:
      Result := 'decreaseIndent';
    heptiDeleteColumn:
      Result := 'deleteColumn';
    heptiDeleteRow:
      Result := 'deleteRow';
    heptiDeleteTable:
      Result := 'deleteTable';
    heptiFont:
      Result := 'font';
    heptiHeader:
      Result := 'header';
    heptiImage:
      Result := 'image';
    heptiIncreaseIndent:
      Result := 'increaseIndent';
    heptiInsertColumnLeft:
      Result := 'insertColumnLeft';
    heptiInsertColumnRight:
      Result := 'insertColumnRight';
    heptiInsertHeaderRow:
      Result := 'insertHeaderRow';
    heptiInsertRowAbove:
      Result := 'insertRowAbove';
    heptiInsertRowBelow:
      Result := 'insertRowBelow';
    heptiInsertTable:
      Result := 'insertTable';
    heptiItalic:
      Result := 'italic';
    heptiLink:
      Result := 'link';
    heptiOrderedList:
      Result := 'orderedList';
    heptiRedo:
      Result := 'redo';
    heptiSeparator:
      Result := 'separator';
    heptiSize:
      Result := 'size';
    heptiStrike:
      Result := 'strike';
    heptiSubscript:
      Result := 'subscript';
    heptiSuperscript:
      Result := 'superscript';
    heptiTableProperties:
      Result := 'tableProperties';
    heptiUnderline:
      Result := 'underline';
    heptiUndo:
      Result := 'undo';
    heptiVariable:
      Result := 'variable';
  end;
end;

class function TdxHtmlEditorPredefinedToolbarItemHelper.FromString(const value: string): TdxHtmlEditorPredefinedToolbarItem;
begin
  Result := heptiAlignCenter;

  if value = 'alignCenter' then
    Result := heptiAlignCenter
  else
    if value = 'alignJustify' then
      Result := heptiAlignJustify
    else
      if value = 'alignLeft' then
        Result := heptiAlignLeft
      else
        if value = 'alignRight' then
          Result := heptiAlignRight
        else
          if value = 'background' then
            Result := heptiBackground
          else
            if value = 'blockquote' then
              Result := heptiBlockquote
            else
              if value = 'bold' then
                Result := heptiBold
              else
                if value = 'bulletList' then
                  Result := heptiBulletList
                else
                  if value = 'cellProperties' then
                    Result := heptiCellProperties
                  else
                    if value = 'clear' then
                      Result := heptiClear
                    else
                      if value = 'codeBlock' then
                        Result := heptiCodeBlock
                      else
                        if value = 'color' then
                          Result := heptiColor
                        else
                          if value = 'decreaseIndent' then
                            Result := heptiDecreaseIndent
                          else
                            if value = 'deleteColumn' then
                              Result := heptiDeleteColumn
                            else
                              if value = 'deleteRow' then
                                Result := heptiDeleteRow
                              else
                                if value = 'deleteTable' then
                                  Result := heptiDeleteTable
                                else
                                  if value = 'font' then
                                    Result := heptiFont
                                  else
                                    if value = 'header' then
                                      Result := heptiHeader
                                    else
                                      if value = 'image' then
                                        Result := heptiImage
                                      else
                                        if value = 'increaseIndent' then
                                        Result := heptiIncreaseIndent
                                        else
                                        if value = 'insertColumnLeft' then
                                        Result := heptiInsertColumnLeft
                                        else
                                        if value = 'insertColumnRight' then
                                        Result := heptiInsertColumnRight
                                        else
                                        if value = 'insertHeaderRow' then
                                        Result := heptiInsertHeaderRow
                                        else
                                        if value = 'insertRowAbove' then
                                        Result := heptiInsertRowAbove
                                        else
                                        if value = 'insertRowBelow' then
                                        Result := heptiInsertRowBelow
                                        else
                                        if value = 'insertTable' then
                                        Result := heptiInsertTable
                                        else
                                        if value = 'italic' then
                                        Result := heptiItalic
                                        else
                                        if value = 'link' then
                                        Result := heptiLink
                                        else
                                        if value = 'orderedList' then
                                        Result := heptiOrderedList
                                        else
                                        if value = 'redo' then
                                        Result := heptiRedo
                                        else
                                        if value = 'separator' then
                                        Result := heptiSeparator
                                        else
                                        if value = 'size' then
                                        Result := heptiSize
                                        else
                                        if value = 'strike' then
                                        Result := heptiStrike
                                        else
                                        if value = 'subscript' then
                                        Result := heptiSubscript
                                        else
                                        if value = 'superscript' then
                                        Result := heptiSuperscript
                                        else
                                        if value = 'tableProperties' then
                                        Result := heptiTableProperties
                                        else
                                        if value = 'underline' then
                                        Result := heptiUnderline
                                        else
                                        if value = 'undo' then
                                        Result := heptiUndo
                                        else
                                        if value = 'variable' then
                                        Result := heptiVariable;
end;

function TdxMarkupTypeHelper.ToString: string;
begin
  case self of
    mtHtml:
      Result := 'html';
    mtMarkdown:
      Result := 'markdown';
  end;
end;

class function TdxMarkupTypeHelper.FromString(const value: string): TdxMarkupType;
begin
  Result := mtHtml;

  if value = 'html' then
    Result := mtHtml
  else
    if value = 'markdown' then
      Result := mtMarkdown;
end;

function TdxItemDeleteModeHelper.ToString: string;
begin
  case self of
    idmContext:
      Result := 'context';
    idmSlideButton:
      Result := 'slideButton';
    idmSlideItem:
      Result := 'slideItem';
    idmStatic:
      Result := 'static';
    idmSwipe:
      Result := 'swipe';
    idmToggle:
      Result := 'toggle';
  end;
end;

class function TdxItemDeleteModeHelper.FromString(const value: string): TdxItemDeleteMode;
begin
  Result := idmContext;

  if value = 'context' then
    Result := idmContext
  else
    if value = 'slideButton' then
      Result := idmSlideButton
    else
      if value = 'slideItem' then
        Result := idmSlideItem
      else
        if value = 'static' then
          Result := idmStatic
        else
          if value = 'swipe' then
            Result := idmSwipe
          else
            if value = 'toggle' then
              Result := idmToggle;
end;

function TdxListMenuModeHelper.ToString: string;
begin
  case self of
    lmmContext:
      Result := 'context';
    lmmSlide:
      Result := 'slide';
  end;
end;

class function TdxListMenuModeHelper.FromString(const value: string): TdxListMenuMode;
begin
  Result := lmmContext;

  if value = 'context' then
    Result := lmmContext
  else
    if value = 'slide' then
      Result := lmmSlide;
end;

function TdxMapProviderHelper.ToString: string;
begin
  case self of
    mpBing:
      Result := 'bing';
    mpGoogle:
      Result := 'google';
    mpGoogleStatic:
      Result := 'googleStatic';
  end;
end;

class function TdxMapProviderHelper.FromString(const value: string): TdxMapProvider;
begin
  Result := mpBing;

  if value = 'bing' then
    Result := mpBing
  else
    if value = 'google' then
      Result := mpGoogle
    else
      if value = 'googleStatic' then
        Result := mpGoogleStatic;
end;

function TdxMapTypeHelper.ToString: string;
begin
  case self of
    mtHybrid:
      Result := 'hybrid';
    mtRoadmap:
      Result := 'roadmap';
    mtSatellite:
      Result := 'satellite';
  end;
end;

class function TdxMapTypeHelper.FromString(const value: string): TdxMapType;
begin
  Result := mtHybrid;

  if value = 'hybrid' then
    Result := mtHybrid
  else
    if value = 'roadmap' then
      Result := mtRoadmap
    else
      if value = 'satellite' then
        Result := mtSatellite;
end;

function TdxRouteModeHelper.ToString: string;
begin
  case self of
    rmDriving:
      Result := 'driving';
    rmWalking:
      Result := 'walking';
  end;
end;

class function TdxRouteModeHelper.FromString(const value: string): TdxRouteMode;
begin
  Result := rmDriving;

  if value = 'driving' then
    Result := rmDriving
  else
    if value = 'walking' then
      Result := rmWalking;
end;

function TdxSubmenuDirectionHelper.ToString: string;
begin
  case self of
    sdAuto:
      Result := 'auto';
    sdLeftOrTop:
      Result := 'leftOrTop';
    sdRightOrBottom:
      Result := 'rightOrBottom';
  end;
end;

class function TdxSubmenuDirectionHelper.FromString(const value: string): TdxSubmenuDirection;
begin
  Result := sdAuto;

  if value = 'auto' then
    Result := sdAuto
  else
    if value = 'leftOrTop' then
      Result := sdLeftOrTop
    else
      if value = 'rightOrBottom' then
        Result := sdRightOrBottom;
end;

function TdxNumberBoxPredefinedButtonHelper.ToString: string;
begin
  case self of
    nbpbClear:
      Result := 'clear';
    nbpbSpins:
      Result := 'spins';
  end;
end;

class function TdxNumberBoxPredefinedButtonHelper.FromString(const value: string): TdxNumberBoxPredefinedButton;
begin
  Result := nbpbClear;

  if value = 'clear' then
    Result := nbpbClear
  else
    if value = 'spins' then
      Result := nbpbSpins;
end;

function TdxNumberBoxTypeHelper.ToString: string;
begin
  case self of
    nbtNumber:
      Result := 'number';
    nbtTel:
      Result := 'tel';
    nbtText:
      Result := 'text';
  end;
end;

class function TdxNumberBoxTypeHelper.FromString(const value: string): TdxNumberBoxType;
begin
  Result := nbtNumber;

  if value = 'number' then
    Result := nbtNumber
  else
    if value = 'tel' then
      Result := nbtTel
    else
      if value = 'text' then
        Result := nbtText;
end;

function TdxPieChartAnnotationLocationHelper.ToString: string;
begin
  case self of
    pcalCenter:
      Result := 'center';
    pcalEdge:
      Result := 'edge';
  end;
end;

class function TdxPieChartAnnotationLocationHelper.FromString(const value: string): TdxPieChartAnnotationLocation;
begin
  Result := pcalCenter;

  if value = 'center' then
    Result := pcalCenter
  else
    if value = 'edge' then
      Result := pcalEdge;
end;

function TdxPieChartLegendHoverModeHelper.ToString: string;
begin
  case self of
    pclhmAllArgumentPoints:
      Result := 'allArgumentPoints';
    pclhmNone:
      Result := 'none';
  end;
end;

class function TdxPieChartLegendHoverModeHelper.FromString(const value: string): TdxPieChartLegendHoverMode;
begin
  Result := pclhmAllArgumentPoints;

  if value = 'allArgumentPoints' then
    Result := pclhmAllArgumentPoints
  else
    if value = 'none' then
      Result := pclhmNone;
end;

function TdxPieChartSegmentDirectionHelper.ToString: string;
begin
  case self of
    pcsdAnticlockwise:
      Result := 'anticlockwise';
    pcsdClockwise:
      Result := 'clockwise';
  end;
end;

class function TdxPieChartSegmentDirectionHelper.FromString(const value: string): TdxPieChartSegmentDirection;
begin
  Result := pcsdAnticlockwise;

  if value = 'anticlockwise' then
    Result := pcsdAnticlockwise
  else
    if value = 'clockwise' then
      Result := pcsdClockwise;
end;

function TdxPieChartSeriesInteractionModeHelper.ToString: string;
begin
  case self of
    pcsimNone:
      Result := 'none';
    pcsimOnlyPoint:
      Result := 'onlyPoint';
  end;
end;

class function TdxPieChartSeriesInteractionModeHelper.FromString(const value: string): TdxPieChartSeriesInteractionMode;
begin
  Result := pcsimNone;

  if value = 'none' then
    Result := pcsimNone
  else
    if value = 'onlyPoint' then
      Result := pcsimOnlyPoint;
end;

function TdxPieChartTypeHelper.ToString: string;
begin
  case self of
    pctDonut:
      Result := 'donut';
    pctDoughnut:
      Result := 'doughnut';
    pctPie:
      Result := 'pie';
  end;
end;

class function TdxPieChartTypeHelper.FromString(const value: string): TdxPieChartType;
begin
  Result := pctDonut;

  if value = 'donut' then
    Result := pctDonut
  else
    if value = 'doughnut' then
      Result := pctDoughnut
    else
      if value = 'pie' then
        Result := pctPie;
end;

function TdxSmallValuesGroupingModeHelper.ToString: string;
begin
  case self of
    svgmNone:
      Result := 'none';
    svgmSmallValueThreshold:
      Result := 'smallValueThreshold';
    svgmTopN:
      Result := 'topN';
  end;
end;

class function TdxSmallValuesGroupingModeHelper.FromString(const value: string): TdxSmallValuesGroupingMode;
begin
  Result := svgmNone;

  if value = 'none' then
    Result := svgmNone
  else
    if value = 'smallValueThreshold' then
      Result := svgmSmallValueThreshold
    else
      if value = 'topN' then
        Result := svgmTopN;
end;

function TdxPivotGridAreaHelper.ToString: string;
begin
  case self of
    pgaColumn:
      Result := 'column';
    pgaData:
      Result := 'data';
    pgaFilter:
      Result := 'filter';
    pgaRow:
      Result := 'row';
  end;
end;

class function TdxPivotGridAreaHelper.FromString(const value: string): TdxPivotGridArea;
begin
  Result := pgaColumn;

  if value = 'column' then
    Result := pgaColumn
  else
    if value = 'data' then
      Result := pgaData
    else
      if value = 'filter' then
        Result := pgaFilter
      else
        if value = 'row' then
          Result := pgaRow;
end;

function TdxPivotGridDataFieldAreaHelper.ToString: string;
begin
  case self of
    pgdfaColumn:
      Result := 'column';
    pgdfaRow:
      Result := 'row';
  end;
end;

class function TdxPivotGridDataFieldAreaHelper.FromString(const value: string): TdxPivotGridDataFieldArea;
begin
  Result := pgdfaColumn;

  if value = 'column' then
    Result := pgdfaColumn
  else
    if value = 'row' then
      Result := pgdfaRow;
end;

function TdxPivotGridDataTypeHelper.ToString: string;
begin
  case self of
    pgdtDate:
      Result := 'date';
    pgdtNumber:
      Result := 'number';
    pgdtString:
      Result := 'string';
  end;
end;

class function TdxPivotGridDataTypeHelper.FromString(const value: string): TdxPivotGridDataType;
begin
  Result := pgdtDate;

  if value = 'date' then
    Result := pgdtDate
  else
    if value = 'number' then
      Result := pgdtNumber
    else
      if value = 'string' then
        Result := pgdtString;
end;

function TdxPivotGridGroupIntervalHelper.ToString: string;
begin
  case self of
    pggiDay:
      Result := 'day';
    pggiDayOfWeek:
      Result := 'dayOfWeek';
    pggiMonth:
      Result := 'month';
    pggiQuarter:
      Result := 'quarter';
    pggiYear:
      Result := 'year';
  end;
end;

class function TdxPivotGridGroupIntervalHelper.FromString(const value: string): TdxPivotGridGroupInterval;
begin
  Result := pggiDay;

  if value = 'day' then
    Result := pggiDay
  else
    if value = 'dayOfWeek' then
      Result := pggiDayOfWeek
    else
      if value = 'month' then
        Result := pggiMonth
      else
        if value = 'quarter' then
          Result := pggiQuarter
        else
          if value = 'year' then
            Result := pggiYear;
end;

function TdxPivotGridRowHeaderLayoutHelper.ToString: string;
begin
  case self of
    pgrhlStandard:
      Result := 'standard';
    pgrhlTree:
      Result := 'tree';
  end;
end;

class function TdxPivotGridRowHeaderLayoutHelper.FromString(const value: string): TdxPivotGridRowHeaderLayout;
begin
  Result := pgrhlStandard;

  if value = 'standard' then
    Result := pgrhlStandard
  else
    if value = 'tree' then
      Result := pgrhlTree;
end;

function TdxPivotGridRunningTotalModeHelper.ToString: string;
begin
  case self of
    pgrtmColumn:
      Result := 'column';
    pgrtmRow:
      Result := 'row';
  end;
end;

class function TdxPivotGridRunningTotalModeHelper.FromString(const value: string): TdxPivotGridRunningTotalMode;
begin
  Result := pgrtmColumn;

  if value = 'column' then
    Result := pgrtmColumn
  else
    if value = 'row' then
      Result := pgrtmRow;
end;

function TdxPivotGridSortByHelper.ToString: string;
begin
  case self of
    pgsbDisplayText:
      Result := 'displayText';
    pgsbNone:
      Result := 'none';
    pgsbValue:
      Result := 'value';
  end;
end;

class function TdxPivotGridSortByHelper.FromString(const value: string): TdxPivotGridSortBy;
begin
  Result := pgsbDisplayText;

  if value = 'displayText' then
    Result := pgsbDisplayText
  else
    if value = 'none' then
      Result := pgsbNone
    else
      if value = 'value' then
        Result := pgsbValue;
end;

function TdxPivotGridStoreTypeHelper.ToString: string;
begin
  case self of
    pgstArray:
      Result := 'array';
    pgstLocal:
      Result := 'local';
    pgstOdata:
      Result := 'odata';
    pgstXmla:
      Result := 'xmla';
  end;
end;

class function TdxPivotGridStoreTypeHelper.FromString(const value: string): TdxPivotGridStoreType;
begin
  Result := pgstArray;

  if value = 'array' then
    Result := pgstArray
  else
    if value = 'local' then
      Result := pgstLocal
    else
      if value = 'odata' then
        Result := pgstOdata
      else
        if value = 'xmla' then
          Result := pgstXmla;
end;

function TdxPivotGridSummaryDisplayModeHelper.ToString: string;
begin
  case self of
    pgsdmAbsoluteVariation:
      Result := 'absoluteVariation';
    pgsdmPercentOfColumnGrandTotal:
      Result := 'percentOfColumnGrandTotal';
    pgsdmPercentOfColumnTotal:
      Result := 'percentOfColumnTotal';
    pgsdmPercentOfGrandTotal:
      Result := 'percentOfGrandTotal';
    pgsdmPercentOfRowGrandTotal:
      Result := 'percentOfRowGrandTotal';
    pgsdmPercentOfRowTotal:
      Result := 'percentOfRowTotal';
    pgsdmPercentVariation:
      Result := 'percentVariation';
  end;
end;

class function TdxPivotGridSummaryDisplayModeHelper.FromString(const value: string): TdxPivotGridSummaryDisplayMode;
begin
  Result := pgsdmAbsoluteVariation;

  if value = 'absoluteVariation' then
    Result := pgsdmAbsoluteVariation
  else
    if value = 'percentOfColumnGrandTotal' then
      Result := pgsdmPercentOfColumnGrandTotal
    else
      if value = 'percentOfColumnTotal' then
        Result := pgsdmPercentOfColumnTotal
      else
        if value = 'percentOfGrandTotal' then
          Result := pgsdmPercentOfGrandTotal
        else
          if value = 'percentOfRowGrandTotal' then
            Result := pgsdmPercentOfRowGrandTotal
          else
            if value = 'percentOfRowTotal' then
              Result := pgsdmPercentOfRowTotal
            else
              if value = 'percentVariation' then
                Result := pgsdmPercentVariation;
end;

function TdxPivotGridTotalDisplayModeHelper.ToString: string;
begin
  case self of
    pgtdmBoth:
      Result := 'both';
    pgtdmColumns:
      Result := 'columns';
    pgtdmNone:
      Result := 'none';
    pgtdmRows:
      Result := 'rows';
  end;
end;

class function TdxPivotGridTotalDisplayModeHelper.FromString(const value: string): TdxPivotGridTotalDisplayMode;
begin
  Result := pgtdmBoth;

  if value = 'both' then
    Result := pgtdmBoth
  else
    if value = 'columns' then
      Result := pgtdmColumns
    else
      if value = 'none' then
        Result := pgtdmNone
      else
        if value = 'rows' then
          Result := pgtdmRows;
end;

function TdxPolarChartSeriesTypeHelper.ToString: string;
begin
  case self of
    pcstArea:
      Result := 'area';
    pcstBar:
      Result := 'bar';
    pcstLine:
      Result := 'line';
    pcstScatter:
      Result := 'scatter';
    pcstStackedbar:
      Result := 'stackedbar';
  end;
end;

class function TdxPolarChartSeriesTypeHelper.FromString(const value: string): TdxPolarChartSeriesType;
begin
  Result := pcstArea;

  if value = 'area' then
    Result := pcstArea
  else
    if value = 'bar' then
      Result := pcstBar
    else
      if value = 'line' then
        Result := pcstLine
      else
        if value = 'scatter' then
          Result := pcstScatter
        else
          if value = 'stackedbar' then
            Result := pcstStackedbar;
end;

function TdxValueAxisVisualRangeUpdateModeHelper.ToString: string;
begin
  case self of
    vavrumAuto:
      Result := 'auto';
    vavrumKeep:
      Result := 'keep';
    vavrumReset:
      Result := 'reset';
  end;
end;

class function TdxValueAxisVisualRangeUpdateModeHelper.FromString(const value: string): TdxValueAxisVisualRangeUpdateMode;
begin
  Result := vavrumAuto;

  if value = 'auto' then
    Result := vavrumAuto
  else
    if value = 'keep' then
      Result := vavrumKeep
    else
      if value = 'reset' then
        Result := vavrumReset;
end;

function TdxToolbarLocationHelper.ToString: string;
begin
  case self of
    tlBottom:
      Result := 'bottom';
    tlTop:
      Result := 'top';
  end;
end;

class function TdxToolbarLocationHelper.FromString(const value: string): TdxToolbarLocation;
begin
  Result := tlBottom;

  if value = 'bottom' then
    Result := tlBottom
  else
    if value = 'top' then
      Result := tlTop;
end;

function TdxAxisScaleHelper.ToString: string;
begin
  case self of
    asContinuous:
      Result := 'continuous';
    asDiscrete:
      Result := 'discrete';
    asLogarithmic:
      Result := 'logarithmic';
    asSemidiscrete:
      Result := 'semidiscrete';
  end;
end;

class function TdxAxisScaleHelper.FromString(const value: string): TdxAxisScale;
begin
  Result := asContinuous;

  if value = 'continuous' then
    Result := asContinuous
  else
    if value = 'discrete' then
      Result := asDiscrete
    else
      if value = 'logarithmic' then
        Result := asLogarithmic
      else
        if value = 'semidiscrete' then
          Result := asSemidiscrete;
end;

function TdxBackgroundImageLocationHelper.ToString: string;
begin
  case self of
    bilCenter:
      Result := 'center';
    bilCenterBottom:
      Result := 'centerBottom';
    bilCenterTop:
      Result := 'centerTop';
    bilFull:
      Result := 'full';
    bilLeftBottom:
      Result := 'leftBottom';
    bilLeftCenter:
      Result := 'leftCenter';
    bilLeftTop:
      Result := 'leftTop';
    bilRightBottom:
      Result := 'rightBottom';
    bilRightCenter:
      Result := 'rightCenter';
    bilRightTop:
      Result := 'rightTop';
  end;
end;

class function TdxBackgroundImageLocationHelper.FromString(const value: string): TdxBackgroundImageLocation;
begin
  Result := bilCenter;

  if value = 'center' then
    Result := bilCenter
  else
    if value = 'centerBottom' then
      Result := bilCenterBottom
    else
      if value = 'centerTop' then
        Result := bilCenterTop
      else
        if value = 'full' then
          Result := bilFull
        else
          if value = 'leftBottom' then
            Result := bilLeftBottom
          else
            if value = 'leftCenter' then
              Result := bilLeftCenter
            else
              if value = 'leftTop' then
                Result := bilLeftTop
              else
                if value = 'rightBottom' then
                  Result := bilRightBottom
                else
                  if value = 'rightCenter' then
                    Result := bilRightCenter
                  else
                    if value = 'rightTop' then
                      Result := bilRightTop;
end;

function TdxChartAxisScaleHelper.ToString: string;
begin
  case self of
    casContinuous:
      Result := 'continuous';
    casLogarithmic:
      Result := 'logarithmic';
  end;
end;

class function TdxChartAxisScaleHelper.FromString(const value: string): TdxChartAxisScale;
begin
  Result := casContinuous;

  if value = 'continuous' then
    Result := casContinuous
  else
    if value = 'logarithmic' then
      Result := casLogarithmic;
end;

function TdxValueChangedCallModeHelper.ToString: string;
begin
  case self of
    vccmOnMoving:
      Result := 'onMoving';
    vccmOnMovingComplete:
      Result := 'onMovingComplete';
  end;
end;

class function TdxValueChangedCallModeHelper.FromString(const value: string): TdxValueChangedCallMode;
begin
  Result := vccmOnMoving;

  if value = 'onMoving' then
    Result := vccmOnMoving
  else
    if value = 'onMovingComplete' then
      Result := vccmOnMovingComplete;
end;

function TdxResizeHandleHelper.ToString: string;
begin
  case self of
    rhAll:
      Result := 'all';
    rhBottom:
      Result := 'bottom';
    rhLeft:
      Result := 'left';
    rhRight:
      Result := 'right';
    rhTop:
      Result := 'top';
  end;
end;

class function TdxResizeHandleHelper.FromString(const value: string): TdxResizeHandle;
begin
  Result := rhAll;

  if value = 'all' then
    Result := rhAll
  else
    if value = 'bottom' then
      Result := rhBottom
    else
      if value = 'left' then
        Result := rhLeft
      else
        if value = 'right' then
          Result := rhRight
        else
          if value = 'top' then
            Result := rhTop;
end;

function TdxResizableStepPrecisionHelper.ToString: string;
begin
  case self of
    rspSimple:
      Result := 'simple';
    rspStrict:
      Result := 'strict';
  end;
end;

class function TdxResizableStepPrecisionHelper.FromString(const value: string): TdxResizableStepPrecision;
begin
  Result := rspSimple;

  if value = 'simple' then
    Result := rspSimple
  else
    if value = 'strict' then
      Result := rspStrict;
end;

function TdxSankeyColorModeHelper.ToString: string;
begin
  case self of
    scmGradient:
      Result := 'gradient';
    scmNone:
      Result := 'none';
    scmSource:
      Result := 'source';
    scmTarget:
      Result := 'target';
  end;
end;

class function TdxSankeyColorModeHelper.FromString(const value: string): TdxSankeyColorMode;
begin
  Result := scmGradient;

  if value = 'gradient' then
    Result := scmGradient
  else
    if value = 'none' then
      Result := scmNone
    else
      if value = 'source' then
        Result := scmSource
      else
        if value = 'target' then
          Result := scmTarget;
end;

function TdxAllDayPanelModeHelper.ToString: string;
begin
  case self of
    adpmAll:
      Result := 'all';
    adpmAllDay:
      Result := 'allDay';
    adpmHidden:
      Result := 'hidden';
  end;
end;

class function TdxAllDayPanelModeHelper.FromString(const value: string): TdxAllDayPanelMode;
begin
  Result := adpmAll;

  if value = 'all' then
    Result := adpmAll
  else
    if value = 'allDay' then
      Result := adpmAllDay
    else
      if value = 'hidden' then
        Result := adpmHidden;
end;

function TdxCellAppointmentsLimitHelper.ToString: string;
begin
  case self of
    calAuto:
      Result := 'auto';
    calUnlimited:
      Result := 'unlimited';
  end;
end;

class function TdxCellAppointmentsLimitHelper.FromString(const value: string): TdxCellAppointmentsLimit;
begin
  Result := calAuto;

  if value = 'auto' then
    Result := calAuto
  else
    if value = 'unlimited' then
      Result := calUnlimited;
end;

function TdxRecurrenceEditModeHelper.ToString: string;
begin
  case self of
    remDialog:
      Result := 'dialog';
    remOccurrence:
      Result := 'occurrence';
    remSeries:
      Result := 'series';
  end;
end;

class function TdxRecurrenceEditModeHelper.FromString(const value: string): TdxRecurrenceEditMode;
begin
  Result := remDialog;

  if value = 'dialog' then
    Result := remDialog
  else
    if value = 'occurrence' then
      Result := remOccurrence
    else
      if value = 'series' then
        Result := remSeries;
end;

function TdxViewTypeHelper.ToString: string;
begin
  case self of
    vtAgenda:
      Result := 'agenda';
    vtDay:
      Result := 'day';
    vtMonth:
      Result := 'month';
    vtTimelineDay:
      Result := 'timelineDay';
    vtTimelineMonth:
      Result := 'timelineMonth';
    vtTimelineWeek:
      Result := 'timelineWeek';
    vtTimelineWorkWeek:
      Result := 'timelineWorkWeek';
    vtWeek:
      Result := 'week';
    vtWorkWeek:
      Result := 'workWeek';
  end;
end;

class function TdxViewTypeHelper.FromString(const value: string): TdxViewType;
begin
  Result := vtAgenda;

  if value = 'agenda' then
    Result := vtAgenda
  else
    if value = 'day' then
      Result := vtDay
    else
      if value = 'month' then
        Result := vtMonth
      else
        if value = 'timelineDay' then
          Result := vtTimelineDay
        else
          if value = 'timelineMonth' then
            Result := vtTimelineMonth
          else
            if value = 'timelineWeek' then
              Result := vtTimelineWeek
            else
              if value = 'timelineWorkWeek' then
                Result := vtTimelineWorkWeek
              else
                if value = 'week' then
                  Result := vtWeek
                else
                  if value = 'workWeek' then
                    Result := vtWorkWeek;
end;

function TdxScrollableShowScrollbarHelper.ToString: string;
begin
  case self of
    sssAlways:
      Result := 'always';
    sssNever:
      Result := 'never';
    sssOnHover:
      Result := 'onHover';
    sssOnScroll:
      Result := 'onScroll';
  end;
end;

class function TdxScrollableShowScrollbarHelper.FromString(const value: string): TdxScrollableShowScrollbar;
begin
  Result := sssAlways;

  if value = 'always' then
    Result := sssAlways
  else
    if value = 'never' then
      Result := sssNever
    else
      if value = 'onHover' then
        Result := sssOnHover
      else
        if value = 'onScroll' then
          Result := sssOnScroll;
end;

function TdxSparklineTypeHelper.ToString: string;
begin
  case self of
    stArea:
      Result := 'area';
    stBar:
      Result := 'bar';
    stLine:
      Result := 'line';
    stSpline:
      Result := 'spline';
    stSplinearea:
      Result := 'splinearea';
    stSteparea:
      Result := 'steparea';
    stStepline:
      Result := 'stepline';
    stWinloss:
      Result := 'winloss';
  end;
end;

class function TdxSparklineTypeHelper.FromString(const value: string): TdxSparklineType;
begin
  Result := stArea;

  if value = 'area' then
    Result := stArea
  else
    if value = 'bar' then
      Result := stBar
    else
      if value = 'line' then
        Result := stLine
      else
        if value = 'spline' then
          Result := stSpline
        else
          if value = 'splinearea' then
            Result := stSplinearea
          else
            if value = 'steparea' then
              Result := stSteparea
            else
              if value = 'stepline' then
                Result := stStepline
              else
                if value = 'winloss' then
                  Result := stWinloss;
end;

function TdxToastTypeHelper.ToString: string;
begin
  case self of
    ttCustom:
      Result := 'custom';
    ttError:
      Result := 'error';
    ttInfo:
      Result := 'info';
    ttSuccess:
      Result := 'success';
    ttWarning:
      Result := 'warning';
  end;
end;

class function TdxToastTypeHelper.FromString(const value: string): TdxToastType;
begin
  Result := ttCustom;

  if value = 'custom' then
    Result := ttCustom
  else
    if value = 'error' then
      Result := ttError
    else
      if value = 'info' then
        Result := ttInfo
      else
        if value = 'success' then
          Result := ttSuccess
        else
          if value = 'warning' then
            Result := ttWarning;
end;

function TdxLocateInMenuModeHelper.ToString: string;
begin
  case self of
    limmAlways:
      Result := 'always';
    limmAuto:
      Result := 'auto';
    limmNever:
      Result := 'never';
  end;
end;

class function TdxLocateInMenuModeHelper.FromString(const value: string): TdxLocateInMenuMode;
begin
  Result := limmAlways;

  if value = 'always' then
    Result := limmAlways
  else
    if value = 'auto' then
      Result := limmAuto
    else
      if value = 'never' then
        Result := limmNever;
end;

function TdxShowTextModeHelper.ToString: string;
begin
  case self of
    stmAlways:
      Result := 'always';
    stmInMenu:
      Result := 'inMenu';
  end;
end;

class function TdxShowTextModeHelper.FromString(const value: string): TdxShowTextMode;
begin
  Result := stmAlways;

  if value = 'always' then
    Result := stmAlways
  else
    if value = 'inMenu' then
      Result := stmInMenu;
end;

function TdxTreeListCommandColumnTypeHelper.ToString: string;
begin
  case self of
    tlcctAdaptive:
      Result := 'adaptive';
    tlcctButtons:
      Result := 'buttons';
    tlcctDrag:
      Result := 'drag';
  end;
end;

class function TdxTreeListCommandColumnTypeHelper.FromString(const value: string): TdxTreeListCommandColumnType;
begin
  Result := tlcctAdaptive;

  if value = 'adaptive' then
    Result := tlcctAdaptive
  else
    if value = 'buttons' then
      Result := tlcctButtons
    else
      if value = 'drag' then
        Result := tlcctDrag;
end;

function TdxTreeListFilterModeHelper.ToString: string;
begin
  case self of
    tlfmFullBranch:
      Result := 'fullBranch';
    tlfmMatchOnly:
      Result := 'matchOnly';
    tlfmWithAncestors:
      Result := 'withAncestors';
  end;
end;

class function TdxTreeListFilterModeHelper.FromString(const value: string): TdxTreeListFilterMode;
begin
  Result := tlfmFullBranch;

  if value = 'fullBranch' then
    Result := tlfmFullBranch
  else
    if value = 'matchOnly' then
      Result := tlfmMatchOnly
    else
      if value = 'withAncestors' then
        Result := tlfmWithAncestors;
end;

function TdxTreeListPredefinedColumnButtonHelper.ToString: string;
begin
  case self of
    tlpcbAdd:
      Result := 'add';
    tlpcbCancel:
      Result := 'cancel';
    tlpcbDelete:
      Result := 'delete';
    tlpcbEdit:
      Result := 'edit';
    tlpcbSave:
      Result := 'save';
    tlpcbUndelete:
      Result := 'undelete';
  end;
end;

class function TdxTreeListPredefinedColumnButtonHelper.FromString(const value: string): TdxTreeListPredefinedColumnButton;
begin
  Result := tlpcbAdd;

  if value = 'add' then
    Result := tlpcbAdd
  else
    if value = 'cancel' then
      Result := tlpcbCancel
    else
      if value = 'delete' then
        Result := tlpcbDelete
      else
        if value = 'edit' then
          Result := tlpcbEdit
        else
          if value = 'save' then
            Result := tlpcbSave
          else
            if value = 'undelete' then
              Result := tlpcbUndelete;
end;

function TdxTreeListPredefinedToolbarItemHelper.ToString: string;
begin
  case self of
    tlptiAddRowButton:
      Result := 'addRowButton';
    tlptiApplyFilterButton:
      Result := 'applyFilterButton';
    tlptiColumnChooserButton:
      Result := 'columnChooserButton';
    tlptiRevertButton:
      Result := 'revertButton';
    tlptiSaveButton:
      Result := 'saveButton';
    tlptiSearchPanel:
      Result := 'searchPanel';
  end;
end;

class function TdxTreeListPredefinedToolbarItemHelper.FromString(const value: string): TdxTreeListPredefinedToolbarItem;
begin
  Result := tlptiAddRowButton;

  if value = 'addRowButton' then
    Result := tlptiAddRowButton
  else
    if value = 'applyFilterButton' then
      Result := tlptiApplyFilterButton
    else
      if value = 'columnChooserButton' then
        Result := tlptiColumnChooserButton
      else
        if value = 'revertButton' then
          Result := tlptiRevertButton
        else
          if value = 'saveButton' then
            Result := tlptiSaveButton
          else
            if value = 'searchPanel' then
              Result := tlptiSearchPanel;
end;

function TdxTreeMapColorizerTypeHelper.ToString: string;
begin
  case self of
    tmctDiscrete:
      Result := 'discrete';
    tmctGradient:
      Result := 'gradient';
    tmctNone:
      Result := 'none';
    tmctRange:
      Result := 'range';
  end;
end;

class function TdxTreeMapColorizerTypeHelper.FromString(const value: string): TdxTreeMapColorizerType;
begin
  Result := tmctDiscrete;

  if value = 'discrete' then
    Result := tmctDiscrete
  else
    if value = 'gradient' then
      Result := tmctGradient
    else
      if value = 'none' then
        Result := tmctNone
      else
        if value = 'range' then
          Result := tmctRange;
end;

function TdxTreeMapLayoutAlgorithmHelper.ToString: string;
begin
  case self of
    tmlaSliceanddice:
      Result := 'sliceanddice';
    tmlaSquarified:
      Result := 'squarified';
    tmlaStrip:
      Result := 'strip';
  end;
end;

class function TdxTreeMapLayoutAlgorithmHelper.FromString(const value: string): TdxTreeMapLayoutAlgorithm;
begin
  Result := tmlaSliceanddice;

  if value = 'sliceanddice' then
    Result := tmlaSliceanddice
  else
    if value = 'squarified' then
      Result := tmlaSquarified
    else
      if value = 'strip' then
        Result := tmlaStrip;
end;

function TdxTreeMapLayoutDirectionHelper.ToString: string;
begin
  case self of
    tmldLeftBottomRightTop:
      Result := 'leftBottomRightTop';
    tmldLeftTopRightBottom:
      Result := 'leftTopRightBottom';
    tmldRightBottomLeftTop:
      Result := 'rightBottomLeftTop';
    tmldRightTopLeftBottom:
      Result := 'rightTopLeftBottom';
  end;
end;

class function TdxTreeMapLayoutDirectionHelper.FromString(const value: string): TdxTreeMapLayoutDirection;
begin
  Result := tmldLeftBottomRightTop;

  if value = 'leftBottomRightTop' then
    Result := tmldLeftBottomRightTop
  else
    if value = 'leftTopRightBottom' then
      Result := tmldLeftTopRightBottom
    else
      if value = 'rightBottomLeftTop' then
        Result := tmldRightBottomLeftTop
      else
        if value = 'rightTopLeftBottom' then
          Result := tmldRightTopLeftBottom;
end;

function TdxTreeViewCheckBoxModeHelper.ToString: string;
begin
  case self of
    tvcbmNone:
      Result := 'none';
    tvcbmNormal:
      Result := 'normal';
    tvcbmSelectAll:
      Result := 'selectAll';
  end;
end;

class function TdxTreeViewCheckBoxModeHelper.FromString(const value: string): TdxTreeViewCheckBoxMode;
begin
  Result := tvcbmNone;

  if value = 'none' then
    Result := tvcbmNone
  else
    if value = 'normal' then
      Result := tvcbmNormal
    else
      if value = 'selectAll' then
        Result := tvcbmSelectAll;
end;

function TdxTreeViewExpandEventHelper.ToString: string;
begin
  case self of
    tveeClick:
      Result := 'click';
    tveeDblclick:
      Result := 'dblclick';
  end;
end;

class function TdxTreeViewExpandEventHelper.FromString(const value: string): TdxTreeViewExpandEvent;
begin
  Result := tveeClick;

  if value = 'click' then
    Result := tveeClick
  else
    if value = 'dblclick' then
      Result := tveeDblclick;
end;

function TdxVectorMapLayerTypeHelper.ToString: string;
begin
  case self of
    vmltArea:
      Result := 'area';
    vmltLine:
      Result := 'line';
    vmltMarker:
      Result := 'marker';
  end;
end;

class function TdxVectorMapLayerTypeHelper.FromString(const value: string): TdxVectorMapLayerType;
begin
  Result := vmltArea;

  if value = 'area' then
    Result := vmltArea
  else
    if value = 'line' then
      Result := vmltLine
    else
      if value = 'marker' then
        Result := vmltMarker;
end;

function TdxVectorMapMarkerShapeHelper.ToString: string;
begin
  case self of
    vmmsCircle:
      Result := 'circle';
    vmmsSquare:
      Result := 'square';
  end;
end;

class function TdxVectorMapMarkerShapeHelper.FromString(const value: string): TdxVectorMapMarkerShape;
begin
  Result := vmmsCircle;

  if value = 'circle' then
    Result := vmmsCircle
  else
    if value = 'square' then
      Result := vmmsSquare;
end;

function TdxVectorMapMarkerTypeHelper.ToString: string;
begin
  case self of
    vmmtBubble:
      Result := 'bubble';
    vmmtDot:
      Result := 'dot';
    vmmtImage:
      Result := 'image';
    vmmtPie:
      Result := 'pie';
  end;
end;

class function TdxVectorMapMarkerTypeHelper.FromString(const value: string): TdxVectorMapMarkerType;
begin
  Result := vmmtBubble;

  if value = 'bubble' then
    Result := vmmtBubble
  else
    if value = 'dot' then
      Result := vmmtDot
    else
      if value = 'image' then
        Result := vmmtImage
      else
        if value = 'pie' then
          Result := vmmtPie;
end;

function TdxVectorMapProjectionHelper.ToString: string;
begin
  case self of
    vmpEquirectangular:
      Result := 'equirectangular';
    vmpLambert:
      Result := 'lambert';
    vmpMercator:
      Result := 'mercator';
    vmpMiller:
      Result := 'miller';
  end;
end;

class function TdxVectorMapProjectionHelper.FromString(const value: string): TdxVectorMapProjection;
begin
  Result := vmpEquirectangular;

  if value = 'equirectangular' then
    Result := vmpEquirectangular
  else
    if value = 'lambert' then
      Result := vmpLambert
    else
      if value = 'mercator' then
        Result := vmpMercator
      else
        if value = 'miller' then
          Result := vmpMiller;
end;

end.
