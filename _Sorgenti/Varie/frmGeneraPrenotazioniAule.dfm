object FormGeneraPrenotazioniAule: TFormGeneraPrenotazioniAule
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Prenotazioni Aule'
  ClientHeight = 585
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 15
  object dxLayoutControl: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 460
    Height = 585
    TabOrder = 0
    AutoSize = True
    object edOra_Inizio_Lun: TcxTimeEdit
      Left = 278
      Top = 310
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 7
      Width = 70
    end
    object edOra_Inizio_Mar: TcxTimeEdit
      Left = 278
      Top = 340
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 10
      Width = 70
    end
    object edOra_Inizio_Mer: TcxTimeEdit
      Left = 278
      Top = 370
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
    object edOra_Inizio_Gio: TcxTimeEdit
      Left = 278
      Top = 400
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 16
      Width = 70
    end
    object edOra_Inizio_Ven: TcxTimeEdit
      Left = 278
      Top = 430
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
    object edOra_Inizio_Sab: TcxTimeEdit
      Left = 278
      Top = 460
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
    object edOra_Inizio_Dom: TcxTimeEdit
      Left = 278
      Top = 490
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
    object edOra_Fine_Lun: TcxTimeEdit
      Left = 355
      Top = 310
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 8
      Width = 70
    end
    object edOra_Fine_Mar: TcxTimeEdit
      Left = 355
      Top = 340
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
    object edOra_Fine_Mer: TcxTimeEdit
      Left = 355
      Top = 370
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 14
      Width = 70
    end
    object edOra_Fine_Gio: TcxTimeEdit
      Left = 355
      Top = 400
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
    object edOra_Fine_Ven: TcxTimeEdit
      Left = 355
      Top = 430
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 20
      Width = 70
    end
    object edOra_Fine_Sab: TcxTimeEdit
      Left = 355
      Top = 460
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
    object edOra_Fine_Dom: TcxTimeEdit
      Left = 355
      Top = 490
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ReadOnly = False
      Properties.SpinButtons.Position = sbpHorzRight
      Properties.TimeFormat = tfHourMin
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      TabOrder = 26
      Width = 70
    end
    object edDalGiorno: TcxDateEdit
      Left = 26
      Top = 310
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
      TabOrder = 4
      Width = 130
    end
    object edAlGiorno: TcxDateEdit
      Left = 26
      Top = 361
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
      TabOrder = 5
      Width = 130
    end
    object tnOk: TcxButton
      Left = 282
      Top = 548
      Width = 75
      Height = 25
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 27
    end
    object btnCancel: TcxButton
      Left = 364
      Top = 548
      Width = 75
      Height = 25
      Caption = 'Annulla'
      ModalResult = 2
      TabOrder = 28
    end
    object checkLunedi: TcxCheckBox
      Left = 191
      Top = 312
      Caption = 'Luned'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 6
      Transparent = True
    end
    object checkMartedi: TcxCheckBox
      Left = 191
      Top = 342
      Caption = 'Marted'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 9
      Transparent = True
    end
    object checkMercoledi: TcxCheckBox
      Left = 191
      Top = 372
      Caption = 'Mercoled'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 12
      Transparent = True
    end
    object checkGiovedi: TcxCheckBox
      Left = 191
      Top = 402
      Caption = 'Gioved'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 15
      Transparent = True
    end
    object checkVenerdi: TcxCheckBox
      Left = 191
      Top = 432
      Caption = 'Venerd'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 18
      Transparent = True
    end
    object checkSabato: TcxCheckBox
      Left = 191
      Top = 462
      Caption = 'Sabato'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 21
      Transparent = True
    end
    object checkDomenica: TcxCheckBox
      Left = 191
      Top = 492
      Caption = 'Domenica'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 24
      Transparent = True
    end
    object edProgetto: TcxExtLookupComboBox
      Left = 26
      Top = 106
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.OnEditValueChanged = edProgettoPropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 399
    end
    object edCorso: TcxExtLookupComboBox
      Left = 26
      Top = 158
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.OnEditValueChanged = edCorsoPropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 2
      Width = 399
    end
    object edAula: TcxExtLookupComboBox
      Left = 26
      Top = 54
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.OnEditValueChanged = edAulaPropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 399
    end
    object edOggetto: TcxTextEdit
      Left = 26
      Top = 210
      Properties.OnEditValueChanged = edOggettoPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Text = 'edOggetto'
      Width = 399
    end
    object edEliminazionePrenotazioni: TcxCheckBox
      Left = 33
      Top = 548
      Caption = 'Eliminazione Prenotazioni'
      Properties.Alignment = taRightJustify
      Properties.OnEditValueChanged = edEliminazionePrenotazioniPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 29
      Transparent = True
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahLeft
      AlignVert = avTop
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemOra1InizioLun: TdxLayoutItem
      Parent = dxLayoutGroupLunedi
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Ora Inizio:'
      CaptionOptions.Layout = clTop
      Control = edOra_Inizio_Lun
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
      Control = edOra_Inizio_Mar
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
      Control = edOra_Inizio_Mer
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
      Control = edOra_Inizio_Gio
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
      Control = edOra_Inizio_Ven
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
      Control = edOra_Inizio_Sab
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
      Control = edOra_Inizio_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOra1FineLun: TdxLayoutItem
      Parent = dxLayoutGroupLunedi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Layout = clTop
      Control = edOra_Fine_Lun
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineMar: TdxLayoutItem
      Parent = dxLayoutGroupMartedi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_Mar
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineMer: TdxLayoutItem
      Parent = dxLayoutGroupMercoledi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_Mer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineGio: TdxLayoutItem
      Parent = dxLayoutGroupGiovedi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_Gio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineVen: TdxLayoutItem
      Parent = dxLayoutGroupVenerdi
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_Ven
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineSab: TdxLayoutItem
      Parent = dxLayoutGroupSabato
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_Sab
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOra1FineDom: TdxLayoutItem
      Parent = dxLayoutGroupDomenica
      CaptionOptions.Text = 'Ora Fine:'
      CaptionOptions.Visible = False
      Control = edOra_Fine_Dom
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemDataInizio: TdxLayoutItem
      Parent = dxLayoutGroupDate
      CaptionOptions.Text = 'Dal Giorno:'
      CaptionOptions.Layout = clTop
      Control = edDalGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 130
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemDataFine: TdxLayoutItem
      Parent = dxLayoutGroupDate
      CaptionOptions.Text = 'Al Giorno:'
      CaptionOptions.Layout = clTop
      Control = edAlGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 130
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupLunedi: TdxLayoutGroup
      Parent = dxLayoutGroup
      CaptionOptions.Text = 'Luned'#236
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupMartedi: TdxLayoutGroup
      Parent = dxLayoutGroup
      CaptionOptions.Text = 'Marted'#236
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupMercoledi: TdxLayoutGroup
      Parent = dxLayoutGroup
      CaptionOptions.Text = 'Mercoled'#236
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupGiovedi: TdxLayoutGroup
      Parent = dxLayoutGroup
      CaptionOptions.Text = 'Gioved'#236
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 3
    end
    object dxLayoutGroupSabato: TdxLayoutGroup
      Parent = dxLayoutGroup
      CaptionOptions.Text = 'Sabato'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 5
    end
    object dxLayoutGroupVenerdi: TdxLayoutGroup
      Parent = dxLayoutGroup
      CaptionOptions.Text = 'Venerd'#236
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 4
    end
    object dxLayoutGroupDomenica: TdxLayoutGroup
      Parent = dxLayoutGroup
      CaptionOptions.Text = 'Domenica'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 6
    end
    object dxLayoutGroupMain: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMain
      SizeOptions.Height = 7
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 1
    end
    object dxLayoutGroupDate: TdxLayoutGroup
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'Periodo'
      Index = 0
    end
    object dxLayoutGroup: TdxLayoutGroup
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'Orari'
      CaptionOptions.Visible = False
      ButtonOptions.Alignment = gbaLeft
      ButtonOptions.CheckBox.Visible = True
      ButtonOptions.Visible = False
      Index = 1
    end
    object dxLayoutItemLabelLunedi: TdxLayoutItem
      Parent = dxLayoutGroupLunedi
      AlignVert = avCenter
      SizeOptions.Width = 80
      CaptionOptions.Text = 'Giorno:'
      CaptionOptions.Layout = clTop
      Control = checkLunedi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 54
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemLabelMartedi: TdxLayoutItem
      Parent = dxLayoutGroupMartedi
      AlignVert = avCenter
      SizeOptions.Width = 80
      CaptionOptions.Text = 'Giorno:'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkMartedi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 59
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemLabelMercoledi: TdxLayoutItem
      Parent = dxLayoutGroupMercoledi
      AlignVert = avCenter
      SizeOptions.Width = 80
      CaptionOptions.Text = 'checkMercoledi'
      CaptionOptions.Visible = False
      Control = checkMercoledi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 71
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemLabelDomenica: TdxLayoutItem
      Parent = dxLayoutGroupDomenica
      AlignVert = avCenter
      SizeOptions.Width = 80
      CaptionOptions.Text = 'checkDomenica'
      CaptionOptions.Visible = False
      Control = checkDomenica
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 72
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemLabelSabato: TdxLayoutItem
      Parent = dxLayoutGroupSabato
      AlignVert = avCenter
      SizeOptions.Width = 80
      CaptionOptions.Text = 'checkSabato'
      CaptionOptions.Visible = False
      Control = checkSabato
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 54
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemLabelVenerdi: TdxLayoutItem
      Parent = dxLayoutGroupVenerdi
      AlignVert = avCenter
      SizeOptions.Width = 80
      CaptionOptions.Text = 'checkVenerdi'
      CaptionOptions.Visible = False
      Control = checkVenerdi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 57
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemLabelGiovedi: TdxLayoutItem
      Parent = dxLayoutGroupGiovedi
      AlignVert = avCenter
      SizeOptions.Width = 80
      CaptionOptions.Text = 'checkGiovedi'
      CaptionOptions.Visible = False
      Control = checkGiovedi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 58
      ControlOptions.ShowBorder = False
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
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 4
    end
    object dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupMain
      SizeOptions.Height = 7
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutItemAula: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'Aula:'
      CaptionOptions.Layout = clTop
      Control = edAula
      ControlOptions.OriginalHeight = 24
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemProgetto: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'Progetto:'
      CaptionOptions.Layout = clTop
      Control = edProgetto
      ControlOptions.OriginalHeight = 24
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemCorso: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'Corso:'
      CaptionOptions.Layout = clTop
      Control = edCorso
      ControlOptions.OriginalHeight = 24
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemOggetto: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'Oggetto:'
      CaptionOptions.Layout = clTop
      Control = edOggetto
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutGroup1: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      CaptionOptions.Text = 'Nuovo gruppo'
      CaptionOptions.Visible = False
      Index = 0
    end
    object dxLayoutGroup2: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      CaptionOptions.Text = 'Nuovo gruppo'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object dxLayoutItemEliminazionePrenotazioni: TdxLayoutItem
      Parent = dxLayoutGroupButtons
      AlignVert = avClient
      CaptionOptions.Glyph.SourceDPI = 96
      CaptionOptions.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000025744558745469746C6500436C6561723B45726173653B
        52656D6F76653B426172733B526962626F6E3B87808373000000804944415478
        5EB5D3B109803014846167929419C0C20DECB5CD048260E5060EE00459C39DE2
        0B0A079E8113B1F8CAFFE015AF4A297D2205DEFB36D307385E4F3CA2C7D0F180
        1E6F26999107F4D860E47D0C130610D726A871768FFB4B50E28C6358CA3194E2
        D9EC2672CC03EE3186C8319FE0288641FA050B1A3D86BFBE517700AB9046D6FE
        06CD5C0000000049454E44AE426082}
      Control = edEliminazionePrenotazioni
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 154
      ControlOptions.ShowBorder = False
      Index = 2
    end
  end
  object lkAuleSrc: TDataSource
    Left = 368
    Top = 72
  end
  object lkProgettiSrc: TDataSource
    Left = 368
    Top = 136
  end
  object lkCorsiSrc: TDataSource
    Left = 368
    Top = 192
  end
end
