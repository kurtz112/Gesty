inherited Sostegno: TSostegno
  Height = 281
  Width = 278
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'lkProgetti'
        DataSet = lkProgetti
        OnClose = ocPost
      end
      item
        DisplayName = 'lkCorsi'
        DataSet = lkCorsi
        OnClose = ocPost
      end
      item
        DisplayName = 'lkDocenti'
        DataSet = lkDocenti
        OnClose = ocPost
      end
      item
        DisplayName = 'lkStudenti'
        DataSet = lkStudenti
        IncludeInOpen = False
        OnClose = ocPost
      end>
  end
  object lkProgetti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI'
    Left = 132
    Top = 20
  end
  object lkProgettiSrc: TDataSource
    DataSet = lkProgetti
    Left = 204
    Top = 20
  end
  object lkCorsi: TzFbDataSet
    BeforeOpen = lkCorsiBeforeOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_CORSI'
    Left = 132
    Top = 76
  end
  object lkCorsiSrc: TDataSource
    DataSet = lkCorsi
    Left = 204
    Top = 76
  end
  object lkDocenti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RISORSE'
    Left = 132
    Top = 140
  end
  object lkDocentiSrc: TDataSource
    DataSet = lkDocenti
    Left = 204
    Top = 140
  end
  object lkStudenti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI_PROGETTI'
    Left = 132
    Top = 212
  end
  object lkStudentiSrc: TDataSource
    DataSet = lkStudenti
    Left = 204
    Top = 212
  end
  object lkStudentiDlg: TzDbViewDlg
    Caption = 'Studenti'
    DataSet = lkStudenti
    ToolActions = <>
    Left = 56
    Top = 212
  end
end
