unit GestyTools.Script.Editor;

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
  ComCtrls,
  ExtCtrls,
  ImgList,
  SynEdit,
  ActnMan,
  ToolWin,
  Grids,
  StdCtrls,
  SynCompletionProposal,
  SynEditTypes,
  SynEditHighlighter,
  Menus,
  StdActns,
  ActnList,
  SynEditOptionsDialog,
  SynEditMiscClasses,
  SynEditRegexSearch,
  SynHighlighterPas,
  fs_ipascal,
  fs_iinterpreter,
  fs_iclassesrtti,
  fs_igraphicsrtti,
  fs_iformsrtti,
  fs_iextctrlsrtti,
  fs_idialogsrtti,
  fs_imenusrtti,
  fs_iinirtti,
  fs_iadortti,
  fs_idbrtti,
  fs_idbctrlsrtti,
  fs_ichartrtti,
  fs_tree,
  dxSkinsCore,
  dxSkinsDefaultPainters,
  cxControls,
  cxSplitter,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  dxBar,
  cxClasses,
  dxStatusBar,
  SynEditCodeFolding,
  System.Actions,
  System.ImageList,
  cxImageList,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxMemo;

type
  TScriptEditor = class(TForm)
    CompletionProposal: TSynCompletionProposal;
    Splitter1: TcxSplitter;
    MemoLog: TcxMemo;
    ParamProposal: TSynCompletionProposal;
    Editor: TSynEdit;
    actTaglia: TEditCut;
    actCopia: TEditCopy;
    actIncolla: TEditPaste;
    actSelezionaTutto: TEditSelectAll;
    actAnnulla: TEditUndo;
    actElimina: TEditDelete;
    SynEditOptionsDialog: TSynEditOptionsDialog;
    actTrova: TAction;
    actSostituisci: TAction;
    EditorImageList: TcxImageList;
    ActionList: TActionList;
    actRipristina: TAction;
    CaricaDalFile: TFileOpen;
    SalvaSuFile: TFileSaveAs;
    OpizioniEditor: TAction;
    PanelEditor: TPanel;
    FindDialog: TFindDialog;
    ReplaceDialog: TReplaceDialog;
    SynEditRegexSearch: TSynEditRegexSearch;
    DuplicaLinea: TAction;
    Maiuscolo: TAction;
    Minuscolo: TAction;
    CompletionImageList: TcxImageList;
    SynPasSyn: TSynPasSyn;
    actRun: TAction;
    actCompile: TAction;
    actColori: TAction;
    actFormatta: TAction;
    actCommenta: TAction;
    actDecommenta: TAction;
    Libreria: TAction;
    dxBarManager: TdxBarManager;
    dxbrbtnPrepara: TdxBarButton;
    StatusBar: TdxStatusBar;
    PopupMenu: TdxBarPopupMenu;
    Annulla1: TdxBarButton;
    Ripristina1: TdxBarButton;
    Cut1: TdxBarButton;
    Copy1: TdxBarButton;
    Paste1: TdxBarButton;
    Elimina1: TdxBarButton;
    SelectAll1: TdxBarButton;
    DuplicaLinea1: TdxBarButton;
    Maiuscolo1: TdxBarButton;
    Minuscolo1: TdxBarButton;
    Formatta1: TdxBarButton;
    Commenta1: TdxBarButton;
    Decommenta1: TdxBarButton;
    Find1: TdxBarButton;
    Searchagain1: TdxBarButton;
    CaricadaFile1: TdxBarButton;
    SalvasuFile1: TdxBarButton;
    ColoriEditor1: TdxBarButton;
    EditorOptions1: TdxBarButton;
    dxBarManagerBar1: TdxBar;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarButton10: TdxBarButton;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    dxBarButton13: TdxBarButton;
    dxBarButton14: TdxBarButton;
    dxBarButton15: TdxBarButton;
    dxBarButton16: TdxBarButton;
    dxBarButton17: TdxBarButton;
    dxBarButton18: TdxBarButton;
    Step: TAction;
    Watch: TAction;
    dxBarButton19: TdxBarButton;
    dxBarButton20: TdxBarButton;
    dxStatusBar: TdxStatusBar;
    Reset: TAction;
    dxBarButton21: TdxBarButton;
    procedure actColoriExecute(Sender: TObject);
    procedure actCommentaExecute(Sender: TObject);
    procedure actCompileExecute(Sender: TObject);
    procedure actDecommentaExecute(Sender: TObject);
    procedure actFormattaExecute(Sender: TObject);
    procedure actRipristinaExecute(Sender: TObject);
    procedure EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure OpizioniEditorExecute(Sender: TObject);
    procedure actRipristinaUpdate(Sender: TObject);
    procedure actRunExecute(Sender: TObject);
    procedure CaricaDalFileBeforeExecute(Sender: TObject);
    procedure CaricaDalFileAccept(Sender: TObject);
    procedure SalvaSuFileAccept(Sender: TObject);
    procedure actTrovaExecute(Sender: TObject);
    procedure actSostituisciExecute(Sender: TObject);
    procedure CompletionProposalExecute(Kind: SynCompletionType; Sender: TObject; var CurrentInput: string; var x, y: Integer; var CanExecute: Boolean);
    procedure DoFindText(Sender: TObject);
    procedure DoReplaceText(Sender: TObject);
    procedure SalvaSuFileBeforeExecute(Sender: TObject);
    procedure EditorChange(Sender: TObject);
    procedure DuplicaLineaExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure LibreriaExecute(Sender: TObject);
    procedure MaiuscoloExecute(Sender: TObject);
    procedure MinuscoloExecute(Sender: TObject);
    procedure ParamProposalExecute(Kind: SynCompletionType; Sender: TObject; var CurrentInput: string; var x, y: Integer; var CanExecute: Boolean);
    procedure ResetExecute(Sender: TObject);
    procedure ResetUpdate(Sender: TObject);
    procedure StepExecute(Sender: TObject);
    procedure WatchExecute(Sender: TObject);
  private
    FOnChange: TNotifyEvent;
    function GetScript: string;
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure SetScript(const Value: string);
    procedure MostraLibreria(Visibile: Boolean);
    procedure SetEditorPos(SourcePos: String);
  private
    procedure LogMessage(const s: String);
  private
    Running: Boolean;
    Stopped: Boolean;
    procedure fsScriptRunLine(Sender: TfsScript; const UnitName, SourcePos: String);
  protected
    FilesDefaultExt: string;
    FilesFilter: string;
    fsTree: TfsTree;
    SplitterTree: TcxSplitter;
    procedure PreparaListaIdentificatori(ItemList, InsertList: TStrings);
    procedure doRun(const singleLine: Boolean);
    function doCompile: Boolean;
    function FormatItem(const Icon: Integer; const Color: TColor; const ItemClass, ItemName, ItemParams: string): string;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    property Script: string read GetScript write SetScript;
  published
    property OnChange: TNotifyEvent read FOnChange write SetOnChange;
  end;

