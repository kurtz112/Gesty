inherited FormAS_Rendicontazione: TFormAS_Rendicontazione
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 176
    Top = 56
    object ImportTreEffe: TdxFileOpen
      Caption = 'Importa File Rendicontazione'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'CSV|*.csv|Tutti|*.*'
      ImageIndex = 1744
      OnAccept = ImportTreEffeAccept
    end
    object ElaboraTreEffe: TAction
      Caption = 'Elabora Rendicontazioni'
      ImageIndex = 1591
      OnExecute = ElaboraTreEffeExecute
    end
  end
end
