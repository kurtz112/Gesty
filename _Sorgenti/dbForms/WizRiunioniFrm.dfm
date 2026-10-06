inherited WizRiunioniForm: TWizRiunioniForm
  Caption = 'WizRiunioniForm'
  PixelsPerInch = 96
  TextHeight = 15
  inherited Wizard: TdxWizardControl
    ExplicitTop = 30
    ExplicitHeight = 449
    inherited pageWelcome: TdxWizardControlPage
      ExplicitLeft = 11
      ExplicitTop = 82
      ExplicitWidth = 723
      ExplicitHeight = 305
    end
    inherited pageFinish: TdxWizardControlPage
      Header.Description = ''
      ExplicitLeft = 11
      ExplicitTop = 82
      ExplicitWidth = 723
      ExplicitHeight = 305
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
