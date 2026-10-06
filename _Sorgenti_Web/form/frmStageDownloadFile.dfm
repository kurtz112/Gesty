inherited FormStageDownloadFile: TFormStageDownloadFile
  Width = 640
  Height = 480
  object Stages: TjdxDataSource
    dm = 'Stage'
    dataset = 'ElencoStage'
    key = 'ID_TIROCINIO'
    Left = 72
    Top = 124
  end
  object Allegati: TjdxDataSource
    dm = 'Stage'
    dataset = 'Allegati'
    key = 'ID_FILE'
    Left = 72
    Top = 196
  end
end
