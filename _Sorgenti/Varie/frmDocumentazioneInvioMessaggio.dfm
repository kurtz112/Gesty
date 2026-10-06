object FormDocumentazioneInvioMessaggio: TFormDocumentazioneInvioMessaggio
  Left = 0
  Top = 0
  Caption = 'Invio messaggio (PEC)'
  ClientHeight = 460
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  DesignSize = (
    516
    460)
  TextHeight = 15
  object LabelDestinatari: TLabel
    Left = 8
    Top = 8
    Width = 131
    Height = 15
    Caption = 'Destinatari (uno per riga)'
    FocusControl = meDestinatari
  end
  object LabelCopie: TLabel
    Left = 8
    Top = 102
    Width = 171
    Height = 15
    Caption = 'Copia conoscenza (uno per riga)'
    FocusControl = meCopie
  end
  object LabelOggetto: TLabel
    Left = 8
    Top = 176
    Width = 44
    Height = 15
    Caption = 'Oggetto'
    FocusControl = edOggetto
  end
  object LabelCorpo: TLabel
    Left = 8
    Top = 224
    Width = 27
    Height = 15
    Caption = 'Testo'
    FocusControl = meCorpo
  end
  object edOggetto: TcxTextEdit
    Left = 8
    Top = 194
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Width = 500
  end
  object meDestinatari: TcxMemo
    Left = 8
    Top = 26
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Height = 70
    Width = 500
  end
  object meCopie: TcxMemo
    Left = 8
    Top = 120
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Height = 50
    Width = 500
  end
  object meCorpo: TcxMemo
    Left = 8
    Top = 242
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    Height = 170
    Width = 500
  end
  object PanelBottoni: TPanel
    Left = 0
    Top = 420
    Width = 516
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      516
      40)
    object btnOk: TcxButton
      Left = 362
      Top = 8
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnAnnulla: TcxButton
      Left = 438
      Top = 8
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Annulla'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
