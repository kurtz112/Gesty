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
    Images = dx.Immagini
    OnUpdate = ActionListUpdate
    Left = 192
    Top = 56
    object NuovaRiunione: TAction
      Caption = 'Nuova Riunione'
      ImageIndex = 1838
      OnExecute = NuovaRiunioneExecute
    end
    object AggiungiPartecipanti: TAction
      Caption = 'Aggiungi Partecipanti'
      ImageIndex = 1796
      OnExecute = AggiungiPartecipantiExecute
    end
    object InviaMail: TAction
      Caption = 'Invia Mail Partecipanti'
      ImageIndex = 1801
      OnExecute = InviaMailExecute
    end
    object ProgrammaRiunione: TAction
      Caption = 'Programma Riunione'
      ImageIndex = 1118
      OnExecute = ProgrammaRiunioneExecute
    end
    object AnnullaRiunione: TAction
      Caption = 'Annulla Riunione'
      ImageIndex = 1840
      OnExecute = AnnullaRiunioneExecute
    end
    object RipristinaRiunione: TAction
      Caption = 'Ripristina Riunione'
      ImageIndex = 1842
      OnExecute = RipristinaRiunioneExecute
    end
    object Verbalizza: TAction
      Caption = 'Verbalizza'
      ImageIndex = 1841
      OnExecute = VerbalizzaExecute
    end
    object Contabilizza: TAction
      Caption = 'Contabilizza'
      ImageIndex = 1236
      OnExecute = ContabilizzaExecute
    end
  end
end
