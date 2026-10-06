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
    Images = zDmImages.ImageList24
    Left = 240
    Top = 72
    object InserimentoStudente: TAction
      Caption = 'Inserimento Studente'
      ImageIndex = 164
      OnExecute = InserimentoStudenteExecute
    end
    object RettificaDataIscrizione: TAction
      Caption = 'Rettifica Data Iscrizione'
      ImageIndex = 48
      OnExecute = RettificaDataIscrizioneExecute
    end
    object RegistraRitiroStudente: TAction
      Caption = 'Registra Ritiro Studente'
      ImageIndex = 49
      OnExecute = RegistraRitiroStudenteExecute
    end
    object ImportSidi: TdxFileOpen
      Caption = 'Importa'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'CSV|*.csv|Tutti|*.*'
      ImageIndex = 56
      OnAccept = ImportSidiAccept
    end
    object ImportSpaggiari: TdxFileOpen
      Caption = 'Importa'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'CSV|*.csv|Tutti|*.*'
      ImageIndex = 56
      OnAccept = ImportSpaggiariAccept
    end
    object CreaUtenteSistema: TAction
      Caption = 'Crea Utenti Sistema'
      ImageIndex = 377
      OnExecute = CreaUtentiSistemaExecute
    end
    object ImportDomandeIscrizione: TdxFileOpen
      Caption = 'Importa'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'File csv|*.csv|Tutti|*.*'
      ImageIndex = 56
      OnAccept = ImportDomandeIscrizioneAccept
    end
    object ElaboraDomandeIscrizione: TAction
      Caption = 'Elabora'
      ImageIndex = 59
      OnExecute = ElaboraDomandeIscrizioneExecute
    end
  end
end
