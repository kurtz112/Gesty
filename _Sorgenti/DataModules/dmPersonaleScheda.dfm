inherited PersonaleScheda: TPersonaleScheda
  Height = 221
  Width = 305
  object SetColorsSrc: TDataSource
    OnDataChange = SetColorsSrcDataChange
    Left = 210
    Top = 152
  end
  object dlgProgettiColonne: TzDbViewDlg
    Caption = 'Progetti da affiancare nel timesheet'
    DataSet = lkProgettiColonne
    ToolActions = <>
    Left = 208
    Top = 24
  end
  object lkProgettiColonne: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI'
    Left = 96
    Top = 24
  end
end
