unit DevExtreme.factory;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  jsdelphisystem,
  js,
  web,
  DevExtreme.Accordion.js,
  DevExtreme.ActionSheet.js,
  DevExtreme.Autocomplete.js,
  DevExtreme.BarGauge.js,
  DevExtreme.Box.js,
  DevExtreme.Bullet.js,
  DevExtreme.Button.js,
  DevExtreme.ButtonGroup.js,
  DevExtreme.Calendar.js,
  DevExtreme.Chart.js,
  DevExtreme.CheckBox.js,
  DevExtreme.CircularGauge.js,
  DevExtreme.ColorBox.js,
  DevExtreme.ContextMenu.js,
  DevExtreme.DataGrid.js,
  DevExtreme.DateBox.js,
  DevExtreme.DeferRendering.js,
  DevExtreme.Diagram.js,
  DevExtreme.Draggable.js,
  DevExtreme.Drawer.js,
  DevExtreme.DropDownBox.js,
  DevExtreme.DropDownButton.js,
  DevExtreme.DropDownEditor.js,
  DevExtreme.DropDownList.js,
  DevExtreme.FileManager.js,
  DevExtreme.FileUploader.js,
  DevExtreme.FilterBuilder.js,
  DevExtreme.Form.js,
  DevExtreme.Funnel.js,
  DevExtreme.Gallery.js,
  DevExtreme.Gantt.js,
  DevExtreme.HtmlEditor.js,
  DevExtreme.LinearGauge.js,
  DevExtreme.List.js,
  DevExtreme.LoadIndicator.js,
  DevExtreme.LoadPanel.js,
  DevExtreme.Lookup.js,
  DevExtreme.Map.js,
  DevExtreme.Menu.js,
  DevExtreme.MenuBase.js,
  DevExtreme.MultiView.js,
  DevExtreme.NumberBox.js,
  DevExtreme.Overlay.js,
  DevExtreme.PieChart.js,
  DevExtreme.PivotGrid.js,
  DevExtreme.PivotGridFieldChooser.js,
  DevExtreme.PolarChart.js,
  DevExtreme.Popover.js,
  DevExtreme.Popup.js,
  DevExtreme.ProgressBar.js,
  DevExtreme.RadioButton.js,
  DevExtreme.RadioGroup.js,
  DevExtreme.RangeSelector.js,
  DevExtreme.RangeSlider.js,
  DevExtreme.Resizable.js,
  DevExtreme.ResponsiveBox.js,
  DevExtreme.Sankey.js,
  DevExtreme.Scheduler.js,
  DevExtreme.Scrollable.js,
  DevExtreme.ScrollView.js,
  DevExtreme.SelectBox.js,
  DevExtreme.Slider.js,
  DevExtreme.SliderBase.js,
  DevExtreme.Sortable.js,
  DevExtreme.Sparkline.js,
  DevExtreme.SpeedDialAction.js,
  DevExtreme.Switch.js,
  DevExtreme.TabPanel.js,
  DevExtreme.Tabs.js,
  DevExtreme.TagBox.js,
  DevExtreme.TextArea.js,
  DevExtreme.TextBox.js,
  DevExtreme.TextEditor.js,
  DevExtreme.TileView.js,
  DevExtreme.Toast.js,
  DevExtreme.Toolbar.js,
  DevExtreme.Tooltip.js,
  DevExtreme.TrackBar.js,
  DevExtreme.TreeList.js,
  DevExtreme.TreeMap.js,
  DevExtreme.TreeView.js,
  DevExtreme.ValidationGroup.js,
  DevExtreme.ValidationSummary.js,
  DevExtreme.Validator.js,
  DevExtreme.VectorMap.js,
  DevExtreme.Base,
  DevExtreme.Options,
  DevExtreme.Data,
  DevExtreme.Types;

