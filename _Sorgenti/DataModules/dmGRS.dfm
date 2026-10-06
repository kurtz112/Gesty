inherited GRS: TGRS
  Height = 205
  Width = 524
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
        DisplayName = 'lkCorsi'
        DataSet = lkCorsi
        OnClose = ocPost
      end
      item
        DisplayName = 'lkStudenti'
        DataSet = lkStudenti
        OnClose = ocPost
      end>
  end
  object QExport4Xlsx: TQExport4Xlsx
    About = '(About EMS AdvancedExport)'
    _Version = '4.15.0.1'
    OnBeforeExportRow = QExport4XlsxBeforeExportRow
    OnCustomFormat = QExport4XlsxCustomFormat
    ShowFile = True
    Formats.DecimalSeparator = ','
    Formats.ThousandSeparator = '.'
    Formats.DateSeparator = '/'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue = 'true'
    Formats.BooleanFalse = 'false'
    Formats.IntegerFormat = '#,###,##0'
    Formats.FloatFormat = '#,###,##0.00'
    Formats.DateFormat = 'dd/MM/yyyy'
    Formats.TimeFormat = 'hh:mm'
    Formats.DateTimeFormat = 'dd/MM/yyyy hh:mm:ss'
    Formats.CurrencyFormat = #8364' #,###,##0.00'
    SheetName = 'sheet1'
    XlsxOptions.AutoCalcColWidth = True
    XlsxOptions.HeaderStyle.Font.Charset = DEFAULT_CHARSET
    XlsxOptions.HeaderStyle.Font.Color = clBlack
    XlsxOptions.HeaderStyle.Font.Height = -15
    XlsxOptions.HeaderStyle.Font.Name = 'Calibri'
    XlsxOptions.HeaderStyle.Font.Style = []
    XlsxOptions.CaptionRowStyle.Font.Charset = DEFAULT_CHARSET
    XlsxOptions.CaptionRowStyle.Font.Color = clBlack
    XlsxOptions.CaptionRowStyle.Font.Height = -15
    XlsxOptions.CaptionRowStyle.Font.Name = 'Calibri'
    XlsxOptions.CaptionRowStyle.Font.Style = []
    XlsxOptions.DataStyle.Font.Charset = DEFAULT_CHARSET
    XlsxOptions.DataStyle.Font.Color = clBlack
    XlsxOptions.DataStyle.Font.Height = -15
    XlsxOptions.DataStyle.Font.Name = 'Calibri'
    XlsxOptions.DataStyle.Font.Style = []
    XlsxOptions.FooterStyle.Font.Charset = DEFAULT_CHARSET
    XlsxOptions.FooterStyle.Font.Color = clBlack
    XlsxOptions.FooterStyle.Font.Height = -15
    XlsxOptions.FooterStyle.Font.Name = 'Calibri'
    XlsxOptions.FooterStyle.Font.Style = []
    XlsxOptions.StripStylesList = <>
    XlsxOptions.PageSettings.MarginLeft = 0.700000000000000000
    XlsxOptions.PageSettings.MarginRight = 0.700000000000000000
    XlsxOptions.PageSettings.MarginTop = 0.750000000000000000
    XlsxOptions.PageSettings.MarginBottom = 0.750000000000000000
    XlsxOptions.PageSettings.Header = 0.300000000000000000
    XlsxOptions.PageSettings.Footer = 0.300000000000000000
    Left = 104
    Top = 8
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
    Left = 103
    Top = 72
  end
  object lkEnti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ENTI'
    Left = 208
    Top = 11
  end
  object lkEntiSrc: TDataSource
    DataSet = lkEnti
    Left = 208
    Top = 72
  end
  object lkProgetti: TzFbDataSet
    MasterSource = lkEntiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI'
    Left = 280
    Top = 11
  end
  object lkProgettiSrc: TDataSource
    DataSet = lkProgetti
    Left = 280
    Top = 72
  end
  object lkCorsi: TzFbDataSet
    MasterSource = lkProgettiSrc
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'PROGETTI_CORSI'
    Left = 352
    Top = 11
  end
  object lkCorsiSrc: TDataSource
    DataSet = lkCorsi
    Left = 352
    Top = 72
  end
  object lkStudenti: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'STUDENTI'
    Left = 424
    Top = 11
  end
  object lkStudentiSrc: TDataSource
    DataSet = lkStudenti
    Left = 424
    Top = 72
  end
  object QImport3Xls: TQImport3XLS
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
    Left = 103
    Top = 136
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 24
    Top = 72
  end
  object QImport3Xlsx_SIUF: TQImport3Xlsx
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
    Left = 207
    Top = 136
  end
  object QImport3XLsx_GOL: TQImport3Xlsx
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
    Left = 327
    Top = 136
  end
end
