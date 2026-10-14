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
    Images = dx.Immagini
    Left = 240
    Top = 72
    object InserimentoInterventoAS: TAction
      Caption = 'Inserimento Intervento AS'
      ImageIndex = 1423
      OnExecute = InserimentoInterventoASExecute
    end
    object InserimentoInterventoAES: TAction
      Caption = 'Inserimento Intervento AES'
      ImageIndex = 1423
      OnExecute = InserimentoInterventoAESExecute
    end
    object InserimentoInterventoADH: TAction
      Caption = 'Inserimento Intervento ADH'
      ImageIndex = 1423
      OnExecute = InserimentoInterventoADHExecute
    end
    object SchedaAnagraficaUtenteAS: TAction
      Caption = 'Scheda Anagrafica Utente'
      ImageIndex = 989
      OnExecute = SchedaAnagraficaUtenteASExecute
    end
    object SchedaAnagraficaUtenteAES: TAction
      Caption = 'Scheda Anagrafica Utente'
      ImageIndex = 989
      OnExecute = SchedaAnagraficaUtenteAESExecute
    end
    object SchedaAnagraficaUtenteADH: TAction
      Caption = 'Scheda Anagrafica Utente'
      ImageIndex = 989
      OnExecute = SchedaAnagraficaUtenteADHExecute
    end
    object AggiungiUtentiAGruppo: TAction
      Caption = 'Aggiungi Utenti'
      ImageIndex = 1827
      OnExecute = AggiungiUtentiAGruppoExecute
    end
    object DuplicaAS: TAction
      Caption = 'Duplica Utente'
      ImageIndex = 1829
      OnExecute = DuplicaASExecute
    end
    object DuplicaAES: TAction
      Caption = 'Duplica Utente'
      ImageIndex = 1829
      OnExecute = DuplicaAESExecute
    end
    object DuplicaADH: TAction
      Caption = 'Duplica Utente'
      ImageIndex = 1829
      OnExecute = DuplicaADHExecute
    end
    object ImpostaCostoOrario: TAction
      Caption = 'Imposta Costo Orario'
      ImageIndex = 1793
      OnExecute = ImpostaCostoOrarioExecute
    end
  end
end
