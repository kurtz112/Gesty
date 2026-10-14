inherited FormRichiesteAttivazione: TFormRichiesteAttivazione
  ClientHeight = 465
  ClientWidth = 649
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 665
  ExplicitHeight = 504
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
    Top = 152
    object NuovaRichiestaAttivazione: TAction
      Caption = 'Nuova Richiesta Attivazione'
      ImageIndex = 1914
      OnExecute = NuovaRichiestaAttivazioneExecute
    end
    object RicopiaAllegatiRisorsa: TAction
      Caption = 'Ricopia Allegati Risorsa'
      ImageIndex = 983
      OnExecute = RicopiaAllegatiRisorsaExecute
    end
    object ConvalidaRichiestaAttivazione: TAction
      Caption = 'Convalida Richiesta'
      ImageIndex = 1915
      OnExecute = ConvalidaRichiestaAttivazioneExecute
    end
    object RichiestaAttivazioneNonValida: TAction
      Caption = 'Richiesta Non Valida'
      ImageIndex = 1023
      OnExecute = RichiestaAttivazioneNonValidaExecute
    end
    object ApprovaRichiestaAttivazione: TAction
      Caption = 'Approva Richiesta'
      ImageIndex = 1915
      OnExecute = ApprovaRichiestaAttivazioneExecute
    end
    object RespingiRichiestaAttivazione: TAction
      Caption = 'Respingi Richiesta'
      ImageIndex = 1918
      OnExecute = RespingiRichiestaAttivazioneExecute
    end
    object GeneraRisorsa: TAction
      Caption = 'Genera Risorsa'
      ImageIndex = 1349
      OnExecute = GeneraRisorsaExecute
    end
  end
end
