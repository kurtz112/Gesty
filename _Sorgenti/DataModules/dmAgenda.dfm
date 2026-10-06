inherited Agenda: TAgenda
  Height = 232
  Width = 350
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Calendario'
        DataSet = Calendario
        IncludeInOpen = False
        OnClose = ocPost
      end>
  end
  object SetColorsSrc: TDataSource
    Left = 210
    Top = 152
  end
  object cxSchedulerDBStorage: TcxSchedulerDBStorage
    Resources.Items = <>
    Resources.ResourceColor = 'COLORE'
    Resources.ResourceID = 'ID_RISORSA'
    Resources.ResourceImageIndex = 'IMAGE_INDEX'
    Resources.ResourceName = 'DESC_RISORSA'
    CustomFields = <>
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
    FieldNames.ParentID = 'PARENT_ID'
    FieldNames.RecurrenceIndex = 'RICORRENZA'
    FieldNames.RecurrenceInfo = 'RICORRENZA_INFO'
    FieldNames.ReminderDate = 'PROMEMORIA_DATA'
    FieldNames.ReminderMinutesBeforeStart = 'PROMEMORIA_MINUTI_PREAVVISO'
    FieldNames.ReminderResourcesData = 'PROMEMORIA_RESOURCES_DATA'
    FieldNames.ResourceID = 'ID_RISORSA'
    FieldNames.Start = 'INIZIO'
    FieldNames.State = 'STATO'
    FieldNames.TaskCompleteField = 'ATTIVITA_COMPLETATA'
    FieldNames.TaskIndexField = 'ATTIVITA_INDICE'
    FieldNames.TaskLinksField = 'ATTIVITA_LINKS'
    FieldNames.TaskStatusField = 'ATTIVITA_STATUS'
    Left = 208
    Top = 88
  end
  object Calendario: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    TableName = 'CALENDARIO'
    Left = 96
    Top = 86
  end
  object CalendarioSrc: TDataSource
    DataSet = Calendario
    Left = 96
    Top = 151
  end
end
