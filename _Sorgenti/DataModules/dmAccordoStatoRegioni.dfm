inherited AccordoStatoRegioni: TAccordoStatoRegioni
  Height = 133
  Width = 382
  object ImportStudentiDlg: TzDbViewDlg
    Caption = 'Iscrivi'
    ToolActions = <>
    Left = 120
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
    Left = 223
    Top = 9
  end
  object ImportNoteDlg: TzDbViewDlg
    Caption = 'Note'
    ToolActions = <>
    Left = 312
    Top = 8
  end
  object ImportAnagrafeDlg: TzDbViewDlg
    Caption = 'Iscrivi'
    ToolActions = <>
    Left = 120
    Top = 72
  end
end
