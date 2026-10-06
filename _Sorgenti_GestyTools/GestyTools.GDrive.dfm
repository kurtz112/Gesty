object GDrive: TGDrive
  OnCreate = DataModuleCreate
  Height = 126
  Width = 422
  object dxCloudStorage: TdxCloudStorage
    ProviderClassName = 'TdxCloudStorageGoogleDriveProvider'
    Provider.AuthorizationAgent = dxGoogleAPIOAuth2AuthorizationAgent
    Left = 88
    Top = 40
  end
  object dxGoogleAPIOAuth2AuthorizationAgent: TdxGoogleAPIOAuth2AuthorizationAgent
    ClientID = 
      '411091787928-g5e2gfb3rchvk68dmhl08cpvsi2pad93.apps.googleusercon' +
      'tent.com'
    Left = 264
    Top = 40
  end
end
