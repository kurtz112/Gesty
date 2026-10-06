inherited FormAnalisiRilevamenti: TFormAnalisiRilevamenti
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  object zDbPivot1: TzDbPivot [1]
    AlignWithMargins = True
    Left = 312
    Top = 160
    Width = 509
    Height = 329
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    ToolActions = <>
    ToolFilters = <>
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
end
