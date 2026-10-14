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
    Images = dx.Immagini
    Left = 312
    Top = 240
    object AggiungiDestinatarioEffettivo: TAction
      Caption = 'Aggiungi Destinatario Effettivo'
      ImageIndex = 1796
      OnExecute = AggiungiDestinatarioEffettivoExecute
    end
    object InterventiCoperture: TAction
      Caption = 'Coperture'
      ImageIndex = 993
      OnExecute = InterventiCopertureExecute
    end
    object RettificaAnagrafica: TAction
      Caption = 'Rettifica Anagrafica'
      ImageIndex = 2053
      OnExecute = RettificaAnagraficaExecute
      OnUpdate = RettificaAnagraficaUpdate
    end
  end
end
