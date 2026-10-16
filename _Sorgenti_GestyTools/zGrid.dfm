object zGrid: TzGrid
  Left = 0
  Top = 0
  Width = 700
  Height = 400
  TabOrder = 0
  object dockTop: TdxBarDockControl
    Left = 0
    Top = 0
    Width = 700
    Align = dalTop
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 3
    Width = 700
    Height = 397
    Align = alClient
    TabOrder = 1
    ExplicitTop = 26
    ExplicitHeight = 374
    object GridView: TcxGridDBTableView
      OnCellDblClick = GridViewCellDblClick
      DataController.DataSource = DataSource
      FilterRow.Visible = True
      OptionsBehavior.CellHints = True
      OptionsBehavior.IncSearch = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
    end
    object GridLevel: TcxGridLevel
      GridView = GridView
    end
  end
  object DataSource: TDataSource
    Left = 48
    Top = 72
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 48
    Top = 136
    object actAdattaLarghezza: TAction
      Caption = 'Adatta larghezza'
      Hint = 'Adatta la larghezza delle colonne al contenuto'
      OnExecute = actAdattaLarghezzaExecute
    end
    object actRigaFiltri: TAction
      AutoCheck = True
      Caption = 'Riga filtri'
      Hint = 'Mostra o nasconde la riga dei filtri'
      OnExecute = actRigaFiltriExecute
    end
    object actRicerca: TAction
      AutoCheck = True
      Caption = 'Cerca'
      Hint = 'Mostra o nasconde il pannello di ricerca'
      OnExecute = actRicercaExecute
    end
    object actRaggruppamento: TAction
      AutoCheck = True
      Caption = 'Raggruppa'
      Hint = 'Mostra o nasconde l'#39'area di raggruppamento'
      OnExecute = actRaggruppamentoExecute
    end
    object actPiePagina: TAction
      AutoCheck = True
      Caption = 'Totali'
      Hint = 'Mostra o nasconde la riga dei totali'
      OnExecute = actPiePaginaExecute
    end
    object actCopiaCella: TAction
      Caption = 'Copia cella'
      Hint = 'Copia negli appunti il contenuto della cella'
      OnExecute = actCopiaCellaExecute
    end
    object actCopiaRiga: TAction
      Caption = 'Copia riga'
      Hint = 'Copia negli appunti la riga, colonne separate da tabulazione'
      OnExecute = actCopiaRigaExecute
    end
    object actImpostaNull: TAction
      Caption = 'NULL'
      Hint = 'Imposta a NULL il campo selezionato'
      OnExecute = actImpostaNullExecute
    end
    object actImpostaVuoto: TAction
      Caption = 'Vuoto'
      Hint = 'Imposta a stringa vuota il campo selezionato'
      OnExecute = actImpostaVuotoExecute
    end
    object actVediValore: TAction
      Caption = 'Vedi valore'
      Hint = 'Mostra per esteso il contenuto del campo selezionato'
      OnExecute = actVediValoreExecute
    end
    object actEsportaExcel: TAction
      Caption = 'Excel'
      Hint = 'Esporta in formato XLSX'
      OnExecute = actEsportaExcelExecute
    end
    object actEsportaCsv: TAction
      Caption = 'CSV'
      Hint = 'Esporta in formato CSV'
      OnExecute = actEsportaCsvExecute
    end
    object actEsportaHtml: TAction
      Caption = 'HTML'
      Hint = 'Esporta in formato HTML'
      OnExecute = actEsportaHtmlExecute
    end
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 48
    Top = 200
  end
end
