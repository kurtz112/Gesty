inherited FormAbitareSostegnoScheda: TFormAbitareSostegnoScheda
  ClientHeight = 465
  TextHeight = 15
  object OkCancel: TOkCancel [1]
    Left = 0
    Top = 435
    Width = 633
    Height = 30
    Align = alBottom
    TabOrder = 5
     
    DefaultOk = False
    DefaultCancel = False
    ExplicitTop = 433
    ExplicitWidth = 629
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 256
    Top = 80
    object MostraSchedaInquilino: TAction
      Caption = 'Scheda Inquilino'
      ImageIndex = 164
      OnExecute = MostraSchedaInquilinoExecute
    end
    object MostraSchedaProprietario: TAction
      Caption = 'Scheda Proprietario'
      ImageIndex = 330
      OnExecute = MostraSchedaProprietarioExecute
    end
  end
end
