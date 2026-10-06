inherited CalendarioAvvioCorsi: TCalendarioAvvioCorsi
  Height = 154
  Width = 589
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Giorni'
        DataSet = Giorni
        OnClose = ocPost
      end
      item
        DisplayName = 'lkProgetti'
        DataSet = lkProgetti
        OnClose = ocPost
      end
      item
        DisplayName = 'DateChiusura'
        DataSet = DateChiusura
        OnClose = ocPost
      end
      item
        DisplayName = 'ElencoPerReport'
        DataSet = ElencoPerReport
        OnClose = ocPost
      end>
  end
  object GiorniSrc: TDataSource
    DataSet = Giorni
    Left = 192
    Top = 88
  end
  object Giorni: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    TableName = 'CALENDARIO_INIZIO_CORSO_TMP'
    Left = 104
    Top = 88
  end
  object lkProgettiSrc: TDataSource
    DataSet = lkProgetti
    Left = 488
    Top = 24
  end
  object lkProgetti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    TableName = 'PROGETTI'
    Left = 400
    Top = 24
  end
  object DateChiusuraSrc: TDataSource
    DataSet = DateChiusura
    Left = 488
    Top = 88
  end
  object DateChiusura: TzFbDataSet
    BeforeOpen = DateChiusuraBeforeOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    TableName = 'ENTI_SEDI_GIORNI_CHIUSURA'
    Left = 400
    Top = 88
  end
  object ElencoPerReport: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    TableName = 'CALENDARIO_INIZIO_CORSO_GET'
    Left = 192
    Top = 16
  end
end
