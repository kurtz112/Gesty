
{*********************************************************}
{                                                         }
{                    XML Data Binding                     }
{                                                         }
{         Generated on: 05/02/2023 10:29:35               }
{       Generated from: C:\Users\Luca\Desktop\prova.xml   }
{   Settings stored in: C:\Users\Luca\Desktop\prova.xdb   }
{                                                         }
{*********************************************************}

unit Excel_FoglioDiCalcoloXML2003;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward Decls }

  IXMLWorkbookType = interface;
  IXMLDocumentPropertiesType = interface;
  IXMLExcelWorkbookType = interface;
  IXMLWorksheetType = interface;
  IXMLTableType = interface;
  IXMLRowType = interface;
  IXMLCellType = interface;
  IXMLDataType = interface;

{ IXMLWorkbookType }

  IXMLWorkbookType = interface(IXMLNode)
    ['{90DDB9D3-4946-48A1-8B0B-ADF32B72FE71}']
    { Property Accessors }
    function Get_Xmlns: UnicodeString;
    function Get_DocumentProperties: IXMLDocumentPropertiesType;
    function Get_ExcelWorkbook: IXMLExcelWorkbookType;
    function Get_Styles: UnicodeString;
    function Get_Worksheet: IXMLWorksheetType;
    procedure Set_Xmlns(const Value: UnicodeString);
    procedure Set_Styles(const Value: UnicodeString);
    { Methods & Properties }
    property Xmlns: UnicodeString read Get_Xmlns write Set_Xmlns;
    property DocumentProperties: IXMLDocumentPropertiesType read Get_DocumentProperties;
    property ExcelWorkbook: IXMLExcelWorkbookType read Get_ExcelWorkbook;
    property Styles: UnicodeString read Get_Styles write Set_Styles;
    property Worksheet: IXMLWorksheetType read Get_Worksheet;
  end;

{ IXMLDocumentPropertiesType }

  IXMLDocumentPropertiesType = interface(IXMLNode)
    ['{89207A1B-E6B6-4170-8749-ADBD30C2334A}']
    { Property Accessors }
    function Get_Xmlns: UnicodeString;
    procedure Set_Xmlns(const Value: UnicodeString);
    { Methods & Properties }
    property Xmlns: UnicodeString read Get_Xmlns write Set_Xmlns;
  end;

{ IXMLExcelWorkbookType }

  IXMLExcelWorkbookType = interface(IXMLNode)
    ['{C5171E65-4FBB-4B74-9FAC-ABB50F0782AB}']
    { Property Accessors }
    function Get_Xmlns: UnicodeString;
    procedure Set_Xmlns(const Value: UnicodeString);
    { Methods & Properties }
    property Xmlns: UnicodeString read Get_Xmlns write Set_Xmlns;
  end;

{ IXMLWorksheetType }

  IXMLWorksheetType = interface(IXMLNode)
    ['{3EA74A36-11A3-4543-84F6-B76915FB9611}']
    { Property Accessors }
    function Get_Name: UnicodeString;
    function Get_Table: IXMLTableType;
    procedure Set_Name(const Value: UnicodeString);
    { Methods & Properties }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Table: IXMLTableType read Get_Table;
  end;

{ IXMLTableType }

  IXMLTableType = interface(IXMLNodeCollection)
    ['{DE649559-7529-4161-BF32-3677E2F6FF0E}']
    { Property Accessors }
    function Get_Row(const Index: Integer): IXMLRowType;
    { Methods & Properties }
    function Add: IXMLRowType;
    function Insert(const Index: Integer): IXMLRowType;
    property Row[const Index: Integer]: IXMLRowType read Get_Row; default;
  end;

{ IXMLRowType }

  IXMLRowType = interface(IXMLNodeCollection)
    ['{209C0A38-2F5A-465C-9801-18644858A084}']
    { Property Accessors }
    function Get_Cell(const Index: Integer): IXMLCellType;
    { Methods & Properties }
    function Add: IXMLCellType;
    function Insert(const Index: Integer): IXMLCellType;
    property Cell[const Index: Integer]: IXMLCellType read Get_Cell; default;
  end;

{ IXMLCellType }

  IXMLCellType = interface(IXMLNode)
    ['{894B9DE9-F744-41DD-B5D6-EE9772FBDB3B}']
    { Property Accessors }
    function Get_Data: IXMLDataType;
    { Methods & Properties }
    property Data: IXMLDataType read Get_Data;
  end;

