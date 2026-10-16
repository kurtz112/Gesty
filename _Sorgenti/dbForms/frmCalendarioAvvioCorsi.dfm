inherited FormCalendarioAvvioCorsi: TFormCalendarioAvvioCorsi
  Left = 0
  Top = 0
  Caption = 'FormCalendarioAvvioCorsi'
  ClientHeight = 717
  ClientWidth = 1227
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 1243
  ExplicitHeight = 756
  TextHeight = 15
  inherited lblTitolo: TcxLabel
    TabOrder = 1
  end
  object dxLayoutControl: TdxLayoutControl [1]
    Left = 0
    Top = 30
    Width = 1227
    Height = 687
    Align = alClient
    TabOrder = 0
    AutoSize = True
    ExplicitWidth = 1223
    ExplicitHeight = 686
    object btnSvuota: TcxButton
      Left = 672
      Top = 39
      Width = 100
      Height = 25
      Action = Svuota
      TabOrder = 53
    end
    object edOra_Inizio_2_Lun: TcxTimeEdit
      Left = 270
      Top = 270
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 12
      Width = 70
    end
    object edOra_Fine_2_Lun: TcxTimeEdit
      Left = 347
      Top = 270
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 13
      Width = 70
    end
    object edNumero_Ore_Lun: TcxTextEdit
      Left = 441
      Top = 270
      TabStop = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Properties.ValidateOnEnter = True
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 14
      Width = 100
    end
    object edOra_Inizio_1_Lun: TcxTimeEdit
      Left = 99
      Top = 270
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnEditValueChanged = EditValueChanged
      TabOrder = 10
      Width = 70
    end
    object edOra_Inizio_1_Mar: TcxTimeEdit
      Left = 99
      Top = 300
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnEditValueChanged = EditValueChanged
      TabOrder = 16
      Width = 70
    end
    object edOra_Inizio_1_Mer: TcxTimeEdit
      Left = 99
      Top = 330
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 22
      Width = 70
    end
    object edOra_Inizio_1_Gio: TcxTimeEdit
      Left = 99
      Top = 360
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 28
      Width = 70
    end
    object edOra_Inizio_1_Ven: TcxTimeEdit
      Left = 99
      Top = 390
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 34
      Width = 70
    end
    object edOra_Inizio_1_Sab: TcxTimeEdit
      Left = 99
      Top = 420
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 40
      Width = 70
    end
    object edOra_Inizio_1_Dom: TcxTimeEdit
      Left = 99
      Top = 450
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 46
      Width = 70
    end
    object edOra_Fine_1_Lun: TcxTimeEdit
      Left = 176
      Top = 270
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 11
      Width = 70
    end
    object edOra_Fine_1_Mar: TcxTimeEdit
      Left = 176
      Top = 300
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 17
      Width = 70
    end
    object edOra_Fine_1_Mer: TcxTimeEdit
      Left = 176
      Top = 330
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 23
      Width = 70
    end
    object edOra_Fine_1_Gio: TcxTimeEdit
      Left = 176
      Top = 360
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 29
      Width = 70
    end
    object edOra_Fine_1_Ven: TcxTimeEdit
      Left = 176
      Top = 390
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 35
      Width = 70
    end
    object edOra_Fine_1_Sab: TcxTimeEdit
      Left = 176
      Top = 420
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 41
      Width = 70
    end
    object edOra_Fine_1_Dom: TcxTimeEdit
      Left = 176
      Top = 450
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 47
      Width = 70
    end
    object edOra_Inizio_2_Mar: TcxTimeEdit
      Left = 270
      Top = 300
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 18
      Width = 70
    end
    object edOra_Fine_2_Mar: TcxTimeEdit
      Left = 347
      Top = 300
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 19
      Width = 70
    end
    object edNumero_Ore_Mar: TcxTextEdit
      Left = 441
      Top = 300
      TabStop = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Properties.ValidateOnEnter = True
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 20
      Width = 100
    end
    object edOra_Inizio_2_Mer: TcxTimeEdit
      Left = 270
      Top = 330
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 24
      Width = 70
    end
    object edOra_Fine_2_Mer: TcxTimeEdit
      Left = 347
      Top = 330
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 25
      Width = 70
    end
    object edNumero_Ore_Mer: TcxTextEdit
      Left = 441
      Top = 330
      TabStop = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Properties.ValidateOnEnter = True
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 26
      Width = 100
    end
    object edOra_Inizio_2_Gio: TcxTimeEdit
      Left = 270
      Top = 360
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 30
      Width = 70
    end
    object edOra_Fine_2_Gio: TcxTimeEdit
      Left = 347
      Top = 360
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 31
      Width = 70
    end
    object edNumero_Ore_Gio: TcxTextEdit
      Left = 441
      Top = 360
      TabStop = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Properties.ValidateOnEnter = True
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 32
      Width = 100
    end
    object edOra_Inizio_2_Ven: TcxTimeEdit
      Left = 270
      Top = 390
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 36
      Width = 70
    end
    object edOra_Fine_2_Ven: TcxTimeEdit
      Left = 347
      Top = 390
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 37
      Width = 70
    end
    object edNumero_Ore_Ven: TcxTextEdit
      Left = 441
      Top = 390
      TabStop = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Properties.ValidateOnEnter = True
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 38
      Width = 100
    end
    object edOra_Inizio_2_Sab: TcxTimeEdit
      Left = 270
      Top = 420
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 42
      Width = 70
    end
    object edOra_Fine_2_Sab: TcxTimeEdit
      Left = 347
      Top = 420
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 43
      Width = 70
    end
    object edNumero_Ore_Sab: TcxTextEdit
      Left = 441
      Top = 420
      TabStop = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Properties.ValidateOnEnter = True
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 44
      Width = 100
    end
    object edOra_Inizio_2_Dom: TcxTimeEdit
      Left = 270
      Top = 450
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 48
      Width = 70
    end
    object edOra_Fine_2_Dom: TcxTimeEdit
      Left = 347
      Top = 450
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 49
      Width = 70
    end
    object edNumero_Ore_Dom: TcxTextEdit
      Left = 441
      Top = 450
      TabStop = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Properties.ValidateOnEnter = True
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 50
      Width = 100
    end
    object edDalGiorno: TcxDateEdit
      Left = 101
      Top = 219
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
      TabOrder = 6
      Width = 100
    end
    object edAlGiorno: TcxDateEdit
      Left = 266
      Top = 219
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
      TabOrder = 7
      Width = 100
    end
    object btnGenera: TcxButton
      Left = 565
      Top = 39
      Width = 100
      Height = 25
      Action = Genera
      TabOrder = 52
    end
    object edModalita: TcxComboBox
      Left = 464
      Top = 219
      Properties.Items.Strings = (
        'Aula'
        'Stage')
      Properties.OnEditValueChanged = edModalitaPropertiesEditValueChanged
      TabOrder = 8
      Text = 'Aula'
      Width = 75
    end
    object viewGiorni: TzDbView
      Left = 565
      Top = 71
      Width = 650
      Height = 604
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 54
      ToolActions = <>
    end
    object viewChiusure: TzDbView
      Left = 12
      Top = 497
      Width = 529
      Height = 178
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 51
      ToolActions = <>
    end
    object checkLunedi: TcxCheckBox
      Left = 12
      Top = 274
      Caption = 'Luned'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = AbilitaGiorni
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 9
      Transparent = True
    end
    object checkMercoledi: TcxCheckBox
      Left = 12
      Top = 334
      Caption = 'Mercoled'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 21
      Transparent = True
    end
    object checkGiovedi: TcxCheckBox
      Left = 12
      Top = 364
      Caption = 'Gioved'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 27
      Transparent = True
    end
    object checkVenerdi: TcxCheckBox
      Left = 12
      Top = 390
      Caption = 'Venerd'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 33
      Transparent = True
    end
    object checkSabato: TcxCheckBox
      Left = 12
      Top = 420
      Caption = 'Sabato'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 39
      Transparent = True
    end
    object checkDomenica: TcxCheckBox
      Left = 12
      Top = 450
      Caption = 'Domenica'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 45
      Transparent = True
    end
    object checkMartedi: TcxCheckBox
      Left = 12
      Top = 304
      Caption = 'Marted'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 15
      Transparent = True
    end
    object edTitoloCorso: TcxTextEdit
      Left = 101
      Top = 69
      Properties.OnEditValueChanged = edTitoloCorsoPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 440
    end
    object edCodiceCorso: TcxTextEdit
      Left = 101
      Top = 99
      Properties.OnEditValueChanged = edCodiceCorsoPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Width = 440
    end
    object edTipoAnnualita: TcxTextEdit
      Left = 101
      Top = 129
      Properties.OnEditValueChanged = edTipoAnnualitaPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Width = 440
    end
    object edIdSezione: TcxTextEdit
      Left = 101
      Top = 159
      Properties.OnEditValueChanged = edIdSezionePropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Width = 440
    end
    object edCodiceSezione: TcxTextEdit
      Left = 101
      Top = 189
      Properties.OnEditValueChanged = edCodiceSezionePropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 5
      Width = 440
    end
    object edProgetto: TcxExtLookupComboBox
      Left = 101
      Top = 39
      Properties.OnEditValueChanged = edProgettoPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 440
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutGroupBtns: TdxLayoutGroup
      Parent = dxLayoutGroupCalendario
      CaptionOptions.Text = 'New Group'
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemOra1InizioLun: TdxLayoutItem
      Parent = dxLayoutGroupLunedi
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Layout = clTop
      Control = edOra_Inizio_1_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1InizioMar: TdxLayoutItem
      Parent = dxLayoutGroupMartedi
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1InizioMer: TdxLayoutItem
      Parent = dxLayoutGroupMercoledi
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1InizioGio: TdxLayoutItem
      Parent = dxLayoutGroupGiovedi
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1InizioVen: TdxLayoutItem
      Parent = dxLayoutGroupVenerdi
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1InizioSab: TdxLayoutItem
      Parent = dxLayoutGroupSabato
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1InizioDom: TdxLayoutItem
      Parent = dxLayoutGroupDomenica
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_1_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1FineLun: TdxLayoutItem
      Parent = dxLayoutGroupLunedi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Layout = clTop
      Control = edOra_Fine_1_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineMar: TdxLayoutItem
      Parent = dxLayoutGroupMartedi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineMer: TdxLayoutItem
      Parent = dxLayoutGroupMercoledi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineGio: TdxLayoutItem
      Parent = dxLayoutGroupGiovedi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineVen: TdxLayoutItem
      Parent = dxLayoutGroupVenerdi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineSab: TdxLayoutItem
      Parent = dxLayoutGroupSabato
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineDom: TdxLayoutItem
      Parent = dxLayoutGroupDomenica
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_1_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra2InizioLun: TdxLayoutItem
      Parent = dxLayoutGroupLunedi
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Layout = clTop
      Control = edOra_Inizio_2_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItemOra2InizioMar: TdxLayoutItem
      Parent = dxLayoutGroupMartedi
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItemOra2InizioMer: TdxLayoutItem
      Parent = dxLayoutGroupMercoledi
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItemOra2InizioGio: TdxLayoutItem
      Parent = dxLayoutGroupGiovedi
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItemOra2InizioVen: TdxLayoutItem
      Parent = dxLayoutGroupVenerdi
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItemOra2InizioSab: TdxLayoutItem
      Parent = dxLayoutGroupSabato
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItemOra2InizioDom: TdxLayoutItem
      Parent = dxLayoutGroupDomenica
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Visible = False
      Control = edOra_Inizio_2_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItemOra2FineLun: TdxLayoutItem
      Parent = dxLayoutGroupLunedi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Layout = clTop
      Control = edOra_Fine_2_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItemOra2FineMar: TdxLayoutItem
      Parent = dxLayoutGroupMartedi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItemOra2FineMer: TdxLayoutItem
      Parent = dxLayoutGroupMercoledi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItemOra2FineGio: TdxLayoutItem
      Parent = dxLayoutGroupGiovedi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItemOra2FineVen: TdxLayoutItem
      Parent = dxLayoutGroupVenerdi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItemOra2FineSab: TdxLayoutItem
      Parent = dxLayoutGroupSabato
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItemOra2FineDom: TdxLayoutItem
      Parent = dxLayoutGroupDomenica
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_2_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItemTotaleOreLun: TdxLayoutItem
      Parent = dxLayoutGroupLunedi
      CaptionOptions.Text = 'Tot. Ore'
      CaptionOptions.Layout = clTop
      Control = edNumero_Ore_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object dxLayoutItemTotaleOreMar: TdxLayoutItem
      Parent = dxLayoutGroupMartedi
      CaptionOptions.Text = 'Tot. Ore'
      CaptionOptions.Visible = False
      Control = edNumero_Ore_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object dxLayoutItemTotaleOreMer: TdxLayoutItem
      Parent = dxLayoutGroupMercoledi
      CaptionOptions.Text = 'Tot. Ore'
      CaptionOptions.Visible = False
      Control = edNumero_Ore_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object dxLayoutItemTotaleOreGio: TdxLayoutItem
      Parent = dxLayoutGroupGiovedi
      CaptionOptions.Text = 'Tot. Ore'
      CaptionOptions.Visible = False
      Control = edNumero_Ore_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object dxLayoutItemTotaleOreVen: TdxLayoutItem
      Parent = dxLayoutGroupVenerdi
      CaptionOptions.Text = 'Tot. Ore'
      CaptionOptions.Visible = False
      Control = edNumero_Ore_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object dxLayoutItemTotaleOreSab: TdxLayoutItem
      Parent = dxLayoutGroupSabato
      CaptionOptions.Text = 'Tot. Ore'
      CaptionOptions.Visible = False
      Control = edNumero_Ore_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object dxLayoutItemTotaleOreDom: TdxLayoutItem
      Parent = dxLayoutGroupDomenica
      CaptionOptions.Text = 'Tot. Ore'
      CaptionOptions.Visible = False
      Control = edNumero_Ore_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object dxLayoutItemDataInizio: TdxLayoutItem
      Parent = dxLayoutGroupDate
      CaptionOptions.Text = 'Data Inizio:'
      Control = edDalGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemDataFine: TdxLayoutItem
      Parent = dxLayoutGroupDate
      CaptionOptions.Text = 'Data Fine:'
      Control = edAlGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupLunedi: TdxLayoutGroup
      Parent = dxLayoutGroupGiorni
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Luned'#236
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupMartedi: TdxLayoutGroup
      Parent = dxLayoutGroupGiorni
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Marted'#236
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupMercoledi: TdxLayoutGroup
      Parent = dxLayoutGroupGiorni
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Mercoled'#236
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 3
    end
    object dxLayoutGroupGiovedi: TdxLayoutGroup
      Parent = dxLayoutGroupGiorni
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Gioved'#236
      ItemIndex = 5
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 4
    end
    object dxLayoutGroupSabato: TdxLayoutGroup
      Parent = dxLayoutGroupGiorni
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Sabato'
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 6
    end
    object dxLayoutGroupVenerdi: TdxLayoutGroup
      Parent = dxLayoutGroupGiorni
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Venerd'#236
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 5
    end
    object dxLayoutGroupDomenica: TdxLayoutGroup
      Parent = dxLayoutGroupGiorni
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Domenica'
      ItemIndex = 7
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 7
    end
    object dxLayoutGroupGiorni: TdxLayoutGroup
      Parent = dxLayoutGroupTop
      AlignHorz = ahLeft
      AlignVert = avClient
      CaptionOptions.Text = 'Giorni'
      CaptionOptions.Visible = False
      ItemIndex = 8
      ShowBorder = False
      Index = 0
    end
    object dxLayoutEmptySpaceItemLun: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupLunedi
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemMar: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMartedi
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemMer: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMercoledi
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemGio: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupGiovedi
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemVen: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupVenerdi
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemSab: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupSabato
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemDom: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupDomenica
      AlignVert = avClient
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItemTotLun: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupLunedi
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 6
    end
    object dxLayoutEmptySpaceItemTotMar: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMartedi
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 6
    end
    object dxLayoutEmptySpaceItemTotMer: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMercoledi
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 6
    end
    object dxLayoutEmptySpaceItemTotGio: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupGiovedi
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 6
    end
    object dxLayoutEmptySpaceItemTotVen: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupVenerdi
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 6
    end
    object dxLayoutEmptySpaceItemTotSab: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupSabato
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 6
    end
    object dxLayoutEmptySpaceItemTotDom: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupDomenica
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 6
    end
    object dxLayoutItemSvuota: TdxLayoutItem
      Parent = dxLayoutGroupBtns
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnSvuota
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupMain: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      ItemIndex = 1
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemGenera: TdxLayoutItem
      Parent = dxLayoutGroupBtns
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnGenera
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemModalita: TdxLayoutItem
      Parent = dxLayoutGroupDate
      CaptionOptions.Text = 'Mod. Operativa:'
      Control = edModalita
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMain
      SizeOptions.Height = 20
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 0
    end
    object dxLayoutItemCalendario: TdxLayoutItem
      Parent = dxLayoutGroupCalendario
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = viewGiorni
      ControlOptions.OriginalHeight = 329
      ControlOptions.OriginalWidth = 509
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemChiusure: TdxLayoutItem
      Parent = dxLayoutGroupGiorni
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = viewChiusure
      ControlOptions.OriginalHeight = 150
      ControlOptions.OriginalWidth = 150
      ControlOptions.ShowBorder = False
      Index = 9
    end
    object dxLayoutGroupTop: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItem3: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupTop
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 1
    end
    object dxLayoutItemLunedi: TdxLayoutItem
      Parent = dxLayoutGroupLunedi
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkLunedi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 56
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemMartedì: TdxLayoutItem
      Parent = dxLayoutGroupMartedi
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = checkMartedi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 61
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemMercoledi: TdxLayoutItem
      Parent = dxLayoutGroupMercoledi
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = checkMercoledi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 73
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemGiovedi: TdxLayoutItem
      Parent = dxLayoutGroupGiovedi
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = checkGiovedi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 60
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemVenerdi: TdxLayoutItem
      Parent = dxLayoutGroupVenerdi
      SizeOptions.Width = 80
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = checkVenerdi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 59
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemSabato: TdxLayoutItem
      Parent = dxLayoutGroupSabato
      SizeOptions.Width = 80
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = checkSabato
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 56
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemDomenica: TdxLayoutItem
      Parent = dxLayoutGroupDomenica
      SizeOptions.Width = 80
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = checkDomenica
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 74
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemProgetto: TdxLayoutItem
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Progetto:'
      Control = edProgetto
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 305
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemTitoloCorso: TdxLayoutItem
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      CaptionOptions.Text = 'Titolo Corso:'
      Control = edTitoloCorso
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 305
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemCodiceCorso: TdxLayoutItem
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      CaptionOptions.Text = 'Codice Corso:'
      Control = edCodiceCorso
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 305
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemTipoAnnualita: TdxLayoutItem
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Tipo Annualit'#224':'
      Control = edTipoAnnualita
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 305
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutItemIdSezione: TdxLayoutItem
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      CaptionOptions.Text = 'Id Sezione:'
      Control = edIdSezione
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 305
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItemCodiceSezione: TdxLayoutItem
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      CaptionOptions.Text = 'Codice Sezione:'
      Control = edCodiceSezione
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 305
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutGroupProgetto: TdxLayoutGroup
      Parent = dxLayoutGroupGiorni
      CaptionOptions.Text = 'New Group'
      ItemIndex = 6
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupDate: TdxLayoutGroup
      Parent = dxLayoutGroupProgetto
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 6
    end
    object dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupGiorni
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 8
    end
    object dxLayoutGroupCalendario: TdxLayoutGroup
      Parent = dxLayoutGroupTop
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 2
    end
  end
  inherited dxBarManager: TdxBarManager
    Left = 104
    Top = 552
    PixelsPerInch = 96
  end
  inherited BaseActions: TActionList
    Left = 124
    Top = 452
  end
  inherited popActions: TdxBarPopupMenu
    Left = 116
    Top = 504
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 104
    Top = 613
    object Genera: TAction
      Caption = 'Genera'
      ImageIndex = 1428
      ShortCut = 120
      OnExecute = GeneraExecute
    end
    object Svuota: TAction
      Caption = 'Svuota'
      ImageIndex = 2186
      OnExecute = SvuotaExecute
    end
  end
end
