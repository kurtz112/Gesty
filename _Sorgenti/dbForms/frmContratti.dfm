inherited FormContratti: TFormContratti
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
    Top = 152
    object Approva: TAction
      Caption = 'Approva Contratto'
      ImageIndex = 1866
      OnExecute = ApprovaExecute
    end
    object Respingi: TAction
      Caption = 'Respingi Contratto'
      ImageIndex = 1868
      OnExecute = RespingiExecute
    end
    object Invia: TAction
      Caption = 'Invia  Per Firma Docente'
      ImageIndex = 1738
      OnExecute = InviaExecute
    end
    object AggiornaStato: TAction
      Caption = 'Aggiorna Stato'
      ImageIndex = 1867
      OnExecute = AggiornaStatoExecute
    end
  end
end
