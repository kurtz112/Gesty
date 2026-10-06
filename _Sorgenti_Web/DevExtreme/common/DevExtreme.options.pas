unit DevExtreme.options;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  jsdelphisystem,
  js,
  web,
  libjquery,
  DevExtreme.Types,
  DevExtreme.Base,
  DevExtreme.Data,
  DevExtreme.Form.js,
  DevExtreme.Form;

type
  TdxOptions = record
  private
    class function DefaultOptions(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
  public
    class function Accordion(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function ActionSheet(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Autocomplete(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function BarGauge(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Box(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Bullet(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;

    class function Button(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
      overload; static;
    class function Button(const name: string; btnText: string; icon: string; btnType: TdxButtonType; btnStyle: TdxButtonStyle; onClick: TdxEventHandlerFunc): TJSObject; overload; static;

    class function ButtonGroup(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Calendar(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Chart(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function CheckBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function CircularGauge(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function ColorBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function ContextMenu(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;

    class function DataGrid(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
      overload; static;
    class procedure DataGrid(const id: string; DataSource: TjdxDataSource; callBack: TdxCallback<TJSObject>); overload; static;

    class function DateBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function DeferRendering(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Diagram(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Draggable(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Drawer(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function DropDownBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function DropDownButton(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function DropDownEditor(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function DropDownList(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function FileManager(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function FileUploader(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function FilterBuilder(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;

    class function Form(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; overload; static;

    class function Funnel(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Gallery(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Gantt(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function HtmlEditor(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function LinearGauge(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function List(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function LoadIndicator(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function LoadPanel(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;

    class function Lookup(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
      overload; static;
    class function Lookup(const id: string; const displayExpr, valueExpr: string; columns: TJSArray; dxForm: TdxForm; fieldsToCopy: TJSArray; options: TJSObject = nil): TJSObject; overload; static;

    class function Map(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Menu(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function MenuBase(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function MultiView(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function NumberBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Overlay(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function PieChart(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function PivotGrid(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function PivotGridFieldChooser(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil)
      : TJSObject; static;
    class function PolarChart(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Popover(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;

    class function Popup(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
      overload; static;
    class function Popup(const Title: string; const AccentTitleCss: boolean): TJSObject; overload; static;

    class function ProgressBar(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function RadioButton(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function RadioGroup(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function RangeSelector(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function RangeSlider(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Resizable(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function ResponsiveBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Sankey(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Scheduler(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Scrollable(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function ScrollView(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function SelectBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Slider(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function SliderBase(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Sortable(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Sparkline(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function SpeedDialAction(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil)
      : TJSObject; static;
    class function Switch(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function TabPanel(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Tabs(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function TagBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function TextArea(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function TextBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function TextEditor(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function TileView(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Toast(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Toolbar(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function Tooltip(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function TrackBar(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function TreeList(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function TreeMap(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function TreeView(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function ValidationGroup(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil)
      : TJSObject; static;
    class function ValidationSummary(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil)
      : TJSObject; static;
    class function Validator(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
    class function VectorMap(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject; static;
  public
    class function ToolButton(const text: string; btnType: TdxButtonType; proc: TProc): TJSObject; static;
    class function ToolOkCancel(OkProc: TProc; CancelProc: TProc): TJSArray; static;
  end;

var
  dxOptions: TdxOptions;

implementation

uses
  zz.web.js,
  DevExtreme.images,
  DevExtreme.DataGrid,
  DevExtreme.DataGrid.js,
  DevExtreme.Popup.js,
  DevExtreme.Popup,
  DevExtreme.Lookup.js,
  DevExtreme.utils;

{ TdxOptions }

class function TdxOptions.DefaultOptions(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := options;

  if not assigned(result) then
    result := TJSObject.new;

  if not WidgetId.IsEmpty then
    result['id'] := WidgetId;

  result['dm'] := dm;
  result['dataset'] := dataset;

  if assigned(DataSource) then
  begin
    result['dm'] := DataSource.dm;
    result['dataset'] := DataSource.dataset;
  end;
end;

class function TdxOptions.Accordion(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.ActionSheet(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Autocomplete(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.BarGauge(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Box(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Bullet(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Button(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Button(const name: string; btnText, icon: string; btnType: TdxButtonType; btnStyle: TdxButtonStyle; onClick: TdxEventHandlerFunc): TJSObject;
var
  elementAttr: TJSObject;
begin
  result := DefaultOptions(name, nil);
  result['name'] := name;
  result['text'] := btnText;
  result['icon'] := icon;
  result['type'] := btnType.ToString; // 'default';
  result['stylingMode'] := btnStyle.ToString; // 'filled';
  result['onClick'] := onClick; // @Indietro;

  elementAttr := TJSObject.new; // utilizzato
  result['elementAttr'] := elementAttr;
  // elementAttr['style'] := 'width:35%';
end;

class function TdxOptions.ButtonGroup(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Calendar(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Chart(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.CheckBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.CircularGauge(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.ColorBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.ContextMenu(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.DataGrid(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;

  function columnChooser: TJSObject;
  begin
    result := TJSObject.new;
    result['enabled'] := true;
    result['mode'] := 'select';
    result['allowSearch'] := true;
  end;

  function export: TJSObject;
  begin
    result := TJSObject.new;
    result['enabled'] := false; // includere jsZip
    result['fileName'] := 'export';
  end;

  function searchPanel: TJSObject;
  begin
    result := TJSObject.new;
    result['visible'] := false;
  end;

  function paging: TJSObject;
  begin
    result := TJSObject.new;
    result['pageSize'] := 10000;
  end;

  function scrolling: TJSObject;
  begin
    result := TJSObject.new;
    result['mode'] := 'standard';
    result['showScrollbar'] := 'always';
    // result['rowRenderingMode'] := 'infinite';
    // result['renderAsync'] := false;
    // Result['useNative'] := true;
  end;

  function grouping: TJSObject;
  begin
    result := TJSObject.new;
    result['autoExpandAll'] := true;
  end;

  function groupPanel: TJSObject;
  begin
    result := TJSObject.new;
    result['visible'] := false;
  end;

  function selection: TJSObject;
  begin
    result := TJSObject.new;
    result['mode'] := 'single'; // 'multiple' | 'none' | 'single'
    // allowSelectAll
    // selectAllMode  'allPages' | 'page'
    // showCheckBoxesMode  'always' | 'none' | 'onClick' | 'onLongTap'
  end;

  function stateStoring(gridId: string): TJSObject;
  begin
    result := TJSObject.new;
    /// /////////////////////////////////
    // result['enabled'] := true;
    result['enabled'] := false;
    /// /////////////////////////////////
    result['type'] := 'localStorage';
    result['storageKey'] := 'view' + gridId;
  end;

  function toolbar_(DataGrid: TdxDataGrid): TJSObject;

    function toolCaption(const Caption: string): TJSObject;
    begin
      result := TJSObject.new;
      result['location'] := 'before';
      result['template'] := function(): JSValue
        begin
          { TODO : zz-dataGrid-toolbar }
          result := JQuery('<div class="zz-dataGrid-toolbar">' + Caption + '</div>');
        end;
    end;

    function ToolButton_(const hint, icon, location: string; onClick: TdxEventHandlerFunc): TJSObject;
    var
      options: TJSObject;
    begin
      options := TJSObject.new;
      options['hint'] := hint;
      options['icon'] := icon;
      options['width'] := 25;
      options['onClick'] := onClick;

      result := TJSObject.new;
      result['widget'] := 'dxButton';
      result['location'] := location;
      result['options'] := options;
    end;

  var
    Items: TJSArray;
  begin
    Items := TJSArray.new;
    Items.Push(toolCaption(js.ToString(DataGrid.option('caption'))));

    // if js.ToBoolean(store['canUpdate']) then
    if not DataGrid.HideEditButton then
      Items.Push(ToolButton_('apri record corrente', imageEdit, 'before', @DataGrid.UpdateClick));

    if DataGrid.CanInsert then
      Items.Push(ToolButton_('aggiungi un nuovo record', imageAdd, 'before', @DataGrid.AppendClick));

    if DataGrid.CanDelete then
      Items.Push(ToolButton_('elimina il record selezionato', imageRemove, 'before', @DataGrid.DeleteClick));

    if Base.Onnipotente then
      Items.Push(ToolButton_('Personalizza', imageProperties, 'after', @DataGrid.PropertiesClick));

    if Base.Onnipotente then
      Items.Push(ToolButton_('Sql', imageSql, 'after', @DataGrid.SqlClick));

    Items.find(
      function(item: JSValue; index: NativeInt; a: TJSArray): boolean
      var
        btn, options: TJSObject;
      begin
        btn := js.ToObject(item);

        result := sameText(js.ToString(btn['name']), 'columnChooserButton');

        if result then
        begin
          options := js.ToObject(btn['options']);
          options['icon'] := imageColumnChooser;
        end;
      end);

    result := TJSObject.new;
    result['items'] := Items;
  end;

begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
  result['rowAlternationEnabled'] := false;
  result['rowAlternationEnabled'] := true; // PROVA
  result['allowColumnReordering'] := true;
  result['allowColumnResizing'] := true;
  result['columnHidingEnabled'] := false;
  result['columnResizingMode'] := 'widget';
  result['columnAutoWidth'] := true;
  result['columnWidth'] := 'auto';
  result['dateSerializationFormat'] := 'yyyy-MM-ddTHH:mm:ss';
  // Result['dateSerializationFormat'] := 'yyyy-MM-ddTHH:mm:ssZ';
  result['wordWrapEnabled'] := true;
  result['showBorders'] := true;
  result['autoNavigateToFocusedRow'] := true;
  result['focusStateEnabled'] := true;
  result['columnChooser'] := columnChooser;
  result['export'] := export;
  result['searchPanel'] := searchPanel;
  result['paging'] := paging;
  result['remoteOperations'] := true;
  result['scrolling'] := scrolling;
  result['grouping'] := grouping;
  result['groupPanel'] := groupPanel;
  result['selection'] := selection;
  // result['columnHidingEnabled'] := not TdxUtils.isDesktop;

  result['max-width'] := '97%';
  result['max-height'] := '97%';

  result['width'] := '100%';
  result['height'] := '100%';

  if not WidgetId.IsEmpty then
    result['stateStoring'] := stateStoring(WidgetId);

  result['onContentReady'] := function(e: TJSObject): boolean
    var
      DataGrid: TdxDataGrid;
    begin
      DataGrid := TdxDataGrid(e['component']);
      DataGrid.option('focusedRowIndex', 0);
      DataGrid.option('columnAutoWidth', false);
      DataGrid.option('toolbar', toolbar_(DataGrid));
    end;

  result['onCellDblClick'] := function(e: TJSObject): JSValue
    var
      DataGrid: TdxDataGrid;
    begin
      DataGrid := TdxDataGrid(e['component']);
      DataGrid.UpdateClick(e);
    end;
end;

class procedure TdxOptions.DataGrid(const id: string; DataSource: TjdxDataSource; callBack: TdxCallback<TJSObject>);
var
  options: TJSObject;
  columns: TJSArray;
begin
  options := DataGrid(id, nil);

  if assigned(DataSource) then
  begin
    options['dm'] := DataSource.dm;
    options['dataset'] := DataSource.dataset;
    options['keyExpr'] := DataSource.key;
    options['keyExpr'] := DataSource.key;
    options['focusedRowEnabled'] := true;
    options['PK'] := DataSource.key;
    options['remoteOperations'] := true;

    DataSource.GetFields._then(
      function(Value: JSValue): JSValue
      var
        fields: TJSArray;
      begin
        fields := js.toArray(Value);
        columns := CalcHidingPriority(fields);
        options['columns'] := columns;
        options['dataSource'] := DataSource.DataSource;

        if assigned(callBack) then
          callBack(options);
      end)
  end
  else
    if assigned(callBack) then
      callBack(options);
end;

class function TdxOptions.DateBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.DeferRendering(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Diagram(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Draggable(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Drawer(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.DropDownBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.DropDownButton(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.DropDownEditor(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.DropDownList(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.FileManager(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.FileUploader(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.FilterBuilder(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Form(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);

  result['accessKey'] := null;
  result['activeStateEnabled'] := false;
  result['alignItemLabels'] := true;
  result['alignItemLabelsInAllGroups'] := true;
  result['colCount'] := 'auto'; // js.toNumber(card['ColCount']);
  result['customizeItem'] := null;
  result['disabled'] := false;
  result['focusStateEnabled'] := true; //
  result['formData'] := null;
  // Result['height'] := 'auto'; // null;
  result['hint'] := null;
  result['hoverStateEnabled'] := true; //
  result['labelLocation'] := 'left';
  // Result['labelMode'] := 'floating';
  result['labelMode'] := 'outside';
  result['onDisposing'] := null;

  result['onEditorEnterKey'] := function(e: TJSObject): JSValue
    var
      Form: TdxForm;
      dataField: String;
    begin
      dataField := js.ToString(e['dataField']);
      Form := TdxForm(e['component']);
      Form.FocusNextItem(dataField);
    end;

  result['onInitialized'] := null;
  result['onOptionChanged'] := null;
  result['optionalMark'] := 'optional';
  result['readOnly'] := false;
  result['requiredMark'] := '*';
  result['requiredMessage'] := 'Il campo { 0 } è richiesto';
  result['rtlEnabled'] := false;
  result['screenByWidth'] := null;
  result['scrollingEnabled'] := true;
  result['showColonAfterLabel'] := true;
  result['showOptionalMark'] := false;
  result['showRequiredMark'] := true;
  result['showValidationSummary'] := false;
  result['tabIndex'] := 0;
  result['validationGroup'] := null;
  result['visible'] := true;
  result['width'] := null;
  result['height'] := 'auto';
  result['minColWidth'] := 300;

  if dm.IsEmpty and dataset.IsEmpty and (not assigned(DataSource)) then
    result['items'] := TJSArray.new; // assegnato tramite card

  result['onContentReady'] := function(e: TJSObject): JSValue
    var
      dxForm: TdxForm;
      ElementID: string;
    begin

      asm
        ElementID  = e.element[0].id;
      end;

      dxForm := TdxForm(js.ToObject(e['component']));
      dxForm.AfterContentReady(ElementID);
    end;

  result['onFieldDataChanged'] := function(e: TJSObject): JSValue
    var
      dxForm: TdxForm;
      dataField: string;
      Value: JSValue;
    begin
      dxForm := TdxForm(e['component']);
      dataField := js.ToString(e['dataField']);
      Value := e['value'];
      dxForm.FieldChanged(dataField, Value);
    end;
end;

class function TdxOptions.Funnel(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Gallery(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Gantt(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.HtmlEditor(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.LinearGauge(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.List(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.LoadIndicator(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.LoadPanel(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Lookup(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
var
  dropDownOptions: TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);

  result['searchEnabled'] := true;
  result['searchTimeout'] := 300;
  result['searchMode'] := 'startswith';
  result['showDataBeforeSearch'] := true;
  result['minSearchLength'] := 0;
  result['popupHeight'] := 'auto';
  result['showCancelButton'] := true;
  result['showClearButton'] := true;
  result['wrapItemText'] := false;

  /// ////////////////////////////////////////
  /// ////////////////////////////////////////
  /// ////////////////////////////////////////

  dropDownOptions := js.ToObject(result['dropDownOptions']);
  if not assigned(dropDownOptions) then
    dropDownOptions := TJSObject.new;

  // dropDownOptions['container'] := dxForm.element;
  dropDownOptions['resizeEnabled'] := true;
  dropDownOptions['fullScreen'] := tdxutils.ScreenSize < ssMedium;
  // dropDownOptions['hideOnParentScroll'] := tdxutils.ScreenSize >= ssMedium;
  result['dropDownOptions'] := dropDownOptions;
end;

class function TdxOptions.Lookup(const id: string; const displayExpr, valueExpr: string; columns: TJSArray; dxForm: TdxForm; fieldsToCopy: TJSArray; options: TJSObject = nil): TJSObject;
begin
  result := Lookup(id, options);

  result['valueExpr'] := valueExpr;
  result['displayExpr'] := displayExpr;
  result['searchExpr'] := displayExpr;

  /// ///////////////////////////////////////////
  /// ///////////////////////////////////////////
  /// ///////////////////////////////////////////

  result['itemTemplate'] := function(Data: TJSObject; index: integer; element: JSValue): TJSElement
    var
      row: TJQUery;
      multiColumns: boolean;

      procedure AppendToRow(jq: TJQUery);
      begin
        asm
          jq.appendTo(row);
        end;
      end;

      function CreateRow: TJQUery;
      begin
        result := JQuery('<DIV>');
        result := result.css('display', 'flex');
        result := result.css('flex-direction', 'row');
        result := result.css('flex-wrap', 'nowrap');
      end;

      procedure AddField(const Value: string; w: integer; const FirstField: boolean);
      var
        jq: TJQUery;
      begin
        jq := JQuery('<DIV>');

        if FirstField then
        begin
          jq := jq.css('width', '100%');

          if w > 0 then
            jq := jq.css('min-width', w.ToString + 'px');
        end
        else
          if w <= 0 then
            jq := jq.css('width', '100%')
          else
          begin
            jq := jq.css('width', w.ToString + 'px');
            jq := jq.css('max-width', w.ToString + 'px');
          end;

        jq := jq.css('overflow', 'hidden');
        jq := jq.css('white-space', 'nowrap');
        jq := jq.css('text-overflow', 'ellipsis');

        if not Value.IsEmpty then
          jq := jq.text(Value)
        else
          jq := jq.css('height', '7px');

        AppendToRow(jq);
      end;

      procedure AddSeparator;
      const
        SeparatorW = 7;
      var
        jq: TJQUery;
      begin
        jq := JQuery('<DIV>');
        jq := jq.css('width', SeparatorW.ToString + 'px');
        jq := jq.css('max-width', SeparatorW.ToString + 'px');
        jq := jq.css('height', SeparatorW.ToString + 'px');
        AppendToRow(jq);
      end;

      function numeroColonneVisibili(columns: TJSArray): integer;
      var
        i: integer;
      begin
        i := 0;

        columns.forEach(
          function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
          var
            col: TJSObject;
          begin
            col := js.ToObject(element);

            if dxColumnVisible(col) then
              inc(i);
          end);

        result := i;
      end;

    begin
      multiColumns := numeroColonneVisibili(columns) > 1;
      row := CreateRow;

      columns.forEach(
        function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
        var
          col: TJSObject;
          Value: string;
          jq: TJQUery;
          w: integer;
        begin
          col := js.ToObject(element);

          if dxColumnVisible(col) then
          begin
            Value := JSValueToString(Data[js.ToString(col['dataField'])]);

            if multiColumns then
            begin
              w := dxColumnWidth(col);
              AddField(Value, w, index = 0);
              AddSeparator;
            end
            else
              AddField(Value, -1, index = 0);
          end;
        end);
      asm
        element.append(row); // aggiunge al container
      end;
    end;

  /// ///////////////////////////////////////////
  /// ///////////////////////////////////////////
  /// ///////////////////////////////////////////

  // CopyLookupFields
  if assigned(dxForm) then
  begin
    result['onValueChanged'] := function(e: TJSObject): JSValue
      var
        Lookup: TdxLookup;
        selectedItem: TJSObject;
        dataField: string;
      begin
        Lookup := TdxLookup(e['component']);
        selectedItem := js.ToObject(Lookup.option('selectedItem'));
        dxForm.CopyLookupFields(fieldsToCopy, selectedItem);
        //

        dataField := js.ToString(Lookup.option('dataField'));
        console.log('Lookup: ' + dataField, e);
      end;
  end;

  /// ///////////////////////////////////////////
  /// ///////////////////////////////////////////
  /// ///////////////////////////////////////////
end;

class function TdxOptions.Map(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Menu(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.MenuBase(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.MultiView(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.NumberBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Overlay(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.PieChart(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.PivotGrid(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.PivotGridFieldChooser(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil)
  : TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.PolarChart(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Popover(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Popup(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
var
  PopId: string;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);

  PopId := 'pop' + Random(maxint).ToString;

  result := TJSObject.new;
  result[PopIdent] := PopId;
  result['animation'] := TJSObject.new; // toglie l'effetto in show
  result['hideOnOutsideClick'] := false;
  result['hideOnParentScroll'] := false;
  result['dragOutsideBoundary'] := false;
  result['resizeEnabled'] := true;
  result['enableBodyScroll'] := true;
  result['shading'] := true; // pone a modal
  result['showCloseButton'] := false;
  result['showTitle'] := false;
  result['position'] := 'center';
  result['restorePosition'] := true;

  result['width'] := '100px';
  result['height'] := '100px';

  result['maxWidth'] := '97%'; // max/min
  result['maxHeight'] := '97%'; // max/min

  result['contentTemplate'] := function(container: JSValue): JSValue
    begin
      // result := JQuery('<div id="' + TjdxPopup.ContentId(PopId) + '" style="height: fit-content;"></div>');
      result := JQuery('<div id="' + TjdxPopup.ContentId(PopId) + '" style="height: inherit; overflow: hidden;"></div>');
    end;

  result['onDisposing'] := function(e: TJSObject): JSValue
    var
      pop: TdxPopup;
      PopupId: string;
    begin
      // rimuove il DIV creato all'apertura
      pop := TdxPopup(e['component']);
      PopupId := TjdxPopup.ContentId(pop);

      if not PopupId.IsEmpty then
        Window.setTimeout(
          procedure
          var
            div_: TJQUery;
          begin
            div_ := JQuery('#div_' + PopupId);

            if assigned(div_) then
              div_.remove;
          end, 100);
    end;
end;

class function TdxOptions.Popup(const Title: string; const AccentTitleCss: boolean): TJSObject;
begin
  result := Popup('', nil); // vedere se occorre impostare

  if Title.IsEmpty then
    result['showTitle'] := false
  else
  begin
    result['showTitle'] := true;
    result['title'] := Title;
  end;

  if AccentTitleCss then
    result['onTitleRendered'] :=
    function(e: TJSObject): JSValue var Title: TJQUery;

  begin
    Title := TJQUery(e['titleElement']);
    Title.addClass(cssAccentBackgroundColor + ' ' + cssAccentTextColor);
  end;
end;

class function TdxOptions.ProgressBar(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.RadioButton(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.RadioGroup(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.RangeSelector(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.RangeSlider(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Resizable(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.ResponsiveBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Sankey(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Scheduler(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Scrollable(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.ScrollView(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.SelectBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Slider(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.SliderBase(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Sortable(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Sparkline(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.SpeedDialAction(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Switch(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.TabPanel(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Tabs(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.TagBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.TextArea(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.TextBox(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.TextEditor(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.TileView(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Toast(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Toolbar(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Tooltip(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.TrackBar(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.TreeList(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.TreeMap(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.TreeView(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.ValidationGroup(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.ValidationSummary(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil)
  : TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.Validator(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

class function TdxOptions.VectorMap(const WidgetId: string; const options: TJSObject = nil; const dm: string = ''; const dataset: string = ''; const DataSource: TjdxDataSource = nil): TJSObject;
begin
  result := DefaultOptions(WidgetId, options, dm, dataset, DataSource);
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

class function TdxOptions.ToolButton(const text: string; btnType: TdxButtonType; proc: TProc): TJSObject;
var
  options: TJSObject;
begin
  options := TJSObject.new;
  options['type'] := btnType.ToString;
  // options['icon']: 'email',
  options['text'] := text;
  options['stylingMode'] := 'contained';
  options['onClick'] := function(e: TJSObject): boolean
    begin
      if assigned(proc) then
        proc;
    end;

  result := TJSObject.new;
  result['widget'] := 'dxButton';
  result['toolbar'] := 'bottom';
  result['location'] := 'after';
  result['options'] := options;
end;

class function TdxOptions.ToolOkCancel(OkProc, CancelProc: TProc): TJSArray;
begin
  result := TJSArray.new;
  result.Push(ToolButton('Conferma', btSuccess, OkProc));
  result.Push(ToolButton('Annulla', btDefault, CancelProc));
end;

end.

  DevExtreme.Lookup DevExtreme.DataGrid
