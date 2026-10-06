inherited FormRilevamenti: TFormRilevamenti
  Width = 640
  Height = 480
  object btnTest: TjdxButton
    Left = 56
    Top = 48
    Width = 96
    Height = 25
    hint = ''
    ElementID = 'btnTest'
    ElementPosition = epIgnore
    tabIndex = 0
    text = 'Test'
  end
  object Rilevamenti: TjdxDataSource
    dm = 'Rilevamenti'
    dataset = 'Rilevamenti'
    key = 'ID_RILEVAMENTO_ORE'
    Left = 56
    Top = 116
  end
end
