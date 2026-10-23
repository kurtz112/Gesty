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
    Images = dx.Immagini
    Left = 280
    Top = 64
    object NuovoIncarico: TAction
      Caption = 'Nuovo Incarico'
      ImageIndex = 1496
      OnExecute = NuovoIncaricoExecute
    end
    object ImportaStudenti: TAction
      Caption = 'Importa Studenti'
      ImageIndex = 1346
      OnExecute = ImportaStudentiExecute
    end
    object ImportaAnagrafe: TAction
      Caption = 'Importa Anagrafe'
      ImageIndex = 2044
      OnExecute = ImportaAnagrafeExecute
    end
    object ImportaFileIscrizioni: TdxFileOpen
      Caption = 'Importa File Iscrizioni'
      Dialog.DefaultExt = '*.xslx'
      Dialog.Filter = 'Excel|*.xlsx|Tutti|*.*'
      ImageIndex = 1744
      OnAccept = ImportaFileIscrizioniAccept
    end
    object ImportNoteAnalisiFabbisogni: TAction
      Caption = 'Importa'
      ImageIndex = 2317
      OnExecute = ImportNoteAnalisiFabbisogniExecute
    end
    object ImportNoteObiettiviRisultatiAttesi: TAction
      Caption = 'Importa'
      ImageIndex = 2317
      OnExecute = ImportNoteObiettiviRisultatiAttesiExecute
    end
    object ImportNoteArticolazioneDidattica: TAction
      Caption = 'Importa'
      ImageIndex = 2317
      OnExecute = ImportNoteArticolazioneDidatticaExecute
    end
    object ImportNoteMetodologia: TAction
      Caption = 'Importa'
      ImageIndex = 2317
      OnExecute = ImportNoteMetodologiaExecute
    end
    object ImportNoteMateriali: TAction
      Caption = 'Importa'
      ImageIndex = 2317
      OnExecute = ImportNoteMaterialiExecute
    end
    object ImportNoteMonitoraggio: TAction
      Caption = 'Importa'
      ImageIndex = 2317
      OnExecute = ImportNoteMonitoraggioExecute
    end
    object ImportDescrizioneProvaVerifica: TAction
      Caption = 'Importa'
      ImageIndex = 2317
      OnExecute = ImportDescrizioneProvaVerificaExecute
    end
    object ImportNoteVerbale: TAction
      Caption = 'Importa'
      ImageIndex = 2317
      OnExecute = ImportNoteVerbaleExecute
    end
    object GefosDatiCorso: TAction
      Category = 'GEFOS'
      Caption = 'Dati GEFOS del corso'
      Hint = 'Crea i dati GEFOS del corso con la sede dell'#39'ente e la tipologia proposta'
      ImageIndex = 1496
      OnExecute = GefosDatiCorsoExecute
    end
    object GefosGeneraGiornate: TAction
      Category = 'GEFOS'
      Caption = 'Genera giornate'
      Hint = 'Riempie le giornate del corso dalle date e dalle ore totali'
      ImageIndex = 1496
      OnExecute = GefosGeneraGiornateExecute
    end
    object GefosControllaCorso: TAction
      Category = 'GEFOS'
      Caption = 'Controlla per GEFOS'
      Hint = 'Controlla corso, giornate e partecipanti senza inviare niente'
      ImageIndex = 2044
      OnExecute = GefosControllaCorsoExecute
    end
    object GefosComunicaAvvio: TAction
      Category = 'GEFOS'
      Caption = 'Comunica avvio a GEFOS'
      Hint = 'Crea corso, edizioni e partecipanti in GEFOS e comunica l'#39'avvio'
      ImageIndex = 1744
      OnExecute = GefosComunicaAvvioExecute
    end
    object GefosComunicaEsiti: TAction
      Category = 'GEFOS'
      Caption = 'Comunica esiti a GEFOS'
      Hint = 'Comunica a GEFOS gli esiti dei partecipanti'
      ImageIndex = 1744
      OnExecute = GefosComunicaEsitiExecute
    end
    object GefosConfermaConclusione: TAction
      Category = 'GEFOS'
      Caption = 'Conferma conclusione a GEFOS'
      Hint = 'Conferma a GEFOS la conclusione del corso (irreversibile)'
      ImageIndex = 1744
      OnExecute = GefosConfermaConclusioneExecute
    end
    object GefosAggiornaTipologie: TAction
      Category = 'GEFOS'
      Caption = 'Aggiorna tipologie GEFOS'
      Hint = 'Legge da GEFOS le tipologie di corso dell'#39'ente'
      ImageIndex = 1346
      OnExecute = GefosAggiornaTipologieExecute
    end
  end
end
