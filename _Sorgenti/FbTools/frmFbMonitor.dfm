inherited FormFbMonitor: TFormFbMonitor
  ClientHeight = 652
  ClientWidth = 842
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 858
  ExplicitHeight = 691
  TextHeight = 15
  object layoutDB: TdxLayoutControl [1]
    Left = 136
    Top = 59
    Width = 665
    Height = 126
    TabOrder = 5
    OptionsImage.Images = cxImageList
    OptionsItem.FocusControlOnItemCaptionClick = True
    OptionsItem.ShowQuickCustomizationToolbar = False
    object lblDatabaseName: TcxDBLabel
      Left = 26
      Top = 33
      ParentFont = False
      Style.HotTrack = False
      Style.StyleController = styleTytle
      Style.TransparentBorder = False
      TabOrder = 0
      Transparent = True
      Height = 21
      Width = 121
    end
    object lblODS: TcxDBLabel
      Left = 26
      Top = 61
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Transparent = True
      Height = 21
      Width = 121
    end
    object lblPagine: TcxDBLabel
      Left = 182
      Top = 61
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Transparent = True
      Height = 21
      Width = 121
    end
    object lblDimensione: TcxDBLabel
      Left = 182
      Top = 33
      ParentFont = False
      Style.HotTrack = False
      Style.StyleController = styleTytle
      Style.TransparentBorder = False
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 121
    end
    object lblBufferCount: TcxDBLabel
      Left = 338
      Top = 61
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 5
      Transparent = True
      Height = 15
      Width = 68
    end
    object lblBufferCache: TcxDBLabel
      Left = 338
      Top = 33
      ParentFont = False
      Style.HotTrack = False
      Style.StyleController = styleTytle
      Style.TransparentBorder = False
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 121
    end
    object lblCreationTime: TcxDBLabel
      Left = 494
      Top = 61
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 7
      Transparent = True
      Height = 21
      Width = 121
    end
    object lblCreationDate: TcxDBLabel
      Left = 494
      Top = 33
      ParentFont = False
      Style.HotTrack = False
      Style.StyleController = styleTytle
      Style.TransparentBorder = False
      TabOrder = 6
      Transparent = True
      Height = 21
      Width = 121
    end
    object layoutDBGroup_Root1: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avTop
      Hidden = True
      ItemIndex = 3
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutGroupDatabase: TdxLayoutGroup
      Parent = layoutDBGroup_Root1
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.ImageIndex = 0
      CaptionOptions.Text = 'Database'
      ItemIndex = 1
      Index = 0
    end
    object dxLayoutGroupDimensioni: TdxLayoutGroup
      Parent = layoutDBGroup_Root1
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.ImageIndex = 1
      CaptionOptions.Text = 'Dimensioni'
      ItemIndex = 1
      Index = 1
    end
    object dxLayoutGroupBufferCache: TdxLayoutGroup
      Parent = layoutDBGroup_Root1
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.ImageIndex = 2
      CaptionOptions.Text = 'Buffer Cache'
      ItemIndex = 1
      Index = 2
    end
    object dxLayoutGroupCreazione: TdxLayoutGroup
      Parent = layoutDBGroup_Root1
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.ImageIndex = 3
      CaptionOptions.Text = 'Creazione'
      ItemIndex = 1
      Index = 3
    end
    object dxLayoutItemDatabaseName: TdxLayoutItem
      Parent = dxLayoutGroupDatabase
      AlignHorz = ahLeft
      AlignVert = avTop
      AlignmentConstraint = AlignmentConstraint1
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      Control = lblDatabaseName
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemODS: TdxLayoutItem
      Parent = dxLayoutGroupDatabase
      AlignHorz = ahLeft
      AlignVert = avTop
      AlignmentConstraint = AlignmentConstraint1
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      Control = lblODS
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemDimensione: TdxLayoutItem
      Parent = dxLayoutGroupDimensioni
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      Control = lblDimensione
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemPagine: TdxLayoutItem
      Parent = dxLayoutGroupDimensioni
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      Control = lblPagine
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemBufferCache: TdxLayoutItem
      Parent = dxLayoutGroupBufferCache
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      Control = lblBufferCache
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemBufferCount: TdxLayoutItem
      Parent = dxLayoutGroupBufferCache
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      Control = lblBufferCount
      ControlOptions.OriginalHeight = 15
      ControlOptions.OriginalWidth = 68
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemCreationDate: TdxLayoutItem
      Parent = dxLayoutGroupCreazione
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      Control = lblCreationDate
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemCreationTime: TdxLayoutItem
      Parent = dxLayoutGroupCreazione
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      Control = lblCreationTime
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object AlignmentConstraint1: TdxLayoutAlignmentConstraint
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 320
    Top = 240
    object KillConnection: TAction
      Caption = 'Termina Connessione'
      ImageIndex = 40
      OnExecute = KillConnectionExecute
    end
    object CancelStatement: TAction
      Caption = 'Annulla Esecuzione'
      ImageIndex = 210
      OnExecute = CancelStatementExecute
    end
    object CancelConnectionStatement: TAction
      Caption = 'Annulla Esecuzione'
      ImageIndex = 210
      OnExecute = CancelConnectionStatementExecute
    end
  end
  object cxImageList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 14680169
    ImageInfo = <
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000002D744558745469746C650044423B536F757263653B5374
          6F723B64617461736F757263653B44617461626173653B4564697428F6BA9C00
          0000BB49444154785EB5D3210EC2301805E029D404D740CCACC95405480C0798
          40A2AB114D7A0D32CB7576869E60820B9437F20224EB3FFE0AC4679ABE97E56D
          AB524A2FC698D9167AB8C1080F1A79D6F3CE3BF75DD0C21DD21ADE6973050324
          A521573015144C7F7982AE60832E577081A3E22DECA09636880C9FA1819A1A9E
          9DE690B5D6410457B24140A0020F89E262036D989C6683AB100E9A0D36521854
          DFC15E0AC3CF7FE1C0C5C332FC2910FF46863D0381AA5C818863F9B53B4FC7D2
          BAA04B4E8F2C0000000049454E44AE426082}
        FileName = 'Grayscale Images\Data\EditDataSource_16x16.png'
        Keywords = 'Data;EditDataSource'
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001F744558745469746C6500437562653B5371756172653B
          456C656D656E743B4974656D3B17B055FD000000B549444154785ED5D3310AC2
          401046E1402020E424012BABC0169203A4F5068220D85A59790FC13695552037
          489B2AAD60E525C687CC3623430C56161FCBF2C3639B4D44E427EF218460E538
          E2AE676E763790618F2724D2FB010B2F90628B07C4A3FB0E990D9C20339C6DA0
          4481662270C312A50D085AAC5467021DE2D6423E03500D0A94B822D8D77901EB
          82B59EA2660410B7FF0854E8BF0CF4A86C20AA31388101B5F717AC0D46DD46BD
          4F7E262BD52D45E2055E1D84C928D972361A0000000049454E44AE426082}
        FileName = 'Grayscale Images\Miscellaneous\Cube_16x16.png'
        Keywords = 'Miscellaneous;Cube'
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000018744558745469746C650054696D656C696E653B576F72
          6B54696D653B44F43FCB000000A749444154785EADD3DD09032110046053443A
          C84BACC1027C4C013671156807166257426C6333C20892B81C9C79F860BD1B06
          F67E8C886C31CE39D18C10E6A4591554C8E0A7820778387E0A181AC1EE06010A
          342A10784F5DA1C28BCDA248CCD491990B3204CE6F886029F29A309339CBF70A
          85A1C8B380A1C873D156B843E36C170596E7C6AC74E705B428385F61A2AE70F5
          217A48DD95D7F884E36F1FD2F6A7BCFF3321B0E503954ECFF5CF8FC54D000000
          0049454E44AE426082}
        FileName = 'Grayscale Images\Scheduling\ShowWorkTimeOnly_16x16.png'
        Keywords = 'Scheduling;ShowWorkTimeOnly'
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001A744558745469746C65005765656B3B566965773B5765
          656B20766965773B5B83154A0000004E49444154785EC591410A004004451DCC
          62EE7FA93F9932646141B2787D492F41003ECC0CC9403AF31ADAF4E94966AC30
          6B2E5082A0CCBEC08E5261561057AD0894D31540245D01CD0AF6DFD8E10202B1
          4F3F196CDD7C0000000049454E44AE426082}
        FileName = 'Grayscale Images\Scheduling\WeekView_16x16.png'
        Keywords = 'Scheduling;WeekView'
      end>
  end
  object styleTytle: TcxEditStyleController
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -19
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Left = 104
    Top = 296
    PixelsPerInch = 96
  end
end