type
  TdxFactory = record
  private
    class function FieldsPropName(const className: string): string; static;
    class function ParseFields(const className: string; Fields: TJSArray): TJSArray; static;

    class procedure Make(const WidgetId, dm, dataset, className: string; DataSource: TjdxDataSource; defaultOptions: TJSObject; resolverProc: TdxCallBack<TJSObject>); static;
  public

    class function Accordion(const WidgetId: string; Options: TJSObject): TdxAccordion; assembler; overload; static;
    class function Accordion(const WidgetId, dm, name: string; out dxAccordion: TdxAccordion): TJSPromise; overload; static;
    class function Accordion(const WidgetId: string; DataSource: TjdxDataSource; out dxAccordion: TdxAccordion): TJSPromise; overload; static;

    class function ActionSheet(const WidgetId: string; Options: TJSObject): TdxActionSheet; assembler; overload; static;
    class function ActionSheet(const WidgetId, dm, name: string; out dxActionSheet: TdxActionSheet): TJSPromise; overload; static;
    class function ActionSheet(const WidgetId: string; DataSource: TjdxDataSource; out dxActionSheet: TdxActionSheet): TJSPromise; overload; static;

    class function Autocomplete(const WidgetId: string; Options: TJSObject): TdxAutocomplete; assembler; overload; static;
    class function Autocomplete(const WidgetId, dm, name: string; out dxAutocomplete: TdxAutocomplete): TJSPromise; overload; static;
    class function Autocomplete(const WidgetId: string; DataSource: TjdxDataSource; out dxAutocomplete: TdxAutocomplete): TJSPromise; overload; static;

    class function BarGauge(const WidgetId: string; Options: TJSObject): TdxBarGauge; assembler; overload; static;
    class function BarGauge(const WidgetId, dm, name: string; out dxBarGauge: TdxBarGauge): TJSPromise; overload; static;
    class function BarGauge(const WidgetId: string; DataSource: TjdxDataSource; out dxBarGauge: TdxBarGauge): TJSPromise; overload; static;

    class function Box(const WidgetId: string; Options: TJSObject): TdxBox; assembler; overload; static;
    class function Box(const WidgetId, dm, name: string; out dxBox: TdxBox): TJSPromise; overload; static;
    class function Box(const WidgetId: string; DataSource: TjdxDataSource; out dxBox: TdxBox): TJSPromise; overload; static;

    class function Bullet(const WidgetId: string; Options: TJSObject): TdxBullet; assembler; overload; static;
    class function Bullet(const WidgetId, dm, name: string; out dxBullet: TdxBullet): TJSPromise; overload; static;
    class function Bullet(const WidgetId: string; DataSource: TjdxDataSource; out dxBullet: TdxBullet): TJSPromise; overload; static;

    class function Button(const WidgetId: string; Options: TJSObject): TdxButton; assembler; overload; static;
    class function Button(const WidgetId, dm, name: string; out dxButton: TdxButton): TJSPromise; overload; static;
    class function Button(const WidgetId: string; DataSource: TjdxDataSource; out dxButton: TdxButton): TJSPromise; overload; static;

    class function ButtonGroup(const WidgetId: string; Options: TJSObject): TdxButtonGroup; assembler; overload; static;
    class function ButtonGroup(const WidgetId, dm, name: string; out dxButtonGroup: TdxButtonGroup): TJSPromise; overload; static;
    class function ButtonGroup(const WidgetId: string; DataSource: TjdxDataSource; out dxButtonGroup: TdxButtonGroup): TJSPromise; overload; static;

    class function Calendar(const WidgetId: string; Options: TJSObject): TdxCalendar; assembler; overload; static;
    class function Calendar(const WidgetId, dm, name: string; out dxCalendar: TdxCalendar): TJSPromise; overload; static;
    class function Calendar(const WidgetId: string; DataSource: TjdxDataSource; out dxCalendar: TdxCalendar): TJSPromise; overload; static;

    class function Chart(const WidgetId: string; Options: TJSObject): TdxChart; assembler; overload; static;
    class function Chart(const WidgetId, dm, name: string; out dxChart: TdxChart): TJSPromise; overload; static;
    class function Chart(const WidgetId: string; DataSource: TjdxDataSource; out dxChart: TdxChart): TJSPromise; overload; static;

    class function CheckBox(const WidgetId: string; Options: TJSObject): TdxCheckBox; assembler; overload; static;
    class function CheckBox(const WidgetId, dm, name: string; out dxCheckBox: TdxCheckBox): TJSPromise; overload; static;
    class function CheckBox(const WidgetId: string; DataSource: TjdxDataSource; out dxCheckBox: TdxCheckBox): TJSPromise; overload; static;

    class function CircularGauge(const WidgetId: string; Options: TJSObject): TdxCircularGauge; assembler; overload; static;
    class function CircularGauge(const WidgetId, dm, name: string; out dxCircularGauge: TdxCircularGauge): TJSPromise; overload; static;
    class function CircularGauge(const WidgetId: string; DataSource: TjdxDataSource; out dxCircularGauge: TdxCircularGauge): TJSPromise; overload; static;

    class function ColorBox(const WidgetId: string; Options: TJSObject): TdxColorBox; assembler; overload; static;
    class function ColorBox(const WidgetId, dm, name: string; out dxColorBox: TdxColorBox): TJSPromise; overload; static;
    class function ColorBox(const WidgetId: string; DataSource: TjdxDataSource; out dxColorBox: TdxColorBox): TJSPromise; overload; static;

    class function ContextMenu(const WidgetId: string; Options: TJSObject): TdxContextMenu; assembler; overload; static;
    class function ContextMenu(const WidgetId, dm, name: string; out dxContextMenu: TdxContextMenu): TJSPromise; overload; static;
    class function ContextMenu(const WidgetId: string; DataSource: TjdxDataSource; out dxContextMenu: TdxContextMenu): TJSPromise; overload; static;

    class function DataGrid(const WidgetId: string; Options: TJSObject): TdxDataGrid; assembler; overload; static;
    class function DataGrid(const WidgetId, dm, name: string; out dxDataGrid: TdxDataGrid): TJSPromise; overload; static;
    class function DataGrid(const WidgetId: string; DataSource: TjdxDataSource; out dxDataGrid: TdxDataGrid): TJSPromise; overload; static;

    class function DateBox(const WidgetId: string; Options: TJSObject): TdxDateBox; assembler; overload; static;
    class function DateBox(const WidgetId, dm, name: string; out dxDateBox: TdxDateBox): TJSPromise; overload; static;
    class function DateBox(const WidgetId: string; DataSource: TjdxDataSource; out dxDateBox: TdxDateBox): TJSPromise; overload; static;

    class function DeferRendering(const WidgetId: string; Options: TJSObject): TdxDeferRendering; assembler; overload; static;
    class function DeferRendering(const WidgetId, dm, name: string; out dxDeferRendering: TdxDeferRendering): TJSPromise; overload; static;
    class function DeferRendering(const WidgetId: string; DataSource: TjdxDataSource; out dxDeferRendering: TdxDeferRendering): TJSPromise; overload; static;

    class function Diagram(const WidgetId: string; Options: TJSObject): TdxDiagram; assembler; overload; static;
    class function Diagram(const WidgetId, dm, name: string; out dxDiagram: TdxDiagram): TJSPromise; overload; static;
    class function Diagram(const WidgetId: string; DataSource: TjdxDataSource; out dxDiagram: TdxDiagram): TJSPromise; overload; static;

    class function Draggable(const WidgetId: string; Options: TJSObject): TdxDraggable; assembler; overload; static;
    class function Draggable(const WidgetId, dm, name: string; out dxDraggable: TdxDraggable): TJSPromise; overload; static;
    class function Draggable(const WidgetId: string; DataSource: TjdxDataSource; out dxDraggable: TdxDraggable): TJSPromise; overload; static;

    class function Drawer(const WidgetId: string; Options: TJSObject): TdxDrawer; assembler; overload; static;
    class function Drawer(const WidgetId, dm, name: string; out dxDrawer: TdxDrawer): TJSPromise; overload; static;
    class function Drawer(const WidgetId: string; DataSource: TjdxDataSource; out dxDrawer: TdxDrawer): TJSPromise; overload; static;

    class function DropDownBox(const WidgetId: string; Options: TJSObject): TdxDropDownBox; assembler; overload; static;
    class function DropDownBox(const WidgetId, dm, name: string; out dxDropDownBox: TdxDropDownBox): TJSPromise; overload; static;
    class function DropDownBox(const WidgetId: string; DataSource: TjdxDataSource; out dxDropDownBox: TdxDropDownBox): TJSPromise; overload; static;

    class function DropDownButton(const WidgetId: string; Options: TJSObject): TdxDropDownButton; assembler; overload; static;
    class function DropDownButton(const WidgetId, dm, name: string; out dxDropDownButton: TdxDropDownButton): TJSPromise; overload; static;
    class function DropDownButton(const WidgetId: string; DataSource: TjdxDataSource; out dxDropDownButton: TdxDropDownButton): TJSPromise; overload; static;

    class function DropDownEditor(const WidgetId: string; Options: TJSObject): TdxDropDownEditor; assembler; overload; static;
    class function DropDownEditor(const WidgetId, dm, name: string; out dxDropDownEditor: TdxDropDownEditor): TJSPromise; overload; static;
    class function DropDownEditor(const WidgetId: string; DataSource: TjdxDataSource; out dxDropDownEditor: TdxDropDownEditor): TJSPromise; overload; static;

    class function DropDownList(const WidgetId: string; Options: TJSObject): TdxDropDownList; assembler; overload; static;
    class function DropDownList(const WidgetId, dm, name: string; out dxDropDownList: TdxDropDownList): TJSPromise; overload; static;
    class function DropDownList(const WidgetId: string; DataSource: TjdxDataSource; out dxDropDownList: TdxDropDownList): TJSPromise; overload; static;

    class function FileManager(const WidgetId: string; Options: TJSObject): TdxFileManager; assembler; overload; static;
    class function FileManager(const WidgetId, dm, name: string; out dxFileManager: TdxFileManager): TJSPromise; overload; static;
    class function FileManager(const WidgetId: string; DataSource: TjdxDataSource; out dxFileManager: TdxFileManager): TJSPromise; overload; static;

    class function FileUploader(const WidgetId: string; Options: TJSObject): TdxFileUploader; assembler; overload; static;
    class function FileUploader(const WidgetId, dm, name: string; out dxFileUploader: TdxFileUploader): TJSPromise; overload; static;
    class function FileUploader(const WidgetId: string; DataSource: TjdxDataSource; out dxFileUploader: TdxFileUploader): TJSPromise; overload; static;

    class function FilterBuilder(const WidgetId: string; Options: TJSObject): TdxFilterBuilder; assembler; overload; static;
    class function FilterBuilder(const WidgetId, dm, name: string; out dxFilterBuilder: TdxFilterBuilder): TJSPromise; overload; static;
    class function FilterBuilder(const WidgetId: string; DataSource: TjdxDataSource; out dxFilterBuilder: TdxFilterBuilder): TJSPromise; overload; static;

    class function Form(const WidgetId: string; Options: TJSObject): TdxForm; assembler; overload; static;
    class function Form(const WidgetId, dm, name: string; out dxForm: TdxForm): TJSPromise; overload; static;
    class function Form(const WidgetId: string; DataSource: TjdxDataSource; out dxForm: TdxForm): TJSPromise; overload; static;

    class function Funnel(const WidgetId: string; Options: TJSObject): TdxFunnel; assembler; overload; static;
    class function Funnel(const WidgetId, dm, name: string; out dxFunnel: TdxFunnel): TJSPromise; overload; static;
    class function Funnel(const WidgetId: string; DataSource: TjdxDataSource; out dxFunnel: TdxFunnel): TJSPromise; overload; static;

    class function Gallery(const WidgetId: string; Options: TJSObject): TdxGallery; assembler; overload; static;
    class function Gallery(const WidgetId, dm, name: string; out dxGallery: TdxGallery): TJSPromise; overload; static;
    class function Gallery(const WidgetId: string; DataSource: TjdxDataSource; out dxGallery: TdxGallery): TJSPromise; overload; static;

    class function Gantt(const WidgetId: string; Options: TJSObject): TdxGantt; assembler; overload; static;
    class function Gantt(const WidgetId, dm, name: string; out dxGantt: TdxGantt): TJSPromise; overload; static;
    class function Gantt(const WidgetId: string; DataSource: TjdxDataSource; out dxGantt: TdxGantt): TJSPromise; overload; static;

    class function HtmlEditor(const WidgetId: string; Options: TJSObject): TdxHtmlEditor; assembler; overload; static;
    class function HtmlEditor(const WidgetId, dm, name: string; out dxHtmlEditor: TdxHtmlEditor): TJSPromise; overload; static;
    class function HtmlEditor(const WidgetId: string; DataSource: TjdxDataSource; out dxHtmlEditor: TdxHtmlEditor): TJSPromise; overload; static;

    class function LinearGauge(const WidgetId: string; Options: TJSObject): TdxLinearGauge; assembler; overload; static;
    class function LinearGauge(const WidgetId, dm, name: string; out dxLinearGauge: TdxLinearGauge): TJSPromise; overload; static;
    class function LinearGauge(const WidgetId: string; DataSource: TjdxDataSource; out dxLinearGauge: TdxLinearGauge): TJSPromise; overload; static;

    class function List(const WidgetId: string; Options: TJSObject): TdxList; assembler; overload; static;
    class function List(const WidgetId, dm, name: string; out dxList: TdxList): TJSPromise; overload; static;
    class function List(const WidgetId: string; DataSource: TjdxDataSource; out dxList: TdxList): TJSPromise; overload; static;

    class function LoadIndicator(const WidgetId: string; Options: TJSObject): TdxLoadIndicator; assembler; overload; static;
    class function LoadIndicator(const WidgetId, dm, name: string; out dxLoadIndicator: TdxLoadIndicator): TJSPromise; overload; static;
    class function LoadIndicator(const WidgetId: string; DataSource: TjdxDataSource; out dxLoadIndicator: TdxLoadIndicator): TJSPromise; overload; static;

    class function LoadPanel(const WidgetId: string; Options: TJSObject): TdxLoadPanel; assembler; overload; static;
    class function LoadPanel(const WidgetId, dm, name: string; out dxLoadPanel: TdxLoadPanel): TJSPromise; overload; static;
    class function LoadPanel(const WidgetId: string; DataSource: TjdxDataSource; out dxLoadPanel: TdxLoadPanel): TJSPromise; overload; static;

    class function Lookup(const WidgetId: string; Options: TJSObject): TdxLookup; assembler; overload; static;
    class function Lookup(const WidgetId, dm, name: string; out dxLookup: TdxLookup): TJSPromise; overload; static;
    class function Lookup(const WidgetId: string; DataSource: TjdxDataSource; out dxLookup: TdxLookup): TJSPromise; overload; static;

    class function Map(const WidgetId: string; Options: TJSObject): TdxMap; assembler; overload; static;
    class function Map(const WidgetId, dm, name: string; out dxMap: TdxMap): TJSPromise; overload; static;
    class function Map(const WidgetId: string; DataSource: TjdxDataSource; out dxMap: TdxMap): TJSPromise; overload; static;

    class function Menu(const WidgetId: string; Options: TJSObject): TdxMenu; assembler; overload; static;
    class function Menu(const WidgetId, dm, name: string; out dxMenu: TdxMenu): TJSPromise; overload; static;
    class function Menu(const WidgetId: string; DataSource: TjdxDataSource; out dxMenu: TdxMenu): TJSPromise; overload; static;

    class function MenuBase(const WidgetId: string; Options: TJSObject): TdxMenuBase; assembler; overload; static;
    class function MenuBase(const WidgetId, dm, name: string; out dxMenuBase: TdxMenuBase): TJSPromise; overload; static;
    class function MenuBase(const WidgetId: string; DataSource: TjdxDataSource; out dxMenuBase: TdxMenuBase): TJSPromise; overload; static;

    class function MultiView(const WidgetId: string; Options: TJSObject): TdxMultiView; assembler; overload; static;
    class function MultiView(const WidgetId, dm, name: string; out dxMultiView: TdxMultiView): TJSPromise; overload; static;
    class function MultiView(const WidgetId: string; DataSource: TjdxDataSource; out dxMultiView: TdxMultiView): TJSPromise; overload; static;

    class function NumberBox(const WidgetId: string; Options: TJSObject): TdxNumberBox; assembler; overload; static;
    class function NumberBox(const WidgetId, dm, name: string; out dxNumberBox: TdxNumberBox): TJSPromise; overload; static;
    class function NumberBox(const WidgetId: string; DataSource: TjdxDataSource; out dxNumberBox: TdxNumberBox): TJSPromise; overload; static;

    class function Overlay(const WidgetId: string; Options: TJSObject): TdxOverlay; assembler; overload; static;
    class function Overlay(const WidgetId, dm, name: string; out dxOverlay: TdxOverlay): TJSPromise; overload; static;
    class function Overlay(const WidgetId: string; DataSource: TjdxDataSource; out dxOverlay: TdxOverlay): TJSPromise; overload; static;

    class function PieChart(const WidgetId: string; Options: TJSObject): TdxPieChart; assembler; overload; static;
    class function PieChart(const WidgetId, dm, name: string; out dxPieChart: TdxPieChart): TJSPromise; overload; static;
    class function PieChart(const WidgetId: string; DataSource: TjdxDataSource; out dxPieChart: TdxPieChart): TJSPromise; overload; static;

    class function PivotGrid(const WidgetId: string; Options: TJSObject): TdxPivotGrid; assembler; overload; static;
    class function PivotGrid(const WidgetId, dm, name: string; out dxPivotGrid: TdxPivotGrid): TJSPromise; overload; static;
    class function PivotGrid(const WidgetId: string; DataSource: TjdxDataSource; out dxPivotGrid: TdxPivotGrid): TJSPromise; overload; static;

    class function PivotGridFieldChooser(const WidgetId: string; Options: TJSObject): TdxPivotGridFieldChooser; assembler; overload; static;
    class function PivotGridFieldChooser(const WidgetId, dm, name: string; out dxPivotGridFieldChooser: TdxPivotGridFieldChooser): TJSPromise; overload; static;
    class function PivotGridFieldChooser(const WidgetId: string; DataSource: TjdxDataSource; out dxPivotGridFieldChooser: TdxPivotGridFieldChooser): TJSPromise; overload; static;

    class function PolarChart(const WidgetId: string; Options: TJSObject): TdxPolarChart; assembler; overload; static;
    class function PolarChart(const WidgetId, dm, name: string; out dxPolarChart: TdxPolarChart): TJSPromise; overload; static;
    class function PolarChart(const WidgetId: string; DataSource: TjdxDataSource; out dxPolarChart: TdxPolarChart): TJSPromise; overload; static;

    class function Popover(const WidgetId: string; Options: TJSObject): TdxPopover; assembler; overload; static;
    class function Popover(const WidgetId, dm, name: string; out dxPopover: TdxPopover): TJSPromise; overload; static;
    class function Popover(const WidgetId: string; DataSource: TjdxDataSource; out dxPopover: TdxPopover): TJSPromise; overload; static;

    class function Popup(const WidgetId: string; Options: TJSObject): TdxPopup; assembler; overload; static;
    class function Popup(const WidgetId, dm, name: string; out dxPopup: TdxPopup): TJSPromise; overload; static;
    class function Popup(const WidgetId: string; DataSource: TjdxDataSource; out dxPopup: TdxPopup): TJSPromise; overload; static;

    class function ProgressBar(const WidgetId: string; Options: TJSObject): TdxProgressBar; assembler; overload; static;
    class function ProgressBar(const WidgetId, dm, name: string; out dxProgressBar: TdxProgressBar): TJSPromise; overload; static;
    class function ProgressBar(const WidgetId: string; DataSource: TjdxDataSource; out dxProgressBar: TdxProgressBar): TJSPromise; overload; static;

    class function RadioButton(const WidgetId: string; Options: TJSObject): TdxRadioButton; assembler; overload; static;
    class function RadioButton(const WidgetId, dm, name: string; out dxRadioButton: TdxRadioButton): TJSPromise; overload; static;
    class function RadioButton(const WidgetId: string; DataSource: TjdxDataSource; out dxRadioButton: TdxRadioButton): TJSPromise; overload; static;

    class function RadioGroup(const WidgetId: string; Options: TJSObject): TdxRadioGroup; assembler; overload; static;
    class function RadioGroup(const WidgetId, dm, name: string; out dxRadioGroup: TdxRadioGroup): TJSPromise; overload; static;
    class function RadioGroup(const WidgetId: string; DataSource: TjdxDataSource; out dxRadioGroup: TdxRadioGroup): TJSPromise; overload; static;

    class function RangeSelector(const WidgetId: string; Options: TJSObject): TdxRangeSelector; assembler; overload; static;
    class function RangeSelector(const WidgetId, dm, name: string; out dxRangeSelector: TdxRangeSelector): TJSPromise; overload; static;
    class function RangeSelector(const WidgetId: string; DataSource: TjdxDataSource; out dxRangeSelector: TdxRangeSelector): TJSPromise; overload; static;

    class function RangeSlider(const WidgetId: string; Options: TJSObject): TdxRangeSlider; assembler; overload; static;
    class function RangeSlider(const WidgetId, dm, name: string; out dxRangeSlider: TdxRangeSlider): TJSPromise; overload; static;
    class function RangeSlider(const WidgetId: string; DataSource: TjdxDataSource; out dxRangeSlider: TdxRangeSlider): TJSPromise; overload; static;

    class function Resizable(const WidgetId: string; Options: TJSObject): TdxResizable; assembler; overload; static;
    class function Resizable(const WidgetId, dm, name: string; out dxResizable: TdxResizable): TJSPromise; overload; static;
    class function Resizable(const WidgetId: string; DataSource: TjdxDataSource; out dxResizable: TdxResizable): TJSPromise; overload; static;

    class function ResponsiveBox(const WidgetId: string; Options: TJSObject): TdxResponsiveBox; assembler; overload; static;
    class function ResponsiveBox(const WidgetId, dm, name: string; out dxResponsiveBox: TdxResponsiveBox): TJSPromise; overload; static;
    class function ResponsiveBox(const WidgetId: string; DataSource: TjdxDataSource; out dxResponsiveBox: TdxResponsiveBox): TJSPromise; overload; static;

    class function Sankey(const WidgetId: string; Options: TJSObject): TdxSankey; assembler; overload; static;
    class function Sankey(const WidgetId, dm, name: string; out dxSankey: TdxSankey): TJSPromise; overload; static;
    class function Sankey(const WidgetId: string; DataSource: TjdxDataSource; out dxSankey: TdxSankey): TJSPromise; overload; static;

    class function Scheduler(const WidgetId: string; Options: TJSObject): TdxScheduler; assembler; overload; static;
    class function Scheduler(const WidgetId, dm, name: string; out dxScheduler: TdxScheduler): TJSPromise; overload; static;
    class function Scheduler(const WidgetId: string; DataSource: TjdxDataSource; out dxScheduler: TdxScheduler): TJSPromise; overload; static;

    class function Scrollable(const WidgetId: string; Options: TJSObject): TdxScrollable; assembler; overload; static;
    class function Scrollable(const WidgetId, dm, name: string; out dxScrollable: TdxScrollable): TJSPromise; overload; static;
    class function Scrollable(const WidgetId: string; DataSource: TjdxDataSource; out dxScrollable: TdxScrollable): TJSPromise; overload; static;

    class function ScrollView(const WidgetId: string; Options: TJSObject): TdxScrollView; assembler; overload; static;
    class function ScrollView(const WidgetId, dm, name: string; out dxScrollView: TdxScrollView): TJSPromise; overload; static;
    class function ScrollView(const WidgetId: string; DataSource: TjdxDataSource; out dxScrollView: TdxScrollView): TJSPromise; overload; static;

    class function SelectBox(const WidgetId: string; Options: TJSObject): TdxSelectBox; assembler; overload; static;
    class function SelectBox(const WidgetId, dm, name: string; out dxSelectBox: TdxSelectBox): TJSPromise; overload; static;
    class function SelectBox(const WidgetId: string; DataSource: TjdxDataSource; out dxSelectBox: TdxSelectBox): TJSPromise; overload; static;

    class function Slider(const WidgetId: string; Options: TJSObject): TdxSlider; assembler; overload; static;
    class function Slider(const WidgetId, dm, name: string; out dxSlider: TdxSlider): TJSPromise; overload; static;
    class function Slider(const WidgetId: string; DataSource: TjdxDataSource; out dxSlider: TdxSlider): TJSPromise; overload; static;

    class function SliderBase(const WidgetId: string; Options: TJSObject): TdxSliderBase; assembler; overload; static;
    class function SliderBase(const WidgetId, dm, name: string; out dxSliderBase: TdxSliderBase): TJSPromise; overload; static;
    class function SliderBase(const WidgetId: string; DataSource: TjdxDataSource; out dxSliderBase: TdxSliderBase): TJSPromise; overload; static;

    class function Sortable(const WidgetId: string; Options: TJSObject): TdxSortable; assembler; overload; static;
    class function Sortable(const WidgetId, dm, name: string; out dxSortable: TdxSortable): TJSPromise; overload; static;
    class function Sortable(const WidgetId: string; DataSource: TjdxDataSource; out dxSortable: TdxSortable): TJSPromise; overload; static;

    class function Sparkline(const WidgetId: string; Options: TJSObject): TdxSparkline; assembler; overload; static;
    class function Sparkline(const WidgetId, dm, name: string; out dxSparkline: TdxSparkline): TJSPromise; overload; static;
    class function Sparkline(const WidgetId: string; DataSource: TjdxDataSource; out dxSparkline: TdxSparkline): TJSPromise; overload; static;

    class function SpeedDialAction(const WidgetId: string; Options: TJSObject): TdxSpeedDialAction; assembler; overload; static;
    class function SpeedDialAction(const WidgetId, dm, name: string; out dxSpeedDialAction: TdxSpeedDialAction): TJSPromise; overload; static;
    class function SpeedDialAction(const WidgetId: string; DataSource: TjdxDataSource; out dxSpeedDialAction: TdxSpeedDialAction): TJSPromise; overload; static;

    class function Switch(const WidgetId: string; Options: TJSObject): TdxSwitch; assembler; overload; static;
    class function Switch(const WidgetId, dm, name: string; out dxSwitch: TdxSwitch): TJSPromise; overload; static;
    class function Switch(const WidgetId: string; DataSource: TjdxDataSource; out dxSwitch: TdxSwitch): TJSPromise; overload; static;

    class function TabPanel(const WidgetId: string; Options: TJSObject): TdxTabPanel; assembler; overload; static;
    class function TabPanel(const WidgetId, dm, name: string; out dxTabPanel: TdxTabPanel): TJSPromise; overload; static;
    class function TabPanel(const WidgetId: string; DataSource: TjdxDataSource; out dxTabPanel: TdxTabPanel): TJSPromise; overload; static;

    class function Tabs(const WidgetId: string; Options: TJSObject): TdxTabs; assembler; overload; static;
    class function Tabs(const WidgetId, dm, name: string; out dxTabs: TdxTabs): TJSPromise; overload; static;
    class function Tabs(const WidgetId: string; DataSource: TjdxDataSource; out dxTabs: TdxTabs): TJSPromise; overload; static;

    class function TagBox(const WidgetId: string; Options: TJSObject): TdxTagBox; assembler; overload; static;
    class function TagBox(const WidgetId, dm, name: string; out dxTagBox: TdxTagBox): TJSPromise; overload; static;
    class function TagBox(const WidgetId: string; DataSource: TjdxDataSource; out dxTagBox: TdxTagBox): TJSPromise; overload; static;

    class function TextArea(const WidgetId: string; Options: TJSObject): TdxTextArea; assembler; overload; static;
    class function TextArea(const WidgetId, dm, name: string; out dxTextArea: TdxTextArea): TJSPromise; overload; static;
    class function TextArea(const WidgetId: string; DataSource: TjdxDataSource; out dxTextArea: TdxTextArea): TJSPromise; overload; static;

    class function TextBox(const WidgetId: string; Options: TJSObject): TdxTextBox; assembler; overload; static;
    class function TextBox(const WidgetId, dm, name: string; out dxTextBox: TdxTextBox): TJSPromise; overload; static;
    class function TextBox(const WidgetId: string; DataSource: TjdxDataSource; out dxTextBox: TdxTextBox): TJSPromise; overload; static;

    class function TextEditor(const WidgetId: string; Options: TJSObject): TdxTextEditor; assembler; overload; static;
    class function TextEditor(const WidgetId, dm, name: string; out dxTextEditor: TdxTextEditor): TJSPromise; overload; static;
    class function TextEditor(const WidgetId: string; DataSource: TjdxDataSource; out dxTextEditor: TdxTextEditor): TJSPromise; overload; static;

    class function TileView(const WidgetId: string; Options: TJSObject): TdxTileView; assembler; overload; static;
    class function TileView(const WidgetId, dm, name: string; out dxTileView: TdxTileView): TJSPromise; overload; static;
    class function TileView(const WidgetId: string; DataSource: TjdxDataSource; out dxTileView: TdxTileView): TJSPromise; overload; static;

    class function Toast(const WidgetId: string; Options: TJSObject): TdxToast; assembler; overload; static;
    class function Toast(const WidgetId, dm, name: string; out dxToast: TdxToast): TJSPromise; overload; static;
    class function Toast(const WidgetId: string; DataSource: TjdxDataSource; out dxToast: TdxToast): TJSPromise; overload; static;

    class function Toolbar(const WidgetId: string; Options: TJSObject): TdxToolbar; assembler; overload; static;
    class function Toolbar(const WidgetId, dm, name: string; out dxToolbar: TdxToolbar): TJSPromise; overload; static;
    class function Toolbar(const WidgetId: string; DataSource: TjdxDataSource; out dxToolbar: TdxToolbar): TJSPromise; overload; static;

    class function Tooltip(const WidgetId: string; Options: TJSObject): TdxTooltip; assembler; overload; static;
    class function Tooltip(const WidgetId, dm, name: string; out dxTooltip: TdxTooltip): TJSPromise; overload; static;
    class function Tooltip(const WidgetId: string; DataSource: TjdxDataSource; out dxTooltip: TdxTooltip): TJSPromise; overload; static;

    class function TrackBar(const WidgetId: string; Options: TJSObject): TdxTrackBar; assembler; overload; static;
    class function TrackBar(const WidgetId, dm, name: string; out dxTrackBar: TdxTrackBar): TJSPromise; overload; static;
    class function TrackBar(const WidgetId: string; DataSource: TjdxDataSource; out dxTrackBar: TdxTrackBar): TJSPromise; overload; static;

    class function TreeList(const WidgetId: string; Options: TJSObject): TdxTreeList; assembler; overload; static;
    class function TreeList(const WidgetId, dm, name: string; out dxTreeList: TdxTreeList): TJSPromise; overload; static;
    class function TreeList(const WidgetId: string; DataSource: TjdxDataSource; out dxTreeList: TdxTreeList): TJSPromise; overload; static;

    class function TreeMap(const WidgetId: string; Options: TJSObject): TdxTreeMap; assembler; overload; static;
    class function TreeMap(const WidgetId, dm, name: string; out dxTreeMap: TdxTreeMap): TJSPromise; overload; static;
    class function TreeMap(const WidgetId: string; DataSource: TjdxDataSource; out dxTreeMap: TdxTreeMap): TJSPromise; overload; static;

    class function TreeView(const WidgetId: string; Options: TJSObject): TdxTreeView; assembler; overload; static;
    class function TreeView(const WidgetId, dm, name: string; out dxTreeView: TdxTreeView): TJSPromise; overload; static;
    class function TreeView(const WidgetId: string; DataSource: TjdxDataSource; out dxTreeView: TdxTreeView): TJSPromise; overload; static;

    class function ValidationGroup(const WidgetId: string; Options: TJSObject): TdxValidationGroup; assembler; overload; static;
    class function ValidationGroup(const WidgetId, dm, name: string; out dxValidationGroup: TdxValidationGroup): TJSPromise; overload; static;
    class function ValidationGroup(const WidgetId: string; DataSource: TjdxDataSource; out dxValidationGroup: TdxValidationGroup): TJSPromise; overload; static;

    class function ValidationSummary(const WidgetId: string; Options: TJSObject): TdxValidationSummary; assembler; overload; static;
    class function ValidationSummary(const WidgetId, dm, name: string; out dxValidationSummary: TdxValidationSummary): TJSPromise; overload; static;
    class function ValidationSummary(const WidgetId: string; DataSource: TjdxDataSource; out dxValidationSummary: TdxValidationSummary): TJSPromise; overload; static;

    class function Validator(const WidgetId: string; Options: TJSObject): TdxValidator; assembler; overload; static;
    class function Validator(const WidgetId, dm, name: string; out dxValidator: TdxValidator): TJSPromise; overload; static;
    class function Validator(const WidgetId: string; DataSource: TjdxDataSource; out dxValidator: TdxValidator): TJSPromise; overload; static;

    class function VectorMap(const WidgetId: string; Options: TJSObject): TdxVectorMap; assembler; overload; static;
    class function VectorMap(const WidgetId, dm, name: string; out dxVectorMap: TdxVectorMap): TJSPromise; overload; static;
    class function VectorMap(const WidgetId: string; DataSource: TjdxDataSource; out dxVectorMap: TdxVectorMap): TJSPromise; overload; static;
  end;

