inherited FormTabelle: TFormTabelle
  Caption = 'Tabelle'
  ClientHeight = 465
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitHeight = 504
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList16
    Left = 240
    Top = 80
    object AggiungiContenuti: TAction
      Caption = 'Aggiungi Contenuti'
      ImageIndex = 4
      OnExecute = AggiungiContenutiExecute
    end
  end
end
