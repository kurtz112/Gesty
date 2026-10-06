inherited Common: TCommon
  Height = 135
  Width = 228
  object lkEmail: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    ActivationMode = amManual
    AutoCommit = False
    TableName = 'RISORSE_ELENCO'
    Left = 112
    Top = 10
  end
  object lkAnniFormativi: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    ActivationMode = amManual
    AutoCommit = False
    TableName = 'ZZ_ANNI_FORMATIVI'
    Left = 112
    Top = 72
  end
end
