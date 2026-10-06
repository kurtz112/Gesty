inherited Tirocini: TTirocini
  Height = 339
  Width = 114
  inherited dbMaster: TdbMaster
    Left = 41
  end
  object ActionList: TActionList
    Left = 41
    Top = 72
    object actNuovaAziendaOspitante: TAction
      Caption = 'Nuova Azienda Ospitante'
      ImageIndex = 473
      OnExecute = actNuovaAziendaOspitanteExecute
    end
  end
  object dlgPeriodi: TzDbViewDlg
    Caption = 'Periodi'
    ToolActions = <>
    OnInitDialog = dlgPeriodiInitDialog
    Left = 41
    Top = 144
  end
  object QExport4Xlsx: TQExport4Xlsx
    About = '(About EMS AdvancedExport)'
    _Version = '4.15.0.1'
    OnBeforeExportRow = QExport4XlsxBeforeExportRow
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
    Left = 40
    Top = 272
  end
  object cardOrario: TzDbCardDlg
    Caption = 'Orario'
    CardID = 'TirociniOrario'
    Left = 41
    Top = 208
  end
end
