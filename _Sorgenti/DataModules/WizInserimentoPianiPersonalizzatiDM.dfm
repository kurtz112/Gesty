inherited WizInserimentoPianiPersonalizzati: TWizInserimentoPianiPersonalizzati
  Height = 256
  Width = 355
  PixelsPerInch = 96
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Piano'
        DataSet = Piano
        OnClose = ocPost
      end
      item
        DisplayName = 'Servizi'
        DataSet = Servizi
        OnClose = ocPost
      end
      item
        DisplayName = 'StudentiProgetti'
        DataSet = StudentiProgetti
        IncludeInOpen = False
        OnClose = ocPost
      end>
  end
  object PianoSrc: TDataSource
    DataSet = Piano
    Left = 145
    Top = 80
  end
  object Piano: TzFbDataSet
    BeforeOpen = PianoBeforeOpen
    AfterPost = PianoAfterPost
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PIANI_PERSONALIZZATI'
    Left = 41
    Top = 80
  end
  object ServiziSrc: TDataSource
    DataSet = Servizi
    Left = 145
    Top = 136
  end
  object Servizi: TzFbDataSet
    MasterSource = PianoSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_PIANI_PERS_SERVIZI'
    Left = 41
    Top = 136
  end
  object StudentiProgettiSrc: TDataSource
    DataSet = StudentiProgetti
    Left = 145
    Top = 192
  end
  object StudentiProgetti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI_PROGETTI'
    Left = 41
    Top = 192
  end
  object cardStudentiProgetti: TzDbCardDlg
    Caption = 'Studenti Progetti'
    DataSet = StudentiProgetti
    Left = 273
    Top = 192
  end
  object lkServizi: TzFbDataSet
    MasterSource = PianoSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ZZ_PIANI_PERS_SERVIZI_EROGATI'
    Left = 273
    Top = 16
  end
  object dlgServizi: TzDbViewDlg
    Caption = 'Servizi'
    DataSet = lkServizi
    ToolActions = <>
    Left = 273
    Top = 80
  end
end
