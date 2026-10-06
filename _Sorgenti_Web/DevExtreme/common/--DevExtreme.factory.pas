unit DevExtreme.Factory;

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
    class procedure Make(const WidgetId, dm, dataset, className: string; DataSource: TjdxDataSource; defaultOptions: TJSObject; resolverProc: TdxCallBack<TJSObject>); static;
    class function FieldsPropName(const className: string): string; static;
  public
    class function Accordion(const WidgetId: string; Options: TJSObject): TdxAccordion; assembler; overload; static;
    class procedure Accordion(const WidgetId, dm, name: string; callback: TdxCallBack<TdxAccordion>); overload; static;
    class procedure Accordion(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxAccordion>); overload; static;

    class function ActionSheet(const WidgetId: string; Options: TJSObject): TdxActionSheet; assembler; overload; static;
    class procedure ActionSheet(const WidgetId, dm, name: string; callback: TdxCallBack<TdxActionSheet>); overload; static;
    class procedure ActionSheet(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxActionSheet>); overload; static;

    class function Autocomplete(const WidgetId: string; Options: TJSObject): TdxAutocomplete; assembler; overload; static;
    class procedure Autocomplete(const WidgetId, dm, name: string; callback: TdxCallBack<TdxAutocomplete>); overload; static;
    class procedure Autocomplete(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxAutocomplete>); overload; static;

    class function BarGauge(const WidgetId: string; Options: TJSObject): TdxBarGauge; assembler; overload; static;
    class procedure BarGauge(const WidgetId, dm, name: string; callback: TdxCallBack<TdxBarGauge>); overload; static;
    class procedure BarGauge(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxBarGauge>); overload; static;

    class function Box(const WidgetId: string; Options: TJSObject): TdxBox; assembler; overload; static;
    class procedure Box(const WidgetId, dm, name: string; callback: TdxCallBack<TdxBox>); overload; static;
    class procedure Box(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxBox>); overload; static;

    class function Bullet(const WidgetId: string; Options: TJSObject): TdxBullet; assembler; overload; static;
    class procedure Bullet(const WidgetId, dm, name: string; callback: TdxCallBack<TdxBullet>); overload; static;
    class procedure Bullet(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxBullet>); overload; static;

    class function Button(const WidgetId: string; Options: TJSObject): TdxButton; assembler; overload; static;
    class procedure Button(const WidgetId, dm, name: string; callback: TdxCallBack<TdxButton>); overload; static;
    class procedure Button(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxButton>); overload; static;

    class function ButtonGroup(const WidgetId: string; Options: TJSObject): TdxButtonGroup; assembler; overload; static;
    class procedure ButtonGroup(const WidgetId, dm, name: string; callback: TdxCallBack<TdxButtonGroup>); overload; static;
    class procedure ButtonGroup(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxButtonGroup>); overload; static;

    class function Calendar(const WidgetId: string; Options: TJSObject): TdxCalendar; assembler; overload; static;
    class procedure Calendar(const WidgetId, dm, name: string; callback: TdxCallBack<TdxCalendar>); overload; static;
    class procedure Calendar(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxCalendar>); overload; static;

    class function Chart(const WidgetId: string; Options: TJSObject): TdxChart; assembler; overload; static;
    class procedure Chart(const WidgetId, dm, name: string; callback: TdxCallBack<TdxChart>); overload; static;
    class procedure Chart(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxChart>); overload; static;

    class function CheckBox(const WidgetId: string; Options: TJSObject): TdxCheckBox; assembler; overload; static;
    class procedure CheckBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxCheckBox>); overload; static;
    class procedure CheckBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxCheckBox>); overload; static;

    class function CircularGauge(const WidgetId: string; Options: TJSObject): TdxCircularGauge; assembler; overload; static;
    class procedure CircularGauge(const WidgetId, dm, name: string; callback: TdxCallBack<TdxCircularGauge>); overload; static;
    class procedure CircularGauge(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxCircularGauge>); overload; static;

    class function ColorBox(const WidgetId: string; Options: TJSObject): TdxColorBox; assembler; overload; static;
    class procedure ColorBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxColorBox>); overload; static;
    class procedure ColorBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxColorBox>); overload; static;

    class function ContextMenu(const WidgetId: string; Options: TJSObject): TdxContextMenu; assembler; overload; static;
    class procedure ContextMenu(const WidgetId, dm, name: string; callback: TdxCallBack<TdxContextMenu>); overload; static;
    class procedure ContextMenu(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxContextMenu>); overload; static;

    class function DataGrid(const WidgetId: string; Options: TJSObject): TdxDataGrid; assembler; overload; static;
    class function DataGrid(const WidgetId, dm, name: string; out dxDataGrid: TdxDataGrid): TJSPromise; overload; static;
    class function DataGrid(const WidgetId: string; DataSource: TjdxDataSource; out dxDataGrid: TdxDataGrid): TJSPromise; overload; static;

    class function DateBox(const WidgetId: string; Options: TJSObject): TdxDateBox; assembler; overload; static;
    class procedure DateBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDateBox>); overload; static;
    class procedure DateBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDateBox>); overload; static;

    class function DeferRendering(const WidgetId: string; Options: TJSObject): TdxDeferRendering; assembler; overload; static;
    class procedure DeferRendering(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDeferRendering>); overload; static;
    class procedure DeferRendering(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDeferRendering>); overload; static;

    class function Diagram(const WidgetId: string; Options: TJSObject): TdxDiagram; assembler; overload; static;
    class procedure Diagram(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDiagram>); overload; static;
    class procedure Diagram(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDiagram>); overload; static;

    class function Draggable(const WidgetId: string; Options: TJSObject): TdxDraggable; assembler; overload; static;
    class procedure Draggable(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDraggable>); overload; static;
    class procedure Draggable(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDraggable>); overload; static;

    class function Drawer(const WidgetId: string; Options: TJSObject): TdxDrawer; assembler; overload; static;
    class procedure Drawer(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDrawer>); overload; static;
    class procedure Drawer(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDrawer>); overload; static;

    class function DropDownBox(const WidgetId: string; Options: TJSObject): TdxDropDownBox; assembler; overload; static;
    class procedure DropDownBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDropDownBox>); overload; static;
    class procedure DropDownBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDropDownBox>); overload; static;

    class function DropDownButton(const WidgetId: string; Options: TJSObject): TdxDropDownButton; assembler; overload; static;
    class procedure DropDownButton(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDropDownButton>); overload; static;
    class procedure DropDownButton(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDropDownButton>); overload; static;

    class function DropDownEditor(const WidgetId: string; Options: TJSObject): TdxDropDownEditor; assembler; overload; static;
    class procedure DropDownEditor(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDropDownEditor>); overload; static;
    class procedure DropDownEditor(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDropDownEditor>); overload; static;

    class function DropDownList(const WidgetId: string; Options: TJSObject): TdxDropDownList; assembler; overload; static;
    class procedure DropDownList(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDropDownList>); overload; static;
    class procedure DropDownList(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDropDownList>); overload; static;

    class function FileManager(const WidgetId: string; Options: TJSObject): TdxFileManager; assembler; overload; static;
    class procedure FileManager(const WidgetId, dm, name: string; callback: TdxCallBack<TdxFileManager>); overload; static;
    class procedure FileManager(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxFileManager>); overload; static;

    class function FileUploader(const WidgetId: string; Options: TJSObject): TdxFileUploader; assembler; overload; static;
    class procedure FileUploader(const WidgetId, dm, name: string; callback: TdxCallBack<TdxFileUploader>); overload; static;
    class procedure FileUploader(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxFileUploader>); overload; static;

    class function FilterBuilder(const WidgetId: string; Options: TJSObject): TdxFilterBuilder; assembler; overload; static;
    class procedure FilterBuilder(const WidgetId, dm, name: string; callback: TdxCallBack<TdxFilterBuilder>); overload; static;
    class procedure FilterBuilder(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxFilterBuilder>); overload; static;

    class function Form(const WidgetId: string; Options: TJSObject): TdxForm; assembler; overload; static;
    class procedure Form(const WidgetId, dm, name: string; callback: TdxCallBack<TdxForm>); overload; static;
    class procedure Form(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxForm>); overload; static;

    class function Funnel(const WidgetId: string; Options: TJSObject): TdxFunnel; assembler; overload; static;
    class procedure Funnel(const WidgetId, dm, name: string; callback: TdxCallBack<TdxFunnel>); overload; static;
    class procedure Funnel(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxFunnel>); overload; static;

    class function Gallery(const WidgetId: string; Options: TJSObject): TdxGallery; assembler; overload; static;
    class procedure Gallery(const WidgetId, dm, name: string; callback: TdxCallBack<TdxGallery>); overload; static;
    class procedure Gallery(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxGallery>); overload; static;

    class function Gantt(const WidgetId: string; Options: TJSObject): TdxGantt; assembler; overload; static;
    class procedure Gantt(const WidgetId, dm, name: string; callback: TdxCallBack<TdxGantt>); overload; static;
    class procedure Gantt(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxGantt>); overload; static;

    class function HtmlEditor(const WidgetId: string; Options: TJSObject): TdxHtmlEditor; assembler; overload; static;
    class procedure HtmlEditor(const WidgetId, dm, name: string; callback: TdxCallBack<TdxHtmlEditor>); overload; static;
    class procedure HtmlEditor(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxHtmlEditor>); overload; static;

    class function LinearGauge(const WidgetId: string; Options: TJSObject): TdxLinearGauge; assembler; overload; static;
    class procedure LinearGauge(const WidgetId, dm, name: string; callback: TdxCallBack<TdxLinearGauge>); overload; static;
    class procedure LinearGauge(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxLinearGauge>); overload; static;

    class function List(const WidgetId: string; Options: TJSObject): TdxList; assembler; overload; static;
    class procedure List(const WidgetId, dm, name: string; callback: TdxCallBack<TdxList>); overload; static;
    class procedure List(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxList>); overload; static;

    class function LoadIndicator(const WidgetId: string; Options: TJSObject): TdxLoadIndicator; assembler; overload; static;
    class procedure LoadIndicator(const WidgetId, dm, name: string; callback: TdxCallBack<TdxLoadIndicator>); overload; static;
    class procedure LoadIndicator(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxLoadIndicator>); overload; static;

    class function LoadPanel(const WidgetId: string; Options: TJSObject): TdxLoadPanel; assembler; overload; static;
    class procedure LoadPanel(const WidgetId, dm, name: string; callback: TdxCallBack<TdxLoadPanel>); overload; static;
    class procedure LoadPanel(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxLoadPanel>); overload; static;

    class function Lookup(const WidgetId: string; Options: TJSObject): TdxLookup; assembler; overload; static;
    class procedure Lookup(const WidgetId, dm, name: string; callback: TdxCallBack<TdxLookup>); overload; static;
    class procedure Lookup(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxLookup>); overload; static;

    class function Map(const WidgetId: string; Options: TJSObject): TdxMap; assembler; overload; static;
    class procedure Map(const WidgetId, dm, name: string; callback: TdxCallBack<TdxMap>); overload; static;
    class procedure Map(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxMap>); overload; static;

    class function Menu(const WidgetId: string; Options: TJSObject): TdxMenu; assembler; overload; static;
    class procedure Menu(const WidgetId, dm, name: string; callback: TdxCallBack<TdxMenu>); overload; static;
    class procedure Menu(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxMenu>); overload; static;

    class function MenuBase(const WidgetId: string; Options: TJSObject): TdxMenuBase; assembler; overload; static;
    class procedure MenuBase(const WidgetId, dm, name: string; callback: TdxCallBack<TdxMenuBase>); overload; static;
    class procedure MenuBase(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxMenuBase>); overload; static;

    class function MultiView(const WidgetId: string; Options: TJSObject): TdxMultiView; assembler; overload; static;
    class procedure MultiView(const WidgetId, dm, name: string; callback: TdxCallBack<TdxMultiView>); overload; static;
    class procedure MultiView(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxMultiView>); overload; static;

    class function NumberBox(const WidgetId: string; Options: TJSObject): TdxNumberBox; assembler; overload; static;
    class procedure NumberBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxNumberBox>); overload; static;
    class procedure NumberBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxNumberBox>); overload; static;

    class function Overlay(const WidgetId: string; Options: TJSObject): TdxOverlay; assembler; overload; static;
    class procedure Overlay(const WidgetId, dm, name: string; callback: TdxCallBack<TdxOverlay>); overload; static;
    class procedure Overlay(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxOverlay>); overload; static;

    class function PieChart(const WidgetId: string; Options: TJSObject): TdxPieChart; assembler; overload; static;
    class procedure PieChart(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPieChart>); overload; static;
    class procedure PieChart(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPieChart>); overload; static;

    class function PivotGrid(const WidgetId: string; Options: TJSObject): TdxPivotGrid; assembler; overload; static;
    class procedure PivotGrid(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPivotGrid>); overload; static;
    class procedure PivotGrid(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPivotGrid>); overload; static;

    class function PivotGridFieldChooser(const WidgetId: string; Options: TJSObject): TdxPivotGridFieldChooser; assembler; overload; static;
    class procedure PivotGridFieldChooser(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPivotGridFieldChooser>); overload; static;
    class procedure PivotGridFieldChooser(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPivotGridFieldChooser>); overload; static;

    class function PolarChart(const WidgetId: string; Options: TJSObject): TdxPolarChart; assembler; overload; static;
    class procedure PolarChart(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPolarChart>); overload; static;
    class procedure PolarChart(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPolarChart>); overload; static;

    class function Popover(const WidgetId: string; Options: TJSObject): TdxPopover; assembler; overload; static;
    class procedure Popover(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPopover>); overload; static;
    class procedure Popover(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPopover>); overload; static;

    class function Popup(const WidgetId: string; Options: TJSObject): TdxPopup; assembler; overload; static;
    class procedure Popup(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPopup>); overload; static;
    class procedure Popup(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPopup>); overload; static;

    class function ProgressBar(const WidgetId: string; Options: TJSObject): TdxProgressBar; assembler; overload; static;
    class procedure ProgressBar(const WidgetId, dm, name: string; callback: TdxCallBack<TdxProgressBar>); overload; static;
    class procedure ProgressBar(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxProgressBar>); overload; static;

    class function RadioButton(const WidgetId: string; Options: TJSObject): TdxRadioButton; assembler; overload; static;
    class procedure RadioButton(const WidgetId, dm, name: string; callback: TdxCallBack<TdxRadioButton>); overload; static;
    class procedure RadioButton(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxRadioButton>); overload; static;

    class function RadioGroup(const WidgetId: string; Options: TJSObject): TdxRadioGroup; assembler; overload; static;
    class procedure RadioGroup(const WidgetId, dm, name: string; callback: TdxCallBack<TdxRadioGroup>); overload; static;
    class procedure RadioGroup(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxRadioGroup>); overload; static;

    class function RangeSelector(const WidgetId: string; Options: TJSObject): TdxRangeSelector; assembler; overload; static;
    class procedure RangeSelector(const WidgetId, dm, name: string; callback: TdxCallBack<TdxRangeSelector>); overload; static;
    class procedure RangeSelector(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxRangeSelector>); overload; static;

    class function RangeSlider(const WidgetId: string; Options: TJSObject): TdxRangeSlider; assembler; overload; static;
    class procedure RangeSlider(const WidgetId, dm, name: string; callback: TdxCallBack<TdxRangeSlider>); overload; static;
    class procedure RangeSlider(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxRangeSlider>); overload; static;

    class function Resizable(const WidgetId: string; Options: TJSObject): TdxResizable; assembler; overload; static;
    class procedure Resizable(const WidgetId, dm, name: string; callback: TdxCallBack<TdxResizable>); overload; static;
    class procedure Resizable(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxResizable>); overload; static;

    class function ResponsiveBox(const WidgetId: string; Options: TJSObject): TdxResponsiveBox; assembler; overload; static;
    class procedure ResponsiveBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxResponsiveBox>); overload; static;
    class procedure ResponsiveBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxResponsiveBox>); overload; static;

    class function Sankey(const WidgetId: string; Options: TJSObject): TdxSankey; assembler; overload; static;
    class procedure Sankey(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSankey>); overload; static;
    class procedure Sankey(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSankey>); overload; static;

    class function Scheduler(const WidgetId: string; Options: TJSObject): TdxScheduler; assembler; overload; static;
    class procedure Scheduler(const WidgetId, dm, name: string; callback: TdxCallBack<TdxScheduler>); overload; static;
    class procedure Scheduler(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxScheduler>); overload; static;

    class function Scrollable(const WidgetId: string; Options: TJSObject): TdxScrollable; assembler; overload; static;
    class procedure Scrollable(const WidgetId, dm, name: string; callback: TdxCallBack<TdxScrollable>); overload; static;
    class procedure Scrollable(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxScrollable>); overload; static;

    class function ScrollView(const WidgetId: string; Options: TJSObject): TdxScrollView; assembler; overload; static;
    class procedure ScrollView(const WidgetId, dm, name: string; callback: TdxCallBack<TdxScrollView>); overload; static;
    class procedure ScrollView(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxScrollView>); overload; static;

    class function SelectBox(const WidgetId: string; Options: TJSObject): TdxSelectBox; assembler; overload; static;
    class procedure SelectBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSelectBox>); overload; static;
    class procedure SelectBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSelectBox>); overload; static;

    class function Slider(const WidgetId: string; Options: TJSObject): TdxSlider; assembler; overload; static;
    class procedure Slider(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSlider>); overload; static;
    class procedure Slider(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSlider>); overload; static;

    class function SliderBase(const WidgetId: string; Options: TJSObject): TdxSliderBase; assembler; overload; static;
    class procedure SliderBase(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSliderBase>); overload; static;
    class procedure SliderBase(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSliderBase>); overload; static;

    class function Sortable(const WidgetId: string; Options: TJSObject): TdxSortable; assembler; overload; static;
    class procedure Sortable(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSortable>); overload; static;
    class procedure Sortable(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSortable>); overload; static;

    class function Sparkline(const WidgetId: string; Options: TJSObject): TdxSparkline; assembler; overload; static;
    class procedure Sparkline(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSparkline>); overload; static;
    class procedure Sparkline(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSparkline>); overload; static;

    class function SpeedDialAction(const WidgetId: string; Options: TJSObject): TdxSpeedDialAction; assembler; overload; static;
    class procedure SpeedDialAction(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSpeedDialAction>); overload; static;
    class procedure SpeedDialAction(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSpeedDialAction>); overload; static;

    class function Switch(const WidgetId: string; Options: TJSObject): TdxSwitch; assembler; overload; static;
    class procedure Switch(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSwitch>); overload; static;
    class procedure Switch(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSwitch>); overload; static;

    class function TabPanel(const WidgetId: string; Options: TJSObject): TdxTabPanel; assembler; overload; static;
    class procedure TabPanel(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTabPanel>); overload; static;
    class procedure TabPanel(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTabPanel>); overload; static;

    class function Tabs(const WidgetId: string; Options: TJSObject): TdxTabs; assembler; overload; static;
    class procedure Tabs(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTabs>); overload; static;
    class procedure Tabs(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTabs>); overload; static;

    class function TagBox(const WidgetId: string; Options: TJSObject): TdxTagBox; assembler; overload; static;
    class procedure TagBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTagBox>); overload; static;
    class procedure TagBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTagBox>); overload; static;

    class function TextArea(const WidgetId: string; Options: TJSObject): TdxTextArea; assembler; overload; static;
    class procedure TextArea(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTextArea>); overload; static;
    class procedure TextArea(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTextArea>); overload; static;

    class function TextBox(const WidgetId: string; Options: TJSObject): TdxTextBox; assembler; overload; static;
    class procedure TextBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTextBox>); overload; static;
    class procedure TextBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTextBox>); overload; static;

    class function TextEditor(const WidgetId: string; Options: TJSObject): TdxTextEditor; assembler; overload; static;
    class procedure TextEditor(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTextEditor>); overload; static;
    class procedure TextEditor(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTextEditor>); overload; static;

    class function TileView(const WidgetId: string; Options: TJSObject): TdxTileView; assembler; overload; static;
    class procedure TileView(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTileView>); overload; static;
    class procedure TileView(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTileView>); overload; static;

    class function Toast(const WidgetId: string; Options: TJSObject): TdxToast; assembler; overload; static;
    class procedure Toast(const WidgetId, dm, name: string; callback: TdxCallBack<TdxToast>); overload; static;
    class procedure Toast(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxToast>); overload; static;

    class function Toolbar(const WidgetId: string; Options: TJSObject): TdxToolbar; assembler; overload; static;
    class procedure Toolbar(const WidgetId, dm, name: string; callback: TdxCallBack<TdxToolbar>); overload; static;
    class procedure Toolbar(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxToolbar>); overload; static;

    class function Tooltip(const WidgetId: string; Options: TJSObject): TdxTooltip; assembler; overload; static;
    class procedure Tooltip(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTooltip>); overload; static;
    class procedure Tooltip(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTooltip>); overload; static;

    class function TrackBar(const WidgetId: string; Options: TJSObject): TdxTrackBar; assembler; overload; static;
    class procedure TrackBar(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTrackBar>); overload; static;
    class procedure TrackBar(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTrackBar>); overload; static;

    class function TreeList(const WidgetId: string; Options: TJSObject): TdxTreeList; assembler; overload; static;
    class procedure TreeList(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTreeList>); overload; static;
    class procedure TreeList(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTreeList>); overload; static;

    class function TreeMap(const WidgetId: string; Options: TJSObject): TdxTreeMap; assembler; overload; static;
    class procedure TreeMap(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTreeMap>); overload; static;
    class procedure TreeMap(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTreeMap>); overload; static;

    class function TreeView(const WidgetId: string; Options: TJSObject): TdxTreeView; assembler; overload; static;
    class procedure TreeView(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTreeView>); overload; static;
    class procedure TreeView(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTreeView>); overload; static;

    class function ValidationGroup(const WidgetId: string; Options: TJSObject): TdxValidationGroup; assembler; overload; static;
    class procedure ValidationGroup(const WidgetId, dm, name: string; callback: TdxCallBack<TdxValidationGroup>); overload; static;
    class procedure ValidationGroup(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxValidationGroup>); overload; static;

    class function ValidationSummary(const WidgetId: string; Options: TJSObject): TdxValidationSummary; assembler; overload; static;
    class procedure ValidationSummary(const WidgetId, dm, name: string; callback: TdxCallBack<TdxValidationSummary>); overload; static;
    class procedure ValidationSummary(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxValidationSummary>); overload; static;

    class function Validator(const WidgetId: string; Options: TJSObject): TdxValidator; assembler; overload; static;
    class procedure Validator(const WidgetId, dm, name: string; callback: TdxCallBack<TdxValidator>); overload; static;
    class procedure Validator(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxValidator>); overload; static;

    class function VectorMap(const WidgetId: string; Options: TJSObject): TdxVectorMap; assembler; overload; static;
    class procedure VectorMap(const WidgetId, dm, name: string; callback: TdxCallBack<TdxVectorMap>); overload; static;
    class procedure VectorMap(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxVectorMap>); overload; static;
  end;