var
  dxFactory: TdxFactory;

implementation

uses
  DevExtreme.Form;

class function TdxFactory.FieldsPropName(const className: string): string;
begin
  Result := '';

  if sameText(className, 'TdxDataGrid') then
    Result := 'columns'
  else
    if sameText(className, 'TdxForm') then
      Result := 'items'
    else
      if sameText(className, 'TdxPivotGrid') then
        Result := 'columns'
      else
        if sameText(className, 'TdxTreeList') then
          Result := 'columns';
end;

class function TdxFactory.ParseFields(const className: string; Fields: TJSArray): TJSArray;
begin
  Result := Fields;

  if sameText(className, 'TdxDataGrid') then
    Result := Fields { TODO : Implementare }
  else
    if sameText(className, 'TdxForm') then
      Result := TdxForm.ParseFields(Fields)
    else
      if sameText(className, 'TdxPivotGrid') then
        Result := Fields { TODO : Implementare }
      else
        if sameText(className, 'TdxTreeList') then
          Result := Fields; { TODO : Implementare }
end;

class procedure TdxFactory.Make(const WidgetId, dm, dataset, className: string; DataSource: TjdxDataSource; defaultOptions: TJSObject; resolverProc: TdxCallBack<TJSObject>);
var
  Options: TJSObject;
  _dm, _dataset: string;
  fieldProp: string;
begin
  Options := TJSObject.Assign(TJSObject.New, defaultOptions);

  _dm := dm;
  _dataset := dataset;
  fieldProp := FieldsPropName(className);

  if assigned(DataSource) then
  begin
    _dm := DataSource.dm;
    _dataset := DataSource.dataset;
  end;

  if (_dm.isEmpty) or (_dataset.isEmpty) then
    resolverProc(Options)
  else
    Base.DownloadOptions(_dm, _dataset, className)._then(
      function(value: JSValue): JSValue
      var
        o: TJSObject;
      begin
        o := js.toObject(value);

        Options := TJSObject.Assign(Options, o);

        if assigned(DataSource) then
          Options['dataSource'] := DataSource.DataSource;

        if fieldProp.isEmpty then
          resolverProc(Options)
        else
        begin
          if Options.hasOwnProperty(fieldProp) then
            resolverProc(Options)
          else
            Base.Fields(_dm, _dataset)._then(
              function(value: JSValue): JSValue
              var
                Fields: TJSArray;
              begin
                Fields := js.toArray(value);
                Fields := ParseFields(className, Fields);
                Options[fieldProp] := Fields;
                resolverProc(Options);
              end);
        end;
      end);
