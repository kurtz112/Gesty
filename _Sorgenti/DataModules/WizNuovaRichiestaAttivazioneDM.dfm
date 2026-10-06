inherited WizNuovaRichiestaAttivazione: TWizNuovaRichiestaAttivazione
  Height = 395
  Width = 571
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'RichiestaAttivazione'
        DataSet = RichiestaAttivazione
        OnClose = ocPost
      end
      item
        DisplayName = 'Competenze'
        DataSet = Competenze
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'Settori'
        DataSet = Settori
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'Forniture'
        DataSet = Forniture
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'Allegati'
        DataSet = Allegati
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkForniture'
        DataSet = lkForniture
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkSettori'
        DataSet = lkSettori
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkCompetenze'
        DataSet = lkCompetenze
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkTestiEsigenze'
        DataSet = lkTestiEsigenze
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkReferenti'
        DataSet = lkRichiedenti
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkRichiedenti'
        DataSet = lkRichiedenti
        OnClose = ocPost
      end>
    Left = 41
    Top = 24
  end
  object RichiestaAttivazioneSrc: TDataSource
    DataSet = RichiestaAttivazione
    Left = 153
    Top = 88
  end
  object RichiestaAttivazione: TzFbDataSet
    BeforeOpen = RichiestaAttivazioneBeforeOpen
    AfterInsert = RichiestaAttivazioneAfterInsert
    AfterPost = RichiestaAttivazioneAfterPost
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RICHIESTE_ATTIVAZIONE_ELENCO'
    Left = 41
    Top = 88
  end
  object CompetenzeSrc: TDataSource
    DataSet = Competenze
    Left = 153
    Top = 208
  end
  object Competenze: TzFbDataSet
    BeforeInsert = SalvaRichiestaAttivazione
    MasterSource = RichiestaAttivazioneSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RICHIESTE_ATTIV_COMPETENZE'
    Left = 41
    Top = 208
  end
  object SettoriSrc: TDataSource
    DataSet = Settori
    Left = 153
    Top = 269
  end
  object Settori: TzFbDataSet
    BeforeInsert = SalvaRichiestaAttivazione
    MasterSource = RichiestaAttivazioneSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RICHIESTE_ATTIV_SETTORI'
    Left = 41
    Top = 269
  end
  object FornitureSrc: TDataSource
    DataSet = Forniture
    Left = 153
    Top = 148
  end
  object Forniture: TzFbDataSet
    BeforeInsert = SalvaRichiestaAttivazione
    MasterSource = RichiestaAttivazioneSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RISORSE_TIPO_FORNITURE'
    Left = 41
    Top = 148
  end
  object lkFornitureDlg: TzDbViewDlg
    Caption = 'Forniture'
    DataSet = lkForniture
    ToolActions = <>
    Left = 288
    Top = 148
  end
  object lkForniture: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ZZ_TIPO_FORNITURE'
    Left = 392
    Top = 148
  end
  object lkSettoriDlg: TzDbViewDlg
    Caption = 'Settori'
    DataSet = lkSettori
    ToolActions = <>
    Left = 288
    Top = 208
  end
  object lkSettori: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ZZ_SETTORI'
    Left = 392
    Top = 208
  end
  object lkCompetenzeDlg: TzDbViewDlg
    Caption = 'Competenze'
    DataSet = lkCompetenze
    ToolActions = <>
    Left = 288
    Top = 269
  end
  object lkCompetenze: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ZZ_COMPETENZE'
    Left = 392
    Top = 269
  end
  object lkTestiEsigenzeDlg: TzDbViewDlg
    Caption = 'Esigenze'
    DataSet = lkTestiEsigenze
    ToolActions = <>
    Left = 288
    Top = 88
  end
  object lkTestiEsigenze: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ZZ_TESTI_ESIGENZE'
    Left = 392
    Top = 88
  end
  object lkRichiedenti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PERSONALE'
    Left = 392
    Top = 32
  end
  object lkRichiedentiSrc: TDataSource
    DataSet = lkRichiedenti
    Left = 497
    Top = 32
  end
  object AllegatiSrc: TDataSource
    DataSet = Allegati
    Left = 153
    Top = 333
  end
  object Allegati: TzFbDataSet
    BeforeInsert = SalvaRichiestaAttivazione
    MasterSource = RichiestaAttivazioneSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'OBJECTS_ELENCO_FILES'
    Left = 41
    Top = 333
  end
end
