inherited FormSIA_ServizioInclusioneAdulti: TFormSIA_ServizioInclusioneAdulti
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 312
    Top = 240
    object AggiungiDestinatarioEffettivo: TAction
      Caption = 'Aggiungi Destinatario Effettivo'
      ImageIndex = 145
      OnExecute = AggiungiDestinatarioEffettivoExecute
    end
    object InterventiCoperture: TAction
      Caption = 'Coperture'
      ImageIndex = 18
      OnExecute = InterventiCopertureExecute
    end
  end
end
