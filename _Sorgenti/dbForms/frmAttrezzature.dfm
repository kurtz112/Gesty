inherited FormAttrezzature: TFormAttrezzature
  Caption = 'Dotazioni'
  ClientHeight = 467
  ClientWidth = 645
  OnCreate = FormCreate
  ExplicitWidth = 661
  ExplicitHeight = 506
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 32
    Top = 248
    object InviaMail: TAction
      Caption = 'Invia Mail'
      ImageIndex = 1801
      OnExecute = InviaMailExecute
    end
  end
end
