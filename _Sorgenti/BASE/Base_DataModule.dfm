object BaseDataModule: TBaseDataModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 73
  Width = 85
  object dbMaster: TdbMaster
    DataSets = <>
    AutoOpen = False
    AutoClose = False
    OnOpenProgress = dbMasterOpenProgress
    OnClose = ocPost
    Left = 24
    Top = 8
  end
end
