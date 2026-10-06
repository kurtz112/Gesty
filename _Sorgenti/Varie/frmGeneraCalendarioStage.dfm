object FormGeneraCalendarioStage: TFormGeneraCalendarioStage
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsSizeToolWin
  Caption = 'Generazione Date Tirocinio'
  ClientHeight = 617
  ClientWidth = 1146
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 13
  object dxLayoutControl: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 1146
    Height = 617
    Align = alTop
    TabOrder = 0
    AutoSize = True
    CustomizeFormTabbedView = True
    object edOra_Inizio_2_Lun: TcxTimeEdit
      Left = 396
      Top = 129
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 12
      Width = 75
    end
    object edOra_Fine_2_Lun: TcxTimeEdit
      Left = 477
      Top = 129
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 13
      Width = 75
    end
    object edOra_Inizio_1_Lun: TcxTimeEdit
      Left = 37
      Top = 129
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 9
      Width = 75
    end
    object edOra_Inizio_1_Mar: TcxTimeEdit
      Left = 37
      Top = 190
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 18
      Width = 75
    end
    object edOra_Inizio_1_Mer: TcxTimeEdit
      Left = 37
      Top = 251
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 27
      Width = 75
    end
    object edOra_Inizio_1_Gio: TcxTimeEdit
      Left = 37
      Top = 312
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 36
      Width = 75
    end
    object edOra_Inizio_1_Ven: TcxTimeEdit
      Left = 37
      Top = 373
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 45
      Width = 75
    end
    object edOra_Inizio_1_Sab: TcxTimeEdit
      Left = 37
      Top = 434
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 54
      Width = 75
    end
    object edOra_Inizio_1_Dom: TcxTimeEdit
      Left = 37
      Top = 495
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 63
      Width = 75
    end
    object edOra_Fine_1_Lun: TcxTimeEdit
      Left = 118
      Top = 129
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 10
      Width = 75
    end
    object edOra_Fine_1_Mar: TcxTimeEdit
      Left = 118
      Top = 190
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 19
      Width = 75
    end
    object edOra_Fine_1_Mer: TcxTimeEdit
      Left = 118
      Top = 251
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 28
      Width = 75
    end
    object edOra_Fine_1_Gio: TcxTimeEdit
      Left = 118
      Top = 312
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 37
      Width = 75
    end
    object edOra_Fine_1_Ven: TcxTimeEdit
      Left = 118
      Top = 373
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 46
      Width = 75
    end
    object edOra_Fine_1_Sab: TcxTimeEdit
      Left = 118
      Top = 434
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 55
      Width = 75
    end
    object edOra_Fine_1_Dom: TcxTimeEdit
      Left = 118
      Top = 495
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 64
      Width = 75
    end
    object edOra_Inizio_2_Mar: TcxTimeEdit
      Left = 396
      Top = 190
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 21
      Width = 75
    end
    object edOra_Fine_2_Mar: TcxTimeEdit
      Left = 477
      Top = 190
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 22
      Width = 75
    end
    object edOra_Inizio_2_Mer: TcxTimeEdit
      Left = 396
      Top = 251
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 30
      Width = 75
    end
    object edOra_Fine_2_Mer: TcxTimeEdit
      Left = 477
      Top = 251
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 31
      Width = 75
    end
    object edOra_Inizio_2_Gio: TcxTimeEdit
      Left = 396
      Top = 312
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 39
      Width = 75
    end
    object edOra_Fine_2_Gio: TcxTimeEdit
      Left = 477
      Top = 312
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 40
      Width = 75
    end
    object edOra_Inizio_2_Ven: TcxTimeEdit
      Left = 396
      Top = 373
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 48
      Width = 75
    end
    object edOra_Fine_2_Ven: TcxTimeEdit
      Left = 477
      Top = 373
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 49
      Width = 75
    end
    object edOra_Inizio_2_Sab: TcxTimeEdit
      Left = 396
      Top = 434
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 57
      Width = 75
    end
    object edOra_Fine_2_Sab: TcxTimeEdit
      Left = 477
      Top = 434
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 58
      Width = 75
    end
    object edOra_Inizio_2_Dom: TcxTimeEdit
      Left = 396
      Top = 495
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 66
      Width = 75
    end
    object edOra_Fine_2_Dom: TcxTimeEdit
      Left = 477
      Top = 495
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 67
      Width = 75
    end
    object edDalGiorno: TcxDateEdit
      Left = 91
      Top = 20
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.AssignedValues.DisplayFormat = True
      Properties.AssignedValues.EditFormat = True
      Properties.DateButtons = [btnClear, btnToday]
      Properties.ReadOnly = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnEditValueChanged = edDalGiornoPropertiesEditValueChanged
      TabOrder = 0
      Width = 85
    end
    object edAlGiorno: TcxDateEdit
      Left = 240
      Top = 20
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.AssignedValues.DisplayFormat = True
      Properties.AssignedValues.EditFormat = True
      Properties.DateButtons = [btnClear, btnToday]
      Properties.ReadOnly = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnEditValueChanged = edAlGiornoPropertiesEditValueChanged
      TabOrder = 1
      Width = 85
    end
    object checkLunedi: TcxCheckBox
      Left = 27
      Top = 49
      Caption = 'Luned'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Transparent = True
    end
    object checkMercoledi: TcxCheckBox
      Left = 189
      Top = 49
      Caption = 'Mercoled'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Transparent = True
    end
    object checkGiovedi: TcxCheckBox
      Left = 270
      Top = 49
      Caption = 'Gioved'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 5
      Transparent = True
    end
    object checkVenerdi: TcxCheckBox
      Left = 351
      Top = 49
      Caption = 'Venerd'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 6
      Transparent = True
    end
    object checkSabato: TcxCheckBox
      Left = 432
      Top = 49
      Caption = 'Sabato'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 7
      Transparent = True
    end
    object checkDomenica: TcxCheckBox
      Left = 513
      Top = 49
      Caption = 'Domenica'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 8
      Transparent = True
    end
    object checkMartedi: TcxCheckBox
      Left = 108
      Top = 49
      Caption = 'Marted'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Transparent = True
    end
    object tnOk: TcxButton
      Left = 963
      Top = 559
      Width = 75
      Height = 25
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 72
    end
    object btnCancel: TcxButton
      Left = 1044
      Top = 559
      Width = 75
      Height = 25
      Caption = 'Annulla'
      ModalResult = 2
      TabOrder = 73
    end
    object edOra_Inizio_3_Lun: TcxTimeEdit
      Left = 755
      Top = 129
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 15
      Width = 75
    end
    object edOra_Fine_3_Lun: TcxTimeEdit
      Left = 836
      Top = 129
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 16
      Width = 75
    end
    object edOra_Inizio_3_Mar: TcxTimeEdit
      Left = 755
      Top = 190
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 24
      Width = 75
    end
    object edOra_Fine_3_Mar: TcxTimeEdit
      Left = 836
      Top = 190
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 25
      Width = 75
    end
    object edOra_Inizio_3_Mer: TcxTimeEdit
      Left = 755
      Top = 251
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 33
      Width = 75
    end
    object edOra_Fine_3_Mer: TcxTimeEdit
      Left = 836
      Top = 251
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 34
      Width = 75
    end
    object edOra_Inizio_3_Gio: TcxTimeEdit
      Left = 755
      Top = 312
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 42
      Width = 75
    end
    object edOra_Fine_3_Gio: TcxTimeEdit
      Left = 836
      Top = 312
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 43
      Width = 75
    end
    object edOra_Inizio_3_Ven: TcxTimeEdit
      Left = 755
      Top = 373
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 51
      Width = 75
    end
    object edOra_Fine_3_Ven: TcxTimeEdit
      Left = 836
      Top = 373
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 52
      Width = 75
    end
    object edOra_Inizio_3_Sab: TcxTimeEdit
      Left = 755
      Top = 434
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 60
      Width = 75
    end
    object edOra_Fine_3_Sab: TcxTimeEdit
      Left = 836
      Top = 434
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 61
      Width = 75
    end
    object edOra_Inizio_3_Dom: TcxTimeEdit
      Left = 755
      Top = 495
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 69
      Width = 75
    end
    object edOra_Fine_3_Dom: TcxTimeEdit
      Left = 836
      Top = 495
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 70
      Width = 75
    end
    object edContenuti1_Lun: TcxExtLookupComboBox
      Left = 199
      Top = 129
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 11
      Width = 175
    end
    object edContenuti2_Lun: TcxExtLookupComboBox
      Left = 558
      Top = 129
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 14
      Width = 175
    end
    object edContenuti3_Lun: TcxExtLookupComboBox
      Left = 917
      Top = 129
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 17
      Width = 175
    end
    object edContenuti1_Mar: TcxExtLookupComboBox
      Left = 199
      Top = 190
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 20
      Width = 175
    end
    object edContenuti2_Mar: TcxExtLookupComboBox
      Left = 558
      Top = 190
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 23
      Width = 175
    end
    object edContenuti3_Mar: TcxExtLookupComboBox
      Left = 917
      Top = 190
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 26
      Width = 175
    end
    object edContenuti1_Mer: TcxExtLookupComboBox
      Left = 199
      Top = 251
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 29
      Width = 175
    end
    object edContenuti2_Mer: TcxExtLookupComboBox
      Left = 558
      Top = 251
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 32
      Width = 175
    end
    object edContenuti3_Mer: TcxExtLookupComboBox
      Left = 917
      Top = 251
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 35
      Width = 175
    end
    object edContenuti1_Gio: TcxExtLookupComboBox
      Left = 199
      Top = 312
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 38
      Width = 175
    end
    object edContenuti2_Gio: TcxExtLookupComboBox
      Left = 558
      Top = 312
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 41
      Width = 175
    end
    object edContenuti3_Gio: TcxExtLookupComboBox
      Left = 917
      Top = 312
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 44
      Width = 175
    end
    object edContenuti1_Ven: TcxExtLookupComboBox
      Left = 199
      Top = 373
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 47
      Width = 175
    end
    object edContenuti2_Ven: TcxExtLookupComboBox
      Left = 558
      Top = 373
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 50
      Width = 175
    end
    object edContenuti3_Ven: TcxExtLookupComboBox
      Left = 917
      Top = 373
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 53
      Width = 175
    end
    object edContenuti1_Sab: TcxExtLookupComboBox
      Left = 199
      Top = 434
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 56
      Width = 175
    end
    object edContenuti2_Sab: TcxExtLookupComboBox
      Left = 558
      Top = 434
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 59
      Width = 175
    end
    object edContenuti3_Sab: TcxExtLookupComboBox
      Left = 917
      Top = 434
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 62
      Width = 175
    end
    object edContenuti1_Dom: TcxExtLookupComboBox
      Left = 199
      Top = 495
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 65
      Width = 175
    end
    object edContenuti2_Dom: TcxExtLookupComboBox
      Left = 558
      Top = 495
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 68
      Width = 175
    end
    object edContenuti3_Dom: TcxExtLookupComboBox
      Left = 917
      Top = 495
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 71
      Width = 175
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avTop
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemOra1InizioLun: TdxLayoutItem
      Parent = dxLayoutGroupOre1Lun
      AlignHorz = ahLeft
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Layout = clTop
      Control = edOra_Inizio_1_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra1InizioMar: TdxLayoutItem
      Parent = dxLayoutGroupOre1Mar
      AlignHorz = ahLeft
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra1InizioMer: TdxLayoutItem
      Parent = dxLayoutGroupOre1Mer
      AlignHorz = ahLeft
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra1InizioGio: TdxLayoutItem
      Parent = dxLayoutGroupOre1Gio
      AlignHorz = ahLeft
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra1InizioVen: TdxLayoutItem
      Parent = dxLayoutGroupOre1Ven
      AlignHorz = ahLeft
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra1InizioSab: TdxLayoutItem
      Parent = dxLayoutGroupOre1Sab
      AlignHorz = ahLeft
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra1InizioDom: TdxLayoutItem
      Parent = dxLayoutGroupOre1Dom
      AlignHorz = ahLeft
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra1FineLun: TdxLayoutItem
      Parent = dxLayoutGroupOre1Lun
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Layout = clTop
      Control = edOra_Fine_1_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1FineMar: TdxLayoutItem
      Parent = dxLayoutGroupOre1Mar
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1FineMer: TdxLayoutItem
      Parent = dxLayoutGroupOre1Mer
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1FineGio: TdxLayoutItem
      Parent = dxLayoutGroupOre1Gio
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1FineVen: TdxLayoutItem
      Parent = dxLayoutGroupOre1Ven
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1FineSab: TdxLayoutItem
      Parent = dxLayoutGroupOre1Sab
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1FineDom: TdxLayoutItem
      Parent = dxLayoutGroupOre1Dom
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra2InizioLun: TdxLayoutItem
      Parent = dxLayoutGroupOre2Lun
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Layout = clTop
      Control = edOra_Inizio_2_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra2InizioMar: TdxLayoutItem
      Parent = dxLayoutGroupOre2Mar
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra2InizioMer: TdxLayoutItem
      Parent = dxLayoutGroup2
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra2InizioGio: TdxLayoutItem
      Parent = dxLayoutGroupOre2Gio
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra2InizioVen: TdxLayoutItem
      Parent = dxLayoutGroupOre2Ven
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra2InizioSab1: TdxLayoutItem
      Parent = dxLayoutGroupOre2Sab
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra2InizioDom: TdxLayoutItem
      Parent = dxLayoutGroupOre2Dom
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra2FineLun: TdxLayoutItem
      Parent = dxLayoutGroupOre2Lun
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Layout = clTop
      Control = edOra_Fine_2_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra2FineMar: TdxLayoutItem
      Parent = dxLayoutGroupOre2Mar
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra2FineMer: TdxLayoutItem
      Parent = dxLayoutGroup2
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra2FineGio: TdxLayoutItem
      Parent = dxLayoutGroupOre2Gio
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra2FineVen: TdxLayoutItem
      Parent = dxLayoutGroupOre2Ven
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra2FineSab: TdxLayoutItem
      Parent = dxLayoutGroupOre2Sab
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra2FineDom: TdxLayoutItem
      Parent = dxLayoutGroupOre2Dom
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemDataInizio: TdxLayoutItem
      Parent = dxLayoutGroupDate
      CaptionOptions.Text = 'Data Inizio:'
      Control = edDalGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemDataFine: TdxLayoutItem
      Parent = dxLayoutGroupDate
      CaptionOptions.Text = 'Data Fine:'
      Control = edAlGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupLunedi: TdxLayoutGroup
      Parent = dxLayoutGroupOrari
      CaptionOptions.Text = 'Luned'#236
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      Index = 0
    end
    object dxLayoutGroupMartedi: TdxLayoutGroup
      Parent = dxLayoutGroupOrari
      CaptionOptions.Text = 'Marted'#236
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object dxLayoutGroupMercoledi: TdxLayoutGroup
      Parent = dxLayoutGroupOrari
      CaptionOptions.Text = 'Mercoled'#236
      LayoutDirection = ldHorizontal
      Index = 2
    end
    object dxLayoutGroupGiovedi: TdxLayoutGroup
      Parent = dxLayoutGroupOrari
      CaptionOptions.Text = 'Gioved'#236
      ItemIndex = 4
      LayoutDirection = ldHorizontal
      Index = 3
    end
    object dxLayoutGroupSabato: TdxLayoutGroup
      Parent = dxLayoutGroupOrari
      CaptionOptions.Text = 'Sabato'
      ItemIndex = 4
      LayoutDirection = ldHorizontal
      Index = 5
    end
    object dxLayoutGroupVenerdi: TdxLayoutGroup
      Parent = dxLayoutGroupOrari
      CaptionOptions.Text = 'Venerd'#236
      LayoutDirection = ldHorizontal
      Index = 4
    end
    object dxLayoutGroupDomenica: TdxLayoutGroup
      Parent = dxLayoutGroupOrari
      CaptionOptions.Text = 'Domenica'
      ItemIndex = 4
      LayoutDirection = ldHorizontal
      Index = 6
    end
    object dxLayoutEmptySpaceItemLun1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupLunedi
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 1
    end
    object dxLayoutEmptySpaceItemMar1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMartedi
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 1
    end
    object dxLayoutGroup2Mer: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMercoledi
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 1
    end
    object dxLayoutEmptySpaceItemGio1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupGiovedi
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 1
    end
    object dxLayoutEmptySpaceItemVen1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupVenerdi
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 1
    end
    object dxLayoutEmptySpaceItemSab: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupSabato
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 1
    end
    object dxLayoutEmptySpaceItemDom1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupDomenica
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 1
    end
    object dxLayoutEmptySpaceItemTotLun: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupLunedi
      SizeOptions.Height = 10
      SizeOptions.Width = 5
      CaptionOptions.Text = 'Empty Space Item'
      Index = 5
    end
    object dxLayoutEmptySpaceItemTotMar: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMartedi
      SizeOptions.Height = 10
      SizeOptions.Width = 5
      CaptionOptions.Text = 'Empty Space Item'
      Index = 5
    end
    object dxLayoutEmptySpaceItemTotMer: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMercoledi
      SizeOptions.Height = 10
      SizeOptions.Width = 5
      CaptionOptions.Text = 'Empty Space Item'
      Index = 5
    end
    object dxLayoutEmptySpaceItemTotGio: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupGiovedi
      SizeOptions.Height = 10
      SizeOptions.Width = 5
      CaptionOptions.Text = 'Empty Space Item'
      Index = 5
    end
    object dxLayoutEmptySpaceItemTotVen: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupVenerdi
      SizeOptions.Height = 10
      SizeOptions.Width = 5
      CaptionOptions.Text = 'Empty Space Item'
      Index = 5
    end
    object dxLayoutEmptySpaceItemTotSab: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupSabato
      SizeOptions.Height = 10
      SizeOptions.Width = 5
      CaptionOptions.Text = 'Empty Space Item'
      Index = 5
    end
    object dxLayoutEmptySpaceItemTotDom: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupDomenica
      SizeOptions.Height = 10
      SizeOptions.Width = 5
      CaptionOptions.Text = 'Empty Space Item'
      Index = 5
    end
    object dxLayoutGroupMain: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      ShowBorder = False
      Index = 0
    end
    object dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMain
      SizeOptions.Height = 3
      SizeOptions.Width = 3
      CaptionOptions.Text = 'Empty Space Item'
      Index = 0
    end
    object dxLayoutItemLunedi: TdxLayoutItem
      Parent = dxLayoutGroupSettimana
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkLunedi
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 53
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemMartedì: TdxLayoutItem
      Parent = dxLayoutGroupSettimana
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkMartedi
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 58
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemMercoledi: TdxLayoutItem
      Parent = dxLayoutGroupSettimana
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkMercoledi
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 69
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemGiovedi: TdxLayoutItem
      Parent = dxLayoutGroupSettimana
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkGiovedi
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 57
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutItemVenerdi: TdxLayoutItem
      Parent = dxLayoutGroupSettimana
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkVenerdi
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 57
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItemSabato: TdxLayoutItem
      Parent = dxLayoutGroupSettimana
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkSabato
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 54
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItemDomenica: TdxLayoutItem
      Parent = dxLayoutGroupSettimana
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkDomenica
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 69
      ControlOptions.ShowBorder = False
      Index = 6
    end
    object dxLayoutGroupDate: TdxLayoutGroup
      Parent = dxLayoutGroupPeriodo
      CaptionOptions.Text = 'Periodo'
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupGiorni: TdxLayoutGroup
      Parent = dxLayoutGroupPeriodo
      CaptionOptions.Text = 'Giorni'
      ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupOrari: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      CaptionOptions.Text = 'Orari'
      ButtonOptions.Alignment = gbaLeft
      ButtonOptions.CheckBox.Visible = True
      ItemIndex = 3
      OnCheckBoxStateChanged = dxLayoutGroupOrariCheckBoxStateChanged
      Index = 2
    end
    object dxLayoutGroupSettimana: TdxLayoutGroup
      Parent = dxLayoutGroupGiorni
      CaptionOptions.Text = 'New Group'
      ItemIndex = 6
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOk: TdxLayoutItem
      Parent = dxLayoutGroupButtons
      AlignHorz = ahRight
      SizeOptions.Width = 75
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = tnOk
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemCancel: TdxLayoutItem
      Parent = dxLayoutGroupButtons
      AlignHorz = ahRight
      SizeOptions.Width = 75
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = btnCancel
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupButtons: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 4
    end
    object dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMain
      SizeOptions.Height = 3
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutItemOra3FineLun: TdxLayoutItem
      Parent = dxLayoutGroupOre3Lun
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Layout = clTop
      Control = edOra_Fine_3_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra3InizioLun: TdxLayoutItem
      Parent = dxLayoutGroupOre3Lun
      SizeOptions.Width = 75
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Layout = clTop
      Control = edOra_Inizio_3_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra3InizioMar: TdxLayoutItem
      Parent = dxLayoutGroupOre3Mar
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_3_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutEmptySpaceItemLun2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupLunedi
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutItemOra3FineMar: TdxLayoutItem
      Parent = dxLayoutGroupOre3Mar
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Fine_3_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItemMar2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMartedi
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemMer2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMercoledi
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemGio2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupGiovedi
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemVen2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupVenerdi
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemSab2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupSabato
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemDom2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupDomenica
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutItemOra3InizioMer: TdxLayoutItem
      Parent = dxLayoutGroupOre3Mer
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_3_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra3FineMer: TdxLayoutItem
      Parent = dxLayoutGroupOre3Mer
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Fine_3_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra3InizioGio: TdxLayoutItem
      Parent = dxLayoutGroup3OreGio
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_3_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra3FineGio: TdxLayoutItem
      Parent = dxLayoutGroup3OreGio
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Fine_3_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra3InizioVen: TdxLayoutItem
      Parent = dxLayoutGroupORe3Ven
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_3_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra3FineVen: TdxLayoutItem
      Parent = dxLayoutGroupORe3Ven
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Fine_3_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra3InizioSab: TdxLayoutItem
      Parent = dxLayoutGroupOre3Sab
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_3_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra3FineSab: TdxLayoutItem
      Parent = dxLayoutGroupOre3Sab
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Fine_3_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupOra3InizioDom: TdxLayoutItem
      Parent = dxLayoutGroupOre3Dom
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_3_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOra3FineDom: TdxLayoutItem
      Parent = dxLayoutGroupOre3Dom
      SizeOptions.Width = 75
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edOra_Fine_3_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemContenuti1_Lun: TdxLayoutItem
      Parent = dxLayoutGroupOre1Lun
      AlignHorz = ahClient
      SizeOptions.Width = 175
      CaptionOptions.Text = 'Contenuti'
      CaptionOptions.Layout = clTop
      Control = edContenuti1_Lun
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti2_Lun: TdxLayoutItem
      Parent = dxLayoutGroupOre2Lun
      SizeOptions.Width = 175
      CaptionOptions.Text = 'Contenuti'
      CaptionOptions.Layout = clTop
      Control = edContenuti2_Lun
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti3_Lun: TdxLayoutItem
      Parent = dxLayoutGroupOre3Lun
      SizeOptions.Width = 175
      CaptionOptions.Text = 'Contenuti'
      CaptionOptions.Layout = clTop
      Control = edContenuti3_Lun
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti1_Mar: TdxLayoutItem
      Parent = dxLayoutGroupOre1Mar
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti1_Mar
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti2_Mar: TdxLayoutItem
      Parent = dxLayoutGroupOre2Mar
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti2_Mar
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti3_Mar: TdxLayoutItem
      Parent = dxLayoutGroupOre3Mar
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti3_Mar
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti1_Mer: TdxLayoutItem
      Parent = dxLayoutGroupOre1Mer
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti1_Mer
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti2_Mer: TdxLayoutItem
      Parent = dxLayoutGroup2
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti2_Mer
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti3_Mer: TdxLayoutItem
      Parent = dxLayoutGroupOre3Mer
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti3_Mer
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti1_Gio: TdxLayoutItem
      Parent = dxLayoutGroupOre1Gio
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti1_Gio
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti2_Gio: TdxLayoutItem
      Parent = dxLayoutGroupOre2Gio
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti2_Gio
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti3_Gio: TdxLayoutItem
      Parent = dxLayoutGroup3OreGio
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti3_Gio
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti1_Ven: TdxLayoutItem
      Parent = dxLayoutGroupOre1Ven
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti1_Ven
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti2_Ven: TdxLayoutItem
      Parent = dxLayoutGroupOre2Ven
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti2_Ven
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti3_Ven: TdxLayoutItem
      Parent = dxLayoutGroupORe3Ven
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti3_Ven
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti1_Sab: TdxLayoutItem
      Parent = dxLayoutGroupOre1Sab
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti1_Sab
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti2_Sab: TdxLayoutItem
      Parent = dxLayoutGroupOre2Sab
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti2_Sab
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti3_Sab: TdxLayoutItem
      Parent = dxLayoutGroupOre3Sab
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti3_Sab
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti1_Dom: TdxLayoutItem
      Parent = dxLayoutGroupOre1Dom
      AlignHorz = ahClient
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti1_Dom
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti2_Dom: TdxLayoutItem
      Parent = dxLayoutGroupOre2Dom
      AlignHorz = ahClient
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti2_Dom
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemContenuti3_Dom: TdxLayoutItem
      Parent = dxLayoutGroupOre3Dom
      AlignHorz = ahClient
      SizeOptions.Width = 175
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = edContenuti3_Dom
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupOre1Lun: TdxLayoutGroup
      Parent = dxLayoutGroup1Lun
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup1Lun: TdxLayoutGroup
      Parent = dxLayoutGroupLunedi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOre2Lun: TdxLayoutGroup
      Parent = dxLayoutGroup2Lun
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup2Lun: TdxLayoutGroup
      Parent = dxLayoutGroupLunedi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupOre3Lun: TdxLayoutGroup
      Parent = dxLayoutGroup3Lun
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup3Lun: TdxLayoutGroup
      Parent = dxLayoutGroupLunedi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 4
    end
    object dxLayoutGroupOre1Mar: TdxLayoutGroup
      Parent = dxLayoutGroup1Mar
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOre2Mar: TdxLayoutGroup
      Parent = dxLayoutGroup2Mar
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOre3Mar: TdxLayoutGroup
      Parent = dxLayoutGroup3Mar
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup3Mar: TdxLayoutGroup
      Parent = dxLayoutGroupMartedi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 4
    end
    object dxLayoutGroup2Mar: TdxLayoutGroup
      Parent = dxLayoutGroupMartedi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 2
    end
    object dxLayoutGroup1Mar: TdxLayoutGroup
      Parent = dxLayoutGroupMartedi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOre1Mer: TdxLayoutGroup
      Parent = dxLayoutGroup1Mer
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup2: TdxLayoutGroup
      Parent = dxLayoutGroupOre2Mer
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOre3Mer: TdxLayoutGroup
      Parent = dxLayoutGroup3Mer
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup3Mer: TdxLayoutGroup
      Parent = dxLayoutGroupMercoledi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 4
    end
    object dxLayoutGroupOre2Mer: TdxLayoutGroup
      Parent = dxLayoutGroupMercoledi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 2
    end
    object dxLayoutGroup1Mer: TdxLayoutGroup
      Parent = dxLayoutGroupMercoledi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOre1Gio: TdxLayoutGroup
      Parent = dxLayoutGroup1Gio
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup1Gio: TdxLayoutGroup
      Parent = dxLayoutGroupGiovedi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOre2Gio: TdxLayoutGroup
      Parent = dxLayoutGroup2Gio
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup2Gio: TdxLayoutGroup
      Parent = dxLayoutGroupGiovedi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 2
    end
    object dxLayoutGroup3OreGio: TdxLayoutGroup
      Parent = dxLayoutGroup3Gio
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup3Gio: TdxLayoutGroup
      Parent = dxLayoutGroupGiovedi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 4
    end
    object dxLayoutGroupOre1Ven: TdxLayoutGroup
      Parent = dxLayoutGroup1Ven
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup1Ven: TdxLayoutGroup
      Parent = dxLayoutGroupVenerdi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOre2Ven: TdxLayoutGroup
      Parent = dxLayoutGroup2Ven
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup2Ven: TdxLayoutGroup
      Parent = dxLayoutGroupVenerdi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupORe3Ven: TdxLayoutGroup
      Parent = dxLayoutGroup3Ven
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup3Ven: TdxLayoutGroup
      Parent = dxLayoutGroupVenerdi
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 4
    end
    object dxLayoutGroupOre1Sab: TdxLayoutGroup
      Parent = dxLayoutGroup1Sab
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup1Sab: TdxLayoutGroup
      Parent = dxLayoutGroupSabato
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOre2Sab: TdxLayoutGroup
      Parent = dxLayoutGroup2Sab
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup2Sab: TdxLayoutGroup
      Parent = dxLayoutGroupSabato
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupOre3Sab: TdxLayoutGroup
      Parent = dxLayoutGroup3Sab
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup3Sab: TdxLayoutGroup
      Parent = dxLayoutGroupSabato
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 4
    end
    object dxLayoutGroupOre1Dom: TdxLayoutGroup
      Parent = dxLayoutGroup1Dom
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup1Dom: TdxLayoutGroup
      Parent = dxLayoutGroupDomenica
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOre2Dom: TdxLayoutGroup
      Parent = dxLayoutGroup2Dom
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup2Dom: TdxLayoutGroup
      Parent = dxLayoutGroupDomenica
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupOre3Dom: TdxLayoutGroup
      Parent = dxLayoutGroup3Dom
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup3Dom: TdxLayoutGroup
      Parent = dxLayoutGroupDomenica
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 4
    end
    object dxLayoutGroupPeriodo: TdxLayoutGroup
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'Periodo'
      ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItem3: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupButtons
      AlignHorz = ahRight
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 2
    end
    object dxLayoutEmptySpaceItem4: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMain
      SizeOptions.Height = 3
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 5
    end
    object dxLayoutGroup1: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItem5: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroup1
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 0
    end
  end
end
