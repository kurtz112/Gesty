inherited ValutazioniRisorse: TValutazioniRisorse
  Height = 128
  Width = 87
  PixelsPerInch = 96
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'Valutazioni'
        DataSet = Valutazioni
        IncludeInOpen = False
        OnClose = ocPost
      end>
  end
  object Valutazioni: TzFbDataSet
    ActivationMode = amManual
    AutoCommit = False
    TableName = 'RISORSE_VALUTAZIONI_ELENCO'
    Left = 24
    Top = 64
  end
end
