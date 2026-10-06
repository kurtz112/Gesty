inherited WizInserimentoIncarico: TWizInserimentoIncarico
  Height = 379
  Width = 415
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Incarico'
        DataSet = Incarico
        OnClose = ocPost
      end
      item
        DisplayName = 'Corsi'
        DataSet = Corsi
        OnClose = ocPost
      end
      item
        DisplayName = 'Piani'
        DataSet = Piani
        OnClose = ocPost
      end
      item
        DisplayName = 'Servizi'
        DataSet = Servizi
        OnClose = ocPost
      end
      item
        DisplayName = 'Riepilogo'
        DataSet = Riepilogo
        OnClose = ocPost
      end
      item
        DisplayName = 'lkStudenti'
        DataSet = lkStudenti
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkServizi'
        DataSet = lkServizi
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkProgettiCorsi'
        DataSet = lkProgettiCorsi
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'NuovoProgetto'
        DataSet = NuovoProgetto
        IncludeInOpen = False
        IncludeInRefresh = False
        OnClose = ocPost
      end>
  end
  object IncaricoSrc: TDataSource
    DataSet = Incarico
    Left = 112
    Top = 72
  end
  object Incarico: TzFbDataSet
    BeforeOpen = IncaricoBeforeOpen
    AfterOpen = IncaricoAfterOpen
    AfterInsert = IncaricoAfterInsert
    BeforePost = IncaricoBeforePost
    AfterPost = IncaricoAfterPost
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PERSONALE_INCARICHI_ELENCO'
    OnAfterCreateFields = IncaricoAfterCreateFields
    Left = 24
    Top = 72
  end
  object PianiSrc: TDataSource
    DataSet = Piani
    Left = 112
    Top = 192
  end
  object Piani: TzFbDataSet
    MasterSource = IncaricoSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'INCARICHI_PIANI_PERSONALIZZATI'
    Left = 24
    Top = 192
  end
  object ServiziSrc: TDataSource
    DataSet = Servizi
    Left = 112
    Top = 252
  end
  object Servizi: TzFbDataSet
    AfterPost = AggiornaRiepilogo
    AfterDelete = AggiornaRiepilogo
    MasterSource = PianiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'INCARICHI_PIANI_PERS_SERVIZI'
    Left = 24
    Top = 252
  end
  object lkStudentiDlg: TzDbViewDlg
    Caption = 'Studenti'
    DataSet = lkStudenti
    ToolActions = <>
    Left = 240
    Top = 132
  end
  object lkStudenti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'INCARICHI_PIANI_LK_STUDENTI'
    Left = 344
    Top = 132
  end
  object lkServizi: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'INCARICHI_PIANI_LK_SERVIZI'
    Left = 344
    Top = 192
  end
  object lkServiziDlg: TzDbViewDlg
    Caption = 'Servizi'
    DataSet = lkServizi
    ToolActions = <>
    Left = 240
    Top = 192
  end
  object RiepilogoSrc: TDataSource
    DataSet = Riepilogo
    Left = 112
    Top = 312
  end
  object Riepilogo: TzFbDataSet
    MasterSource = PianiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'INCARICHI_PIANI_RIEPILOGO_ORE'
    Left = 24
    Top = 312
  end
  object CorsiSrc: TDataSource
    DataSet = Corsi
    Left = 112
    Top = 132
  end
  object Corsi: TzFbDataSet
    OnNewRecord = CorsiNewRecord
    MasterSource = IncaricoSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'INCARICHI_CORSI'
    Left = 24
    Top = 132
  end
  object cardNuovoCorso: TzDbCardDlg
    Caption = 'Inserimento Corso'
    Left = 240
    Top = 252
  end
  object lkProgettiCorsi: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_CORSI'
    Left = 344
    Top = 252
  end
  object cardNuovoProgetto: TzDbCardDlg
    Caption = 'Inserimento Progetto'
    CardID = 'Progetto'
    DataSet = NuovoProgetto
    Left = 240
    Top = 311
  end
  object NuovoProgetto: TzFbDataSet
    OnNewRecord = NuovoProgettoNewRecord
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_ELENCO'
    Left = 344
    Top = 311
  end
end
