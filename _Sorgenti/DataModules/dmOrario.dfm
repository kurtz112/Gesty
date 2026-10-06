inherited Orario: TOrario
  Height = 277
  Width = 580
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Calendario'
        DataSet = Calendario
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkEnti'
        DataSet = lkEnti
        OnClose = ocPost
      end
      item
        DisplayName = 'lkProgetti'
        DataSet = lkProgetti
        OnClose = ocPost
      end
      item
        DisplayName = 'lkProgettiCodReg'
        DataSet = lkProgettiCodReg
        OnClose = ocPost
      end
      item
        DisplayName = 'lkCorsi'
        DataSet = lkCorsi
        OnClose = ocPost
      end
      item
        DisplayName = 'lkMaterie'
        DataSet = lkMaterie
        OnClose = ocPost
      end
      item
        DisplayName = 'lkDocenti'
        DataSet = lkDocenti
        OnClose = ocPost
      end
      item
        DisplayName = 'lkAule'
        DataSet = lkAule
        OnClose = ocPost
      end>
  end
  object CalendarioSrc: TDataSource
    DataSet = Calendario
    Left = 56
    Top = 200
  end
  object cxSchedulerDBStorage: TcxSchedulerDBStorage
    Resources.Items = <>
    Resources.ResourceID = 'ID_DOCENTE'
    Resources.ResourceName = 'NOMINATIVO_O_RAGIONE_SOCIALE'
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
    FieldNames.ResourceID = 'ID_DOCENTE'
    FieldNames.Start = 'INIZIO'
    FieldNames.State = 'STATO'
    FieldNames.TaskCompleteField = 'ATTIVITA_COMPLETATA'
    FieldNames.TaskIndexField = 'ATTIVITA_INDICE'
    FieldNames.TaskLinksField = 'ATTIVITA_LINKS'
    FieldNames.TaskStatusField = 'ATTIVITA_STATUS'
    Left = 56
    Top = 72
  end
  object Calendario: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'CALENDARIO'
    Left = 56
    Top = 142
  end
  object lkProgetti: TzFbDataSet
    BeforeOpen = FiltroEnteBeforeOpen
    AfterOpen = lkProgettiAfterOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI'
    UseSqlLocate = False
    Left = 244
    Top = 80
  end
  object lkProgettiSrc: TDataSource
    DataSet = lkProgetti
    Left = 372
    Top = 80
  end
  object lkMaterie: TzFbDataSet
    BeforeOpen = DatasetViewsBeforeOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_MATERIE'
    Left = 490
    Top = 86
  end
  object lkDocenti: TzFbDataSet
    BeforeOpen = DatasetViewsBeforeOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'DOCENTI'
    Left = 490
    Top = 142
  end
  object lkAule: TzFbDataSet
    BeforeOpen = DatasetViewsBeforeOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AULE'
    Left = 490
    Top = 198
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 104
    Top = 8
  end
  object lkCorsi: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_CORSI'
    Left = 244
    Top = 199
  end
  object lkCorsiSrc: TDataSource
    DataSet = lkCorsi
    Left = 372
    Top = 199
  end
  object lkEnti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ENTI'
    Left = 244
    Top = 20
  end
  object lkEntiSrc: TDataSource
    DataSet = lkEnti
    Left = 372
    Top = 20
  end
  object lkProgettiCodReg: TzFbDataSet
    BeforeOpen = FiltroEnteBeforeOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI'
    Left = 244
    Top = 140
  end
  object lkProgettiCodRegSrc: TDataSource
    DataSet = lkProgettiCodReg
    Left = 372
    Top = 140
  end
end
