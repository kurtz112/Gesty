inherited FormAziendaScheda: TFormAziendaScheda
  ClientHeight = 465
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 504
  TextHeight = 15
  object OkCancel: TOkCancel [1]
    Left = 0
    Top = 435
    Width = 629
    Height = 30
    Align = alBottom
    TabOrder = 5
    DefaultOk = False
    DefaultCancel = False
    ExplicitTop = 432
    ExplicitWidth = 625
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
end
