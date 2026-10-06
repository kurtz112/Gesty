object FormSelezionaDate: TFormSelezionaDate
  Left = 908
  Top = 266
  BorderStyle = bsSizeToolWin
  Caption = 'Selezione periodo'
  ClientHeight = 119
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  DesignSize = (
    216
    119)
  TextHeight = 15
  object Label1: TLabel
    Left = 7
    Top = 48
    Width = 49
    Height = 15
    Caption = '&Al giorno'
    FocusControl = edAlGiorno
  end
  object Label2: TLabel
    Left = 7
    Top = 21
    Width = 55
    Height = 15
    Caption = '&Dal giorno'
    FocusControl = edDalGiorno
  end
  object PanelBottoni: TPanel
    Left = 0
    Top = 81
    Width = 216
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      216
      38)
    object BitBtn1: TcxButton
      Left = 56
      Top = 7
      Width = 70
      Height = 24
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object BitBtn2: TcxButton
      Left = 130
      Top = 7
      Width = 70
      Height = 24
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Annulla'
      Default = True
      ModalResult = 2
      TabOrder = 1
    end
  end
  object edAlGiorno: TcxDateEdit
    Left = 67
    Top = 44
    Anchors = [akLeft, akTop, akRight]
    Properties.SaveTime = False
    Properties.ShowTime = False
    TabOrder = 1
    Width = 135
  end
  object edDalGiorno: TcxDateEdit
    Left = 67
    Top = 17
    Anchors = [akLeft, akTop, akRight]
    Properties.SaveTime = False
    Properties.ShowTime = False
    TabOrder = 0
    Width = 135
  end
end