end;

class function TdxFactory.Accordion(const WidgetId: string; Options: TJSObject): TdxAccordion;
asm
  return $(WidgetId).dxAccordion(Options).dxAccordion("instance");
end;

class function TdxFactory.Accordion(const WidgetId, dm, name: string; out dxAccordion: TdxAccordion): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Accordion(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxAccordion', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxAccordion := dxFactory.Accordion(WidgetId, Options);
          resolve(dxAccordion);
        end);
    end);
end;

class function TdxFactory.Accordion(const WidgetId: string; DataSource: TjdxDataSource; out dxAccordion: TdxAccordion): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Accordion(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxAccordion', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxAccordion := dxFactory.Accordion(WidgetId, Options);
          resolve(dxAccordion);
        end);
    end);
end;

class function TdxFactory.ActionSheet(const WidgetId: string; Options: TJSObject): TdxActionSheet;
asm
  return $(WidgetId).dxActionSheet(Options).dxActionSheet("instance");
end;

class function TdxFactory.ActionSheet(const WidgetId, dm, name: string; out dxActionSheet: TdxActionSheet): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ActionSheet(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxActionSheet', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxActionSheet := dxFactory.ActionSheet(WidgetId, Options);
          resolve(dxActionSheet);
        end);
    end);
end;

class function TdxFactory.ActionSheet(const WidgetId: string; DataSource: TjdxDataSource; out dxActionSheet: TdxActionSheet): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ActionSheet(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxActionSheet', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxActionSheet := dxFactory.ActionSheet(WidgetId, Options);
          resolve(dxActionSheet);
        end);
    end);
end;

class function TdxFactory.Autocomplete(const WidgetId: string; Options: TJSObject): TdxAutocomplete;
asm
  return $(WidgetId).dxAutocomplete(Options).dxAutocomplete("instance");
end;

class function TdxFactory.Autocomplete(const WidgetId, dm, name: string; out dxAutocomplete: TdxAutocomplete): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Autocomplete(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxAutocomplete', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxAutocomplete := dxFactory.Autocomplete(WidgetId, Options);
          resolve(dxAutocomplete);
        end);
    end);
end;

class function TdxFactory.Autocomplete(const WidgetId: string; DataSource: TjdxDataSource; out dxAutocomplete: TdxAutocomplete): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Autocomplete(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxAutocomplete', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxAutocomplete := dxFactory.Autocomplete(WidgetId, Options);
          resolve(dxAutocomplete);
        end);
    end);
end;

class function TdxFactory.BarGauge(const WidgetId: string; Options: TJSObject): TdxBarGauge;
asm
  return $(WidgetId).dxBarGauge(Options).dxBarGauge("instance");
end;

class function TdxFactory.BarGauge(const WidgetId, dm, name: string; out dxBarGauge: TdxBarGauge): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.BarGauge(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxBarGauge', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxBarGauge := dxFactory.BarGauge(WidgetId, Options);
          resolve(dxBarGauge);
        end);
    end);
end;

class function TdxFactory.BarGauge(const WidgetId: string; DataSource: TjdxDataSource; out dxBarGauge: TdxBarGauge): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.BarGauge(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxBarGauge', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxBarGauge := dxFactory.BarGauge(WidgetId, Options);
          resolve(dxBarGauge);
        end);
    end);
end;

class function TdxFactory.Box(const WidgetId: string; Options: TJSObject): TdxBox;
asm
  return $(WidgetId).dxBox(Options).dxBox("instance");
end;

class function TdxFactory.Box(const WidgetId, dm, name: string; out dxBox: TdxBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Box(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxBox', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxBox := dxFactory.Box(WidgetId, Options);
          resolve(dxBox);
        end);
    end);
end;

class function TdxFactory.Box(const WidgetId: string; DataSource: TjdxDataSource; out dxBox: TdxBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Box(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxBox', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxBox := dxFactory.Box(WidgetId, Options);
          resolve(dxBox);
        end);
    end);
end;

class function TdxFactory.Bullet(const WidgetId: string; Options: TJSObject): TdxBullet;
asm
  return $(WidgetId).dxBullet(Options).dxBullet("instance");
end;

class function TdxFactory.Bullet(const WidgetId, dm, name: string; out dxBullet: TdxBullet): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Bullet(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxBullet', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxBullet := dxFactory.Bullet(WidgetId, Options);
          resolve(dxBullet);
        end);
    end);
end;

class function TdxFactory.Bullet(const WidgetId: string; DataSource: TjdxDataSource; out dxBullet: TdxBullet): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Bullet(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxBullet', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxBullet := dxFactory.Bullet(WidgetId, Options);
          resolve(dxBullet);
        end);
    end);
end;

class function TdxFactory.Button(const WidgetId: string; Options: TJSObject): TdxButton;
asm
  return $(WidgetId).dxButton(Options).dxButton("instance");
end;

class function TdxFactory.Button(const WidgetId, dm, name: string; out dxButton: TdxButton): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Button(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxButton', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxButton := dxFactory.Button(WidgetId, Options);
          resolve(dxButton);
        end);
    end);
end;

class function TdxFactory.Button(const WidgetId: string; DataSource: TjdxDataSource; out dxButton: TdxButton): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Button(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxButton', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxButton := dxFactory.Button(WidgetId, Options);
          resolve(dxButton);
        end);
    end);
end;

class function TdxFactory.ButtonGroup(const WidgetId: string; Options: TJSObject): TdxButtonGroup;
asm
  return $(WidgetId).dxButtonGroup(Options).dxButtonGroup("instance");
end;

class function TdxFactory.ButtonGroup(const WidgetId, dm, name: string; out dxButtonGroup: TdxButtonGroup): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ButtonGroup(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxButtonGroup', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxButtonGroup := dxFactory.ButtonGroup(WidgetId, Options);
          resolve(dxButtonGroup);
        end);
    end);
end;

class function TdxFactory.ButtonGroup(const WidgetId: string; DataSource: TjdxDataSource; out dxButtonGroup: TdxButtonGroup): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ButtonGroup(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxButtonGroup', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxButtonGroup := dxFactory.ButtonGroup(WidgetId, Options);
          resolve(dxButtonGroup);
        end);
    end);
end;

class function TdxFactory.Calendar(const WidgetId: string; Options: TJSObject): TdxCalendar;
asm
  return $(WidgetId).dxCalendar(Options).dxCalendar("instance");
end;

class function TdxFactory.Calendar(const WidgetId, dm, name: string; out dxCalendar: TdxCalendar): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Calendar(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxCalendar', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxCalendar := dxFactory.Calendar(WidgetId, Options);
          resolve(dxCalendar);
        end);
    end);
end;

class function TdxFactory.Calendar(const WidgetId: string; DataSource: TjdxDataSource; out dxCalendar: TdxCalendar): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Calendar(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxCalendar', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxCalendar := dxFactory.Calendar(WidgetId, Options);
          resolve(dxCalendar);
        end);
    end);
end;

class function TdxFactory.Chart(const WidgetId: string; Options: TJSObject): TdxChart;
asm
  return $(WidgetId).dxChart(Options).dxChart("instance");
end;

class function TdxFactory.Chart(const WidgetId, dm, name: string; out dxChart: TdxChart): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Chart(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxChart', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxChart := dxFactory.Chart(WidgetId, Options);
          resolve(dxChart);
        end);
    end);
end;

class function TdxFactory.Chart(const WidgetId: string; DataSource: TjdxDataSource; out dxChart: TdxChart): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Chart(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxChart', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxChart := dxFactory.Chart(WidgetId, Options);
          resolve(dxChart);
        end);
    end);
end;

class function TdxFactory.CheckBox(const WidgetId: string; Options: TJSObject): TdxCheckBox;
asm
  return $(WidgetId).dxCheckBox(Options).dxCheckBox("instance");
end;

class function TdxFactory.CheckBox(const WidgetId, dm, name: string; out dxCheckBox: TdxCheckBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.CheckBox(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxCheckBox', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxCheckBox := dxFactory.CheckBox(WidgetId, Options);
          resolve(dxCheckBox);
        end);
    end);
end;

class function TdxFactory.CheckBox(const WidgetId: string; DataSource: TjdxDataSource; out dxCheckBox: TdxCheckBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.CheckBox(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxCheckBox', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxCheckBox := dxFactory.CheckBox(WidgetId, Options);
          resolve(dxCheckBox);
        end);
    end);
end;

class function TdxFactory.CircularGauge(const WidgetId: string; Options: TJSObject): TdxCircularGauge;
asm
  return $(WidgetId).dxCircularGauge(Options).dxCircularGauge("instance");
end;

class function TdxFactory.CircularGauge(const WidgetId, dm, name: string; out dxCircularGauge: TdxCircularGauge): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.CircularGauge(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxCircularGauge', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxCircularGauge := dxFactory.CircularGauge(WidgetId, Options);
          resolve(dxCircularGauge);
        end);
    end);
end;

class function TdxFactory.CircularGauge(const WidgetId: string; DataSource: TjdxDataSource; out dxCircularGauge: TdxCircularGauge): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.CircularGauge(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxCircularGauge', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxCircularGauge := dxFactory.CircularGauge(WidgetId, Options);
          resolve(dxCircularGauge);
        end);
    end);
end;

class function TdxFactory.ColorBox(const WidgetId: string; Options: TJSObject): TdxColorBox;
asm
  return $(WidgetId).dxColorBox(Options).dxColorBox("instance");
end;

class function TdxFactory.ColorBox(const WidgetId, dm, name: string; out dxColorBox: TdxColorBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ColorBox(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxColorBox', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxColorBox := dxFactory.ColorBox(WidgetId, Options);
          resolve(dxColorBox);
        end);
    end);
end;

class function TdxFactory.ColorBox(const WidgetId: string; DataSource: TjdxDataSource; out dxColorBox: TdxColorBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ColorBox(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxColorBox', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxColorBox := dxFactory.ColorBox(WidgetId, Options);
          resolve(dxColorBox);
        end);
    end);
end;

class function TdxFactory.ContextMenu(const WidgetId: string; Options: TJSObject): TdxContextMenu;
asm
  return $(WidgetId).dxContextMenu(Options).dxContextMenu("instance");
end;

class function TdxFactory.ContextMenu(const WidgetId, dm, name: string; out dxContextMenu: TdxContextMenu): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ContextMenu(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxContextMenu', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxContextMenu := dxFactory.ContextMenu(WidgetId, Options);
          resolve(dxContextMenu);
        end);
    end);
end;

class function TdxFactory.ContextMenu(const WidgetId: string; DataSource: TjdxDataSource; out dxContextMenu: TdxContextMenu): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ContextMenu(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxContextMenu', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxContextMenu := dxFactory.ContextMenu(WidgetId, Options);
          resolve(dxContextMenu);
        end);
    end);
end;

class function TdxFactory.DataGrid(const WidgetId: string; Options: TJSObject): TdxDataGrid;
asm
  return $(WidgetId).dxDataGrid(Options).dxDataGrid("instance");
end;

class function TdxFactory.DataGrid(const WidgetId, dm, name: string; out dxDataGrid: TdxDataGrid): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DataGrid(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxDataGrid', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDataGrid := dxFactory.DataGrid(WidgetId, Options);
          resolve(dxDataGrid);
        end);
    end);
end;

class function TdxFactory.DataGrid(const WidgetId: string; DataSource: TjdxDataSource; out dxDataGrid: TdxDataGrid): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DataGrid(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxDataGrid', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDataGrid := dxFactory.DataGrid(WidgetId, Options);
          resolve(dxDataGrid);
        end);
    end);
end;

class function TdxFactory.DateBox(const WidgetId: string; Options: TJSObject): TdxDateBox;
asm
  return $(WidgetId).dxDateBox(Options).dxDateBox("instance");
end;

class function TdxFactory.DateBox(const WidgetId, dm, name: string; out dxDateBox: TdxDateBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DateBox(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxDateBox', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDateBox := dxFactory.DateBox(WidgetId, Options);
          resolve(dxDateBox);
        end);
    end);
end;

class function TdxFactory.DateBox(const WidgetId: string; DataSource: TjdxDataSource; out dxDateBox: TdxDateBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DateBox(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxDateBox', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDateBox := dxFactory.DateBox(WidgetId, Options);
          resolve(dxDateBox);
        end);
    end);
end;

class function TdxFactory.DeferRendering(const WidgetId: string; Options: TJSObject): TdxDeferRendering;
asm
  return $(WidgetId).dxDeferRendering(Options).dxDeferRendering("instance");
end;

class function TdxFactory.DeferRendering(const WidgetId, dm, name: string; out dxDeferRendering: TdxDeferRendering): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DeferRendering(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxDeferRendering', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDeferRendering := dxFactory.DeferRendering(WidgetId, Options);
          resolve(dxDeferRendering);
        end);
    end);
end;

class function TdxFactory.DeferRendering(const WidgetId: string; DataSource: TjdxDataSource; out dxDeferRendering: TdxDeferRendering): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DeferRendering(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxDeferRendering', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDeferRendering := dxFactory.DeferRendering(WidgetId, Options);
          resolve(dxDeferRendering);
        end);
    end);
end;

