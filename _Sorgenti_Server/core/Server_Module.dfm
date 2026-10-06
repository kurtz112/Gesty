object ServerModule: TServerModule
  OnCreate = WebModuleCreate
  OnDestroy = WebModuleDestroy
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModuleDefaultHandlerAction
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  AfterDispatch = WebModuleAfterDispatch
  OnException = WebModuleException
  Height = 209
  Width = 151
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\FB3\WOW64\fbclient.dll'
    Left = 63
    Top = 25
  end
  object FDStanStorageJSONLink: TFDStanStorageJSONLink
    Left = 63
    Top = 88
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 63
    Top = 152
  end
end
