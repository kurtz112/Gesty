inherited CalendarioAule: TCalendarioAule
  Height = 138
  Width = 336
  object CalendarioAule: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    Left = 112
    Top = 8
  end
  object Orario: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'ORARIO'
    Left = 257
    Top = 13
  end
  object cardOrario: TzDbCardDlg
    Caption = 'Orario'
    DataSet = Orario
    Left = 257
    Top = 69
  end
  object cxSchedulerStorage: TcxSchedulerStorage
    CustomFields = <>
    Resources.Items = <>
    Left = 112
    Top = 72
  end
end
