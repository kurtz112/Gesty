inherited FormPianiIndividuali: TFormPianiIndividuali
  Caption = 'FormPianiIndividuali'
  ClientHeight = 465
  ClientWidth = 645
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 661
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
    Left = 185
    Top = 72
    object NuovoPianoIndividuale: TAction
      Caption = 'Nuovo Piano Individuale'
      ImageIndex = 302
      OnExecute = NuovoPianoIndividualeExecute
    end
    object InserimentoIncarico: TAction
      Caption = 'Nuovo Incarico'
      ImageIndex = 302
      OnExecute = InserimentoIncaricoExecute
    end
    object GeneraDocumentazione: TAction
      Caption = 'Genera Documentazione'
      ImageIndex = 403
      OnExecute = GeneraDocumentazioneExecute
    end
  end
end
