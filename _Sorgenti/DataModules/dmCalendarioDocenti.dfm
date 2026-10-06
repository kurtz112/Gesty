inherited CalendarioDocenti: TCalendarioDocenti
  Height = 138
  Width = 336
  object CalendarioDocenti: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    Left = 112
    Top = 8
  end
  object Orario: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'ORARIO'
    Left = 257
    Top = 13
  end
  object cardOrario: TzDbCardDlg
    Caption = 'Orario'
    DataSet = Orario
    Left = 257
    Top = 69
  end
  object cxSchedulerStorage: TcxSchedulerStorage
    CustomFields = <
      item
        Name = 'ID_DOCENTE'
        ValueType = 'Integer'
      end
      item
        Name = 'NOMINATIVO'
      end
      item
        Name = 'ID_ORARIO'
        ValueType = 'Integer'
      end>
    Resources.Items = <>
    Left = 112
    Top = 72
  end
end
