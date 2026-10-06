inherited WizInserimentoStudenteForm: TWizInserimentoStudenteForm
  Caption = 'Inserimento Destinatario Corso'
  ClientHeight = 704
  ClientWidth = 1064
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 1080
  ExplicitHeight = 743
  TextHeight = 17
  inherited Wizard: TdxWizardControl
    Width = 1064
    Height = 704
    ExplicitWidth = 1064
    ExplicitHeight = 704
    inherited pageWelcome: TdxWizardControlPage
      Header.Description = ''
      Header.Title = 'Inserimento Destinatario Corso'
      Header.Description = ''
      ExplicitLeft = 11
      ExplicitTop = 88
      ExplicitWidth = 1042
      ExplicitHeight = 552
      object cardStudente: TzDbCard
        Left = 0
        Top = 0
        Width = 1042
        Height = 552
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
    object pageAltriDati: TdxWizardControlPage [1]
      Header.Title = 'Altri Dati'
      Header.Description = ''
      object cardAltro: TzDbCard
        Left = 0
        Top = 0
        Width = 1042
        Height = 552
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
    object pageGenitori: TdxWizardControlPage [2]
      Header.Title = 'Genitori/Tutori/Affidatari'
      Header.Description = ''
      object Panel1: TPanel
        Left = 0
        Top = 163
        Width = 1042
        Height = 389
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Splitter2: TcxSplitter
          Left = 250
          Top = 0
          Width = 8
          Height = 389
          HotZoneClassName = 'TcxMediaPlayer8Style'
        end
        object viewAllegatiGenitori: TzDbView
          Left = 0
          Top = 0
          Width = 250
          Height = 389
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
          TabOrder = 0
          ToolActions = <>
          ToolFilters = <>
        end
        object viewerAllegatiGenitori: TzFileViewer
          Left = 258
          Top = 0
          Width = 784
          Height = 389
          Align = alClient
          TabOrder = 1
          ToolActions = <>
          Locked = False
          OnImportFile = viewerImportFile
        end
      end
      object Splitter1: TcxSplitter
        Left = 0
        Top = 155
        Width = 1042
        Height = 8
        HotZoneClassName = 'TcxMediaPlayer8Style'
        AlignSplitter = salTop
      end
      object viewGenitori: TzDbView
        Left = 0
        Top = 0
        Width = 1042
        Height = 155
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
        TabOrder = 2
        ToolActions = <>
        ToolFilters = <>
      end
    end
    object pageProgettiDoti: TdxWizardControlPage [3]
      Header.Title = 'Progetti/Doti'
      Header.Description = ''
      object cardProgetti: TzDbCard
        Left = 0
        Top = 0
        Width = 1042
        Height = 552
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
    object pageBisogniEducativiSpeciali: TdxWizardControlPage [4]
      Header.Title = 'Bisogni Educativi Speciali'
      Header.Description = ''
      object viewBisogniEducativiSpeciali: TzDbView
        Left = 0
        Top = 0
        Width = 1042
        Height = 552
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
      end
    end
    object pageLingue: TdxWizardControlPage [5]
      Header.Title = 'Lingue Conosciute'
      Header.Description = ''
      object viewLingue: TzDbView
        Left = 0
        Top = 0
        Width = 1042
        Height = 552
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
      end
    end
    object pageEsperienze: TdxWizardControlPage [6]
      Header.Title = 'Esperienze'
      Header.Description = ''
      object viewEsperienze: TzDbView
        Left = 458
        Top = 0
        Width = 584
        Height = 552
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
      end
      object viewFigureProfessionali: TzDbView
        Left = 0
        Top = 0
        Width = 450
        Height = 552
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
        TabOrder = 1
        ToolActions = <>
        ToolFilters = <>
      end
      object cxSplitter1: TcxSplitter
        Left = 450
        Top = 0
        Width = 8
        Height = 552
      end
    end
    object pageDispOrari: TdxWizardControlPage [7]
      Header.Title = 'Disponibilit'#224' Orari Lavorativi'
      Header.Description = ''
      object viewDispOrari: TzDbView
        Left = 0
        Top = 0
        Width = 1042
        Height = 552
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
      end
    end
    object pageContiCorrenti: TdxWizardControlPage [8]
      Header.Title = 'Conti Correnti'
      Header.Description = ''
      object viewContiCorrenti: TzDbView
        Left = 0
        Top = 0
        Width = 1042
        Height = 552
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
      end
    end
    object pageAllegatiStudente: TdxWizardControlPage [9]
      Header.Title = 'Allegati'
      Header.Description = ''
      object Splitter3: TcxSplitter
        Left = 241
        Top = 0
        Width = 8
        Height = 552
        HotZoneClassName = 'TcxMediaPlayer8Style'
      end
      object viewAllegatiStudente: TzDbView
        Left = 0
        Top = 0
        Width = 241
        Height = 552
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
        TabOrder = 1
        ToolActions = <>
        ToolFilters = <>
      end
      object viewerAllegatiStudente: TzFileViewer
        Left = 249
        Top = 0
        Width = 793
        Height = 552
        Align = alClient
        TabOrder = 2
        ToolActions = <>
        Locked = False
        OnImportFile = viewerImportFile
      end
    end
    inherited pageFinish: TdxWizardControlPage
      Header.Description = ''
      ExplicitLeft = 11
      ExplicitTop = 88
      ExplicitWidth = 1042
      ExplicitHeight = 552
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  inherited BasePopup: TdxBarPopupMenu
    PixelsPerInch = 96
  end
end
