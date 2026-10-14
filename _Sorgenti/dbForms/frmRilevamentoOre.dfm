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
    Images = dx.Immagini
    OnUpdate = BaseActionsUpdate
    Left = 36
    Top = 232
    object RegistraMeseRilevazione: TAction
      Caption = 'Registra Mese Rilevazione'
      ImageIndex = 1982
      OnExecute = RegistraMeseRilevazioneExecute
    end
    object GeneraRilevamento: TAction
      Caption = 'Genera Rilevamento'
      ImageIndex = 1983
      OnExecute = GeneraRilevamentoExecute
    end
  end
end
