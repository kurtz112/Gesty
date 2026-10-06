inherited FormCalendarioAule: TFormCalendarioAule
  Caption = 'FormCalendarioAule'
  ClientHeight = 464
  ClientWidth = 771
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 787
  ExplicitHeight = 503
  TextHeight = 15
  inline FrameCalendarioAule: TFrameCalendarioAule [1]
    Left = 0
    Top = 30
    Width = 771
    Height = 434
    Align = alClient
    TabOrder = 5
    ExplicitTop = 30
    ExplicitWidth = 771
    ExplicitHeight = 434
    inherited dxLayoutControl: TdxLayoutControl
      Width = 771
      Height = 434
      ExplicitWidth = 771
      ExplicitHeight = 434
      inherited tree: TcxTreeList
        Top = 87
        Width = 715
        Height = 319
        ExplicitTop = 87
        ExplicitWidth = 715
        ExplicitHeight = 319
      end
      inherited Scheduler: TcxScheduler
        Width = 715
        Height = 249
        OptionsView.WorkStart = 0.291666666666666700
        OptionsView.WorkFinish = 0.999305555555555600
        ExplicitWidth = 715
        ExplicitHeight = 249
        Splitters = {
          500200007F0000006E03000084000000EB02000002000000F0020000C0010000}
        StoredClientBounds = {0000000000000000CB020000F9000000}
      end
      inherited dxBarDockControl: TdxBarDockControl
        Width = 747
        Height = 30
        ExplicitWidth = 747
        ExplicitHeight = 30
      end
      inherited dxLayoutItemBar: TdxLayoutItem
        ControlOptions.OriginalHeight = 30
      end
    end
    inherited dxBarManager: TdxBarManager
      PixelsPerInch = 96
    end
    inherited popActions: TdxBarPopupMenu
      PixelsPerInch = 96
    end
    inherited dxComponentPrinter: TdxComponentPrinter
      PreviewOptions.PreviewBoundsRect = {00000000000000000004000020030000}
      PixelsPerInch = 96
      inherited dxComponentPrinterLinkTree: TcxTreeListReportLink
        ReportDocument.CreationDate = 45552.677602777770000000
        PixelsPerInch = 96
        BuiltInReportLink = True
      end
      inherited dxComponentPrinterLinkScheduler: TcxSchedulerReportLink
        PixelsPerInch = 96
        BuiltInReportLink = True
      end
    end
    inherited ColorRepository: TcxStyleRepository
      PixelsPerInch = 96
    end
  end
  inherited dxBarManager: TdxBarManager [2]
    PixelsPerInch = 96
    inherited barSistema: TdxBar
      DockedLeft = 175
    end
  end
  inherited BaseActions: TActionList [3]
    Top = 128
  end
  inherited popActions: TdxBarPopupMenu
    Top = 200
    PixelsPerInch = 96
  end
end