var
  ScriptEditor: TScriptEditor;

implementation

uses
  System.StrUtils,
  System.Variants,
  System.DateUtils,
  fs_itools,
  SynEditKeyCmds,
  GestyTools.Log,
  GestyTools.Connection,
  GestyTools.Script,
  GestyTools.Script.Editor.ColorDialog,
  GestyTools.Script.Editor.Evalute, zMsg;

{$R *.dfm}

constructor TScriptEditor.Create(aOwner: TComponent);
begin
  inherited;
  Running := false;
  Stopped := false;
  fsTree := nil;
  SplitterTree := nil;
  FOnChange := nil;
  Editor.Highlighter := SynPasSyn;
  CompletionProposal.Images := CompletionImageList;
  ParamProposal.Images := CompletionImageList;
  FilesDefaultExt := '*.pas';
  FilesFilter := 'Pascal|*.pas|Tutti|*.*';
  MostraLibreria(false);

  CaricaDalFile.Dialog.InitialDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'scripts';
  SalvaSuFile.Dialog.InitialDir := CaricaDalFile.Dialog.InitialDir;

  __WriteLog := Procedure(s: string)
    begin
      LogMessage(s);
    end;
end;

destructor TScriptEditor.Destroy;
begin
  inherited;

  if assigned(ScriptModule) then
    ScriptModule.fsScript.OnRunLine := nil;
