object ScriptEditor: TScriptEditor
  Left = 0
  Top = 0
  Caption = 'Script Editor'
  ClientHeight = 468
  ClientWidth = 821
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  TextHeight = 15
  object Splitter1: TcxSplitter
    Left = 0
    Top = 371
    Width = 821
    Height = 8
    Cursor = crVSplit
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    Control = MemoLog
    ExplicitTop = 370
    ExplicitWidth = 817
  end
  object MemoLog: TcxMemo
    Left = 0
    Top = 379
    TabStop = False
    Align = alBottom
    Properties.ScrollBars = ssBoth
    TabOrder = 1
    ExplicitTop = 378
    Height = 69
    Width = 821
  end
  object PanelEditor: TPanel
    Left = 0
    Top = 26
    Width = 821
    Height = 345
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 28
    ExplicitWidth = 817
    ExplicitHeight = 342
    object Editor: TSynEdit
      Left = 0
      Top = 0
      Width = 821
      Height = 323
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      Font.Quality = fqClearTypeNatural
      TabOrder = 0
      UseCodeFolding = False
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Courier New'
      Gutter.Font.Style = []
      Gutter.Font.Quality = fqClearTypeNatural
      Gutter.Visible = False
      Gutter.Bands = <
        item
          Kind = gbkMarks
          Width = 13
        end
        item
          Kind = gbkLineNumbers
        end
        item
          Kind = gbkFold
        end
        item
          Kind = gbkTrackChanges
        end
        item
          Kind = gbkMargin
          Width = 3
        end>
      Highlighter = SynPasSyn
      ScrollbarAnnotations = <>
      SearchEngine = SynEditRegexSearch
      OnChange = EditorChange
      OnStatusChange = EditorStatusChange
      ExplicitWidth = 817
      ExplicitHeight = 322
      RemovedKeystrokes = <
        item
          Command = ecContextHelp
          ShortCut = 112
        end>
      AddedKeystrokes = <
        item
          Command = ecContextHelp
          ShortCut = 16496
        end>
    end
    object StatusBar: TdxStatusBar
      Left = 0
      Top = 323
      Width = 821
      Height = 20
      Panels = <
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
          Width = 66
        end
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
          Width = 75
        end
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
          Width = 90
        end
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
          Width = 100
        end>
      SizeGrip = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitTop = 322
      ExplicitWidth = 817
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 448
    Width = 821
    Height = 20
    Panels = <>
    ExplicitTop = 447
    ExplicitWidth = 817
  end
  object CompletionProposal: TSynCompletionProposal
    Options = [scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoUseBuiltInTimer, scoEndCharCompletion, scoCompleteWithTab, scoCompleteWithEnter]
    NbLinesInWindow = 12
    Width = 300
    EndOfTokenChr = '()[]., '
    TriggerChars = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    GripperFont.Charset = DEFAULT_CHARSET
    GripperFont.Color = clBtnText
    GripperFont.Height = -12
    GripperFont.Name = 'Segoe UI'
    GripperFont.Style = []
    Columns = <>
    ItemHeight = 16
    Images = CompletionImageList
    OnExecute = CompletionProposalExecute
    ShortCut = 16416
    Editor = Editor
    TimerInterval = 800
    Left = 304
    Top = 113
  end
  object ParamProposal: TSynCompletionProposal
    DefaultType = ctParams
    Options = [scoLimitToMatchedText, scoUsePrettyText, scoUseBuiltInTimer]
    ClBackground = clInfoBk
    Width = 500
    EndOfTokenChr = '()[]. '
    TriggerChars = '('
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    GripperFont.Charset = DEFAULT_CHARSET
    GripperFont.Color = clBtnText
    GripperFont.Height = -12
    GripperFont.Name = 'Segoe UI'
    GripperFont.Style = []
    Columns = <>
    Images = CompletionImageList
    OnExecute = ParamProposalExecute
    ShortCut = 24608
    Editor = Editor
    TimerInterval = 800
    Left = 304
    Top = 57
  end
  object SynEditOptionsDialog: TSynEditOptionsDialog
    UseExtendedStrings = False
    Left = 512
    Top = 64
  end
  object ActionList: TActionList
    Images = EditorImageList
    Left = 64
    Top = 59
    object actAnnulla: TEditUndo
      Category = 'Edit'
      Caption = 'Annulla'
      Hint = 'annulla'
      ImageIndex = 4
      ShortCut = 16474
    end
    object actRipristina: TAction
      Category = 'Edit'
      Caption = 'Ripristina'
      Hint = 'ripristina'
      ImageIndex = 5
      OnExecute = actRipristinaExecute
      OnUpdate = actRipristinaUpdate
    end
    object actTaglia: TEditCut
      Category = 'Edit'
      Caption = 'Taglia'
      Hint = 'taglia'
      ImageIndex = 0
      ShortCut = 16472
    end
    object actCopia: TEditCopy
      Category = 'Edit'
      Caption = 'Copia'
      Hint = 'copia'
      ImageIndex = 1
      ShortCut = 16451
    end
    object actIncolla: TEditPaste
      Category = 'Edit'
      Caption = 'Incolla'
      Hint = 'incolla'
      ImageIndex = 2
      ShortCut = 16470
    end
    object actSelezionaTutto: TEditSelectAll
      Category = 'Edit'
      Caption = 'Seleziona Tutto'
      Hint = 'seleziona tutto'
      ImageIndex = 6
      ShortCut = 16449
    end
    object actElimina: TEditDelete
      Category = 'Edit'
      Caption = 'Elimina'
      Hint = 'elimina'
      ImageIndex = 3
    end
    object actTrova: TAction
      Category = 'Search'
      Caption = 'Trova...'
      Hint = 'trova'
      ImageIndex = 7
      ShortCut = 16454
      OnExecute = actTrovaExecute
    end
    object actSostituisci: TAction
      Category = 'Search'
      Caption = 'Sostituisci'
      Hint = 'sostituisci'
      ImageIndex = 9
      ShortCut = 16466
      OnExecute = actSostituisciExecute
    end
    object CaricaDalFile: TFileOpen
      Category = 'File'
      Caption = 'Carica da File'
      Dialog.DefaultExt = '*.sql'
      Dialog.Filter = 'SQL|*.sql|Tutti|*.*'
      Hint = 'Carica da File'
      ImageIndex = 10
      ShortCut = 16460
      BeforeExecute = CaricaDalFileBeforeExecute
      OnAccept = CaricaDalFileAccept
    end
    object SalvaSuFile: TFileSaveAs
      Category = 'File'
      Caption = 'Salva su File'
      Dialog.DefaultExt = '*.SQL'
      Dialog.Filter = 'SQL|*.sql|Tutti|*.*'
      Hint = 'Salva su File'
      ImageIndex = 11
      ShortCut = 16467
      BeforeExecute = SalvaSuFileBeforeExecute
      OnAccept = SalvaSuFileAccept
    end
    object OpizioniEditor: TAction
      Category = 'File'
      Caption = 'Opizioni Editor'
      Hint = 'Opizioni Editor'
      ImageIndex = 20
      OnExecute = OpizioniEditorExecute
    end
    object DuplicaLinea: TAction
      Category = 'Altro'
      Caption = 'Duplica Linea'
      ImageIndex = 22
      ShortCut = 24644
      OnExecute = DuplicaLineaExecute
    end
    object Maiuscolo: TAction
      Category = 'Altro'
      Caption = 'Maiuscolo'
      ImageIndex = 13
      ShortCut = 32806
      OnExecute = MaiuscoloExecute
    end
    object Minuscolo: TAction
      Category = 'Altro'
      Caption = 'Minuscolo'
      ImageIndex = 12
      ShortCut = 32808
      OnExecute = MinuscoloExecute
    end
    object actRun: TAction
      Category = 'Run'
      Caption = 'Run'
      ImageIndex = 14
      ShortCut = 120
      OnExecute = actRunExecute
    end
    object actCompile: TAction
      Category = 'Run'
      Caption = 'Compile'
      ImageIndex = 16
      ShortCut = 16504
      OnExecute = actCompileExecute
    end
    object actColori: TAction
      Category = 'File'
      Caption = 'Colori Editor'
      ImageIndex = 23
      OnExecute = actColoriExecute
    end
    object actFormatta: TAction
      Category = 'Altro'
      Caption = 'Formatta'
      ImageIndex = 24
      ShortCut = 16452
      OnExecute = actFormattaExecute
    end
    object actCommenta: TAction
      Caption = 'Commenta'
      ImageIndex = 30
      ShortCut = 49342
      OnExecute = actCommentaExecute
    end
    object actDecommenta: TAction
      Caption = 'Decommenta'
      ImageIndex = 31
      ShortCut = 49340
      OnExecute = actDecommentaExecute
    end
    object Libreria: TAction
      AutoCheck = True
      Caption = 'Libreria'
      ImageIndex = 33
      OnExecute = LibreriaExecute
    end
    object Step: TAction
      Category = 'Run'
      Caption = 'Step'
      ImageIndex = 29
      ShortCut = 119
      OnExecute = StepExecute
    end
    object Watch: TAction
      Category = 'Run'
      Caption = 'Watch'
      ImageIndex = 34
      ShortCut = 16502
      OnExecute = WatchExecute
    end
    object Reset: TAction
      Category = 'Run'
      Caption = 'Reset'
      ImageIndex = 35
      OnExecute = ResetExecute
      OnUpdate = ResetUpdate
    end
  end
  object FindDialog: TFindDialog
    Options = [frDown, frFindNext]
    OnFind = DoFindText
    Left = 512
    Top = 228
  end
  object ReplaceDialog: TReplaceDialog
    OnFind = DoFindText
    OnReplace = DoReplaceText
    Left = 512
    Top = 284
  end
  object SynEditRegexSearch: TSynEditRegexSearch
    Left = 512
    Top = 120
  end
  object SynPasSyn: TSynPasSyn
    Left = 512
    Top = 176
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = EditorImageList
    PopupMenuLinks = <
      item
        Control = Editor
        PopupMenu = PopupMenu
      end>
    UseSystemFont = True
    Left = 176
    Top = 60
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Toolbar'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 571
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'dxBarButton11'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton12'
        end
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton14'
        end
        item
          Visible = True
          ItemName = 'dxBarButton15'
        end
        item
          Visible = True
          ItemName = 'dxBarButton16'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton17'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton18'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton21'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton19'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton20'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = True
    end
    object dxbrbtnPrepara: TdxBarButton
      Category = 0
      Visible = ivAlways
    end
    object dxBarButton1: TdxBarButton
      Action = CaricaDalFile
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = SalvaSuFile
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = actTaglia
      Category = 0
    end
    object dxBarButton4: TdxBarButton
      Action = actCopia
      Category = 0
    end
    object dxBarButton5: TdxBarButton
      Action = actIncolla
      Category = 0
    end
    object dxBarButton6: TdxBarButton
      Action = actElimina
      Category = 0
    end
    object dxBarButton7: TdxBarButton
      Action = actAnnulla
      Category = 0
    end
    object dxBarButton8: TdxBarButton
      Action = actRipristina
      Category = 0
    end
    object dxBarButton9: TdxBarButton
      Action = actFormatta
      Category = 0
    end
    object dxBarButton10: TdxBarButton
      Action = actCommenta
      Category = 0
    end
    object dxBarButton11: TdxBarButton
      Action = actDecommenta
      Category = 0
    end
    object dxBarButton12: TdxBarButton
      Action = actTrova
      Category = 0
    end
    object dxBarButton13: TdxBarButton
      Action = actSostituisci
      Category = 0
    end
    object dxBarButton14: TdxBarButton
      Action = OpizioniEditor
      Category = 0
    end
    object dxBarButton15: TdxBarButton
      Action = actColori
      Category = 0
    end
    object dxBarButton16: TdxBarButton
      Action = Libreria
      Category = 0
    end
    object dxBarButton17: TdxBarButton
      Action = actCompile
      Category = 0
    end
    object dxBarButton18: TdxBarButton
      Action = actRun
      Category = 0
    end
    object dxBarButton19: TdxBarButton
      Action = Step
      Category = 0
    end
    object dxBarButton20: TdxBarButton
      Action = Watch
      Category = 0
    end
    object dxBarButton21: TdxBarButton
      Action = Reset
      Category = 0
    end
    object Annulla1: TdxBarButton
      Action = actAnnulla
      Category = 1
    end
    object Ripristina1: TdxBarButton
      Action = actRipristina
      Category = 1
    end
    object Cut1: TdxBarButton
      Action = actTaglia
      Category = 1
    end
    object Copy1: TdxBarButton
      Action = actCopia
      Category = 1
    end
    object Paste1: TdxBarButton
      Action = actIncolla
      Category = 1
    end
    object Elimina1: TdxBarButton
      Action = actElimina
      Category = 1
    end
    object SelectAll1: TdxBarButton
      Action = actSelezionaTutto
      Category = 1
    end
    object DuplicaLinea1: TdxBarButton
      Action = DuplicaLinea
      Category = 1
    end
    object Maiuscolo1: TdxBarButton
      Action = Maiuscolo
      Category = 1
    end
    object Minuscolo1: TdxBarButton
      Action = Minuscolo
      Category = 1
    end
    object Formatta1: TdxBarButton
      Action = actFormatta
      Category = 1
    end
    object Commenta1: TdxBarButton
      Action = actCommenta
      Category = 1
    end
    object Decommenta1: TdxBarButton
      Action = actDecommenta
      Category = 1
    end
    object Find1: TdxBarButton
      Action = actTrova
      Category = 1
    end
    object Searchagain1: TdxBarButton
      Action = actSostituisci
      Category = 1
    end
    object CaricadaFile1: TdxBarButton
      Action = CaricaDalFile
      Category = 1
    end
    object SalvasuFile1: TdxBarButton
      Action = SalvaSuFile
      Category = 1
    end
    object ColoriEditor1: TdxBarButton
      Action = actColori
      Category = 1
    end
    object EditorOptions1: TdxBarButton
      Action = OpizioniEditor
      Category = 1
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'Annulla1'
      end
      item
        Visible = True
        ItemName = 'Ripristina1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'Cut1'
      end
      item
        Visible = True
        ItemName = 'Copy1'
      end
      item
        Visible = True
        ItemName = 'Paste1'
      end
      item
        Visible = True
        ItemName = 'Elimina1'
      end
      item
        Visible = True
        ItemName = 'SelectAll1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'DuplicaLinea1'
      end
      item
        Visible = True
        ItemName = 'Maiuscolo1'
      end
      item
        Visible = True
        ItemName = 'Minuscolo1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'Formatta1'
      end
      item
        Visible = True
        ItemName = 'Commenta1'
      end
      item
        Visible = True
        ItemName = 'Decommenta1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'Find1'
      end
      item
        Visible = True
        ItemName = 'Searchagain1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'CaricadaFile1'
      end
      item
        Visible = True
        ItemName = 'SalvasuFile1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'ColoriEditor1'
      end
      item
        Visible = True
        ItemName = 'EditorOptions1'
      end>
    UseOwnFont = False
    Left = 176
    Top = 120
    PixelsPerInch = 96
  end
  object EditorImageList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 8388672
    ImageInfo = <
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000A5420800A7440700A23F08000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000A23F0800A5420800A23F0800A54208000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000A74407000000000000000000A23F0800A23F
          080000000000A23F0800A7440700000000000000000000000000000000000000
          0000000000000000000000000000A74407000000000000000000A23F08000000
          0000A23F0800A23F0800A23F0800A54208000000000000000000000000000000
          0000000000000000000000000000A5420800A23F0800A23F0800A23F08000000
          0000A23F08000000000000000000A64307000000000000000000000000000000
          000000000000000000000000000000000000A23F0800A7440700A5420800A23F
          0800A54208000000000000000000A23F08000000000000000000000000000000
          000000000000000000000000000000000000000000009E410D00A14E2200A23F
          0800A7440700A5420800A5420800A23F08000000000000000000000000000000
          00000000000000000000000000000000000000000000957D75008D766C00A55E
          3900A23F0800A23F0800A23F0800000000000000000000000000000000000000
          0000000000000000000000000000000000008E7C7200AC928E008E7C72008E7C
          7200000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000008E7C7200D3BDBD008E7C7200AD938F008E7C
          7200000000000000000000000000000000000000000000000000000000000000
          000000000000000000008E7C7200E9DEDE008E7C7200A9958F00D2BABA008E7C
          7200000000000000000000000000000000000000000000000000000000000000
          0000000000008E7C7200FCFAFA008E7C7200000000008E7C7200DFCECE008E7C
          7200000000000000000000000000000000000000000000000000000000000000
          0000000000008E7C72008E7C720000000000000000008E7C7200ECE2E2008E7C
          7200000000000000000000000000000000000000000000000000000000000000
          0000000000008E7C72000000000000000000000000008E7C7200F9F5F5008E7C
          7200000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000008E7C72008E7C72000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000008E7C7200000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FC7F0000F87F0000FB270000FB430000F85B0000FC1B0000FE030000FE07
          0000FC3F0000F83F0000F03F0000E23F0000E63F0000EE3F0000FE7F0000FEFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000A4787400A4787400A4787400A4787400A478
          7400A4787400A4787400A4787400A47874008C5D5C0000000000000000000000
          0000000000000000000000000000A87C7500FEE5CB00FFE2C400FFDFBE00FFDC
          B800FFD9B100FED6AC00FFD4A600FFD1A2008C5D5C0000000000000000000000
          0000000000000000000000000000AD807800FFEAD400E5A65700E5A65700E5A6
          5700E5A65700E5A65700E5A65700FFD4A8008C5D5C0000000000000000000000
          0000000000000000000000000000B4867A00FEEEDD00FFEBD600FFE8CF00FFE4
          C900FEE1C200FEDDBB00FFDBB500FFD8AF008C5D5C0000000000A4787400A478
          7400A4787400A4787400A4787400BA8D7D00FEF2E500E5A65700E5A65700E5A6
          5700E5A65700E5A65700E5A65700FEDCB7008C5D5C0000000000A87C7500FEE5
          CB00FFE2C400FFDFBE00FFDCB800C2958100FEF6EC00FEF3E600FEEFE100FFED
          DA00FEE9D400FEE6CC00FFE2C600FEDFBF008C5D5C0000000000AD807800FFEA
          D400E5A65700E5A65700E5A65700CA9B8300FFF9F300E5A65700E5A65700E5A6
          5700E5A65700E5A65700E5A65700FEE3C8008C5D5C0000000000B4867A00FEEE
          DD00FFEBD600FFE8CF00FFE4C900D1A28600FEFBF900FEF9F400FEF7EF00FEF5
          EA00FEF1E400FEEEDE00FEEBD700FEE8D0008C5D5C0000000000BA8D7D00FEF2
          E500E5A65700E5A65700E5A65700D8A98A00FEFEFD00FEFCFA00FEFAF600FEF8
          F100FEF5EC00EBDFDB00D3C2C000BAA9AA008C5D5C0000000000C2958100FEF6
          EC00FEF3E600FEEFE100FFEDDA00DFB08D00FEFEFE00FEFEFE00FEFCFB00FEFB
          F700FEF8F200B4817600B4817600B4817600B17F740000000000CA9B8300FFF9
          F300E5A65700E5A65700E5A65700E4B58E00FEFEFE00FEFEFE00FEFEFE00FEFD
          FC00FEFBF800B4817600EBB56F00E49B42000000000000000000D1A28600FEFB
          F900FEF9F400FEF7EF00FEF5EA00E8B89000DCA88700DCA88700DCA88700DCA8
          8700DCA88700B4817600F0B25E00000000000000000000000000D8A98A00FEFE
          FD00FEFCFA00FEFAF600FEF8F100FEF5EC00EBDFDB00D3C2C000BAA9AA008C5D
          5C00000000000000000000000000000000000000000000000000DFB08D00FEFE
          FE00FEFEFE00FEFCFB00FEFBF700FEF8F200B4817600B4817600B4817600B17F
          7400000000000000000000000000000000000000000000000000E4B58E00FEFE
          FE00FEFEFE00FEFEFE00FEFDFC00FEFBF800B4817600EBB56F00E49B42000000
          0000000000000000000000000000000000000000000000000000E8B89000DCA8
          8700DCA88700DCA88700DCA88700DCA88700B4817600F0B25E00000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00F8010000F8010000F8010000F80100000001000000010000000100000001
          000000010000000100000003000000070000003F0000003F0000007F000000FF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000669A0000669A0000669A00A4787400A4787400A4787400A4787400A478
          7400A4787400A4787400A4787400A47874008C5D5C0000000000000000000066
          9A003CBEE30036BAE10030B6DF00B7818300FCEDDD00FAF2E400F8F1E000F7EE
          DD00F7EEDB00F7EDDB00F7ECDA00F8EDD9008C5D5C0000000000000000000066
          9A0045C4E6003FC0E40038BCE200B7818300F6E4DA00E4A85C00E4A75900E3A7
          5900E3A75900E3A65800E3A75900F0E3D0008C5D5C0000000000000000000066
          9A004DC9E90047C4E70041C0E500B9848400F8E8DF00F9E4CE00F9DBBD00F9DB
          BD00F9DBBD00F8D9B800F5DDC200F0E4D2008C5D5C0000000000000000000066
          9A0056CDED0050C9EA004AC5E800BC878500F9EBE400E4A85C00E4A75800E4A7
          5800E4A75800E4A65700E3A75900F2E6D6008C5D5C0000000000000000000066
          9A005ED2F00058CFED0052CBEB00C08B8500FAEFE900FAEDDE00FAE5D000F9E5
          CF00F9E3CD00F8E1CA00F5E4D000F3E8DB008C5D5C0000000000000000000066
          9A0066D7F30060D4F1005AD0EE00C4908600FCF4F000E5A95C00E5A65700E5A6
          5700E4A65700E4A65600E4A75A00F7EEE3008C5D5C0000000000000000000066
          9A006DDBF60067D8F30062D4F200C8948800FEF7F400FEF7F000FBF0E500FBEF
          E300FAEDE000FAEEE100F9F0E500E8E3DD008C5D5C0000000000000000000066
          9A0074DFF8006FDCF6006ADAF400CC998900FEF8F500FFFFFF00FEFFFE00FCFA
          F900FBFBF900B4817600B4817600B4817600B481760000000000000000000066
          9A007AE3FA0076E1F80070DDF600D09C8900FFFAF800FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00B4817600E0A87000F7935B00FF00FE0000000000000000000066
          9A007FE6FC007BE4FA0077E1F900D29F8A00DCA88700DCA88700DCA88700DCA8
          8700DCA88700B4817600C7AF890000669A000000000000000000000000000066
          9A0083E8FE0080E6FC007DE5FC007DE5FC0078E2FA0072DFF8006BDAF50064D5
          F2005DD0EF0056CDED0052CAEB0000669A000000000000000000000000000066
          9A0084E9FE0084E9FE0073737300737373007373730073737300737373007373
          73007373730060D4F0005ACFEE0000669A000000000000000000000000000066
          9A0084E9FE0084E9FE0073737300CFC1BC00CFC1BB00CFC1BB00CFC1BB00CEBE
          B7007373730068D8F40062D4F10000669A000000000000000000000000000000
          000000669A0000669A0073737300E2D8D300FAF9F800F9F8F700F9F8F700D0C5
          BF007373730000669A0000669A00000000000000000000000000000000000000
          0000000000000000000000000000737373007373730073737300737373007373
          7300000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00C00100008001000080010000800100008001000080010000800100008001
          0000800100008001000080030000800300008003000080030000C0070000F83F
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000732DE000732DE00000000000732
          DE000732DE000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000732DE000732DE0000000000000000000732
          DE000732DE000732DE0000000000000000000000000000000000000000000000
          000000000000000000000732DE000732DE000000000000000000000000000732
          DE000732DD000732DE000732DE00000000000000000000000000000000000000
          0000000000000732DE000732DE00000000000000000000000000000000000000
          00000534ED000732DF000732DE000732DE000000000000000000000000000000
          00000732DE000732DE0000000000000000000000000000000000000000000000
          000000000000000000000732DE000732DE000732DD00000000000732DD000732
          DE000732DE000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000732DD000633E6000633E6000633E9000732
          DC00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000633E3000732E3000534EF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000732DD000534ED000533E9000434EF000434
          F500000000000000000000000000000000000000000000000000000000000000
          000000000000000000000434F4000534EF000533EB0000000000000000000434
          F4000335F8000000000000000000000000000000000000000000000000000000
          0000000000000335FC000534EF000434F8000000000000000000000000000000
          00000335FC000335FB0000000000000000000000000000000000000000000000
          00000335FB000335FB000335FC00000000000000000000000000000000000000
          0000000000000335FB000335FB00000000000000000000000000000000000335
          FB000335FB000335FB0000000000000000000000000000000000000000000000
          00000000000000000000000000000335FB0000000000000000000335FB000335
          FB000335FB000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000335FB000335
          FB00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFC00009FF900008FF3000087E70000C3CF0000F11F0000F83F0000FC7F
          0000F83F0000F19F0000E3CF0000C7E700008FFB00001FFF00003FFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000BD73
          5200C65A0000AD4A000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000B55A
          3100C65A0000CE630000B5521000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000B55A3100C6630000CE630000B55A21000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000B55A2100CE630000C6630000C68463000000000000000000AD4A
          0000BD5A0000BD5A0000BD5A0000BD5A0000BD5A0000BD5A0000BD5A0000C684
          63000000000000000000AD4A0000CE630000B54A00000000000000000000B552
          0000D6730000CE6B0000CE630000CE630000CE630000CE630000C6630000BD6B
          42000000000000000000CE9C8400C6630000C6630000C684630000000000BD5A
          0000DE7B0000D6730000CE630000A5421000CE9C8400CE9C8400CE9C84000000
          0000000000000000000000000000AD4A0000CE630000B552100000000000C663
          0000E7840000CE630000DE730000CE630000C684630000000000000000000000
          0000000000000000000000000000C6734200CE630000B54A000000000000CE63
          0000F7940000B5521000B5520000DE7B0000CE6B0000BD7B5200000000000000
          0000000000000000000000000000C6734200CE630000B54A000000000000CE6B
          0800FF9C0800CE84420000000000B5520000E7840000CE6B0000BD6331000000
          0000000000000000000000000000B54A0000CE630000B552100000000000CE73
          2100FFAD3100CE844A000000000000000000C6631000E7840000E77B0000BD52
          0000C67B5200C68C7300B5521000C6630000C6630000C684630000000000CE7B
          3900FFBD6300C67B5200000000000000000000000000B55A2100E77B0000E784
          0000DE7B0000D6730000CE6B0000C6630000AD4A10000000000000000000CE94
          7B00C6845A000000000000000000000000000000000000000000CE9C8400C663
          1000CE6B0000CE6B0000BD5A0000BD6B42000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FF8F0000FF870000FFC30000FFE1000080310000803000008078000081F8
          000080F80000887800008C0000008E0100009F030000FFFF0000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000AD4A0000C65A0000BD73520000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000B5521000CE630000C65A0000B55A310000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000B55A2100CE630000C6630000B55A31000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000C684
          6300C6630000CE630000B55A2100000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000B54A
          0000CE630000AD4A00000000000000000000C6846300BD5A0000BD5A0000BD5A
          0000BD5A0000BD5A0000BD5A0000BD5A0000AD4A000000000000C6846300C663
          0000C6630000000000000000000000000000BD6B4200C6630000CE630000CE63
          0000CE630000CE630000CE6B0000D6730000B552000000000000B5521000CE63
          0000AD4A000000000000000000000000000000000000CE9C8400CE9C8400CE9C
          8400A5421000CE630000D6730000DE7B0000BD5A000000000000B54A0000CE63
          0000C6734200000000000000000000000000000000000000000000000000C684
          6300CE630000DE730000CE630000E7840000C663000000000000B54A0000CE63
          0000C67342000000000000000000000000000000000000000000BD7B5200CE6B
          0000DE7B0000B5520000B5521000F7940000CE63000000000000B5521000CE63
          0000B54A000000000000000000000000000000000000BD633100CE6B0000E784
          0000B552000000000000CE844200FF9C0800CE6B080000000000C6846300C663
          0000C6630000B5521000C68C7300C67B5200BD520000E77B0000E7840000C663
          10000000000000000000CE844A00FFAD3100CE7321000000000000000000AD4A
          1000C6630000CE6B0000D6730000DE7B0000E7840000E77B0000B55A21000000
          00000000000000000000C67B5200FFBD6300CE7B390000000000000000000000
          0000BD6B4200BD5A0000CE6B0000CE6B0000C6631000CE9C8400000000000000
          0000000000000000000000000000C6845A00CE947B0000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00F1FF0000E1FF0000C3FF000087FF00008C0100001C0100001E0100001F81
          00001F0100001E1100000031000080710000C0F90000FFFF0000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000000000C684
          7300B5848400B5848400B5848400B5848400B5848400B5848400B5848400B584
          8400B5848400B5848400B5848400B5848400B584840000000000C6A59C00FFFF
          FF00FFFFFF00FFFFFF00FFFFEF00FFFFEF00FFFFEF00FFF7DE00FFF7DE00FFEF
          D600FFEFD600FFEFD600FFDEB50000189C00FFD6A500B5848400C6A59C00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFEF00FFFFEF00FFFFEF00FFF7
          DE00FFF7DE00FFEFD600FFEFD60000189C00FFDEBD00B5848400C6ADA500FFFF
          FF00FFFFFF00FFFFFF00DEA57B00C6847300FFFFFF00DEA57B00C6847300FFFF
          EF00DEA57B002118CE002118CE002118CE0000189C0000189C00C6ADA500FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFEF00FFFFEF00FFF7DE002118CE00FFEFD600B5848400D6B5AD00FFFF
          FF00C6847300FFFFFF00FFFFFF00EFE7E700943931008C2121008C212100A563
          5A008C212100E7CEC600FFFFEF002118CE00FFEFD600B5848400D6B5AD00FFFF
          FF00DEA57B00FFFFFF00FFFFFF00BD7B7B009C424200FFFFFF00EFE7E7009C52
          52008C212100FFFFFF00FFFFEF00DEA57B00FFEFD600B5848400D6BDB500FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00C68C8C008C212100CE949400FFFFFF00FFFF
          FF008C212100FFFFFF00FFFFFF00FFFFEF00FFF7DE00B5848400D6BDB500FFFF
          FF00C6847300FFFFFF00FFFFFF00FFFFFF00B56B6B00943931008C2121008C21
          21008C212100FFFFFF00FFFFFF00C6847300FFFFEF00B5848400D6BDB500FFFF
          FF00DEA57B00FFFFFF00FFFFFF00EFE7E700CE949400FFFFFF00FFFFFF00E7D6
          D6008C212100FFFFFF00FFFFFF00DEA57B00FFFFEF00B5848400E7C6B500FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00EFE7E7008C212100BD7B7B00CE949400B56B
          6B008C212100FFFFFF00FFFFFF00FFFFFF00FFFFEF00B5848400E7C6B500FFFF
          FF00C6847300FFFFFF00FFFFFF00FFFFFF00DEBDB5009C525200943931009C42
          4200DEBDB500FFFFFF00FFFFFF00C6847300FFFFEF00B5848400E7C6B500FFFF
          FF00DEA57B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00DEA57B00FFFFFF00B5848400E7C6B500FFFF
          FF00FFFFFF00FFFFFF00DEA57B00C6847300FFFFFF00DEA57B00C6847300FFFF
          FF00DEA57B00C6847300FFFFFF00FFFFFF00FFFFFF00B5848400E7C6B500FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C684730000000000E7C6
          B500E7C6B500E7C6B500E7C6B500E7C6B500E7C6B500D6BDB500D6BDB500D6B5
          AD00D6B5AD00C6ADA500C6ADA500C6A59C00C6A59C0000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00800100000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000008001
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000004B00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000004B0000004B00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000004B000034CB5C0017A72B00004B0000004B0000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000004B00003ED76D003ED76D0025BA43000C971800004B0000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000004B00003ED76D0034CB5B00004B0000004B0000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000004B0000004B00000000000000000000000000000000
          00000000000000000000000000000000000000000000035A910002416A000454
          8600000000000000000000000000004B00000000000000000000000000000000
          00000000000000000000000000000000000002558E002882A500533924000911
          14000B5B88000000000000000000000000000000000000000000000000000000
          000000000000000000000000000002558E001CBFFF003692AD00FFCF89006244
          2D000D2433000000000000386C0000386C000000000000000000000000000000
          00000000000002558E001BADEB001697D5003FC5FE005DBAE000DAA97600CB92
          5E00161D23000E60960000386C0000386C00033E640000000000000000000000
          000002558E002BC2FE0051D4FF0041A0D00099D3EF00EDFFFF00D4D0C900836E
          580018445B0044ABDE004AADD700695A46000A0A0900013B6500046099001680
          B8005CD3FF008CDDFF00C1EDFF00D0EBF7004093B8009DCCE20072BBDD002182
          B6000C96CF0031C2FF001AA5E000C2AC8600623C230000243D00035188000255
          8E00BFE5F700F8FFFF00EEFBFF00D0F2FF0045ABD700027FB6000075AA00006F
          A5000493C9001FB7F8001EC1FF0064A5AD0072503300002A470002558E00AAD0
          E30002558E008AC5DE007ACEF40057D0FF0039CAFF001EAFED000B84C0000173
          AA000089BC000FA1DC0021BCFB00129DDD000C4B6D0000447600000000000255
          8E0002558E0002558E00148AC5001498D7001CB1F20021BAFA001FB4F40017A1
          E0000774AC0000578A0006609A00000000000000000000000000000000000000
          0000000000000000000000000000056BA50004649E00087AB5000474AF000051
          8800000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFB0000FFF30000FFE00000FFC00000FFE00000FFF30000FE3B0000FC1F
          0000F8130000E0010000C000000000000000000000000000000080070000F83F
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000660000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000660000006600000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000660000006600004DD777002ABA43000066000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000066000058E0870058E087003CC95E0019AC2C0000660000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000006600000066000058E087004DD776000066000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000660000006600000000000000000000000000000000
          000000000000000000000000000000000000000000000975A700075C84000C6F
          9D00000000000000000000660000000000000000000000000000000000000000
          0000000000000000000000000000000000000670A4003F9AB8006E533B001521
          260018769F000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000670A40031CDFF0050A8BF00FFDAA0007C5F
          45001B3B4C000000000000528600005286000000000000000000000000000000
          0000000000000670A4002FBFF00028ACDF0059D2FE0078C9E700E3BB8F00D7A8
          7900283239001D7BAB0000528600005286000A587E0000000000000000000000
          00000670A40043D0FE006CDEFF005CB4DB00AEDDF300F1FFFF00DEDBD5009B88
          73002C5F76005FBDE60065BFE000837561001716150004557F000C7BAE002998
          C80077DDFF00A3E5FF00CFF1FF00DBF0F9005AA9C800B1D8E9008BCAE500379A
          C6001AABDA004AD0FF002EB8E700D0BE9D007C563900023B5700086C9F000670
          A400CDEBF900FAFFFF00F2FCFF00DBF5FF0060BDE0000697C600008EBC000089
          B8000BA9D50034C7FA0033CFFF007EB8BF008B6B4C00014262000670A400BCDB
          EA000670A400A1D2E60093D9F70072DBFF0053D6FF0033C0F100189CCE00058C
          BC0000A0CB001FB5E40037CBFC0023B1E5001A668700025F8F00000000000670
          A4000670A4000670A40026A1D20026ADE00031C2F50037C9FB0034C4F7002AB5
          E700128DBE000172A1000F7BAF00000000000000000000000000000000000000
          00000000000000000000000000000E85B8000C7EB2001393C5000B8DC000006C
          9F00000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFF70000FFF30000FFC10000FFC00000FFC10000FFF30000FE370000FC1F
          0000F8130000E0010000C000000000000000000000000000000080070000F83F
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000000000A130
          00000000000000000000A1300000000000000000000000000000006D0300006D
          030000000000000000009933000099330000993300000000000000000000A130
          00000000000000000000A130000000000000006D0300006D0300006D030029BA
          4400006D0300000000009933000000000000000000009933000000000000A130
          0000A1300000A1300000A130000000000000006D030058E0870058E087003CC9
          5F001AAD2C00006D03009933000099330000993300009933000000000000A130
          00000000000000000000A130000000000000006D0300006D0300006D03004CD7
          7600006D03000000000099330000000000000000000099330000000000000000
          0000A1300000A130000000000000000000000000000000000000006D0300006D
          0300000000000000000099330000993300009933000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000975A700075C84000C6F
          9D00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000670A4003F9AB8006E533B001521
          260018769F000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000670A40031CDFF0050A8BF00FFDAA0007C5F
          45001B3B4C000000000000528600005286000000000000000000000000000000
          0000000000000670A4002FBFF00028ACDF0059D2FE0078C9E700E3BB8F00D7A8
          7900283239001D7BAB0000528600005286000A587E0000000000000000000000
          00000670A40043D0FE006CDEFF005CB4DB00AEDDF300F1FFFF00DEDBD5009B88
          73002C5F76005FBDE60065BFE000837561001716150004557F000C7BAE002998
          C80077DDFF00A3E5FF00CFF1FF00DBF0F9005AA9C800B1D8E9008BCAE500379A
          C6001AABDA004AD0FF002EB8E700D0BE9D007C563900023B5700086C9F000670
          A400CDEBF900FAFFFF00F2FCFF00DBF5FF0060BDE0000697C600008EBC000089
          B8000BA9D50034C7FA0033CFFF007EB8BF008B6B4C00014262000670A400BCDB
          EA000670A400A1D2E60093D9F70072DBFF0053D6FF0033C0F100189CCE00058C
          BC0000A0CB001FB5E40037CBFC0023B1E5001A668700025F8F00000000000670
          A4000670A4000670A40026A1D20026ADE00031C2F50037C9FB0034C4F7002AB5
          E700128DBE000172A1000F7BAF00000000000000000000000000000000000000
          00000000000000000000000000000E85B8000C7EB2001393C5000B8DC000006C
          9F00000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00B7310000B416000084000000B4160000CF310000FFFF0000FE3F0000FC1F
          0000F8130000E0010000C000000000000000000000000000000080070000F83F
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000000000078D
          BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
          BE00078DBE00078DBE00078DBE00078DBE000000000000000000078DBE0025A1
          D10072C7E70085D7FA0066CDF90065CDF90065CDF90065CDF90065CDF80065CD
          F90065CDF80066CEF90039ADD800078DBE000000000000000000078DBE004CBC
          E70039A8D100A0E2FB006FD4FA006FD4F9006ED4FA006FD4F9006FD4FA006FD4
          FA006FD4FA006ED4F9003EB1D90084D7EB00078DBE0000000000078DBE0072D6
          FA00078DBE00AEEAFC0079DCFB0079DCFB0079DCFB0079DCFB0079DCFB007ADC
          FB0079DCFA0079DCFA0044B5D900AEF1F900078DBE0000000000078DBE0079DD
          FB001899C7009ADFF30092E7FB0084E4FB0083E4FC0083E4FC0084E4FC0083E4
          FC0083E4FB0084E5FC0048B9DA00B3F4F900078DBE0000000000078DBE0082E3
          FC0043B7DC0065C3E000ACF0FD008DEBFC008DEBFC008DEBFD008DEBFD008DEB
          FC008DEBFD000C8518004CBBDA00B6F7F9006DCAE000078DBE00078DBE008AEA
          FC0077DCF300229CC600FDFFFF00C8F7FE00C9F7FE00C9F7FE00C9F7FE00C8F7
          FE000C8518003CBC5D000C851800DEF9FB00D6F6F900078DBE00078DBE0093F0
          FE0093F0FD001697C500078DBE00078DBE00078DBE00078DBE00078DBE000C85
          180052D97F0062ED970041C465000C851800078DBE00078DBE00078DBE009BF5
          FE009AF6FE009AF6FE009BF5FD009BF6FE009AF6FE009BF5FE000C85180046CE
          6C0059E4880058E1880061EB940040C165000C85180000000000078DBE00FEFE
          FE00A0FBFF00A0FBFE00A0FBFE00A1FAFE00A1FBFE000C8518000C8518000C85
          18000C85180056E1840047CD6E000C8518000C8518000C85180000000000078D
          BE00FEFEFE00A5FEFF00A5FEFF00A5FEFF00078CB60043B7DC0043B7DC0043B7
          DC000C8518004EDD790036BA54000C8518000000000000000000000000000000
          0000078DBE00078DBE00078DBE00078DBE000000000000000000000000000000
          00000C85180040D065000C851800000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000C85
          18002AB743002DBA49000C851800000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000C85
          180021B538000C85180000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000C8518000C8518000C85
          18000C8518000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000C8518000C8518000C8518000C8518000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00800300000003000000010000000100000001000000000000000000000000
          0000000100000000000080030000C3C70000FF870000FF8F0000FE1F0000F87F
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000097433F0097433F00B59A9B00B59A9B00B59A9B00B59A9B00B59A9B00B59A
          9B00B59A9B009330300097433F00000000000000000000000000000000009743
          3F00D6686800C6606000E5DEDF0092292A0092292A00E4E7E700E0E3E600D9DF
          E000CCC9CC008F201F00AF46460097433F000000000000000000000000009743
          3F00D0656600C25F5F00E9E2E20092292A0092292A00E2E1E300E2E6E800DDE2
          E400CFCCCF008F222200AD46460097433F000000000000000000000000009743
          3F00D0656500C15D5D00ECE4E40092292A0092292A00DFDDDF00E1E6E800E0E5
          E700D3D0D2008A1E1E00AB44440097433F000000000000000000000000009743
          3F00D0656500C15B5C00EFE6E600EDE5E500E5DEDF00E0DDDF00DFE0E200E0E1
          E300D6D0D200962A2A00B24A4A0097433F000000000000000000000000009743
          3F00CD626300C8606000C9676700CC727200CA727100C6696900C4646400CC6D
          6C00CA666700C55D5D00CD65650097433F000000000000000000000000009743
          3F00B6555300C27B7800D39D9C00D7A7A500D8A7A600D8A6A500D7A09F00D5A0
          9F00D7A9A700D8ABAB00CC66670097433F000000000000000000000000009743
          3F00CC666700F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9
          F900F9F9F900F9F9F900CC66670097433F000000000000000000000000009743
          3F00CC666700F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9
          F900F9F9F900F9F9F900CC66670097433F000000000000000000000000009743
          3F00CC666700F9F9F900CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCD
          CD00CDCDCD00F9F9F900CC66670097433F000000000000000000000000009743
          3F00CC666700F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9
          F900F9F9F900F9F9F900CC66670097433F000000000000000000000000009743
          3F00CC666700F9F9F900CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCD
          CD00CDCDCD00F9F9F900CC66670097433F000000000000000000000000009743
          3F00CC666700F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9
          F900F9F9F900F9F9F900CC66670097433F000000000000000000000000000000
          000097433F00F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9
          F900F9F9F900F9F9F90097433F00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000C007000080030000800300008003000080030000800300008003
          0000800300008003000080030000800300008003000080030000C0070000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000CA680000CA680000CA680000CA680000CA680000CA680000CA680000CA68
          0000CA680000CA680000CA680000CA680000000000000000000000000000CA68
          0000FFE9CF00FFE5C900FEE2C100FEDEBC00FEDAB500FED9B000FED5AA00FFD3
          A500FED0A000FECF9D00FECC9900FECB9600CA6800000000000000000000CA68
          0000FFEBD700FEE7CF00FFE5C900FEE2C200FEDEBB00FEDCB500FED9B000FED5
          AB00FED3A500FED0A000FECF9D00FECC9800CA6800000000000000000000CA68
          0000FFEEDC00FEEBD700FEE7CF00FEE5C900FEE2C100FFDEBB00FEDCB600FED9
          B000FED5AB00FED3A500FED1A000FECE9C00CA6800000000000000000000CA68
          0000FEF2E300BC4B0000BC4B0000BC4B0000BC4B0000FEE2C100FEDEBC000000
          82000000820000008200FED3A500FED0A000CA6800000000000000000000CA68
          0000FFF4E900BC4B0000FEEFDD00FEEBD700FFE7CF00BC4B0000FEE2C2000000
          8200FFDCB600FED9AF0000008200FED3A500CA6800000000000000000000CA68
          0000FFF7EE00BC4B0000FEF2E200FFEFDD00FFEBD700BC4B0000FFE5C9000000
          8200FEDEBB00FEDCB60000008200FED5AA00CA6800000000000000000000CA68
          0000FFFAF400BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000FFE9CF000000
          8200FFE1C100FEDEBC0000008200FED8AF00CA6800000000000000000000CA68
          0000FFFBF800BC4B0000FFF7EF00FFF4E700FEF0E200BC4B0000FFEBD7000000
          82000000820000008200FEDEBC00FEDCB600CA6800000000000000000000CA68
          0000FFFCFB00BC4B0000FFFAF300FFF6EE00FEF3E900BC4B0000FFEFDD000000
          8200FEE7D000FEE5C900FFE1C200FFDEBB00CA6800000000000000000000CA68
          0000FFFFFF00BC4B0000BC4B0000BC4B0000BC4B0000FFF4E900FFF2E2000000
          8200FFEAD700FEE9D000FEE5C900FEE1C200CA6800000000000000000000CA68
          0000FFFFFF00FFFFFF00FFFEFB00FFFBF800FEFAF300FEF7EE00FEF4E700FEF2
          E200FFEEDD00FFEBD500FEE9CF00FFE5C900CA6800000000000000000000CA68
          0000FFFFFF00FFFFFF00FFFFFF00FFFCFC00FFFCF700FFFAF300FFF7EE00FFF4
          E900FFF2E200FFEFDD00FFEBD500FEE9CF00CA68000000000000000000000000
          0000CA680000CA680000CA680000CA680000CA680000CA680000CA680000CA68
          0000CA680000CA680000CA680000CA6800000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000C003000080010000800100008001000080010000800100008001
          0000800100008001000080010000800100008001000080010000C0030000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000D6820000D6820000D6820000D6820000D6820000D6820000D6820000D682
          0000D6820000D6820000D6820000D6820000000000000000000000000000D682
          0000FFEEDA00FFEBD500FEE9CF00FEE6CB00FEE3C500FEE2C100FEDFBC00FFDD
          B800FEDBB400FEDAB100FED8AE00FED7AB00D68200000000000000000000D682
          0000FFF0E000FEEDDA00FFEBD500FEE9D000FEE6CA00FEE4C500FEE2C100FEDF
          BD00FEDDB800FEDBB400FEDAB100FED8AD00D68200000000000000000000D682
          0000FFF2E400FEF0E000FEEDDA00FEEBD500FEE9CF00FFE6CA00FEE4C600FEE2
          C100FEDFBD00FEDDB800FEDCB400FED9B000D68200000000000000000000D682
          0000FEF5EA00CB660000CB660000CB660000FFEBD500FEE9CF0000009A000000
          9A0000009A0000009A00FEDDB800FEDBB400D68200000000000000000000D682
          0000FFF7EE00CB660000FEF3E500FEF0E000CB660000FEEBD50000009A00FEE6
          CB00FFE4C600FEE2C00000009A00FEDDB800D68200000000000000000000D682
          0000FFF9F200CB660000FEF5E900FFF3E500CB660000FFEEDB0000009A00FFE8
          D000FEE6CA00FEE4C60000009A00FEDFBC00D68200000000000000000000D682
          0000FFFBF700CB660000FFF7EE00FEF5EA00CB660000FEF0E00000009A000000
          9A0000009A0000009A0000009A00FEE1C000D68200000000000000000000D682
          0000FFFCFA00CB660000CB660000CB660000FEF4E900FFF2E40000009A00FEEE
          DB00FEEBD500FEE8CF0000009A00FEE4C600D68200000000000000000000D682
          0000FFFDFC00CB660000FFFBF600FFF8F200FEF6EE00FFF5E90000009A00FFF0
          DF00FEEDDB00FEEBD50000009A00FFE6CA00D68200000000000000000000D682
          0000FFFFFF00CB660000FFFDF900FFFBF600FFF9F200FFF7EE0000009A000000
          9A0000009A0000009A00FEEBD500FEE8D000D68200000000000000000000D682
          0000FFFFFF00FFFFFF00FFFEFC00FFFCFA00FEFBF600FEF9F200FEF7ED00FEF5
          E900FFF2E500FFF0DF00FEEEDA00FFEBD500D68200000000000000000000D682
          0000FFFFFF00FFFFFF00FFFFFF00FFFDFD00FFFDF900FFFBF600FFF9F200FFF7
          EE00FFF5E900FFF3E500FFF0DF00FEEEDA00D682000000000000000000000000
          0000D6820000D6820000D6820000D6820000D6820000D6820000D6820000D682
          0000D6820000D6820000D6820000D68200000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000C003000080010000800100008001000080010000800100008001
          0000800100008001000080010000800100008001000080010000C0030000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000FF0000C6C6C6000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000C6C6C60000FF0000C6C6C60000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000FF0000C6C6C60000FF0000C6C6C600000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000C6C6C60000FF0000C6C6C60000FF0000C6C6C6000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000FF0000C6C6C60000FF0000C6C6C60000FF0000C6C6
          C600000000000000000000000000000000000000000000000000000000000000
          00000000000000000000C6C6C60000FF0000C6C6C60000FF0000C6C6C60000FF
          0000C6C6C6000000000000000000000000000000000000000000000000000000
          0000000000000000000000FF0000C6C6C60000FF0000C6C6C60000FF0000C6C6
          C60000FF0000C6C6C60000000000000000000000000000000000000000000000
          00000000000000000000C6C6C60000FF0000C6C6C60000FF0000C6C6C60000FF
          0000C6C6C6000000000000000000000000000000000000000000000000000000
          0000000000000000000000FF0000C6C6C60000FF0000C6C6C60000FF0000C6C6
          C600000000000000000000000000000000000000000000000000000000000000
          00000000000000000000C6C6C60000FF0000C6C6C60000FF0000C6C6C6000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000FF0000C6C6C60000FF0000C6C6C600000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000C6C6C60000FF0000C6C6C60000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000FF0000C6C6C6000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000F3FF0000F1FF0000F0FF0000F07F0000F03F0000F01F0000F00F
          0000F00F0000F01F0000F03F0000F07F0000F0FF0000F1FF0000F3FF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          0000C6C6C6000000000000000000000000000000000000FF0000C6C6C6000000
          000000000000000000000000000000000000000000000000000000000000C6C6
          C60000FF0000C6C6C600000000000000000000000000C6C6C60000FF0000C6C6
          C6000000000000000000000000000000000000000000000000000000000000FF
          0000C6C6C60000FF0000C6C6C600000000000000000000FF0000C6C6C60000FF
          0000C6C6C600000000000000000000000000000000000000000000000000C6C6
          C60000FF0000C6C6C60000FF0000C6C6C60000000000C6C6C60000FF0000C6C6
          C60000FF0000C6C6C600000000000000000000000000000000000000000000FF
          0000C6C6C60000FF0000C6C6C60000FF00008484840000FF0000C6C6C60000FF
          0000C6C6C60000FF0000C6C6C60000000000000000000000000000000000C6C6
          C60000FF0000C6C6C60000FF0000C6C6C60084848400C6C6C60000FF0000C6C6
          C60000FF0000C6C6C60000FF0000C6C6C60000000000000000000000000000FF
          0000C6C6C60000FF0000C6C6C60000FF00008484840000FF0000C6C6C60000FF
          0000C6C6C60000FF0000C6C6C60000FF0000C6C6C6000000000000000000C6C6
          C60000FF0000C6C6C60000FF0000C6C6C60084848400C6C6C60000FF0000C6C6
          C60000FF0000C6C6C60000FF0000C6C6C60000000000000000000000000000FF
          0000C6C6C60000FF0000C6C6C60000FF00008484840000FF0000C6C6C60000FF
          0000C6C6C60000FF0000C6C6C60000000000000000000000000000000000C6C6
          C60000FF0000C6C6C60000FF0000C6C6C60000000000C6C6C60000FF0000C6C6
          C60000FF0000C6C6C600000000000000000000000000000000000000000000FF
          0000C6C6C60000FF0000C6C6C600000000000000000000FF0000C6C6C60000FF
          0000C6C6C600000000000000000000000000000000000000000000000000C6C6
          C60000FF0000C6C6C600000000000000000000000000C6C6C60000FF0000C6C6
          C6000000000000000000000000000000000000000000000000000000000000FF
          0000C6C6C6000000000000000000000000000000000000FF0000C6C6C6000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF00009E7F00008E3F0000861F0000820F000080070000800300008001
          0000800100008003000080070000820F0000861F00008E3F00009E7F0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000008400000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000008400000084000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000840000008400
          0000840000008400000084000000840000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000008400000084000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000008400000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000FE730000FCF90000FCF90000FCF90000FCF90000F9FC
          0000ECF90000E4F9000000F90000E4F90000EE730000FFFF0000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF000000FF000000FF0000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF000000FF000000FF0000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
          0000000000000000000000000000000000000000000000000000000000008484
          84000000FF000000FF0000000000000000000000FF000000FF000000FF000000
          0000000000000000000000000000000000000000000000000000848484000000
          FF0000000000000000000000000000000000000000000000FF000000FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF000000FF000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000FF000000
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF000000FF000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000848484000000FF0000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000848484000000FF00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000FF0000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000F9FF0000F0FF0000F0FF0000E07F0000C07F0000843F
          00001E3F0000FE1F0000FF1F0000FF8F0000FFC70000FFE30000FFF80000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFB0000EFFF0000C7F70000C7EF0000E3CF0000F19F0000F83F
          0000FC7F0000F83F0000F1BF0000C3CF000087E700009FF30000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          000084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          000084FFFF0084848400848484008484840084FFFF0000000000000000000000
          00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
          000084FFFF0084848400848484008484840084FFFF00000000000000000084FF
          FF0084FFFF0084FFFF0084FFFF0084FFFF000000000000000000000000000000
          000084FFFF0084FFFF0084FFFF0084FFFF0084FFFF00000000000000000084FF
          FF0084848400848484008484840084FFFF0000000000FFFFFF00FFFFFF000000
          00000000000000000000000000000000000000000000000000000000000084FF
          FF0084848400848484008484840084FFFF0000000000FFFFFF00FFFFFF000000
          00000000000000000000000000000000000000000000000000000000000084FF
          FF0084FFFF0084FFFF0084FFFF0084FFFF0000000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
          00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
          00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF0000000000FFFFFF0000000000000000000000000000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000C0030000C0030000C0000000C0000000C0000000000000000000
          00000000000000000000000300000003000000030000C0070000C00F0000C01F
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000CE63
          0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
          0000CE630000CE630000CE630000CE630000CE630000CE63000000000000CE63
          0000FFFFFF00FFFFF700948C8C00948C8C00948C8C00948C8C00FFD6AD00FFD6
          AD00FFD6AD00FFD6AD00FFD6AD00FFD6AD00FFD6AD00CE63000000000000CE63
          0000FFFFFF00FFFFFF00313129006B7394001029A50021213900FFE7C600FFDE
          B500FFD6AD00FFD6AD00FFD6AD00FFD6AD00FFD6AD00CE63000000000000CE63
          0000FFFFFF00FFFFFF0031313900637BE700FFFFF70010219C00FFEFD600FFE7
          C600FFDEB500FFD6AD00FFD6AD00FFD6AD00FFD6AD00CE63000000000000CE63
          0000FFFFFF00FFFFFF0042424200524A4A005A524A00182994006373D600FFEF
          D600FFE7C600FFDEB500FFD6AD00FFD6AD00FFD6AD00CE63000000000000CE63
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00637BE700425A
          E700FFEFD600FFE7C600FFDEB500FFD6AD00FFD6AD00CE63000000000000CE63
          0000FFFFFF00FFFFFF00948C8C00948C8C00948C8C00948C8C00FFFFFF00FFFF
          FF00FFF7E700FFEFD600FFE7C600FFDEB500FFD6AD00CE63000000000000CE63
          0000FFFFFF00FFFFFF00313129006B7394001029A50021213900FFFFFF00FFFF
          FF00FFFFF700FFF7E700FFEFD600FFE7C600FFDEB500CE63000000000000CE63
          0000FFFFFF00FFFFFF0031313900637BE700FFFFFF0010219C00FFFFFF00FFFF
          FF00FFFFFF00FFFFF700FFF7E700FFEFD600FFE7C600CE63000000000000CE63
          0000FFFFFF00FFFFFF0042424200524A4A005A524A00182994006373D600FFFF
          FF00FFFFFF00FFFFFF00FFFFF700FFF7E700FFEFD600CE63000000000000CE63
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00637BE700425A
          E700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7E700CE63000000000000CE63
          0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
          0000CE630000CE630000CE630000CE630000CE630000CE630000000000000000
          0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
          0000CE630000CE630000CE630000CE630000CE63000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF00008000000080000000800000008000000080000000800000008000
          00008000000080000000800000008000000080000000C0010000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000046F0800046F
          080000000000000000000000000000000000000000000000000000000000B781
          8300B7818300B7818300B7818300B78183005A784300046F08002DB547001D9E
          3000046F0800B7818300B7818300B7818300000000000000000000000000B781
          8300F9EACB00FAE7C700F9E5C100046F08001689230042D0670037C557002EBD
          4A00046F0800F6D8A300F6D6A000B7818300000000000000000000000000B781
          8300FBECD300FAE9CE00F9E7C800046F08004FDD7A00046F080008730C0022A8
          380020A5340039832900F6D8A400B7818300000000000000000000000000B481
          7600FBEFD900EFCC9A00EFCB9700EFC99500046F080068964300EEC78D00046F
          08001FA23100046F0800F6DBA900B7818300000000000000000000000000B481
          7600FCF2E000FBF0DB00FBEED600EEE5C700FAE9CB00FAE7C600F9E5C100F8E2
          BD00046F080015942400518E3B00B7818300000000000000000000000000BA8E
          8500FCF4E500F0CFA000F0CD9E00F0CC9C00F0CB9900EFCA9600EFC99400EFC8
          9100EEC78F0007730B00107F16005B734100000000000000000000000000BA8E
          8500FDF7EC00FDF5E800FCF3E300FCF1DD00FBEFD900FBEDD400FBEBCF00FAE9
          CA00F9E6C50080AC670006740A00166D1300000000000000000000000000CB9A
          8200FEF9F100F1D1A600F1D0A400F0CFA200F0CE9F00F0CD9D00F0CC9A00EFCB
          9800EFCA9500EFC8930079A86200026C0500046F08000000000000000000CB9A
          82001963AC001963AC001963AC001963AC001963AC00FCF2E100FBF0DC00FBEE
          D700FAECD200FAEACE00F9E8C9003B762E0009680C0000000000000000001963
          AC0053B7FF004CB0FF0047ABFF0047ABFF001963AC00F1D0A300F0CFA100F0CE
          9F00F0CD9C00F0CB9A00FBEBCF00B7818300046F08000066000000000000DCA8
          87001963AC0057BBFF0050B3FF0049ADFF001963AC00FDF7ED00FDF6E900FCF3
          E400FBF1E000FCEFDA00FBEED600B78183000000000000000000000000001963
          AC006ED0FF0065C8FF005CBFFF0054B7FF001963AC00F1D2A900F1D1A700F1D0
          A500F1D0A300F0CEA000FBF0DC00B781830000000000000000001963AC0076D8
          FF0076D8FF0071D4FF001963AC0061C4FF001963AC00FFFBF700FEFAF300FEF8
          F000FDF7EB00FDF5E700FCF3E300B78183000000000000000000000000001963
          AC0076D8FF001963AC00FFFFFF001963AC00FFFEFE00FEFDFB00FEFCF800FEFB
          F500FEF9F100FDF7ED00FDF5E800B7818300000000000000000000000000EDBD
          92001963AC00DCA88700DCA88700DCA88700DCA88700DCA88700DCA88700DCA8
          8700DCA88700DCA88700DCA88700DCA887000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FF3F00008003000080030000800300008003000080030000800300008003
          0000800100008001000080000000800300008003000000030000800300008003
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000B0808000B0808000B0808000B0808000B0808000B0808000B0808000B080
          8000B0808000B0808000B0808000B08080000000000000000000000000000000
          0000B0808000F0E0C000F0DFBF00F0D0B000F0D0AF00F0D0AF00EFCFA000EFCF
          9F00EFCF9F00EFCF9000EFCF9000B08080000000000000000000000000000000
          0000B0808000F0E0CF006060600070707000808080008F8F8F008F8F8F008F8F
          8F008F8F8F0090909000EFCF9000B08080000000000000000000000000000000
          0000B0808000F0EFDF00F0E0CF00F0DFC000F0DFBF00F0D0B000F0D0AF00EFCF
          A000EFCF9F00EFCF9000EFCF9000B08080000000000000000000000000000000
          0000B0808000F0EFDF00F0E0CF00F0E0CF00F0DFC000F0DFBF00F0D0AF00F0D0
          AF00EFCF9F00EFCF9F00EFCF9000B08080000000000000000000000000000070
          0F00B0808000FFF0EF000050AF000050AF000060CF000060CF000060CF000060
          CF000060CF000060CF00EFCF9F00B0808000000000000000000000700F00009F
          000000700F00FFF0EF0010F0FF0010F0FF0010F0FF0080FFFF0080FFFF00C0FF
          FF00C0FFFF00C0FFFF00EFCF9F00B08080000000000000000000009F0000009F
          0000009F000000700F0010F0FF0010F0FF0010F0FF0010F0FF0010F0FF0080FF
          FF0080FFFF00C0FFFF00F0D0AF00B0808000000000000000000000000000009F
          0000BFD0A000FFFFFF000050AF000050AF000060CF000060CF000060CF000060
          CF000060CF000060CF00F0D0AF00B08080000000000000000000000000000000
          0000B0808000FFFFFF00FFFFFF00FFFFFF00FFF0EF00F0EFE000F0EFDF00F0E0
          D000F0E0CF00F0DFC000F0DFBF00B08080000000000000000000000000000000
          0000B0808000FFFFFF00FFFFFF00FFFFFF00FFF0F000FFF0EF00F0EFE000F0EF
          DF00F0E0CF00F0E0CF00CFBFAF00B08080000000000000000000000000000000
          0000B0808000FFFFFF005050500060606000808080008F8F8F0090909000FFF0
          EF00B0807000AF807000AF7F7000AF7F70000000000000000000000000000000
          0000B0808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF0F000FFF0
          EF00B0807000E0B08000EFA05000B08080000000000000000000000000000000
          0000B0808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00B0807000EFC08F00B0808000000000000000000000000000000000000000
          0000B0808000B0808000B0808000B0808000B0808000B0808000B0808000B080
          8000B0807000B080800000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00C0030000C0030000C0030000C0030000C003000080030000000300000003
          000080030000C0030000C0030000C0030000C0030000C0070000C00F0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000A73A800258AC200258AC2000A73
          A800000000000000000000000000000000000000000000000000000000000000
          000000000000086EA3002982AE002291C60023A4DD001E9ED500158FC3000C7B
          A900057AA80000669A0000000000000000000000000000000000000000000000
          0000086EA3008E8CA900B15A5B007E5963003588B1002AABE600158FA9000AB2
          BF0008A8B900058AB8000090C80000669A00000000000000000000000000086E
          A30072B9EC00C0737C00D9615D00D65F5C0072535F001EA6CD0002FAFB0000FF
          FF0000FFFF0002B8DE00197C980005789E0000669A0000000000157BB10058B7
          E9004EABDE00769CBC00A6869C008695B7005B92BD0026C3EC0019DCF70016CE
          EF0016B5E400759E7900E8880000BD7B1000376862000075A8002F93CC002A6A
          F7000E3CE0001F59BC003F9CCE004DC0FF0047BCFA0043B4F0003CAEEA0027A9
          EB004BA3B800F79A0800FF9A0000FF9B0000927F3500007DB900258AC2004096
          FA000235FF000023FB002154B3005CBEF90055C0FF0049B8F40040B5EF0034B0
          E9002DAEE60042AAC7005AA5A30086A172002A9CB2000075A800000000001F84
          BB0050AAFF004296FF004796E40039928B0047A1C80049B0EC003BABE6003EB3
          ED00259CD2000D81B90000669A000081C00000669A0000000000000000001F84
          BB0054B9F10063CCF6003CAA7E002FBF5A002A965300317FA80000000000288C
          BD00000000000000000000000000000000000000000000000000000000000000
          00000A73A800298DC60049C9B70041C99A004CC8B60056B9F00046A9E300369E
          D6000A73A8000000000000000000000000000000000000000000000000000000
          000000000000000000000A73A8001D82B9002F93CC002F93CC002086BD000A73
          A800000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000FC3F0000E00F0000C003000080010000000000000000
          0000000000008001000080BF0000C01F0000F03F0000FFFF0000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000158320001583
          2000158320001583200015832000158320001583200015832000158320001583
          2000158320001583200000000000000000000000000000000000158320001583
          2000158320001583200015832000158320001583200015832000158320001583
          2000158320001583200000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00001963AD000000000000000000000000000000000000660000006600000066
          0000006600000066000000660000000000000000000000000000000000000000
          00001963AD001963AD00000000000000000000000000006600003DBF5F002BAE
          45001BA12D000E951900006600000000000000000000000000001963AD001963
          AD003CA1EE003FA6FE001963AD00000000000000000000660000006600000066
          00000066000000660000006600000000000000000000000000001963AD00ABF4
          FF007DD2FF0055B7FF003697F1001963AD000000000000000000000000000000
          00000000000000000000000000000000000000000000000000001963AD001963
          AD007BB0DB0072BFF5001963AD00000000000000000000660000006600000066
          0000006600000066000000660000006600000066000000660000000000000000
          00001963AD001963AD000000000000000000000000000066000044C4690041C0
          63003CBC5D0033B5500029AC40001EA43100159F240004750800000000000000
          00001963AD000000000000000000000000000000000000660000006600000066
          0000006600000066000000660000006600000066000000660000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000158320001583
          2000158320001583200015832000158320001583200015832000158320001583
          2000158320001583200000000000000000000000000000000000158320001583
          2000158320001583200015832000158320001583200015832000158320001583
          2000158320001583200000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000000F0000000F0000FFFF0000DE070000CE0700000607000003FF
          000006000000CE000000DE000000FFFF0000000F0000000F0000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000FF0000000000000000000000000000000000000000000000000000000000
          00000000000000000000FF00000000000000000000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF0000000000000000000000FF0000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF0000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF0000000000000000000000000000000000
          0000FF0000000000000000000000000000000000000000000000000000000000
          00000000000000000000FF000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000FFFF0000DFF70000BFFB0000BBBB0000BBBB0000BFFB
          00007FFD0000BFFB0000BFFB0000BFFB0000BFFB0000DFF70000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF00000000000000000000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          FF000000000000000000000000000000FF000000000000000000000000000000
          FF000000000000000000000000000000FF000000000000000000000000000000
          FF000000000000000000000000000000FF000000000000000000000000000000
          FF000000000000000000000000000000FF000000000000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF0000000000000000000000FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000FF0000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          00000000FF000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000FFFF0000DFF70000BFFB0000BBBB0000BBBB0000BFFB
          00007FFD0000BFFB0000BFFB0000BFFB0000BFFB0000DFF70000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000D9A77D00A3760000A3760000A3760000D9A77D000000000000000000D9A7
          7D00A3760000A3760000A3760000D9A77D000000000000000000000000000000
          0000A3760000D9A77D00CB8C4400CB8C4400A37600000000000000000000A376
          0000FF9F7F00CB8C4400CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FF9F7F00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FF9F7F00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000AA7F
          5500FFFFCC00D9A77D00CB8C4400A37600000000000000000000000000000000
          0000AA7F5500FFFFCC00FFFFCC00D9A77D00A37600000000000000000000AA7F
          5500FFFFCC00FFFFCC00FF9F7F00A37600000000000000000000000000000000
          0000D9A77D00AA7F5500AA7F5500AA7F5500D9A77D000000000000000000D9A7
          7D00AA7F5500AA7F5500AA7F5500D9A77D000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00C1830000C1830000C1830000C1830000C1830000C1830000C1830000C183
          0000C1830000C1830000C1830000C1830000C1830000C1830000C1830000C183
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000CB8C4400A6540000633600006336
          0000A65400000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000A3760000D9A77D00CB8C4400CB8C
          4400CB8C44006336000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000A3760000D9A77D00D9A77D00CB8C
          4400CB8C4400A3760000A6540000000000000000000000000000000000000000
          000000000000000000000000000000000000A3760000D9A77D00D9A77D00D9A7
          7D00CB8C4400A3760000A6540000000000000000000000000000000000000000
          000000000000000000000000000000000000A3760000D9A77D00D9A77D00D9A7
          7D00D9A77D00A3760000A6540000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000A3760000FFFFCC00FFFF
          CC00FFFFCC00FFFFCC00A3760000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000A3760000A376
          0000A3760000A3760000CB8C4400000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000001FFF000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000001F
          FF00001FFF00001FFF0000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000001FFF00001F
          FF00001FFF00001FFF00001FFF00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000001FFF000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000001F
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000001FFF0000000000001FFF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FC1F0000FC0F0000FC070000FC070000FC070000FE070000FF07
          0000FFDF0000FF8F0000FF070000FFDF0000FFFF0000FFBF0000FAFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000CB8C4400A65400006336000063360000A65400000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000A3760000D9A77D00CB8C4400CB8C4400CB8C44006336
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000A3760000D9A77D00D9A77D00CB8C4400CB8C4400A376
          0000A65400000000000000000000000000000000000000000000000000000000
          00000000000000000000A3760000D9A77D00D9A77D00D9A77D00CB8C4400A376
          0000A65400000000000000000000000000000000000000000000000000000000
          00000000000000000000A3760000D9A77D00D9A77D00D9A77D00D9A77D00A376
          0000A65400000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000A3760000FFFFCC00FFFFCC00FFFFCC00FFFF
          CC00A37600000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000A3760000A3760000A3760000A376
          0000CB8C44000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000001FFF00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000001FFF00001FFF00001FFF000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000001FFF00001FFF00001FFF00001FFF00001FFF000000000000000000001F
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000001FFF00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000001FFF000000000000000000000000000000000000000000000000000000
          000000000000001FFF0000000000000000000000000000000000000000000000
          00000000000000000000001FFF000000000000000000001FFF0000000000001F
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000F07F0000F03F0000F01F0000F01F0000F01F0000F81F0000FC1F
          0000FFF70000FFE30000FFC10000BFF70000FFFF0000DFEF0000F6BF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000FF0000000000000000000000000000000000000000000000000000000000
          00000000000000000000FF00000000000000000000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF0000000000000000000000FF0000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF0000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF000000000000000000000000000000FF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF0000000000000000000000000000000000
          0000FF0000000000000000000000000000000000000000000000000000000000
          00000000000000000000FF000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000FFFF0000DFF70000BFFB0000BBBB0000BBBB0000BFFB
          00007FFD0000BFFB0000BFFB0000BFFB0000BFFB0000DFF70000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF00000000000000000000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          FF000000000000000000000000000000FF000000000000000000000000000000
          FF000000000000000000000000000000FF000000000000000000000000000000
          FF000000000000000000000000000000FF000000000000000000000000000000
          FF000000000000000000000000000000FF000000000000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF0000000000000000000000FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000FF0000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF000000000000000000000000000000
          00000000FF000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000FFFF0000DFF70000BFFB0000BBBB0000BBBB0000BFFB
          00007FFD0000BFFB0000BFFB0000BFFB0000BFFB0000DFF70000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000FF00000084000000FF00000084000000FF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          000000000000000000000000000000000000000000000000000000000000FFFF
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF0000000000000000000000000000000000000000000000000000000000FFFF
          FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
          840000000000000000000000000000000000000000000000000000000000FFFF
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF0000000000000000000000000000000000000000000000000000000000FFFF
          FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
          840000000000000000000000000000000000000000000000000000000000FFFF
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF00000000000000000000000000000000000000000000000000000000000000
          0000FFFFFF000000FF000000FF000000FF000000FF000000FF000000FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000084000000840000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000084000000840000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000840000008400000084000000840000008400000084000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000840000008400000084000000840000008400000084000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000084000000840000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000084000000840000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00E0FF0000C07F0000803F0000001F0000001F0000001F0000001F0000001F
          0000803F0000C07F0000E0F30000FFF30000FFC00000FFC00000FFF30000FFF3
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000000000818C
          97004F749A000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000944A240066A1
          CE002A99F100687994009F5A3B00944B2500944A2400944A2400944A2400944A
          2400944A2400944A2400944A2400944A2400944A2400944A240083422100C3E2
          F60061BEFD002E95E9007C8EAC00C9712500FEE4C600FEE1C000FEDEB900FEDB
          B400FED9B000FED7AC00FED7AB00FED7AB00FED7AB008F48230083422100FFFD
          FB00C4E0F7005CBCFD003097E8008C838300CFB5A400C3AA9B00C3A99B00D2B5
          A200E9C8A900FED9AF00FED7AB00FED7AB00FED7AB008F48230083422100FFFF
          FF00FFFDFC00BFE0F80087BDE100AFA09A00BBA29300DBB68B00E6D2B800DAC0
          A800C7A58B00E4983500FF990000FF990000FED7AB008F48230083422100FFFF
          FF004CB74C004CB74C00CABFBB00D0AA8F00F7E0B400FFFFDD00FFFFE800FFFF
          F300E1D4CB00CAAFA100FEDAB200FFD9AD00FED7AB008F48230083422100FFFF
          FF004CB74C004CB74C00C4ADA200DCB08900FFEAB200FEF9D000FFFFE500FFFF
          F900F7F4F200C4AB9A00FF990000FF990000FED8AD008F48230083422100FFFF
          FF00FFFFFF00FFFEFE00C4ACA000E5C5A100FAD09300F8E1B200FFFFE800FFFF
          F100F7F4DD00C5AE9F00FEDFBC00FEDCB600FFDAB0008F48230083422100FFFF
          FF00FFFFFF00FFFEFE00D2BEB500D9BCA000FEE3A900F5D09E00F9EBC200FDF9
          D800E5DBC100D7C09F00FF990000FF990000FEDCB5008F48230083422100FFFF
          FF006E94FF006E94FF00E8DEDA00C2A18D00E3D8C700F7E9CB00F2CD9A00E5CD
          A600CEBAA400D8C1AC00FFE4C700FEE1C100FEDEBB008F48230083422100FFFF
          FF006E94FF006E94FF00FEFEFE00C47A3900C5AEA500C1A99B00C3AA9900D2B8
          9F00D6AD8800EC952200FF990000FF990000FFE1C0008F482300B26C3900D3A3
          5C00D3A35C00D3A35C00D3A35C00D3A35C00D3A35C00D3A35C00D3A35C00D3A3
          5C00D8AE6D00D3A35C00D9AE6C00D3A35C00CAAA7700B56D3800AE5C2700DB7F
          2600DB7F2600DB7F2600DB7F2600DB7F2600DB7F2600DB7F2600DB7F2600DB7F
          2600F6BB8000DB7F2600F6BB8000B37D53004E6ED400B95D190000000000AA5A
          2F00AA5A2F00AA5A2F00AA5A2F00AA5A2F00AA5A2F00AA5A2F00AA5A2F00AA5A
          2F00AA5A2F00AA5A2F00AA5A2F00AA5A2F00AA5A2F0000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF009FFF00000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000080010000FFFF0000FFFF
          0000}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000B1300000B1301009A9C180000000467414D410000
          B19E614C41F7000000206348524D00007A30000080980000F9FF000080E80000
          75300000EA6000003A980000176FE6A93A7F000001F64944415478DA8C935D48
          537118C67F83B9BA3028DD8DD245658223FC9B5A3341D18BDA45D630EAA60421
          C288AE22BA29E8AAB01B8920C83E88BAA92EA209CB0882486D76967389279D1A
          38ECEB98C5E6A1E929DD69A78BD36CB9B3D10B7F789E17DEE7FDE0F9DB0CC300
          A0EEB4B41FF0F37FE17D7DB9FE31803D23E96F3F524FD280640AF4142B389902
          3D8D0D08F74A7EC0B65A80D8D48DAC56057F5E3A9A1A0F11CEE0F6D5057B6BE5
          BCB3DB1D2DFFF24CE22C3F46A9F3595E81BBD18DC0476B81C0AB08AEF54DF48E
          A8CCCEC668F79433FDDDC660F01D57472F526C28380B43E0F0E45E616A1E7E2C
          2500887C5B26AEE9E67D16E2146B3324D6ADC9BD426383602060DE60DB2EC170
          D0C4A535827DFA1800EEAAC3F054B116781990B97452706F40652C2873BE4330
          1983873E9933275A701426E8ECAA63033DD60235D55B387BCDEC5A515BC9855B
          262EA912745D7F02C0F68A47BC5772ACF066244A9BA78CD08CC664F82D6DBBB7
          129D5F460ACB1C68DD4351C91CB7BB0FE69E00E0D3A2414C5D00E0CB4F48E836
          00160BA2FC5AD2B27D9149DC6E17FD831300EC6C163CEFFB6BAA784F3700CD95
          2E4695616B81A1A109CE1D17F8FABF12EA93B9734A309784CF1A282A28AA8EF4
          229267821D6574DE34BB5637088E5EC9B6F5DACD9BE0C3B8A580F7814F5EF9CE
          D3F7256B2F9BC5DE34FD3D00F29DBF388347C1A70000000049454E44AE426082}
        FileName = 'Z:\ICONE\GlyFX_Full\Core I\PNG\16x16\calculator_16.png'
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000000D744558745469746C65005265636F72643B61F05A1A00
          00021A49444154785EAD915F4853711CC5675CDA2A2246180549905BD94379E3
          A220D532D4ACB9B0F225A23F4241116E456F116668596B08455820482E2A2828
          58841425F4074DCD87B9BA45D3D9823518222151912FA7DFF932F2765F6B70B8
          87733EDF03F7CE01E09FF47F06745D771886217AD47CDA3970F1FC89C170FBD0
          50F8C2378A9E19BB3CC79BD9018FC723CF672DCD45FDE75A4793376F20D71BC3
          74DF634A3C337664C87ABDDED901B7DBEDE80936B95EB59C191DEFE9C6D7FBB7
          3115BD8EC9AECB14BD64EC1493B8753C348F377F06D4AFA037183A695EBD82C9
          EE4E6423AD180E1DC393C6468A9E997464C8F2C63AA0DDDBD5F06622D28E2FAD
          A730DC7404FD9D5D30DF7D8269A6C58F048F4A47862C6FAC03CE3BB58199F1C3
          FB903AB4174F0F1E402A994126374DD133938E8C627FF1C63AE08AFA6A663E34
          F8F13E5085079B37213D91456EEA87289DCA3293CEDCED47D457FD9D377F0D5C
          3336C407AB2BF176AB0FCFEBFD18084790F99CA3C4BFDC59271D19B2F60167DB
          AAD2B3B1B20AC42B2B90D8518B17F57578B8C547894F046AA42343D6FE0ADA9A
          F90B9775AC5C978CE90646369623BEBD0AE6FE3D14BD64EC143346D6FE110B94
          5CDB16159687979724EF96AC45DFFA52BC2ED329F1CC54374686ACFD6FA4E628
          2D58AACD2D0EB98B3ADA0A8B3F5E5AE2FD49D133634726CF3AAC03F264915F5F
          ACB442693545CF8C1D19B2F601ABF83A9A92530E44E235765690B7BF01D76404
          F64F3219EB0000000049454E44AE426082}
        FileName = 'Images\Arrows\Record_16x16.png'
        Keywords = 'Arrows;Record'
      end>
  end
  object CompletionImageList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 12582976
  end
end
