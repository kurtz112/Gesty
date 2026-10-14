inherited FormServiziAlLavoro: TFormServiziAlLavoro
  ClientHeight = 464
  ClientWidth = 633
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 649
  ExplicitHeight = 503
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 216
    Top = 88
    object NuovaAzienda: TAction
      Caption = 'Nuova Azienda'
      ImageIndex = 1913
      OnExecute = NuovaAziendaExecute
    end
    object AggiungiServizi: TAction
      Caption = 'Aggiungi Servizi'
      ImageIndex = 1629
      OnExecute = AggiungiServiziExecute
    end
  end
end
