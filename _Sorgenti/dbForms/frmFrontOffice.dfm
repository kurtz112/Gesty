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
  end
end
