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
    Images = zDmImages.ImageList16
    Left = 216
    Top = 88
    object InoltraComunicazione: TAction
      Caption = 'Inoltra Comunicazione'
      ImageIndex = 71
      OnExecute = InoltraComunicazioneExecute
    end
    object AssegnaTicket: TAction
      Caption = 'Assegna Ticket'
      ImageIndex = 314
      OnExecute = AssegnaTicketExecute
    end
    object ModificaTicket: TAction
      Caption = 'Modifica Ticket'
      ImageIndex = 390
      OnExecute = ModificaTicketExecute
    end
    object RichiedeRisposta: TAction
      AutoCheck = True
      Caption = 'Richiede Risposta'
      ImageIndex = 392
      OnExecute = RichiedeRispostaExecute
      OnUpdate = RichiedeRispostaUpdate
    end
  end
end
