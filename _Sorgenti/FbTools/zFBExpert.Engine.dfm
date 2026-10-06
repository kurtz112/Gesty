object zFBExpertEngine: TzFBExpertEngine
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 336
  Width = 176
  object FDScript: TFDScript
    SQLScripts = <>
    Params = <>
    Macros = <>
    OnConsolePut = FDScriptConsolePut
    OnConsoleGet = FDScriptConsoleGet
    OnPause = FDScriptPause
    OnError = FDScriptError
    AfterExecute = FDScriptAfterExecute
    Left = 69
    Top = 24
  end
  object FDGUIxScriptDialog: TFDGUIxScriptDialog
    Provider = 'Forms'
    Options = [ssCallstack, ssAutoHide]
    Left = 69
    Top = 263
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 69
    Top = 202
  end
  object FDGUIxAsyncExecuteDialog: TFDGUIxAsyncExecuteDialog
    Provider = 'Forms'
    Caption = 'FireDAC Executor Working'
    Left = 69
    Top = 146
  end
  object FDGUIxErrorDialog: TFDGUIxErrorDialog
    Provider = 'Forms'
    Caption = 'FireDAC Executor Error'
    Left = 69
    Top = 90
  end
end
