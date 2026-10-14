inherited WizNuovaAziendaOspitanteForm: TWizNuovaAziendaOspitanteForm
  Caption = 'Inserimento Azienda Ospitante'
  ClientHeight = 697
  ClientWidth = 783
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 799
  ExplicitHeight = 736
  TextHeight = 17
  inherited Wizard: TdxWizardControl
    Width = 783
    Height = 697
    OnPageChanging = WizardPageChanging
    ExplicitTop = 30
    ExplicitWidth = 783
    ExplicitHeight = 667
    inherited pageWelcome: TdxWizardControlPage
      Header.Description = 'Inserimento Azienda Ospitante'
      ExplicitLeft = 11
      ExplicitTop = 88
      ExplicitWidth = 761
      ExplicitHeight = 545
      object dxLayoutControlRicerca: TdxLayoutControl
        Left = 0
        Top = 0
        Width = 761
        Height = 523
        Align = alClient
        TabOrder = 0
        object cardAzienda: TzDbCard
          Left = 12
          Top = 79
          Width = 737
          Height = 432
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
          TabOrder = 4
          ToolActions = <>
          LookupsEnabled = True
        end
        object edCodiceFiscale: TcxMaskEdit
          Left = 110
          Top = 34
          ParentFont = False
          Properties.CharCase = ecUpperCase
          Properties.MaxLength = 16
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.HotTrack = False
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 200
        end
        object edPartitaIVA: TcxTextEdit
          Left = 381
          Top = 34
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.HotTrack = False
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          TabOrder = 1
          Width = 150
        end
        object btnCerca: TcxButton
          Left = 595
          Top = 33
          Width = 75
          Height = 25
          Action = Cerca
          TabOrder = 3
        end
        object checkEstero: TcxCheckBox
          Left = 538
          Top = 36
          Caption = 'Estero'
          Style.HotTrack = False
          Style.TransparentBorder = False
          TabOrder = 2
        end
        object dxLayoutControlRicercaGroup_Root: TdxLayoutGroup
          AlignHorz = ahClient
          AlignVert = avClient
          Hidden = True
          ShowBorder = False
          Index = -1
        end
        object dxLayoutItemCodiceFiscale: TdxLayoutItem
          Parent = dxLayoutGroupRicerca
          AlignVert = avCenter
          CaptionOptions.Text = 'Codice Fiscale:'
          Control = edCodiceFiscale
          ControlOptions.OriginalHeight = 22
          ControlOptions.OriginalWidth = 200
          ControlOptions.ShowBorder = False
          Index = 0
        end
        object dxLayoutItemPartitaIva: TdxLayoutItem
          Parent = dxLayoutGroupRicerca
          AlignVert = avCenter
          CaptionOptions.Text = 'Partita IVA:'
          Control = edPartitaIVA
          ControlOptions.OriginalHeight = 22
          ControlOptions.OriginalWidth = 150
          ControlOptions.ShowBorder = False
          Index = 1
        end
        object dxLayoutItemCerca: TdxLayoutItem
          Parent = dxLayoutGroupRicerca
          AlignVert = avCenter
          CaptionOptions.Text = 'New Item'
          CaptionOptions.Visible = False
          Control = btnCerca
          ControlOptions.OriginalHeight = 25
          ControlOptions.OriginalWidth = 75
          ControlOptions.ShowBorder = False
          Index = 3
        end
        object dxLayoutGroupRicerca: TdxLayoutGroup
          Parent = dxLayoutControlRicercaGroup_Root
          AlignHorz = ahClient
          AlignVert = avTop
          CaptionOptions.Text = 'Cerca'
          LayoutDirection = ldHorizontal
          Index = 0
        end
        object dxLayoutItemCardAzienda: TdxLayoutItem
          Parent = dxLayoutControlRicercaGroup_Root
          AlignHorz = ahClient
          AlignVert = avClient
          CaptionOptions.Text = 'New Item'
          CaptionOptions.Visible = False
          Control = cardAzienda
          ControlOptions.OriginalHeight = 507
          ControlOptions.OriginalWidth = 741
          ControlOptions.ShowBorder = False
          Index = 1
        end
        object dxLayoutItemEstero: TdxLayoutItem
          Parent = dxLayoutGroupRicerca
          AlignVert = avCenter
          CaptionOptions.Text = 'New Item'
          CaptionOptions.Visible = False
          Control = checkEstero
          ControlOptions.OriginalHeight = 19
          ControlOptions.OriginalWidth = 50
          ControlOptions.ShowBorder = False
          Index = 2
        end
      end
    end
    object pageAziendaDetail: TdxWizardControlPage [1]
      Header.Title = 'Dettaglio Azienda'
      Header.Description = ''
      object cardAziendaDetail: TzDbCard
        Left = 0
        Top = 0
        Width = 761
        Height = 523
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
    object pageSediOperative: TdxWizardControlPage [2]
      Header.Title = 'Sedi Operative'
      Header.Description = ''
      object viewSediOperative: TzDbView
        Left = 0
        Top = 0
        Width = 408
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
        ToolActions = <>
        ToolFilters = <>
        ExplicitHeight = 523
      end
      object pnlAmbiti: TPanel
        Left = 416
        Top = 0
        Width = 345
        Height = 521
        Align = alRight
        ShowCaption = False
        TabOrder = 1
        ExplicitHeight = 523
        object viewAmbiti: TzDbView
          Left = 1
          Top = 1
          Width = 343
          Height = 200
          Align = alTop
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
          ToolActions = <>
          ToolFilters = <>
        end
        object cxSplitter2: TcxSplitter
          Left = 1
          Top = 201
          Width = 343
          Height = 8
          AlignSplitter = salTop
        end
        object viewMansioni: TzDbView
          Left = 1
          Top = 209
          Width = 343
          Height = 311
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
          TabOrder = 2
          ToolActions = <>
          ToolFilters = <>
          ExplicitHeight = 313
        end
      end
      object cxSplitter1: TcxSplitter
        Left = 408
        Top = 0
        Width = 8
        Height = 521
        AlignSplitter = salRight
        ExplicitHeight = 523
      end
    end
    object pageContatti: TdxWizardControlPage [3]
      Header.Title = 'Contatti/Tutor Aziendali'
      Header.Description = ''
      object viewContatti: TzDbView
        Left = 0
        Top = 0
        Width = 761
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
        ToolActions = <>
        ToolFilters = <>
        ExplicitHeight = 523
      end
    end
    inherited pageFinish: TdxWizardControlPage
      Header.Description = ''
      ExplicitLeft = 11
      ExplicitTop = 88
      ExplicitWidth = 761
      ExplicitHeight = 545
      object memoRiepilogo: TcxMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Align = alClient
        Lines.Strings = (
          'memoRiepilogo')
        TabOrder = 0
        Height = 539
        Width = 755
      end
    end
    object pageConvenzioni: TdxWizardControlPage
      Header.Title = 'Convenzioni'
      object viewConvenzioni: TzDbView
        Left = 0
        Top = 0
        Width = 761
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
        ToolActions = <>
        ToolFilters = <>
        ExplicitHeight = 523
      end
    end
  end
  inherited dxBarManager: TdxBarManager
    Left = 56
    Top = 256
    PixelsPerInch = 96
  end
  inherited BaseActions: TActionList
    Left = 60
    Top = 312
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Images = dx.Immagini
    Left = 56
    Top = 209
    object Cerca: TAction
      Caption = 'Cerca'
      OnExecute = CercaExecute
    end
  end
  inherited BasePopup: TdxBarPopupMenu
    Left = 64
    Top = 368
    PixelsPerInch = 96
  end
  object ImageList: TImageList
    Left = 64
    Top = 432
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