class function TdxFactory.Diagram(const WidgetId: string; Options: TJSObject): TdxDiagram;
asm
  return $(WidgetId).dxDiagram(Options).dxDiagram("instance");
end;

class function TdxFactory.Diagram(const WidgetId, dm, name: string; out dxDiagram: TdxDiagram): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Diagram(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxDiagram', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDiagram := dxFactory.Diagram(WidgetId, Options);
          resolve(dxDiagram);
        end);
    end);
end;

class function TdxFactory.Diagram(const WidgetId: string; DataSource: TjdxDataSource; out dxDiagram: TdxDiagram): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Diagram(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxDiagram', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDiagram := dxFactory.Diagram(WidgetId, Options);
          resolve(dxDiagram);
        end);
    end);
end;

class function TdxFactory.Draggable(const WidgetId: string; Options: TJSObject): TdxDraggable;
asm
  return $(WidgetId).dxDraggable(Options).dxDraggable("instance");
end;

class function TdxFactory.Draggable(const WidgetId, dm, name: string; out dxDraggable: TdxDraggable): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Draggable(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxDraggable', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDraggable := dxFactory.Draggable(WidgetId, Options);
          resolve(dxDraggable);
        end);
    end);
end;

class function TdxFactory.Draggable(const WidgetId: string; DataSource: TjdxDataSource; out dxDraggable: TdxDraggable): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Draggable(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxDraggable', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDraggable := dxFactory.Draggable(WidgetId, Options);
          resolve(dxDraggable);
        end);
    end);
end;

class function TdxFactory.Drawer(const WidgetId: string; Options: TJSObject): TdxDrawer;
asm
  return $(WidgetId).dxDrawer(Options).dxDrawer("instance");
end;

class function TdxFactory.Drawer(const WidgetId, dm, name: string; out dxDrawer: TdxDrawer): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Drawer(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxDrawer', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDrawer := dxFactory.Drawer(WidgetId, Options);
          resolve(dxDrawer);
        end);
    end);
end;

class function TdxFactory.Drawer(const WidgetId: string; DataSource: TjdxDataSource; out dxDrawer: TdxDrawer): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Drawer(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxDrawer', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDrawer := dxFactory.Drawer(WidgetId, Options);
          resolve(dxDrawer);
        end);
    end);
end;

class function TdxFactory.DropDownBox(const WidgetId: string; Options: TJSObject): TdxDropDownBox;
asm
  return $(WidgetId).dxDropDownBox(Options).dxDropDownBox("instance");
end;

class function TdxFactory.DropDownBox(const WidgetId, dm, name: string; out dxDropDownBox: TdxDropDownBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DropDownBox(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxDropDownBox', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDropDownBox := dxFactory.DropDownBox(WidgetId, Options);
          resolve(dxDropDownBox);
        end);
    end);
end;

class function TdxFactory.DropDownBox(const WidgetId: string; DataSource: TjdxDataSource; out dxDropDownBox: TdxDropDownBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DropDownBox(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxDropDownBox', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDropDownBox := dxFactory.DropDownBox(WidgetId, Options);
          resolve(dxDropDownBox);
        end);
    end);
end;

class function TdxFactory.DropDownButton(const WidgetId: string; Options: TJSObject): TdxDropDownButton;
asm
  return $(WidgetId).dxDropDownButton(Options).dxDropDownButton("instance");
end;

class function TdxFactory.DropDownButton(const WidgetId, dm, name: string; out dxDropDownButton: TdxDropDownButton): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DropDownButton(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxDropDownButton', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDropDownButton := dxFactory.DropDownButton(WidgetId, Options);
          resolve(dxDropDownButton);
        end);
    end);
end;

class function TdxFactory.DropDownButton(const WidgetId: string; DataSource: TjdxDataSource; out dxDropDownButton: TdxDropDownButton): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DropDownButton(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxDropDownButton', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDropDownButton := dxFactory.DropDownButton(WidgetId, Options);
          resolve(dxDropDownButton);
        end);
    end);
end;

class function TdxFactory.DropDownEditor(const WidgetId: string; Options: TJSObject): TdxDropDownEditor;
asm
  return $(WidgetId).dxDropDownEditor(Options).dxDropDownEditor("instance");
end;

class function TdxFactory.DropDownEditor(const WidgetId, dm, name: string; out dxDropDownEditor: TdxDropDownEditor): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DropDownEditor(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxDropDownEditor', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDropDownEditor := dxFactory.DropDownEditor(WidgetId, Options);
          resolve(dxDropDownEditor);
        end);
    end);
end;

class function TdxFactory.DropDownEditor(const WidgetId: string; DataSource: TjdxDataSource; out dxDropDownEditor: TdxDropDownEditor): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DropDownEditor(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxDropDownEditor', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDropDownEditor := dxFactory.DropDownEditor(WidgetId, Options);
          resolve(dxDropDownEditor);
        end);
    end);
end;

class function TdxFactory.DropDownList(const WidgetId: string; Options: TJSObject): TdxDropDownList;
asm
  return $(WidgetId).dxDropDownList(Options).dxDropDownList("instance");
end;

class function TdxFactory.DropDownList(const WidgetId, dm, name: string; out dxDropDownList: TdxDropDownList): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DropDownList(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxDropDownList', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDropDownList := dxFactory.DropDownList(WidgetId, Options);
          resolve(dxDropDownList);
        end);
    end);
end;

class function TdxFactory.DropDownList(const WidgetId: string; DataSource: TjdxDataSource; out dxDropDownList: TdxDropDownList): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DropDownList(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxDropDownList', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDropDownList := dxFactory.DropDownList(WidgetId, Options);
          resolve(dxDropDownList);
        end);
    end);
end;

class function TdxFactory.FileManager(const WidgetId: string; Options: TJSObject): TdxFileManager;
asm
  return $(WidgetId).dxFileManager(Options).dxFileManager("instance");
end;

class function TdxFactory.FileManager(const WidgetId, dm, name: string; out dxFileManager: TdxFileManager): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.FileManager(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxFileManager', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxFileManager := dxFactory.FileManager(WidgetId, Options);
          resolve(dxFileManager);
        end);
    end);
end;

class function TdxFactory.FileManager(const WidgetId: string; DataSource: TjdxDataSource; out dxFileManager: TdxFileManager): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.FileManager(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxFileManager', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxFileManager := dxFactory.FileManager(WidgetId, Options);
          resolve(dxFileManager);
        end);
    end);
end;

class function TdxFactory.FileUploader(const WidgetId: string; Options: TJSObject): TdxFileUploader;
asm
  return $(WidgetId).dxFileUploader(Options).dxFileUploader("instance");
end;

class function TdxFactory.FileUploader(const WidgetId, dm, name: string; out dxFileUploader: TdxFileUploader): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.FileUploader(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxFileUploader', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxFileUploader := dxFactory.FileUploader(WidgetId, Options);
          resolve(dxFileUploader);
        end);
    end);
end;

class function TdxFactory.FileUploader(const WidgetId: string; DataSource: TjdxDataSource; out dxFileUploader: TdxFileUploader): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.FileUploader(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxFileUploader', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxFileUploader := dxFactory.FileUploader(WidgetId, Options);
          resolve(dxFileUploader);
        end);
    end);
end;

class function TdxFactory.FilterBuilder(const WidgetId: string; Options: TJSObject): TdxFilterBuilder;
asm
  return $(WidgetId).dxFilterBuilder(Options).dxFilterBuilder("instance");
end;

class function TdxFactory.FilterBuilder(const WidgetId, dm, name: string; out dxFilterBuilder: TdxFilterBuilder): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.FilterBuilder(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxFilterBuilder', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxFilterBuilder := dxFactory.FilterBuilder(WidgetId, Options);
          resolve(dxFilterBuilder);
        end);
    end);
end;

class function TdxFactory.FilterBuilder(const WidgetId: string; DataSource: TjdxDataSource; out dxFilterBuilder: TdxFilterBuilder): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.FilterBuilder(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxFilterBuilder', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxFilterBuilder := dxFactory.FilterBuilder(WidgetId, Options);
          resolve(dxFilterBuilder);
        end);
    end);
end;

class function TdxFactory.Form(const WidgetId: string; Options: TJSObject): TdxForm;
asm
  return $(WidgetId).dxForm(Options).dxForm("instance");
end;

class function TdxFactory.Form(const WidgetId, dm, name: string; out dxForm: TdxForm): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Form(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxForm', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxForm := dxFactory.Form(WidgetId, Options);
          resolve(dxForm);
        end);
    end);
end;

class function TdxFactory.Form(const WidgetId: string; DataSource: TjdxDataSource; out dxForm: TdxForm): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Form(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxForm', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxForm := dxFactory.Form(WidgetId, Options);
          resolve(dxForm);
        end);
    end);
end;

class function TdxFactory.Funnel(const WidgetId: string; Options: TJSObject): TdxFunnel;
asm
  return $(WidgetId).dxFunnel(Options).dxFunnel("instance");
end;

class function TdxFactory.Funnel(const WidgetId, dm, name: string; out dxFunnel: TdxFunnel): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Funnel(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxFunnel', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxFunnel := dxFactory.Funnel(WidgetId, Options);
          resolve(dxFunnel);
        end);
    end);
end;

class function TdxFactory.Funnel(const WidgetId: string; DataSource: TjdxDataSource; out dxFunnel: TdxFunnel): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Funnel(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxFunnel', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxFunnel := dxFactory.Funnel(WidgetId, Options);
          resolve(dxFunnel);
        end);
    end);
end;

class function TdxFactory.Gallery(const WidgetId: string; Options: TJSObject): TdxGallery;
asm
  return $(WidgetId).dxGallery(Options).dxGallery("instance");
end;

class function TdxFactory.Gallery(const WidgetId, dm, name: string; out dxGallery: TdxGallery): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Gallery(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxGallery', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxGallery := dxFactory.Gallery(WidgetId, Options);
          resolve(dxGallery);
        end);
    end);
end;

class function TdxFactory.Gallery(const WidgetId: string; DataSource: TjdxDataSource; out dxGallery: TdxGallery): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Gallery(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxGallery', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxGallery := dxFactory.Gallery(WidgetId, Options);
          resolve(dxGallery);
        end);
    end);
end;

class function TdxFactory.Gantt(const WidgetId: string; Options: TJSObject): TdxGantt;
asm
  return $(WidgetId).dxGantt(Options).dxGantt("instance");
end;

class function TdxFactory.Gantt(const WidgetId, dm, name: string; out dxGantt: TdxGantt): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Gantt(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxGantt', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxGantt := dxFactory.Gantt(WidgetId, Options);
          resolve(dxGantt);
        end);
    end);
end;

class function TdxFactory.Gantt(const WidgetId: string; DataSource: TjdxDataSource; out dxGantt: TdxGantt): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Gantt(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxGantt', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxGantt := dxFactory.Gantt(WidgetId, Options);
          resolve(dxGantt);
        end);
    end);
end;

class function TdxFactory.HtmlEditor(const WidgetId: string; Options: TJSObject): TdxHtmlEditor;
asm
  return $(WidgetId).dxHtmlEditor(Options).dxHtmlEditor("instance");
end;

class function TdxFactory.HtmlEditor(const WidgetId, dm, name: string; out dxHtmlEditor: TdxHtmlEditor): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.HtmlEditor(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxHtmlEditor', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxHtmlEditor := dxFactory.HtmlEditor(WidgetId, Options);
          resolve(dxHtmlEditor);
        end);
    end);
end;

class function TdxFactory.HtmlEditor(const WidgetId: string; DataSource: TjdxDataSource; out dxHtmlEditor: TdxHtmlEditor): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.HtmlEditor(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxHtmlEditor', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxHtmlEditor := dxFactory.HtmlEditor(WidgetId, Options);
          resolve(dxHtmlEditor);
        end);
    end);
end;

class function TdxFactory.LinearGauge(const WidgetId: string; Options: TJSObject): TdxLinearGauge;
asm
  return $(WidgetId).dxLinearGauge(Options).dxLinearGauge("instance");
end;

class function TdxFactory.LinearGauge(const WidgetId, dm, name: string; out dxLinearGauge: TdxLinearGauge): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.LinearGauge(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxLinearGauge', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxLinearGauge := dxFactory.LinearGauge(WidgetId, Options);
          resolve(dxLinearGauge);
        end);
    end);
end;

class function TdxFactory.LinearGauge(const WidgetId: string; DataSource: TjdxDataSource; out dxLinearGauge: TdxLinearGauge): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.LinearGauge(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxLinearGauge', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxLinearGauge := dxFactory.LinearGauge(WidgetId, Options);
          resolve(dxLinearGauge);
        end);
    end);
end;

class function TdxFactory.List(const WidgetId: string; Options: TJSObject): TdxList;
asm
  return $(WidgetId).dxList(Options).dxList("instance");
end;

class function TdxFactory.List(const WidgetId, dm, name: string; out dxList: TdxList): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.List(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxList', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxList := dxFactory.List(WidgetId, Options);
          resolve(dxList);
        end);
    end);
end;

class function TdxFactory.List(const WidgetId: string; DataSource: TjdxDataSource; out dxList: TdxList): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.List(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxList', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxList := dxFactory.List(WidgetId, Options);
          resolve(dxList);
        end);
    end);
end;

class function TdxFactory.LoadIndicator(const WidgetId: string; Options: TJSObject): TdxLoadIndicator;
asm
  return $(WidgetId).dxLoadIndicator(Options).dxLoadIndicator("instance");
