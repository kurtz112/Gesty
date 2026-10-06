inherited PersonalePresenze: TPersonalePresenze
  Height = 138
  Width = 91
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Presenze'
        DataSet = Presenze
        OnClose = ocPost
      end>
  end
  object Presenze: TzFbDataSet
    AfterPost = PresenzeAfterPost
    OnNewRecord = PresenzeNewRecord
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'PERSONALE_PRESENZE'
    Left = 22
    Top = 75
  end
end
