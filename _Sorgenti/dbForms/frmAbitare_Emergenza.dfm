inherited FormAbitareEmergenza: TFormAbitareEmergenza
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList16
    OnUpdate = BaseActionsUpdate
    Left = 164
    Top = 116
    object DuplicaProntoIntervento: TAction
      Caption = 'Duplica Intervento'
      ImageIndex = 74
      OnExecute = DuplicaProntoInterventoExecute
    end
    object ProntoInterventoCoperture: TAction
      Caption = 'Coperture'
      ImageIndex = 18
      OnExecute = ProntoInterventoCopertureExecute
    end
    object DuplicaProgetto: TAction
      Caption = 'Duplica Progetto'
      ImageIndex = 74
      OnExecute = DuplicaProgettoExecute
    end
    object ProgettoCoperture: TAction
      Caption = 'Coperture'
      ImageIndex = 18
      OnExecute = ProgettoCopertureExecute
    end
    object BloccaImportiProntoIntervento: TAction
      Caption = 'Blocca Importi'
      Hint = 'Congela gli importi ai valori attuali'
      ImageIndex = 384
      OnExecute = BloccaImportiProntoInterventoExecute
      OnUpdate = BloccaImportiProntoInterventoUpdate
    end
    object SbloccaImportiProntoIntervento: TAction
      Caption = 'Sblocca Importi'
      Hint = 'Torna agli importi calcolati dai dati della scheda'
      ImageIndex = 392
      OnExecute = SbloccaImportiProntoInterventoExecute
      OnUpdate = SbloccaImportiProntoInterventoUpdate
    end
    object BloccaImportiProgetto: TAction
      Caption = 'Blocca Importi'
      Hint = 'Congela gli importi ai valori attuali'
      ImageIndex = 384
      OnExecute = BloccaImportiProgettoExecute
      OnUpdate = BloccaImportiProgettoUpdate
    end
    object SbloccaImportiProgetto: TAction
      Caption = 'Sblocca Importi'
      Hint = 'Torna agli importi calcolati dai dati della scheda'
      ImageIndex = 392
      OnExecute = SbloccaImportiProgettoExecute
      OnUpdate = SbloccaImportiProgettoUpdate
    end
  end
end
