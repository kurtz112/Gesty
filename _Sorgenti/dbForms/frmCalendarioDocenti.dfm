inherited FormCalendarioDocenti: TFormCalendarioDocenti
  Caption = 'FormCalendarioDocenti'
  ClientWidth = 771
  OnCreate = FormCreate
  ExplicitWidth = 783
  ExplicitHeight = 500
  TextHeight = 15
  inline FrameCalendarioDocenti: TFrameCalendarioDocenti [1]
    Left = 0
    Top = 32
    Width = 771
    Height = 430
    Align = alClient
    TabOrder = 5
    ExplicitTop = 32
    ExplicitWidth = 767
    ExplicitHeight = 429
    inherited dxLayoutControl: TdxLayoutControl
      Width = 771
      Height = 430
      ExplicitWidth = 767
      ExplicitHeight = 429
      inherited tree: TcxTreeList
        Width = 715
        Height = 313
        ExplicitWidth = 715
        ExplicitHeight = 313
      end
      inherited Scheduler: TcxScheduler
        Width = 715
        Height = 254
        OptionsView.WorkStart = 0.291666666666666700
        OptionsView.WorkFinish = 0.999305555555555600
        ExplicitWidth = 715
        ExplicitHeight = 254
        Splitters = {
          500200007F0000006E03000084000000EB02000002000000F0020000C0010000}
        StoredClientBounds = {0000000000000000CB020000FE000000}
      end
      inherited dxBarDockControl: TdxBarDockControl
        Width = 747
        ExplicitWidth = 747
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
    Left = 60
    Top = 176
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
end
