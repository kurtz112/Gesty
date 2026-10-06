unit fastReportFontSubset;

interface

uses
  winapi.Windows,
  winapi.Messages,
  System.SysUtils,
  System.Classes,
  vcl.Graphics,
  frxExportPDFHelpers,
  frxOTF,
  frxStorage,
  frxCrypto;

// fastReportFontSubset.WriteFont(FPOH.Fonts[i], FPOH, pdf, Compressed, FEncKey);
procedure WriteFont(frxPDFFont: TfrxPDFFont; FPOH: TPDFObjectsHelper; pdf: TStream; const Compressed: Boolean; EncKey: String);

type
  TfrxPDFCharClass = (ccRegular, ccWhitespace, ccDelimiter);

  TfrxPDFBinaryStreamOption = (bsoEncrypt, bsoCompress, bsoHexEncode);
  TfrxPDFBinaryStreamOptions = set of TfrxPDFBinaryStreamOption;

  TfrxPDFFontInfo = record
    FontBox: TFontBox;
    Ascent: Integer;
    Descent: Integer;
    AvgWidth: Integer;
    MaxWidth: Integer;
    ItalicAngle: Integer;
    MissingWidth: Integer;
    StemV: Integer;
    CapHeight: Integer;
    Leading: Integer;
    Flags: Word;
  end;

  TfrxPDFFontView = class
  private
    FView: TView;
    FCollection: Boolean;
    FData: TMemoryStream;

    function FindFont(Name: string): TFontView;
    procedure CreateView;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Load(Handle: HFont); overload;
    procedure Load(Src: TStream); overload;

    function GetFontsCount: Integer;
    function GetFont(Index: Integer): TFontView; overload;
    function GetFont(Name: string): TFontView; overload;
  end;

  TfrxPDFFontZZ = class
  private
    FEmbedSubset: Boolean;
    FSourceFont: TFont;
    FReference: Longint;
    FSaved: Boolean;
    FName: AnsiString;
    FSubsetTag: AnsiString;
    FFontName: AnsiString;
    FView: TfrxPDFFontView;
    FFontView: TFontView;
    FUsedChars: TBitArray;
    FFontInfo: TfrxPDFFontInfo;
    frxPDFFont: TfrxPDFFont;

    procedure BuildFont;
    procedure MarkCharAsUsed(Char: Word);
    procedure LoadFontInfo;
    function GetFontFile: TStream;
    function GetFontName: AnsiString;
    function GetFontInfo: TfrxPDFFontInfo;
    function GetSubsetTag: AnsiString;
    function IsBuilt: Boolean;

    function GetCMapType: Integer;
    function GetCMapName: string;
    function GetCMapRegistry: string;
    function GetCMapOrdering: string;
    function GetCMapSupplement: Integer;
  public
    constructor Create(afrxPDFFont: TfrxPDFFont; EmbedSubset: Boolean);
    destructor Destroy; override;

    procedure SaveToStream(Stream: TStream);

    { Writes a mapping from charcodes to unicodes }
    procedure WriteCharToUnicodeMap(Stream: TStream);

    { Writes mapping from CID to GID indices.
      This stream is the contents of the /CIDToGID key. }
    procedure WriteCIDToGIDMap(Stream: TStream);

    { Writes widths of used characters.
      This data is the value of the /W key. }
    procedure WriteCharWidths(Stream: TStream);

    { Writes a bit array of used CIDs }
    procedure WriteCIDSet(Stream: TStream);

    property FontName: AnsiString read GetFontName;
    property FontFile: TStream read GetFontFile;
    property FontInfo: TfrxPDFFontInfo read GetFontInfo;

    property CMapName: string read GetCMapName;
    property CMapOrdering: string read GetCMapOrdering;
    property CMapRegistry: string read GetCMapRegistry;
    property CMapSupplement: Integer read GetCMapSupplement;

    property PDFName: AnsiString read FName write FName;
    property Saved: Boolean read FSaved write FSaved;
    property Reference: Integer read FReference write FReference;
    property SourceFont: TFont read FSourceFont;
  end;

  { Builds a font (a .ttf file) }
  TFontBuilder = class(TBuilder)
  private
    FFontFileBase: Cardinal;
    FFont: TFontView;
    FTags: array of TFontTableTag;
    FTables: array of TBuilder;
    FCompChecksums: Boolean;

    FCharmap: TOrderedMap; // maps charcodes to glyph indices
    FGUsed: TOrderedMap; // set of original indices of all used glyphs
    FGRemap: TOrderedMap; // maps original glyph indices to new ones
    FGlyphs: WordArray; // list of original indices for all used glyphs
    FChars: WordArray; // list of all used charcodes

    function RemapGlyph(g: TGlyphIndex): TGlyphIndex; // maps original index to index in repacked font
    function MapCharToGlyph(c: Word): TGlyphIndex; // maps charcode to glyph index in original font

    function CreateMetricsInfoTable(View: TMetricsInfoTableView; NumMetrics: Word): TBuilder;
    function CreateSegCharmapTable(Lang: Word): TSegCharmapTableBuilder;
    function CreateAsciiCharmapTable(Lang: Word): TAsciiCharmapTableBuilder;
    function CreateCharmapTable: TCharmapTableBuilder;
    function CreateMetricsTable(View: TMetricsTableView): TMetricsTableBuilder;
    function CreateMaxpTable(NumGlyphs: Word): TBuilder;
    function CreateHeadTable(LongOffsets: Boolean): TBuilder;
    function CreateStringTable: TStringTableBuilder;

    procedure RepackGlyphs(out Glyf, Loca: TFontTableBuilder; out LongOffsets: Boolean);

    procedure AddDescendantGlyphs(g: TGlyphIndex);
    procedure BuildGlyphsRemapping; // fills in FGRemap, FGlyphs
    procedure BuildCharsList; // fills in FChars

    procedure WriteHeader(Stream: TStream);
    procedure WriteTableRecord(Stream: TStream; Index, Offset, Len, Checksum: Cardinal);

    procedure CopyTableFromSrcFont(Name: TFontTableTag);
    procedure AddTable(Tag: TFontTableTag; Table: TBuilder);
    procedure SaveTablesToStream(Stream: TStream);
  public
    constructor Create(Font: TFontView);
    destructor Destroy; override;

    procedure AddCharset(Charset: TBitArray);
    procedure AddChar(c: Word);
    procedure AddCharExt(idx, c: Word);
    procedure SaveToStream(Stream: TStream); override;

    function GetUsedGlyphs: TBitArray;

    property ComputeChecksums: Boolean read FCompChecksums write FCompChecksums;
    property FontFileBase: Cardinal read FFontFileBase write FFontFileBase;
  end;

  { Represents a charmap subtable of the format 4 }
  TSegCharmapTableView = class(TCharmapSubtableView)
  private
    FSegNum: Integer;
    FGlyphNum: Integer;
    FFirst: WordArray;
    FLast: WordArray;
    FDelta: WordArray;
    FOffset: WordArray;

    function GetHeader: TSegCharmapTableHeader;
    procedure CheckHeader(const h: TSegCharmapTableHeader);

    function ReadWord(Offset: Cardinal): Word;
    function GetWord(var w: WordArray; i: Integer; p: Cardinal): Word;

    function GetFirst(i: Integer): Word;
    function GetLast(i: Integer): Word;
    function GetOffset(i: Integer): Word;
    function GetGlyph(i: Integer): Word;
    function GetDelta(i: Integer): Word;

    { Finds optimal set of segments for a set of used chars which
      produces the smallest charmap.

      Chars[i]  = charcode of the i-th char; this array must be ascending
      Glyphs[i] = glyph index the corresponds to the i-th char
      Seg[i]    = length of the i-th segment

      Result    = number of bytes needed for all these segments }

    class function FindOptimalMapping(const Chars, Glyphs: WordArray; out Seg: WordArray): Word;
  protected
    procedure Init; override;
    function GetLanguage: Word; override;
    function GetGlyphIndex(Char: Word): TGlyphIndex; override;
  public
    procedure Accept(v: TVisitor); override;

    property SegCount: Integer read FSegNum;
    property First[i: Integer]: Word read GetFirst;
    property Last[i: Integer]: Word read GetLast;
    property Delta[i: Integer]: Word read GetDelta;
    property Offset[i: Integer]: Word read GetOffset;
    property Glyph[i: Integer]: Word read GetGlyph;
  end;

