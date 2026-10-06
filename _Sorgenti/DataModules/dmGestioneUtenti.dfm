inherited GestioneUtenti: TGestioneUtenti
  Height = 219
  Width = 366
  object ClonaUtenteDlg: TzDbViewDlg
    Caption = 'Utente Da Clonare'
    DataSet = lkClonaUtente
    ToolActions = <>
    Left = 176
    Top = 8
  end
  object lkClonaUtente: TzFbDataSet
    FetchOptions.AssignedValues = [evAutoFetchAll, evDetailDelay]
    FetchOptions.AutoFetchAll = afTruncate
    FetchOptions.DetailDelay = 300
    AutoCommit = False
    TableName = 'USR_UTENTI'
    Left = 176
    Top = 64
  end
  object dlgUtenti: TzDbViewDlg
    Caption = 'Utenti'
    ToolActions = <>
    Left = 176
    Top = 136
  end
end
