inherited BaseWebDM: TBaseWebDM
  Height = 84
  Width = 436
  inherited dbMaster: TdbMaster
    Top = 16
  end
  object qryExec: TFDQuery
    Left = 196
    Top = 16
  end
  object FDCommand: TFDCommand
    Left = 282
    Top = 16
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 110
    Top = 16
  end
  object Campi: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    Left = 368
    Top = 16
  end
end
