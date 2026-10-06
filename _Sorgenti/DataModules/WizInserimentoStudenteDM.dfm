inherited WizInserimentoStudente: TWizInserimentoStudente
  Height = 590
  Width = 487
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Studenti'
        DataSet = Studenti
        OnClose = ocPost
      end
      item
        DisplayName = 'Genitori'
        DataSet = Genitori
        OnClose = ocPost
      end
      item
        DisplayName = 'StudentiFiles'
        DataSet = StudentiFiles
        OnClose = ocPost
      end
      item
        DisplayName = 'GenitoriFiles'
        DataSet = GenitoriFiles
        OnClose = ocPost
      end
      item
        DisplayName = 'Progetti'
        DataSet = Progetti
        OnClose = ocPost
      end
      item
        DisplayName = 'BisogniEd'
        DataSet = BisogniEd
        OnClose = ocPost
      end
      item
        DisplayName = 'Lingue'
        DataSet = Lingue
        OnClose = ocPost
      end
      item
        DisplayName = 'FigureProfessionali'
        DataSet = FigureProfessionali
        OnClose = ocPost
      end
      item
        DisplayName = 'Esperienze'
        DataSet = Esperienze
        OnClose = ocPost
      end
      item
        DisplayName = 'DispOrari'
        DataSet = DispOrari
        OnClose = ocPost
      end
      item
        DisplayName = 'ContiCorrenti'
        DataSet = ContiCorrenti
        OnClose = ocPost
      end>
    Left = 49
  end
  object StudentiSrc: TDataSource
    DataSet = Studenti
    Left = 185
    Top = 80
  end
  object Studenti: TzFbDataSet
    BeforeOpen = StudentiBeforeOpen
    AfterOpen = StudentiAfterOpen
    AfterInsert = StudentiFillCache
    AfterEdit = StudentiFillCache
    AfterPost = StudentiAfterPost
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI'
    OnAfterCreateFields = StudentiAfterCreateFields
    Left = 49
    Top = 80
  end
  object GenitoriSrc: TDataSource
    DataSet = Genitori
    Left = 185
    Top = 148
  end
  object Genitori: TzFbDataSet
    AfterInsert = GenitoriAfterInsert
    MasterSource = StudentiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'GENITORI_STUDENTI_ELENCO'
    Left = 49
    Top = 148
  end
  object StudentiFilesSrc: TDataSource
    DataSet = StudentiFiles
    Left = 409
    Top = 80
  end
  object StudentiFiles: TzFbDataSet
    MasterSource = StudentiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'OBJ_FILES_ELENCO'
    Left = 313
    Top = 80
  end
  object GenitoriFilesSrc: TDataSource
    DataSet = GenitoriFiles
    Left = 409
    Top = 148
  end
  object GenitoriFiles: TzFbDataSet
    MasterSource = GenitoriSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'OBJ_FILES_ELENCO'
    Left = 313
    Top = 148
  end
  object ProgettiSrc: TDataSource
    DataSet = Progetti
    Left = 185
    Top = 206
  end
  object Progetti: TzFbDataSet
    OnNewRecord = ProgettiNewRecord
    MasterSource = StudentiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI_PROGETTI'
    Left = 49
    Top = 206
  end
  object BisogniEd: TzFbDataSet
    MasterSource = StudentiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI_BISOGNI_EDUCATIVI_SPEC'
    Left = 49
    Top = 272
  end
  object BisogniEdSrc: TDataSource
    DataSet = BisogniEd
    Left = 185
    Top = 272
  end
  object Lingue: TzFbDataSet
    MasterSource = StudentiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI_LINGUE'
    Left = 49
    Top = 334
  end
  object LingueSrc: TDataSource
    DataSet = Lingue
    Left = 185
    Top = 334
  end
  object Esperienze: TzFbDataSet
    MasterSource = FigureProfessionaliSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI_FIGURE_PROFESSIONALI_ESPERIENZE'
    Left = 409
    Top = 396
  end
  object EsperienzeSrc: TDataSource
    DataSet = Esperienze
    Left = 313
    Top = 396
  end
  object DispOrari: TzFbDataSet
    MasterSource = StudentiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI_DISP_ORARI_CONTRATTO'
    Left = 49
    Top = 458
  end
  object DispOrariSrc: TDataSource
    DataSet = DispOrari
    Left = 185
    Top = 458
  end
  object ContiCorrenti: TzFbDataSet
    MasterSource = StudentiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI_CONTI_CORRENTI'
    Left = 49
    Top = 520
  end
  object ContiCorrentiSrc: TDataSource
    DataSet = ContiCorrenti
    Left = 185
    Top = 520
  end
  object FigureProfessionali: TzFbDataSet
    MasterSource = StudentiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI_FIGURE_PROFESSIONALI'
    Left = 49
    Top = 396
  end
  object FigureProfessionaliSrc: TDataSource
    DataSet = FigureProfessionali
    Left = 185
    Top = 396
  end
end
