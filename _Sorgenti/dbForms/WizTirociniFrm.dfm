inherited WizTirociniForm: TWizTirociniForm
  Caption = 'WizTirociniForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 17
  inherited Wizard: TdxWizardControl
    ExplicitTop = 32
    ExplicitHeight = 447
    inherited pageWelcome: TdxWizardControlPage
      ExplicitLeft = 11
      ExplicitTop = 82
      ExplicitWidth = 723
      ExplicitHeight = 303
    end
    inherited pageFinish: TdxWizardControlPage
      Header.Description = ''
      ExplicitLeft = 11
      ExplicitTop = 82
      ExplicitWidth = 723
      ExplicitHeight = 303
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 216
    object AggiungiStudentiStage: TAction
      Caption = 'Aggiungi Studenti'
      ImageIndex = 165
      OnExecute = AggiungiStudentiStageExecute
    end
    object NuovaAziendaOspitante: TAction
      Caption = 'Nuova Azienda Ospitante'
      ImageIndex = 473
      OnExecute = NuovaAziendaOspitanteExecute
    end
  end
  inherited BasePopup: TdxBarPopupMenu
    PixelsPerInch = 96
  end
end