end;

class function TdxFactory.LoadIndicator(const WidgetId, dm, name: string; out dxLoadIndicator: TdxLoadIndicator): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.LoadIndicator(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxLoadIndicator', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxLoadIndicator := dxFactory.LoadIndicator(WidgetId, Options);
          resolve(dxLoadIndicator);
        end);
    end);
end;

class function TdxFactory.LoadIndicator(const WidgetId: string; DataSource: TjdxDataSource; out dxLoadIndicator: TdxLoadIndicator): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.LoadIndicator(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxLoadIndicator', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxLoadIndicator := dxFactory.LoadIndicator(WidgetId, Options);
          resolve(dxLoadIndicator);
        end);
    end);
end;

class function TdxFactory.LoadPanel(const WidgetId: string; Options: TJSObject): TdxLoadPanel;
asm
  return $(WidgetId).dxLoadPanel(Options).dxLoadPanel("instance");
end;

class function TdxFactory.LoadPanel(const WidgetId, dm, name: string; out dxLoadPanel: TdxLoadPanel): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.LoadPanel(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxLoadPanel', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxLoadPanel := dxFactory.LoadPanel(WidgetId, Options);
          resolve(dxLoadPanel);
        end);
    end);
end;

class function TdxFactory.LoadPanel(const WidgetId: string; DataSource: TjdxDataSource; out dxLoadPanel: TdxLoadPanel): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.LoadPanel(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxLoadPanel', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxLoadPanel := dxFactory.LoadPanel(WidgetId, Options);
          resolve(dxLoadPanel);
        end);
    end);
end;

class function TdxFactory.Lookup(const WidgetId: string; Options: TJSObject): TdxLookup;
asm
  return $(WidgetId).dxLookup(Options).dxLookup("instance");
end;

class function TdxFactory.Lookup(const WidgetId, dm, name: string; out dxLookup: TdxLookup): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Lookup(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxLookup', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxLookup := dxFactory.Lookup(WidgetId, Options);
          resolve(dxLookup);
        end);
    end);
end;

class function TdxFactory.Lookup(const WidgetId: string; DataSource: TjdxDataSource; out dxLookup: TdxLookup): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Lookup(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxLookup', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxLookup := dxFactory.Lookup(WidgetId, Options);
          resolve(dxLookup);
        end);
    end);
end;

class function TdxFactory.Map(const WidgetId: string; Options: TJSObject): TdxMap;
asm
  return $(WidgetId).dxMap(Options).dxMap("instance");
end;

class function TdxFactory.Map(const WidgetId, dm, name: string; out dxMap: TdxMap): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Map(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxMap', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxMap := dxFactory.Map(WidgetId, Options);
          resolve(dxMap);
        end);
    end);
end;

class function TdxFactory.Map(const WidgetId: string; DataSource: TjdxDataSource; out dxMap: TdxMap): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Map(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxMap', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxMap := dxFactory.Map(WidgetId, Options);
          resolve(dxMap);
        end);
    end);
end;

class function TdxFactory.Menu(const WidgetId: string; Options: TJSObject): TdxMenu;
asm
  return $(WidgetId).dxMenu(Options).dxMenu("instance");
end;

class function TdxFactory.Menu(const WidgetId, dm, name: string; out dxMenu: TdxMenu): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Menu(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxMenu', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxMenu := dxFactory.Menu(WidgetId, Options);
          resolve(dxMenu);
        end);
    end);
end;

class function TdxFactory.Menu(const WidgetId: string; DataSource: TjdxDataSource; out dxMenu: TdxMenu): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Menu(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxMenu', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxMenu := dxFactory.Menu(WidgetId, Options);
          resolve(dxMenu);
        end);
    end);
end;

class function TdxFactory.MenuBase(const WidgetId: string; Options: TJSObject): TdxMenuBase;
asm
  return $(WidgetId).dxMenuBase(Options).dxMenuBase("instance");
end;

class function TdxFactory.MenuBase(const WidgetId, dm, name: string; out dxMenuBase: TdxMenuBase): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.MenuBase(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxMenuBase', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxMenuBase := dxFactory.MenuBase(WidgetId, Options);
          resolve(dxMenuBase);
        end);
    end);
end;

class function TdxFactory.MenuBase(const WidgetId: string; DataSource: TjdxDataSource; out dxMenuBase: TdxMenuBase): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.MenuBase(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxMenuBase', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxMenuBase := dxFactory.MenuBase(WidgetId, Options);
          resolve(dxMenuBase);
        end);
    end);
end;

class function TdxFactory.MultiView(const WidgetId: string; Options: TJSObject): TdxMultiView;
asm
  return $(WidgetId).dxMultiView(Options).dxMultiView("instance");
end;

class function TdxFactory.MultiView(const WidgetId, dm, name: string; out dxMultiView: TdxMultiView): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.MultiView(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxMultiView', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxMultiView := dxFactory.MultiView(WidgetId, Options);
          resolve(dxMultiView);
        end);
    end);
end;

class function TdxFactory.MultiView(const WidgetId: string; DataSource: TjdxDataSource; out dxMultiView: TdxMultiView): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.MultiView(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxMultiView', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxMultiView := dxFactory.MultiView(WidgetId, Options);
          resolve(dxMultiView);
        end);
    end);
end;

class function TdxFactory.NumberBox(const WidgetId: string; Options: TJSObject): TdxNumberBox;
asm
  return $(WidgetId).dxNumberBox(Options).dxNumberBox("instance");
end;

class function TdxFactory.NumberBox(const WidgetId, dm, name: string; out dxNumberBox: TdxNumberBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.NumberBox(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxNumberBox', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxNumberBox := dxFactory.NumberBox(WidgetId, Options);
          resolve(dxNumberBox);
        end);
    end);
end;

class function TdxFactory.NumberBox(const WidgetId: string; DataSource: TjdxDataSource; out dxNumberBox: TdxNumberBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.NumberBox(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxNumberBox', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxNumberBox := dxFactory.NumberBox(WidgetId, Options);
          resolve(dxNumberBox);
        end);
    end);
end;

class function TdxFactory.Overlay(const WidgetId: string; Options: TJSObject): TdxOverlay;
asm
  return $(WidgetId).dxOverlay(Options).dxOverlay("instance");
end;

class function TdxFactory.Overlay(const WidgetId, dm, name: string; out dxOverlay: TdxOverlay): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Overlay(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxOverlay', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxOverlay := dxFactory.Overlay(WidgetId, Options);
          resolve(dxOverlay);
        end);
    end);
end;

class function TdxFactory.Overlay(const WidgetId: string; DataSource: TjdxDataSource; out dxOverlay: TdxOverlay): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Overlay(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxOverlay', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxOverlay := dxFactory.Overlay(WidgetId, Options);
          resolve(dxOverlay);
        end);
    end);
end;

class function TdxFactory.PieChart(const WidgetId: string; Options: TJSObject): TdxPieChart;
asm
  return $(WidgetId).dxPieChart(Options).dxPieChart("instance");
end;

class function TdxFactory.PieChart(const WidgetId, dm, name: string; out dxPieChart: TdxPieChart): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.PieChart(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxPieChart', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPieChart := dxFactory.PieChart(WidgetId, Options);
          resolve(dxPieChart);
        end);
    end);
end;

class function TdxFactory.PieChart(const WidgetId: string; DataSource: TjdxDataSource; out dxPieChart: TdxPieChart): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.PieChart(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxPieChart', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPieChart := dxFactory.PieChart(WidgetId, Options);
          resolve(dxPieChart);
        end);
    end);
end;

class function TdxFactory.PivotGrid(const WidgetId: string; Options: TJSObject): TdxPivotGrid;
asm
  return $(WidgetId).dxPivotGrid(Options).dxPivotGrid("instance");
end;

class function TdxFactory.PivotGrid(const WidgetId, dm, name: string; out dxPivotGrid: TdxPivotGrid): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.PivotGrid(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxPivotGrid', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPivotGrid := dxFactory.PivotGrid(WidgetId, Options);
          resolve(dxPivotGrid);
        end);
    end);
end;

class function TdxFactory.PivotGrid(const WidgetId: string; DataSource: TjdxDataSource; out dxPivotGrid: TdxPivotGrid): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.PivotGrid(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxPivotGrid', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPivotGrid := dxFactory.PivotGrid(WidgetId, Options);
          resolve(dxPivotGrid);
        end);
    end);
end;

class function TdxFactory.PivotGridFieldChooser(const WidgetId: string; Options: TJSObject): TdxPivotGridFieldChooser;
asm
  return $(WidgetId).dxPivotGridFieldChooser(Options).dxPivotGridFieldChooser("instance");
end;

class function TdxFactory.PivotGridFieldChooser(const WidgetId, dm, name: string; out dxPivotGridFieldChooser: TdxPivotGridFieldChooser): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.PivotGridFieldChooser(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxPivotGridFieldChooser', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPivotGridFieldChooser := dxFactory.PivotGridFieldChooser(WidgetId, Options);
          resolve(dxPivotGridFieldChooser);
        end);
    end);
end;

class function TdxFactory.PivotGridFieldChooser(const WidgetId: string; DataSource: TjdxDataSource; out dxPivotGridFieldChooser: TdxPivotGridFieldChooser): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.PivotGridFieldChooser(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxPivotGridFieldChooser', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPivotGridFieldChooser := dxFactory.PivotGridFieldChooser(WidgetId, Options);
          resolve(dxPivotGridFieldChooser);
        end);
    end);
end;

class function TdxFactory.PolarChart(const WidgetId: string; Options: TJSObject): TdxPolarChart;
asm
  return $(WidgetId).dxPolarChart(Options).dxPolarChart("instance");
end;

class function TdxFactory.PolarChart(const WidgetId, dm, name: string; out dxPolarChart: TdxPolarChart): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.PolarChart(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxPolarChart', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPolarChart := dxFactory.PolarChart(WidgetId, Options);
          resolve(dxPolarChart);
        end);
    end);
end;

class function TdxFactory.PolarChart(const WidgetId: string; DataSource: TjdxDataSource; out dxPolarChart: TdxPolarChart): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.PolarChart(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxPolarChart', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPolarChart := dxFactory.PolarChart(WidgetId, Options);
          resolve(dxPolarChart);
        end);
    end);
end;

class function TdxFactory.Popover(const WidgetId: string; Options: TJSObject): TdxPopover;
asm
  return $(WidgetId).dxPopover(Options).dxPopover("instance");
end;

class function TdxFactory.Popover(const WidgetId, dm, name: string; out dxPopover: TdxPopover): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Popover(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxPopover', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPopover := dxFactory.Popover(WidgetId, Options);
          resolve(dxPopover);
        end);
    end);
end;

class function TdxFactory.Popover(const WidgetId: string; DataSource: TjdxDataSource; out dxPopover: TdxPopover): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Popover(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxPopover', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPopover := dxFactory.Popover(WidgetId, Options);
          resolve(dxPopover);
        end);
    end);
end;

class function TdxFactory.Popup(const WidgetId: string; Options: TJSObject): TdxPopup;
asm
  return $(WidgetId).dxPopup(Options).dxPopup("instance");
end;

class function TdxFactory.Popup(const WidgetId, dm, name: string; out dxPopup: TdxPopup): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Popup(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxPopup', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPopup := dxFactory.Popup(WidgetId, Options);
          resolve(dxPopup);
        end);
    end);
end;

class function TdxFactory.Popup(const WidgetId: string; DataSource: TjdxDataSource; out dxPopup: TdxPopup): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Popup(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxPopup', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxPopup := dxFactory.Popup(WidgetId, Options);
          resolve(dxPopup);
        end);
    end);
end;

class function TdxFactory.ProgressBar(const WidgetId: string; Options: TJSObject): TdxProgressBar;
asm
  return $(WidgetId).dxProgressBar(Options).dxProgressBar("instance");
end;

class function TdxFactory.ProgressBar(const WidgetId, dm, name: string; out dxProgressBar: TdxProgressBar): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ProgressBar(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxProgressBar', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxProgressBar := dxFactory.ProgressBar(WidgetId, Options);
          resolve(dxProgressBar);
        end);
    end);
end;

class function TdxFactory.ProgressBar(const WidgetId: string; DataSource: TjdxDataSource; out dxProgressBar: TdxProgressBar): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ProgressBar(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxProgressBar', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxProgressBar := dxFactory.ProgressBar(WidgetId, Options);
          resolve(dxProgressBar);
        end);
    end);
end;

class function TdxFactory.RadioButton(const WidgetId: string; Options: TJSObject): TdxRadioButton;
asm
  return $(WidgetId).dxRadioButton(Options).dxRadioButton("instance");
end;

class function TdxFactory.RadioButton(const WidgetId, dm, name: string; out dxRadioButton: TdxRadioButton): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.RadioButton(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxRadioButton', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxRadioButton := dxFactory.RadioButton(WidgetId, Options);
          resolve(dxRadioButton);
        end);
    end);
end;

class function TdxFactory.RadioButton(const WidgetId: string; DataSource: TjdxDataSource; out dxRadioButton: TdxRadioButton): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.RadioButton(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxRadioButton', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxRadioButton := dxFactory.RadioButton(WidgetId, Options);
          resolve(dxRadioButton);
        end);
    end);
