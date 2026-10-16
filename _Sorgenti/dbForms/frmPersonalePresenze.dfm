inherited FormPersonalePresenze: TFormPersonalePresenze
  Caption = 'FormPersonalePresenze'
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 160
    Top = 56
    object ImportaOmniaTime: TdxFileOpen
      Caption = 'Importa'
      Dialog.DefaultExt = '*.*'
      Dialog.Filter = 'Tutti|*.*'
      ImageIndex = 2290
      OnAccept = ImportaOmniaTimeAccept
    end
    object ElaboraOmniaTime: TAction
      Caption = 'Elabora'
      ImageIndex = 2294
      OnExecute = ElaboraOmniaTimeExecute
    end
  end
end
