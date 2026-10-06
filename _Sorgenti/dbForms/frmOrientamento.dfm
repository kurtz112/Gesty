inherited FormOrientamento: TFormOrientamento
  Caption = 'Orientamento'
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
    Left = 216
    Top = 88
    object RegistraInterazione: TAction
      Caption = 'Registra Interazione'
      Hint = 'Annota una telefonata, una mail ricevuta o un incontro sulla scheda del contatto'
      ImageIndex = 390
      OnExecute = RegistraInterazioneExecute
    end
    object ConvertiInStudente: TAction
      Caption = 'Immatricola'
      Hint = 'Crea lo studente e l'#39'iscrizione al percorso di interesse; travasa le segnalazioni BES'
      ImageIndex = 314
      OnExecute = ConvertiInStudenteExecute
    end
    object DestinatariAttivita: TAction
      Caption = 'Destinatari: Attivit'#224' Selezionata'
      Hint = 'Elenco dei partecipanti da convocare all'#39'attivit'#224' selezionata nel calendario'
      ImageIndex = 392
      OnExecute = DestinatariAttivitaExecute
    end
    object DestinatariScadenze: TAction
      Caption = 'Destinatari: Scadenze Non Rispettate'
      Hint = 'Elenco dei contatti con almeno una scadenza superata'
      ImageIndex = 392
      OnExecute = DestinatariScadenzeExecute
    end
    object DestinatariStato: TAction
      Caption = 'Destinatari: Stessa Fase'
      Hint = 'Elenco dei contatti nella stessa fase del percorso del contatto selezionato'
      ImageIndex = 392
      OnExecute = DestinatariStatoExecute
    end
    object InviaComunicazioni: TAction
      Caption = 'Invia Comunicazioni'
      Hint = 'Spedisce il modello selezionato a tutti i destinatari spedibili dell'#39'elenco'
      ImageIndex = 71
      OnExecute = InviaComunicazioniExecute
    end
    object AttivaPlacement: TAction
      Caption = 'Attiva Placement'
      Hint = 'Iscrive il diplomato selezionato allo sportello Placement ITS di Servizi al Lavoro'
      ImageIndex = 546
      OnExecute = AttivaPlacementExecute
    end
  end
end
