inherited WizNuovaAziendaOspitante: TWizNuovaAziendaOspitante
  Height = 457
  Width = 256
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Aziende'
        DataSet = Aziende
        OnClose = ocPost
      end
      item
        DisplayName = 'Tutor'
        DataSet = Contatti
        OnClose = ocPost
      end
      item
        DisplayName = 'SediOperative'
        DataSet = SediOperative
        OnClose = ocPost
      end
      item
        DisplayName = 'Contatti'
        DataSet = Contatti
        OnClose = ocPost
      end
      item
        DisplayName = 'Convenzioni'
        DataSet = Convenzioni
        OnClose = ocPost
      end
      item
        DisplayName = 'Ambiti'
        DataSet = Ambiti
        OnClose = ocPost
      end
      item
        DisplayName = 'Mansioni'
        DataSet = Mansioni
        OnClose = ocPost
      end>
    Left = 41
    Top = 24
  end
  object AziendeSrc: TDataSource
    DataSet = Aziende
    Left = 153
    Top = 80
  end
  object Aziende: TzFbDataSet
    BeforeOpen = AziendeBeforeOpen
    BeforePost = AziendeBeforePost
    AfterPost = AziendeAfterPost
    OnNewRecord = AziendeNewRecord
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AZIENDE'
    Left = 41
    Top = 80
  end
  object ContattiSrc: TDataSource
    DataSet = Contatti
    Left = 153
    Top = 384
  end
  object Contatti: TzFbDataSet
    MasterSource = AziendeSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    NewRecordOptions.MasterToFieldsExcluded = 'CODICE_FISCALE;PARTITA_IVA;TELEFONO_1;TELEFONO_2;E_MAIL;MAIL_PEC;SITO_WEB'
    TableName = 'AZIENDE_CONTATTI_ELENCO'
    Left = 41
    Top = 384
  end
  object SediOperativeSrc: TDataSource
    DataSet = SediOperative
    Left = 153
    Top = 204
  end
  object SediOperative: TzFbDataSet
    MasterSource = AziendeSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AZIENDE_SEDI_OPERATIVE'
    Left = 41
    Top = 204
  end
  object ConvenzioniSrc: TDataSource
    DataSet = Convenzioni
    Left = 153
    Top = 140
  end
  object Convenzioni: TzFbDataSet
    OnNewRecord = ConvenzioniNewRecord
    MasterSource = AziendeSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AZIENDE_CONVENZIONI_ELENCO'
    Left = 41
    Top = 140
  end
  object AmbitiSrc: TDataSource
    DataSet = Ambiti
    Left = 185
    Top = 260
  end
  object Ambiti: TzFbDataSet
    MasterSource = SediOperativeSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AZIENDE_SEDI_OP_AMBITI_INSERIM'
    Left = 73
    Top = 260
  end
  object MansioniSrc: TDataSource
    DataSet = Mansioni
    Left = 185
    Top = 316
  end
  object Mansioni: TzFbDataSet
    MasterSource = AziendeSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AZIENDE_SEDI_OP_AMBITI_MANSIONI'
    Left = 73
    Top = 316
  end
end
