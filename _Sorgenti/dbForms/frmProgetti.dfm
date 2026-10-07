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
    Images = zDmImages.ImageList24
    Left = 336
    Top = 176
    object ModificaEstensore: TAction
      Caption = 'Modifica Estensore'
      ImageIndex = 164
      Visible = False
      OnExecute = ModificaEstensoreExecute
    end
    object AccettaOreResidue: TAction
      Caption = 'Accetta Ore Residue'
      ImageIndex = 402
      OnExecute = AccettaOreResidueExecute
    end
    object CopiaMaterie: TAction
      Caption = 'Copia Materie'
      ImageIndex = 118
      OnExecute = CopiaMaterieExecute
    end
    object NuovoPianoPersonale: TAction
      Caption = 'Nuovo Piano Personale'
      ImageIndex = 302
      OnExecute = NuovoPianoPersonaleExecute
    end
    object IscrizioneStudenti: TAction
      Caption = 'Iscrizione Studenti'
      ImageIndex = 165
      OnExecute = IscrizioneStudentiExecute
    end
    object NumerazioneRegistro: TAction
      Caption = 'Numerazione Registro'
      ImageIndex = 46
      OnExecute = NumerazioneRegistroExecute
    end
    object AggiungiStudentiStage: TAction
      Caption = 'Aggiungi Studenti'
      ImageIndex = 165
      OnExecute = AggiungiStudentiStageExecute
    end
    object NuovaAziendaOspitante: TAction
      Caption = 'Nuova Azienda Ospitante'
      ImageIndex = 473
      OnExecute = NuovaAziendaOspitanteExecute
    end
    object MaterieGeneraIncarico: TAction
      Caption = 'Genera Incarico'
      ImageIndex = 302
      OnExecute = MaterieGeneraIncaricoExecute
    end
    object BudgetCopiaDaAltroProgetto: TAction
      Caption = 'Copia Da Altro Progetto'
      ImageIndex = 118
      OnExecute = BudgetCopiaDaAltroProgettoExecute
    end
    object BudgetAggiungiRighe: TAction
      Caption = 'Aggiungi Righe'
      ImageIndex = 48
      OnExecute = BudgetAggiungiRigheExecute
    end
    object RegistroStudenti: TAction
      Caption = 'Registro Studenti'
      ImageIndex = 455
      OnExecute = RegistroStudentiExecute
    end
    object CalendarioCorsi: TAction
      Caption = 'Calendario Corsi'
      ImageIndex = 272
      OnExecute = CalendarioCorsiExecute
    end
    object EsportaPDFFirmatiDigitalmente: TAction
      Caption = 'Esporta PDF'
      ImageIndex = 5
      OnExecute = EsportaPDFFirmatiDigitalmenteExecute
    end
    object Procedi: TAction
      Caption = 'Procedi'
      Hint = 'Esegue il passaggio della fase degli incarichi selezionati'
      ImageIndex = 18
      OnExecute = ProcediExecute
    end
  end
end
