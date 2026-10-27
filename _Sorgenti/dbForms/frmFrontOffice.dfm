inherited FormFrontOffice: TFormFrontOffice
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
    Left = 216
    Top = 88
    object InoltraComunicazione: TAction
      Caption = 'Inoltra Comunicazione'
      ImageIndex = 463
      OnExecute = InoltraComunicazioneExecute
    end
    object AssegnaTicket: TAction
      Caption = 'Assegna Ticket'
      ImageIndex = 1979
      OnExecute = AssegnaTicketExecute
      OnUpdate = AssegnaTicketUpdate
    end
    object ModificaTicket: TAction
      Caption = 'Modifica Ticket'
      ImageIndex = 1980
      OnExecute = ModificaTicketExecute
    end
    object RichiedeRisposta: TAction
      AutoCheck = True
      Caption = 'Richiede Risposta'
      ImageIndex = 1023
      OnExecute = RichiedeRispostaExecute
      OnUpdate = RichiedeRispostaUpdate
    end
    object SbloccaDatiAnagrafe: TAction
      Caption = 'Sblocca Dati Anagrafe'
      Hint = 'Consente di modificare nominativo, telefono e mail copiati dall'#39'anagrafe'
      ImageIndex = 1980
      OnExecute = SbloccaDatiAnagrafeExecute
      OnUpdate = SbloccaDatiAnagrafeUpdate
    end
    object CercaAnagrafica: TAction
      Caption = 'Cerca Anagrafica'
      Hint = 'Collega il contatto a un'#39'anagrafica cercata per nome, telefono, e-mail o codice fiscale, o la crea se manca'
      ImageIndex = 2323
      OnExecute = CercaAnagraficaExecute
      OnUpdate = CercaAnagraficaUpdate
    end
  end
end
