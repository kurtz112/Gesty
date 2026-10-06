inherited WizTirocini: TWizTirocini
  Height = 137
  Width = 221
  object dlgStudentiStage: TzDbViewDlg
    Caption = 'Studenti'
    DataSet = lkStudentiStage
    ToolActions = <>
    Left = 133
    Top = 64
  end
  object lkStudentiStage: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI'
    Left = 133
    Top = 8
  end
end