implementation

uses
  System.Math,
  frxGZip;

type
  TfrxPDFFontAccess = class(TfrxPDFFont);

function GetCharClass(c: AnsiChar): TfrxPDFCharClass;
begin
  case c of
    #0, #9, #10, #12, #13, #32:
      Result := ccWhitespace;
    '(', ')', '[', ']', '{', '}', '/', '%':
      Result := ccDelimiter;
  else
    Result := ccRegular;
  end;
end;

procedure EndLine(Stream: TStream);
begin
  Stream.Write(AnsiString(#13#10), 2);
end;

procedure Write(Stream: TStream; const s: WideString); overload;
begin
  Write(Stream, AnsiString(s))
end;

procedure Write(Stream: TStream; const Fmt: string; const Args: array of const); overload;
begin
  Write(Stream, AnsiString(Format(Fmt, Args)))
end;

procedure Writeln(Stream: TStream; const Fmt: string; const Args: array of const); overload;
begin
  Writeln(Stream, AnsiString(Format(Fmt, Args)));
end;

procedure Writeln(Stream: TStream; const s: WideString); overload;
begin
  Writeln(Stream, AnsiString(s))
end;

/// /////////////////////////////////////////////////////////////////////////////////////

procedure Error(const Msg: string);
begin
  raise EInvalidOpenTypeFont.Create(Msg)
end;

procedure Check(Condition: Boolean; const Msg: string = 'Invalid font');
begin
  if not Condition then
    Error(Msg)
end;

function Log2(x: Word): Word;
begin
  Result := 0;

  while x > 1 do
  begin
    Inc(Result);
    x := x div 2;
  end;
end;

procedure Zero(var p; Size: Cardinal);
begin
  FillChar(p, Size, 0)
end;

function Swap(x: Cardinal): Cardinal; overload;
begin
  Result := (x shr 0 and $FF shl 24) or (x shr 8 and $FF shl 16) or (x shr 16 and $FF shl 8) or (x shr 24 and $FF shl 0)
end;

function Swap(x: Word): Word; overload;
begin
  Result := (x and $FF shl 8) or (x shr 8)
end;

function Swap(x: Int64): Int64; overload;
begin
  Result := (Int64(Swap(Cardinal(x and $FFFFFFFF))) shl 32) xor Int64(Swap(Cardinal(x shr 32)))
end;

function Swap(x: SmallInt): SmallInt; overload;
begin
  Result := SmallInt(Swap(Word(x)))
end;

procedure Swap(var a: array of Word); overload;
var
  i: Integer;
begin
  for i := Low(a) to High(a) do
    a[i] := Swap(a[i])
end;

procedure Swap(var a: array of SmallInt); overload;
var
  i: Integer;
begin
  for i := Low(a) to High(a) do
    a[i] := Swap(a[i])
end;

procedure Swap(var s: WideString); overload;
var
  i: Integer;
begin
  for i := 1 to Length(s) do
    s[i] := WideChar(Swap(Word(s[i])))
end;

procedure SwapIP(var a: Word); overload;
begin
  a := Swap(a)
end;

procedure SwapIP(var a: SmallInt); overload;
begin
  a := Swap(a)
end;

procedure SwapIP(var a: Cardinal); overload;
begin
  a := Swap(a)
end;

procedure Swap(var h: TWinMetrics1TableHeader); overload;
begin
  with h do
  begin
    SwapIP(Version);
    SwapIP(AvgWidth);
    SwapIP(Weight);
    SwapIP(Width);
    SwapIP(Rights);

    SwapIP(SubXSize);
    SwapIP(SubYSize);
    SwapIP(SubXOffset);
    SwapIP(SubYOffset);

    SwapIP(SupXSize);
    SwapIP(SupYSize);
    SwapIP(SupXOffset);
    SwapIP(SupYOffset);

    SwapIP(StrikeSize);
    SwapIP(StrikePos);
    SwapIP(Family);

    // todo: swap Panose?
    // todo: swap UniRange?
    // todo: swap Vendor?

    SwapIP(Selection);
    SwapIP(FirstChar);
    SwapIP(LastChar);
    SwapIP(Ascender);
    SwapIP(Descender);
    SwapIP(WinAscent);
    SwapIP(WinDescent);

    // todo: swap PageRange?

    {
      SwapIP(Height);
      SwapIP(CapHeight);
      SwapIP(DefChar);
      SwapIP(BreakChar);
      SwapIP(MaxContext);
    }
  end;
end;

procedure Swap(var h: TGlyphHeader); overload;
begin
  with h do
  begin
    NumContours := Swap(NumContours);
    XMin := Swap(XMin);
    XMax := Swap(XMax);
    YMin := Swap(YMin);
    YMax := Swap(YMax);
  end;
end;

procedure Swap(var h: TGlyphEntryHeader); overload;
begin
  with h do
  begin
    Flags := Swap(Flags);
    Glyph := Swap(Glyph);
  end;
end;

procedure Swap(var h: TMetricsTableHeader); overload;
begin
  with h do
  begin
    Version := Swap(Version);
    Ascent := Swap(Ascent);
    Descent := Swap(Descent);
    LineGap := Swap(LineGap);
    MaxWidth := Swap(MaxWidth);
    MinSB1 := Swap(MinSB1);
    MinSB2 := Swap(MinSB2);
    MaxExtent := Swap(MaxExtent);
    SlopeRise := Swap(SlopeRise);
    SlopeRun := Swap(SlopeRun);
    Offset := Swap(Offset);
    Metric := Swap(Metric);
    NumMetrics := Swap(NumMetrics);
  end;
end;

procedure Swap(var h: TAsciiCharmapTableHeader); overload;
begin
  with h do
  begin
    Format := Swap(Format);
    Length := Swap(Length);
    Lang := Swap(Lang);
  end;
end;

procedure Swap(var h: TStringTableHeader); overload;
begin
  with h do
  begin
    Format := Swap(Format);
    Count := Swap(Count);
    Offset := Swap(Offset);
  end;
end;

procedure Swap(var h: TStringRecord); overload;
begin
  with h do
  begin
    Platform := Swap(Platform);
    Encoding := Swap(Encoding);
    Language := Swap(Language);
    Id := Swap(Id);
    Size := Swap(Size);
    Offset := Swap(Offset);
  end;
end;

procedure Swap(var h: TFontFileHeader); overload;
begin
  with h do
  begin
    NumTables := Swap(NumTables);
    Selector := Swap(Selector);
    Shift := Swap(Shift);
    Range := Swap(Range);
    Version := Swap(Version);
  end;
end;

procedure Swap(var h: TTableRecordEntry); overload;
begin
  with h do
  begin
    Checksum := Swap(Checksum);
    Offset := Swap(Offset);
    Length := Swap(Length);
  end;
end;

procedure Swap(var h: TFontCollectionFileHeader); overload;
begin
  with h do
  begin
    Version := Swap(Version);
    NumFonts := Swap(NumFonts);
  end;
end;

procedure Swap(var h: TSegCharmapTableHeader); overload;
begin
  with h do
  begin
    Format := Swap(Format);
    Length := Swap(Length);
    Lang := Swap(Lang);
    SegCount2 := Swap(SegCount2);
    Range := Swap(Range);
    Selector := Swap(Selector);
    Shift := Swap(Shift);
  end;
end;

procedure Swap(var h: TCharmapSubtableRecordEntry); overload;
begin
  with h do
  begin
    Platform := Swap(Platform);
    Encoding := Swap(Encoding);
    Offset := Swap(Offset);
  end;
end;

procedure Swap(var h: TCharmapTableHeader); overload;
begin
  with h do
  begin
    Version := Swap(Version);
    NumTables := Swap(NumTables);
  end;
end;

procedure Swap(var h: TFontBox); overload;
begin
  with h do
  begin
    XMin := Swap(XMin);
    YMin := Swap(YMin);
    XMax := Swap(XMax);
    YMax := Swap(YMax);
  end;
end;

procedure Swap(var h: THeadTableHeader); overload;
begin
  with h do
  begin
    Version := Swap(Version);
    Revision := Swap(Revision);
    Checksum := Swap(Checksum);
    Signature := Swap(Signature);
    Flags := Swap(Flags);
    UnitsPerEm := Swap(UnitsPerEm);
    Created := Swap(Created);
    Modified := Swap(Modified);
    Style := Swap(Style);
    Smallest := Swap(Smallest);
    DirHint := Swap(DirHint);
    LongOffset := Swap(LongOffset);
    Format := Swap(Format);

    Swap(FontBox);
  end;
end;

procedure Swap(var h: TMaxpTableHeader); overload;
begin
  with h do
  begin
    Version := Swap(Version);
    NumGlyphs := Swap(NumGlyphs);
    MaxPoints := Swap(MaxPoints);
    MaxContours := Swap(MaxContours);
    MaxCompPts := Swap(MaxCompPts);
    MaxCompCtrs := Swap(MaxCompCtrs);
    MaxZones := Swap(MaxZones);
    MaxTwPoints := Swap(MaxTwPoints);
    MaxStorage := Swap(MaxStorage);
    MaxFunc := Swap(MaxFunc);
    MaxInst := Swap(MaxInst);
    MaxStack := Swap(MaxStack);
    MaxInstSize := Swap(MaxInstSize);
    MaxComp := Swap(MaxComp);
    MaxDepth := Swap(MaxDepth);
  end;
end;

{$Q-}

function SumNoOverflow(a, b: Cardinal): Cardinal; overload;
begin
  Result := a + b
end;

function SumNoOverflow(a, b: Word): Word; overload;
begin
  Result := (Cardinal(a) + Cardinal(b)) and $FFFF
end;
{$Q+}

function GetTableChecksum(Stream: TStream): Cardinal;
var
  a: array [0 .. 64] of Cardinal;
  i, n: Integer;
begin
  Assert(SizeOf(a[0]) = 4);
  Result := 0;

  while True do
  begin
    n := Stream.Read(a[0], SizeOf(a));

    if n = 0 then
      Exit;

    for i := 0 to n div 4 - 1 do
      Result := SumNoOverflow(Result, Swap(a[i]));

    if n mod 4 > 0 then
      Result := SumNoOverflow(Result, Swap(Cardinal(a[n div 4] and ((1 shl (8 * (n mod 4))) - 1))));
  end;
end;
/// /////////////////////////////////////////////////////////////////////////////////////

{ TfrxPDFFontView }

constructor TfrxPDFFontView.Create;
begin
  FData := TMemoryStream.Create
end;

destructor TfrxPDFFontView.Destroy;
begin
  FView.Free;
  FData.Free;
end;

procedure TfrxPDFFontView.CreateView;
begin
  FView.Free;
  FView := OpenFont(FData);
  FCollection := FView is TFontCollectionView;
end;

procedure TfrxPDFFontView.Load(Handle: HFont);
const
  ttcf = $66637474;
var
  DC: HDC;
  Tag: Cardinal;
begin
  DC := CreateDC('DISPLAY', nil, nil, nil);

  try
    SelectObject(DC, Handle);

    if GetFontData(DC, ttcf, 0, nil, 0) = GDI_ERROR { -1 } then
      Tag := 0
    else
      Tag := ttcf;

    FData.Size := GetFontData(DC, Tag, 0, nil, 0);
    GetFontData(DC, Tag, 0, FData.Memory, FData.Size);
  finally
    DeleteDC(DC);
  end;

  CreateView;
end;

procedure TfrxPDFFontView.Load(Src: TStream);
begin
  FData.Size := 0;
  FData.LoadFromStream(Src);
  CreateView;
end;

function TfrxPDFFontView.GetFontsCount: Integer;
begin
  if FCollection then
    Result := TFontCollectionView(FView).FontsCount
  else
    Result := 1
end;

function TfrxPDFFontView.GetFont(Index: Integer): TFontView;
begin
  if FCollection then
    Result := TFontCollectionView(FView).Font[Index]
  else
    Result := TFontView(FView)
end;

function TfrxPDFFontView.GetFont(Name: string): TFontView;
begin
  if FCollection then
    Result := FindFont(Name)
  else
    if TFontView(FView).FamilyName = AnsiString(Name) then
      Result := TFontView(FView)
    else
      Result := nil
end;

function TfrxPDFFontView.FindFont(Name: string): TFontView;
var
  i: Integer;
begin
  for i := 0 to GetFontsCount - 1 do
    if GetFont(i).FamilyName = AnsiString(Name) then
    begin
      Result := GetFont(i);
      Exit;
    end;

  Result := nil;
end;

{ TfrxPDFFontZZ }

constructor TfrxPDFFontZZ.Create(afrxPDFFont: TfrxPDFFont; EmbedSubset: Boolean);
var
  i: Integer;
  w: Word;
begin
  FView := TfrxPDFFontView.Create;
  FUsedChars := TBitArray.Create;
  FEmbedSubset := EmbedSubset;
  FSourceFont := TFont.Create;

  frxPDFFont := afrxPDFFont;
  FSourceFont.Assign(TfrxPDFFontAccess(frxPDFFont).SourceFont);
  Reference := frxPDFFont.Reference;
  PDFName := frxPDFFont.FontName;

  // for i := 0 to frxPDFFont.UsedAlphabetUnicode.Count - 1 do
  for i := 0 to frxPDFFont.UsedAlphabet.Count - 1 do
  begin
    // w := Word(frxPDFFont.UsedAlphabetUnicode[i]);
    w := Word(frxPDFFont.UsedAlphabet[i]);
    MarkCharAsUsed(w);
  end;

  BuildFont;
end;

destructor TfrxPDFFontZZ.Destroy;
begin
  FView.Free;
  FUsedChars.Free;
  FSourceFont.Free;
  inherited;
end;

procedure TfrxPDFFontZZ.LoadFontInfo;
begin
  Assert(IsBuilt);

  with FFontView do
  begin
    with HeadTable.Header do
    begin
      FFontInfo.FontBox := FontBox;
      FFontInfo.Flags := Flags;
    end;

    with HMetricsInfoTable.Header do
    begin
      FFontInfo.Ascent := Ascent;
      FFontInfo.Descent := Descent;
      FFontInfo.Leading := LineGap;
      FFontInfo.MaxWidth := MaxWidth;
    end;
  end;
end;

procedure TfrxPDFFontZZ.MarkCharAsUsed(Char: Word);
begin
  Assert(not IsBuilt, 'Font is already built. New chars cannot be added to it.');

  if FUsedChars.Length <= Char then
    FUsedChars.Length := Char + 1;

  FUsedChars[Char] := True;
end;

function TfrxPDFFontZZ.GetFontFile: TStream;
begin
  Assert(IsBuilt);
  Result := FFontView.Stream;
end;

procedure TfrxPDFFontZZ.BuildFont;

{$IFDEF DBGLOG}
  procedure PrintIndices(Title: string; b: TBitArray);
  var
    i, j: Integer;
  begin
    DbgPrint('%s (%d):', [Title, b.GetNumOfSetBits]);
    j := -1;

    for i := 0 to b.Length - 1 do
      if b[i] then
        if j < 0 then // new range is begun
        begin
          DbgPrint(' ' + IntToStr(i));
          j := i;
        end
        else // range is continued
          { do nothing }
        else
          if j >= 0 then // range is breaked
          begin
            if i > j + 1 then // long range is breaked
              DbgPrint('-' + IntToStr(i - 1))
            else // short range is breaked
              { do nothing };

            j := -1;
          end;

    DbgPrintln;
  end;

  procedure ProcessFont(Font: TStream; FontNameXXX: string);
  var
    Name, Path, Log: string;
  begin
    Name := string(SHA1(Font, 6));
    Path := 'fonts\' + Name + '.ttf';
    Log := 'fonts\' + Name + '.log';

    with TFileStream.Create(Path, fmCreate) do
      try
        CopyFrom(Font, 0)
      finally
        Free
      end;

    DbgPrint('font %s (%s) saved to %s'#10, [Name, FontNameXXX, Path]);
    PrintFontInfo(Font, Log);
  end;
{$ENDIF}
  function SelectFontView: TFontView;
  begin
    Result := FView.GetFont(SourceFont.Name);

    if Result = nil then
      Result := FView.GetFont(0)
  end;

  procedure EmbedFontSubset;
  var
    Builder: TFontBuilder;
    FontData: TMemoryStream;
    i: Integer;
    w: Word;
  begin

    // Builder := PackFont(FFontView, FUsedChars) as TFontBuilder;
    Builder := TFontBuilder.Create(FFontView);
    try
      for i := 0 to frxPDFFont.UsedAlphabet.Count - 1 do
        Builder.AddCharExt(Word(frxPDFFont.UsedAlphabet[i]), Word(frxPDFFont.UsedAlphabetUnicode[i]));

      FontData := TMemoryStream.Create;
      try
        Assert(Builder <> nil);
        Builder.SaveToStream(FontData);
        FView.Load(FontData);
      finally
        FontData.Free;
      end;
    finally
      Builder.Free;
    end;

    FFontView := SelectFontView;

{$IFDEF DBGLOG}
    PrintIndices('chars', FUsedChars);
{$ENDIF}
  end;

begin
  if IsBuilt then
    Exit;

{$IFDEF DBGLOG}
  if not DirectoryExists('fonts') then
    CreateDir('fonts');
{$ENDIF}
  FView.Load(SourceFont.Handle);
  FFontView := SelectFontView;

{$IFDEF DBGLOG}
  ProcessFont(FView.FData, SourceFont.Name);
{$ENDIF}
  if FEmbedSubset then
    EmbedFontSubset;

  FFontView.SelectMapping(3, 1); // Unicode BMP (UCS-2)
  LoadFontInfo;
end;

function TfrxPDFFontZZ.GetFontInfo: TfrxPDFFontInfo;
begin
  Assert(IsBuilt);
  Result := FFontInfo;
end;

function TfrxPDFFontZZ.GetFontName: AnsiString;

  function Encode(const s: AnsiString): AnsiString;
  var
    i: Integer;
  begin
    Result := '';

    for i := 1 to Length(s) do
      if Ord(s[i]) in [32 .. 126] then
      begin
        if GetCharClass(s[i]) = ccRegular then
          Result := Result + s[i]
        else
          Result := Result + '#20';
      end;
  end;

begin
  Assert(IsBuilt);

  if FFontName = '' then
  begin
    FFontName := FFontView.FamilyName;

    if FEmbedSubset then
      FFontName := GetSubsetTag + '+' + FFontName;

    with SourceFont do
    begin
      if fsBold in Style then
        FFontName := FFontName + ',Bold';

      if fsItalic in Style then
        FFontName := FFontName + ',Italic';
    end;

    FFontName := Encode(FFontName);
  end;

  Result := FFontName;
end;

{ Font subset tag is arbitrary 6 uppercase letters.
  This function constructs the tag from the SHA1 of the font. }

function TfrxPDFFontZZ.GetSubsetTag: AnsiString;
var
  h: TCryptoSHA1;
  d: array of Byte;
  i: Integer;
begin
  Assert(IsBuilt);

  if FSubsetTag = '' then
  begin
    h := TCryptoSHA1.Create;

    try
      h.Push(FontFile);
      SetLength(d, h.DigestSize);
      h.GetDigest(d[0], Length(d));
    finally
      h.Free;
    end;

    SetLength(FSubsetTag, 6);

    for i := 1 to 6 do
      FSubsetTag[i] := AnsiChar(Ord('A') + d[i] mod (Ord('Z') - Ord('A') + 1));
  end;

  Result := FSubsetTag;
end;

function TfrxPDFFontZZ.IsBuilt: Boolean;
begin
  Result := FFontView <> nil
end;

function TfrxPDFFontZZ.GetCMapName: string;
begin
  Result := 'CMap' + string(GetSubsetTag)
end;

function TfrxPDFFontZZ.GetCMapRegistry: string;
begin
  Result := 'Adobe'
end;

function TfrxPDFFontZZ.GetCMapOrdering: string;
begin
  Result := 'Identity'
end;

function TfrxPDFFontZZ.GetCMapSupplement: Integer;
begin
  Result := 0
end;

function TfrxPDFFontZZ.GetCMapType: Integer;
begin
  Result := 1
end;

procedure TfrxPDFFontZZ.SaveToStream(Stream: TStream);
begin
  Assert(IsBuilt);
  Assert(Assigned(Stream));

  Stream.CopyFrom(FFontView.Stream, 0);
end;

procedure TfrxPDFFontZZ.WriteCharToUnicodeMap(Stream: TStream);

  procedure WriteCodespace;
  begin
    Writeln(Stream, '1 begincodespacerange');
    Writeln(Stream, '<0000> <FFFF>');
    Writeln(Stream, 'endcodespacerange');
  end;

  procedure WriteMapping;
  var
    i: Integer;
  begin
    // Writeln(Stream, '1 beginbfrange');
    // Writeln(Stream, '<0000> <FFFF> <0000>');
    // Writeln(Stream, 'endbfrange');

    Write(Stream, IntToStr(frxPDFFont.UsedAlphabet.Count));
    Writeln(Stream, ' beginbfchar');
    for i := 0 to frxPDFFont.UsedAlphabet.Count - 1 do
    begin
      Write(Stream, '<');
      Write(Stream, IntToHex(Word(frxPDFFont.UsedAlphabet[i]), 4));
      Write(Stream, '> <');
      Write(Stream, IntToHex(Word(frxPDFFont.UsedAlphabetUnicode[i]), 4));
      Writeln(Stream, '>');
    end;
    Writeln(Stream, 'endbfchar');
  end;

begin
  Writeln(Stream, '/CIDInit /ProcSet findresource begin');
  Writeln(Stream, '12 dict begin');
  Writeln(Stream, 'begincmap');
  Writeln(Stream, '/CIDSystemInfo << /Registry (%s) /Ordering (%s) /Supplement %d >> def', [GetCMapRegistry, GetCMapOrdering, GetCMapSupplement]);
  Writeln(Stream, '/CMapName /%s def', [GetCMapName]);
  Writeln(Stream, '/CMapType %d def', [GetCMapType]);

  WriteCodespace;
  WriteMapping;

  Writeln(Stream, 'endcmap');
  Writeln(Stream, 'CMapName currentdict /CMap defineresource pop');
  Writeln(Stream, 'end');
  Writeln(Stream, 'end');
end;

procedure TfrxPDFFontZZ.WriteCharWidths(Stream: TStream);

  function GetWidth(g: TGlyphIndex): Extended;
  var
    AW, UPEM: Integer;
  begin
    AW := FFontView.GlyphMetrics[g].AdvWidth; // glyph width in font units
    UPEM := FFontView.HeadTable.Header.UnitsPerEm; // font units per em
    Result := 1000 * AW / UPEM;
  end;

var
  i, g: Integer;
begin
  Assert(IsBuilt);
  Write(Stream, '[ ');

  for i := 0 to FUsedChars.Length - 1 do
    if FUsedChars[i] then
    begin
      g := FFontView.GetGlyphIndex(i);
      Write(Stream, IntToStr(i) + ' [' + FormatFloat('00', GetWidth(g)) + '] ');
    end;

  Write(Stream, ']');
end;

procedure TfrxPDFFontZZ.WriteCIDSet(Stream: TStream);
type
  TSBox = array [0 .. 255] of Byte;

  function SwapBits(b: Byte): Byte;
  var
    i: Integer;
    r: Byte;
  begin
    r := 0;

    for i := 0 to 7 do
    begin
      r := r shl 1;
      r := r xor (b and 1);
      b := b shr 1;
    end;

    Result := r;
  end;

  procedure InitSBox(var SBox: TSBox);
  var
    i: Integer;
  begin
    for i := 0 to 255 do
      SBox[i] := SwapBits(i)
  end;

var
  Temp: TMemoryStream;
  b: Byte;
  SBox: TSBox;
begin
  Assert(IsBuilt);

  InitSBox(SBox);
  Temp := TMemoryStream.Create;

  try
    FUsedChars.SaveToStream(Temp);

    with Temp do
    begin
      Position := 0;

      while Read(b, 1) = 1 do
      begin
        b := SBox[b];
        Stream.WriteBuffer(b, 1);
      end;
    end;
  finally
    Temp.Free;
  end;
end;

procedure TfrxPDFFontZZ.WriteCIDToGIDMap(Stream: TStream);
var
  c, g: Word;
begin
  Assert(IsBuilt);

  for c := 0 to FUsedChars.Length - 1 do
  begin

    if FUsedChars[c] then
      g := FFontView.GetGlyphIndex(c)
    else
      g := 0;

    g := (g and $FF shl 8) or (g shr 8); // swap bytes
    Stream.WriteBuffer(g, 2);
  end;
end;

{ TFontBuilder }

constructor TFontBuilder.Create(Font: TFontView);
begin
  FFont := Font;

  FCharmap := TBtree.Create(8);
  FGRemap := TBtree.Create(8);
  FGUsed := TBtree.Create(8);

  FGUsed.Exists[Pointer(0)] := True; // use the missing glyph (aka .notdef)

{$IFDEF EMIT_CHECKSUMS}
  FCompChecksums := True;
{$ENDIF}
end;

destructor TFontBuilder.Destroy;
var
  i: Integer;
begin
  for i := 0 to High(FTables) do
    FTables[i].Free;

  FCharmap.Free;
  FGRemap.Free;
  FGUsed.Free;

  inherited;
end;

procedure TFontBuilder.AddCharExt(idx, c: Word);
var
  g: TGlyphIndex;
begin
  g := FFont.GetGlyphIndex(c);

  FCharmap[Pointer(idx)] := Pointer(g);
  FGUsed.Exists[Pointer(g)] := True;

  AddDescendantGlyphs(g);
end;

procedure TFontBuilder.AddChar(c: Word);
var
  g: TGlyphIndex;
begin
  g := FFont.GetGlyphIndex(c);

  FCharmap[Pointer(c)] := Pointer(g);
  FGUsed.Exists[Pointer(g)] := True;

  AddDescendantGlyphs(g);
end;

procedure TFontBuilder.AddCharset(Charset: TBitArray);
var
  c: Word;
begin
  for c := 0 to Charset.Length - 1 do
    if Charset[c] then
      AddChar(c)
end;

procedure TFontBuilder.CopyTableFromSrcFont(Name: TFontTableTag);
begin
  if FFont.TableExists(Name) then
    AddTable(Name, TStreamBuilder.Create(FFont.GetTable(Name).Stream))
end;

procedure TFontBuilder.AddTable(Tag: TFontTableTag; Table: TBuilder);
var
  i: Integer;
begin
  SetLength(FTags, Length(FTags) + 1);
  SetLength(FTables, Length(FTables) + 1);

  // FTags must be sorted

  i := High(FTags);

  while (i > 0) and (Tag < FTags[i - 1]) do
  begin
    FTags[i] := FTags[i - 1];
    FTables[i] := FTables[i - 1];

    Dec(i);
  end;

  FTags[i] := Tag;
  FTables[i] := Table;
end;

procedure TFontBuilder.WriteHeader(Stream: TStream);
var
  h: TFontFileHeader;
begin
  Zero(h, SizeOf(h));

  with h do
  begin
    Version := $00010000;
    NumTables := Length(FTags);
    Selector := Log2(NumTables);
    Range := 16 * (1 shl Log2(NumTables));
    Shift := 16 * NumTables - Range;
  end;

  Swap(h);
  Stream.WriteBuffer(h, SizeOf(h));
end;

procedure TFontBuilder.WriteTableRecord(Stream: TStream; Index, Offset, Len, Checksum: Cardinal);
var
  h: TTableRecordEntry;
begin
  Zero(h, SizeOf(h));

  h.Tag := FTags[Index];
  h.Offset := Offset;
  h.Length := Len;
  h.Checksum := Checksum;

  Swap(h);
  Stream.WriteBuffer(h, SizeOf(h));
end;

procedure TFontBuilder.SaveTablesToStream(Stream: TStream);

  function AlignOffset(n: Integer): Integer;
  begin
    Result := (n + 3) and not 3 // (n + 3) div 4 * 4
  end;

  procedure WriteZeros(n: Integer);
  var
    z: Byte;
  begin
    z := 0;

    for n := n downto 1 do
      Stream.WriteBuffer(z, 1);
  end;

  function ComputeChecksum(Offset, Len: Cardinal): Cardinal;
  var
    s: TStream;
  begin
    s := TProxyStream.Create(Stream, Offset, Len);

    try
      Result := GetTableChecksum(s);
    finally
      s.Free;
    end;
  end;

const
  HeaderSize = SizeOf(TFontFileHeader);
  TableRecordSize = SizeOf(TTableRecordEntry);
var
  Base, i, n: Integer;
  Offset, Len, Checksum: Cardinal;
begin
  Base := Stream.Position;
  Assert(Cardinal(Base) >= FontFileBase);
  WriteHeader(Stream);
  n := Length(FTags);

  if n = 0 then
    Exit;

  for i := 0 to n - 1 do
    WriteTableRecord(Stream, i, 0, 0, 0);

  for i := 0 to n - 1 do
  begin
    Offset := Stream.Position;
    FTables[i].SaveToStream(Stream);
    WriteZeros(AlignOffset(Stream.Position) - Stream.Position);
    Len := Stream.Position - Offset;

    if ComputeChecksums then
      Checksum := ComputeChecksum(Offset, Len)
    else
      Checksum := 0;

    Stream.Position := Base + SizeOf(TFontFileHeader) + i * SizeOf(TTableRecordEntry);
    WriteTableRecord(Stream, i, Offset - FontFileBase, Len, Checksum);
    Stream.Position := Offset + Len;
  end;
end;

procedure TFontBuilder.AddDescendantGlyphs(g: TGlyphIndex);
var
  Glyph: TCompositeGlyphView;
  i: Integer;
  Sub: TGlyphIndex;
begin
  if not FFont.Glyph[g].Composite then
    Exit;

  Glyph := FFont.Glyph[g] as TCompositeGlyphView;

  for i := 0 to Glyph.Count - 1 do
  begin
    Sub := Glyph.Component[i];

    if not FGUsed.Exists[Pointer(Sub)] then
    begin
      FGUsed.Exists[Pointer(Sub)] := True;
      AddDescendantGlyphs(Sub);
    end;
  end;
end;

procedure TFontBuilder.BuildCharsList;
var
  i: Integer;
  Keys: TList;
begin
  Keys := TList.Create;

  try
    FCharmap.GetKeysAndValues(Keys, nil);
    SetLength(FChars, Keys.Count);

    for i := 0 to Keys.Count - 1 do
      FChars[i] := Word(Keys[i])
  finally
    Keys.Free;
  end;
end;

procedure TFontBuilder.BuildGlyphsRemapping;
var
  i: Integer;
  Glyphs: TList;
begin
  Glyphs := TList.Create;

  try
    FGUsed.GetKeysAndValues(Glyphs, nil);
    SetLength(FGlyphs, Glyphs.Count);

    for i := 0 to Glyphs.Count - 1 do
    begin
      FGRemap[Glyphs[i]] := Pointer(i);
      FGlyphs[i] := TGlyphIndex(Glyphs[i]);
    end;
  finally
    Glyphs.Free;
  end;
end;

function TFontBuilder.GetUsedGlyphs: TBitArray;
var
  i: Integer;
begin
  Result := TBitArray.Create;

  if Length(FGlyphs) > 0 then
    try
      Result.Length := FGlyphs[High(FGlyphs)] + 1;

      for i := 0 to High(FGlyphs) do
        Result[RemapGlyph(FGlyphs[i])] := True
    except
      Result.Free;
      Result := nil;
    end;
end;

function TFontBuilder.MapCharToGlyph(c: Word): TGlyphIndex;
begin
  Result := TGlyphIndex(FCharmap[Pointer(c)])
end;

function TFontBuilder.RemapGlyph(g: TGlyphIndex): TGlyphIndex;
begin
  Result := TGlyphIndex(FGRemap[Pointer(g)])
end;

procedure TFontBuilder.RepackGlyphs(out Glyf, Loca: TFontTableBuilder; out LongOffsets: Boolean);

  function CreateSimpleGlyph(g: TGlyphView): TBuilder;
  begin
    Result := TStreamBuilder.Create(g.Stream);
  end;

  function CreateCompositeGlyph(g: TCompositeGlyphView): TCompositeGlyphBuilder;
  var
    i: Integer;
  begin
    Result := TCompositeGlyphBuilder.Create(g);

    for i := 0 to g.Count - 1 do
      Result.Component[i] := RemapGlyph(g.Component[i]);
  end;

var
  GlyphTable: TGlyphTableBuilder;
  PosTable: TGlyphPosTableBuilder;
  i: TGlyphIndex;
  Glyph: TGlyphView;
  PaddedLength: Cardinal;
begin
  GlyphTable := TGlyphTableBuilder.Create;
  PosTable := TGlyphPosTableBuilder.Create;

  for i := 0 to High(FGlyphs) do
  begin
    Glyph := FFont.Glyph[FGlyphs[i]];
    PaddedLength := PosTable.AddGlyph(Glyph.Stream.Size);

    if Glyph.Composite then
      GlyphTable.AddGlyph(CreateCompositeGlyph(Glyph as TCompositeGlyphView), PaddedLength)
    else
      GlyphTable.AddGlyph(CreateSimpleGlyph(Glyph), PaddedLength);
  end;

  Glyf := GlyphTable;
  Loca := PosTable;

  LongOffsets := PosTable.LongOffsets;
end;

function TFontBuilder.CreateAsciiCharmapTable(Lang: Word): TAsciiCharmapTableBuilder;
var
  i: Integer;
begin
  Result := TAsciiCharmapTableBuilder.Create(Lang);

  for i := 0 to High(FChars) do
    if (FChars[i] < 256) and (MapCharToGlyph(FChars[i]) < 256) then
      Result.GlyphIndex[FChars[i]] := RemapGlyph(MapCharToGlyph(FChars[i]));
end;

function TFontBuilder.CreateSegCharmapTable(Lang: Word): TSegCharmapTableBuilder;
var
  Segs, Glyphs: WordArray;
  i, n: Integer;
begin
  SetLength(Glyphs, Length(FChars));

  for i := 0 to High(FChars) do
    Glyphs[i] := RemapGlyph(MapCharToGlyph(FChars[i]));

  TSegCharmapTableView.FindOptimalMapping(FChars, Glyphs, Segs);
  Result := TSegCharmapTableBuilder.Create(Lang);
  n := 0;

  for i := 0 to High(Segs) do
  begin
    if (Segs[i] > 1) or (Glyphs[n] > 0) then
      Result.AddSegment(FChars[n], FChars[n + Segs[i] - 1], $FFFF and (Integer(Glyphs[n]) - Integer(FChars[n])));

    Inc(n, Segs[i]);
  end;
end;

function TFontBuilder.CreateCharmapTable: TCharmapTableBuilder;
var
  Cmap: TCharmapTableView;
  Subtable: TCharmapSubtableView;
  NewSubTable: TCharmapSubtableBuilder;
  i: Integer;
begin
  Cmap := FFont.CharmapTable;
  Result := TCharmapTableBuilder.Create;

  for i := 0 to Cmap.SubtablesCount - 1 do
  begin
    Subtable := Cmap.Subtable[i];
    NewSubTable := nil;

    case Subtable.Format of
      4:
        NewSubTable := CreateSegCharmapTable(Subtable.Language);
      0:
        NewSubTable := CreateAsciiCharmapTable(Subtable.Language);
    end;

    if NewSubTable <> nil then
      Result.AddSubtable(NewSubTable, Cmap.Platform[i], Cmap.Encoding[i]);
  end;
end;

function TFontBuilder.CreateStringTable: TStringTableBuilder;
var
  i: Integer;
  View: TStringTableView;
begin
  View := FFont.StringsTable;
  Result := TStringTableBuilder.Create;

  for i := 0 to View.Count - 1 do
    with View.Entry[i] do
      if (Id in [1 .. 4]) and ((Language = $409) or (Language = 0)) then
        Result.AddString(View[i], Platform, Encoding, Language, Id);
end;

function TFontBuilder.CreateMetricsTable(View: TMetricsTableView): TMetricsTableBuilder;
var
  i: Integer;
begin
  Assert(Cardinal(Length(FGlyphs)) <= View.Count);
  Result := TMetricsTableBuilder.Create;

  for i := 0 to High(FGlyphs) do
    Result.AddMetric(View.Dim[FGlyphs[i]], View.SB[FGlyphs[i]]);
end;

function TFontBuilder.CreateHeadTable(LongOffsets: Boolean): TBuilder;
var
  h: THeadTableHeader;
  s: TStreamBuilder;
begin
  h := FFont.HeadTable.Header;

  if LongOffsets then
    h.LongOffset := 1
  else
    h.LongOffset := 0;

  Swap(h);

  s := TStreamBuilder.CreateWithStream;
  s.Stream.WriteBuffer(h, SizeOf(h));

  Result := s;
end;

function TFontBuilder.CreateMaxpTable(NumGlyphs: Word): TBuilder;
var
  h: TMaxpTableHeader;
  s: TStreamBuilder;
begin
  h := FFont.MaxpTable.Header;
  h.NumGlyphs := NumGlyphs;
  Swap(h);

  s := TStreamBuilder.CreateWithStream;
  s.Stream.WriteBuffer(h, SizeOf(h));

  Result := s;
end;

function TFontBuilder.CreateMetricsInfoTable(View: TMetricsInfoTableView; NumMetrics: Word): TBuilder;
var
  h: TMetricsTableHeader;
  s: TStreamBuilder;
begin
  h := View.Header;
  h.NumMetrics := NumMetrics;
  Swap(h);

  s := TStreamBuilder.CreateWithStream;
  s.Stream.WriteBuffer(h, SizeOf(h));

  Result := s;
end;

procedure TFontBuilder.SaveToStream(Stream: TStream);
var
  LongOffsets: Boolean;
  Glyf, Loca: TFontTableBuilder;
  NumGlyphs: Word;
begin
  BuildCharsList;
  BuildGlyphsRemapping;

  NumGlyphs := Length(FGlyphs);
  RepackGlyphs(Glyf, Loca, LongOffsets);

  AddTable('glyf', Glyf);
  AddTable('loca', Loca);
  AddTable('cmap', CreateCharmapTable);
  AddTable('head', CreateHeadTable(LongOffsets));
  AddTable('maxp', CreateMaxpTable(NumGlyphs));
  AddTable('name', CreateStringTable);
  AddTable('hmtx', CreateMetricsTable(FFont.HMetricsTable));
  AddTable('hhea', CreateMetricsInfoTable(FFont.HMetricsInfoTable, NumGlyphs));

  if FFont.TableExists('vmtx') then
    AddTable('vmtx', CreateMetricsTable(FFont.VMetricsTable));

  if FFont.TableExists('vhea') then
    AddTable('hhea', CreateMetricsInfoTable(FFont.VMetricsInfoTable, NumGlyphs));

  CopyTableFromSrcFont('fpgm');
  CopyTableFromSrcFont('prep');
  CopyTableFromSrcFont('cvt ');

  SaveTablesToStream(Stream);
end;

{ TSegCharmapTableView }

procedure TSegCharmapTableView.Init;
var
  h: TSegCharmapTableHeader;
  ts: Integer;
begin
  inherited;

  Check(Size >= SizeOf(h));
  h := GetHeader;
  CheckHeader(h);

  FSegNum := h.SegCount2 div 2;
  Check(Size >= SizeOf(h) + 2 + 2 * 4 * Cardinal(FSegNum));

  ts := Integer(Size) - (SizeOf(h) + 2 + 2 * 4 * FSegNum);

{$IFDEF EXTENSIVE_CHECKS}
  Check(ts mod 2 = 0);
{$ENDIF}
  FGlyphNum := ts div 2;
end;

procedure TSegCharmapTableView.Accept(v: TVisitor);
begin
  v.Visit(Self)
end;

procedure TSegCharmapTableView.CheckHeader(const h: TSegCharmapTableHeader);
begin
  with h do
  begin
{$IFDEF EXTENSIVE_CHECKS}
    Check(Format = 4);
    Check(SegCount2 mod 2 = 0);
    Check(Range = 2 * (1 shl Log2(SegCount2 div 2)));
    Check(Selector = Log2(SegCount2 div 2));
    Check(Shift = SegCount2 - Range);
    Check(Length >= SizeOf(h));
{$ENDIF}
  end;
end;

function TSegCharmapTableView.GetHeader: TSegCharmapTableHeader;
begin
  Stream.Position := 0;
  Stream.ReadBuffer(Result, SizeOf(Result));
  Swap(Result);
end;

function TSegCharmapTableView.GetFirst(i: Integer): Word;
begin
  Check((i >= 0) and (i < FSegNum));
  Result := GetWord(FFirst, i, 2 + FSegNum * 2 + i * 2);
end;

function TSegCharmapTableView.GetLast(i: Integer): Word;
begin
  Check((i >= 0) and (i < FSegNum));
  Result := GetWord(FLast, i, i * 2);
end;

function TSegCharmapTableView.GetDelta(i: Integer): Word;
begin
  Check((i >= 0) and (i < FSegNum));
  Result := GetWord(FDelta, i, 2 + 2 * FSegNum * 2 + i * 2);
end;

function TSegCharmapTableView.GetOffset(i: Integer): Word;
begin
  Check((i >= 0) and (i < FSegNum));
  Result := GetWord(FOffset, i, 2 + 3 * FSegNum * 2 + i * 2);
end;

function TSegCharmapTableView.GetGlyph(i: Integer): Word;
begin
  Check((i >= 0) and (i < FGlyphNum));
  Result := ReadWord(2 + 4 * FSegNum * 2 + i * 2);
end;

function TSegCharmapTableView.GetWord(var w: WordArray; i: Integer; p: Cardinal): Word;
var
  n: Integer;
begin
  if i > High(w) then
  begin
    n := Length(w);
    SetLength(w, i + 9); // i + 1 is enough, but i + 9 reduces memory reallocations
    FillChar(w[n], 2 * (Length(w) - n), $11);
  end;

  if w[i] = $1111 then
    w[i] := ReadWord(p);

  Result := w[i];
end;

function TSegCharmapTableView.ReadWord(Offset: Cardinal): Word;
begin
  Stream.Position := SizeOf(TSegCharmapTableHeader) + Offset;
  Stream.ReadBuffer(Result, 2);
  Result := Swap(Result);
end;

function TSegCharmapTableView.GetLanguage: Word;
begin
  Result := GetHeader.Lang
end;

function TSegCharmapTableView.GetGlyphIndex(Char: Word): TGlyphIndex;

  function GetIndex(i: Integer; out g: TGlyphIndex): Integer;
  begin
    if Char < First[i] then
      Result := -1
    else
      if Char > Last[i] then
        Result := +1
      else
      begin
{$IFDEF EXTENSIVE_CHECKS}
        Check(Offset[i] mod 2 = 0);
{$ENDIF}
        if Offset[i] = 0 then
          g := SumNoOverflow(Delta[i], Char)
        else
          g := Glyph[Offset[i] div 2 + i - SegCount + (Char - First[i])];

        Result := 0;
      end;
  end;

var
  i, j, m: Integer;
begin
  Result := 0;
  i := 0;
  j := SegCount - 1;

  while i <= j do
  begin
    m := i + (j - i) div 2;

    case GetIndex(m, Result) of
      - 1:
        j := m - 1;
      +1:
        i := m + 1;

    else
      Break;
    end;
  end;
end;

class function TSegCharmapTableView.FindOptimalMapping(const Chars, Glyphs: WordArray; out Seg: WordArray): Word;
var
  Size: array of Word; // Size[i] = optimal size for Chars[0]..Chars[i]
  Len: array of Word; // Len[i] = length of a segment ending on Chars[i]

  function Delta(i: Integer): Integer;
  begin
    Result := Integer(Chars[i]) - Integer(Glyphs[i])
  end;

{ Returns size of one segment that covers Chars[First]..Chars[Last] chars.
  If these chars cannot be covered by one segment, -1 is returned. }

  function GetSize(First, Last: Integer): Integer;
  var
    i: Integer;
  begin
    Result := -1;

    { todo -cOptimisation: A better mapping can be done.
      This function is aware about only one segments kind - segments
      that operate as the shift operator: GID = CID + Delta.
      However, there's another segments kind - segments that
      perform arbitrary mapping: GID = Map[CID]. This kind
      of segments is not currently supported by charmap builders,
      that's why this function is aware only about one kind of segments. }

    for i := First + 1 to Last do
      if Delta(i) <> Delta(i - 1) then
        Exit;

    if (First = Last) and (Glyphs[First] = 0) then
      Result := 0
    else
      Result := 8
  end;

{ Finds optimal mapping for Chars[0]..Chars[i] }

  procedure Find(Last: Integer);
  var
    i, iOpt: Integer;
    sOpt, sTest: Integer;
  begin
    iOpt := Last;
    sOpt := GetSize(0, Last);

    // try segments 0..i and i+1..Last

    for i := Last - 1 downto 0 do
    begin
      sTest := GetSize(i + 1, Last);

      // if a the segment is invalid, then it's useless to extend it
      if sTest < 0 then
        Break;

      if (sTest >= 0) and ((sOpt < 0) or (Size[i] + sTest < sOpt)) then
      begin
        sOpt := Size[i] + sTest;
        iOpt := i;
      end;
    end;

    // i = Last-1 must give a positive sOpt
    Assert(sOpt >= 0);

    Size[Last] := Word(sOpt);

    if iOpt < Last then
      Len[Last] := Last - iOpt
    else
      Len[Last] := Last + 1
  end;

{ Finds the number of segments from the Len array }

  function GetSegCount: Integer;
  var
    i: Integer;
  begin
    Result := 0;
    i := Length(Len) - 1;

    while i >= 0 do
    begin
      Inc(Result);
      Dec(i, Len[i]);
    end;
  end;

{ Finds segment lengths Seg from the Len array }

  procedure GetLayout;
  var
    i, s: Integer;
  begin
    SetLength(Seg, GetSegCount);

    i := Length(Len) - 1;
    s := Length(Seg) - 1;

    while i >= 0 do
    begin
      Seg[s] := Len[i];
      Dec(s);
      Dec(i, Len[i]);
    end;
  end;

  function GetLayoutSize: Word;
  var
    i, s: Integer;
    n: Word;
  begin
    n := 0;
    Result := 0;

    for i := 0 to High(Seg) do
    begin
      s := GetSize(n, n + Seg[i] - 1);
      Assert(s >= 0);
      Inc(Result, Word(s));
      Inc(n, Seg[i]);
    end;
  end;

  function SumSeg: Word;
  var
    i: Integer;
  begin
    Result := 0;

    for i := 0 to High(Seg) do
      Inc(Result, Seg[i]);
  end;

var
  i: Integer;
begin
  Assert(Length(Chars) = Length(Glyphs));

  SetLength(Size, Length(Chars));
  SetLength(Len, Length(Chars));

  // if there's only one char, it's covered by one segment

  Size[0] := Word(GetSize(0, 0));
  Len[0] := 1;

  for i := 1 to Length(Size) - 1 do
    Find(i);

  // get explicit segments layout

  GetLayout;

  Assert(Size[High(Size)] = GetLayoutSize);
  Assert(SumSeg = Length(Chars));

  // now Seg[i] contains length of i-th segment and
  // Size[High(Size)] tells how many bytes is needed for this layout

  Result := Size[High(Size)];
end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////

procedure WriteFont(frxPDFFont: TfrxPDFFont; FPOH: TPDFObjectsHelper; pdf: TStream; const Compressed: Boolean; EncKey: String);
var
  pdfFont: TfrxPDFFontZZ;

  procedure BeginObj(Stream: TStream; ObjId: Integer; ObjGen: Integer = 0);
  begin
    Writeln(Stream, IntToStr(ObjId) + ' ' + IntToStr(ObjGen) + ' obj')
  end;

  procedure EndObj(Stream: TStream);
  begin
    Writeln(Stream, 'endobj');
  end;

  procedure BeginStream(Res: TStream);
  begin
    Write(Res, 'stream'#13#10); // 'stream'#10 is also valid
  end;

  procedure EndStream(Res: TStream);
  begin
    Write(Res, #13#10'endstream'#13#10);
  end;

  function WriteDataStream(Res, Src: TStream; const Ext: string; IsText: Boolean): Integer;
    procedure WriteStreamHeader(Data: TStream; Options: TfrxPDFBinaryStreamOptions);
    begin
      Write(Res, '<< ');
      Write(Res, '/Length %d ', [Data.Size]);
      Write(Res, '/Length1 %d ', [Src.Size]);

      if Options <> [] then
      begin
        Write(Res, '/Filter [ ');

        if bsoHexEncode in Options then
          Write(Res, '/ASCIIHexDecode ');

        if bsoCompress in Options then
          Write(Res, '/FlateDecode ');

        Write(Res, '] ');
      end;

      Writeln(Res, '>>');
    end;

    procedure EncryptStream(Data: TStream; Id: Integer);
    var
      s: TStream;
    begin
      s := TMemoryStream.Create;

      try
        CryptStream(Data, s, EncKey, Id);
        Data.Size := 0;
        Data.CopyFrom(s, 0);
      finally
        s.Free;
      end;
    end;

    procedure CompressStream(Data: TStream);
    var
      Temp: TStream;
    begin
      Temp := TMemoryStream.Create;

      try
        Temp.CopyFrom(Data, 0);
        Data.Size := 0;
        frxDeflateStream(Temp, Data, gzFastest);
      finally
        Temp.Free;
      end;
    end;

    procedure HexEncodeStream(Data: TStream);
    var
      Hex: THexEncoder;
      Splitter: TLineSplitter;
      Temp: TStream;
    begin
      Splitter := TLineSplitter.Create(Data, 120);
      Hex := THexEncoder.Create(Splitter);
      Temp := TMemoryStream.Create;

      try
        Temp.CopyFrom(Data, 0);
        Data.Size := 0;
        Hex.CopyFrom(Temp, 0);
      finally
        Hex.Free;
        Splitter.Free;
        Temp.Free;
      end;
    end;

    function GetBinaryStreamOptions: TfrxPDFBinaryStreamOptions;
    begin
      Result := [];

      if Compressed then
        Result := Result + [bsoCompress];

      if not EncKey.IsEmpty then
        Result := Result + [bsoEncrypt];
    end;

  var
    Data: TStream;
    Options: TfrxPDFBinaryStreamOptions;
  begin
    Options := GetBinaryStreamOptions;

    // {$IFNDEF DEBUG}   // Why debug was here?
    if not IsText then
      Options := Options + [bsoCompress];

    if not(bsoEncrypt in Options) then
      if not(IsText or (bsoCompress in Options)) then
        Options := Options + [bsoHexEncode];
    // {$ENDIF}

    Result := FPOH.UpdateXRef;
    BeginObj(Res, Result);

    Data := TMemoryStream.Create;
    try
      Data.CopyFrom(Src, 0);

      if bsoCompress in Options then
        CompressStream(Data);

      if bsoEncrypt in Options then
        EncryptStream(Data, Result);

      if bsoHexEncode in Options then
        HexEncodeStream(Data);

      WriteStreamHeader(Data, Options);
      BeginStream(Res);
      Res.CopyFrom(Data, 0);
      EndStream(Res);
    finally
      Data.Free;
      EndObj(Res);
    end;
  end;

{ Writes an object with the font file inside }
  function WriteFontFile: Integer;
  var
    tmp: TStream;
  begin
    tmp := TMemoryStream.Create;
    try
      tmp.CopyFrom(pdfFont.FontFile, 0);
      Result := WriteDataStream(pdf, tmp, 'ttf', False);
    finally
      tmp.Free;
    end;
  end;

{ Writes FontDescriptor }
  function WriteFontDescriptor(CIDSetId: Integer): Integer;
  var
    fontFileId: Integer;
  begin
    fontFileId := 0; // to suppress W1036 compiler warning

    if FPOH.EmbeddedFonts then
      fontFileId := WriteFontFile;

    Result := FPOH.UpdateXRef;
    BeginObj(pdf, Result);

    Writeln(pdf, '<<');
    Writeln(pdf, '/Type /FontDescriptor');
    Writeln(pdf, '/FontName /' + pdfFont.FontName);
    // Writeln(pdf, '/FontName ' + pdfFont.PdfName); // tolto uno slash
    Writeln(pdf, '/FontFamily /' + pdfFont.FontName);

    with pdfFont.FontInfo do
    begin
      with FontBox do
        Writeln(pdf, '/FontBBox [%d %d %d %d]', [XMin, YMin, XMax, YMax]);

      Writeln(pdf, '/ItalicAngle %d', [ItalicAngle]);
      Writeln(pdf, '/Ascent %d', [Ascent]);
      Writeln(pdf, '/Descent %d', [Descent]);
      Writeln(pdf, '/CapHeight %d', [CapHeight]);
      Writeln(pdf, '/StemV %d', [StemV]);
      Writeln(pdf, '/Flags %d', [32]);
    end;

    Writeln(pdf, '/CIDSet %s', [ObjNumberRef(CIDSetId)]);

    if FPOH.EmbeddedFonts then
      Writeln(pdf, '/FontFile2 ' + ObjNumberRef(fontFileId));

    Writeln(pdf, '>>');
    EndObj(pdf);
  end;

{ Writes CIDSystemInfo }
  function WriteCIDSystemInfo: Integer;
  begin
    Result := FPOH.UpdateXRef;
    BeginObj(pdf, Result);
    Writeln(pdf, '<< /Registry (%s) /Ordering (%s) /Supplement %d >>', [pdfFont.CMapRegistry, pdfFont.CMapOrdering, pdfFont.CMapSupplement]);
    EndObj(pdf);
  end;

{ Writes CID to GID mapping }
  function WriteCIDToGID: Integer;
  var
    Map: TStream;
  begin
    Map := TMemoryStream.Create;
    try
      pdfFont.WriteCIDToGIDMap(Map);
      Result := WriteDataStream(pdf, Map, 'cidtogid', False);
    finally
      Map.Free;
    end;
  end;

{ Writes CIDFontType2 }
  function WriteDescendantFonts(cIDSystemInfoId, descriptorId: Integer): Integer;
  var
    CIDToGIDMapId: Integer;
  begin
    CIDToGIDMapId := WriteCIDToGID;

    Result := FPOH.UpdateXRef;
    BeginObj(pdf, Result);

    Writeln(pdf, '<<');
    Writeln(pdf, '/Type /Font');
    Writeln(pdf, '/Subtype /CIDFontType2');
    // Writeln(pdf, '/CIDToGIDMap /Identity');
    Writeln(pdf, '/CIDToGIDMap %s', [ObjNumberRef(CIDToGIDMapId)]);
    Writeln(pdf, '/BaseFont /' + pdfFont.FontName);
    Writeln(pdf, '/CIDSystemInfo ' + ObjNumberRef(cIDSystemInfoId));
    Writeln(pdf, '/FontDescriptor ' + ObjNumberRef(descriptorId));

    Write(pdf, '/W ');
    pdfFont.WriteCharWidths(pdf);
    Writeln(pdf, '');

    Writeln(pdf, '>>');
    EndObj(pdf);
  end;

{ Writes char to unicode map }
  function WriteUnicodeMap: Integer;
  var
    Cmap: TStream;
  begin
    Cmap := TMemoryStream.Create;
    try
      pdfFont.WriteCharToUnicodeMap(Cmap);
      Result := WriteDataStream(pdf, Cmap, 'cmap', True);
    finally
      Cmap.Free;
    end;
  end;

// Writes a bitmask of used CIDs
  function WriteCIDSet: Integer;
  var
    Stream: TStream;
  begin
    Stream := TMemoryStream.Create;
    try
      pdfFont.WriteCIDSet(Stream);
      Result := WriteDataStream(pdf, Stream, 'cidset', False);
    finally
      Stream.Free;
    end;
  end;

var
  // CMapId: Integer;
  descendantFontId: Integer;
  cIDSystemInfoId: Integer;
  FontDescriptorId: Integer;
  UnicodeMapId: Integer;
  CIDSetId: Integer;
  i: Integer;
  s: string;
  wc: WideChar;
begin

  pdfFont := TfrxPDFFontZZ.Create(frxPDFFont, FPOH.EmbeddedFonts);
  try
    // CMapId := WriteCMap;
    CIDSetId := WriteCIDSet;
    UnicodeMapId := WriteUnicodeMap;
    cIDSystemInfoId := WriteCIDSystemInfo;
    FontDescriptorId := WriteFontDescriptor(CIDSetId);
    descendantFontId := WriteDescendantFonts(cIDSystemInfoId, FontDescriptorId);

    // FPOH.XRef[pdfFont.Reference - 1] := PrepXrefPos(pdf.Position);
    FPOH.UpdateXRef;
    Writeln(pdf, ObjNumber(pdfFont.Reference));
    Writeln(pdf, '<<');
    Writeln(pdf, '/Type /Font');
    Writeln(pdf, '/Subtype /Type0');
    Writeln(pdf, '/BaseFont /%s', [pdfFont.FontName]); // tolto slash
    // WriteLn(pdf, '/Encoding %s', [ObjNumberRef(CMapId)]);
    Writeln(pdf, '/Encoding /Identity-H % char to CID');
    Writeln(pdf, '/DescendantFonts [' + ObjNumberRef(descendantFontId) + ']');
    Writeln(pdf, '/ToUnicode %s', [ObjNumberRef(UnicodeMapId)]);
    Writeln(pdf, '>>');
    EndObj(pdf);
  finally
    pdfFont.Free;
  end;
end;

end.
