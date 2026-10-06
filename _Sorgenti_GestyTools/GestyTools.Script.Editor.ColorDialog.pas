unit GestyTools.Script.Editor.ColorDialog;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  SynEdit,
  SynEditHighlighter;

type
  TScriptEditorColorDialog = class(TForm)
    Label1: TLabel;
    ListBox1: TListBox;
    SynEdit1: TSynEdit;
    Label2: TLabel;
    ColorBox1: TColorBox;
    Label3: TLabel;
    ColorBox2: TColorBox;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure ColorBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
  private
    { Private declarations }
    fSynH: TsynCustomHighlighter;
    procedure EnableItems(aenable: boolean);
    procedure SetFontStyle;
  public
    { Public declarations }
    procedure SetHighlighter(SynH: TsynCustomHighlighter);
    function GetHighlighter: TsynCustomHighlighter;
  end;

function SynColorDialogExecute(SynEdit: TCustomSynEdit): boolean;

implementation

{$R *.dfm}

type
  TSynHClass = class of TsynCustomHighlighter;

function SynColorDialogExecute(SynEdit: TCustomSynEdit): boolean;
var
  ScriptEditorColorDialog: TScriptEditorColorDialog;
begin
  result := false;

  if assigned(SynEdit) then
  begin
    if assigned(SynEdit.highlighter) then
    begin
      ScriptEditorColorDialog := TScriptEditorColorDialog.Create(nil);
      try
        ScriptEditorColorDialog.SetHighlighter(SynEdit.highlighter);

        result := (ScriptEditorColorDialog.ShowModal = mrOK);

        if result then
          SynEdit.highlighter.assign(ScriptEditorColorDialog.GetHighlighter);
      finally
        FreeAndNil(ScriptEditorColorDialog);
      end;
    end
    else
      EInvalidOperation.Create('SynEdit.Highligher has not been properly assigned');
  end
  else
    EInvalidOperation.Create('SynEdit has not been properly assigned');
end;

{ TfrmSynColorDialog }

procedure TScriptEditorColorDialog.SetHighlighter(SynH: TsynCustomHighlighter);
var
  loop: integer;
  wSynClass: TSynHClass;
begin
  wSynClass := TSynHClass(SynH.ClassType);
  fSynH := wSynClass.Create(nil);
  fSynH.assign(SynH);
  ListBox1.items.BeginUpdate;
  try
    ListBox1.itemindex := -1;
    CheckBox1.Checked := false;
    CheckBox2.Checked := false;
    CheckBox3.Checked := false;
    CheckBox4.Checked := false;
    ColorBox1.itemindex := -1;
    ColorBox2.itemindex := -1;
    for loop := 0 to fSynH.AttrCount - 1 do
      ListBox1.items.Add(fSynH.Attribute[loop].Name);
    SynEdit1.highlighter := fSynH;
    SynEdit1.Lines.Text := fSynH.SampleSource;
    caption := fSynH.LanguageName + ' Color Definitions';
  finally
    ListBox1.items.EndUpdate;
  end;
end;

procedure TScriptEditorColorDialog.FormDestroy(Sender: TObject);
begin
  if assigned(fSynH) then
    fSynH.free;
end;

function TScriptEditorColorDialog.GetHighlighter: TsynCustomHighlighter;
begin
  result := fSynH;
end;

procedure TScriptEditorColorDialog.ListBox1Click(Sender: TObject);
var
  wSynAttr: TSynHighlighterAttributes;
begin
  if ListBox1.itemindex <> -1 then
  begin
    EnableItems(true);
    wSynAttr := fSynH.Attribute[ListBox1.itemindex];
    CheckBox1.Checked := (fsBold in wSynAttr.Style);
    CheckBox2.Checked := (fsItalic in wSynAttr.Style);
    CheckBox3.Checked := (fsUnderline in wSynAttr.Style);
    CheckBox4.Checked := (fsStrikeOut in wSynAttr.Style);
    ColorBox1.Selected := wSynAttr.Foreground;
    ColorBox2.Selected := wSynAttr.Background;
  end
  else
    EnableItems(false);
end;

procedure TScriptEditorColorDialog.EnableItems(aenable: boolean);
begin
  ColorBox1.Enabled := aenable;
  ColorBox2.Enabled := aenable;
  CheckBox1.Enabled := aenable;
  CheckBox2.Enabled := aenable;
  CheckBox3.Enabled := aenable;
  CheckBox4.Enabled := aenable;
end;

procedure TScriptEditorColorDialog.ColorBox1Change(Sender: TObject);
var
  wSynAttr: TSynHighlighterAttributes;
begin
  wSynAttr := fSynH.Attribute[ListBox1.itemindex];
  wSynAttr.Foreground := ColorBox1.Selected;
end;

procedure TScriptEditorColorDialog.ColorBox2Change(Sender: TObject);
var
  wSynAttr: TSynHighlighterAttributes;
begin
  wSynAttr := fSynH.Attribute[ListBox1.itemindex];
  wSynAttr.Background := ColorBox2.Selected;
end;

procedure TScriptEditorColorDialog.ColorBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = vk_delete) and (Shift = []) then
  begin
    Key := 0;
    TColorBox(Sender).Selected := clNone;
    TColorBox(Sender).OnChange(nil);
  end;
end;

procedure TScriptEditorColorDialog.CheckBox1Click(Sender: TObject);
begin
  SetFontStyle;
end;

procedure TScriptEditorColorDialog.CheckBox2Click(Sender: TObject);
begin
  SetFontStyle;
end;

procedure TScriptEditorColorDialog.CheckBox3Click(Sender: TObject);
begin
  SetFontStyle;
end;

procedure TScriptEditorColorDialog.CheckBox4Click(Sender: TObject);
begin
  SetFontStyle;
end;

procedure TScriptEditorColorDialog.SetFontStyle;
var
  wfs: TFontStyles;
  wSynAttr: TSynHighlighterAttributes;
begin
  wfs := [];
  wSynAttr := fSynH.Attribute[ListBox1.itemindex];

  if CheckBox1.Checked then
    include(wfs, fsBold);

  if CheckBox2.Checked then
    include(wfs, fsItalic);

  if CheckBox3.Checked then
    include(wfs, fsUnderline);

  if CheckBox4.Checked then
    include(wfs, fsStrikeOut);

  wSynAttr.Style := wfs;
end;

end.
