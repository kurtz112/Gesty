inherited BaseWizard: TBaseWizard
  Left = 580
  Top = 361
  BorderIcons = []
  Caption = 'BaseWizard'
  ClientHeight = 479
  ClientWidth = 745
  ParentFont = False
  Font.Height = -13
  StyleElements = [seFont, seClient, seBorder]
  OnContextPopup = FormContextPopup
  ExplicitWidth = 761
  ExplicitHeight = 518
  TextHeight = 17
  object Wizard: TdxWizardControl [1]
    Left = 0
    Top = 0
    Width = 745
    Height = 479
    Buttons.CustomButtons.Alignment = wccbaLeft
    Buttons.CustomButtons.Buttons = <>
    Buttons.Finish.Caption = '&Conferma'
    Buttons.Next.Caption = '&Continua'
    OnButtonClick = WizardButtonClick
    OnHandleChildControlKey = WizardHandleChildControlKey
    object pageWelcome: TdxWizardControlPage
      Header.Title = 'Welcome'
    end
    object pageFinish: TdxWizardControlPage
      Header.Title = 'Conferma'
      Header.Description = ''
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
    inherited barTitolo: TdxBar
      Visible = False
    end
    inherited barFree: TdxBar
      Visible = False
    end
    inherited barSistema: TdxBar
      Visible = False
    end
  end
  inherited BaseActions: TActionList
    inherited actVisualizzaGuida: TAction
      OnExecute = actVisualizzaGuidaExecute
    end
    object actConfiguraWizard: TAction
      Category = 'Sistema'
      Caption = 'Configura Wizard'
      OnExecute = actConfiguraWizardExecute
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Left = 168
    Top = 88
  end
  object BasePopup: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
      end
      item
        Visible = True
      end
      item
        BeginGroup = True
        Visible = True
      end
      item
        Visible = True
      end
      item
        Visible = True
      end
      item
        BeginGroup = True
        Visible = True
      end
      item
        Visible = True
        ItemName = 'dxBarSubItemController'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButtonSistema'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'btnScreenshot'
      end
      item
        Visible = True
      end>
    UseOwnFont = False
    Left = 32
    Top = 240
    PixelsPerInch = 96
  end
end
