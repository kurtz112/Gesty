inherited WizNuovaRichiestaAttivazioneForm: TWizNuovaRichiestaAttivazioneForm
  Caption = 'Richiesta Attivazione Risorsa'
  ClientHeight = 673
  ClientWidth = 824
  OnCreate = FormCreate
  ExplicitWidth = 840
  ExplicitHeight = 712
  TextHeight = 17
  inherited Wizard: TdxWizardControl
    Width = 824
    Height = 673
    OnPageChanged = WizardPageChanged
    OnPageChanging = WizardPageChanging
    ExplicitWidth = 824
    ExplicitHeight = 673
    inherited pageWelcome: TdxWizardControlPage
      Header.Description = 'Ricerca per Codice Fiscale/Partita IVA'
      Header.Title = 'Richiesta Attivazione Risorsa'
      ExplicitLeft = 11
      ExplicitTop = 88
      ExplicitWidth = 802
      ExplicitHeight = 521
      object dxLayoutControlRicerca: TdxLayoutControl
        Left = 0
        Top = 0
        Width = 802
        Height = 521
        Align = alClient
        TabOrder = 0
        object edPartitaIVA: TcxTextEdit
          Left = 605
          Top = 33
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 2
          Width = 101
        end
        object edCodiceFiscale: TcxMaskEdit
          Left = 371
          Top = 33
          ParentFont = False
          Properties.CharCase = ecUpperCase
          Properties.MaxLength = 16
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 1
          Width = 157
        end
        object memoEsigenza: TcxMemo
          Left = 28
          Top = 156
          Lines.Strings = (
            'memoEsigenza')
          Style.HotTrack = False
          TabOrder = 5
          Height = 304
          Width = 746
        end
        object edTipoRisorsa: TcxImageComboBox
          Left = 92
          Top = 31
          Properties.Images = cxImageListTipoRisorse
          Properties.ImmediateDropDownWhenActivated = True
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Description = 'Persona Fisica'
              ImageIndex = 0
              Value = 'P'
            end
            item
              Description = 'Azienda'
              ImageIndex = 1
              Value = 'A'
            end>
          Style.HotTrack = False
          TabOrder = 0
          OnClick = edTipoRisorsaClick
          Width = 180
        end
        object btnVerifica: TcxButton
          Left = 714
          Top = 31
          Width = 75
          Height = 25
          Action = Verifica
          TabOrder = 3
        end
        object btnEsigenze: TcxButton
          Left = 28
          Top = 468
          Width = 100
          Height = 25
          Action = AggiungiTestoEsigenza
          TabOrder = 6
        end
        object edRichiedente: TcxExtLookupComboBox
          Left = 104
          Top = 123
          Properties.ImmediateDropDownWhenActivated = True
          Properties.ImmediatePost = True
          EditValue = 0
          Style.HotTrack = False
          TabOrder = 4
          Width = 670
        end
        object dxLayoutControlRicercaGroup_Root: TdxLayoutGroup
          AlignHorz = ahClient
          AlignVert = avClient
          Hidden = True
          ItemIndex = 1
          ShowBorder = False
          Index = -1
        end
        object dxLayoutItemPartitaIVA: TdxLayoutItem
          Parent = dxLayoutGroupRicerca
          AlignHorz = ahClient
          AlignVert = avBottom
          CaptionOptions.Text = 'Partita IVA:'
          Control = edPartitaIVA
          ControlOptions.OriginalHeight = 23
          ControlOptions.OriginalWidth = 120
          ControlOptions.ShowBorder = False
          Index = 2
        end
        object dxLayoutItemCodiceFiscale: TdxLayoutItem
          Parent = dxLayoutGroupRicerca
          AlignHorz = ahClient
          AlignVert = avBottom
          CaptionOptions.Text = 'Codice Fiscale:'
          Control = edCodiceFiscale
          ControlOptions.OriginalHeight = 23
          ControlOptions.OriginalWidth = 186
          ControlOptions.ShowBorder = False
          Index = 1
        end
        object dxLayoutGroupRicerca: TdxLayoutGroup
          Parent = dxLayoutControlRicercaGroup_Root
          AlignHorz = ahClient
          AlignVert = avTop
          CaptionOptions.Text = 'Ricerca'
          ItemIndex = 3
          LayoutDirection = ldHorizontal
          ShowBorder = False
          Index = 1
        end
        object dxLayoutItemEsigenza: TdxLayoutItem
          Parent = dxLayoutGroupEsigenza
          AlignHorz = ahClient
          AlignVert = avClient
          CaptionOptions.Text = 'Esigenza:'
          CaptionOptions.Visible = False
          CaptionOptions.Layout = clTop
          Control = memoEsigenza
          ControlOptions.OriginalHeight = 89
          ControlOptions.OriginalWidth = 185
          ControlOptions.ShowBorder = False
          Index = 2
        end
        object dxLayoutItemTipoRisorsa: TdxLayoutItem
          Parent = dxLayoutGroupRicerca
          AlignHorz = ahLeft
          AlignVert = avBottom
          CaptionOptions.Text = 'Tipo Risorsa'
          Control = edTipoRisorsa
          ControlOptions.OriginalHeight = 25
          ControlOptions.OriginalWidth = 180
          ControlOptions.ShowBorder = False
          Index = 0
        end
        object dxLayoutGroupEsigenza: TdxLayoutGroup
          Parent = dxLayoutControlRicercaGroup_Root
          AlignHorz = ahClient
          AlignVert = avClient
          CaptionOptions.Text = 'Esigenza'
          Index = 3
        end
        object dxLayoutItemVerifica: TdxLayoutItem
          Parent = dxLayoutGroupRicerca
          AlignHorz = ahRight
          AlignVert = avBottom
          CaptionOptions.Text = 'cxButton1'
          CaptionOptions.Visible = False
          Control = btnVerifica
          ControlOptions.OriginalHeight = 25
          ControlOptions.OriginalWidth = 75
          ControlOptions.ShowBorder = False
          Index = 3
        end
        object dxLayoutItemAggiungiEsigenza: TdxLayoutItem
          Parent = dxLayoutGroupEsigenza
          AlignHorz = ahLeft
          AlignVert = avBottom
          CaptionOptions.Text = 'New Item'
          CaptionOptions.Visible = False
          Control = btnEsigenze
          ControlOptions.OriginalHeight = 25
          ControlOptions.OriginalWidth = 100
          ControlOptions.ShowBorder = False
          Index = 3
        end
        object dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem
          Parent = dxLayoutControlRicercaGroup_Root
          SizeOptions.Height = 10
          SizeOptions.Width = 10
          CaptionOptions.Text = 'Empty Space Item'
          Index = 0
        end
        object dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem
          Parent = dxLayoutControlRicercaGroup_Root
          SizeOptions.Height = 10
          SizeOptions.Width = 10
          CaptionOptions.Text = 'Empty Space Item'
          Index = 2
        end
        object dxLayoutItemRichiedente: TdxLayoutItem
          Parent = dxLayoutGroupEsigenza
          AlignHorz = ahClient
          AlignVert = avTop
          CaptionOptions.Text = 'Richiedente:'
          Control = edRichiedente
          ControlOptions.OriginalHeight = 25
          ControlOptions.OriginalWidth = 450
          ControlOptions.ShowBorder = False
          Index = 1
        end
        object dxLayoutEmptySpaceItem3: TdxLayoutEmptySpaceItem
          Parent = dxLayoutGroupEsigenza
          SizeOptions.Height = 10
          SizeOptions.Width = 10
          CaptionOptions.Text = 'Empty Space Item'
          Index = 0
        end
      end
    end
    inherited pageFinish: TdxWizardControlPage
      Header.Description = ''
      ExplicitLeft = 11
      ExplicitTop = 88
      ExplicitWidth = 802
      ExplicitHeight = 521
      object memoRiepilogo: TcxMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Align = alClient
        Lines.Strings = (
          'memoRiepilogo')
        TabOrder = 0
        Height = 515
        Width = 796
      end
    end
    object pagePersonale: TdxWizardControlPage
      Header.Title = 'Persona Fisica'
      Header.Description = ''
      object cardPersonale: TzDbCard
        Left = 0
        Top = 0
        Width = 802
        Height = 521
        Align = alClient
        DoubleBuffered = True
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentDoubleBuffered = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ToolActions = <>
        LookupsEnabled = True
      end
    end
    object pageAzienda: TdxWizardControlPage
      Header.Title = 'Azienda'
      Header.Description = ''
      object cardAzienda: TzDbCard
        Left = 0
        Top = 0
        Width = 802
        Height = 521
        Align = alClient
        DoubleBuffered = True
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentDoubleBuffered = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ToolActions = <>
        LookupsEnabled = True
      end
    end
    object pageAziendaDetail: TdxWizardControlPage
      Header.Title = 'Dettaglio Azienda'
      Header.Description = ''
      object cardAziendaDetail: TzDbCard
        Left = 0
        Top = 0
        Width = 802
        Height = 521
        Align = alClient
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentDoubleBuffered = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ToolActions = <>
        LookupsEnabled = True
      end
    end
    object pageAltro: TdxWizardControlPage
      Header.Title = 'Altro'
      Header.Description = ''
      object cardAltro: TzDbCard
        Left = 0
        Top = 0
        Width = 802
        Height = 521
        Align = alClient
        DoubleBuffered = True
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentDoubleBuffered = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ToolActions = <>
        LookupsEnabled = True
      end
    end
    object pageSettori: TdxWizardControlPage
      Header.Title = 'Settori'
      Header.Description = ''
      object viewSettori: TzDbView
        Left = 0
        Top = 0
        Width = 802
        Height = 521
        Align = alClient
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ToolActions = <
          item
            Name = 'AggiungiSettori'
            Action = AggiungiSettori
            ShowCaption = True
          end>
        ToolFilters = <>
      end
    end
    object pageForniture: TdxWizardControlPage
      Header.Title = 'Fornitori'
      Header.Description = ''
      object cardTipologiaFornitore: TzDbCard
        Left = 0
        Top = 0
        Width = 802
        Height = 176
        Align = alTop
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentDoubleBuffered = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ToolActions = <>
        LookupsEnabled = True
      end
      object panelForniture: TPanel
        Left = 0
        Top = 184
        Width = 802
        Height = 337
        Align = alClient
        ShowCaption = False
        TabOrder = 1
        object Splitter2: TcxSplitter
          Left = 363
          Top = 1
          Width = 8
          Height = 335
          HotZoneClassName = 'TcxMediaPlayer8Style'
          AlignSplitter = salRight
        end
        object viewCompetenze: TzDbView
          Left = 371
          Top = 1
          Width = 430
          Height = 335
          Align = alRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ToolActions = <
            item
              Name = 'AggiungiCompetenze'
              Action = AggiungiCompetenze
              ShowCaption = True
            end>
          ToolFilters = <>
        end
        object viewForniture: TzDbView
          Left = 1
          Top = 1
          Width = 362
          Height = 335
          Align = alClient
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          ToolActions = <
            item
              Name = 'AggiungiForniture'
              Action = AggiungiForniture
              ShowCaption = True
            end>
          ToolFilters = <>
        end
      end
      object Splitter3: TcxSplitter
        Left = 0
        Top = 176
        Width = 8
        Height = 8
        HotZoneClassName = 'TcxMediaPlayer8Style'
        AlignSplitter = salTop
      end
    end
    object pageAllegati: TdxWizardControlPage
      Header.Title = 'Allegati'
      Header.Description = ''
      object Splitter1: TcxSplitter
        Left = 183
        Top = 0
        Width = 8
        Height = 521
        HotZoneClassName = 'TcxMediaPlayer8Style'
        Control = viewAllegati
      end
      object viewerAllegati: TzFileViewer
        Left = 191
        Top = 0
        Width = 611
        Height = 521
        Align = alClient
        TabOrder = 1
        ToolActions = <>
        Locked = False
        OnImportFile = viewerAllegatiImportFile
      end
      object viewAllegati: TzDbView
        Left = 0
        Top = 0
        Width = 183
        Height = 521
        Align = alLeft
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        ToolActions = <>
        ToolFilters = <>
      end
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Images = dx.Immagini
    Left = 152
    Top = 161
    object Verifica: TAction
      Caption = 'Verifica'
      OnExecute = VerificaExecute
    end
    object AggiungiForniture: TAction
      Caption = 'Aggiungi Forniture'
      ImageIndex = 2017
      OnExecute = AggiungiFornitureExecute
    end
    object AggiungiCompetenze: TAction
      Caption = 'Aggiungi Competenze'
      ImageIndex = 1360
      OnExecute = AggiungiCompetenzeExecute
    end
    object AggiungiSettori: TAction
      Caption = 'Aggiungi Settori'
      ImageIndex = 1327
      OnExecute = AggiungiSettoriExecute
    end
    object AggiungiTestoEsigenza: TAction
      Caption = 'Esigenze...'
      ImageIndex = 4
      OnExecute = AggiungiTestoEsigenzaExecute
    end
  end
  inherited BasePopup: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object cxImageListTipoRisorse: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 14549632
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000009E9D9CFF9E9D9CFF9E9D9CFF9E9D9CFF9E9D9CFF9E9D9CFF9E9D
          9CFF9E9D9CFF9E9D9CFF00000000000000000000000000000000000000000000
          0000000000009E9D9CFFFFFFFFFFFFFFFFFFE8E8E8FFF2F1F0FFB8B8B8FFB4C6
          D9FFB4BFCDFFC0C2C4FF9E9D9CFF9E9D9CFF0000000000000000000000000000
          0000000000009E9D9CFFFFFFFFFFFEFDFDFFB8B8B8FFB8B8B8FFD1D6DEFFB8C3
          D6FFB0BFCBFFB8B8B8FFC9C9C9FF9E9D9CFF0000000000000000000000000000
          0000000000009E9D9CFFF4F4F3FFB8B8B8FFD1D0D0FFEFEDEDFF838A90FF9BA5
          AEFF9FAFBEFFB8B8B8FFC7C7C6FF9E9D9CFF0000000000000000000000000000
          0000000000003A3A3A5B9E9D9CFFC4C2C2FEE7E3DFFFCAC7C1FF14120EFF0F0C
          08FF282425FFDBDBDBFFB8B8B8FF9E9D9CFF0000000000000000000000000000
          00002828283C9E9D9CFFC6C5C4F59E9D9CFF82A0B9FF4473A7FF144A85FF0A42
          79FF263A49FFD7D4D2FC9E9D9CFF0C0C0C130000000000000000000000000000
          00009E9D9CFFC1C1C1F0B8B8B8FF7199C4FF0E6DDAFF3A81D7FFB8C6DCFF347A
          D9FF3F74B5FF9E9D9CFF6A6B6BA2494949680000000000000000000000001919
          19299E9D9CFFB8B8B8FFA4BAD0FF3092F4FF309AFFFF3F9DF4FFDDE4E7FFCDD7
          E2FFD9DEE7FFD9DEE7FF9E9D9CFF818080AD0303030500000000000000009E9D
          9CFFD8D8D8FED2CDC9FF88A7C5FF2E9CFAFF43A6F8FF6C96B9FF9EA3A5FFB2BC
          C6FFBAC2CDFF677D99FFABB2B8FF9E9D9CFF0B0B0B1200000000000000001E1E
          1E309E9D9CFFD8D8D7FDB8B8B8FF6E97B8FF457296FFC08E5FFFD9B083FF877B
          72FF9C836CFFD9A471FFC8B3A3FF7A7C7DA00000000000000000000000000E0E
          0E189E9D9CFFADADADF0F7F1EDFFA5C3D9FF3BA4EFFF49A8ECFF4FA4E2FF4D9E
          DDFF4D99DAFF5985ACFFBEB6AFFE9E9D9CFF0707070C00000000000000000808
          080F9E9D9CFFE9E9E9FFFBF9F8FFB8B8B8FF64B4EDFF63ACDFFF50A6E4FF3EA6
          F3FF3C9CEAFFB8B8B8FFD4D2CFFF9E9D9CFF0A0A0A1100000000000000000000
          0000000000009E9D9CFFD7D7D8FCF2F0EFFFF0F0F0FFEEECE9FFBDCBD5FFB8CA
          D7FFDCDEDFFFCFCECCFC9E9D9CFF3636364E0000000000000000000000000000
          000000000000454545669E9D9CFFF1F1F1FFEEEDEDFFE4E3E3FF9E9D9CFFF1EE
          ECFFF4F2F1FF9E9D9CFF40404060050505090000000000000000000000000000
          000000000000000000000A0A0A259E9D9CFF9E9D9CFF9E9D9CFF2828285E9E9D
          9CFF9E9D9CFF9E9D9CFF00000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00002D2D2D4050505072B4B3B2FFB4B3B2FFB4B3B2FFB4B3B2FFB4B3B2FFB4B3
          B2FF4F4F4E702D2D2D400000000000000000000000000000000030302F446262
          618CB4B3B2FFB4B3B2FFBEBBBAFEB7B6B6FFBDBEC0FFAAACAEFFB5B6B7FFB5B5
          B5F3B4B3B2FFB4B3B2FF545453772D2D2D400000000000000000B4B3B2FFB4B3
          B2FFC4C4C5FFA4A5A7FF582511FFB19F92FFB5B5B5FFBEB1A1FF9B9892FF989B
          9DFFAAACAFFFBDBDBEFFB4B3B2FFB4B3B2FF666565913131314631303045B4B3
          B2FFB5B5B5FFBFAE9BFF582511FFECD6B4FFB5B5B5FFECD6B4FFECD6B4FFDDC4
          A3FFB4A695FFB2B0ADFFD5D6D8FFE5E5E5FFB4B3B2FFB4B3B2FF000000000000
          0000B5B5B5FFECD6B4FFECD6B4FFB08487FFB5B5B5FFB08487FFB08487FFECD6
          B4FFECD6B4FFB5B5B5FFB5B5B5FFB4B3B2FF6463638E31313146000000000000
          0000B5B5B5FFB08487FFB08487FFECD6B4FFB5B5B5FFECD6B4FFECD6B4FFB084
          87FFB08487FFB5B5B5FFFDB56CFF050404060000000000000000000000000000
          0000B5B5B5FFECD6B4FFECD6B4FFB08487FFB5B5B5FFB08487FFB08487FFECD6
          B4FFECD6B4FFB5B5B5FFB5B5B5FF0909090B0000000000000000000000000000
          0000B5B5B5FFB08487FFB08487FFECD6B4FFB5B5B5FFECD6B4FFECD6B4FFB084
          87FFB08487FFB5B5B5FFFDB56CFF080707090000000000000000000000000000
          0000B5B5B5FFECD6B4FFF2D5B2FFA66A73FFA66A73FFA66A73FFDCB59DFFECD6
          B4FFECD6B4FFB5B5B5FFB5B5B5FF060605070000000000000000000000000000
          0000B5B5B5FFA66A73FFA66A73FFB88387FFD6AAA7FFDFB4B2FFA66A73FFA66A
          73FFA66A73FFB5B5B5FFFDB56CFF06060607000000000000000000000000A66A
          73FFA66A73FFCBA4A0FFF2DBCBFFFFF1DDFFFFEDDCFFFFE6D9FFFFE2D7FFF8CF
          CAFFE2AEB1FFA66A73FFA66A73FF0D0908100000000000000000000000003924
          275859383D89A66A73FFA66A73FFA66A73FFFFE6D7FFFFE7DAFFFFDDD4FFF9CF
          CAFFA66A73FFA66A73FFA66A73FF130B0C1E0000000000000000000000000000
          000000000000000000003521245257373C87A66A73FFA66A73FFA66A73FFA66A
          73FF5F3C41933321235000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
  object ImageList: TImageList
    Left = 416
    Top = 64
    Bitmap = {
      494C010101000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD70035B3DC0023A9
      D700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD700AFF6FC0086EF
      FA0049C2E40049C2E40049C2E40034B4DD0024AAD70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD700A6E9F5009EFF
      FF0097FCFF0099FBFF0095F7FF008DF2FE0083EAFA0049C2E40049C2E4003AB8
      DF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD7008BD7EC00ABFE
      FF0090F8FF0091F6FF0090F5FF008FF5FF008FF4FF0090F4FF0095F6FF0075DD
      F5002DAFDB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD70029ABD700AAF0
      FA0091FAFF0091F6FF0090F5FF008EF4FF008DF2FE008BF1FE008CF1FF0077DF
      F60056CAEA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD7007BE5F40029AB
      D7009EFEFF008DF7FF008EF6FF008CF4FF008DF2FE008BF1FE008CF1FF0072DD
      F50079E1F6002CB0DA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD70093F9FD0029AB
      D700A8E9F500A8F0FA00A4F1FB00A1F7FF008CF3FF008AF1FE008CF1FF0070DA
      F30005740B0058CDEA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD7009DFEFF0086F2
      FB0029ABD70029ABD70029ABD70029ABD700AFF2FB0090F4FF0088F2FF000574
      0B005BE78C0005740B001FA8D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD7009AFCFF0096FB
      FF0095FBFF0095FAFF0090F7FF006CDEF30029ABD7009FE3F40005740B0050D7
      7A0045D26C0031C14F0005740B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD7009BFDFF0094FA
      FF0092F8FF0091F6FF0092F7FF0093F9FF0084EFFD0029ABD70029ABD700168C
      230030C14C001698240034AFDA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ABD700A4FFFF0094FC
      FF0092F9FF0093F8FF008FEDFA0090ECFA0095EEFC0096F1FD009AF4FF000C81
      16001AAF2C000883100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000025A8D60029ABD7009EF5
      FB009FF7FD0086EAF8002BAED90025A8D60028ABD7002AACD80032B0DA000C90
      17000EA01A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000029AB
      D70030AED9002CADD800000000000000000000000000000000000A8912000EA1
      1A0008810F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000005710A0009790F000B8916000A8C1300067A
      0D00000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF0000000000008FFF000000000000
      807F000000000000800F00000000000080070000000000008007000000000000
      8003000000000000800300000000000080010000000000008001000000000000
      800100000000000080030000000000008007000000000000E3C7000000000000
      FE0F000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
end
