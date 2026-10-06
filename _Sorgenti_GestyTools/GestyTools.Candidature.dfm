object ImportCandidature: TImportCandidature
  Height = 334
  Width = 192
  object CandidatureAllegati: TFDQuery
    FetchOptions.AssignedValues = [evUnidirectional]
    FetchOptions.Unidirectional = True
    SQL.Strings = (
      'SELECT'
      '    CANDIDATURE_FILES_ALLEGATI.*,'
      '    GET_FULL_FILE_NAME.FULL_FILE_NAME'
      'FROM'
      '    CANDIDATURE'
      
        '          INNER JOIN CANDIDATURE_FILES_ALLEGATI ON CANDIDATURE_F' +
        'ILES_ALLEGATI.ID_CANDIDATURA = CANDIDATURE.ID_CANDIDATURA'
      
        '          LEFT OUTER JOIN GET_FULL_FILE_NAME(CANDIDATURE_FILES_A' +
        'LLEGATI.ID_OBJECT_FILE) ON 1 = 1'
      'WHERE'
      '    CANDIDATURE.ID_FILE_CANDIDATURE = :ID_FILE_CANDIDATURE'
      'ORDER BY'
      '    CANDIDATURE_FILES_ALLEGATI.ID_CANDIDATURA,'
      '    CANDIDATURE_FILES_ALLEGATI.TIPO_ALLEGATO')
    Left = 77
    Top = 248
    ParamData = <
      item
        Name = 'ID_FILE_CANDIDATURE'
        DataType = ftLargeint
        ParamType = ptInput
      end>
    object CandidatureAllegatiID_CANDIDATURA: TLargeintField
      FieldName = 'ID_CANDIDATURA'
      Origin = 'ID_CANDIDATURA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CandidatureAllegatiTIPO_ALLEGATO: TWideStringField
      FieldName = 'TIPO_ALLEGATO'
      Origin = 'TIPO_ALLEGATO'
      Required = True
      Size = 1
    end
    object CandidatureAllegatiFILE_NAME_DA_IMPORT: TWideStringField
      FieldName = 'FILE_NAME_DA_IMPORT'
      Origin = 'FILE_NAME_DA_IMPORT'
      Required = True
      Size = 255
    end
    object CandidatureAllegatiID_OBJECT_FILE: TLargeintField
      FieldName = 'ID_OBJECT_FILE'
      Origin = 'ID_OBJECT_FILE'
      Required = True
    end
    object CandidatureAllegatiFULL_FILE_NAME: TWideStringField
      FieldName = 'FULL_FILE_NAME'
      Origin = 'FULL_FILE_NAME'
      Size = 255
    end
  end
  object procCandidatureImport: TFDStoredProc
    StoredProcName = 'CANDIDATURE_FILES_ADD'
    Left = 77
    Top = 190
    ParamData = <
      item
        Position = 1
        Name = 'NOME_FILE'
        DataType = ftWideString
        ParamType = ptInput
        Size = 255
      end
      item
        Position = 2
        Name = 'FILE_ORIGINALE'
        DataType = ftWideMemo
        ParamType = ptInput
      end
      item
        Position = 3
        Name = 'ID_FILE_CANDIDATURE'
        DataType = ftLargeint
        ParamType = ptOutput
      end>
  end
  object NetHTTPClient: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 77
    Top = 16
  end
  object procCandidatureLogin: TFDStoredProc
    ObjectView = False
    StoredProcName = 'CANDIDATURE_LOGIN'
    Left = 77
    Top = 132
    ParamData = <
      item
        Position = 1
        Name = 'COMPUTER_NAME'
        DataType = ftWideString
        ParamType = ptInput
        Size = 255
      end>
  end
  object QImport3Xlsx: TQImport3Xlsx
    ImportDestination = qidUserDefined
    Formats.DecimalSeparator = ','
    Formats.ThousandSeparator = '.'
    Formats.DateSeparator = '/'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue.Strings = (
      'True')
    Formats.BooleanFalse.Strings = (
      'False')
    Formats.NullValues.Strings = (
      'Null')
    Formats.ShortDateFormat = 'dd/mm/yyyy'
    Formats.LongDateFormat = 'dddd d mmmm yyyy'
    Formats.ShortTimeFormat = 'hh:nn'
    Formats.LongTimeFormat = 'hh:nn:ss'
    FieldFormats = <>
    ErrorLogFileName = 'error.log'
    OnUserDefinedImport = QImport3XlsxUserDefinedImport
    FileName = 'X:\Gesty\Todo\files\GRPA 11-04-2022.xlsx'
    SkipFirstRows = 1
    SheetName = ''
    Left = 77
    Top = 74
  end
end