{ IXMLDataType }

  IXMLDataType = interface(IXMLNode)
    ['{D6A1BDFF-BB94-4750-BBA4-1E5DE6309185}']
    { Property Accessors }
    function Get_Type_: UnicodeString;
    procedure Set_Type_(const Value: UnicodeString);
    { Methods & Properties }
    property Type_: UnicodeString read Get_Type_ write Set_Type_;
  end;

{ Forward Decls }

  TXMLWorkbookType = class;
  TXMLDocumentPropertiesType = class;
  TXMLExcelWorkbookType = class;
  TXMLWorksheetType = class;
  TXMLTableType = class;
  TXMLRowType = class;
  TXMLCellType = class;
  TXMLDataType = class;

{ TXMLWorkbookType }

  TXMLWorkbookType = class(TXMLNode, IXMLWorkbookType)
  protected
    { IXMLWorkbookType }
    function Get_Xmlns: UnicodeString;
    function Get_DocumentProperties: IXMLDocumentPropertiesType;
    function Get_ExcelWorkbook: IXMLExcelWorkbookType;
    function Get_Styles: UnicodeString;
    function Get_Worksheet: IXMLWorksheetType;
    procedure Set_Xmlns(const Value: UnicodeString);
    procedure Set_Styles(const Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDocumentPropertiesType }

  TXMLDocumentPropertiesType = class(TXMLNode, IXMLDocumentPropertiesType)
  protected
    { IXMLDocumentPropertiesType }
    function Get_Xmlns: UnicodeString;
    procedure Set_Xmlns(const Value: UnicodeString);
  end;

{ TXMLExcelWorkbookType }

  TXMLExcelWorkbookType = class(TXMLNode, IXMLExcelWorkbookType)
  protected
    { IXMLExcelWorkbookType }
    function Get_Xmlns: UnicodeString;
    procedure Set_Xmlns(const Value: UnicodeString);
  end;

{ TXMLWorksheetType }

  TXMLWorksheetType = class(TXMLNode, IXMLWorksheetType)
  protected
    { IXMLWorksheetType }
    function Get_Name: UnicodeString;
    function Get_Table: IXMLTableType;
    procedure Set_Name(const Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTableType }

  TXMLTableType = class(TXMLNodeCollection, IXMLTableType)
  protected
    { IXMLTableType }
    function Get_Row(const Index: Integer): IXMLRowType;
    function Add: IXMLRowType;
    function Insert(const Index: Integer): IXMLRowType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRowType }

  TXMLRowType = class(TXMLNodeCollection, IXMLRowType)
  protected
    { IXMLRowType }
    function Get_Cell(const Index: Integer): IXMLCellType;
    function Add: IXMLCellType;
    function Insert(const Index: Integer): IXMLCellType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCellType }

  TXMLCellType = class(TXMLNode, IXMLCellType)
  protected
    { IXMLCellType }
    function Get_Data: IXMLDataType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDataType }

  TXMLDataType = class(TXMLNode, IXMLDataType)
  protected
    { IXMLDataType }
    function Get_Type_: UnicodeString;
    procedure Set_Type_(const Value: UnicodeString);
  end;

{ Global Functions }

function GetWorkbook(Doc: IXMLDocument): IXMLWorkbookType;
function LoadWorkbook(const FileName: string): IXMLWorkbookType;
function NewWorkbook: IXMLWorkbookType;

const
  TargetNamespace = 'urn:schemas-microsoft-com:office:spreadsheet';

implementation

uses System.Variants, System.SysUtils, Xml.xmlutil;

{ Global Functions }

function GetWorkbook(Doc: IXMLDocument): IXMLWorkbookType;
begin
  Result := Doc.GetDocBinding('Workbook', TXMLWorkbookType, TargetNamespace) as IXMLWorkbookType;
end;

function LoadWorkbook(const FileName: string): IXMLWorkbookType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Workbook', TXMLWorkbookType, TargetNamespace) as IXMLWorkbookType;
end;

function NewWorkbook: IXMLWorkbookType;
begin
  Result := NewXMLDocument.GetDocBinding('Workbook', TXMLWorkbookType, TargetNamespace) as IXMLWorkbookType;
end;

{ TXMLWorkbookType }

procedure TXMLWorkbookType.AfterConstruction;
begin
  RegisterChildNode('DocumentProperties', TXMLDocumentPropertiesType);
  RegisterChildNode('ExcelWorkbook', TXMLExcelWorkbookType);
  RegisterChildNode('Worksheet', TXMLWorksheetType);
  inherited;
