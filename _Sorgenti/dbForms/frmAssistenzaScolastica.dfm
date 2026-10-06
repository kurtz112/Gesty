inherited FormAssistenzaScolastica: TFormAssistenzaScolastica
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 240
    Top = 72
    object InserimentoInterventoAS: TAction
      Caption = 'Inserimento Intervento AS'
      ImageIndex = 164
      OnExecute = InserimentoInterventoASExecute
    end
    object InserimentoInterventoAES: TAction
      Caption = 'Inserimento Intervento AES'
      ImageIndex = 164
      OnExecute = InserimentoInterventoAESExecute
    end
    object InserimentoInterventoADH: TAction
      Caption = 'Inserimento Intervento ADH'
      ImageIndex = 164
      OnExecute = InserimentoInterventoADHExecute
    end
    object SchedaAnagraficaUtenteAS: TAction
      Caption = 'Scheda Anagrafica Utente'
      ImageIndex = 330
      OnExecute = SchedaAnagraficaUtenteASExecute
    end
    object SchedaAnagraficaUtenteAES: TAction
      Caption = 'Scheda Anagrafica Utente'
      ImageIndex = 330
      OnExecute = SchedaAnagraficaUtenteAESExecute
    end
    object SchedaAnagraficaUtenteADH: TAction
      Caption = 'Scheda Anagrafica Utente'
      ImageIndex = 330
      OnExecute = SchedaAnagraficaUtenteADHExecute
    end
    object AggiungiUtentiAGruppo: TAction
      Caption = 'Aggiungi Utenti'
      ImageIndex = 165
      OnExecute = AggiungiUtentiAGruppoExecute
    end
    object DuplicaAS: TAction
      Caption = 'Duplica Utente'
      ImageIndex = 441
      OnExecute = DuplicaASExecute
    end
    object DuplicaAES: TAction
      Caption = 'Duplica Utente'
      ImageIndex = 441
      OnExecute = DuplicaAESExecute
    end
    object DuplicaADH: TAction
      Caption = 'Duplica Utente'
      ImageIndex = 441
      OnExecute = DuplicaADHExecute
    end
    object ImpostaCostoOrario: TAction
      Caption = 'Imposta Costo Orario'
      ImageIndex = 46
      OnExecute = ImpostaCostoOrarioExecute
    end
  end
end
