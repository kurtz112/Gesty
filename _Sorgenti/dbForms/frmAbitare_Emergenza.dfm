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
    Images = dx.Immagini
    OnUpdate = BaseActionsUpdate
    Left = 164
    Top = 116
    object DuplicaProntoIntervento: TAction
      Caption = 'Duplica Intervento'
      ImageIndex = 1425
      OnExecute = DuplicaProntoInterventoExecute
    end
    object ProntoInterventoCoperture: TAction
      Caption = 'Coperture'
      ImageIndex = 993
      OnExecute = ProntoInterventoCopertureExecute
    end
    object DuplicaProgetto: TAction
      Caption = 'Duplica Progetto'
      ImageIndex = 1630
      OnExecute = DuplicaProgettoExecute
    end
    object ProgettoCoperture: TAction
      Caption = 'Coperture'
      ImageIndex = 993
      OnExecute = ProgettoCopertureExecute
    end
    object BloccaImportiProntoIntervento: TAction
      Caption = 'Blocca Importi'
      Hint = 'Congela gli importi ai valori attuali'
      ImageIndex = 1954
      OnExecute = BloccaImportiProntoInterventoExecute
      OnUpdate = BloccaImportiProntoInterventoUpdate
    end
    object SbloccaImportiProntoIntervento: TAction
      Caption = 'Sblocca Importi'
      Hint = 'Torna agli importi calcolati dai dati della scheda'
      ImageIndex = 1955
      OnExecute = SbloccaImportiProntoInterventoExecute
      OnUpdate = SbloccaImportiProntoInterventoUpdate
    end
    object BloccaImportiProgetto: TAction
      Caption = 'Blocca Importi'
      Hint = 'Congela gli importi ai valori attuali'
      ImageIndex = 1954
      OnExecute = BloccaImportiProgettoExecute
      OnUpdate = BloccaImportiProgettoUpdate
    end
    object SbloccaImportiProgetto: TAction
      Caption = 'Sblocca Importi'
      Hint = 'Torna agli importi calcolati dai dati della scheda'
      ImageIndex = 1955
      OnExecute = SbloccaImportiProgettoExecute
      OnUpdate = SbloccaImportiProgettoUpdate
    end
  end
end