end;

function TXMLWorkbookType.Get_Xmlns: UnicodeString;
begin
  Result := AttributeNodes['xmlns'].Text;
end;

procedure TXMLWorkbookType.Set_Xmlns(const Value: UnicodeString);
begin
  SetAttribute('xmlns', Value);
end;

function TXMLWorkbookType.Get_DocumentProperties: IXMLDocumentPropertiesType;
begin
  Result := ChildNodes['DocumentProperties'] as IXMLDocumentPropertiesType;
end;

function TXMLWorkbookType.Get_ExcelWorkbook: IXMLExcelWorkbookType;
begin
  Result := ChildNodes['ExcelWorkbook'] as IXMLExcelWorkbookType;
end;

function TXMLWorkbookType.Get_Styles: UnicodeString;
begin
  Result := ChildNodes['Styles'].Text;
end;

procedure TXMLWorkbookType.Set_Styles(const Value: UnicodeString);
begin
  ChildNodes['Styles'].NodeValue := Value;
end;

function TXMLWorkbookType.Get_Worksheet: IXMLWorksheetType;
begin
  Result := ChildNodes['Worksheet'] as IXMLWorksheetType;
end;

{ TXMLDocumentPropertiesType }

function TXMLDocumentPropertiesType.Get_Xmlns: UnicodeString;
begin
  Result := AttributeNodes['xmlns'].Text;
end;

procedure TXMLDocumentPropertiesType.Set_Xmlns(const Value: UnicodeString);
begin
  SetAttribute('xmlns', Value);
end;

{ TXMLExcelWorkbookType }

function TXMLExcelWorkbookType.Get_Xmlns: UnicodeString;
begin
  Result := AttributeNodes['xmlns'].Text;
end;

procedure TXMLExcelWorkbookType.Set_Xmlns(const Value: UnicodeString);
begin
  SetAttribute('xmlns', Value);
end;

{ TXMLWorksheetType }

procedure TXMLWorksheetType.AfterConstruction;
begin
  RegisterChildNode('Table', TXMLTableType);
  inherited;
end;

function TXMLWorksheetType.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['Name'].Text;
end;

procedure TXMLWorksheetType.Set_Name(const Value: UnicodeString);
begin
  SetAttribute('Name', Value);
end;

function TXMLWorksheetType.Get_Table: IXMLTableType;
begin
  Result := ChildNodes['Table'] as IXMLTableType;
end;

{ TXMLTableType }

procedure TXMLTableType.AfterConstruction;
begin
  RegisterChildNode('Row', TXMLRowType);
  ItemTag := 'Row';
  ItemInterface := IXMLRowType;
  inherited;
end;

function TXMLTableType.Get_Row(const Index: Integer): IXMLRowType;
begin
  Result := List[Index] as IXMLRowType;
end;

function TXMLTableType.Add: IXMLRowType;
begin
  Result := AddItem(-1) as IXMLRowType;
end;

function TXMLTableType.Insert(const Index: Integer): IXMLRowType;
begin
  Result := AddItem(Index) as IXMLRowType;
end;

{ TXMLRowType }

procedure TXMLRowType.AfterConstruction;
begin
  RegisterChildNode('Cell', TXMLCellType);
  ItemTag := 'Cell';
  ItemInterface := IXMLCellType;
  inherited;
end;

function TXMLRowType.Get_Cell(const Index: Integer): IXMLCellType;
begin
  Result := List[Index] as IXMLCellType;
end;

function TXMLRowType.Add: IXMLCellType;
begin
  Result := AddItem(-1) as IXMLCellType;
end;

function TXMLRowType.Insert(const Index: Integer): IXMLCellType;
begin
  Result := AddItem(Index) as IXMLCellType;
end;

{ TXMLCellType }

procedure TXMLCellType.AfterConstruction;
begin
  RegisterChildNode('Data', TXMLDataType);
  inherited;
end;

function TXMLCellType.Get_Data: IXMLDataType;
begin
  Result := ChildNodes['Data'] as IXMLDataType;
end;

{ TXMLDataType }

function TXMLDataType.Get_Type_: UnicodeString;
begin
  Result := AttributeNodes['Type'].Text;
end;

procedure TXMLDataType.Set_Type_(const Value: UnicodeString);
begin
  SetAttribute('Type', Value);
end;

end.