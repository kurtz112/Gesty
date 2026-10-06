inherited FbExpert: TFbExpert
  Height = 404
  Width = 276
  object FDScript: TFDScript
    SQLScripts = <>
    Params = <>
    Macros = <>
    Left = 141
    Top = 8
  end
  object DataSet: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    Left = 141
    Top = 64
  end
  object FDGUIxScriptDialog: TFDGUIxScriptDialog
    Provider = 'Forms'
    Options = [ssCallstack, ssAutoHide]
    Left = 141
    Top = 327
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 141
    Top = 266
  end
  object FDGUIxAsyncExecuteDialog: TFDGUIxAsyncExecuteDialog
    Provider = 'Forms'
    Caption = 'FireDAC Executor Working'
    Left = 141
    Top = 210
  end
  object FDGUIxErrorDialog: TFDGUIxErrorDialog
    Provider = 'Forms'
    Caption = 'FireDAC Executor Error'
    Left = 141
    Top = 154
  end
end
