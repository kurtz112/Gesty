inherited FormRiunioni: TFormRiunioni
  Caption = 'FormRiunioni'
  ClientHeight = 464
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitHeight = 503
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList16
    OnUpdate = ActionListUpdate
    Left = 192
    Top = 56
    object NuovaRiunione: TAction
      Caption = 'Nuova Riunione'
      ImageIndex = 165
      OnExecute = NuovaRiunioneExecute
    end
    object AggiungiPartecipanti: TAction
      Caption = 'Aggiungi Partecipanti'
      ImageIndex = 314
      OnExecute = AggiungiPartecipantiExecute
    end
    object InviaMail: TAction
      Caption = 'Invia Mail Partecipanti'
      ImageIndex = 72
      OnExecute = InviaMailExecute
    end
    object ProgrammaRiunione: TAction
      Caption = 'Programma Riunione'
      ImageIndex = 547
      OnExecute = ProgrammaRiunioneExecute
    end
    object AnnullaRiunione: TAction
      Caption = 'Annulla Riunione'
      ImageIndex = 387
      OnExecute = AnnullaRiunioneExecute
    end
    object RipristinaRiunione: TAction
      Caption = 'Ripristina Riunione'
      ImageIndex = 92
      OnExecute = RipristinaRiunioneExecute
    end
    object Verbalizza: TAction
      Caption = 'Verbalizza'
      ImageIndex = 402
      OnExecute = VerbalizzaExecute
    end
    object Contabilizza: TAction
      Caption = 'Contabilizza'
      ImageIndex = 382
      OnExecute = ContabilizzaExecute
    end
  end
end
