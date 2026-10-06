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
    Images = zDmImages.ImageList24
    Left = 224
    Top = 56
    object RicaricaImpostazioniUtente: TAction
      Caption = 'Ricarica Impostazioni Utente'
      ImageIndex = 76
      OnExecute = RicaricaImpostazioniUtenteExecute
    end
    object InizializzaSettings: TAction
      Caption = 'Inizializza Settings'
      ImageIndex = 59
      OnExecute = InizializzaSettingsExecute
    end
    object InizializzaAutorizzazioni: TAction
      Caption = 'Inizializza Autorizzazioni'
      ImageIndex = 59
      OnExecute = InizializzaAutorizzazioniExecute
    end
    object ClonaUtente: TAction
      Caption = 'Clona Diritti Da Altro Utente'
      ImageIndex = 245
      OnExecute = ClonaUtenteExecute
    end
    object CreaUtenteDominio: TAction
      Caption = 'Crea Utente Dominio'
      ImageIndex = 164
      OnExecute = CreaUtenteDominioExecute
    end
    object InizializzaHyperLinks: TAction
      Caption = 'Inizializza HyperLinks'
      ImageIndex = 59
      OnExecute = InizializzaHyperLinksExecute
    end
    object ImpersonaUtenteSelezionato: TAction
      Caption = 'Impersona Utente Selezionato'
      ImageIndex = 320
      OnExecute = ImpersonaUtenteSelezionatoExecute
    end
    object Shutdown: TAction
      Caption = 'Shutdown'
      ImageIndex = 40
      OnExecute = ShutdownExecute
    end
    object BroadcastMessage: TAction
      Caption = 'Broadcast Message'
      ImageIndex = 437
      OnExecute = BroadcastMessageExecute
    end
    object AggiungiUtenti: TAction
      Caption = 'Aggiungi Utenti'
      ImageIndex = 170
      OnExecute = AggiungiUtentiExecute
    end
    object InizializzaNotifiche: TAction
      Caption = 'Inizializza Notifiche'
      ImageIndex = 59
      OnExecute = InizializzaNotificheExecute
    end
  end
end
