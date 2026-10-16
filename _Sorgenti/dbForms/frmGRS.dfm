inherited FormGRS: TFormGRS
  Caption = 'FormGRS'
  ClientWidth = 641
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 657
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 232
    Top = 88
    object Esporta: TdxFileSaveAs
      Caption = 'Export GRS'
      Dialog.DefaultExt = '*.xlsx'
      Dialog.Filter = 'File Excel|*.xlsx|Tutti|*.*'
      Dialog.Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
      ImageIndex = 1492
      OnAccept = EsportaAccept
    end
    object ImportaGRS: TdxFileOpen
      Caption = 'Importa GRS'
      Dialog.DefaultExt = '*.xlsx'
      Dialog.Filter = 
        'Excel|*.xlsx|File csv|*.csv|Excel 97|*.xls|File xml|*.xml|Tutti|' +
        '*.*'
      ImageIndex = 1491
      OnAccept = ImportaGRSAccept
    end
    object ImportaSIUF: TdxFileOpen
      Caption = 'Importa SIUF'
      Dialog.DefaultExt = '*.xls'
      Dialog.Filter = 'Excel|*.xlsx|Excel 97|*.xls|Tutti|*.*'
      ImageIndex = 1636
      OnAccept = ImportaSIUFAccept
    end
    object ImportaGOL: TdxFileOpen
      Caption = 'Importa GOL'
      Dialog.DefaultExt = '*.xlsx'
      Dialog.Filter = 'Excel|*.xlsx|Tutti|*.*'
      ImageIndex = 1489
      OnAccept = ImportaGOLAccept
    end
    object ElaboraFileImport: TAction
      Caption = 'Elabora'
      ImageIndex = 2195
      OnExecute = ElaboraFileImportExecute
    end
    object EliminaFileImport: TAction
      Caption = 'Elimina File'
      ImageIndex = 1745
      OnExecute = EliminaFileImportExecute
    end
    object GeneraIncarico: TAction
      Caption = 'Genera Incarico'
      ImageIndex = 1498
      OnExecute = GeneraIncaricoExecute
    end
    object GeneraRilevamento: TAction
      Caption = 'Genera Rilevamento'
      ImageIndex = 1606
      OnExecute = GeneraRilevamentoExecute
    end
    object ElaboraRigheImportNonValide: TAction
      Caption = 'Elabora Righe Non Valide'
      ImageIndex = 1932
      OnExecute = ElaboraRigheImportNonValideExecute
    end
    object CooperazioneApplicativa: TAction
      Caption = 'Invia SIUF'
      ImageIndex = 1638
      OnExecute = CooperazioneApplicativaExecute
      OnUpdate = CooperazioneApplicativaUpdate
    end
    object DifferenzeMantieniGesty: TAction
      Caption = 'Mantieni Gesty'
      Hint = 'Le lezioni selezionate restano come sono in Gesty'
      ImageIndex = 1993
      OnExecute = DifferenzeMantieniGestyExecute
    end
    object DifferenzeSovrascrivi: TAction
      Caption = 'Sovrascrivi'
      Hint = 
        'Le lezioni selezionate prendono i dati del file, con le supplenz' +
        'e'
      ImageIndex = 2196
      OnExecute = DifferenzeSovrascriviExecute
    end
    object MonitoraggioEsegui: TAction
      Caption = 'Esegui controllo'
      Hint = 
        'Controlla importazioni e invii SIUF di ieri e di oggi, senza inv' +
        'iare niente'
      ImageIndex = 1362
      OnExecute = MonitoraggioEseguiExecute
    end
    object DifformitaGiustifica: TAction
      Caption = 'Giustifica'
      Hint = 
        'Le difformit'#224' selezionate sono corrette: escono dalle anomalie a' +
        'perte'
      ImageIndex = 78
      OnExecute = DifformitaGiustificaExecute
      OnUpdate = DifformitaUpdate
    end
    object DifformitaRisolta: TAction
      Caption = 'Risolta'
      Hint = 'Le difformit'#224' selezionate sono state corrette'
      ImageIndex = 1958
      OnExecute = DifformitaRisoltaExecute
      OnUpdate = DifformitaUpdate
    end
    object DifformitaRiapri: TAction
      Caption = 'Riapri'
      Hint = 'Le difformit'#224' selezionate tornano da verificare'
      ImageIndex = 2197
      OnExecute = DifformitaRiapriExecute
      OnUpdate = DifformitaUpdate
    end
  end
end
