inherited Aule: TAule
  Height = 100
  Width = 386
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'RiepilogoGiornalieroAule'
        DataSet = RiepGiornalieroAule
        IncludeInOpen = False
        OnClose = ocPost
      end>
    Top = 20
  end
  object RiepGiornalieroAule: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AULE_PRENOTAZIONI_ELENCO'
    Left = 280
    Top = 20
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 104
    Top = 20
  end
end
