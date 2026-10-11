object BaseFrame: TBaseFrame
  Left = 0
  Top = 0
  Width = 303
  Height = 282
  TabOrder = 0
  object dxBarManager: TdxBarManager
    AllowReset = False
    AutoDockColor = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockColor = clBtnFace
    ImageOptions.Images = zDmImages.ImageList16
    ImageOptions.LargeImages = zDmImages.ImageList16
    ImageOptions.LargeIcons = True
    ImageOptions.UseLargeImagesForLargeIcons = True
    PopupMenuLinks = <>
    UseSystemFont = True
    OnBarVisibleChange = dxBarManagerBarVisibleChange
    Left = 36
    Top = 96
    PixelsPerInch = 96
    object dxBarButtonPermessiAzione: TdxBarButton
      Action = actPermessiAzione
      Category = 0
    end
  end
  object BaseActions: TActionList
    Images = zDmImages.ImageList16
    Left = 36
    Top = 36
    object actPermessiAzione: TAction
      Caption = 'Permessi'
      ImageIndex = 184
      OnExecute = actPermessiAzioneExecute
    end
  end
  object popActions: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButtonPermessiAzione'
      end>
    UseOwnFont = False
    OnPopup = popActionsPopup
    Left = 36
    Top = 152
    PixelsPerInch = 96
  end
end
