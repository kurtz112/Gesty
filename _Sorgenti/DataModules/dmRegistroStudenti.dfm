inherited RegistroStudenti: TRegistroStudenti
  Height = 326
  Width = 302
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'lkEnti'
        DataSet = lkEnti
        OnClose = ocPost
      end
      item
        DisplayName = 'lkProgetti'
        DataSet = lkProgetti
        OnClose = ocPost
      end
      item
        DisplayName = 'lkProgettiCodReg'
        DataSet = lkProgettiCodReg
        OnClose = ocPost
      end
      item
        DisplayName = 'lkCorsi'
        DataSet = lkCorsi
        OnClose = ocPost
      end
      item
        DisplayName = 'Orario'
        DataSet = Orario
        IncludeInOpen = False
        OnClose = ocPost
      end>
    Top = 12
  end
  object lkProgetti: TzFbDataSet
    BeforeOpen = FiltroEnteBeforeOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI'
    Left = 100
    Top = 84
  end
  object lkProgettiSrc: TDataSource
    DataSet = lkProgetti
    Left = 220
    Top = 84
  end
  object cardOrario: TzDbCardDlg
    Caption = 'Orario'
    DataSet = Orario
    Left = 96
    Top = 256
  end
  object Orario: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ORARIO'
    Left = 220
    Top = 256
  end
  object lkCorsi: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_CORSI'
    Left = 100
    Top = 196
  end
  object lkCorsiSrc: TDataSource
    DataSet = lkCorsi
    Left = 220
    Top = 196
  end
  object lkEnti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ENTI'
    Left = 100
    Top = 28
  end
  object lkEntiSrc: TDataSource
    DataSet = lkEnti
    Left = 220
    Top = 28
  end
  object lkProgettiCodReg: TzFbDataSet
    BeforeOpen = FiltroEnteBeforeOpen
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI'
    Left = 100
    Top = 140
  end
  object lkProgettiCodRegSrc: TDataSource
    DataSet = lkProgettiCodReg
    Left = 220
    Top = 140
  end
end
