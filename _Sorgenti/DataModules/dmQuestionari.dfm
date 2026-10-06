inherited Questionari: TQuestionari
  Height = 409
  Width = 463
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'lkQuestionari'
        DataSet = lkQuestionari
        OnClose = ocPost
      end
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
        DisplayName = 'lkRaggruppamenti'
        DataSet = lkRaggruppamenti
        OnClose = ocPost
      end>
  end
  object SalvaLinkDlg: TdxSaveFileDialog
    DefaultExt = '*.txt'
    Filter = 'Testo|*.txt|Tutti|*.*'
    Left = 384
    Top = 8
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 231
    Top = 8
  end
  object lkProgetti: TzFbDataSet
    BeforeOpen = lkProgettiBeforeOpen
    AfterOpen = lkProgettiAfterOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI'
    UseSqlLocate = False
    Left = 112
    Top = 191
  end
  object lkProgettiSrc: TDataSource
    DataSet = lkProgetti
    Left = 231
    Top = 191
  end
  object lkCorsi: TzFbDataSet
    BeforeOpen = lkCorsiBeforeOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_CORSI'
    Left = 112
    Top = 246
  end
  object lkCorsiSrc: TDataSource
    DataSet = lkCorsi
    Left = 231
    Top = 246
  end
  object lkDocenti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RISORSE'
    Left = 112
    Top = 302
  end
  object lkDocentiSrc: TDataSource
    DataSet = lkDocenti
    Left = 231
    Top = 302
  end
  object SalvaQuestionarioDlg: TdxSaveFileDialog
    DefaultExt = '*.xlsx'
    Filter = 'Excel|*.xlsx|Tutti|*.*'
    Left = 384
    Top = 72
  end
  object lkQuestionari: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'QUESTIONARI'
    UseSqlLocate = False
    Left = 112
    Top = 80
  end
  object lkQuestionariSrc: TDataSource
    DataSet = lkQuestionari
    Left = 231
    Top = 80
  end
  object lkRaggruppamenti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'QUESTIONARI_RAGGRUPPAMENTI'
    UseSqlLocate = False
    Left = 112
    Top = 135
  end
  object lkRaggruppamentiSrc: TDataSource
    DataSet = lkRaggruppamenti
    Left = 231
    Top = 135
  end
end
