inherited InserimentoLavorativo: TInserimentoLavorativo
  Height = 90
  Width = 276
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'lkProfili'
        DataSet = lkProfili
        OnClose = ocPost
      end>
    Top = 16
  end
  object dlgProfili: TzDbViewDlg
    Caption = 'Risultati'
    DataSet = lkProfili
    ToolActions = <>
    Left = 160
    Top = 16
  end
  object lkProfili: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'SAL_RICHIESTE_PROFILI_ELENCO'
    Left = 217
    Top = 16
  end
end
