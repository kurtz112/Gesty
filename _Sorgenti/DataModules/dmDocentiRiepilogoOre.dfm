inherited DocentiRiepilogoOre: TDocentiRiepilogoOre
  Height = 138
  Width = 247
  PixelsPerInch = 96
  inherited dbMaster: TdbMaster
    DataSets = <
      item
        DisplayName = 'RiepilogoOre'
        DataSet = RiepilogoOre
        OnClose = ocPost
      end>
  end
  object RiepilogoOre: TzFbDataSet
    Transaction = Config.DefaultReadTrans
    AutoCommit = False
    TableName = 'PERSONALE_RIEPILOGO_ORE'
    Left = 72
    Top = 72
  end
  object RiepilogoOreSrc: TDataSource
    DataSet = RiepilogoOre
    Left = 160
    Top = 72
  end
end
