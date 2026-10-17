inherited FormGestioneUtenti: TFormGestioneUtenti
  Caption = 'FormGestioneUtenti'
  ClientHeight = 403
  ClientWidth = 759
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 775
  ExplicitHeight = 442
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
    inherited barFree: TdxBar
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButtonRicaricaImpostazioniUtente'
        end>
    end
    inherited barSistema: TdxBar
      DockedLeft = 248
    end
    object dxBarButtonRicaricaImpostazioniUtente: TdxBarButton
      Action = RicaricaImpostazioniUtente
      Category = 0
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 224
    Top = 56
    object RicaricaImpostazioniUtente: TAction
      Caption = 'Ricarica Impostazioni Utente'
      ImageIndex = 1287
      OnExecute = RicaricaImpostazioniUtenteExecute
    end
    object InizializzaSettings: TAction
      Caption = 'Inizializza Settings'
      ImageIndex = 1288
      OnExecute = InizializzaSettingsExecute
    end
    object InizializzaAutorizzazioni: TAction
      Caption = 'Inizializza Autorizzazioni'
      ImageIndex = 1899
      OnExecute = InizializzaAutorizzazioniExecute
    end
    object ClonaUtente: TAction
      Caption = 'Clona Diritti Da Altro Utente'
      ImageIndex = 973
      OnExecute = ClonaUtenteExecute
    end
    object CreaUtenteDominio: TAction
      Caption = 'Crea Utente Dominio'
      ImageIndex = 1827
      OnExecute = CreaUtenteDominioExecute
    end
    object AzzeraAppAutenticazione: TAction
      Caption = 'Azzera App di Autenticazione'
      Hint = 'Per chi ha perso il telefono: registrera'#39' una nuova app al prossimo accesso'
      ImageIndex = 955
      OnExecute = AzzeraAppAutenticazioneExecute
    end
    object InizializzaHyperLinks: TAction
      Caption = 'Inizializza HyperLinks'
      ImageIndex = 1272
      OnExecute = InizializzaHyperLinksExecute
    end
    object ImpersonaUtenteSelezionato: TAction
      Caption = 'Impersona Utente Selezionato'
      ImageIndex = 973
      OnExecute = ImpersonaUtenteSelezionatoExecute
    end
    object Shutdown: TAction
      Caption = 'Shutdown'
      ImageIndex = 1891
      OnExecute = ShutdownExecute
    end
    object BroadcastMessage: TAction
      Caption = 'Broadcast Message'
      ImageIndex = 986
      OnExecute = BroadcastMessageExecute
    end
    object AggiungiUtenti: TAction
      Caption = 'Aggiungi Utenti'
      ImageIndex = 1827
      OnExecute = AggiungiUtentiExecute
    end
    object InizializzaNotifiche: TAction
      Caption = 'Inizializza Notifiche'
      ImageIndex = 1244
      OnExecute = InizializzaNotificheExecute
    end
  end
end
