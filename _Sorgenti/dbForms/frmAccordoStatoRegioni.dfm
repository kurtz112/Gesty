inherited FormAccordoStatoRegioni: TFormAccordoStatoRegioni
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
    Left = 280
    Top = 64
    object NuovoIncarico: TAction
      Caption = 'Nuovo Incarico'
      ImageIndex = 246
      OnExecute = NuovoIncaricoExecute
    end
    object ImportaStudenti: TAction
      Caption = 'Importa Studenti'
      ImageIndex = 145
      OnExecute = ImportaStudentiExecute
    end
    object ImportaAnagrafe: TAction
      Caption = 'Importa Anagrafe'
      ImageIndex = 581
      OnExecute = ImportaAnagrafeExecute
    end
    object ImportaFileIscrizioni: TdxFileOpen
      Caption = 'Importa File Iscrizioni'
      Dialog.DefaultExt = '*.xslx'
      Dialog.Filter = 'Excel|*.xlsx|Tutti|*.*'
      ImageIndex = 56
      OnAccept = ImportaFileIscrizioniAccept
    end
    object ImportNoteAnalisiFabbisogni: TAction
      Caption = 'Importa'
      ImageIndex = 75
      OnExecute = ImportNoteAnalisiFabbisogniExecute
    end
    object ImportNoteObiettiviRisultatiAttesi: TAction
      Caption = 'Importa'
      ImageIndex = 75
      OnExecute = ImportNoteObiettiviRisultatiAttesiExecute
    end
    object ImportNoteArticolazioneDidattica: TAction
      Caption = 'Importa'
      ImageIndex = 75
      OnExecute = ImportNoteArticolazioneDidatticaExecute
    end
    object ImportNoteMetodologia: TAction
      Caption = 'Importa'
      ImageIndex = 75
      OnExecute = ImportNoteMetodologiaExecute
    end
    object ImportNoteMateriali: TAction
      Caption = 'Importa'
      ImageIndex = 75
      OnExecute = ImportNoteMaterialiExecute
    end
    object ImportNoteMonitoraggio: TAction
      Caption = 'Importa'
      ImageIndex = 75
      OnExecute = ImportNoteMonitoraggioExecute
    end
    object ImportDescrizioneProvaVerifica: TAction
      Caption = 'Importa'
      ImageIndex = 75
      OnExecute = ImportDescrizioneProvaVerificaExecute
    end
    object ImportNoteVerbale: TAction
      Caption = 'Importa'
      ImageIndex = 75
      OnExecute = ImportNoteVerbaleExecute
    end
  end
end
