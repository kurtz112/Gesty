unit HelpGen.HelpCompiler;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Types,
  System.IOUtils,
  System.Generics.Collections,
  System.Generics.Defaults,

  // DevExpress
  dxRichEdit.DocumentServer,
  dxRichEdit.NativeApi,
  dxRichEdit.Types,
  dxRichEdit.HTML,
  dxRichEdit.OpenXML,
  dxRichEdit.DOC,

  dxRichEdit.Options,
  dxRichEdit.Control,
  dxRichEdit.Control.SpellChecker,

  dxRichEdit.Platform.Win.Control,
  dxRichEdit.Control.Core,
  //
  SmartInspect.VCL.SiAuto,
  SmartInspect.VCL;

type
  THelpGenCompiler = class
  private
    FProjectName: string;
    FTitle: string;
    FDefaultTopic: string;
    FLanguage: string;
    FRoot: string;
    FFolderDocs: string;
    FHtmlRoot: string;
    FFolderOutput: string;
    FHyperLinksFileName: string;
    FDuplicatiFileName: string;
    FBlackListFileName: string;
    FWhitelistFileName: string;
    procedure SetRoot(const Value: string);
  private
    HyperLinks: TDictionary<string, string>; // keyword -> filename
    Duplicati: TStringList;
    BlackList: TStringList;
    Titles: TStringList;
    FlogProc: TProc<string>;
    DocServer: TdxRichEditDocumentServer;
    FFolderConfig: string;
    FTitlesFileName: string;
  private
    procedure LoadTitles;
    procedure LoadBlackList;
    procedure LoadHyperLinks;
    procedure SaveHyperLinks;
    procedure SaveDuplicati;
    procedure SaveTitles;
  private
    procedure Log(const msg: string);
  private
    function isParagraphStyle(Paragraph: IdxRichEditParagraph; Style: String): boolean;
    function ParagraphText(Document: IdxRichEditDocument; Paragraph: IdxRichEditParagraph): string;
    function ExtractTitle(Document: IdxRichEditDocument): string;
  private
    function GetTopicId(const FileName: string): string;
    function GetTitle(const FileName: string): string;
    function GetFilesDOCX: TArray<string>;
  private
    procedure AddHyperLink(const keyword, FileName: String);
    procedure GenerateHHP;
    procedure GenerateHHC;
    procedure GenerateHHK;

    procedure PreparaCartellaHTML;
    function CalcolaNomeFileHTML(const NomeFileDOCX: string): String;
    function HyperlinkRelativo(const srcFile, FileNameDOCX: string): string;
    procedure PostElaborazioneHTML(const FileName: String);
    procedure SetFolderDocs(const Value: string);
  public
    constructor Create(const aFolderDocs, aHelpRoot: string);
    destructor Destroy; override;

    procedure GenerateFilesHyperlink;
    procedure GenerateFilesHTML;
    procedure GenerateFilesCHM;
    procedure CompileCHM;
    procedure DeployCHM;
  public
    property logProc: TProc<string> read FlogProc write FlogProc;
  public
    property ProjectName: string read FProjectName write FProjectName;
    property Title: string read FTitle write FTitle;
    property DefaultTopic: string read FDefaultTopic write FDefaultTopic;
    property Language: string read FLanguage write FLanguage;
  public
    property Root: string read FRoot write SetRoot;
    property FolderDocs: string read FFolderDocs write SetFolderDocs;
    property FolderHtml: string read FHtmlRoot;
    property FolderOutput: string read FFolderOutput;
    property FolderConfig: string read FFolderConfig;

    property HyperLinksFileName: string read FHyperLinksFileName;
    property DuplicatiFileName: string read FDuplicatiFileName;
    property WhitelistFileName: string read FWhitelistFileName;
    property BlackListFileName: string read FBlackListFileName;
    property TitlesFileName: string read FTitlesFileName;
  end;

implementation

uses
  Winapi.ShellAPI,
  zMsg;