var
  dxFactory: TdxFactory;

implementation

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

class procedure TdxFactory.Make(const WidgetId, dm, dataset, className: string; DataSource: TjdxDataSource; defaultOptions: TJSObject; resolverProc: TdxCallBack<TJSObject>);
var
  Options: TJSObject;
  _dm, _dataset: string;
  fieldProp: string;
begin
  Options := new([]);
  TJSObject.Assign(Options, defaultOptions);

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
      begin

        TJSResponse(value).json()._then(
          function(value: JSValue): JSValue
          var
            o: TJSObject;
          begin
            o := Base.ExtractOptionsFromResponse(value);

            TJSObject.Assign(Options, o);

            if assigned(DataSource) then
              Options['dataSource'] := DataSource.DataSource;

            if fieldProp.isEmpty then
              resolverProc(Options)
            else
            begin
              if Options.hasOwnProperty(fieldProp) then // <================
                resolverProc(Options)
              else
                Base.fields(_dm, _dataset)._then(
                  function(value: JSValue): JSValue
                  var
                    fields: TJSArray;
                  begin
                    fields := js.toArray(value);
                    Options[fieldProp] := fields; // <================
                    resolverProc(Options);
                  end);
            end;
          end);
      end);
end;

class function TdxFactory.Accordion(const WidgetId: string; Options: TJSObject): TdxAccordion;
asm
  return $(WidgetId).dxAccordion(Options).dxAccordion("instance");
