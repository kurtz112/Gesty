inherited Aziende: TAziende
  Height = 88
  Width = 305
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'lkEnti'
        DataSet = lkEnti
        OnClose = ocPost
      end>
  end
  object lkEnti: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    TableName = 'ENTI'
    Left = 168
    Top = 8
  end
  object lkEntiSrc: TDataSource
    DataSet = lkEnti
    Left = 240
    Top = 8
  end
end
