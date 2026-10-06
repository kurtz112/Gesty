inherited FormRegistroElettronico: TFormRegistroElettronico
  Width = 632
  Height = 445
  Color = clBtnFace
  object btnTest: TjdxButton
    Left = 320
    Top = 16
    Width = 96
    Height = 25
    hint = ''
    ElementID = 'btnTest'
    ElementPosition = epIgnore
    tabIndex = 0
    text = 'Test'
    onClick = btnTestClick
  end
  object btnSuccessiva: TjdxButton
    Left = 112
    Top = 16
    Width = 96
    Height = 25
    hint = ''
    ElementID = 'btnSuccessiva'
    ElementPosition = epIgnore
    icon = 'fa-solid fa-arrow-right'
    tabIndex = 0
    text = 'Successiva'
    onClick = btnSuccessivaClick
  end
  object btnPrecedente: TjdxButton
    Left = 10
    Top = 16
    Width = 96
    Height = 25
    hint = ''
    ElementID = 'btnPrecedente'
    ElementPosition = epIgnore
    icon = 'fa-solid fa-arrow-left'
    tabIndex = 0
    text = 'Precedente'
    onClick = btnPrecedenteClick
  end
  object btnSalva: TjdxButton
    Left = 216
    Top = 16
    Width = 96
    Height = 25
    hint = ''
    ElementID = 'btnSalva'
    ElementPosition = epIgnore
    icon = 'fa-solid fa-floppy-disk'
    tabIndex = 0
    text = 'Salva'
    onClick = btnSalvaClick
  end
  object Lezione: TjdxDataSource
    dm = 'RegistroElettronico'
    dataset = 'Lezione'
    key = 'ID_ORARIO'
    Left = 80
    Top = 116
  end
  object Presenze: TjdxDataSource
    dm = 'RegistroElettronico'
    dataset = 'Presenze'
    key = 'ID_STUDENTE'
    Left = 80
    Top = 188
  end
end
