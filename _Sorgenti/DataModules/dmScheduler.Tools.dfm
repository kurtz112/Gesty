inherited SchedulerTools: TSchedulerTools
  Height = 507
  Width = 699
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'ElencoAule'
        DataSet = ElencoAule
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'Orario'
        DataSet = Orario
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'RilevamentoOre'
        DataSet = RilevamentoOre
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'Riunioni'
        DataSet = Riunioni
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'Agenda'
        DataSet = Agenda
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'PrenotazioneAule'
        DataSet = PrenotazioneAule
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'Scadenze'
        DataSet = Scadenze
        IncludeInOpen = False
        OnClose = ocPost
      end
      item
        DisplayName = 'FuoriSede'
        DataSet = FuoriSede
        IncludeInOpen = False
        OnClose = ocPost
      end>
  end
  object Orario: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ORARIO'
    Left = 602
    Top = 102
  end
  object cardOrario: TzDbCardDlg
    Caption = 'Orario'
    DataSet = Orario
    Left = 472
    Top = 103
  end
  object RilevamentoOre: TzFbDataSet
    BeforeOpen = RilevamentoOreBeforeOpen
    BeforeClose = RilevamentoOreBeforeClose
    BeforePost = RilevamentoOreBeforePost
    OnCalcFields = RilevamentoOreCalcFields
    OnNewRecord = RilevamentoOreNewRecord
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'ORE_RILEVATE'
    OnAfterCreateFields = RilevamentoOreAfterCreateFields
    Left = 602
    Top = 230
  end
  object cardRilevamento: TzDbCardDlg
    Caption = 'Rilevamento Ore'
    DataSet = RilevamentoOre
    Left = 472
    Top = 231
  end
  object Riunioni: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RIUNIONI'
    Left = 602
    Top = 294
  end
  object cardRiunioni: TzDbCardDlg
    Caption = 'Riunione'
    DataSet = Riunioni
    Left = 472
    Top = 295
  end
  object Agenda: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AGENDA'
    Left = 602
    Top = 38
  end
  object cardAgenda: TzDbCardDlg
    Caption = 'Agenda'
    DataSet = Agenda
    Left = 472
    Top = 39
  end
  object PrenotazioneAule: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AULE_PRENOTAZIONI'
    Left = 602
    Top = 166
  end
  object cardPrenotazioneAule: TzDbCardDlg
    Caption = 'Prenotazione Aula'
    DataSet = PrenotazioneAule
    OnInitDialog = cardPrenotazioneAuleInitDialog
    Left = 472
    Top = 167
  end
  object ElencoAule: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'AULE'
    Left = 194
    Top = 86
  end
  object dlgElencoAule: TzDbViewDlg
    Caption = 'Elenco Aule'
    DataSet = ElencoAule
    ToolActions = <>
    Options = [ddAutoAppend, ddAutoPost, ddShowSelectBtns, ddRaiseOnError]
    Left = 96
    Top = 86
  end
  object Scadenze: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'SCADENZE'
    Left = 602
    Top = 358
  end
  object cardScadenze: TzDbCardDlg
    Caption = 'Scadenza'
    DataSet = Scadenze
    Left = 472
    Top = 359
  end
  object cxSchedulerHolidays: TcxSchedulerHolidays
    Locations = <
      item
        Name = 'Italy'
        Holidays = <
          item
            Date = 39022.000000000000000000
            Name = 'All Saints'#39' Day'
          end
          item
            Date = 39387.000000000000000000
            Name = 'All Saints'#39' Day'
          end
          item
            Date = 39753.000000000000000000
            Name = 'All Saints'#39' Day'
          end
          item
            Date = 40118.000000000000000000
            Name = 'All Saints'#39' Day'
          end
          item
            Date = 40483.000000000000000000
            Name = 'All Saints'#39' Day'
          end
          item
            Date = 40848.000000000000000000
            Name = 'All Saints'#39' Day'
          end
          item
            Date = 41214.000000000000000000
            Name = 'All Saints'#39' Day'
          end
          item
            Date = 38944.000000000000000000
            Name = 'Assumption Day'
          end
          item
            Date = 39309.000000000000000000
            Name = 'Assumption Day'
          end
          item
            Date = 39675.000000000000000000
            Name = 'Assumption Day'
          end
          item
            Date = 40040.000000000000000000
            Name = 'Assumption Day'
          end
          item
            Date = 40405.000000000000000000
            Name = 'Assumption Day'
          end
          item
            Date = 40770.000000000000000000
            Name = 'Assumption Day'
          end
          item
            Date = 41136.000000000000000000
            Name = 'Assumption Day'
          end
          item
            Date = 39077.000000000000000000
            Name = 'Boxing Day - St. Stephen'#39's Day'
          end
          item
            Date = 39442.000000000000000000
            Name = 'Boxing Day - St. Stephen'#39's Day'
          end
          item
            Date = 39808.000000000000000000
            Name = 'Boxing Day - St. Stephen'#39's Day'
          end
          item
            Date = 40173.000000000000000000
            Name = 'Boxing Day - St. Stephen'#39's Day'
          end
          item
            Date = 40538.000000000000000000
            Name = 'Boxing Day - St. Stephen'#39's Day'
          end
          item
            Date = 40903.000000000000000000
            Name = 'Boxing Day - St. Stephen'#39's Day'
          end
          item
            Date = 41269.000000000000000000
            Name = 'Boxing Day - St. Stephen'#39's Day'
          end
          item
            Date = 39076.000000000000000000
            Name = 'Christmas Day'
          end
          item
            Date = 39441.000000000000000000
            Name = 'Christmas Day'
          end
          item
            Date = 39807.000000000000000000
            Name = 'Christmas Day'
          end
          item
            Date = 40172.000000000000000000
            Name = 'Christmas Day'
          end
          item
            Date = 40537.000000000000000000
            Name = 'Christmas Day'
          end
          item
            Date = 40902.000000000000000000
            Name = 'Christmas Day'
          end
          item
            Date = 41268.000000000000000000
            Name = 'Christmas Day'
          end
          item
            Date = 38823.000000000000000000
            Name = 'Easter Day'
          end
          item
            Date = 39180.000000000000000000
            Name = 'Easter Day'
          end
          item
            Date = 39530.000000000000000000
            Name = 'Easter Day'
          end
          item
            Date = 39915.000000000000000000
            Name = 'Easter Day'
          end
          item
            Date = 40272.000000000000000000
            Name = 'Easter Day'
          end
          item
            Date = 40657.000000000000000000
            Name = 'Easter Day'
          end
          item
            Date = 41007.000000000000000000
            Name = 'Easter Day'
          end
          item
            Date = 38824.000000000000000000
            Name = 'Easter Monday'
          end
          item
            Date = 39181.000000000000000000
            Name = 'Easter Monday'
          end
          item
            Date = 39531.000000000000000000
            Name = 'Easter Monday'
          end
          item
            Date = 39916.000000000000000000
            Name = 'Easter Monday'
          end
          item
            Date = 40273.000000000000000000
            Name = 'Easter Monday'
          end
          item
            Date = 40658.000000000000000000
            Name = 'Easter Monday'
          end
          item
            Date = 41008.000000000000000000
            Name = 'Easter Monday'
          end
          item
            Date = 38723.000000000000000000
            Name = 'Epiphany'
          end
          item
            Date = 39088.000000000000000000
            Name = 'Epiphany'
          end
          item
            Date = 39453.000000000000000000
            Name = 'Epiphany'
          end
          item
            Date = 39819.000000000000000000
            Name = 'Epiphany'
          end
          item
            Date = 40184.000000000000000000
            Name = 'Epiphany'
          end
          item
            Date = 40549.000000000000000000
            Name = 'Epiphany'
          end
          item
            Date = 40914.000000000000000000
            Name = 'Epiphany'
          end
          item
            Date = 39059.000000000000000000
            Name = 'Immaculate Conception'
          end
          item
            Date = 39424.000000000000000000
            Name = 'Immaculate Conception'
          end
          item
            Date = 39790.000000000000000000
            Name = 'Immaculate Conception'
          end
          item
            Date = 40155.000000000000000000
            Name = 'Immaculate Conception'
          end
          item
            Date = 40520.000000000000000000
            Name = 'Immaculate Conception'
          end
          item
            Date = 40885.000000000000000000
            Name = 'Immaculate Conception'
          end
          item
            Date = 41251.000000000000000000
            Name = 'Immaculate Conception'
          end
          item
            Date = 38832.000000000000000000
            Name = 'Liberation Day'
          end
          item
            Date = 39197.000000000000000000
            Name = 'Liberation Day'
          end
          item
            Date = 39563.000000000000000000
            Name = 'Liberation Day'
          end
          item
            Date = 39928.000000000000000000
            Name = 'Liberation Day'
          end
          item
            Date = 40293.000000000000000000
            Name = 'Liberation Day'
          end
          item
            Date = 40658.000000000000000000
            Name = 'Liberation Day'
          end
          item
            Date = 41024.000000000000000000
            Name = 'Liberation Day'
          end
          item
            Date = 38718.000000000000000000
            Name = 'New Year'#39's Day'
          end
          item
            Date = 39083.000000000000000000
            Name = 'New Year'#39's Day'
          end
          item
            Date = 39448.000000000000000000
            Name = 'New Year'#39's Day'
          end
          item
            Date = 39814.000000000000000000
            Name = 'New Year'#39's Day'
          end
          item
            Date = 40179.000000000000000000
            Name = 'New Year'#39's Day'
          end
          item
            Date = 40544.000000000000000000
            Name = 'New Year'#39's Day'
          end
          item
            Date = 40909.000000000000000000
            Name = 'New Year'#39's Day'
          end
          item
            Date = 38838.000000000000000000
            Name = 'Labor Day'
          end
          item
            Date = 39203.000000000000000000
            Name = 'Labor Day'
          end
          item
            Date = 39569.000000000000000000
            Name = 'Labor Day'
          end
          item
            Date = 39934.000000000000000000
            Name = 'Labor Day'
          end
          item
            Date = 40299.000000000000000000
            Name = 'Labor Day'
          end
          item
            Date = 40664.000000000000000000
            Name = 'Labor Day'
          end
          item
            Date = 41030.000000000000000000
            Name = 'Labor Day'
          end
          item
            Date = 38870.000000000000000000
            Name = 'Republic Day Italy'
          end
          item
            Date = 39235.000000000000000000
            Name = 'Republic Day Italy'
          end
          item
            Date = 39601.000000000000000000
            Name = 'Republic Day Italy'
          end
          item
            Date = 39966.000000000000000000
            Name = 'Republic Day Italy'
          end
          item
            Date = 40331.000000000000000000
            Name = 'Republic Day Italy'
          end
          item
            Date = 40696.000000000000000000
            Name = 'Republic Day Italy'
          end
          item
            Date = 41062.000000000000000000
            Name = 'Republic Day Italy'
          end>
      end>
    Left = 120
    Top = 8
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 88
    Top = 184
    object InviaMailAutorizzazioneAula: TAction
      Caption = 'Richiedi Autorizzazione'
      ImageIndex = 1023
      OnExecute = InviaMailAutorizzazioneAulaExecute
    end
  end
  object dxSaveFileDialog: TdxSaveFileDialog
    DefaultExt = '*.xls'
    Filter = 'Excel|*.xls|Google Calendar|*.csv|Outlook|*.csv|Tutti|*.*'
    FilterIndex = 0
    Left = 88
    Top = 304
  end
  object FuoriSede: TzFbDataSet
    FetchOptions.AssignedValues = [evDetailDelay]
    FetchOptions.DetailDelay = 300
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    AutoCommit = False
    TableName = 'RISORSE_ATTIVITA_FUORI_SEDE'
    Left = 602
    Top = 430
  end
  object cardFuoriSede: TzDbCardDlg
    Caption = 'Attivit'#224' Fuori Sede'
    DataSet = FuoriSede
    Left = 472
    Top = 431
  end
end
