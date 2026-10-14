inherited FormRisorse: TFormRisorse
  Caption = 'Risorse'
  ClientWidth = 1053
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 1069
  TextHeight = 15
  object layoutCP1: TdxLayoutControl [1]
    Left = 136
    Top = 72
    Width = 721
    Height = 73
    TabOrder = 5
    object edMese: TcxComboBox
      Left = 49
      Top = 29
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.DropDownRows = 12
      Properties.ImmediateDropDownWhenActivated = True
      Properties.ImmediatePost = True
      Properties.Revertable = True
      Properties.OnChange = edMesePropertiesChange
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 120
    end
    object edProgetto: TcxExtLookupComboBox
      Left = 336
      Top = 29
      Properties.ImmediateDropDownWhenActivated = True
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = edProgettoPropertiesEditValueChanged
      Properties.OnInitPopup = edProgettoPropertiesInitPopup
      EditValue = 0
      TabOrder = 2
      Width = 349
    end
    object edAnno: TcxSpinEdit
      Left = 214
      Top = 29
      ParentFont = False
      Properties.OnChange = edAnnoPropertiesChange
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.IsFontAssigned = True
      TabOrder = 1
      Value = 2000
      Width = 60
    end
    object layoutCP1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemMese: TdxLayoutItem
      Parent = dxLayoutGroup2
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Mese:'
      Control = edMese
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemProgetto: TdxLayoutItem
      Parent = dxLayoutGroup2
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Progetto:'
      Control = edProgetto
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 450
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemAnno: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'Anno:'
      Control = edAnno
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 60
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItemCP1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroup2
      AlignHorz = ahClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 4
    end
    object dxLayoutSplitterItemCP1: TdxLayoutSplitterItem
      Parent = dxLayoutGroup2
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 3
    end
    object dxLayoutGroup2: TdxLayoutGroup
      Parent = layoutCP1Group_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem
      Parent = layoutCP1Group_Root
      AlignHorz = ahClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 0
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 216
    Top = 152
    object InserimentoIncarico: TAction
      Caption = 'Nuovo'
      ImageIndex = 38
      OnExecute = InserimentoIncaricoExecute
    end
    object RettificaIncarico: TAction
      Caption = 'Rettifica'
      ImageIndex = 77
      OnExecute = RettificaIncaricoExecute
    end
    object GeneraCollegato: TAction
      Caption = 'Collegato'
      ImageIndex = 525
      OnExecute = GeneraCollegatoExecute
    end
    object CreaUtenteSistema: TAction
      Caption = 'Crea Utente Sistema'
      ImageIndex = 1827
      OnExecute = CreaUtenteSistemaExecute
    end
    object CreaUtenteSistemaTutor: TAction
      Caption = 'Crea Utente Sistema'
      ImageIndex = 1827
      OnExecute = CreaUtenteSistemaTutorExecute
    end
    object CreaUtenteDominio: TAction
      Caption = 'Crea Utente Dominio'
      ImageIndex = 1827
      OnExecute = CreaUtenteDominioExecute
    end
    object RettificaIndirizzoRisorse: TAction
      Caption = 'Rettifica Indirizzo'
      ImageIndex = 1309
      OnExecute = RettificaIndirizzoRisorseExecute
    end
    object DuplicaIncarico: TAction
      Caption = 'Duplica'
      ImageIndex = 42
      OnExecute = DuplicaIncaricoExecute
    end
    object ValidataRilevamentoOre: TAction
      Caption = 'Segna Come Valido'
      ImageIndex = 41
      OnExecute = ValidataRilevamentoOreExecute
    end
    object AnnullaValidazione: TAction
      Caption = 'Annulla Validazione'
      ImageIndex = 1256
      OnExecute = AnnullaValidazioneExecute
    end
    object InviaMail: TAction
      Caption = 'Invia Mail'
      ImageIndex = 1801
      OnExecute = InviaMailExecute
    end
    object RicalcolaTotaliOreAttribuite: TAction
      Caption = 'Ricalcola Totali'
      ImageIndex = 1965
      OnExecute = RicalcolaTotaliOreAttribuiteExecute
    end
    object RicalcolaOreRecupero: TAction
      Caption = 'Ricalcola Ore Recupero'
      ImageIndex = 1259
      OnExecute = RicalcolaOreRecuperoExecute
    end
    object InserimentoIncaricoDaOrario: TAction
      Caption = 'Inserimento Incarico'
      ImageIndex = 1496
      OnExecute = InserimentoIncaricoDaOrarioExecute
    end
    object GeneraRilevamentiOre: TAction
      Caption = 'Genera Rilevamenti Ore'
      ImageIndex = 1606
      OnExecute = GeneraRilevamentiOreExecute
    end
    object GeneraTutorAziendale: TAction
      Caption = 'Genera Tutor Aziendale'
      ImageIndex = 1666
    end
    object GeneraIncarichiMancantiDaRilevamenti: TAction
      Caption = 'Genera Incarico'
      ImageIndex = 1498
      OnExecute = GeneraIncarichiMancantiDaRilevamentiExecute
    end
    object PersonaleImport: TdxFileOpen
      Caption = 'Importa'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'CSV|*.csv|Tutti|*.*'
      ImageIndex = 1242
      OnAccept = PersonaleImportAccept
    end
    object PersonaleElaboraImport: TAction
      Caption = 'Elabora'
      ImageIndex = 165
      OnExecute = PersonaleElaboraImportExecute
    end
    object AziendeImport: TdxFileOpen
      Caption = 'Importa'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'CSV|*.csv|Tutti|*.*'
      ImageIndex = 1242
      OnAccept = AziendeImportAccept
    end
    object AziendeElaboraImport: TAction
      Caption = 'Elabora'
      ImageIndex = 165
      OnExecute = AziendeElaboraImportExecute
    end
    object SpostaAltroProgetto: TAction
      Caption = 'Sposta Altro Progetto'
      ImageIndex = 1633
      OnExecute = SpostaAltroProgettoExecute
    end
    object Supplenza: TAction
      Caption = 'Supplenza'
      ImageIndex = 1331
      OnExecute = SupplenzaExecute
    end
    object EliminaIncarico: TAction
      Caption = 'Elimina Incarico'
      ImageIndex = 1497
      OnExecute = EliminaIncaricoExecute
      OnUpdate = EliminaIncaricoUpdate
    end
    object Integrazione: TAction
      Caption = 'Integrazione'
      ImageIndex = 1003
      OnExecute = IntegrazioneExecute
    end
    object RettificaProtocollo: TAction
      Caption = 'Rettifica Protocollo'
      ImageIndex = 1743
      OnExecute = RettificaProtocolloExecute
    end
    object AnnullaAttivazioneIncarico: TAction
      Caption = 'Annulla Attivazione'
      ImageIndex = 1864
      OnExecute = AnnullaAttivazioneIncaricoExecute
    end
    object ValidaOrePerSettore: TAction
      Caption = 'Valida Ore'
      ImageIndex = 1605
      OnExecute = ValidaOrePerSettoreExecute
    end
    object AnnullaValidazionePerSettore: TAction
      Caption = 'Annulla Validazione'
      ImageIndex = 1256
      OnExecute = AnnullaValidazionePerSettoreExecute
    end
    object RilevamentoOreFatturate: TAction
      Caption = 'Fatturate'
      ImageIndex = 1335
      OnExecute = RilevamentoOreFatturateExecute
    end
    object RilevamentoOreTogliFatturate: TAction
      Caption = 'Non Fatturate'
      ImageIndex = 1336
      OnExecute = RilevamentoOreTogliFatturateExecute
    end
    object GeneraAutorizzazionePagamentoXRisorsa: TAction
      Caption = 'Genera Autorizzazione Pagamento'
      ImageIndex = 1544
      OnExecute = GeneraAutorizzazionePagamentoXRisorsaExecute
    end
  end
end
