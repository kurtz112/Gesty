inherited FormCandidature: TFormCandidature
  ClientHeight = 465
  StyleElements = [seFont, seClient, seBorder]
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
    Left = 216
    Top = 88
    object GeneraRisorsa: TAction
      Caption = 'Genera Risorsa'
      ImageIndex = 302
      OnExecute = GeneraRisorsaExecute
    end
    object ImportaFile: TdxFileOpen
      Caption = 'Importa File'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'CSV|*.csv|Tutti|*.*'
      ImageIndex = 41
      OnAccept = ImportaFileAccept
    end
  end
end