end;

class function TdxFactory.RadioGroup(const WidgetId: string; Options: TJSObject): TdxRadioGroup;
asm
  return $(WidgetId).dxRadioGroup(Options).dxRadioGroup("instance");
end;

class function TdxFactory.RadioGroup(const WidgetId, dm, name: string; out dxRadioGroup: TdxRadioGroup): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.RadioGroup(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxRadioGroup', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxRadioGroup := dxFactory.RadioGroup(WidgetId, Options);
          resolve(dxRadioGroup);
        end);
    end);
end;

class function TdxFactory.RadioGroup(const WidgetId: string; DataSource: TjdxDataSource; out dxRadioGroup: TdxRadioGroup): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.RadioGroup(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxRadioGroup', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxRadioGroup := dxFactory.RadioGroup(WidgetId, Options);
          resolve(dxRadioGroup);
        end);
    end);
end;

class function TdxFactory.RangeSelector(const WidgetId: string; Options: TJSObject): TdxRangeSelector;
asm
  return $(WidgetId).dxRangeSelector(Options).dxRangeSelector("instance");
end;

class function TdxFactory.RangeSelector(const WidgetId, dm, name: string; out dxRangeSelector: TdxRangeSelector): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.RangeSelector(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxRangeSelector', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxRangeSelector := dxFactory.RangeSelector(WidgetId, Options);
          resolve(dxRangeSelector);
        end);
    end);
end;

class function TdxFactory.RangeSelector(const WidgetId: string; DataSource: TjdxDataSource; out dxRangeSelector: TdxRangeSelector): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.RangeSelector(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxRangeSelector', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxRangeSelector := dxFactory.RangeSelector(WidgetId, Options);
          resolve(dxRangeSelector);
        end);
    end);
end;

class function TdxFactory.RangeSlider(const WidgetId: string; Options: TJSObject): TdxRangeSlider;
asm
  return $(WidgetId).dxRangeSlider(Options).dxRangeSlider("instance");
end;

class function TdxFactory.RangeSlider(const WidgetId, dm, name: string; out dxRangeSlider: TdxRangeSlider): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.RangeSlider(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxRangeSlider', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxRangeSlider := dxFactory.RangeSlider(WidgetId, Options);
          resolve(dxRangeSlider);
        end);
    end);
end;

class function TdxFactory.RangeSlider(const WidgetId: string; DataSource: TjdxDataSource; out dxRangeSlider: TdxRangeSlider): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.RangeSlider(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxRangeSlider', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxRangeSlider := dxFactory.RangeSlider(WidgetId, Options);
          resolve(dxRangeSlider);
        end);
    end);
end;

class function TdxFactory.Resizable(const WidgetId: string; Options: TJSObject): TdxResizable;
asm
  return $(WidgetId).dxResizable(Options).dxResizable("instance");
end;

class function TdxFactory.Resizable(const WidgetId, dm, name: string; out dxResizable: TdxResizable): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Resizable(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxResizable', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxResizable := dxFactory.Resizable(WidgetId, Options);
          resolve(dxResizable);
        end);
    end);
end;

class function TdxFactory.Resizable(const WidgetId: string; DataSource: TjdxDataSource; out dxResizable: TdxResizable): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Resizable(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxResizable', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxResizable := dxFactory.Resizable(WidgetId, Options);
          resolve(dxResizable);
        end);
    end);
end;

class function TdxFactory.ResponsiveBox(const WidgetId: string; Options: TJSObject): TdxResponsiveBox;
asm
  return $(WidgetId).dxResponsiveBox(Options).dxResponsiveBox("instance");
end;

class function TdxFactory.ResponsiveBox(const WidgetId, dm, name: string; out dxResponsiveBox: TdxResponsiveBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ResponsiveBox(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxResponsiveBox', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxResponsiveBox := dxFactory.ResponsiveBox(WidgetId, Options);
          resolve(dxResponsiveBox);
        end);
    end);
end;

class function TdxFactory.ResponsiveBox(const WidgetId: string; DataSource: TjdxDataSource; out dxResponsiveBox: TdxResponsiveBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ResponsiveBox(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxResponsiveBox', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxResponsiveBox := dxFactory.ResponsiveBox(WidgetId, Options);
          resolve(dxResponsiveBox);
        end);
    end);
end;

class function TdxFactory.Sankey(const WidgetId: string; Options: TJSObject): TdxSankey;
asm
  return $(WidgetId).dxSankey(Options).dxSankey("instance");
end;

class function TdxFactory.Sankey(const WidgetId, dm, name: string; out dxSankey: TdxSankey): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Sankey(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxSankey', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSankey := dxFactory.Sankey(WidgetId, Options);
          resolve(dxSankey);
        end);
    end);
end;

class function TdxFactory.Sankey(const WidgetId: string; DataSource: TjdxDataSource; out dxSankey: TdxSankey): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Sankey(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxSankey', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSankey := dxFactory.Sankey(WidgetId, Options);
          resolve(dxSankey);
        end);
    end);
end;

class function TdxFactory.Scheduler(const WidgetId: string; Options: TJSObject): TdxScheduler;
asm
  return $(WidgetId).dxScheduler(Options).dxScheduler("instance");
end;

class function TdxFactory.Scheduler(const WidgetId, dm, name: string; out dxScheduler: TdxScheduler): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Scheduler(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxScheduler', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxScheduler := dxFactory.Scheduler(WidgetId, Options);
          resolve(dxScheduler);
        end);
    end);
end;

class function TdxFactory.Scheduler(const WidgetId: string; DataSource: TjdxDataSource; out dxScheduler: TdxScheduler): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Scheduler(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxScheduler', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxScheduler := dxFactory.Scheduler(WidgetId, Options);
          resolve(dxScheduler);
        end);
    end);
end;

class function TdxFactory.Scrollable(const WidgetId: string; Options: TJSObject): TdxScrollable;
asm
  return $(WidgetId).dxScrollable(Options).dxScrollable("instance");
end;

class function TdxFactory.Scrollable(const WidgetId, dm, name: string; out dxScrollable: TdxScrollable): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Scrollable(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxScrollable', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxScrollable := dxFactory.Scrollable(WidgetId, Options);
          resolve(dxScrollable);
        end);
    end);
end;

class function TdxFactory.Scrollable(const WidgetId: string; DataSource: TjdxDataSource; out dxScrollable: TdxScrollable): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Scrollable(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxScrollable', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxScrollable := dxFactory.Scrollable(WidgetId, Options);
          resolve(dxScrollable);
        end);
    end);
end;

class function TdxFactory.ScrollView(const WidgetId: string; Options: TJSObject): TdxScrollView;
asm
  return $(WidgetId).dxScrollView(Options).dxScrollView("instance");
end;

class function TdxFactory.ScrollView(const WidgetId, dm, name: string; out dxScrollView: TdxScrollView): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ScrollView(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxScrollView', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxScrollView := dxFactory.ScrollView(WidgetId, Options);
          resolve(dxScrollView);
        end);
    end);
end;

class function TdxFactory.ScrollView(const WidgetId: string; DataSource: TjdxDataSource; out dxScrollView: TdxScrollView): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ScrollView(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxScrollView', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxScrollView := dxFactory.ScrollView(WidgetId, Options);
          resolve(dxScrollView);
        end);
    end);
end;

class function TdxFactory.SelectBox(const WidgetId: string; Options: TJSObject): TdxSelectBox;
asm
  return $(WidgetId).dxSelectBox(Options).dxSelectBox("instance");
end;

class function TdxFactory.SelectBox(const WidgetId, dm, name: string; out dxSelectBox: TdxSelectBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.SelectBox(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxSelectBox', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSelectBox := dxFactory.SelectBox(WidgetId, Options);
          resolve(dxSelectBox);
        end);
    end);
end;

class function TdxFactory.SelectBox(const WidgetId: string; DataSource: TjdxDataSource; out dxSelectBox: TdxSelectBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.SelectBox(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxSelectBox', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSelectBox := dxFactory.SelectBox(WidgetId, Options);
          resolve(dxSelectBox);
        end);
    end);
end;

class function TdxFactory.Slider(const WidgetId: string; Options: TJSObject): TdxSlider;
asm
  return $(WidgetId).dxSlider(Options).dxSlider("instance");
end;

class function TdxFactory.Slider(const WidgetId, dm, name: string; out dxSlider: TdxSlider): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Slider(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxSlider', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSlider := dxFactory.Slider(WidgetId, Options);
          resolve(dxSlider);
        end);
    end);
end;

class function TdxFactory.Slider(const WidgetId: string; DataSource: TjdxDataSource; out dxSlider: TdxSlider): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Slider(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxSlider', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSlider := dxFactory.Slider(WidgetId, Options);
          resolve(dxSlider);
        end);
    end);
end;

class function TdxFactory.SliderBase(const WidgetId: string; Options: TJSObject): TdxSliderBase;
asm
  return $(WidgetId).dxSliderBase(Options).dxSliderBase("instance");
end;

class function TdxFactory.SliderBase(const WidgetId, dm, name: string; out dxSliderBase: TdxSliderBase): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.SliderBase(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxSliderBase', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSliderBase := dxFactory.SliderBase(WidgetId, Options);
          resolve(dxSliderBase);
        end);
    end);
end;

class function TdxFactory.SliderBase(const WidgetId: string; DataSource: TjdxDataSource; out dxSliderBase: TdxSliderBase): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.SliderBase(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxSliderBase', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSliderBase := dxFactory.SliderBase(WidgetId, Options);
          resolve(dxSliderBase);
        end);
    end);
end;

class function TdxFactory.Sortable(const WidgetId: string; Options: TJSObject): TdxSortable;
asm
  return $(WidgetId).dxSortable(Options).dxSortable("instance");
end;

class function TdxFactory.Sortable(const WidgetId, dm, name: string; out dxSortable: TdxSortable): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Sortable(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxSortable', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSortable := dxFactory.Sortable(WidgetId, Options);
          resolve(dxSortable);
        end);
    end);
end;

class function TdxFactory.Sortable(const WidgetId: string; DataSource: TjdxDataSource; out dxSortable: TdxSortable): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Sortable(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxSortable', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSortable := dxFactory.Sortable(WidgetId, Options);
          resolve(dxSortable);
        end);
    end);
end;

class function TdxFactory.Sparkline(const WidgetId: string; Options: TJSObject): TdxSparkline;
asm
  return $(WidgetId).dxSparkline(Options).dxSparkline("instance");
end;

class function TdxFactory.Sparkline(const WidgetId, dm, name: string; out dxSparkline: TdxSparkline): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Sparkline(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxSparkline', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSparkline := dxFactory.Sparkline(WidgetId, Options);
          resolve(dxSparkline);
        end);
    end);
end;

class function TdxFactory.Sparkline(const WidgetId: string; DataSource: TjdxDataSource; out dxSparkline: TdxSparkline): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Sparkline(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxSparkline', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSparkline := dxFactory.Sparkline(WidgetId, Options);
          resolve(dxSparkline);
        end);
    end);
end;

class function TdxFactory.SpeedDialAction(const WidgetId: string; Options: TJSObject): TdxSpeedDialAction;
asm
  return $(WidgetId).dxSpeedDialAction(Options).dxSpeedDialAction("instance");
end;

class function TdxFactory.SpeedDialAction(const WidgetId, dm, name: string; out dxSpeedDialAction: TdxSpeedDialAction): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.SpeedDialAction(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxSpeedDialAction', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSpeedDialAction := dxFactory.SpeedDialAction(WidgetId, Options);
          resolve(dxSpeedDialAction);
        end);
    end);
end;

class function TdxFactory.SpeedDialAction(const WidgetId: string; DataSource: TjdxDataSource; out dxSpeedDialAction: TdxSpeedDialAction): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.SpeedDialAction(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxSpeedDialAction', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSpeedDialAction := dxFactory.SpeedDialAction(WidgetId, Options);
          resolve(dxSpeedDialAction);
        end);
    end);
end;

class function TdxFactory.Switch(const WidgetId: string; Options: TJSObject): TdxSwitch;
asm
  return $(WidgetId).dxSwitch(Options).dxSwitch("instance");
end;

class function TdxFactory.Switch(const WidgetId, dm, name: string; out dxSwitch: TdxSwitch): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Switch(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxSwitch', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSwitch := dxFactory.Switch(WidgetId, Options);
          resolve(dxSwitch);
        end);
    end);
end;

class function TdxFactory.Switch(const WidgetId: string; DataSource: TjdxDataSource; out dxSwitch: TdxSwitch): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Switch(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxSwitch', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxSwitch := dxFactory.Switch(WidgetId, Options);
          resolve(dxSwitch);
        end);
    end);
end;

class function TdxFactory.TabPanel(const WidgetId: string; Options: TJSObject): TdxTabPanel;
asm
  return $(WidgetId).dxTabPanel(Options).dxTabPanel("instance");
end;

class function TdxFactory.TabPanel(const WidgetId, dm, name: string; out dxTabPanel: TdxTabPanel): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TabPanel(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTabPanel', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTabPanel := dxFactory.TabPanel(WidgetId, Options);
          resolve(dxTabPanel);
        end);
    end);
end;

class function TdxFactory.TabPanel(const WidgetId: string; DataSource: TjdxDataSource; out dxTabPanel: TdxTabPanel): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TabPanel(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTabPanel', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTabPanel := dxFactory.TabPanel(WidgetId, Options);
          resolve(dxTabPanel);
        end);
    end);
