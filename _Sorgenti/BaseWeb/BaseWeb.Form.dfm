inherited FormBaseWeb: TFormBaseWeb
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  object dxPanel1: TdxPanel [1]
    Left = 0
    Top = 22
    Width = 100
    Height = 41
    TabOrder = 5
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
    inherited barSistema: TdxBar
      DockedLeft = 123
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 208
    Top = 64
    object VerificaDataSet: TAction
      Caption = 'Verifica DataSet'
      Hint = 'verifica i dataset selezionati'
      ImageIndex = 18
      OnExecute = VerificaDataSetExecute
    end
    object GeneraCampi: TAction
      Caption = 'Genera Campi'
      Hint = 'genera i fields per i dataset selezionati'
      ImageIndex = 466
      OnExecute = GeneraCampiExecute
    end
    object Editor: TAction
      Caption = 'Editor'
      ImageIndex = 11
      ShortCut = 16504
      OnExecute = EditorExecute
    end
  end
end
