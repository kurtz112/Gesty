inherited FormBandi: TFormBandi
  Caption = 'Bandi'
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 280
    Top = 64
    object ParereFavorevole: TAction
      Category = 'Valutazione'
      Caption = 'Parere favorevole'
      Hint = 'Esprime il parere favorevole del livello sul bando selezionato'
      ImageIndex = 1496
      OnExecute = ParereFavorevoleExecute
    end
    object ParereContrario: TAction
      Category = 'Valutazione'
      Caption = 'Parere contrario'
      Hint = 'Esprime il parere contrario, con motivazione: il bando viene scartato'
      ImageIndex = 2044
      OnExecute = ParereContrarioExecute
    end
    object RiapriValutazione: TAction
      Category = 'Valutazione'
      Caption = 'Riapri valutazione'
      Hint = 'Annulla i pareri espressi e riparte dal primo livello'
      ImageIndex = 1346
      OnExecute = RiapriValutazioneExecute
    end
  end
end
