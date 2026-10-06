inherited Questionari: TQuestionari
  Height = 374
  Width = 357
  object FDStanStorageJSONLink: TFDStanStorageJSONLink
    Left = 249
    Top = 37
  end
  object Docenti_Eliminare: TFDQuery
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      
        '    QUESTIONARI_GET_SEZIONI_DOCENTI(:IDENTIFICATIVO, :ID_SEZIONE' +
        ')'
      'ORDER BY'
      '    QUESTIONARI_GET_SEZIONI_DOCENTI.NOMINATIVO_DOCENTE,'
      '    QUESTIONARI_GET_SEZIONI_DOCENTI.ID_DOCENTE')
    Left = 57
    Top = 285
    ParamData = <
      item
        Name = 'IDENTIFICATIVO'
        ParamType = ptInput
      end
      item
        Name = 'ID_SEZIONE'
        ParamType = ptInput
      end>
  end
  object Sezioni: TFDQuery
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    QUESTIONARI_GET_SEZIONI(:IDENTIFICATIVO)'
      'ORDER BY'
      '    QUESTIONARI_GET_SEZIONI.ORDINE')
    Left = 57
    Top = 99
    ParamData = <
      item
        Name = 'IDENTIFICATIVO'
        ParamType = ptInput
      end>
  end
  object SezioniSrc: TDataSource
    DataSet = Sezioni
    Left = 120
    Top = 100
  end
  object Questionario: TFDQuery
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    QUESTIONARI_GET(:IDENTIFICATIVO)'
      'ORDER BY'
      '    QUESTIONARI_GET.TITOLO_QUESTIONARIO')
    Left = 57
    Top = 37
    ParamData = <
      item
        Name = 'IDENTIFICATIVO'
        ParamType = ptInput
      end>
  end
  object Voci: TFDQuery
    MasterSource = SezioniSrc
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    QUESTIONARI_GET_SEZIONI_VOCI(:ID_SEZIONE)'
      'ORDER BY'
      '    QUESTIONARI_GET_SEZIONI_VOCI.ORDINE')
    Left = 57
    Top = 161
    ParamData = <
      item
        Name = 'ID_SEZIONE'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object VociSrc: TDataSource
    DataSet = Voci
    Left = 118
    Top = 160
  end
  object VociItems: TFDQuery
    MasterSource = VociSrc
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    QUESTIONARI_GET_SEZ_VOCI_ITEMS(:ID_VOCE)')
    Left = 57
    Top = 223
    ParamData = <
      item
        Name = 'ID_VOCE'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