end;

class function TdxFactory.Tabs(const WidgetId: string; Options: TJSObject): TdxTabs;
asm
  return $(WidgetId).dxTabs(Options).dxTabs("instance");
end;

class function TdxFactory.Tabs(const WidgetId, dm, name: string; out dxTabs: TdxTabs): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Tabs(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTabs', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTabs := dxFactory.Tabs(WidgetId, Options);
          resolve(dxTabs);
        end);
    end);
end;

class function TdxFactory.Tabs(const WidgetId: string; DataSource: TjdxDataSource; out dxTabs: TdxTabs): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Tabs(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTabs', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTabs := dxFactory.Tabs(WidgetId, Options);
          resolve(dxTabs);
        end);
    end);
end;

class function TdxFactory.TagBox(const WidgetId: string; Options: TJSObject): TdxTagBox;
asm
  return $(WidgetId).dxTagBox(Options).dxTagBox("instance");
end;

class function TdxFactory.TagBox(const WidgetId, dm, name: string; out dxTagBox: TdxTagBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TagBox(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTagBox', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTagBox := dxFactory.TagBox(WidgetId, Options);
          resolve(dxTagBox);
        end);
    end);
end;

class function TdxFactory.TagBox(const WidgetId: string; DataSource: TjdxDataSource; out dxTagBox: TdxTagBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TagBox(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTagBox', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTagBox := dxFactory.TagBox(WidgetId, Options);
          resolve(dxTagBox);
        end);
    end);
end;

class function TdxFactory.TextArea(const WidgetId: string; Options: TJSObject): TdxTextArea;
asm
  return $(WidgetId).dxTextArea(Options).dxTextArea("instance");
end;

class function TdxFactory.TextArea(const WidgetId, dm, name: string; out dxTextArea: TdxTextArea): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TextArea(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTextArea', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTextArea := dxFactory.TextArea(WidgetId, Options);
          resolve(dxTextArea);
        end);
    end);
end;

class function TdxFactory.TextArea(const WidgetId: string; DataSource: TjdxDataSource; out dxTextArea: TdxTextArea): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TextArea(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTextArea', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTextArea := dxFactory.TextArea(WidgetId, Options);
          resolve(dxTextArea);
        end);
    end);
end;

class function TdxFactory.TextBox(const WidgetId: string; Options: TJSObject): TdxTextBox;
asm
  return $(WidgetId).dxTextBox(Options).dxTextBox("instance");
end;

class function TdxFactory.TextBox(const WidgetId, dm, name: string; out dxTextBox: TdxTextBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TextBox(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTextBox', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTextBox := dxFactory.TextBox(WidgetId, Options);
          resolve(dxTextBox);
        end);
    end);
end;

class function TdxFactory.TextBox(const WidgetId: string; DataSource: TjdxDataSource; out dxTextBox: TdxTextBox): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TextBox(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTextBox', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTextBox := dxFactory.TextBox(WidgetId, Options);
          resolve(dxTextBox);
        end);
    end);
end;

class function TdxFactory.TextEditor(const WidgetId: string; Options: TJSObject): TdxTextEditor;
asm
  return $(WidgetId).dxTextEditor(Options).dxTextEditor("instance");
end;

class function TdxFactory.TextEditor(const WidgetId, dm, name: string; out dxTextEditor: TdxTextEditor): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TextEditor(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTextEditor', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTextEditor := dxFactory.TextEditor(WidgetId, Options);
          resolve(dxTextEditor);
        end);
    end);
end;

class function TdxFactory.TextEditor(const WidgetId: string; DataSource: TjdxDataSource; out dxTextEditor: TdxTextEditor): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TextEditor(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTextEditor', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTextEditor := dxFactory.TextEditor(WidgetId, Options);
          resolve(dxTextEditor);
        end);
    end);
end;

class function TdxFactory.TileView(const WidgetId: string; Options: TJSObject): TdxTileView;
asm
  return $(WidgetId).dxTileView(Options).dxTileView("instance");
end;

class function TdxFactory.TileView(const WidgetId, dm, name: string; out dxTileView: TdxTileView): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TileView(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTileView', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTileView := dxFactory.TileView(WidgetId, Options);
          resolve(dxTileView);
        end);
    end);
end;

class function TdxFactory.TileView(const WidgetId: string; DataSource: TjdxDataSource; out dxTileView: TdxTileView): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TileView(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTileView', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTileView := dxFactory.TileView(WidgetId, Options);
          resolve(dxTileView);
        end);
    end);
end;

class function TdxFactory.Toast(const WidgetId: string; Options: TJSObject): TdxToast;
asm
  return $(WidgetId).dxToast(Options).dxToast("instance");
end;

class function TdxFactory.Toast(const WidgetId, dm, name: string; out dxToast: TdxToast): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Toast(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxToast', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxToast := dxFactory.Toast(WidgetId, Options);
          resolve(dxToast);
        end);
    end);
end;

class function TdxFactory.Toast(const WidgetId: string; DataSource: TjdxDataSource; out dxToast: TdxToast): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Toast(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxToast', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxToast := dxFactory.Toast(WidgetId, Options);
          resolve(dxToast);
        end);
    end);
end;

class function TdxFactory.Toolbar(const WidgetId: string; Options: TJSObject): TdxToolbar;
asm
  return $(WidgetId).dxToolbar(Options).dxToolbar("instance");
end;

class function TdxFactory.Toolbar(const WidgetId, dm, name: string; out dxToolbar: TdxToolbar): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Toolbar(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxToolbar', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxToolbar := dxFactory.Toolbar(WidgetId, Options);
          resolve(dxToolbar);
        end);
    end);
end;

class function TdxFactory.Toolbar(const WidgetId: string; DataSource: TjdxDataSource; out dxToolbar: TdxToolbar): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Toolbar(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxToolbar', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxToolbar := dxFactory.Toolbar(WidgetId, Options);
          resolve(dxToolbar);
        end);
    end);
end;

class function TdxFactory.Tooltip(const WidgetId: string; Options: TJSObject): TdxTooltip;
asm
  return $(WidgetId).dxTooltip(Options).dxTooltip("instance");
end;

class function TdxFactory.Tooltip(const WidgetId, dm, name: string; out dxTooltip: TdxTooltip): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Tooltip(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTooltip', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTooltip := dxFactory.Tooltip(WidgetId, Options);
          resolve(dxTooltip);
        end);
    end);
end;

class function TdxFactory.Tooltip(const WidgetId: string; DataSource: TjdxDataSource; out dxTooltip: TdxTooltip): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Tooltip(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTooltip', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTooltip := dxFactory.Tooltip(WidgetId, Options);
          resolve(dxTooltip);
        end);
    end);
end;

class function TdxFactory.TrackBar(const WidgetId: string; Options: TJSObject): TdxTrackBar;
asm
  return $(WidgetId).dxTrackBar(Options).dxTrackBar("instance");
end;

class function TdxFactory.TrackBar(const WidgetId, dm, name: string; out dxTrackBar: TdxTrackBar): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TrackBar(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTrackBar', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTrackBar := dxFactory.TrackBar(WidgetId, Options);
          resolve(dxTrackBar);
        end);
    end);
end;

class function TdxFactory.TrackBar(const WidgetId: string; DataSource: TjdxDataSource; out dxTrackBar: TdxTrackBar): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TrackBar(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTrackBar', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTrackBar := dxFactory.TrackBar(WidgetId, Options);
          resolve(dxTrackBar);
        end);
    end);
end;

class function TdxFactory.TreeList(const WidgetId: string; Options: TJSObject): TdxTreeList;
asm
  return $(WidgetId).dxTreeList(Options).dxTreeList("instance");
end;

class function TdxFactory.TreeList(const WidgetId, dm, name: string; out dxTreeList: TdxTreeList): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TreeList(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTreeList', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTreeList := dxFactory.TreeList(WidgetId, Options);
          resolve(dxTreeList);
        end);
    end);
end;

class function TdxFactory.TreeList(const WidgetId: string; DataSource: TjdxDataSource; out dxTreeList: TdxTreeList): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TreeList(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTreeList', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTreeList := dxFactory.TreeList(WidgetId, Options);
          resolve(dxTreeList);
        end);
    end);
end;

class function TdxFactory.TreeMap(const WidgetId: string; Options: TJSObject): TdxTreeMap;
asm
  return $(WidgetId).dxTreeMap(Options).dxTreeMap("instance");
end;

class function TdxFactory.TreeMap(const WidgetId, dm, name: string; out dxTreeMap: TdxTreeMap): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TreeMap(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTreeMap', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTreeMap := dxFactory.TreeMap(WidgetId, Options);
          resolve(dxTreeMap);
        end);
    end);
end;

class function TdxFactory.TreeMap(const WidgetId: string; DataSource: TjdxDataSource; out dxTreeMap: TdxTreeMap): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TreeMap(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTreeMap', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTreeMap := dxFactory.TreeMap(WidgetId, Options);
          resolve(dxTreeMap);
        end);
    end);
end;

class function TdxFactory.TreeView(const WidgetId: string; Options: TJSObject): TdxTreeView;
asm
  return $(WidgetId).dxTreeView(Options).dxTreeView("instance");
end;

class function TdxFactory.TreeView(const WidgetId, dm, name: string; out dxTreeView: TdxTreeView): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TreeView(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxTreeView', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTreeView := dxFactory.TreeView(WidgetId, Options);
          resolve(dxTreeView);
        end);
    end);
end;

class function TdxFactory.TreeView(const WidgetId: string; DataSource: TjdxDataSource; out dxTreeView: TdxTreeView): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.TreeView(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxTreeView', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxTreeView := dxFactory.TreeView(WidgetId, Options);
          resolve(dxTreeView);
        end);
    end);
end;

class function TdxFactory.ValidationGroup(const WidgetId: string; Options: TJSObject): TdxValidationGroup;
asm
  return $(WidgetId).dxValidationGroup(Options).dxValidationGroup("instance");
end;

class function TdxFactory.ValidationGroup(const WidgetId, dm, name: string; out dxValidationGroup: TdxValidationGroup): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ValidationGroup(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxValidationGroup', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxValidationGroup := dxFactory.ValidationGroup(WidgetId, Options);
          resolve(dxValidationGroup);
        end);
    end);
end;

class function TdxFactory.ValidationGroup(const WidgetId: string; DataSource: TjdxDataSource; out dxValidationGroup: TdxValidationGroup): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ValidationGroup(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxValidationGroup', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxValidationGroup := dxFactory.ValidationGroup(WidgetId, Options);
          resolve(dxValidationGroup);
        end);
    end);
end;

class function TdxFactory.ValidationSummary(const WidgetId: string; Options: TJSObject): TdxValidationSummary;
asm
  return $(WidgetId).dxValidationSummary(Options).dxValidationSummary("instance");
end;

class function TdxFactory.ValidationSummary(const WidgetId, dm, name: string; out dxValidationSummary: TdxValidationSummary): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ValidationSummary(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxValidationSummary', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxValidationSummary := dxFactory.ValidationSummary(WidgetId, Options);
          resolve(dxValidationSummary);
        end);
    end);
end;

class function TdxFactory.ValidationSummary(const WidgetId: string; DataSource: TjdxDataSource; out dxValidationSummary: TdxValidationSummary): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.ValidationSummary(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxValidationSummary', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxValidationSummary := dxFactory.ValidationSummary(WidgetId, Options);
          resolve(dxValidationSummary);
        end);
    end);
end;

class function TdxFactory.Validator(const WidgetId: string; Options: TJSObject): TdxValidator;
asm
  return $(WidgetId).dxValidator(Options).dxValidator("instance");
end;

class function TdxFactory.Validator(const WidgetId, dm, name: string; out dxValidator: TdxValidator): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Validator(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxValidator', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxValidator := dxFactory.Validator(WidgetId, Options);
          resolve(dxValidator);
        end);
    end);
end;

class function TdxFactory.Validator(const WidgetId: string; DataSource: TjdxDataSource; out dxValidator: TdxValidator): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.Validator(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxValidator', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxValidator := dxFactory.Validator(WidgetId, Options);
          resolve(dxValidator);
        end);
    end);
end;

class function TdxFactory.VectorMap(const WidgetId: string; Options: TJSObject): TdxVectorMap;
asm
  return $(WidgetId).dxVectorMap(Options).dxVectorMap("instance");
end;

class function TdxFactory.VectorMap(const WidgetId, dm, name: string; out dxVectorMap: TdxVectorMap): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.VectorMap(WidgetId, nil, dm, name, nil);

      Make(WidgetId, dm, name, 'TdxVectorMap', nil, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxVectorMap := dxFactory.VectorMap(WidgetId, Options);
          resolve(dxVectorMap);
        end);
    end);
end;

class function TdxFactory.VectorMap(const WidgetId: string; DataSource: TjdxDataSource; out dxVectorMap: TdxVectorMap): TJSPromise;
begin
  Result := TJSPromise.New(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.VectorMap(WidgetId, nil, '', '', DataSource);

      Make(WidgetId, '', '', 'TdxVectorMap', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxVectorMap := dxFactory.VectorMap(WidgetId, Options);
          resolve(dxVectorMap);
        end);
    end);
end;

end.
