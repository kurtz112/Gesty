inherited Config: TConfig
  Height = 797
  Width = 383
  object ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    OnShortCut = ApplicationEventsShortCut
    Left = 72
    Top = 393
  end
  object Database: TzFbDatabase
    Params.Strings = (
      'Password=asterkey'
      'Protocol=TCPIP'
      'CharacterSet=UTF8'
      'DriverID=FB')
    LoginPrompt = False
    OnError = DatabaseError
    OnRecover = DatabaseRecover
    AfterConnect = DatabaseAfterConnect
    Left = 72
    Top = 63
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 72
    Top = 448
  end
  object zSystem: TzSystem
    AppName = 'App'
    zDbViews = <>
    zDbPivots = <>
    zFiles = <>
    zForms = <>
    zLookups = <>
    zWizards = <>
    zMaps = <>
    zTatukMaps = <>
    OnHyperLink = zSystemHyperLink
    OnAssignDataSetEvent = zSystemAssignDataSetEvent
    OnAssignFieldOnChangeEvent = zSystemAssignFieldOnChangeEvent
    zFbDatabase = Database
    zFbTransaction = DefaultWriteTrans
    Left = 72
    Top = 338
  end
  object DefaultReadTrans: TzFbTransaction
    Left = 72
    Top = 173
  end
  object DefaultWriteTrans: TzFbTransaction
    Left = 72
    Top = 228
  end
  object dxAlertWindowManager: TdxAlertWindowManager
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    OptionsAnimate.ShowingAnimation = awaSlide
    OptionsButtons.Buttons = <>
    OptionsCaptionButtons.CaptionButtons = [awcbClose]
    OptionsMessage.Caption.Font.Charset = DEFAULT_CHARSET
    OptionsMessage.Caption.Font.Color = clWindowText
    OptionsMessage.Caption.Font.Height = -13
    OptionsMessage.Caption.Font.Name = 'Segoe UI'
    OptionsMessage.Caption.Font.Style = [fsBold]
    OptionsMessage.Text.Font.Charset = DEFAULT_CHARSET
    OptionsMessage.Text.Font.Color = clWindowText
    OptionsMessage.Text.Font.Height = -11
    OptionsMessage.Text.Font.Name = 'Segoe UI'
    OptionsMessage.Text.Font.Style = []
    OptionsNavigationPanel.Font.Charset = DEFAULT_CHARSET
    OptionsNavigationPanel.Font.Color = clWindowText
    OptionsNavigationPanel.Font.Height = -11
    OptionsNavigationPanel.Font.Name = 'Segoe UI'
    OptionsNavigationPanel.Font.Style = []
    OptionsSize.AutoHeight = True
    OptionsSize.AutoWidth = True
    WindowMaxCount = 7
    OnCustomDrawBackground = dxAlertWindowManagerCustomDrawBackground
    OnClose = dxAlertWindowManagerClose
    OnMouseDown = dxAlertWindowManagerMouseDown
    Left = 72
    Top = 503
    PixelsPerInch = 96
  end
  object TimerShutdown: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = TimerShutdownTimer
    Left = 72
    Top = 558
  end
  object TimerAFK: TTimer
    Enabled = False
    Interval = 3600000
    OnTimer = TimerAFKTimer
    Left = 72
    Top = 613
  end
  object TimerKill: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = TimerKillTimer
    Left = 72
    Top = 668
  end
  object FDEventAlerter: TFDEventAlerter
    Connection = Database
    OnAlert = FDEventAlerterAlert
    Left = 72
    Top = 283
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 72
    Top = 118
  end
  object IdAntiFreeze: TIdAntiFreeze
    Left = 72
    Top = 724
  end
  object dxSaveFileDialog: TdxSaveFileDialog
    DefaultExt = '*.zip'
    Filter = 'Aggiornamento|*.zip|Tutti|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 256
    Top = 118
  end
  object FDMoniRemoteClientLink: TFDMoniRemoteClientLink
    EventKinds = [ekError, ekConnConnect, ekConnTransact, ekCmdPrepare, ekCmdExecute, ekComponent, ekSQL]
    Tracing = True
    Left = 253
    Top = 295
  end
  object FDMoniFlatFileClientLink: TFDMoniFlatFileClientLink
    EventKinds = [ekError, ekConnConnect, ekConnTransact, ekCmdPrepare, ekCmdExecute, ekComponent, ekSQL]
    Left = 253
    Top = 352
  end
  object FDMoniCustomClientLink: TFDMoniCustomClientLink
    EventKinds = [ekError, ekConnConnect, ekConnTransact, ekCmdPrepare, ekCmdExecute, ekComponent, ekSQL]
    OnOutput = FDMoniCustomClientLinkOutput
    Left = 253
    Top = 409
  end
  object FDGUIxAsyncExecuteDialog: TFDGUIxAsyncExecuteDialog
    Provider = 'Forms'
    Caption = 'Gesty'
    Prompt = 'Elaborazione dati in corso, attendere prego...'
    CancelCaption = '&Annulla'
    OnShow = FDGUIxAsyncExecuteDialogShow
    Left = 253
    Top = 238
  end
end
