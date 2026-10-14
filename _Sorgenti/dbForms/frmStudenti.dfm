inherited FormStudenti: TFormStudenti
  Caption = 'layout'
  ClientHeight = 464
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
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
    Left = 240
    Top = 72
    object InserimentoStudente: TAction
      Caption = 'Inserimento Studente'
      ImageIndex = 1345
      OnExecute = InserimentoStudenteExecute
    end
    object RettificaDataIscrizione: TAction
      Caption = 'Rettifica Data Iscrizione'
      ImageIndex = 1722
      OnExecute = RettificaDataIscrizioneExecute
    end
    object RegistraRitiroStudente: TAction
      Caption = 'Registra Ritiro Studente'
      ImageIndex = 1347
      OnExecute = RegistraRitiroStudenteExecute
    end
    object ImportSidi: TdxFileOpen
      Caption = 'Importa'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'CSV|*.csv|Tutti|*.*'
      ImageIndex = 1242
      OnAccept = ImportSidiAccept
    end
    object ImportSpaggiari: TdxFileOpen
      Caption = 'Importa'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'CSV|*.csv|Tutti|*.*'
      ImageIndex = 1242
      OnAccept = ImportSpaggiariAccept
    end
    object CreaUtenteSistema: TAction
      Caption = 'Crea Utenti Sistema'
      ImageIndex = 1827
      OnExecute = CreaUtentiSistemaExecute
    end
    object ImportDomandeIscrizione: TdxFileOpen
      Caption = 'Importa'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'File csv|*.csv|Tutti|*.*'
      ImageIndex = 1242
      OnAccept = ImportDomandeIscrizioneAccept
    end
    object ElaboraDomandeIscrizione: TAction
      Caption = 'Elabora'
      ImageIndex = 165
      OnExecute = ElaboraDomandeIscrizioneExecute
    end
  end
end
