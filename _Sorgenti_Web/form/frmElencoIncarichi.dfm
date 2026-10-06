inherited FormElencoIncarichi: TFormElencoIncarichi
  Width = 742
  Height = 466
  object filterElencoIncarichi: TWebHTMLDiv
    Left = 119
    Top = 55
    Width = 434
    Height = 91
    ElementID = 'filterElencoIncarichi'
    HeightStyle = ssAuto
    WidthStyle = ssAuto
    ElementPosition = epIgnore
    ElementFont = efCSS
    Role = ''
  end
  object apply: TjdxButton
    Left = 119
    Top = 152
    Width = 96
    Height = 25
    hint = ''
    ElementID = 'apply'
    ElementPosition = epIgnore
    tabIndex = 0
    text = 'apply'
    onClick = applyClick
  end
  object btnTest: TjdxButton
    Left = 119
    Top = 24
    Width = 96
    Height = 25
    hint = ''
    ElementID = 'btnTest'
    ElementPosition = epIgnore
    tabIndex = 0
    text = 'Test'
    onClick = btnTestClick
  end
  object ElencoIncarichi: TjdxDataSource
    dm = 'ElencoIncarichi'
    dataset = 'ElencoIncarichi'
    key = 'ID_INCARICO'
    Left = 168
    Top = 228
  end
end