constructor THelpGenCompiler.Create(const aFolderDocs, aHelpRoot: string);
begin
  SiMain.EnterMethod('Create');
  inherited Create;

  FlogProc := nil;
  FProjectName := '';
  FTitle := '';
  FDefaultTopic := '';
  FLanguage := '0x410 Italian (Italy)';

  Root := aHelpRoot;
  FolderDocs := aFolderDocs;

  Titles := TStringList.Create;
  BlackList := TStringList.Create;
  { TODO : Implementare }
  // Indexes := TDictionary<string, string>.Create; // keyword -> filename
  HyperLinks := TDictionary<string, string>.Create; // keyword -> filename
  Duplicati := TStringList.Create;

  DocServer := TdxRichEditDocumentServer.Create(nil);

  LoadBlackList;
  LoadHyperLinks;

  SiMain.LeaveMethod('Create');
end;

destructor THelpGenCompiler.Destroy;
begin
  SiMain.EnterMethod('Done');
  inherited;

  FreeAndNil(Titles);
  FreeAndNil(BlackList);
  { TODO : Implementare }
  // FreeAndNil(Indexes);
  FreeAndNil(HyperLinks);
  FreeAndNil(Duplicati);

  FreeAndNil(DocServer);

  SiMain.LeaveMethod('Done');
end;

procedure THelpGenCompiler.Log(const msg: string);
begin
  SiMain.logVerbose(msg);

  if assigned(FlogProc) then
    logProc(msg);
end;

function THelpGenCompiler.GetFilesDOCX: TArray<string>;
begin
  result := TDirectory.GetFiles(IncludeTrailingPathDelimiter(FolderDocs), '*.docx', TSearchOption.soAllDirectories,
    function(const Path: string; const SearchRec: TSearchRec): boolean
    var
      folder: string;
    begin
      folder := TPath.GetFileName(Path);
      result := not folder.StartsWith('_');
    end);
end;

function THelpGenCompiler.GetTitle(const FileName: string): string;
begin
  result := Titles.Values[GetTopicId(FileName)];

  if result.IsEmpty then
    result := TPath.GetFileNameWithoutExtension(FileName);
end;

function THelpGenCompiler.GetTopicId(const FileName: string): string;
begin
  result := TPath.GetFileNameWithoutExtension(FileName).ToLower;
end;

procedure THelpGenCompiler.AddHyperLink(const keyword, FileName: String);
var
  key, Value: string;
  first: string;
begin
  key := keyword.ToLower.trim;
  Value := FileName;

  if not BlackList.Contains(key) then
  begin

    if not HyperLinks.ContainsKey(key) then
      HyperLinks.Add(key, Value)
    else
    begin
      // duplicati
      HyperLinks.TryGetValue(key, first);

      if not Duplicati.Contains(key + '=' + first) then
        Duplicati.AddPair(key, first);

      if not Duplicati.Contains(key + '=' + Value) then
        Duplicati.AddPair(key, Value);
    end;
  end;
end;

procedure THelpGenCompiler.SetRoot(const Value: string);
begin
  SiMain.EnterMethod('SetRoot');

  FRoot := IncludeTrailingPathDelimiter(Value);
  FFolderOutput := IncludeTrailingPathDelimiter(Root + 'Output');
  FHtmlRoot := IncludeTrailingPathDelimiter(FolderOutput + 'pages');
  FFolderConfig := IncludeTrailingPathDelimiter(Root + '__config');

  FHyperLinksFileName := FolderConfig + 'HyperLinks.txt';
  FDuplicatiFileName := FolderConfig + 'Duplicati.txt';
  FWhitelistFileName := FolderConfig + 'HyperLinks_Whitelist.txt';
  FBlackListFileName := FolderConfig + 'HyperLinks_BlackList.txt';
  FTitlesFileName := FolderConfig + 'PageTitles.txt';

  ForceDirectories(FolderOutput);
  ForceDirectories(FolderConfig);

  SiMain.LeaveMethod('SetRoot');
end;

procedure THelpGenCompiler.SetFolderDocs(const Value: string);
begin
  FFolderDocs := IncludeTrailingPathDelimiter(Value);
