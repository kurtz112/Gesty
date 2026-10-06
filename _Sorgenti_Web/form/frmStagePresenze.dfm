inherited FormStagePresenze: TFormStagePresenze
  Width = 640
  Height = 480
  OnResize = WebFormResize
  object Presenze: TjdxDataSource
    dm = 'Stage'
    dataset = 'Presenze'
    key = 'ID_STAGE_PRESENZA_WEB'
    Left = 48
    Top = 166
  end
  object Contenuti: TjdxDataSource
    dm = 'Stage'
    dataset = 'Contenuti'
    key = 'CONTENUTI'
    Left = 48
    Top = 231
  end
  object Orari: TjdxDataSource
    dm = 'Stage'
    dataset = 'Orari'
    key = 'ORA'
    Left = 48
    Top = 296
  end
  object Stage: TjdxDataSource
    dm = 'Stage'
    dataset = 'ElencoStage'
    key = 'ID_TIROCINIO'
    Left = 48
    Top = 101
  end
end
