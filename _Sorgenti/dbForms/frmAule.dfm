inherited FormAule: TFormAule
  Caption = 'FormAule'
  OnCreate = FormCreate
  ExplicitWidth = 657
  ExplicitHeight = 505
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList16
    Left = 144
    Top = 56
    object Autorizza: TAction
      Caption = 'Autorizza'
      ImageIndex = 107
      OnExecute = AutorizzaExecute
    end
  end
end
