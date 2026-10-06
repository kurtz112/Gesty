inherited FbProfiler: TFbProfiler
  Height = 308
  Width = 431
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Sessions'
        DataSet = Sessions
        OnClose = ocPost
      end
      item
        DisplayName = 'Results'
        DataSet = Results
        OnClose = ocPost
      end
      item
        DisplayName = 'qryCommand'
        DataSet = qryCommand
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'AsyncQry'
        DataSet = AsyncQry
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'PrepareQry'
        DataSet = PrepareQry
        IncludeInOpen = False
        OnClose = ocPost
      end>
  end
  object Sessions: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    PROFILER.SESSIONS'
      'ORDER BY'
      '    SESSIONS.START_TIMESTAMP DESC'
      '')
    Left = 40
    Top = 108
  end
  object Results: TzFbDataSet
    MasterSource = SessionsSrc
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    PROFILER.STATEMENTS(:PROFILE_ID)'
      'ORDER BY'
      '    STATEMENTS.STATEMENT_ID'
      '')
    Left = 40
    Top = 168
    ParamData = <
      item
        Name = 'PROFILE_ID'
        ParamType = ptInput
      end>
  end
  object qryCommand: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    Left = 352
    Top = 159
  end
  object AsyncQry: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    Left = 248
    Top = 216
  end
  object SessionsSrc: TDataSource
    DataSet = Sessions
    Left = 112
    Top = 108
  end
  object ResultsSrc: TDataSource
    DataSet = Results
    Left = 112
    Top = 168
  end
  object FDCommand: TFDCommand
    Left = 352
    Top = 104
  end
  object PrepareQry: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    Left = 112
    Top = 232
  end
  object AsyncConnection: TFDConnection
    Transaction = AsyncTransaction
    UpdateTransaction = AsyncTransaction
    Left = 248
    Top = 104
  end
  object AsyncTransaction: TFDTransaction
    Connection = AsyncConnection
    Left = 248
    Top = 160
  end
end