end;

function THelpGenCompiler.isParagraphStyle(Paragraph: IdxRichEditParagraph; Style: String): boolean;
begin
  result := Paragraph.Style.Name.ToLower.Equals(Style.ToLower);
end;

function THelpGenCompiler.ParagraphText(Document: IdxRichEditDocument; Paragraph: IdxRichEditParagraph): string;
var
  Range: IdxRichEditDocumentRange;
begin
  Range := Paragraph.Range;
  result := Document.GetText(Range);
  result := result.trim;
end;

function THelpGenCompiler.ExtractTitle(Document: IdxRichEditDocument): string;
var
  i: Integer;
  Paragraph: IdxRichEditParagraph;
begin
  result := '';

  for i := 0 to Document.Paragraphs.Count - 1 do
  begin
    Paragraph := Document.Paragraphs.Self[i];

    if isParagraphStyle(Paragraph, 'title') then
    begin
      result := ParagraphText(Document, Paragraph);
      exit;
    end;
  end;
end;

procedure THelpGenCompiler.LoadBlackList;
begin

  if TFile.Exists(BlackListFileName) then
  begin
    BlackList.LoadFromFile(BlackListFileName);
    BlackList.Sort;
  end;
end;

procedure THelpGenCompiler.LoadHyperLinks;

  procedure load(const FileName: string);
  var
    i: Integer;
    k, v: string;
    StringList: TStringList;
  begin
    if not TFile.Exists(FileName) then
      exit;

    StringList := TStringList.Create;
    try
      StringList.LoadFromFile(FileName);

      for i := 0 to StringList.Count - 1 do
        if not StringList.Names[i].trim.IsEmpty then
          HyperLinks.AddOrSetValue(StringList.Names[i].trim, StringList.ValueFromIndex[i].trim);
    finally
      FreeAndNil(StringList);
    end;
  end;

begin
  HyperLinks.clear;

  load(WhitelistFileName);
  load(HyperLinksFileName);
end;

procedure THelpGenCompiler.SaveHyperLinks;
var
  StringList: TStringList;
  hyperLink: TPair<string, string>;
begin
  StringList := TStringList.Create;
  try
    for hyperLink in HyperLinks do
      StringList.AddPair(hyperLink.key, hyperLink.Value);

    StringList.Sort;
    StringList.SaveToFile(HyperLinksFileName);
  finally
    FreeAndNil(StringList);
  end;
end;

procedure THelpGenCompiler.SaveDuplicati;
begin
  Duplicati.Sort;
  Duplicati.SaveToFile(DuplicatiFileName);
end;

procedure THelpGenCompiler.GenerateFilesHyperlink;
var
  Files: TStringDynArray;
  FileName: string;
  Document: IdxRichEditDocument;
  Paragraphs: IdxRichEditParagraphCollection;
  i: Integer;
  Paragraph: IdxRichEditParagraph;
  keyword: string;
begin
  LoadBlackList;
  LoadHyperLinks;
  Duplicati.clear;
  Titles.clear;

  if not TDirectory.Exists(Root) then
    exit;

  Files := GetFilesDOCX;

  for FileName in Files do
  begin
    DocServer.LoadDocument(FileName);
    Document := DocServer.Document;
    Paragraphs := Document.Paragraphs;

    for i := 0 to Document.Paragraphs.Count - 1 do
    begin
      Paragraph := Paragraphs.Self[i];

      if not isParagraphStyle(Paragraph, 'title') then
        continue;

      keyword := ParagraphText(Document, Paragraph);

      if not keyword.IsEmpty then
      begin
        AddHyperLink(keyword, FileName);

        Titles.AddPair(GetTopicId(FileName), keyword);
      end;
    end;
  end;

  DocServer.CreateNewDocument;

  SaveHyperLinks;
  SaveDuplicati;
  SaveTitles;
end;

