inherited FormRilevamentoOre: TFormRilevamentoOre
  Caption = 'Rilevamento Ore'
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
    inherited barSistema: TdxBar
      DockedLeft = 133
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList16
    OnUpdate = BaseActionsUpdate
    Left = 36
    Top = 232
    object RegistraMeseRilevazione: TAction
      Caption = 'Registra Mese Rilevazione'
      ImageIndex = 349
      OnExecute = RegistraMeseRilevazioneExecute
    end
    object GeneraRilevamento: TAction
      Caption = 'Genera Rilevamento'
      ImageIndex = 125
      OnExecute = GeneraRilevamentoExecute
    end
  end
end
