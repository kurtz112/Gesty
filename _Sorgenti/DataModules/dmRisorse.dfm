inherited Risorse: TRisorse
  Height = 316
  Width = 764
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'lkProgetti'
        DataSet = lkProgetti
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'Inquadramento'
        DataSet = Inquadramento
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'FilesDaCopiare'
        DataSet = FilesDaCopiare
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkAutPagProgetti'
        DataSet = lkAutPagProgetti
        IncludeInOpen = False
        OnClose = ocPost
      end>
    Left = 40
  end
  object RettificaDlg: TzDbCardDlg
    Caption = 'Rettifica Indirizzo'
    Left = 40
    Top = 64
  end
  object dlgProgetti: TzDbViewDlg
    Caption = 'Progetti'
    DataSet = lkProgetti
    ToolActions = <>
    Left = 153
    Top = 64
  end
  object lkProgetti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_ELENCO'
    Left = 153
    Top = 8
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 312
    Top = 8
  end
  object lkProgettiSrc: TDataSource
    DataSet = lkProgetti
    Left = 224
    Top = 8
  end
  object Inquadramento: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RISORSE_TIPO_INQUADRAMENTO'
    Left = 329
    Top = 248
  end
  object cardInquadramento: TzDbCardDlg
    Caption = 'Inquadramento'
    DataSet = Inquadramento
    Left = 329
    Top = 192
  end
  object FilesDaCopiare: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RICHIESTE_ATTIV_FILE_DA_COPIARE'
    Left = 217
    Top = 192
  end
  object RisorsaDlg: TzDbCardDlg
    Caption = 'Risorsa'
    Left = 40
    Top = 127
  end
  object dlgSupplenti: TzDbViewDlg
    Caption = 'Docenti'
    ToolActions = <>
    Left = 448
    Top = 8
  end
  object cardProtocollo: TzDbCardDlg
    Caption = 'Protocollo'
    Left = 217
    Top = 248
  end
  object lkEntiSrc: TDataSource
    Left = 448
    Top = 72
  end
  object lkAutPagProgetti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_ELENCO'
    Left = 553
    Top = 8
  end
  object lkAutPagProgettiSrc: TDataSource
    DataSet = lkAutPagProgetti
    Left = 664
    Top = 8
  end
end