procedure THelpGenCompiler.GenerateFilesHTML;
var
  SearchOptions: TdxRichEditSearchOptions;
  FileNameDOCX: string;
  FileNameHTML: string;
  Document: IdxRichEditDocument;
  FoundRanges: TArray<IdxRichEditDocumentRange>;
  Range: IdxRichEditDocumentRange;
  Paragraph: IdxRichEditParagraph;
  RichEditHyperlink: IdxRichEditHyperlink;
  hyperLink: TPair<string, string>;
begin
  Log('GenerateFilesHTML');

  PreparaCartellaHTML;

  GenerateFilesHyperlink;

  if HyperLinks.Count = 0 then
    Log('Nessuna keyword caricata.');

  SearchOptions := [TdxRichEditSearchOption.WholeWord];

  /// /////////////////////////

  for FileNameDOCX in GetFilesDOCX do
  begin
    Log(FileNameDOCX);

    FileNameHTML := CalcolaNomeFileHTML(FileNameDOCX);

    DocServer.LoadDocument(FileNameDOCX);
    Document := DocServer.Document;

    Document.BeginUpdate;
    try

      // Per ogni keyword
      for hyperLink in HyperLinks do
      begin
        // Salta self-link
        if SameText(hyperLink.Value, FileNameDOCX) then
          continue;

        // Cerca la keyword nel testo
        FoundRanges := Document.FindAll(hyperLink.key, SearchOptions, nil);

        for Range in FoundRanges do
        begin
          Paragraph := Document.Paragraphs.Get(Range.Start);

          if not isParagraphStyle(Paragraph, 'normal') then
            continue;

          if Document.HyperLinks.Get(Range).Count <> 0 then // Verifica che non sia già hyperlink
            continue;

          RichEditHyperlink := Document.HyperLinks.CreateHyperlink(Range);
          // RichEditHyperlink.NavigateUri := ChangeFileExt(hyperLink.Value, '.html');
          RichEditHyperlink.NavigateUri := HyperlinkRelativo(FileNameDOCX, hyperLink.Value);
          RichEditHyperlink.ToolTip := 'Vai a: ' + hyperLink.key;
        end; // for ranges
      end; // for keywords
    finally
      Document.EndUpdate;
    end;

    ForceDirectories(ExtractFilePath(FileNameHTML));
    DocServer.SaveDocument(FileNameHTML, TdxRichEditDocumentFormat.HTML);
    PostElaborazioneHTML(FileNameHTML);
    DocServer.CreateNewDocument;
  end;
end;

procedure THelpGenCompiler.GenerateFilesCHM;
begin
  GenerateFilesHTML;
  GenerateHHP;
  GenerateHHC;
  GenerateHHK;
end;

function THelpGenCompiler.CalcolaNomeFileHTML(const NomeFileDOCX: string): String;
begin
  result := IncludeTrailingBackslash(FolderHtml) + ExtractRelativePath(FolderDocs, NomeFileDOCX);
  result := ChangeFileExt(result, '.html');
end;

procedure THelpGenCompiler.CompileCHM;
const
  HHC = '"C:\Program Files (x86)\HTML Help Workshop\hhc.exe"';
var
  HHPFile: string;
begin
  HHPFile := TPath.Combine(FolderOutput, FProjectName + '.hhp');

  // Esegui il compilatore HTML Help
  // hhc.exe restituisce 1 in caso di successo (strano ma vero)
  ShellExecute(0, 'open', HHC, PChar(HHPFile), PChar(FolderOutput), SW_SHOWNORMAL);
end;

