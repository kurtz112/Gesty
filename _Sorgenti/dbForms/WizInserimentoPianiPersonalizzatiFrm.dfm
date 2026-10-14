inherited WizInserimentoPianiPersonalizzatiForm: TWizInserimentoPianiPersonalizzatiForm
  Caption = 'WizInserimentoPianiPersonalizzatiForm'
  ClientHeight = 613
  ClientWidth = 967
  OnCreate = FormCreate
  ExplicitWidth = 983
  ExplicitHeight = 652
  TextHeight = 15
  inherited Wizard: TdxWizardControl
    Width = 967
    Height = 583
    OnPageChanging = WizardPageChanging
    ExplicitWidth = 975
    ExplicitHeight = 595
    inherited pageWelcome: TdxWizardControlPage
      Header.Description = ''
      Header.Title = 'Inserimento Piano Personalizzato'
      Header.Description = ''
      ExplicitLeft = 11
      ExplicitTop = 82
      ExplicitWidth = 953
      ExplicitHeight = 451
      object cardPiano: TzDbCard
        Left = 0
        Top = 0
        Width = 953
        Height = 451
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
        ToolActions = <
          item
            Name = 'AggiungiStudente'
            Action = AggiungiStudente
            ShowCaption = True
          end>
        OnAfterCreateControls = cardPianoAfterCreateControls
      end
    end
    inherited pageFinish: TdxWizardControlPage
      Header.Description = ''
      ExplicitLeft = 11
      ExplicitTop = 82
      ExplicitWidth = 953
      ExplicitHeight = 451
      object memoRiepilogo: TcxMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Align = alClient
        Lines.Strings = (
          'memoRiepilogo')
        TabOrder = 0
        Height = 433
        Width = 939
      end
    end
    object pageServiziErogati: TdxWizardControlPage
      Header.Title = 'Servizi Erogati'
      Header.Description = ''
      object viewServizi: TzDbView
        Left = 0
        Top = 0
        Width = 953
        Height = 451
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
            Name = 'AggiungiServizi'
            Action = AggiungiServizi
            ShowCaption = True
          end>
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
    object AggiungiStudente: TAction
      Caption = 'Aggiungi Studente'
      ImageIndex = 1345
      OnExecute = AggiungiStudenteExecute
    end
    object AggiungiServizi: TAction
      Caption = 'Aggiungi Servizi'
      ImageIndex = 1629
      OnExecute = AggiungiServiziExecute
    end
  end
  inherited BasePopup: TdxBarPopupMenu
    PixelsPerInch = 96
  end
end