end;

class procedure TdxFactory.Accordion(const WidgetId, dm, name: string; callback: TdxCallBack<TdxAccordion>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxAccordion;
  begin
    widget := TdxFactory.Accordion(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxAccordion',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Accordion(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Accordion(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxAccordion>);
begin

  if assigned(DataSource) then
    TdxFactory.Accordion(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Accordion(WidgetId, '', '', callback);
end;

class function TdxFactory.ActionSheet(const WidgetId: string; Options: TJSObject): TdxActionSheet;
asm
  return $(WidgetId).dxActionSheet(Options).dxActionSheet("instance");
end;

class procedure TdxFactory.ActionSheet(const WidgetId, dm, name: string; callback: TdxCallBack<TdxActionSheet>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxActionSheet;
  begin
    widget := TdxFactory.ActionSheet(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxActionSheet',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.ActionSheet(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.ActionSheet(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxActionSheet>);
begin

  if assigned(DataSource) then
    TdxFactory.ActionSheet(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.ActionSheet(WidgetId, '', '', callback);
end;

class function TdxFactory.Autocomplete(const WidgetId: string; Options: TJSObject): TdxAutocomplete;
asm
  return $(WidgetId).dxAutocomplete(Options).dxAutocomplete("instance");
end;

class procedure TdxFactory.Autocomplete(const WidgetId, dm, name: string; callback: TdxCallBack<TdxAutocomplete>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxAutocomplete;
  begin
    widget := TdxFactory.Autocomplete(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxAutocomplete',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Autocomplete(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Autocomplete(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxAutocomplete>);
begin

  if assigned(DataSource) then
    TdxFactory.Autocomplete(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Autocomplete(WidgetId, '', '', callback);
end;

class function TdxFactory.BarGauge(const WidgetId: string; Options: TJSObject): TdxBarGauge;
asm
  return $(WidgetId).dxBarGauge(Options).dxBarGauge("instance");
end;

class procedure TdxFactory.BarGauge(const WidgetId, dm, name: string; callback: TdxCallBack<TdxBarGauge>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxBarGauge;
  begin
    widget := TdxFactory.BarGauge(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxBarGauge',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.BarGauge(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.BarGauge(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxBarGauge>);
begin

  if assigned(DataSource) then
    TdxFactory.BarGauge(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.BarGauge(WidgetId, '', '', callback);
end;

class function TdxFactory.Box(const WidgetId: string; Options: TJSObject): TdxBox;
asm
  return $(WidgetId).dxBox(Options).dxBox("instance");
end;

class procedure TdxFactory.Box(const WidgetId, dm, name: string; callback: TdxCallBack<TdxBox>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxBox;
  begin
    widget := TdxFactory.Box(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxBox',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Box(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Box(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxBox>);
begin

  if assigned(DataSource) then
    TdxFactory.Box(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Box(WidgetId, '', '', callback);
end;

class function TdxFactory.Bullet(const WidgetId: string; Options: TJSObject): TdxBullet;
asm
  return $(WidgetId).dxBullet(Options).dxBullet("instance");
end;

class procedure TdxFactory.Bullet(const WidgetId, dm, name: string; callback: TdxCallBack<TdxBullet>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxBullet;
  begin
    widget := TdxFactory.Bullet(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxBullet',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Bullet(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Bullet(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxBullet>);
begin

  if assigned(DataSource) then
    TdxFactory.Bullet(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Bullet(WidgetId, '', '', callback);
end;

class function TdxFactory.Button(const WidgetId: string; Options: TJSObject): TdxButton;
asm
  return $(WidgetId).dxButton(Options).dxButton("instance");
end;

class procedure TdxFactory.Button(const WidgetId, dm, name: string; callback: TdxCallBack<TdxButton>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxButton;
  begin
    widget := TdxFactory.Button(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxButton',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Button(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Button(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxButton>);
begin

  if assigned(DataSource) then
    TdxFactory.Button(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Button(WidgetId, '', '', callback);
end;

class function TdxFactory.ButtonGroup(const WidgetId: string; Options: TJSObject): TdxButtonGroup;
asm
  return $(WidgetId).dxButtonGroup(Options).dxButtonGroup("instance");
end;

class procedure TdxFactory.ButtonGroup(const WidgetId, dm, name: string; callback: TdxCallBack<TdxButtonGroup>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxButtonGroup;
  begin
    widget := TdxFactory.ButtonGroup(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxButtonGroup',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.ButtonGroup(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.ButtonGroup(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxButtonGroup>);
begin

  if assigned(DataSource) then
    TdxFactory.ButtonGroup(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.ButtonGroup(WidgetId, '', '', callback);
end;

class function TdxFactory.Calendar(const WidgetId: string; Options: TJSObject): TdxCalendar;
asm
  return $(WidgetId).dxCalendar(Options).dxCalendar("instance");
end;

class procedure TdxFactory.Calendar(const WidgetId, dm, name: string; callback: TdxCallBack<TdxCalendar>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxCalendar;
  begin
    widget := TdxFactory.Calendar(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxCalendar',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Calendar(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Calendar(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxCalendar>);
begin

  if assigned(DataSource) then
    TdxFactory.Calendar(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Calendar(WidgetId, '', '', callback);
end;

class function TdxFactory.Chart(const WidgetId: string; Options: TJSObject): TdxChart;
asm
  return $(WidgetId).dxChart(Options).dxChart("instance");
end;

class procedure TdxFactory.Chart(const WidgetId, dm, name: string; callback: TdxCallBack<TdxChart>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxChart;
  begin
    widget := TdxFactory.Chart(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxChart',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Chart(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Chart(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxChart>);
begin

  if assigned(DataSource) then
    TdxFactory.Chart(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Chart(WidgetId, '', '', callback);
end;

class function TdxFactory.CheckBox(const WidgetId: string; Options: TJSObject): TdxCheckBox;
asm
  return $(WidgetId).dxCheckBox(Options).dxCheckBox("instance");
end;

class procedure TdxFactory.CheckBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxCheckBox>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxCheckBox;
  begin
    widget := TdxFactory.CheckBox(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxCheckBox',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.CheckBox(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.CheckBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxCheckBox>);
begin

  if assigned(DataSource) then
    TdxFactory.CheckBox(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.CheckBox(WidgetId, '', '', callback);
end;

class function TdxFactory.CircularGauge(const WidgetId: string; Options: TJSObject): TdxCircularGauge;
asm
  return $(WidgetId).dxCircularGauge(Options).dxCircularGauge("instance");
end;

class procedure TdxFactory.CircularGauge(const WidgetId, dm, name: string; callback: TdxCallBack<TdxCircularGauge>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxCircularGauge;
  begin
    widget := TdxFactory.CircularGauge(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxCircularGauge',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.CircularGauge(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.CircularGauge(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxCircularGauge>);
begin

  if assigned(DataSource) then
    TdxFactory.CircularGauge(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.CircularGauge(WidgetId, '', '', callback);
end;

class function TdxFactory.ColorBox(const WidgetId: string; Options: TJSObject): TdxColorBox;
asm
  return $(WidgetId).dxColorBox(Options).dxColorBox("instance");
end;

class procedure TdxFactory.ColorBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxColorBox>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxColorBox;
  begin
    widget := TdxFactory.ColorBox(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxColorBox',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.ColorBox(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.ColorBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxColorBox>);
begin

  if assigned(DataSource) then
    TdxFactory.ColorBox(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.ColorBox(WidgetId, '', '', callback);
end;

class function TdxFactory.ContextMenu(const WidgetId: string; Options: TJSObject): TdxContextMenu;
asm
  return $(WidgetId).dxContextMenu(Options).dxContextMenu("instance");
end;

class procedure TdxFactory.ContextMenu(const WidgetId, dm, name: string; callback: TdxCallBack<TdxContextMenu>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxContextMenu;
  begin
    widget := TdxFactory.ContextMenu(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxContextMenu',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.ContextMenu(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.ContextMenu(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxContextMenu>);
begin

  if assigned(DataSource) then
    TdxFactory.ContextMenu(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.ContextMenu(WidgetId, '', '', callback);
end;

class function TdxFactory.DateBox(const WidgetId: string; Options: TJSObject): TdxDateBox;
asm
  return $(WidgetId).dxDateBox(Options).dxDateBox("instance");
end;

class procedure TdxFactory.DateBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDateBox>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxDateBox;
  begin
    widget := TdxFactory.DateBox(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxDateBox',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.DateBox(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.DateBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDateBox>);
begin

  if assigned(DataSource) then
    TdxFactory.DateBox(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.DateBox(WidgetId, '', '', callback);
end;

class function TdxFactory.DeferRendering(const WidgetId: string; Options: TJSObject): TdxDeferRendering;
asm
  return $(WidgetId).dxDeferRendering(Options).dxDeferRendering("instance");
end;

class procedure TdxFactory.DeferRendering(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDeferRendering>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxDeferRendering;
  begin
    widget := TdxFactory.DeferRendering(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxDeferRendering',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.DeferRendering(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.DeferRendering(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDeferRendering>);
begin

  if assigned(DataSource) then
    TdxFactory.DeferRendering(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.DeferRendering(WidgetId, '', '', callback);
end;

class function TdxFactory.Diagram(const WidgetId: string; Options: TJSObject): TdxDiagram;
asm
  return $(WidgetId).dxDiagram(Options).dxDiagram("instance");
end;

class procedure TdxFactory.Diagram(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDiagram>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxDiagram;
  begin
    widget := TdxFactory.Diagram(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxDiagram',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Diagram(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Diagram(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDiagram>);
begin

  if assigned(DataSource) then
    TdxFactory.Diagram(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Diagram(WidgetId, '', '', callback);
end;

class function TdxFactory.Draggable(const WidgetId: string; Options: TJSObject): TdxDraggable;
asm
  return $(WidgetId).dxDraggable(Options).dxDraggable("instance");
end;

class procedure TdxFactory.Draggable(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDraggable>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxDraggable;
  begin
    widget := TdxFactory.Draggable(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxDraggable',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Draggable(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Draggable(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDraggable>);
begin

  if assigned(DataSource) then
    TdxFactory.Draggable(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Draggable(WidgetId, '', '', callback);
end;

class function TdxFactory.Drawer(const WidgetId: string; Options: TJSObject): TdxDrawer;
asm
  return $(WidgetId).dxDrawer(Options).dxDrawer("instance");
end;

class procedure TdxFactory.Drawer(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDrawer>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxDrawer;
  begin
    widget := TdxFactory.Drawer(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxDrawer',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Drawer(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Drawer(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDrawer>);
begin

  if assigned(DataSource) then
    TdxFactory.Drawer(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Drawer(WidgetId, '', '', callback);
end;

class function TdxFactory.DropDownBox(const WidgetId: string; Options: TJSObject): TdxDropDownBox;
asm
  return $(WidgetId).dxDropDownBox(Options).dxDropDownBox("instance");
end;

class procedure TdxFactory.DropDownBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDropDownBox>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxDropDownBox;
  begin
    widget := TdxFactory.DropDownBox(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxDropDownBox',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.DropDownBox(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.DropDownBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDropDownBox>);
begin

  if assigned(DataSource) then
    TdxFactory.DropDownBox(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.DropDownBox(WidgetId, '', '', callback);
end;

class function TdxFactory.DropDownButton(const WidgetId: string; Options: TJSObject): TdxDropDownButton;
asm
  return $(WidgetId).dxDropDownButton(Options).dxDropDownButton("instance");
end;

class procedure TdxFactory.DropDownButton(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDropDownButton>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxDropDownButton;
  begin
    widget := TdxFactory.DropDownButton(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxDropDownButton',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.DropDownButton(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.DropDownButton(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDropDownButton>);
begin

  if assigned(DataSource) then
    TdxFactory.DropDownButton(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.DropDownButton(WidgetId, '', '', callback);
end;

class function TdxFactory.DropDownEditor(const WidgetId: string; Options: TJSObject): TdxDropDownEditor;
asm
  return $(WidgetId).dxDropDownEditor(Options).dxDropDownEditor("instance");
end;

class procedure TdxFactory.DropDownEditor(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDropDownEditor>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxDropDownEditor;
  begin
    widget := TdxFactory.DropDownEditor(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxDropDownEditor',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.DropDownEditor(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.DropDownEditor(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDropDownEditor>);
begin

  if assigned(DataSource) then
    TdxFactory.DropDownEditor(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.DropDownEditor(WidgetId, '', '', callback);
end;

class function TdxFactory.DropDownList(const WidgetId: string; Options: TJSObject): TdxDropDownList;
asm
  return $(WidgetId).dxDropDownList(Options).dxDropDownList("instance");
end;

class procedure TdxFactory.DropDownList(const WidgetId, dm, name: string; callback: TdxCallBack<TdxDropDownList>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxDropDownList;
  begin
    widget := TdxFactory.DropDownList(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxDropDownList',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.DropDownList(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.DropDownList(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxDropDownList>);
begin

  if assigned(DataSource) then
    TdxFactory.DropDownList(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.DropDownList(WidgetId, '', '', callback);
end;

class function TdxFactory.FileManager(const WidgetId: string; Options: TJSObject): TdxFileManager;
asm
  return $(WidgetId).dxFileManager(Options).dxFileManager("instance");
end;

class procedure TdxFactory.FileManager(const WidgetId, dm, name: string; callback: TdxCallBack<TdxFileManager>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxFileManager;
  begin
    widget := TdxFactory.FileManager(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxFileManager',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.FileManager(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.FileManager(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxFileManager>);
begin

  if assigned(DataSource) then
    TdxFactory.FileManager(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.FileManager(WidgetId, '', '', callback);
end;

class function TdxFactory.FileUploader(const WidgetId: string; Options: TJSObject): TdxFileUploader;
asm
  return $(WidgetId).dxFileUploader(Options).dxFileUploader("instance");
end;

class procedure TdxFactory.FileUploader(const WidgetId, dm, name: string; callback: TdxCallBack<TdxFileUploader>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxFileUploader;
  begin
    widget := TdxFactory.FileUploader(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxFileUploader',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.FileUploader(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.FileUploader(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxFileUploader>);
begin

  if assigned(DataSource) then
    TdxFactory.FileUploader(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.FileUploader(WidgetId, '', '', callback);
end;

class function TdxFactory.FilterBuilder(const WidgetId: string; Options: TJSObject): TdxFilterBuilder;
asm
  return $(WidgetId).dxFilterBuilder(Options).dxFilterBuilder("instance");
end;

class procedure TdxFactory.FilterBuilder(const WidgetId, dm, name: string; callback: TdxCallBack<TdxFilterBuilder>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxFilterBuilder;
  begin
    widget := TdxFactory.FilterBuilder(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxFilterBuilder',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.FilterBuilder(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.FilterBuilder(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxFilterBuilder>);
begin

  if assigned(DataSource) then
    TdxFactory.FilterBuilder(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.FilterBuilder(WidgetId, '', '', callback);
end;

class function TdxFactory.Form(const WidgetId: string; Options: TJSObject): TdxForm;
asm
  return $(WidgetId).dxForm(Options).dxForm("instance");
end;

class procedure TdxFactory.Form(const WidgetId, dm, name: string; callback: TdxCallBack<TdxForm>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxForm;
  begin
    widget := TdxFactory.Form(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxForm',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Form(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Form(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxForm>);
begin

  if assigned(DataSource) then
    TdxFactory.Form(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Form(WidgetId, '', '', callback);
end;

class function TdxFactory.Funnel(const WidgetId: string; Options: TJSObject): TdxFunnel;
asm
  return $(WidgetId).dxFunnel(Options).dxFunnel("instance");
end;

class procedure TdxFactory.Funnel(const WidgetId, dm, name: string; callback: TdxCallBack<TdxFunnel>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxFunnel;
  begin
    widget := TdxFactory.Funnel(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxFunnel',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Funnel(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Funnel(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxFunnel>);
begin

  if assigned(DataSource) then
    TdxFactory.Funnel(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Funnel(WidgetId, '', '', callback);
end;

class function TdxFactory.Gallery(const WidgetId: string; Options: TJSObject): TdxGallery;
asm
  return $(WidgetId).dxGallery(Options).dxGallery("instance");
end;

class procedure TdxFactory.Gallery(const WidgetId, dm, name: string; callback: TdxCallBack<TdxGallery>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxGallery;
  begin
    widget := TdxFactory.Gallery(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxGallery',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Gallery(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Gallery(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxGallery>);
begin

  if assigned(DataSource) then
    TdxFactory.Gallery(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Gallery(WidgetId, '', '', callback);
end;

class function TdxFactory.Gantt(const WidgetId: string; Options: TJSObject): TdxGantt;
asm
  return $(WidgetId).dxGantt(Options).dxGantt("instance");
end;

class procedure TdxFactory.Gantt(const WidgetId, dm, name: string; callback: TdxCallBack<TdxGantt>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxGantt;
  begin
    widget := TdxFactory.Gantt(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxGantt',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Gantt(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Gantt(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxGantt>);
begin

  if assigned(DataSource) then
    TdxFactory.Gantt(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Gantt(WidgetId, '', '', callback);
end;

class function TdxFactory.HtmlEditor(const WidgetId: string; Options: TJSObject): TdxHtmlEditor;
asm
  return $(WidgetId).dxHtmlEditor(Options).dxHtmlEditor("instance");
end;

class procedure TdxFactory.HtmlEditor(const WidgetId, dm, name: string; callback: TdxCallBack<TdxHtmlEditor>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxHtmlEditor;
  begin
    widget := TdxFactory.HtmlEditor(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxHtmlEditor',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.HtmlEditor(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.HtmlEditor(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxHtmlEditor>);
begin

  if assigned(DataSource) then
    TdxFactory.HtmlEditor(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.HtmlEditor(WidgetId, '', '', callback);
end;

class function TdxFactory.LinearGauge(const WidgetId: string; Options: TJSObject): TdxLinearGauge;
asm
  return $(WidgetId).dxLinearGauge(Options).dxLinearGauge("instance");
end;

class procedure TdxFactory.LinearGauge(const WidgetId, dm, name: string; callback: TdxCallBack<TdxLinearGauge>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxLinearGauge;
  begin
    widget := TdxFactory.LinearGauge(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxLinearGauge',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.LinearGauge(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.LinearGauge(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxLinearGauge>);
begin

  if assigned(DataSource) then
    TdxFactory.LinearGauge(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.LinearGauge(WidgetId, '', '', callback);
end;

class function TdxFactory.List(const WidgetId: string; Options: TJSObject): TdxList;
asm
  return $(WidgetId).dxList(Options).dxList("instance");
end;

class procedure TdxFactory.List(const WidgetId, dm, name: string; callback: TdxCallBack<TdxList>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxList;
  begin
    widget := TdxFactory.List(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxList',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.List(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.List(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxList>);
begin

  if assigned(DataSource) then
    TdxFactory.List(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.List(WidgetId, '', '', callback);
end;

class function TdxFactory.LoadIndicator(const WidgetId: string; Options: TJSObject): TdxLoadIndicator;
asm
  return $(WidgetId).dxLoadIndicator(Options).dxLoadIndicator("instance");
end;

class procedure TdxFactory.LoadIndicator(const WidgetId, dm, name: string; callback: TdxCallBack<TdxLoadIndicator>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxLoadIndicator;
  begin
    widget := TdxFactory.LoadIndicator(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxLoadIndicator',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.LoadIndicator(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.LoadIndicator(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxLoadIndicator>);
begin

  if assigned(DataSource) then
    TdxFactory.LoadIndicator(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.LoadIndicator(WidgetId, '', '', callback);
end;

class function TdxFactory.LoadPanel(const WidgetId: string; Options: TJSObject): TdxLoadPanel;
asm
  return $(WidgetId).dxLoadPanel(Options).dxLoadPanel("instance");
end;

class procedure TdxFactory.LoadPanel(const WidgetId, dm, name: string; callback: TdxCallBack<TdxLoadPanel>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxLoadPanel;
  begin
    widget := TdxFactory.LoadPanel(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxLoadPanel',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.LoadPanel(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.LoadPanel(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxLoadPanel>);
begin

  if assigned(DataSource) then
    TdxFactory.LoadPanel(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.LoadPanel(WidgetId, '', '', callback);
end;

class function TdxFactory.Lookup(const WidgetId: string; Options: TJSObject): TdxLookup;
asm
  return $(WidgetId).dxLookup(Options).dxLookup("instance");
end;

class procedure TdxFactory.Lookup(const WidgetId, dm, name: string; callback: TdxCallBack<TdxLookup>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxLookup;
  begin
    widget := TdxFactory.Lookup(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxLookup',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Lookup(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Lookup(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxLookup>);
begin

  if assigned(DataSource) then
    TdxFactory.Lookup(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Lookup(WidgetId, '', '', callback);
end;

class function TdxFactory.Map(const WidgetId: string; Options: TJSObject): TdxMap;
asm
  return $(WidgetId).dxMap(Options).dxMap("instance");
end;

class procedure TdxFactory.Map(const WidgetId, dm, name: string; callback: TdxCallBack<TdxMap>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxMap;
  begin
    widget := TdxFactory.Map(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxMap',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Map(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Map(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxMap>);
begin

  if assigned(DataSource) then
    TdxFactory.Map(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Map(WidgetId, '', '', callback);
end;

class function TdxFactory.Menu(const WidgetId: string; Options: TJSObject): TdxMenu;
asm
  return $(WidgetId).dxMenu(Options).dxMenu("instance");
end;

class procedure TdxFactory.Menu(const WidgetId, dm, name: string; callback: TdxCallBack<TdxMenu>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxMenu;
  begin
    widget := TdxFactory.Menu(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxMenu',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Menu(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Menu(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxMenu>);
begin

  if assigned(DataSource) then
    TdxFactory.Menu(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Menu(WidgetId, '', '', callback);
end;

class function TdxFactory.MenuBase(const WidgetId: string; Options: TJSObject): TdxMenuBase;
asm
  return $(WidgetId).dxMenuBase(Options).dxMenuBase("instance");
end;

class procedure TdxFactory.MenuBase(const WidgetId, dm, name: string; callback: TdxCallBack<TdxMenuBase>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxMenuBase;
  begin
    widget := TdxFactory.MenuBase(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxMenuBase',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.MenuBase(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.MenuBase(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxMenuBase>);
begin

  if assigned(DataSource) then
    TdxFactory.MenuBase(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.MenuBase(WidgetId, '', '', callback);
end;

class function TdxFactory.MultiView(const WidgetId: string; Options: TJSObject): TdxMultiView;
asm
  return $(WidgetId).dxMultiView(Options).dxMultiView("instance");
end;

class procedure TdxFactory.MultiView(const WidgetId, dm, name: string; callback: TdxCallBack<TdxMultiView>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxMultiView;
  begin
    widget := TdxFactory.MultiView(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxMultiView',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.MultiView(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.MultiView(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxMultiView>);
begin

  if assigned(DataSource) then
    TdxFactory.MultiView(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.MultiView(WidgetId, '', '', callback);
end;

class function TdxFactory.NumberBox(const WidgetId: string; Options: TJSObject): TdxNumberBox;
asm
  return $(WidgetId).dxNumberBox(Options).dxNumberBox("instance");
end;

class procedure TdxFactory.NumberBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxNumberBox>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxNumberBox;
  begin
    widget := TdxFactory.NumberBox(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxNumberBox',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.NumberBox(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.NumberBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxNumberBox>);
begin

  if assigned(DataSource) then
    TdxFactory.NumberBox(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.NumberBox(WidgetId, '', '', callback);
end;

class function TdxFactory.Overlay(const WidgetId: string; Options: TJSObject): TdxOverlay;
asm
  return $(WidgetId).dxOverlay(Options).dxOverlay("instance");
end;

class procedure TdxFactory.Overlay(const WidgetId, dm, name: string; callback: TdxCallBack<TdxOverlay>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxOverlay;
  begin
    widget := TdxFactory.Overlay(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxOverlay',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Overlay(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Overlay(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxOverlay>);
begin

  if assigned(DataSource) then
    TdxFactory.Overlay(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Overlay(WidgetId, '', '', callback);
end;

class function TdxFactory.PieChart(const WidgetId: string; Options: TJSObject): TdxPieChart;
asm
  return $(WidgetId).dxPieChart(Options).dxPieChart("instance");
end;

class procedure TdxFactory.PieChart(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPieChart>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxPieChart;
  begin
    widget := TdxFactory.PieChart(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxPieChart',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.PieChart(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.PieChart(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPieChart>);
begin

  if assigned(DataSource) then
    TdxFactory.PieChart(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.PieChart(WidgetId, '', '', callback);
end;

class function TdxFactory.PivotGrid(const WidgetId: string; Options: TJSObject): TdxPivotGrid;
asm
  return $(WidgetId).dxPivotGrid(Options).dxPivotGrid("instance");
end;

class procedure TdxFactory.PivotGrid(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPivotGrid>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxPivotGrid;
  begin
    widget := TdxFactory.PivotGrid(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxPivotGrid',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.PivotGrid(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.PivotGrid(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPivotGrid>);
begin

  if assigned(DataSource) then
    TdxFactory.PivotGrid(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.PivotGrid(WidgetId, '', '', callback);
end;

class function TdxFactory.PivotGridFieldChooser(const WidgetId: string; Options: TJSObject): TdxPivotGridFieldChooser;
asm
  return $(WidgetId).dxPivotGridFieldChooser(Options).dxPivotGridFieldChooser("instance");
end;

class procedure TdxFactory.PivotGridFieldChooser(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPivotGridFieldChooser>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxPivotGridFieldChooser;
  begin
    widget := TdxFactory.PivotGridFieldChooser(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxPivotGridFieldChooser',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.PivotGridFieldChooser(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.PivotGridFieldChooser(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPivotGridFieldChooser>);
begin

  if assigned(DataSource) then
    TdxFactory.PivotGridFieldChooser(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.PivotGridFieldChooser(WidgetId, '', '', callback);
end;

class function TdxFactory.PolarChart(const WidgetId: string; Options: TJSObject): TdxPolarChart;
asm
  return $(WidgetId).dxPolarChart(Options).dxPolarChart("instance");
end;

class procedure TdxFactory.PolarChart(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPolarChart>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxPolarChart;
  begin
    widget := TdxFactory.PolarChart(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxPolarChart',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.PolarChart(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.PolarChart(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPolarChart>);
begin

  if assigned(DataSource) then
    TdxFactory.PolarChart(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.PolarChart(WidgetId, '', '', callback);
end;

class function TdxFactory.Popover(const WidgetId: string; Options: TJSObject): TdxPopover;
asm
  return $(WidgetId).dxPopover(Options).dxPopover("instance");
end;

class procedure TdxFactory.Popover(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPopover>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxPopover;
  begin
    widget := TdxFactory.Popover(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxPopover',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Popover(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Popover(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPopover>);
begin

  if assigned(DataSource) then
    TdxFactory.Popover(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Popover(WidgetId, '', '', callback);
end;

class function TdxFactory.Popup(const WidgetId: string; Options: TJSObject): TdxPopup;
asm
  return $(WidgetId).dxPopup(Options).dxPopup("instance");
end;

class procedure TdxFactory.Popup(const WidgetId, dm, name: string; callback: TdxCallBack<TdxPopup>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxPopup;
  begin
    widget := TdxFactory.Popup(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxPopup',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Popup(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Popup(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxPopup>);
begin

  if assigned(DataSource) then
    TdxFactory.Popup(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Popup(WidgetId, '', '', callback);
end;

class function TdxFactory.ProgressBar(const WidgetId: string; Options: TJSObject): TdxProgressBar;
asm
  return $(WidgetId).dxProgressBar(Options).dxProgressBar("instance");
end;

class procedure TdxFactory.ProgressBar(const WidgetId, dm, name: string; callback: TdxCallBack<TdxProgressBar>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxProgressBar;
  begin
    widget := TdxFactory.ProgressBar(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxProgressBar',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.ProgressBar(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.ProgressBar(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxProgressBar>);
begin

  if assigned(DataSource) then
    TdxFactory.ProgressBar(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.ProgressBar(WidgetId, '', '', callback);
end;

class function TdxFactory.RadioButton(const WidgetId: string; Options: TJSObject): TdxRadioButton;
asm
  return $(WidgetId).dxRadioButton(Options).dxRadioButton("instance");
end;

class procedure TdxFactory.RadioButton(const WidgetId, dm, name: string; callback: TdxCallBack<TdxRadioButton>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxRadioButton;
  begin
    widget := TdxFactory.RadioButton(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxRadioButton',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.RadioButton(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.RadioButton(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxRadioButton>);
begin

  if assigned(DataSource) then
    TdxFactory.RadioButton(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.RadioButton(WidgetId, '', '', callback);
end;

class function TdxFactory.RadioGroup(const WidgetId: string; Options: TJSObject): TdxRadioGroup;
asm
  return $(WidgetId).dxRadioGroup(Options).dxRadioGroup("instance");
end;

class procedure TdxFactory.RadioGroup(const WidgetId, dm, name: string; callback: TdxCallBack<TdxRadioGroup>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxRadioGroup;
  begin
    widget := TdxFactory.RadioGroup(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxRadioGroup',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.RadioGroup(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.RadioGroup(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxRadioGroup>);
begin

  if assigned(DataSource) then
    TdxFactory.RadioGroup(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.RadioGroup(WidgetId, '', '', callback);
end;

class function TdxFactory.RangeSelector(const WidgetId: string; Options: TJSObject): TdxRangeSelector;
asm
  return $(WidgetId).dxRangeSelector(Options).dxRangeSelector("instance");
end;

class procedure TdxFactory.RangeSelector(const WidgetId, dm, name: string; callback: TdxCallBack<TdxRangeSelector>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxRangeSelector;
  begin
    widget := TdxFactory.RangeSelector(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxRangeSelector',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.RangeSelector(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.RangeSelector(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxRangeSelector>);
begin

  if assigned(DataSource) then
    TdxFactory.RangeSelector(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.RangeSelector(WidgetId, '', '', callback);
end;

class function TdxFactory.RangeSlider(const WidgetId: string; Options: TJSObject): TdxRangeSlider;
asm
  return $(WidgetId).dxRangeSlider(Options).dxRangeSlider("instance");
end;

class procedure TdxFactory.RangeSlider(const WidgetId, dm, name: string; callback: TdxCallBack<TdxRangeSlider>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxRangeSlider;
  begin
    widget := TdxFactory.RangeSlider(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxRangeSlider',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.RangeSlider(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.RangeSlider(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxRangeSlider>);
begin

  if assigned(DataSource) then
    TdxFactory.RangeSlider(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.RangeSlider(WidgetId, '', '', callback);
end;

class function TdxFactory.Resizable(const WidgetId: string; Options: TJSObject): TdxResizable;
asm
  return $(WidgetId).dxResizable(Options).dxResizable("instance");
end;

class procedure TdxFactory.Resizable(const WidgetId, dm, name: string; callback: TdxCallBack<TdxResizable>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxResizable;
  begin
    widget := TdxFactory.Resizable(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxResizable',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Resizable(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Resizable(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxResizable>);
begin

  if assigned(DataSource) then
    TdxFactory.Resizable(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Resizable(WidgetId, '', '', callback);
end;

class function TdxFactory.ResponsiveBox(const WidgetId: string; Options: TJSObject): TdxResponsiveBox;
asm
  return $(WidgetId).dxResponsiveBox(Options).dxResponsiveBox("instance");
end;

class procedure TdxFactory.ResponsiveBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxResponsiveBox>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxResponsiveBox;
  begin
    widget := TdxFactory.ResponsiveBox(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxResponsiveBox',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.ResponsiveBox(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.ResponsiveBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxResponsiveBox>);
begin

  if assigned(DataSource) then
    TdxFactory.ResponsiveBox(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.ResponsiveBox(WidgetId, '', '', callback);
end;

class function TdxFactory.Sankey(const WidgetId: string; Options: TJSObject): TdxSankey;
asm
  return $(WidgetId).dxSankey(Options).dxSankey("instance");
end;

class procedure TdxFactory.Sankey(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSankey>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxSankey;
  begin
    widget := TdxFactory.Sankey(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxSankey',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Sankey(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Sankey(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSankey>);
begin

  if assigned(DataSource) then
    TdxFactory.Sankey(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Sankey(WidgetId, '', '', callback);
end;

class function TdxFactory.Scheduler(const WidgetId: string; Options: TJSObject): TdxScheduler;
asm
  return $(WidgetId).dxScheduler(Options).dxScheduler("instance");
end;

class procedure TdxFactory.Scheduler(const WidgetId, dm, name: string; callback: TdxCallBack<TdxScheduler>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxScheduler;
  begin
    widget := TdxFactory.Scheduler(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxScheduler',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Scheduler(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Scheduler(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxScheduler>);
begin

  if assigned(DataSource) then
    TdxFactory.Scheduler(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Scheduler(WidgetId, '', '', callback);
end;

class function TdxFactory.Scrollable(const WidgetId: string; Options: TJSObject): TdxScrollable;
asm
  return $(WidgetId).dxScrollable(Options).dxScrollable("instance");
end;

class procedure TdxFactory.Scrollable(const WidgetId, dm, name: string; callback: TdxCallBack<TdxScrollable>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxScrollable;
  begin
    widget := TdxFactory.Scrollable(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxScrollable',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Scrollable(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Scrollable(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxScrollable>);
begin

  if assigned(DataSource) then
    TdxFactory.Scrollable(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Scrollable(WidgetId, '', '', callback);
end;

class function TdxFactory.ScrollView(const WidgetId: string; Options: TJSObject): TdxScrollView;
asm
  return $(WidgetId).dxScrollView(Options).dxScrollView("instance");
end;

class procedure TdxFactory.ScrollView(const WidgetId, dm, name: string; callback: TdxCallBack<TdxScrollView>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxScrollView;
  begin
    widget := TdxFactory.ScrollView(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxScrollView',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.ScrollView(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.ScrollView(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxScrollView>);
begin

  if assigned(DataSource) then
    TdxFactory.ScrollView(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.ScrollView(WidgetId, '', '', callback);
end;

class function TdxFactory.SelectBox(const WidgetId: string; Options: TJSObject): TdxSelectBox;
asm
  return $(WidgetId).dxSelectBox(Options).dxSelectBox("instance");
end;

class procedure TdxFactory.SelectBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSelectBox>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxSelectBox;
  begin
    widget := TdxFactory.SelectBox(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxSelectBox',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.SelectBox(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.SelectBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSelectBox>);
begin

  if assigned(DataSource) then
    TdxFactory.SelectBox(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.SelectBox(WidgetId, '', '', callback);
end;

class function TdxFactory.Slider(const WidgetId: string; Options: TJSObject): TdxSlider;
asm
  return $(WidgetId).dxSlider(Options).dxSlider("instance");
end;

class procedure TdxFactory.Slider(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSlider>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxSlider;
  begin
    widget := TdxFactory.Slider(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxSlider',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Slider(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Slider(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSlider>);
begin

  if assigned(DataSource) then
    TdxFactory.Slider(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Slider(WidgetId, '', '', callback);
end;

class function TdxFactory.SliderBase(const WidgetId: string; Options: TJSObject): TdxSliderBase;
asm
  return $(WidgetId).dxSliderBase(Options).dxSliderBase("instance");
end;

class procedure TdxFactory.SliderBase(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSliderBase>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxSliderBase;
  begin
    widget := TdxFactory.SliderBase(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxSliderBase',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.SliderBase(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.SliderBase(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSliderBase>);
begin

  if assigned(DataSource) then
    TdxFactory.SliderBase(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.SliderBase(WidgetId, '', '', callback);
end;

class function TdxFactory.Sortable(const WidgetId: string; Options: TJSObject): TdxSortable;
asm
  return $(WidgetId).dxSortable(Options).dxSortable("instance");
end;

class procedure TdxFactory.Sortable(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSortable>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxSortable;
  begin
    widget := TdxFactory.Sortable(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxSortable',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Sortable(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Sortable(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSortable>);
begin

  if assigned(DataSource) then
    TdxFactory.Sortable(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Sortable(WidgetId, '', '', callback);
end;

class function TdxFactory.Sparkline(const WidgetId: string; Options: TJSObject): TdxSparkline;
asm
  return $(WidgetId).dxSparkline(Options).dxSparkline("instance");
end;

class procedure TdxFactory.Sparkline(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSparkline>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxSparkline;
  begin
    widget := TdxFactory.Sparkline(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxSparkline',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Sparkline(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Sparkline(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSparkline>);
begin

  if assigned(DataSource) then
    TdxFactory.Sparkline(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Sparkline(WidgetId, '', '', callback);
end;

class function TdxFactory.SpeedDialAction(const WidgetId: string; Options: TJSObject): TdxSpeedDialAction;
asm
  return $(WidgetId).dxSpeedDialAction(Options).dxSpeedDialAction("instance");
end;

class procedure TdxFactory.SpeedDialAction(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSpeedDialAction>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxSpeedDialAction;
  begin
    widget := TdxFactory.SpeedDialAction(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxSpeedDialAction',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.SpeedDialAction(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.SpeedDialAction(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSpeedDialAction>);
begin

  if assigned(DataSource) then
    TdxFactory.SpeedDialAction(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.SpeedDialAction(WidgetId, '', '', callback);
end;

class function TdxFactory.Switch(const WidgetId: string; Options: TJSObject): TdxSwitch;
asm
  return $(WidgetId).dxSwitch(Options).dxSwitch("instance");
end;

class procedure TdxFactory.Switch(const WidgetId, dm, name: string; callback: TdxCallBack<TdxSwitch>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxSwitch;
  begin
    widget := TdxFactory.Switch(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxSwitch',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Switch(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Switch(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxSwitch>);
begin

  if assigned(DataSource) then
    TdxFactory.Switch(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Switch(WidgetId, '', '', callback);
end;

class function TdxFactory.TabPanel(const WidgetId: string; Options: TJSObject): TdxTabPanel;
asm
  return $(WidgetId).dxTabPanel(Options).dxTabPanel("instance");
end;

class procedure TdxFactory.TabPanel(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTabPanel>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTabPanel;
  begin
    widget := TdxFactory.TabPanel(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTabPanel',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.TabPanel(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.TabPanel(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTabPanel>);
begin

  if assigned(DataSource) then
    TdxFactory.TabPanel(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.TabPanel(WidgetId, '', '', callback);
end;

class function TdxFactory.Tabs(const WidgetId: string; Options: TJSObject): TdxTabs;
asm
  return $(WidgetId).dxTabs(Options).dxTabs("instance");
end;

class procedure TdxFactory.Tabs(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTabs>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTabs;
  begin
    widget := TdxFactory.Tabs(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTabs',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Tabs(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Tabs(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTabs>);
begin

  if assigned(DataSource) then
    TdxFactory.Tabs(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Tabs(WidgetId, '', '', callback);
end;

class function TdxFactory.TagBox(const WidgetId: string; Options: TJSObject): TdxTagBox;
asm
  return $(WidgetId).dxTagBox(Options).dxTagBox("instance");
end;

class procedure TdxFactory.TagBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTagBox>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTagBox;
  begin
    widget := TdxFactory.TagBox(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTagBox',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.TagBox(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.TagBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTagBox>);
begin

  if assigned(DataSource) then
    TdxFactory.TagBox(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.TagBox(WidgetId, '', '', callback);
end;

class function TdxFactory.TextArea(const WidgetId: string; Options: TJSObject): TdxTextArea;
asm
  return $(WidgetId).dxTextArea(Options).dxTextArea("instance");
end;

class procedure TdxFactory.TextArea(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTextArea>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTextArea;
  begin
    widget := TdxFactory.TextArea(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTextArea',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.TextArea(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.TextArea(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTextArea>);
begin

  if assigned(DataSource) then
    TdxFactory.TextArea(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.TextArea(WidgetId, '', '', callback);
end;

class function TdxFactory.TextBox(const WidgetId: string; Options: TJSObject): TdxTextBox;
asm
  return $(WidgetId).dxTextBox(Options).dxTextBox("instance");
end;

class procedure TdxFactory.TextBox(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTextBox>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTextBox;
  begin
    widget := TdxFactory.TextBox(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTextBox',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.TextBox(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.TextBox(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTextBox>);
begin

  if assigned(DataSource) then
    TdxFactory.TextBox(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.TextBox(WidgetId, '', '', callback);
end;

class function TdxFactory.TextEditor(const WidgetId: string; Options: TJSObject): TdxTextEditor;
asm
  return $(WidgetId).dxTextEditor(Options).dxTextEditor("instance");
end;

class procedure TdxFactory.TextEditor(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTextEditor>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTextEditor;
  begin
    widget := TdxFactory.TextEditor(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTextEditor',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.TextEditor(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.TextEditor(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTextEditor>);
begin

  if assigned(DataSource) then
    TdxFactory.TextEditor(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.TextEditor(WidgetId, '', '', callback);
end;

class function TdxFactory.TileView(const WidgetId: string; Options: TJSObject): TdxTileView;
asm
  return $(WidgetId).dxTileView(Options).dxTileView("instance");
end;

class procedure TdxFactory.TileView(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTileView>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTileView;
  begin
    widget := TdxFactory.TileView(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTileView',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.TileView(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.TileView(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTileView>);
begin

  if assigned(DataSource) then
    TdxFactory.TileView(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.TileView(WidgetId, '', '', callback);
end;

class function TdxFactory.Toast(const WidgetId: string; Options: TJSObject): TdxToast;
asm
  return $(WidgetId).dxToast(Options).dxToast("instance");
end;

class procedure TdxFactory.Toast(const WidgetId, dm, name: string; callback: TdxCallBack<TdxToast>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxToast;
  begin
    widget := TdxFactory.Toast(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxToast',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Toast(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Toast(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxToast>);
begin

  if assigned(DataSource) then
    TdxFactory.Toast(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Toast(WidgetId, '', '', callback);
end;

class function TdxFactory.Toolbar(const WidgetId: string; Options: TJSObject): TdxToolbar;
asm
  return $(WidgetId).dxToolbar(Options).dxToolbar("instance");
end;

class procedure TdxFactory.Toolbar(const WidgetId, dm, name: string; callback: TdxCallBack<TdxToolbar>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxToolbar;
  begin
    widget := TdxFactory.Toolbar(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxToolbar',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Toolbar(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Toolbar(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxToolbar>);
begin

  if assigned(DataSource) then
    TdxFactory.Toolbar(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Toolbar(WidgetId, '', '', callback);
end;

class function TdxFactory.Tooltip(const WidgetId: string; Options: TJSObject): TdxTooltip;
asm
  return $(WidgetId).dxTooltip(Options).dxTooltip("instance");
end;

class procedure TdxFactory.Tooltip(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTooltip>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTooltip;
  begin
    widget := TdxFactory.Tooltip(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTooltip',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Tooltip(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Tooltip(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTooltip>);
begin

  if assigned(DataSource) then
    TdxFactory.Tooltip(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Tooltip(WidgetId, '', '', callback);
end;

class function TdxFactory.TrackBar(const WidgetId: string; Options: TJSObject): TdxTrackBar;
asm
  return $(WidgetId).dxTrackBar(Options).dxTrackBar("instance");
end;

class procedure TdxFactory.TrackBar(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTrackBar>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTrackBar;
  begin
    widget := TdxFactory.TrackBar(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTrackBar',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.TrackBar(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.TrackBar(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTrackBar>);
begin

  if assigned(DataSource) then
    TdxFactory.TrackBar(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.TrackBar(WidgetId, '', '', callback);
end;

class function TdxFactory.TreeList(const WidgetId: string; Options: TJSObject): TdxTreeList;
asm
  return $(WidgetId).dxTreeList(Options).dxTreeList("instance");
end;

class procedure TdxFactory.TreeList(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTreeList>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTreeList;
  begin
    widget := TdxFactory.TreeList(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTreeList',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.TreeList(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.TreeList(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTreeList>);
begin

  if assigned(DataSource) then
    TdxFactory.TreeList(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.TreeList(WidgetId, '', '', callback);
end;

class function TdxFactory.TreeMap(const WidgetId: string; Options: TJSObject): TdxTreeMap;
asm
  return $(WidgetId).dxTreeMap(Options).dxTreeMap("instance");
end;

class procedure TdxFactory.TreeMap(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTreeMap>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTreeMap;
  begin
    widget := TdxFactory.TreeMap(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTreeMap',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.TreeMap(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.TreeMap(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTreeMap>);
begin

  if assigned(DataSource) then
    TdxFactory.TreeMap(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.TreeMap(WidgetId, '', '', callback);
end;

class function TdxFactory.TreeView(const WidgetId: string; Options: TJSObject): TdxTreeView;
asm
  return $(WidgetId).dxTreeView(Options).dxTreeView("instance");
end;

class procedure TdxFactory.TreeView(const WidgetId, dm, name: string; callback: TdxCallBack<TdxTreeView>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxTreeView;
  begin
    widget := TdxFactory.TreeView(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxTreeView',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.TreeView(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.TreeView(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxTreeView>);
begin

  if assigned(DataSource) then
    TdxFactory.TreeView(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.TreeView(WidgetId, '', '', callback);
end;

class function TdxFactory.ValidationGroup(const WidgetId: string; Options: TJSObject): TdxValidationGroup;
asm
  return $(WidgetId).dxValidationGroup(Options).dxValidationGroup("instance");
end;

class procedure TdxFactory.ValidationGroup(const WidgetId, dm, name: string; callback: TdxCallBack<TdxValidationGroup>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxValidationGroup;
  begin
    widget := TdxFactory.ValidationGroup(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxValidationGroup',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.ValidationGroup(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.ValidationGroup(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxValidationGroup>);
begin

  if assigned(DataSource) then
    TdxFactory.ValidationGroup(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.ValidationGroup(WidgetId, '', '', callback);
end;

class function TdxFactory.ValidationSummary(const WidgetId: string; Options: TJSObject): TdxValidationSummary;
asm
  return $(WidgetId).dxValidationSummary(Options).dxValidationSummary("instance");
end;

class procedure TdxFactory.ValidationSummary(const WidgetId, dm, name: string; callback: TdxCallBack<TdxValidationSummary>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxValidationSummary;
  begin
    widget := TdxFactory.ValidationSummary(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxValidationSummary',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.ValidationSummary(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.ValidationSummary(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxValidationSummary>);
begin

  if assigned(DataSource) then
    TdxFactory.ValidationSummary(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.ValidationSummary(WidgetId, '', '', callback);
end;

class function TdxFactory.Validator(const WidgetId: string; Options: TJSObject): TdxValidator;
asm
  return $(WidgetId).dxValidator(Options).dxValidator("instance");
end;

class procedure TdxFactory.Validator(const WidgetId, dm, name: string; callback: TdxCallBack<TdxValidator>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxValidator;
  begin
    widget := TdxFactory.Validator(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxValidator',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.Validator(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.Validator(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxValidator>);
begin

  if assigned(DataSource) then
    TdxFactory.Validator(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.Validator(WidgetId, '', '', callback);
end;

class function TdxFactory.VectorMap(const WidgetId: string; Options: TJSObject): TdxVectorMap;
asm
  return $(WidgetId).dxVectorMap(Options).dxVectorMap("instance");
end;

class procedure TdxFactory.VectorMap(const WidgetId, dm, name: string; callback: TdxCallBack<TdxVectorMap>);
var
  Options: TJSObject;

  procedure doCreate(Options: TJSObject);
  var
    widget: TdxVectorMap;
  begin
    widget := TdxFactory.VectorMap(WidgetId, Options);

    if assigned(callback) then
      callback(widget);
  end;

begin

  if (not dm.isEmpty) and (not name.isEmpty) then
  begin
    Base.DownloadOptions(dm, name, 'TdxVectorMap',
      procedure(o: TJSObject)
      begin
        Options := o;
        doCreate(Options);
      end);
  end
  else
    if assigned(callback) then
    begin
      Options := dxOptions.VectorMap(WidgetId);
      doCreate(Options);
    end;
end;

class procedure TdxFactory.VectorMap(const WidgetId: string; DataSource: TjdxDataSource; callback: TdxCallBack<TdxVectorMap>);
begin

  if assigned(DataSource) then
    TdxFactory.VectorMap(WidgetId, DataSource.dm, DataSource.dataset, callback)
  else
    TdxFactory.VectorMap(WidgetId, '', '', callback);
end;

class function TdxFactory.DataGrid(const WidgetId: string; Options: TJSObject): TdxDataGrid;
asm
  return $(WidgetId).dxDataGrid(Options).dxDataGrid("instance");
end;

class function TdxFactory.DataGrid(const WidgetId, dm, name: string; out dxDataGrid: TdxDataGrid): TJSPromise;
begin
  Result := TJSPromise.new(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DataGrid(WidgetId);

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
  Result := TJSPromise.new(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      defaultOptions: TJSObject;
    begin
      defaultOptions := dxOptions.DataGrid(WidgetId);

      Make(WidgetId, '', '', 'TdxDataGrid', DataSource, defaultOptions,
        procedure(Options: TJSObject)
        begin
          dxDataGrid := dxFactory.DataGrid(WidgetId, Options);
          resolve(dxDataGrid);
        end);
    end);
end;

end.