procedure THelpGenCompiler.GenerateHHC;

  function FolderTitle(const folder: string): string;
  begin
    result := GetTitle(ExtractFileName(folder));
  end;

  procedure GenerateHHC(const StartDir: string; Output: TStrings; const Level: Integer = 0);
  var
    Dir: string;
    FileName: string;
    RelativePath: string;
    Indent: string;
    dirTitle: string;
  begin
    Indent := StringOfChar(' ', Level * 2);

    // 1. Scansione Sottocartelle (che diventano "Book" o cartelle nell'HHC)
    for Dir in TDirectory.GetDirectories(StartDir) do
    begin
      Output.Add(Indent + '<LI> <OBJECT type="text/sitemap">');
      Output.Add(Indent + '  <param name="Name" value="' + FolderTitle(Dir) + '">');
      Output.Add(Indent + '  <param name="ImageNumber" value="1">');
      Output.Add(Indent + '  </OBJECT>');

      Output.Add(Indent + '<UL>');
      GenerateHHC(Dir, Output, Level + 1); // Ricorsione
      Output.Add(Indent + '</UL>');
      Output.Add(Indent + '</LI>');
    end;

    // 2. Scansione File HTML (che diventano i "Topic")
    if StartDir <> FolderHtml then
      for FileName in TDirectory.GetFiles(StartDir, '*.html') do
      begin
        Output.Add(Indent + '<LI> <OBJECT type="text/sitemap">');
        Output.Add(Indent + '  <param name="Name" value="' + GetTitle(FileName) + '">');
        Output.Add(Indent + '  <param name="Local" value="' + ExtractRelativePath(ExcludeTrailingPathDelimiter(FolderHtml), FileName) + '">');
        Output.Add(Indent + '  </OBJECT>');
        Output.Add(Indent + '</LI>');
      end;
  end;

var
  SL: TStringList;
begin
  Log('GenerateHHC');
  LoadTitles;

  SL := TStringList.Create;
  try
    // Header standard richiesto da HTML Help Workshop
    SL.Add('<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//IT">');
    SL.Add('<HTML><HEAD></HEAD><BODY>');
    SL.Add('<OBJECT type="text/site properties">');
    SL.Add('  <param name="ImageType" value="Folder">');
    SL.Add('</OBJECT>');
    SL.Add('<UL>');

    SL.Add('<LI> <OBJECT type="text/sitemap">');
    SL.Add('  <param name="Name" value="Indice">');
    SL.Add('  <param name="Local" value="pages/index.html">');
    SL.Add('  </OBJECT> </LI>');

    GenerateHHC(FolderHtml, SL);

    SL.Add('</UL></BODY></HTML>');

    // Salva con encoding ANSI (importante per il vecchio compilatore HHW)
    SL.SaveToFile(TPath.Combine(FolderOutput, FProjectName + '.hhc'), TEncoding.ANSI);
  finally
    SL.Free;
  end;
end;

procedure THelpGenCompiler.GenerateHHK;
var
  SL: TStringList;
  Files: TStringDynArray;
  FileName: string;

begin
  Log('GenerateHHK');

  Files := TDirectory.GetFiles(IncludeTrailingBackslash(FolderHtml), '*.html', TSearchOption.soAllDirectories);
  TArray.Sort<string>(Files);

  SL := TStringList.Create;
  try
    // Genera HHK
    SL.Add('<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">');
    SL.Add('<HTML>');
    SL.Add('<BODY>');
    SL.Add('<UL>');

    for FileName in Files do
    begin
      // SL.Add(ExtractRelativePath(ExcludeTrailingPathDelimiter(FolderHtml), FileName));
      SL.Add('   <LI> <OBJECT type="text/sitemap">');
      SL.Add('      <param name="Name" value="' + GetTitle(FileName) + '">');
      SL.Add('      <param name="Local" value="' + ExtractRelativePath(ExcludeTrailingPathDelimiter(FolderHtml), FileName) + '">');
      SL.Add('   </OBJECT></LI>');
    end;

    SL.Add('</UL>');
    SL.Add('</BODY>');
    SL.Add('</HTML>');

    SL.SaveToFile(TPath.Combine(FolderOutput, FProjectName + '.hhk'), TEncoding.ANSI);
  finally
    FreeAndNil(SL);
  end;
end;

procedure THelpGenCompiler.GenerateHHP;
var
  SL: TStringList;
  Files: TStringDynArray;
  FileName: string;
