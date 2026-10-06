inherited StudentiRilevamentoPresenzeAssenze: TStudentiRilevamentoPresenzeAssenze
  Height = 281
  Width = 378
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'lkProgetti'
        DataSet = lkProgetti
        OnClose = ocPost
      end
      item
        DisplayName = 'Assenze'
        DataSet = Presenti
        OnClose = ocPost
      end
      item
        DisplayName = 'Presenti'
        DataSet = Presenti
        OnClose = ocPost
      end
      item
        DisplayName = 'Assenti'
        DataSet = Assenti
        OnClose = ocPost
      end
      item
        DisplayName = 'OreLezione'
        DataSet = OreLezione
        OnClose = ocPost
      end
      item
        DisplayName = 'Individuali'
        DataSet = Individuali
        OnClose = ocPost
      end
      item
        DisplayName = 'lkMaterie'
        DataSet = lkMaterie
        IncludeInOpen = False
        OnClose = ocPost
      end>
  end
  object lkProgetti: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'PROGETTI_ELENCO'
    Left = 145
    Top = 8
  end
  object lkProgettiSrc: TDataSource
    DataSet = lkProgetti
    Left = 216
    Top = 8
  end
  object Presenti: TzFbDataSet
    BeforeOpen = PresentiBeforeOpen
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'STUDENTI_PROGETTI'
    Left = 25
    Top = 144
  end
  object PresentiSrc: TDataSource
    DataSet = Presenti
    Left = 96
    Top = 144
  end
  object Assenti: TzFbDataSet
    BeforeOpen = AssentiBeforeOpen
    AfterPost = AssentiAfterPost
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'STUDENTI_ASSENZE'
    Left = 249
    Top = 144
  end
  object AssentiSrc: TDataSource
    DataSet = Assenti
    Left = 320
    Top = 144
  end
  object OreLezione: TzFbDataSet
    BeforeOpen = OreLezioneBeforeOpen
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'STUDENTI_PROGETTI'
    Left = 137
    Top = 72
  end
  object OreLezioneSrc: TDataSource
    DataSet = OreLezione
    Left = 208
    Top = 72
  end
  object Individuali: TzFbDataSet
    BeforeOpen = IndividualiBeforeOpen
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'STUDENTI_PRESENZE'
    Left = 25
    Top = 208
  end
  object IndividualiSrc: TDataSource
    DataSet = Individuali
    Left = 96
    Top = 208
  end
  object lkMaterie: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'ZZ_MATERIE'
    Left = 249
    Top = 224
  end
  object lkMaterieSrc: TDataSource
    DataSet = lkMaterie
    Left = 312
    Top = 224
  end
end
