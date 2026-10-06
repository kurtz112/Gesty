inherited Progetti: TProgetti
  Height = 198
  Width = 651
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'lkEstensori'
        DataSet = lkEstensori
        OnClose = ocPost
      end
      item
        DisplayName = 'lkProgetti'
        DataSet = lkProgetti
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'lkStudenti'
        DataSet = lkStudenti
        OnClose = ocPost
      end
      item
        DisplayName = 'lkStudentiStage'
        DataSet = lkStudentiStage
        OnClose = ocPost
      end
      item
        DisplayName = 'lkRigheBudget'
        DataSet = lkRigheBudget
        IncludeInOpen = False
        OnClose = ocPost
      end>
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 24
    Top = 64
  end
  object dlgEstensori: TzDbViewDlg
    Caption = 'Estensore'
    DataSet = lkEstensori
    ToolActions = <>
    Left = 184
    Top = 80
  end
  object lkEstensori: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    Left = 184
    Top = 24
  end
  object dlgProgetti: TzDbViewDlg
    Caption = 'Progetti'
    DataSet = lkProgetti
    ToolActions = <>
    Left = 272
    Top = 80
  end
  object lkProgetti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI'
    Left = 272
    Top = 24
  end
  object dlgStudenti: TzDbViewDlg
    Caption = 'Studenti'
    DataSet = lkStudenti
    ToolActions = <>
    Left = 341
    Top = 80
  end
  object lkStudenti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI'
    Left = 341
    Top = 24
  end
  object dlgStudentiStage: TzDbViewDlg
    Caption = 'Studenti'
    DataSet = lkStudentiStage
    ToolActions = <>
    Left = 437
    Top = 80
  end
  object lkStudentiStage: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI'
    Left = 437
    Top = 24
  end
  object dlgRigheBudget: TzDbViewDlg
    Caption = 'Tipo Incarico'
    DataSet = lkRigheBudget
    ToolActions = <>
    Left = 541
    Top = 80
  end
  object lkRigheBudget: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTO_LOOKUP_TIPO_INCARICO'
    Left = 541
    Top = 24
  end
  object sbdSelectFolderDialog: TcxShellBrowserDialog
    Left = 56
    Top = 137
  end
end