begin
  Log('GenerateHHP');

  Files := TDirectory.GetFiles(IncludeTrailingBackslash(FolderHtml), '*.html', TSearchOption.soAllDirectories);
  TArray.Sort<string>(Files);

  SL := TStringList.Create;
  try
    // Sezione OPTIONS
    SL.Add('[OPTIONS]');
    SL.Add('Compatibility=1.1 or later');
    SL.Add('Compiled file=' + FProjectName + '.chm');
    SL.Add('Contents file=' + FProjectName + '.hhc');
    SL.Add('Index file=' + FProjectName + '.hhk');
    SL.Add('Default topic=pages\' + FDefaultTopic);
    SL.Add('Display compile progress=Yes');
    SL.Add('Full-text search=Yes');
    SL.Add('Language=' + FLanguage);
    SL.Add('Title=' + FTitle);
    SL.Add('');

    // Sezione FILES
    SL.Add('[FILES]');

    for FileName in Files do
      SL.Add(ExtractRelativePath(ExcludeTrailingPathDelimiter(FolderHtml), FileName));

    SL.Add('');
    // Sezione INFOTYPES (opzionale)
    SL.Add('[INFOTYPES]');

    SL.SaveToFile(TPath.Combine(FolderOutput, FProjectName + '.hhp'), TEncoding.ANSI);
  finally
    FreeAndNil(SL);
  end;
end;

procedure THelpGenCompiler.LoadTitles;
begin

  if TFile.Exists(TitlesFileName) then
  begin
    Titles.LoadFromFile(TitlesFileName);
    Titles.Sort;
  end;
end;

procedure THelpGenCompiler.PostElaborazioneHTML(const FileName: String);
const
  meta = sLineBreak + '<meta http-equiv="X-UA-Compatible" content="IE=edge">';

  // HEADER
  HeaderHtml01 = '<div id="gesty-header" style="display: flex; align-items: center; padding: 10px; border-bottom: 2px solid #7cb142; margin-bottom: 20px; font-family: ''Segoe UI'', Roboto, Helvetica, Arial, sans-serif;">';
  HeaderHtml02 = '    <div style="height: 1.5em; width: 1.5em; margin-right: 8px; display: flex; align-items: center; justify-content: center;">';
  HeaderHtml03 = '        <svg viewBox="0 0 512 512" version="1.1" xmlns="http://www.w3.org/2000/svg" style="height: 100%; width: 100%; display: block;">';
  HeaderHtml04 = '            <g>';
  HeaderHtml05 =
    '                <path d="M463.95,0c81.8,167.5 7.2,448 -224,448c-40.9,0 -79.3,-14.9 -109.65,-39.55c-12.55,24.1 -24.1,52.8 -34.3,87.55c-6.9,11.1 -22.95,16.1 -37.2,13.85c-14.3,-2.25 -26.85,-11.8 -26.85,-29.85c19.85,-45.35 41.2,-80.6 63.6,-108.9c-19.8,-28.4 -31.6,-62.6 -31.6,-99.1c0,-256 312,-120.2 400,-272z" fill="#7cb142"/>';
  HeaderHtml06 =
    '                <path d="M431.6,128.6c0.15,-0.2 0.25,-0.4 0.35,-0.6c19.35,-34.1 32,-75.5 31.95,-128c81.8,167.5 7.2,448 -224,448c-40.9,0 -79.2,-14.9 -109.6,-39.5c-12.55,24.1 -24.05,52.8 -34.25,87.5c-6.95,11.1 -22.95,16.1 -37.2,13.85c0,0 1.7,-7.3 5.15,-21.85c95.9,-263.7 255.65,-184.2 367.6,-359.4z" fill="#689d38"/>';
  HeaderHtml07 = '            </g>';
  HeaderHtml08 = '        </svg>';
  HeaderHtml09 = '    </div>';
  HeaderHtml10 = '    <span style="font-size: 1.5em; font-weight: bold; color: #7cb142; line-height: 1; display: flex; align-items: center;">Gesty</span>';
  HeaderHtml11 = '</div>';

  // FOOTER
  FooterHtml1 = '<div id="gesty-footer" style="margin-top: 40px; padding: 15px 10px; border-top: 2px solid #7cb142; font-family: ''Segoe UI'', Roboto, Helvetica, Arial, sans-serif; font-size: 0.9em; color: #555; text-align: center;">';
  FooterHtml2 = '  <p style="margin: 5px 0;">&copy; 2026 Luca Zebro. Tutti i diritti riservati.</p>';
  FooterHtml3 = '  <p style="margin: 5px 0;"><a href="www.zebro.it/gesty" style="color: #689d38; text-decoration: none; font-weight: 500;">www.zebro.it/gesty</a></p>';
  FooterHtml4 = '</div>';

var
  content: string;
  idx: Integer;
  Header, Footer: string;
begin
  content := TFile.ReadAllText(FileName, TEncoding.UTF8);

  idx := Pos('<head>', content.ToLower);
  if idx > 0 then
    Insert(meta, content, idx + 6);

  // Cerchiamo la posizione del tag <body>
  idx := Pos('<body', content.ToLower);
  if idx > 0 then
  begin
    idx := Pos('>', content, idx); // chiusura del tag > di <body> (potrebbe avere attributi)
    Header := '';
    Header := Header + sLineBreak + HeaderHtml01;
    Header := Header + sLineBreak + HeaderHtml02;
    Header := Header + sLineBreak + HeaderHtml03;
    Header := Header + sLineBreak + HeaderHtml04;
    Header := Header + sLineBreak + HeaderHtml05;
    Header := Header + sLineBreak + HeaderHtml06;
    Header := Header + sLineBreak + HeaderHtml07;
    Header := Header + sLineBreak + HeaderHtml08;
    Header := Header + sLineBreak + HeaderHtml09;
    Header := Header + sLineBreak + HeaderHtml10;
    Header := Header + sLineBreak + HeaderHtml11;

    Insert(Header, content, idx + 1);
  end;

  // Cerchiamo la posizione di chiusura </body>
  idx := Pos('</body>', content.ToLower);
  if idx > 0 then
  begin
    Footer := '';
    Footer := Footer + sLineBreak + FooterHtml1;
    Footer := Footer + sLineBreak + FooterHtml2;
    Footer := Footer + sLineBreak + FooterHtml3;
    Footer := Footer + sLineBreak + FooterHtml4;

    Insert(Footer, content, idx);
  end;

  TFile.WriteAllText(FileName, content, TEncoding.UTF8);
end;

procedure THelpGenCompiler.SaveTitles;
begin
  Titles.Sort;
  Titles.SaveToFile(TitlesFileName);
end;

function THelpGenCompiler.HyperlinkRelativo(const srcFile, FileNameDOCX: string): string;
var
  FileName: string;
begin
  FileName := ExtractFileName(FileNameDOCX);

  result := ExtractRelativePath(IncludeTrailingPathDelimiter(ExtractFilePath(srcFile)), IncludeTrailingPathDelimiter(ExtractFilePath(FileNameDOCX)));
  result := IncludeTrailingPathDelimiter(result) + FileName;
  result := ChangeFileExt(result, '.html');

  result := StringReplace(result, '\', '/', [rfReplaceAll]);
end;

procedure THelpGenCompiler.PreparaCartellaHTML;
var
  srcFile: string;
  destFile: string;
begin

  if TDirectory.Exists(FolderHtml) then
    TDirectory.Delete(FolderHtml, True);

  TDirectory.CreateDirectory(FolderHtml);

  srcFile := TPath.Combine(FolderConfig, 'index.html');
  destFile := TPath.Combine(FolderHtml, TPath.GetFileName(srcFile));

  TFile.Copy(srcFile, destFile, True);
end;

procedure THelpGenCompiler.DeployCHM;
var
  srcFileName: string;
  destFileName: string;
begin
  srcFileName := FolderOutput + ProjectName + '.chm';
  destFileName := TPath.ChangeExtension(ParamStr(0), '.chm');

  TFile.Copy(srcFileName, destFileName, true);
end;

end.
