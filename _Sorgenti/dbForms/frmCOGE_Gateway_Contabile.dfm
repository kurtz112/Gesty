inherited FormCOGE_Gateway_Contabile: TFormCOGE_Gateway_Contabile
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
    Left = 312
    Top = 240
    object actEsportaPrimaNota: TAction
      Caption = 'Esporta Prima Nota'
      ImageIndex = 250
      OnExecute = actEsportaPrimaNotaExecute
    end
    object actLottoConsegna: TAction
      Caption = 'Consegna Lotto'
      ImageIndex = 248
      OnExecute = actLottoConsegnaExecute
    end
    object actLottoAnnulla: TAction
      Caption = 'Annulla Lotto'
      ImageIndex = 249
      OnExecute = actLottoAnnullaExecute
    end
  end
end
