inherited FormNotifiche: TFormNotifiche
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object TimerSegnaComeLetta: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TimerSegnaComeLettaTimer
    Left = 152
    Top = 176
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList16
    Left = 152
    Top = 104
    object RiassegnaTicket: TAction
      Caption = 'Riassegna Ticket'
      ImageIndex = 314
      OnExecute = RiassegnaTicketExecute
    end
  end
end
