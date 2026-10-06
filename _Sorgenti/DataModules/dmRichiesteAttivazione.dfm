inherited RichiesteAttivazione: TRichiesteAttivazione
  Height = 151
  Width = 329
  object FilesDaCopiare: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RICHIESTE_ATTIV_FILE_DA_COPIARE'
    Left = 119
    Top = 72
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 116
    Top = 8
  end
  object Inquadramento: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RISORSE_TIPO_INQUADRAMENTO'
    Left = 233
    Top = 72
  end
  object cardInquadramento: TzDbCardDlg
    Caption = 'Inquadramento'
    DataSet = Inquadramento
    Left = 233
    Top = 8
  end
end
