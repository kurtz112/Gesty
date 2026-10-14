inherited FormProgetti: TFormProgetti
  Caption = 'FormProgetti'
  ClientHeight = 465
  ClientWidth = 633
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 649
  ExplicitHeight = 504
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 336
    Top = 176
    object ModificaEstensore: TAction
      Caption = 'Modifica Estensore'
      ImageIndex = 1350
      Visible = False
      OnExecute = ModificaEstensoreExecute
    end
    object AccettaOreResidue: TAction
      Caption = 'Accetta Ore Residue'
      ImageIndex = 1258
      OnExecute = AccettaOreResidueExecute
    end
    object CopiaMaterie: TAction
      Caption = 'Copia Materie'
      ImageIndex = 1245
      OnExecute = CopiaMaterieExecute
    end
    object NuovoPianoPersonale: TAction
      Caption = 'Nuovo Piano Personale'
      ImageIndex = 2000
      OnExecute = NuovoPianoPersonaleExecute
    end
    object IscrizioneStudenti: TAction
      Caption = 'Iscrizione Studenti'
      ImageIndex = 1344
      OnExecute = IscrizioneStudentiExecute
    end
    object NumerazioneRegistro: TAction
      Caption = 'Numerazione Registro'
      ImageIndex = 345
      OnExecute = NumerazioneRegistroExecute
    end
    object AggiungiStudentiStage: TAction
      Caption = 'Aggiungi Studenti'
      ImageIndex = 1345
      OnExecute = AggiungiStudentiStageExecute
    end
    object NuovaAziendaOspitante: TAction
      Caption = 'Nuova Azienda Ospitante'
      ImageIndex = 1913
      OnExecute = NuovaAziendaOspitanteExecute
    end
    object MaterieGeneraIncarico: TAction
      Caption = 'Genera Incarico'
      ImageIndex = 1498
      OnExecute = MaterieGeneraIncaricoExecute
    end
    object BudgetCopiaDaAltroProgetto: TAction
      Caption = 'Copia Da Altro Progetto'
      ImageIndex = 1630
      OnExecute = BudgetCopiaDaAltroProgettoExecute
    end
    object BudgetAggiungiRighe: TAction
      Caption = 'Aggiungi Righe'
      ImageIndex = 108
      OnExecute = BudgetAggiungiRigheExecute
    end
    object RegistroStudenti: TAction
      Caption = 'Registro Studenti'
      ImageIndex = 1347
      OnExecute = RegistroStudentiExecute
    end
    object CalendarioCorsi: TAction
      Caption = 'Calendario Corsi'
      ImageIndex = 956
      OnExecute = CalendarioCorsiExecute
    end
    object EsportaPDFFirmatiDigitalmente: TAction
      Caption = 'Esporta PDF'
      ImageIndex = 1550
      OnExecute = EsportaPDFFirmatiDigitalmenteExecute
    end
    object Procedi: TAction
      Caption = 'Procedi'
      Hint = 'Esegue il passaggio della fase degli incarichi selezionati'
      ImageIndex = 123
      OnExecute = ProcediExecute
    end
  end
end
