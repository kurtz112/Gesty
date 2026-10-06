inherited InterventiIntegrativi: TInterventiIntegrativi
  Height = 151
  Width = 261
  object lkDocenti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RISORSE'
    Left = 116
    Top = 12
  end
  object lkDocentiSrc: TDataSource
    DataSet = lkDocenti
    Left = 188
    Top = 12
  end
  object lkStudenti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI_PROGETTI'
    Left = 116
    Top = 84
  end
  object lkStudentiSrc: TDataSource
    DataSet = lkStudenti
    Left = 188
    Top = 84
  end
  object lkStudentiDlg: TzDbViewDlg
    Caption = 'Studenti'
    DataSet = lkStudenti
    ToolActions = <>
    Left = 40
    Top = 84
  end
end
