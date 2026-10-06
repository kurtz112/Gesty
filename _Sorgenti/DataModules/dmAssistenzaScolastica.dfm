inherited AssistenzaScolastica: TAssistenzaScolastica
  Height = 172
  Width = 495
  object cardUtenteAS: TzDbCardDlg
    Caption = 'Utente AS'
    CardID = '__shared.Utente_AS'
    Left = 112
    Top = 7
  end
  object dlgUtenti: TzDbViewDlg
    Caption = 'Utenti'
    ToolActions = <>
    Left = 208
    Top = 8
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 280
    Top = 8
  end
  object lkAnniFormativi: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    ActivationMode = amManual
    AutoCommit = False
    TableName = 'ZZ_ANNI_FORMATIVI'
    Left = 304
    Top = 104
  end
  object lkAnniFormativiSrc: TDataSource
    DataSet = lkAnniFormativi
    Left = 406
    Top = 104
  end
end