end;

procedure TScriptEditor.SetEditorPos(SourcePos: String);
var
  pt: TPoint;
begin
  pt := fsPosToPoint(SourcePos);

  Editor.CaretX := pt.x;
  Editor.CaretY := pt.y;

  Editor.SelLength := 0;
  Editor.ExecuteCommand(ecSelLineEnd, #0, nil);
end;

procedure TScriptEditor.actColoriExecute(Sender: TObject);
begin
  SynColorDialogExecute(Editor);
end;

procedure TScriptEditor.actCommentaExecute(Sender: TObject);
var
  str: TStringList;
  I: Integer;
begin
  if Editor.SelText <> '' then
  begin
    str := TStringList.Create;
    try
      str.Text := Editor.SelText;
      for I := 0 to str.Count - 1 do
        str[I] := '// ' + str[I];
      Editor.SelText := str.Text;
    finally
      FreeAndNil(str);
    end;

  end
  else
    Editor.LineText := '// ' + Editor.LineText;
end;

procedure TScriptEditor.actCompileExecute(Sender: TObject);
begin
  doCompile;
end;

procedure TScriptEditor.actDecommentaExecute(Sender: TObject);
var
  str: TStringList;
  I: Integer;
begin
  if Editor.SelText <> '' then
  begin
    str := TStringList.Create;
    try
      str.Text := Editor.SelText;
      for I := 0 to str.Count - 1 do
        str[I] := StringReplace(str[I], '//', '', []);
      Editor.SelText := str.Text;
    finally
      FreeAndNil(str);
    end;

  end
  else
    Editor.LineText := StringReplace(Editor.LineText, '//', '', []);
end;

procedure TScriptEditor.actFormattaExecute(Sender: TObject);
// var
// Converter: TConverter;
begin
  // Converter := TConverter.Create;
  // try
  // Converter.InputCode := Editor.Text;
  // Converter.Convert;
  // if not Converter.ConvertError then
  // Editor.Text := Converter.OutputCode;
  // finally
  // FreeAndNil(Converter);
  // end;
end;

procedure TScriptEditor.actRipristinaUpdate(Sender: TObject);
begin
  actRipristina.Enabled := Editor.CanRedo;
end;

procedure TScriptEditor.actRipristinaExecute(Sender: TObject);
begin
  if Editor.CanRedo then
    Editor.Redo;
end;

procedure TScriptEditor.EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
const
  Modi: array [Boolean] of string[10] = ('', 'Modified');
  Modes: array [Boolean] of string[10] = ('Overwrite', 'Insert');
begin
  StatusBar.Panels[0].Text := IntToStr(Editor.CaretY) + ':' + IntToStr(Editor.CaretX);
  StatusBar.Panels[1].Text := Modi[Editor.Modified];
  if Editor.ReadOnly then
    StatusBar.Panels[2].Text := 'ReadOnly'
  else
    StatusBar.Panels[2].Text := Modes[Editor.InsertMode];
end;

procedure TScriptEditor.OpizioniEditorExecute(Sender: TObject);
var
  SynEditorOptionsContainer: TSynEditorOptionsContainer;
begin
  SynEditorOptionsContainer := TSynEditorOptionsContainer.Create(Self);
  try
    SynEditorOptionsContainer.Assign(Editor);
    if SynEditOptionsDialog.Execute(SynEditorOptionsContainer) then
      SynEditorOptionsContainer.AssignTo(Editor);
  finally
    FreeAndNil(SynEditorOptionsContainer);
  end;
end;

procedure TScriptEditor.CaricaDalFileBeforeExecute(Sender: TObject);
begin
  if Editor.Modified then
    if not ConfirmYesNo('Il testo è stato variato.' + #13 + #10 + 'Continuare perdendo le modifiche?', mtWarning) then
      SysUtils.Abort;

  CaricaDalFile.Dialog.DefaultExt := FilesDefaultExt;
  CaricaDalFile.Dialog.Filter := FilesFilter;
end;

procedure TScriptEditor.CaricaDalFileAccept(Sender: TObject);
begin
  Editor.lines.LoadFromFile(CaricaDalFile.Dialog.FileName);
  Editor.Modified := false;
end;

procedure TScriptEditor.SalvaSuFileAccept(Sender: TObject);
begin
  Editor.lines.SaveToFile(SalvaSuFile.Dialog.FileName);
  Editor.Modified := false;
end;

procedure TScriptEditor.actTrovaExecute(Sender: TObject);
begin
  if Editor.SelText <> '' then
    FindDialog.FindText := Editor.SelText
  else
    FindDialog.FindText := Editor.WordAtCursor;

  FindDialog.Execute;
end;

procedure TScriptEditor.actSostituisciExecute(Sender: TObject);
begin
  if Editor.SelText <> '' then
    ReplaceDialog.FindText := Editor.SelText
  else
    ReplaceDialog.FindText := Editor.WordAtCursor;

  ReplaceDialog.Execute;
end;

procedure TScriptEditor.DoFindText(Sender: TObject);
var
  rOptions: TSynSearchOptions;
  dlg: TFindDialog;
  sSearch: string;
begin
  if Sender = ReplaceDialog then
    dlg := ReplaceDialog
  else
    dlg := FindDialog;
  sSearch := dlg.FindText;
  if Length(sSearch) = 0 then
  begin
    Beep;
  end
  else
  begin
    rOptions := [];
    if not(frDown in dlg.Options) then
      Include(rOptions, ssoBackwards);
    if frMatchCase in dlg.Options then
      Include(rOptions, ssoMatchCase);
    if frWholeWord in dlg.Options then
      Include(rOptions, ssoWholeWord);
    if Editor.SearchReplace(sSearch, '', rOptions) = 0 then
    begin
      Beep;
    end;
  end;
end;

procedure TScriptEditor.DoReplaceText(Sender: TObject);
var
  rOptions: TSynSearchOptions;
  sSearch: string;
begin
  sSearch := ReplaceDialog.FindText;
  if Length(sSearch) = 0 then
  begin
    Beep;
  end
  else
  begin
    rOptions := [ssoReplace];
    if frMatchCase in ReplaceDialog.Options then
      Include(rOptions, ssoMatchCase);
    if frWholeWord in ReplaceDialog.Options then
      Include(rOptions, ssoWholeWord);
    if frReplaceAll in ReplaceDialog.Options then
      Include(rOptions, ssoReplaceAll);
    if Editor.SearchReplace(sSearch, ReplaceDialog.ReplaceText, rOptions) = 0 then
    begin
      Beep;
    end;
  end;
end;

function TScriptEditor.FormatItem(const Icon: Integer; const Color: TColor; const ItemClass: string; const ItemName: string; const ItemParams: string): string;
const
  FormatStr = '\image{%d} \color{$%x} %s \color{clBlack} \style{+B}%s\style{-B}%s';
begin
  result := format(FormatStr, [Icon, Color, ItemClass, ItemName, ItemParams]);
end;

procedure TScriptEditor.SalvaSuFileBeforeExecute(Sender: TObject);
begin
  SalvaSuFile.Dialog.DefaultExt := FilesDefaultExt;
  SalvaSuFile.Dialog.Filter := FilesFilter;
end;

procedure TScriptEditor.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TScriptEditor.EditorChange(Sender: TObject);
begin
  if assigned(FOnChange) then
  begin
    try
      OnChange(Sender);
    except
      on E: Exception do
        ApplicationShowException(E);
    end;
  end
end;

procedure TScriptEditor.DuplicaLineaExecute(Sender: TObject);
begin
  if Editor.CaretY > 0 then
    Editor.lines.Insert(Editor.CaretY, Editor.lines[Editor.CaretY - 1]);
end;

procedure TScriptEditor.MaiuscoloExecute(Sender: TObject);
var
  oldSelStart: Integer;
  oldSelLength: Integer;
begin
  if Editor.SelText = '' then
    Editor.Text := UpperCase(Editor.Text)
  else
  begin
    oldSelStart := Editor.SelStart;
    oldSelLength := Editor.SelLength;
    Editor.SelText := UpperCase(Editor.SelText);
    Editor.SelStart := oldSelStart;
    Editor.SelLength := oldSelLength;
  end;
end;

procedure TScriptEditor.MinuscoloExecute(Sender: TObject);
var
  oldSelStart: Integer;
  oldSelLength: Integer;
begin
  if Editor.SelText = '' then
    Editor.Text := LowerCase(Editor.Text)
  else
  begin
    oldSelStart := Editor.SelStart;
    oldSelLength := Editor.SelLength;
    Editor.SelText := LowerCase(Editor.SelText);
    Editor.SelStart := oldSelStart;
    Editor.SelLength := oldSelLength;
  end;
end;

procedure TScriptEditor.CompletionProposalExecute(Kind: SynCompletionType; Sender: TObject; var CurrentInput: string; var x, y: Integer; var CanExecute: Boolean);
var
  ItemList, InsertList: TStringList;
begin
  ItemList := TStringList.Create;
  try
    InsertList := TStringList.Create;
    try
      PreparaListaIdentificatori(ItemList, InsertList);
      CompletionProposal.ItemList.Assign(ItemList);
      CompletionProposal.InsertList.Assign(InsertList);
    finally
      FreeAndNil(InsertList);
    end;
  finally
    FreeAndNil(ItemList);
  end;
end;

function TScriptEditor.GetScript: string;
begin
  result := Editor.Text;
end;

procedure TScriptEditor.LibreriaExecute(Sender: TObject);
begin
  MostraLibreria(Libreria.Checked);
end;

procedure TScriptEditor.ParamProposalExecute(Kind: SynCompletionType; Sender: TObject; var CurrentInput: string; var x, y: Integer; var CanExecute: Boolean);
var
  locline, lookup: string;
  TmpX, savepos, StartX, ParenCounter, TmpLocation: Integer;
  FoundMatch: Boolean;
  c: Integer;
begin
  locline := Editor.Text;

  if locline = '' then
    Exit;

  TmpX := 0;
  for c := 0 to Editor.CaretY - 2 do
    TmpX := TmpX + Length(Editor.lines[c]) + 2; // crlf
  TmpX := TmpX + Editor.CaretX - 1;

  FoundMatch := false;
  TmpLocation := 0;

  if (Editor.CaretX > 1) then
    while (TmpX > 0) and not(FoundMatch) do
    begin
      if locline[TmpX] = ',' then
      begin
        inc(TmpLocation);
        dec(TmpX);
      end
      else
        if locline[TmpX] = ')' then
        begin
          // We found a close, go till it's opening paren
          ParenCounter := 1;
          dec(TmpX);
          while (TmpX > 0) and (ParenCounter > 0) do
          begin
            if locline[TmpX] = ')' then
              inc(ParenCounter)
            else
              if locline[TmpX] = '(' then
                dec(ParenCounter);
            dec(TmpX);
          end;
          if TmpX > 0 then
            dec(TmpX); // eat the open paren
        end
        else
          if locline[TmpX] = '(' then
          begin
            // we have a valid open paren, lets see what the word before it is
            StartX := TmpX;
            while (TmpX > 0) and not Editor.IsIdentChar(locline[TmpX]) do
              dec(TmpX);
            if TmpX > 0 then
            begin
              savepos := TmpX;
              while (TmpX > 0) and not Editor.IsIdentChar(locline[TmpX]) do
                dec(TmpX);
              inc(TmpX);
              lookup := Copy(locline, TmpX, savepos - TmpX + 1);
              FoundMatch := True; // GetMetaTable; // LookupList.IndexOf(Lookup) > -1;
              if not(FoundMatch) then
              begin
                TmpX := StartX;
                dec(TmpX);
              end;
            end;
          end
          else
            dec(TmpX);

      CanExecute := FoundMatch;
      if CanExecute then
        ParamProposal.Form.CurrentIndex := TmpLocation;
    end;
end;

procedure TScriptEditor.PreparaListaIdentificatori(ItemList, InsertList: TStrings);

  function GetDotPos: Integer;
  var
    I: Integer;
    xy: TBufferCoord;
  begin
    result := -1;

    if Editor.CaretX = 0 then
      Exit;

    if Editor.Text = '' then
      Exit;

    for I := Editor.CaretX downto 1 do
    begin
      xy.Char := I;
      xy.Line := Editor.CaretXY.Line;

      case UpCase(Editor.Text[Editor.RowColToCharIndex(xy)]) of
        '.':
          Exit(I - 2);
        ' ':
          Exit(-1);
      end;
    end;
  end;

  function GetLeftWord: string;
  var
    I: Integer;
    xy: TBufferCoord;
  begin
    result := '';
    I := GetDotPos;

    xy := Editor.CaretXY;
    xy.Char := I;

    result := Editor.GetWordAtRowCol(xy);
  end;

var
  I: Integer;
  s: string;
  Params: string;
  j: Integer;
  Token: string;
  cv: TfsClassVariable;
  insStr: string;
  insFull: string;
  coloredStr: string;
  cName: string;
  ancestor: string;
  xy: TBufferCoord;
  cVar: TfsCustomVariable;
  TypeName: string;
begin
  ItemList.Clear;
  InsertList.Clear;

  Token := GetLeftWord;

  if Token <> '' then
  begin // dopo il '.'

    ScriptModule.CompileScript(Editor.lines.Text);

    cVar := ScriptModule.fsScript.Find(Token);

    if assigned(cVar) then
      TypeName := cVar.TypeName;

    cv := ScriptModule.fsScript.FindClass(TypeName);

    if assigned(cv) then
    begin
      while (cv.ancestor <> EmptyStr) or (cv.Name = 'TObject') do
      begin
        // get parent class
        ancestor := cv.ancestor;
        // loop for members
        for I := 0 to cv.MembersCount - 1 do
        begin
          insStr := EmptyStr;
          insFull := EmptyStr;
          coloredStr := EmptyStr;
          // use regular expression to create colors
          // the colors are used to pointer the type of member
          // use Members.Typ to get type.
          case cv.Members[I].Typ of
            fvtClass:
              coloredStr := '\color{clblack}\style{+B}';
            fvtArray:
              coloredStr := '\color{clgreen}';
            fvtEnum:
              coloredStr := '\color{clHighlight}';
            fvtConstructor:
              coloredStr := '\color{clred}\style{+B}';
          else
            coloredStr := '\color{clblack}';
          end;
          // if not in upon
          // check need result or not
          // the needed member set to navy
          if (coloredStr = '\color{clblack}') and (cv.Members[I].NeedResult) then
            coloredStr := '\color{clnavy}';
          // if contains params
          if cv.Members[I].Count > 0 then
          begin
            insStr := cv.Members[I].Name;
            insFull := cv.Members[I].Name + '(';
            for j := 0 to cv.Members[I].Count - 1 do
            begin
              // add param name and type to member line.
              insFull := insFull + cv.Members[I].Params[j].Name + ': ' + cv.Members[I].Params[j].TypeName;
              // if is not the last param
              // add comma behind
              if j < cv.Members[I].Count - 1 then
              begin
                insFull := insFull + '; ';
              end;
            end;
            insFull := insFull + ')';
            // use colored member line
            coloredStr := coloredStr + insFull;
          end
          else
          begin
            // if has no param
            insStr := cv.Members[I].Name;
            coloredStr := coloredStr + insStr;
          end;
          // if member line not exists
          // add it to popup list
          if InsertList.IndexOf(insStr) = -1 then
          begin
            InsertList.add(insStr);
            ItemList.add(coloredStr);
          end;
        end;
        // find parant class
        cv := ScriptModule.fsScript.FindClass(ancestor);
        if cv = nil then
          Break;
      end;
    end;
  end;

  // se liste vuote ==> tutti gli elementi
  if ItemList.Count = 0 then
  begin
    for I := 0 to fsGlobalUnit.Count - 1 do
      if not fsGlobalUnit.Items[I].isMacro then
      begin
        s := fsGlobalUnit.Items[I].Name;
        if fsGlobalUnit.Items[I].GetNumberOfRequiredParams > 0 then
          s := s + '(';
        InsertList.add(s);

        Params := '';
        for j := 0 to fsGlobalUnit.Items[I].GetNumberOfRequiredParams - 1 do
        begin
          if trim(Params) <> '' then
            Params := Params + ', ';

          Params := Params + fsGlobalUnit.Items[I].Params[j].Name + ':' + fsGlobalUnit.Items[I].Params[j].TypeName;

        end;
        if trim(Params) <> '' then
          Params := ' (' + Params + ')';

        ItemList.add(FormatItem(-1, clNavy, fsGlobalUnit.Items[I].SourcePos, fsGlobalUnit.Items[I].Name, Params));
      end;
  end;
end;

procedure TScriptEditor.SetScript(const Value: string);
begin
  Editor.Text := Value;
end;

procedure TScriptEditor.MostraLibreria(Visibile: Boolean);
begin

  if Visibile then
  begin
    Screen.Cursor := crSqlWait;
    try
      if not assigned(fsTree) then
      begin
        fsTree := TfsTree.Create(Self);
        fsTree.Visible := false;
        fsTree.Parent := Self;
        fsTree.Align := alRight;
        fsTree.Width := 200;
      end;
      fsTree.Visible := True;
      fsTree.ShowClasses := True;
      fsTree.ShowFunctions := True;
      fsTree.ShowTypes := True;
      fsTree.ShowVariables := True;

      if assigned(SplitterTree) then
        SplitterTree.Visible := True
      else
      begin
        SplitterTree := TcxSplitter.Create(Self);
        SplitterTree.Parent := Self;
        SplitterTree.HotZoneClassName := Splitter1.HotZoneClassName;
        SplitterTree.AlignSplitter := salRight;
        SplitterTree.Control := fsTree;
        SplitterTree.Width := 8;
        SplitterTree.Left := fsTree.Left - 1;
      end
    finally
      Screen.Cursor := crDefault;
    end;
  end
  else
  begin
    if assigned(fsTree) then
    begin
      fsTree.Visible := false;
      fsTree.ShowClasses := false;
      fsTree.ShowFunctions := false;
      fsTree.ShowTypes := false;
      fsTree.ShowVariables := false;
    end;

    if assigned(SplitterTree) then
      SplitterTree.Visible := false;
  end;
end;

function TScriptEditor.doCompile: Boolean;
begin
  Running := True;
  try
    result := false;
    MemoLog.lines.Clear;
    try
      ScriptModule.fsScript.OnRunLine := nil;
      result := ScriptModule.CompileScript(Editor.lines.Text);

      if not result then
      begin
        LogMessage(ScriptModule.fsScript.ErrorMsg);
        SetEditorPos(ScriptModule.fsScript.ErrorPos);
        ConfirmOk(ScriptModule.fsScript.ErrorMsg);
      end
      else
        LogMessage('Compilato');

    except
      on E: Exception do
      begin
        LogMessage(E.Message);
        Exit;
      end;
      else
        raise;
    end;
  finally
    Running := false;
  end;
end;

procedure TScriptEditor.WatchExecute(Sender: TObject);
var
  Token: string;
begin
  Token := Editor.WordAtCursor;
  ScriptEditorEvalute.Evalute(Token);
end;

procedure TScriptEditor.actRunExecute(Sender: TObject);
begin
  doRun(false);
end;

procedure TScriptEditor.StepExecute(Sender: TObject);
begin
  doRun(True);
end;

procedure TScriptEditor.LogMessage(const s: String);
begin
  MemoLog.lines.add(now.toString + ' - ' + s);
  SendMessage(MemoLog.Handle, EM_LINESCROLL, 0, MemoLog.lines.Count);
  Application.ProcessMessages;
end;

procedure TScriptEditor.doRun(const singleLine: Boolean);
begin
  // if doCompile then
  // ScriptModule.ExecuteScript(Editor.Lines.Text);

  if Running then
  begin

    if not singleLine then
      ScriptModule.fsScript.OnRunLine := nil;

    Stopped := false;
    Exit;
  end;

  if not ScriptModule.CompileScript(Editor.lines.Text) then
  begin
    Running := false;
    Stopped := false;

    Editor.SetFocus;
    SetEditorPos(ScriptModule.fsScript.ErrorPos);

    if ScriptModule.fsScript.ErrorUnit = '' then
      LogMessage(ScriptModule.fsScript.ErrorMsg)
    else
      LogMessage(ScriptModule.fsScript.ErrorUnit + ': ' + ScriptModule.fsScript.ErrorMsg);

    Exit; // <------------
  end
  else
  begin
    if not singleLine then
      LogMessage('Compilato, in esecuzione...');

    Application.ProcessMessages;

    if singleLine then
      ScriptModule.fsScript.OnRunLine := fsScriptRunLine
    else
      ScriptModule.fsScript.OnRunLine := nil;

    Running := True;
    try
      try
        ScriptModule.ExecuteScript;
      except
        on E: Exception do
        begin
          Stopped := false;
          LogMessage(E.Message);
          raise;
        end;
      end;
    finally
      Running := false;
    end;

    if not singleLine then
      LogMessage('Script completato.');
  end;
end;

procedure TScriptEditor.FormShow(Sender: TObject);
begin
  Editor.SelLength := 0;
  MemoLog.Clear;
end;

procedure TScriptEditor.fsScriptRunLine(Sender: TfsScript; const UnitName, SourcePos: String);
begin
  EnableWindow(Handle, True);
  SetFocus;

  SetEditorPos(SourcePos);

  Stopped := True;

  while Stopped and ScriptModule.fsScript.IsRunning and (ModalResult <> mrCancel) and not(Application.Terminated) do
    Application.ProcessMessages;

  if ModalResult = mrCancel then // se close
  begin
    ScriptModule.fsScript.Terminate;
    ScriptModule.fsScript.OnRunLine := nil;
  end;
end;

procedure TScriptEditor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;

  if ScriptModule.fsScript.IsRunning then
    if Application.MessageBox('Debug script in corso: si desidera terminare?', 'Application.Title', MB_OKCANCEL + MB_ICONQUESTION + MB_TOPMOST) <> mrOk then
    begin
      CanClose := false;
      Exit;
    end
    else
    begin
      Stopped := false;
      ScriptModule.fsScript.Terminate;
    end;

  if Editor.Modified then
    if Application.MessageBox('Script modificare: si desidera annullare le modifiche?', 'Application.Title', MB_OKCANCEL + MB_ICONQUESTION + MB_TOPMOST) <> mrOk then
    begin
      CanClose := false;
      Exit;
    end;
end;

procedure TScriptEditor.ResetExecute(Sender: TObject);
begin
  ScriptModule.fsScript.Terminate;
  Stopped := false;
end;

procedure TScriptEditor.ResetUpdate(Sender: TObject);
begin
  Reset.Visible := ScriptModule.fsScript.IsRunning;
end;

end.


// AsmAttri.Background = clNavy
// AsmAttri.Foreground = clAqua
// CommentAttri.Background = clNavy
// CommentAttri.Foreground = clSilver
// DirectiveAttri.Background = clNavy
// DirectiveAttri.Foreground = clSilver
// IdentifierAttri.Background = clNavy
// IdentifierAttri.Foreground = clWhite
// KeyAttri.Background = clNavy
// KeyAttri.Foreground = clWhite
// NumberAttri.Background = clNavy
// NumberAttri.Foreground = clLime
// FloatAttri.Background = clNavy
// FloatAttri.Foreground = clLime
// HexAttri.Background = clNavy
// HexAttri.Foreground = clLime
// SpaceAttri.Background = clNavy
// StringAttri.Background = clNavy
// StringAttri.Foreground = clFuchsia
// CharAttri.Background = clNavy
// CharAttri.Foreground = clRed
// SymbolAttri.Background = clNavy
// SymbolAttri.Foreground = clYellow
