inherited PrenotazioniAule: TPrenotazioniAule
  Height = 343
  Width = 618
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Calendario'
        DataSet = Calendario
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'Aule'
        DataSet = ElencoAule
        OnClose = ocPost
      end
      item
        DisplayName = 'lkAule'
        DataSet = ElencoAule
        OnClose = ocPost
      end
      item
        DisplayName = 'GiorniLiberiPerAula'
        DataSet = SlotLiberi
        OnClose = ocPost
      end
      item
        DisplayName = 'ElencoAule'
        DataSet = ElencoAule
        OnClose = ocPost
      end
      item
        DisplayName = 'SlotLiberi'
        DataSet = SlotLiberi
        OnClose = ocPost
      end
      item
        DisplayName = 'RiepilogoOccupazioni'
        DataSet = RiepilogoOccupazioni
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkFiltroAule'
        DataSet = lkFiltroAule
        OnClose = ocPost
      end
      item
        DisplayName = 'lkFiltroSedi'
        DataSet = lkFiltroSedi
        OnClose = ocPost
      end>
  end
  object CalendarioSrc: TDataSource
    DataSet = Calendario
    Left = 58
    Top = 200
  end
  object cxSchedulerDBStorage: TcxSchedulerDBStorage
    Resources.Items = <>
    Resources.ResourceID = 'ID_DOCENTE'
    Resources.ResourceName = 'NOMINATIVO_O_RAGIONE_SOCIALE'
    Resources.OnResourceLoaded = cxSchedulerDBStorageResourcesResourceLoaded
    CustomFields = <
      item
        FieldName = 'PUBBLICA'
      end
      item
        FieldName = 'ID_INTESTATARIO'
      end
      item
        FieldName = 'NOMINATIVO_INTESTATARIO'
      end
      item
        FieldName = 'TELEFONO'
      end
      item
        FieldName = 'CELLULARE'
      end>
    DataSource = CalendarioSrc
    FieldNames.ActualFinish = 'ACTUAL_FINE'
    FieldNames.ActualStart = 'ACTUAL_INIZIO'
    FieldNames.Caption = 'OGGETTO'
    FieldNames.EventType = 'TIPO_EVENTO'
    FieldNames.Finish = 'FINE'
    FieldNames.ID = 'ID_AGENDA'
    FieldNames.LabelColor = 'COLORE'
    FieldNames.Message = 'MESSAGGIO'
    FieldNames.Options = 'OPZIONI'
    FieldNames.RecurrenceIndex = 'RICORRENZA'
    FieldNames.RecurrenceInfo = 'RICORRENZA_INFO'
    FieldNames.ReminderDate = 'PROMEMORIA_DATA'
    FieldNames.ReminderMinutesBeforeStart = 'PROMEMORIA_MINUTI_PREAVVISO'
    FieldNames.ReminderResourcesData = 'PROMEMORIA_RESOURCES_DATA'
    FieldNames.ResourceID = 'AULA'
    FieldNames.Start = 'INIZIO'
    FieldNames.State = 'STATO'
    FieldNames.TaskCompleteField = 'ATTIVITA_COMPLETATA'
    FieldNames.TaskIndexField = 'ATTIVITA_INDICE'
    FieldNames.TaskLinksField = 'ATTIVITA_LINKS'
    FieldNames.TaskStatusField = 'ATTIVITA_STATUS'
    Left = 58
    Top = 72
  end
  object Calendario: TzFbDataSet
    BeforeOpen = CalendarioBeforeOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'CALENDARIO'
    Left = 58
    Top = 142
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 104
    Top = 8
  end
  object ElencoAule: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AULE'
    Left = 146
    Top = 142
  end
  object ElencoAuleSrc: TDataSource
    DataSet = ElencoAule
    Left = 144
    Top = 200
  end
  object SlotLiberi: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI'
    Left = 58
    Top = 270
  end
  object lkFiltroAule: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AULE'
    Left = 378
    Top = 142
  end
  object lkFiltroAuleSrc: TDataSource
    DataSet = lkFiltroAule
    Left = 376
    Top = 200
  end
  object RiepilogoOccupazioni: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    ActivationMode = amManual
    AutoCommit = False
    TableName = 'AULE'
    Left = 261
    Top = 142
  end
  object RiepilogoOccupazioniSrc: TDataSource
    DataSet = RiepilogoOccupazioni
    Left = 259
    Top = 200
  end
  object lkFiltroSedi: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ENTI_SEDI'
    Left = 466
    Top = 142
  end
  object lkFiltroSediSrc: TDataSource
    DataSet = lkFiltroSedi
    Left = 464
    Top = 200
  end
  object lkAule: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AULE'
    Left = 554
    Top = 142
  end
  object lkAuleSrc: TDataSource
    DataSet = lkAule
    Left = 552
    Top = 200
  end
end
