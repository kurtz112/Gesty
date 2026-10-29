object Main: TMain
  Left = 799
  Top = 121
  HelpType = htKeyword
  HelpKeyword = 'MAIN'
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Gesty'
  ClientHeight = 715
  ClientWidth = 1165
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  Position = poDesktopCenter
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 17
  object dxRibbonMain: TdxRibbon
    Left = 0
    Top = 0
    Width = 1165
    Height = 132
    ApplicationButton.Menu = dxBarApplicationMenu
    ApplicationButton.Text = 'File'
    BarManager = dxBarManager
    Style = rsOffice365
    ColorSchemeAccent = rcsaGreen
    ColorSchemeName = 'Colorful'
    PopupMenuItems = []
    CaptionAreaSearchToolbar.Alignment = Right
    CaptionAreaSearchToolbar.Toolbar = dxBarManagerBarTabArea
    SupportNonClientDrawing = True
    Contexts = <>
    TabAreaSearchToolbar.Toolbar = TabAreaSearchToolBar
    TabOrder = 0
    TabStop = False
    object tabHome: TdxRibbonTab
      Caption = 'Home'
      Groups = <
        item
          ToolbarName = 'dxBarManagerBarHome'
        end
        item
          ToolbarName = 'dxBarManagerBar15'
        end>
      Index = 0
    end
    object tabEntiProgetti: TdxRibbonTab
      Caption = 'Enti e Progetti'
      Groups = <
        item
          ToolbarName = 'dxBarManagerBarProgetti'
        end
        item
          ToolbarName = 'dxBarManagerBarAnagrafiche'
        end>
      Index = 1
    end
    object tabRisorse: TdxRibbonTab
      Caption = 'Risorse'
      Groups = <
        item
          Caption = 'Personale'
          ToolbarName = 'dxBarManagerBarRisorse'
        end
        item
          ToolbarName = 'dxBarManagerBarAziende'
        end
        item
          ToolbarName = 'dxBarManagerBar7'
        end
        item
          ToolbarName = 'dxBarManagerBar8'
        end
        item
          ToolbarName = 'dxBarManagerBar6'
        end>
      Index = 2
    end
    object tabFormazione: TdxRibbonTab
      Caption = 'Formazione'
      Groups = <
        item
          ToolbarName = 'dxBarManagerBarStudenti'
        end
        item
          ToolbarName = 'dxBarManagerBarInterventi'
        end
        item
          ToolbarName = 'dxBarManagerBarCorsi'
        end
        item
          ToolbarName = 'dxBarManagerBarRilevamentoAssenze'
        end>
      Index = 3
    end
    object tabAdempimenti: TdxRibbonTab
      Caption = 'Formazione '#183' Adempimenti'
      Groups = <
        item
          ToolbarName = 'dxBarManagerBarAccordoStatoRegioni'
        end
        item
          ToolbarName = 'dxBarManagerBarComunicazioniInail'
        end
        item
          ToolbarName = 'dxBarManagerBarEsiti'
        end
        item
          ToolbarName = 'dxBarManagerBarAdempimenti'
        end
        item
          ToolbarName = 'dxBarManagerBarQuestionari'
        end>
      Index = 4
    end
    object dxRibbonMainTabServiziAllaPersona: TdxRibbonTab
      Active = True
      Caption = 'Servizi alla Persona'
      Groups = <
        item
          ToolbarName = 'dxBarManagerBarAssistenzaScolastica'
        end
        item
          ToolbarName = 'dxBarManagerBarAbitare'
        end
        item
          Caption = 'Servizi Inclusione Adulti'
          ToolbarName = 'dxBarManagerBarSIA'
        end
        item
          ToolbarName = 'dxBarManagerBarDiarioSociale'
        end
        item
          ToolbarName = 'dxBarManagerBarInserimentoLavorativo'
        end
        item
          ToolbarName = 'dxBarManagerBarAssistentiSociali'
        end>
      Index = 5
    end
    object tabContabilita: TdxRibbonTab
      Caption = 'Contabilit'#224
      Groups = <
        item
          ToolbarName = 'dxBarManagerBar2'
        end
        item
          ToolbarName = 'dxBarManagerBarIncassi'
        end
        item
          ToolbarName = 'dxBarManagerBarFattureElettroniche'
        end
        item
          ToolbarName = 'dxBarManagerBarRegistrazioni'
        end
        item
          ToolbarName = 'dxBarManagerBarConfigurazione'
        end
        item
          ToolbarName = 'dxBarManagerBarGateway_Contabile'
        end>
      Index = 6
    end
    object tabDocumentazione: TdxRibbonTab
      Caption = 'Documentazione'
      Groups = <
        item
          ToolbarName = 'dxBarManagerBar1'
        end
        item
          ToolbarName = 'dxBarManagerBar16'
        end
        item
          Caption = 'Motori Documentali'
          ToolbarName = 'dxBarManagerBarDocumentaliMotori'
        end
        item
          ToolbarName = 'dxBarManagerBar17'
        end>
      Index = 7
    end
    object tabAccoglienza: TdxRibbonTab
      Caption = 'Accoglienza e Agende'
      Groups = <
        item
          ToolbarName = 'dxBarManagerBarFrontOffice'
        end
        item
          ToolbarName = 'dxBarManagerBarOrientamento'
        end
        item
          ToolbarName = 'dxBarManagerBarPrenotazioniAule'
        end
        item
          ToolbarName = 'dxBarManagerBarCalendarioDocenti'
        end
        item
          ToolbarName = 'dxBarManagerBarAgenda'
        end>
      Index = 8
    end
    object tabVisualizza: TdxRibbonTab
      Caption = 'Visualizza'
      Groups = <
        item
          ToolbarName = 'dxBarManagerBarVisualizza'
        end>
      Index = 9
    end
  end
  object BaseStatusBar: TdxRibbonStatusBar
    Left = 0
    Top = 690
    Width = 1165
    Height = 25
    Color = clBtnFace
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarToolbarPanelStyle'
        PanelStyle.ToolbarName = 'dxBarManagerBarMDI'
        Width = 37
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 50
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 80
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 150
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 300
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 300
      end>
    Ribbon = dxRibbonMain
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object cxImage: TcxImage
    Left = 330
    Top = 152
    Picture.Data = {
      0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
      2220656E636F64696E673D225554462D38223F3E0D0A3C73766720783D223022
      20793D2230222077696474683D2235313222206865696768743D223531322220
      76657273696F6E3D22312E312220786D6C6E733D22687474703A2F2F7777772E
      77332E6F72672F323030302F7376672220786D6C6E733A786C696E6B3D226874
      74703A2F2F7777772E77332E6F72672F313939392F786C696E6B222076696577
      426F783D223020302035313220353132223E0D0A093C7469746C653E6C656166
      2069636F6E3C2F7469746C653E0D0A093C646573633E6C6561662069636F6E20
      66726F6D207468652049636F6E457870657269656E63652E636F6D20472D436F
      6C6C656374696F6E2E20436F7079726967687420627920494E434F525320476D
      624820287777772E696E636F72732E636F6D292E3C2F646573633E0D0A093C67
      3E0D0A09093C7061746820643D224D3436332E39352C306338312E382C313637
      2E3520372E322C343438202D3232342C343438632D34302E392C30202D37392E
      332C2D31342E39202D3130392E36352C2D33392E3535632D31322E35352C3234
      2E31202D32342E312C35322E38202D33342E332C38372E3535632D362E392C31
      312E31202D32322E39352C31362E31202D33372E322C31332E3835632D31342E
      332C2D322E3235202D32362E38352C2D31312E38202D32362E38352C2D32392E
      38356331392E38352C2D34352E33352034312E322C2D38302E362036332E362C
      2D3130382E39632D31392E382C2D32382E34202D33312E362C2D36322E36202D
      33312E362C2D39392E3163302C2D323536203331322C2D3132302E3220343030
      2C2D3237327A222066696C6C3D2223376362313432222F3E0D0A09093C706174
      6820643D224D3433312E362C3132382E3663302E31352C2D302E3220302E3235
      2C2D302E3420302E33352C2D302E366331392E33352C2D33342E312033322C2D
      37352E352033312E39352C2D3132386338312E382C3136372E3520372E322C34
      3438202D3232342C343438632D34302E392C30202D37392E322C2D31342E3920
      2D3130392E362C2D33392E35632D31322E35352C32342E31202D32342E30352C
      35322E38202D33342E32352C38372E35632D362E39352C31312E31202D32322E
      39352C31362E31202D33372E322C31332E383563302C3020312E372C2D372E33
      20352E31352C2D32312E38356339352E392C2D3236332E37203235352E36352C
      2D3138342E32203336372E362C2D3335392E347A222066696C6C3D2223363839
      643338222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
    Properties.FitMode = ifmProportionalStretch
    Properties.GraphicClassName = 'TdxSmartImage'
    Properties.GraphicTransparency = gtTransparent
    Properties.PopupMenuLayout.MenuItems = []
    Properties.ReadOnly = True
    Properties.ShowFocusRect = False
    Style.BorderStyle = ebsNone
    Style.HotTrack = False
    TabOrder = 2
    Transparent = True
    Visible = False
    OnDblClick = cxImageDblClick
    Height = 516
    Width = 516
  end
  object ActionList: TActionList
    Images = dx.Immagini
    OnUpdate = ActionListUpdate
    Left = 58
    Top = 218
    object AggiornaProgressivi: TAction
      Caption = 'Aggiorna Progressivi'
      ImageIndex = 345
      OnExecute = AggiornaProgressiviExecute
      OnUpdate = ActionUpdateAdmin
    end
    object Esci: TAction
      Caption = 'Esci'
      ImageIndex = 954
      OnExecute = EsciExecute
    end
    object Sistema: TAction
      Caption = 'Sistema'
      ImageIndex = 1217
      OnExecute = SistemaExecute
    end
    object WindowCloseAll: TAction
      Category = 'Window'
      Caption = 'Chiudi Tutto'
      Hint = 'chiude tutte le form'
      ImageIndex = 1000
      OnExecute = WindowCloseAllExecute
      OnUpdate = WindowActionUpdate
    end
    object Login: TAction
      Caption = 'Login'
      OnExecute = LoginExecute
    end
    object LoadZip: TAction
      Caption = 'Carica impostazioni'
      ImageIndex = 521
      OnExecute = LoadZipExecute
    end
    object SaveZip: TAction
      Caption = 'Salva Impostazioni'
      ImageIndex = 524
      OnExecute = SaveZipExecute
    end
    object actRicaricaPolitiche: TAction
      Caption = 'Ricarica Permessi'
      ImageIndex = 510
      OnExecute = actRicaricaPoliticheExecute
    end
    object actCambiaPassword: TAction
      Caption = 'Cambia Password'
      ImageIndex = 955
      OnExecute = actCambiaPasswordExecute
    end
    object actAppAutenticazione: TAction
      Caption = 'App di Autenticazione'
      Hint = 'Attiva il codice dal telefono al posto del codice via mail'
      ImageIndex = 955
      Visible = False
      OnExecute = actAppAutenticazioneExecute
    end
    object actCodiciRecupero: TAction
      Caption = 'Nuovi Codici di Recupero'
      Hint = 'Genera nuovi codici di recupero per l'#39'app di autenticazione'
      ImageIndex = 955
      Visible = False
      OnExecute = actCodiciRecuperoExecute
    end
    object actGestioneUtenti: TAction
      Caption = 'Gestione Utenti'
      ImageIndex = 973
      OnExecute = actGestioneUtentiExecute
    end
    object WindowClose: TAction
      Category = 'Window'
      Caption = 'Chiudi'
      Enabled = False
      Hint = 'chuidi form corrente'
      ImageIndex = 953
      OnExecute = WindowCloseExecute
      OnUpdate = WindowActionUpdate
    end
    object WindowCascade: TAction
      Category = 'Window'
      Caption = 'Cascata'
      Enabled = False
      Hint = 'disponi le form a cascata'
      ImageIndex = 999
      OnExecute = WindowCascadeExecute
      OnUpdate = WindowActionUpdate
    end
    object WindowTileHorizontal: TAction
      Category = 'Window'
      Caption = 'Aggiusta Orizzontalmente'
      Enabled = False
      Hint = 'disponi affiancate orizzontalmente'
      ImageIndex = 997
      OnExecute = WindowTileHorizontalExecute
      OnUpdate = WindowActionUpdate
    end
    object WindowTileVertical: TAction
      Category = 'Window'
      Caption = 'Aggiusta Verticalmente'
      Enabled = False
      Hint = 'disponi affiancate verticalmente'
      ImageIndex = 998
      OnExecute = WindowTileVerticalExecute
      OnUpdate = WindowActionUpdate
    end
    object WindowMinimizeAll: TAction
      Category = 'Window'
      Caption = 'Minimizza Tutto'
      Enabled = False
      Hint = 'minimizza tutte le finestre'
      ImageIndex = 1002
      OnExecute = WindowMinimizeAllExecute
      OnUpdate = WindowActionUpdate
    end
    object actPoliticheAccessi: TAction
      Caption = 'Gestione Permessi'
      ImageIndex = 1221
      OnExecute = actPoliticheAccessiExecute
    end
    object Adatta: TAction
      Category = 'Window'
      Caption = 'Adatta'
      Enabled = False
      ImageIndex = 996
      OnExecute = AdattaExecute
      OnUpdate = WindowActionUpdate
    end
    object actPermessiAzione: TAction
      Caption = 'Permessi'
      ImageIndex = 1221
      OnExecute = actPermessiAzioneExecute
    end
    object actStatoAttivazioneModulo: TAction
      Caption = 'Attivazione Modulo'
      ImageIndex = 1216
      OnExecute = actStatoAttivazioneModuloExecute
    end
    object actDizionari: TAction
      Caption = 'Dizionari'
      ImageIndex = 1218
      OnExecute = actDizionariExecute
    end
    object actDownloadAggiornamento: TAction
      Caption = 'Download Aggiornamento'
      ImageIndex = 969
      OnExecute = actDownloadAggiornamentoExecute
    end
    object ConfigurazioneLog: TAction
      Caption = 'Configurazione Log'
      ImageIndex = 1015
      OnExecute = ConfigurazioneLogExecute
      OnUpdate = ActionUpdateAdmin
    end
    object actPatchLzDaFile: TAction
      Caption = 'Da file...'
      Hint = 'Applica una patch JSON al dizionario LZ leggendola da un file'
      ImageIndex = 34
      OnExecute = actPatchLzDaFileExecute
      OnUpdate = ActionUpdateAdmin
    end
    object actPatchLzDagliAppunti: TAction
      Caption = 'Dagli appunti'
      Hint = 'Applica la patch JSON del dizionario LZ copiata negli appunti'
      ImageIndex = 1223
      OnExecute = actPatchLzDagliAppuntiExecute
      OnUpdate = ActionUpdateAdmin
    end
    object actTip: TAction
      Caption = 'Tip'
      ImageIndex = 1229
      OnExecute = actTipExecute
    end
    object Riconnessione: TAction
      Caption = 'Riconnessione'
      ImageIndex = 988
      OnExecute = RiconnessioneExecute
    end
    object FbExpert: TAction
      Caption = 'FbExpert'
      ImageIndex = 1219
      OnExecute = FbExpertExecute
      OnUpdate = ActionUpdateAdmin
    end
    object MonitorFB: TAction
      Caption = 'Monitor FB'
      ImageIndex = 1014
      OnExecute = MonitorFBExecute
      OnUpdate = ActionUpdateAdmin
    end
    object ProfilerFB: TAction
      Caption = 'Profiler FB'
      ImageIndex = 482
      OnExecute = ProfilerFBExecute
      OnUpdate = ActionUpdateAdmin
    end
    object MonitorFireDAC: TAction
      Caption = 'Monitor FireDAC'
      ImageIndex = 1220
      OnExecute = MonitorFireDACExecute
      OnUpdate = ActionUpdateAdmin
    end
    object BaseWeb: TAction
      Caption = 'BaseWeb'
      ImageIndex = 877
      OnExecute = BaseWebExecute
      OnUpdate = ActionUpdateAdmin
    end
    object AttivaLog: TAction
      Caption = 'Attiva Log'
      ImageIndex = 1017
      ShortCut = 24652
      OnExecute = AttivaLogExecute
    end
    object SegnalibroLog: TAction
      Caption = 'Segnalibro Log'
      ImageIndex = 1018
      ShortCut = 24659
      OnExecute = SegnalibroLogExecute
    end
    object RegistraDalProssimoAvvio: TAction
      Caption = 'Registra dal prossimo avvio'
      ImageIndex = 1016
      OnExecute = RegistraDalProssimoAvvioExecute
    end
    object TicketAssistenza: TAction
      Caption = 'Le mie segnalazioni'
      Hint = 'Stato e risposte delle richieste di assistenza inviate'
      ImageIndex = 1222
      OnExecute = TicketAssistenzaExecute
    end
    object actAI: TAction
      Caption = 'actAI'
      ImageIndex = 967
      OnExecute = actAIExecute
      OnUpdate = actAIUpdate
    end
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
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
    ImageOptions.Images = dx.Immagini
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <
      item
      end>
    UseSystemFont = True
    OnBarVisibleChange = dxBarManagerBarVisibleChange
    OnShowToolbarsPopup = dxBarManagerShowToolbarsPopup
    Left = 58
    Top = 160
    PixelsPerInch = 96
    object dxBarManagerBarHome: TdxBar
      Caption = 'Home'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1123
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButtonPersonaleScheda'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton16'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButtonNotifiche'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarAnagrafiche: TdxBar
      Caption = 'Anagrafiche'
      CaptionButtons = <>
      DockedLeft = 180
      DockedTop = 0
      FloatLeft = 1123
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton28'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarLargeButton29'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton34'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarLargeButtonTabelle'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton48'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarMDI: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'ToolbarMDI'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 0
      FloatTop = 8
      FloatClientWidth = 51
      FloatClientHeight = 66
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItemElencoForm'
        end>
      NotDocking = [dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarStudenti: TdxBar
      Caption = 'Studenti'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1123
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton13'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton14'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarLargeButton4'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarRisorse: TdxBar
      Caption = 'Personale'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1123
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButtonRisorse'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton9'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object TabAreaSearchToolBar: TdxBar
      Caption = 'TabAreaSearchToolBar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1248
      FloatTop = 2
      FloatClientWidth = 175
      FloatClientHeight = 22
      ItemLinks = <
        item
          Visible = True
          ItemName = 'beOfficeSearchBox'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarEsiti: TdxBar
      Caption = 'Esiti'
      CaptionButtons = <>
      DockedLeft = 276
      DockedTop = 0
      FloatLeft = 1117
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton60'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarQuestionari: TdxBar
      Caption = 'Questionari'
      CaptionButtons = <>
      DockedLeft = 521
      DockedTop = 0
      FloatLeft = 1117
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton11'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarComunicazioniInail: TdxBar
      Caption = 'Comunicazioni INAIL'
      CaptionButtons = <>
      DockedLeft = 142
      DockedTop = 0
      FloatLeft = 1190
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton19'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarAccordoStatoRegioni: TdxBar
      Caption = 'Accordo Stato-Regioni'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1158
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton61'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarRilevamentoAssenze: TdxBar
      Caption = 'Rilevamento Presenze/Assenze'
      CaptionButtons = <>
      DockedLeft = 766
      DockedTop = 0
      FloatLeft = 1178
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton43'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarAdempimenti: TdxBar
      Caption = 'Rendicontazione'
      CaptionButtons = <>
      DockedLeft = 358
      DockedTop = 0
      FloatLeft = 1190
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton12'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton17'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarPrenotazioniAule: TdxBar
      Caption = 'Prenotazioni Aule'
      CaptionButtons = <>
      DockedLeft = 85
      DockedTop = 0
      FloatLeft = 1190
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton18'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton51'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarInserimentoLavorativo: TdxBar
      Caption = 'Servizi Al Lavoro'
      CaptionButtons = <>
      DockedLeft = 597
      DockedTop = 0
      FloatLeft = 1190
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton47'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton20'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarAssistentiSociali: TdxBar
      Caption = 'Assistenti Sociali'
      CaptionButtons = <>
      DockedLeft = 761
      DockedTop = 0
      FloatLeft = 1190
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton72'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarVisualizza: TdxBar
      Caption = 'Visualizza'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1190
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton26'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton21'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton22'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton23'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton24'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton25'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarCalendarioDocenti: TdxBar
      Caption = 'Calendario Docenti'
      CaptionButtons = <>
      DockedLeft = 262
      DockedTop = 0
      FloatLeft = 1190
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton27'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton58'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarAgenda: TdxBar
      Caption = 'Scadenze e Riunioni'
      CaptionButtons = <>
      DockedLeft = 428
      DockedTop = 0
      FloatLeft = 1190
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton33'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton32'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar6: TdxBar
      Caption = 'Richieste Attivazione'
      CaptionButtons = <>
      DockedLeft = 721
      DockedTop = 0
      FloatLeft = 1178
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton36'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButtonInserimentoPersonale'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarLargeButton46'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar7: TdxBar
      Caption = 'Attivit'#224
      CaptionButtons = <>
      DockedLeft = 238
      DockedTop = 0
      FloatLeft = 1178
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButtonInserimentoIncarico'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton54'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButtonRilevamentoOre'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton57'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton44'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarAssistenzaScolastica: TdxBar
      Caption = 'Assistenza Scolastica'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1178
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton40'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton41'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarAbitare: TdxBar
      Caption = 'Abitare'
      CaptionButtons = <>
      DockedLeft = 196
      DockedTop = 0
      FloatLeft = 1178
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton49'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton42'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarDiarioSociale: TdxBar
      Caption = 'Diario Sociale'
      CaptionButtons = <>
      DockedLeft = 504
      DockedTop = 0
      FloatLeft = 1178
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton3'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar8: TdxBar
      Caption = 'Presenze'
      CaptionButtons = <>
      DockedLeft = 632
      DockedTop = 0
      FloatLeft = 1178
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton1'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarInterventi: TdxBar
      Caption = 'Interventi'
      CaptionButtons = <>
      DockedLeft = 301
      DockedTop = 0
      FloatLeft = 1178
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton37'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton38'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton59'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarFrontOffice: TdxBar
      Caption = 'Front Office'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1178
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton45'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarAziende: TdxBar
      Caption = 'Aziende'
      CaptionButtons = <>
      DockedLeft = 148
      DockedTop = 0
      FloatLeft = 1178
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton50'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarTabArea: TdxBar
      Caption = 'TabArea'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1162
      FloatTop = 2
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButtonRegistrazioneInCorso'
        end
        item
          Visible = True
          ItemName = 'dxBarProgressTempoResiduo'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonSegnalibroBarra'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonPausaFilmato'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonNotifiche'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxSkinChooserGalleryItem'
        end
        item
          Visible = True
          ItemName = 'dxRibbonSkinSelector'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton17'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarSIA: TdxBar
      Caption = 'Custom 4'
      CaptionButtons = <>
      DockedLeft = 357
      DockedTop = 0
      FloatLeft = 1158
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton56'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarProgetti: TdxBar
      Caption = 'Progetti'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1158
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton5'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton35'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton30'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarCorsi: TdxBar
      Caption = 'Corsi'
      CaptionButtons = <>
      DockedLeft = 535
      DockedTop = 0
      FloatLeft = 1158
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton6'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton31'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton8'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar15: TdxBar
      Caption = 'Aspetto'
      CaptionButtons = <>
      DockedLeft = 211
      DockedTop = 0
      FloatLeft = 1158
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxSkinChooserGalleryItem'
        end
        item
          Visible = True
          ItemName = 'dxRibbonSkinSelector'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar16: TdxBar
      Caption = 'Allegati'
      CaptionButtons = <>
      DockedLeft = 109
      DockedTop = 0
      FloatLeft = 1158
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton15'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar17: TdxBar
      Caption = 'Registro Messaggi'
      CaptionButtons = <>
      DockedLeft = 523
      DockedTop = 0
      FloatLeft = 1158
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton62'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarOrientamento: TdxBar
      Caption = 'Orientamento'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1123
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButtonOrientamento'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarDocumentaliMotori: TdxBar
      Caption = 'Motori Documentali'
      CaptionButtons = <>
      DockedLeft = 187
      DockedTop = 0
      FloatLeft = 1158
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton63'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButtonRegistroFirma'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarLargeButtonRegistroProtocollo'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarLargeButtonRegistroConservazione'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar1: TdxBar
      Caption = 'Cruscotto'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1158
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton52'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      Caption = 'Documenti'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1193
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton64'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarIncassi: TdxBar
      Caption = 'Incassi'
      CaptionButtons = <>
      DockedLeft = 97
      DockedTop = 0
      FloatLeft = 1193
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton65'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarFattureElettroniche: TdxBar
      Caption = 'Fatture Elettroniche'
      CaptionButtons = <>
      DockedLeft = 170
      DockedTop = 0
      FloatLeft = 1193
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton66'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarRegistrazioni: TdxBar
      Caption = 'Registrazioni Contabili'
      CaptionButtons = <>
      DockedLeft = 295
      DockedTop = 0
      FloatLeft = 1193
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton67'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton68'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarConfigurazione: TdxBar
      Caption = 'Configurazione'
      CaptionButtons = <>
      DockedLeft = 458
      DockedTop = 0
      FloatLeft = 1193
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton69'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton70'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarGateway_Contabile: TdxBar
      Caption = 'Gateway Contabile'
      CaptionButtons = <>
      DockedLeft = 641
      DockedTop = 0
      FloatLeft = 1193
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton71'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarSubItemSistema: TdxBarSubItem
      Caption = 'Sistema'
      Category = 0
      Visible = ivAlways
      ImageIndex = 1217
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButtonSistema'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItemPatchLz'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItemUtentiPermessi'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItemSviluppo'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonAggiornaProgressivi'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end>
    end
    object dxBarSubItemUtentiPermessi: TdxBarSubItem
      Caption = 'Utenti e permessi'
      Category = 0
      Visible = ivAlways
      ImageIndex = 973
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButtonGestioneUtenti'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonGestionePermessi'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonRicaricaPolitiche'
        end>
    end
    object dxBarSubItemSviluppo: TdxBarSubItem
      Caption = 'Strumenti di sviluppo'
      Category = 0
      Visible = ivAlways
      ImageIndex = 515
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton55'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton15'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarLargeButton53'
        end
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end
        item
          Visible = True
          ItemName = 'dxBarButton14'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonConfigurazioneLog'
        end>
    end
    object dxBarButtonTabelle: TdxBarButton
      Action = Tabelle
      Category = 0
    end
    object dxBarButtonConfigurazioneLog: TdxBarButton
      Action = ConfigurazioneLog
      Category = 0
    end
    object dxBarSubItemPatchLz: TdxBarSubItem
      Caption = 'Applica patch dizionario LZ'
      Category = 0
      Visible = ivAlways
      ImageIndex = 19
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButtonPatchLzDaFile'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonPatchLzDagliAppunti'
        end>
    end
    object dxBarButtonPatchLzDaFile: TdxBarButton
      Action = actPatchLzDaFile
      Category = 0
    end
    object dxBarButtonPatchLzDagliAppunti: TdxBarButton
      Action = actPatchLzDagliAppunti
      Category = 0
    end
    object dxBarLargeButtonTabelle: TdxBarLargeButton
      Action = Tabelle
      Category = 0
    end
    object dxBarLargeButtonRisorse: TdxBarLargeButton
      Action = Risorse
      Category = 0
    end
    object dxBarButtonGestioneUtenti: TdxBarButton
      Action = actGestioneUtenti
      Category = 0
    end
    object dxBarButtonGestionePermessi: TdxBarButton
      Action = actPoliticheAccessi
      Category = 0
    end
    object dxBarButtonCambiaPassword: TdxBarButton
      Action = actCambiaPassword
      Category = 0
    end
    object dxBarButtonAppAutenticazione: TdxBarButton
      Action = actAppAutenticazione
      Category = 0
    end
    object dxBarButtonCodiciRecupero: TdxBarButton
      Action = actCodiciRecupero
      Category = 0
    end
    object dxBarButtonRicaricaPolitiche: TdxBarButton
      Action = actRicaricaPolitiche
      Category = 0
    end
    object dxBarLargeButtonInserimentoPersonale: TdxBarLargeButton
      Action = NuovaRichiestaAttivazione
      Category = 0
    end
    object dxBarLargeButtonInserimentoIncarico: TdxBarLargeButton
      Action = InserimentoIncarico
      Category = 0
    end
    object dxBarLargeButtonRilevamentoOre: TdxBarLargeButton
      Action = RilevamentoOre
      Category = 0
    end
    object dxBarButtonCartellaProgetto: TdxBarButton
      Action = Budget
      Category = 0
    end
    object dxBarLargeButtonPersonaleScheda: TdxBarLargeButton
      Action = PersonaleScheda
      Category = 0
    end
    object dxBarLargeButtonNotifiche: TdxBarLargeButton
      Action = Notifiche
      Category = 0
    end
    object dxBarButtonAggiornaProgressivi: TdxBarButton
      Action = AggiornaProgressivi
      Category = 0
    end
    object dxBarButtonSistema: TdxBarButton
      Action = Sistema
      Category = 0
    end
    object dxBarButtonLoadZip: TdxBarButton
      Action = LoadZip
      Category = 0
    end
    object dxBarButtonSaveZip: TdxBarButton
      Action = SaveZip
      Category = 0
    end
    object dxBarButtonEsci: TdxBarButton
      Action = Esci
      Category = 0
    end
    object dxBarButtonLogin: TdxBarButton
      Action = Login
      Category = 0
      ImageIndex = 1215
    end
    object dxBarButtonChiudiTutto: TdxBarButton
      Action = WindowCloseAll
      Category = 0
    end
    object dxBarLargeButton1: TdxBarLargeButton
      Action = PresenzePersonale
      Category = 0
    end
    object dxBarLargeButton2: TdxBarLargeButton
      Action = Studenti
      Caption = 'Destinatari Corsi'
      Category = 0
    end
    object dxBarLargeButton4: TdxBarLargeButton
      Action = RegistrazionePagamenti
      Caption = 'Pagamenti'
      Category = 0
    end
    object dxSkinChooserGalleryItem: TdxSkinChooserGalleryItem
      Caption = 'Seleziona Aspetto'
      Category = 0
      Visible = ivNever
      GalleryOptions.ItemAllowDeselect = True
      VisibleLookAndFeelStyles = [lfsFlat, lfsStandard, lfsUltraFlat, lfsNative, lfsOffice11, lfsSkin]
      OnSkinChanged = dxSkinChooserGalleryItemSkinChanged
      Glyph.SourceHeight = 16
      Glyph.SourceWidth = 16
      ImageIndex = 952
      LargeImageIndex = 952
      ItemLinks = <>
      ItemOptions.ShowDescriptions = True
    end
    object dxBarLargeButton5: TdxBarLargeButton
      Action = Progetti
      Caption = 'Progetti  Servizi'
      Category = 0
    end
    object dxBarLargeButton6: TdxBarLargeButton
      Action = Orario
      Caption = 'Calendario Corsi'
      Category = 0
    end
    object dxBarLargeButton8: TdxBarLargeButton
      Action = RegistroStudenti
      Category = 0
    end
    object beOfficeSearchBox: TcxBarEditItem
      Caption = 'Cerca Azione'
      Category = 0
      Hint = 'cerca'
      KeyTip = 'Q'
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TdxOfficeSearchBoxProperties'
      Properties.BarManager = dxBarManager
      Properties.Glyph.SourceDPI = 96
      Properties.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001A744558745469746C650053756767657374696F6E3B496465613B4C
        616D701B5C59110000025F49444154785E85934B4854511CC6BF3B8ECE183DD4
        02C5DC2559B93162126A510811B68A16B66AD3A64DD426C3E8411845221A2411
        213D445AB410A274550A61168186086A334EEA8C8EE3D83C6C66EEF3DC734EE7
        84792B2FF5C1C7F973BFFBFFF13FE770C039978654E4C161B92893ED818699CE
        83AFC39D8158A8E3406CBAADAEFFC38DDA63000A642EECF4FD0E9061F05EFDD5
        E8D346AE065F72AA26B82D9C17F5ECA3063E7A736F3B804209F905F0C09132D1
        1668282E2D6BDD71A809BE9D0170460066C12FEA8AA36750565575E96DF3AE26
        C0E9F3C291C75F885B5B6BAA3DCC0883E6AA00F0F590E93328A9A9C6B6F9B98B
        00FA84E9DF00059CD7166EDF0CAE4EC1FEAEC1E3AB8414B3E2E06C16C595FBE0
        2D60756B67810D004EA918C312B182027F1194220E8083912230F14DF1110162
        1052D6C7862358944E5B892580507033013BF55E78043096019B415F8C4033D9
        84A4BA4DC0169246EBA6D1D040F9FE7210E30B1CAD40F19520391E412C63F600
        20AE80131DA1C1772DD5F7BD5E72614B19C0890129C5EB432E9D47782AF5FC74
        77E29904B86D810B5B47EE86AF2FCFAB537A7C15DC02B470129AA8E783996063
        575CDE8026CCDD009868DD2D03339327836ACA00CDADC2CEEA50533A52393204
        40FFD45C4E21E40AE8C135B9D05EFDECD8AB8AC7F85A3F8CFE3D7DE8326FE3E1
        F2A93100F69DC57370073862D1B9E9B19595CCFA6DE5B2792C45433F013621FF
        05F0E1372F16D2E9CC3755D361125B00B2C9C9F1A1A8CC88FD0F00B529CE5FE9
        E6008C5864E6F293DE81F4C791CFE9F862B8058076FC643397FFFC21E7356E00
        FB854BA5D76A8F5BDF0F47CC49F47EBE179B0000000049454E44AE426082}
      Properties.Ribbon = dxRibbonMain
      Properties.SearchSource = dxBarManager
      Properties.ShowResultPaths = True
    end
    object dxBarLargeButton9: TdxBarLargeButton
      Action = Valutazioni
      Category = 0
    end
    object dxBarLargeButton10: TdxBarLargeButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarLargeButton11: TdxBarLargeButton
      Action = Questionari
      Category = 0
    end
    object dxBarLargeButton12: TdxBarLargeButton
      Action = ExportRegione
      Caption = 'Export GRPA'
      Category = 0
    end
    object dxBarLargeButton13: TdxBarLargeButton
      Action = PianiIndividuali
      Category = 0
    end
    object dxBarLargeButton14: TdxBarLargeButton
      Action = Tirocini
      Category = 0
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      PropertiesClassName = 'TcxCheckGroupProperties'
      Properties.Items = <
        item
          Caption = 'aaaa'
        end
        item
          Caption = 'nbbbbbb'
        end
        item
          Caption = 'ccccc'
        end>
    end
    object dxBarLargeButton16: TdxBarLargeButton
      Action = Agenda
      Category = 0
    end
    object dxBarLargeButton17: TdxBarLargeButton
      Action = GRS
      Caption = 'Import/Export GRS'
      Category = 0
    end
    object dxBarLargeButton19: TdxBarLargeButton
      Action = Inail
      Category = 0
    end
    object dxBarLargeButton18: TdxBarLargeButton
      Action = PrenotazioniAule
      Category = 0
    end
    object dxBarLargeButton20: TdxBarLargeButton
      Action = InserimentoLavorativo
      Category = 0
    end
    object dxBarLargeButton7: TdxBarLargeButton
      Action = WindowClose
      Category = 0
    end
    object dxBarLargeButton21: TdxBarLargeButton
      Action = WindowCascade
      Category = 0
    end
    object dxBarLargeButton22: TdxBarLargeButton
      Action = WindowTileHorizontal
      Category = 0
    end
    object dxBarLargeButton23: TdxBarLargeButton
      Action = WindowTileVertical
      Category = 0
    end
    object dxBarLargeButton24: TdxBarLargeButton
      Action = WindowMinimizeAll
      Category = 0
    end
    object dxBarLargeButton25: TdxBarLargeButton
      Action = Adatta
      Category = 0
    end
    object dxBarLargeButton26: TdxBarLargeButton
      Action = WindowCloseAll
      Category = 0
    end
    object dxBarLargeButton27: TdxBarLargeButton
      Action = CalendarioDocenti
      Category = 0
    end
    object dxBarLargeButton28: TdxBarLargeButton
      Action = Enti
      Category = 0
    end
    object dxBarLargeButton29: TdxBarLargeButton
      Action = Aule
      Category = 0
    end
    object dxBarLargeButton30: TdxBarLargeButton
      Action = Bandi
      Category = 0
      DropDownMenu = popActions
    end
    object dxBarButton1: TdxBarButton
      Action = actPermessiAzione
      Category = 0
    end
    object dxBarLargeButton31: TdxBarLargeButton
      Action = CalendarioAvvioCorsi
      Category = 0
    end
    object dxBarLargeButton32: TdxBarLargeButton
      Action = Riunioni
      Category = 0
    end
    object dxBarSubItemElencoForm: TdxBarSubItem
      Caption = '0'
      Category = 0
      Visible = ivAlways
      ImageIndex = 1001
      ItemLinks = <>
    end
    object dxBarLargeButton33: TdxBarLargeButton
      Action = Scadenze
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = actDizionari
      Category = 0
    end
    object dxBarSubItemControlloOrtografico: TdxBarSubItem
      Caption = 'Controllo Ortografico'
      Category = 0
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000017744558745469746C65005370656C6C436865636B3B5370656C6C3B
        53FC4602000002E349444154785E65927F48936B14C71F9DBFCA19DDA925534B
        9D3A6D9BDBEB720ABAAE9BEE75BB2A9A9699962204A636B2A566D245B952C1D4
        98FD7060964ED3A20CEE3547F68722256AA2E62F340B94B21FE294A4A4A86B9E
        DE07DED1C60E1C5E5EF83C9FF33D0F0F9290258A28D5799028CE92FE3CE5F648
        653944269C03715CB16A978FD09190A9E5118A52D84F960242C81E0090652309
        0587CBD4A911641950024F0C7204C9FE62450978ED8D700B8FD3E0832E543B50
        6D6723C0A01F4FE54F819420914DC8CF00212B0681B4B0D2831DF68730F63416
        3885C5AA112E1B818882451484415FAEC28F02614F488248F0E72970670BDCF9
        078AB080892578059C02A7A1FF1908833EDCF8600C7A07C97D79D242E0490B20
        589273C8DD5BE81A28CE2643A3F30137967805495CD32B7BDA73752340AA0D7F
        E1548ED868F175A6DB819EC6A0EF609B2F5FC64AAF7CD2D534F00E7ADE6C4076
        EDD0EF5D70656B07D1FCFF80E67E6CA1D9EF5B68E6DB4F34F57513E1E89CA834
        4F6AF240F3F07BE89C5B873C6D3F08536AFFB612D0D39CE834F6E6C3DEFB6259
        072F189FB68F2DC3DDE935286A1886B0942B068A71B3143048758BEA58DD1024
        971BBB88240D875E8599A079D87573E02DB48C99A0BC630A84A9D7469C99BB3D
        B0DC52E092553308C685CFD03EFA018E54F77D8AC9A93F292F686BAC33BE02C3
        B809AAFE7D0592CC9B1F77711379F88EF8297A642970921CD5EB4ED40F42EB84
        097A97BE80A669146ABAE7E1CEE42A5CEA5904695EDB265B785C4927B30B4DBC
        6125B0C3718934DDF5DCDA6750D3BB04FFBD5E07C38B15A87EBC08A91546F08B
        2ED36206B3F767D7105779D54A80E887B2839FA4D5675DEE87AAEE05A87CB400
        F9FAE7C0915D1CA7004FCCDC9B594577264D2888D4590BC49906B364E73EE5C5
        C68CEA3E287BF01244690D1BAC00528AD7EC985E45AD132BE8D6E8320A8CBF62
        2D20329A1171F8B659C20A21FF698AC9EF04365150618ECE91D7A1008BB610D8
        1403AF43C766D2529BFA05BA6881B1E52780230000000049454E44AE426082}
      ItemLinks = <>
    end
    object dxBarLargeButton35: TdxBarLargeButton
      Action = Budget
      Category = 0
    end
    object dxBarLargeButton36: TdxBarLargeButton
      Action = RichiesteAttivazione
      Category = 0
    end
    object dxBarLargeButton37: TdxBarLargeButton
      Action = Sostegno
      Category = 0
    end
    object dxBarLargeButton38: TdxBarLargeButton
      Action = InterventiIntegrativi
      Category = 0
    end
    object dxBarLargeButton39: TdxBarLargeButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarLargeButton40: TdxBarLargeButton
      Action = AssistenzaScolastica
      Category = 0
    end
    object dxBarLargeButton41: TdxBarLargeButton
      Action = AS_Rendicontazione
      Category = 0
    end
    object dxBarLargeButton42: TdxBarLargeButton
      Action = AbitareEmergenza
      Category = 0
    end
    object dxBarLargeButton43: TdxBarLargeButton
      Action = RilevamentoAssenzeStudenti
      Category = 0
    end
    object dxBarLargeButton3: TdxBarLargeButton
      Action = DiarioSociale
      Category = 0
    end
    object dxBarLargeButton44: TdxBarLargeButton
      Action = AnalisiRilevamenti
      Category = 0
    end
    object dxBarLargeButton34: TdxBarLargeButton
      Action = Attrezzature
      Category = 0
    end
    object dxBarLargeButton45: TdxBarLargeButton
      Action = FrontOffice
      Category = 0
    end
    object dxBarLargeButton46: TdxBarLargeButton
      Action = Candidature
      Category = 0
    end
    object dxBarLargeButton47: TdxBarLargeButton
      Action = ServiziAlLavoro
      Category = 0
    end
    object dxBarLargeButton72: TdxBarLargeButton
      Action = AssistentiSociali
      Category = 0
    end
    object dxBarLargeButton48: TdxBarLargeButton
      Action = Anagrafiche
      Category = 0
    end
    object dxBarLargeButton49: TdxBarLargeButton
      Action = AbitareSostegno
      Category = 0
    end
    object dxBarLargeButton50: TdxBarLargeButton
      Action = Aziende
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = Agenda
      Category = 0
    end
    object dxBarButton4: TdxBarButton
      Action = PersonaleScheda
      Category = 0
    end
    object dxBarButtonNotifiche: TdxBarButton
      Action = Notifiche
      Category = 0
    end
    object dxBarButton5: TdxBarButton
      Action = Notifiche
      Category = 0
    end
    object dxBarButton6: TdxBarButton
      Action = Agenda
      Category = 0
    end
    object dxBarButton7: TdxBarButton
      Action = PersonaleScheda
      Category = 0
    end
    object dxBarButton8: TdxBarButton
      Action = actStatoAttivazioneModulo
      Category = 0
    end
    object dxBarLargeButton51: TdxBarLargeButton
      Action = CalendarioAule
      Category = 0
    end
    object dxBarButton9: TdxBarButton
      Action = actDownloadAggiornamento
      Category = 0
    end
    object dxBarLargeButton53: TdxBarLargeButton
      Action = MonitorFireDAC
      Category = 0
    end
    object dxBarLargeButton54: TdxBarLargeButton
      Action = Contratti
      Category = 0
    end
    object dxBarLargeButton55: TdxBarLargeButton
      Action = FbExpert
      Category = 0
    end
    object dxBarLargeButton56: TdxBarLargeButton
      Action = ServizioInclusioneAdulti
      Category = 0
    end
    object dxBarButtonAttivaLog: TdxBarButton
      Action = AttivaLog
      Category = 0
      ButtonStyle = bsChecked
    end
    object dxBarButtonRegistrazioneInCorso: TdxBarButton
      Caption = 'REC'
      Category = 0
      Hint = 'Registrazione per l'#39'assistenza in corso'
      Visible = ivNever
      ImageIndex = 1017
      PaintStyle = psCaptionGlyph
      OnClick = dxBarButtonRegistrazioneInCorsoClick
    end
    object dxBarProgressTempoResiduo: TdxBarProgressItem
      Caption = 'restano'
      Category = 0
      Visible = ivNever
      ShowCaption = True
      Width = 80
    end
    object dxBarButtonSegnalibroBarra: TdxBarButton
      Caption = 'Segnalibro'
      Category = 0
      Hint = 'Segna questo momento nel log, con una riga che dice cosa e'#39' successo'
      Visible = ivNever
      ImageIndex = 1018
      PaintStyle = psCaptionGlyph
      OnClick = dxBarButtonSegnalibroBarraClick
    end
    object dxBarButtonPausaFilmato: TdxBarButton
      Caption = 'Pausa filmato'
      Category = 0
      Hint =
        'Sospende il filmato senza fermare il log: per le schermate che non vuoi mandare all'#39'assistenza'
      Visible = ivNever
      ButtonStyle = bsChecked
      OnClick = dxBarButtonPausaFilmatoClick
    end
    object dxBarLargeButton57: TdxBarLargeButton
      Action = Timesheet
      Category = 0
    end
    object dxBarLargeButton58: TdxBarLargeButton
      Action = AttivitaFuoriSede
      Category = 0
    end
    object dxBarLargeButton59: TdxBarLargeButton
      Action = FormazioneInterna
      Category = 0
    end
    object dxBarButton11: TdxBarButton
      Action = actTip
      Category = 0
    end
    object dxBarButton12: TdxBarButton
      Action = Riconnessione
      Category = 0
    end
    object dxBarButton13: TdxBarButton
      Action = MonitorFB
      Category = 0
    end
    object dxBarButton14: TdxBarButton
      Action = ProfilerFB
      Category = 0
    end
    object dxBarButton15: TdxBarButton
      Action = BaseWeb
      Category = 0
    end
    object dxBarLargeButton60: TdxBarLargeButton
      Action = Attestati
      Category = 0
    end
    object dxBarLargeButton61: TdxBarLargeButton
      Action = AccordoStatoRegioni
      Category = 0
    end
    object dxRibbonSkinSelector: TdxRibbonSkinSelector
      Caption = 'Colori'
      Category = 0
      Hint = 'Colori'
      Visible = ivAlways
      SkinChooserOptions.Visible = ivNever
      SkinChooserOptions.VisibleLookAndFeelStyles = [lfsFlat, lfsStandard, lfsUltraFlat, lfsNative, lfsOffice11, lfsSkin]
      SkinChooserOptions.VisibleGroups = [Vector, LookAndFeelStyles, Office, Default, LatestOfficeSkins, VisualStudio, PreviousOfficeSkins, ThematicFlat, Seasonal, Thematic, RetroFlat, Retro3D, Custom, Common]
      OnPaletteChanged = dxRibbonSkinSelectorPaletteChanged
      OnSetSkin = dxRibbonSkinSelectorSetSkin
    end
    object dxBarLargeButton15: TdxBarLargeButton
      Action = Allegati
      Category = 0
    end
    object dxBarLargeButton62: TdxBarLargeButton
      Action = RegistroMessaggi
      Category = 0
    end
    object dxBarLargeButtonOrientamento: TdxBarLargeButton
      Action = Orientamento
      Category = 0
    end
    object dxBarLargeButtonRegistroFirma: TdxBarLargeButton
      Action = RegistroFirma
      Category = 0
    end
    object dxBarLargeButtonRegistroProtocollo: TdxBarLargeButton
      Action = RegistroProtocollo
      Category = 0
    end
    object dxBarLargeButtonRegistroConservazione: TdxBarLargeButton
      Action = RegistroConservazione
      Category = 0
    end
    object dxBarLargeButton52: TdxBarLargeButton
      Action = CruscottoDocumentale
      Category = 0
      SyncImageIndex = False
      ImageIndex = 971
    end
    object dxBarLargeButton63: TdxBarLargeButton
      Action = FirmaDocumenti
      Category = 0
      SyncImageIndex = False
      ImageIndex = 1224
    end
    object dxBarButtonSegnalibroLog: TdxBarButton
      Action = SegnalibroLog
      Category = 0
    end
    object dxBarButtonRegistraDalProssimoAvvio: TdxBarButton
      Action = RegistraDalProssimoAvvio
      Category = 0
      ButtonStyle = bsChecked
    end
    object dxBarButtonTicketAssistenza: TdxBarButton
      Action = TicketAssistenza
      Category = 0
    end
    object dxBarSubItemAssistenza: TdxBarSubItem
      Caption = 'Assistenza'
      Category = 0
      Visible = ivAlways
      ImageIndex = 1033
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButtonTicketAssistenza'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonAttivaLog'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonSegnalibroLog'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonRegistraDalProssimoAvvio'
        end>
    end
    object dxBarLargeButton64: TdxBarLargeButton
      Action = CoGe_Documenti
      Category = 0
    end
    object dxBarLargeButton65: TdxBarLargeButton
      Action = CoGe_Incassi
      Category = 0
      SyncImageIndex = False
      ImageIndex = -1
    end
    object dxBarLargeButton66: TdxBarLargeButton
      Action = CoGe_FattureElettroniche
      Category = 0
      SyncImageIndex = False
      ImageIndex = 977
    end
    object dxBarLargeButton67: TdxBarLargeButton
      Action = CoGe_Registrazioni
      Category = 0
      SyncImageIndex = False
      ImageIndex = 981
    end
    object dxBarLargeButton68: TdxBarLargeButton
      Action = CoGe_Bilancio
      Category = 0
    end
    object dxBarLargeButton69: TdxBarLargeButton
      Action = CoGe_Soggetti
      Category = 0
      SyncImageIndex = False
      ImageIndex = -1
    end
    object dxBarLargeButton70: TdxBarLargeButton
      Action = CoGe_Configurazione
      Category = 0
    end
    object dxBarLargeButton71: TdxBarLargeButton
      Action = CoGe_Gateway_Contabile
      Category = 0
    end
    object dxBarButton17: TdxBarButton
      Action = actAI
      Category = 0
    end
  end
  object File1: TdxBarSubItem
    Caption = 'File'
    Category = -1
    Visible = ivAlways
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButtonLogin'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButtonEsci'
      end>
  end
  object Quantita1: TdxBarSubItem
    Caption = 'Quantit'#224
    Category = -1
    Visible = ivAlways
    ItemLinks = <>
  end
  object Tariffa1: TdxBarSubItem
    Caption = 'Tariffe'
    Category = -1
    Visible = ivAlways
    ItemLinks = <>
  end
  object Fatturazione1: TdxBarSubItem
    Caption = 'Documenti'
    Category = -1
    Visible = ivAlways
    ItemLinks = <>
  end
  object Incassi1: TdxBarSubItem
    Caption = 'Incassi'
    Category = -1
    Visible = ivAlways
    ItemLinks = <>
  end
  object Contabilit1: TdxBarSubItem
    Caption = 'Contabilit'#224
    Category = -1
    Visible = ivAlways
    ItemLinks = <>
  end
  object Partitario1: TdxBarSubItem
    Caption = 'Partitario'
    Category = -1
    Visible = ivAlways
    ItemLinks = <>
  end
  object Utilit1: TdxBarSubItem
    Caption = 'Utilit'#224
    Category = -1
    Visible = ivAlways
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButtonAggiornaProgressivi'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButtonSistema'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButtonLoadZip'
      end
      item
        Visible = True
        ItemName = 'dxBarButtonSaveZip'
      end>
  end
  object Finestre1: TdxBarSubItem
    Caption = 'Finestre'
    Category = -1
    Visible = ivAlways
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButtonChiudiTutto'
      end>
  end
  object Help1: TdxBarSubItem
    Caption = 'Help'
    Category = -1
    Visible = ivAlways
    ItemLinks = <>
  end
  object dxBarApplicationMenu: TdxBarApplicationMenu
    BarManager = dxBarManager
    Buttons = <
      item
        Item = dxBarButtonLogin
      end
      item
        Item = dxBarButtonEsci
      end>
    ExtraPane.Items = <>
    ExtraPane.Visible = False
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButton5'
      end
      item
        Visible = True
        ItemName = 'dxBarButton6'
      end
      item
        Visible = True
        ItemName = 'dxBarButton7'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButtonTabelle'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton12'
      end
      item
        Visible = True
        ItemName = 'dxBarButtonLoadZip'
      end
      item
        Visible = True
        ItemName = 'dxBarButton9'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarSubItemAssistenza'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarSubItemSistema'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxSkinChooserGalleryItem'
      end
      item
        Visible = True
        ItemName = 'dxBarButtonCambiaPassword'
      end
      item
        Visible = True
        ItemName = 'dxBarButtonAppAutenticazione'
      end
      item
        Visible = True
        ItemName = 'dxBarButtonCodiciRecupero'
      end
      item
        Visible = True
        ItemName = 'dxBarButtonEsci'
      end>
    UseOwnFont = False
    Left = 58
    Top = 276
    PixelsPerInch = 96
  end
  object ModuliActions: TActionList
    Images = dx.Immagini
    OnExecute = ModuliActionsExecute
    Left = 192
    Top = 160
    object CruscottoDocumentale: TAction
      Category = 'Documentazione'
      Caption = 'Cruscotto Documentale'
      ImageIndex = 971
      OnExecute = CruscottoDocumentaleExecute
    end
    object Orientamento: TAction
      Category = 'Orientamento'
      Caption = 'Orientamento'
      ImageIndex = 545
      OnExecute = OrientamentoExecute
    end
    object FirmaDocumenti: TAction
      Category = 'Documentazione'
      Caption = 'Firma Documenti'
      ImageIndex = 1224
      OnExecute = FirmaDocumentiExecute
    end
    object RegistroFirma: TAction
      Category = 'Documentazione'
      Caption = 'Registro Firma'
      ImageIndex = 985
      OnExecute = RegistroFirmaExecute
    end
    object RegistroProtocollo: TAction
      Category = 'Documentazione'
      Caption = 'Registro Protocollo'
      ImageIndex = 987
      OnExecute = RegistroProtocolloExecute
    end
    object RegistroConservazione: TAction
      Category = 'Documentazione'
      Caption = 'Registro Conservazione'
      ImageIndex = 984
      OnExecute = RegistroConservazioneExecute
    end
    object Budget: TAction
      Category = 'Enti e Progetti'
      Caption = 'Budget'
      ImageIndex = 993
      OnExecute = BudgetExecute
    end
    object Progetti: TAction
      Category = 'Enti e Progetti'
      Caption = 'Progetti/Servizi'
      ImageIndex = 995
      OnExecute = ProgettiExecute
    end
    object Studenti: TAction
      Category = 'Formazione'
      Caption = 'Partecipanti Corsi'
      ImageIndex = 1005
      OnExecute = StudentiExecute
    end
    object Tabelle: TAction
      Category = 'Enti e Progetti'
      Caption = 'Tabelle'
      ImageIndex = 1043
      OnExecute = TabelleExecute
    end
    object Agenda: TAction
      Category = 'Home'
      Caption = 'Agenda'
      ImageIndex = 956
      OnExecute = AgendaExecute
    end
    object PersonaleScheda: TAction
      Category = 'Home'
      Caption = 'Scheda Personale'
      ImageIndex = 989
      OnExecute = PersonaleSchedaExecute
    end
    object NuovaRichiestaAttivazione: TAction
      Category = 'Risorse'
      Caption = 'Nuova Richiesta Attivazione'
      ImageIndex = 1027
      OnExecute = NuovaRichiestaAttivazioneExecute
    end
    object InserimentoIncarico: TAction
      Category = 'Risorse'
      Caption = 'Inserimento Incarico'
      ImageIndex = 1026
      OnExecute = InserimentoIncaricoExecute
    end
    object RilevamentoOre: TAction
      Category = 'Risorse'
      Caption = 'Rilevamento Ore'
      ImageIndex = 1030
      OnExecute = RilevamentoOreExecute
    end
    object PresenzePersonale: TAction
      Category = 'Risorse'
      Caption = 'Presenze Personale'
      ImageIndex = 1028
      OnExecute = PresenzePersonaleExecute
    end
    object Risorse: TAction
      Category = 'Risorse'
      Caption = 'Elenco Risorse'
      ImageIndex = 1025
      OnExecute = RisorseExecute
    end
    object RilevamentoAssenzeStudenti: TAction
      Category = 'Formazione'
      Caption = 'Rilevamento Presenze/Assenze (Vecchio Metodo)'
      ImageIndex = 1010
      OnExecute = RilevamentoAssenzeStudentiExecute
    end
    object RegistrazionePagamenti: TAction
      Category = 'Formazione'
      Caption = 'Registrazione Pagamenti'
      ImageIndex = 1008
      OnExecute = RegistrazionePagamentiExecute
    end
    object Orario: TAction
      Category = 'Formazione'
      Caption = 'Orario'
      ImageIndex = 1004
      OnExecute = OrarioExecute
    end
    object InserimentoLavorativo: TAction
      Category = 'Servizi alla Persona'
      Caption = 'Inserimento Lavorativo'
      ImageIndex = 1042
      OnExecute = InserimentoLavorativoExecute
    end
    object RegistroStudenti: TAction
      Category = 'Formazione'
      Caption = 'Registro Studenti'
      ImageIndex = 1011
      OnExecute = RegistroStudentiExecute
    end
    object Valutazioni: TAction
      Category = 'Risorse'
      Caption = 'Valutazioni'
      ImageIndex = 1032
      OnExecute = ValutazioniExecute
    end
    object Questionari: TAction
      Category = 'Formazione '#183' Adempimenti'
      Caption = 'Questionari'
      ImageIndex = 962
      OnExecute = QuestionariExecute
    end
    object Tirocini: TAction
      Category = 'Formazione'
      Caption = 'Tirocini Stage'
      ImageIndex = 1013
      OnExecute = TirociniExecute
    end
    object PianiIndividuali: TAction
      Category = 'Formazione'
      Caption = 'Piani Individuali'
      ImageIndex = 1009
      OnExecute = PianiIndividualiExecute
    end
    object ExportRegione: TAction
      Category = 'Formazione '#183' Adempimenti'
      Caption = 'Export Regione'
      ImageIndex = 959
      OnExecute = ExportRegioneExecute
    end
    object RegistroMessaggi: TAction
      Category = 'Documentazione'
      Caption = 'Registro Messaggi'
      ImageIndex = 986
      OnExecute = RegistroMessaggiExecute
    end
    object Allegati: TAction
      Category = 'Documentazione'
      Caption = 'Allegati'
      ImageIndex = 983
      OnExecute = AllegatiExecute
    end
    object GRS: TAction
      Category = 'Formazione '#183' Adempimenti'
      Caption = 'GRS'
      ImageIndex = 960
      OnExecute = GRSExecute
    end
    object Inail: TAction
      Category = 'Formazione '#183' Adempimenti'
      Caption = 'Comunicazioni INAIL'
      ImageIndex = 961
      OnExecute = InailExecute
    end
    object Aule: TAction
      Category = 'Enti e Progetti'
      Caption = 'Aule/Spazi'
      ImageIndex = 991
      OnExecute = AuleExecute
    end
    object PrenotazioniAule: TAction
      Category = 'Accoglienza e Agende'
      Caption = 'Prenotazioni Aule'
      ImageIndex = 1020
      OnExecute = PrenotazioniAuleExecute
    end
    object CalendarioAule: TAction
      Category = 'Accoglienza e Agende'
      Caption = 'Calendario Aule'
      ImageIndex = 963
      OnExecute = CalendarioAuleExecute
    end
    object CalendarioDocenti: TAction
      Category = 'Accoglienza e Agende'
      Caption = 'Calendario Docenti'
      ImageIndex = 972
      OnExecute = CalendarioDocentiExecute
    end
    object Enti: TAction
      Category = 'Enti e Progetti'
      Caption = 'Enti Formativi'
      ImageIndex = 994
      OnExecute = EntiExecute
    end
    object Bandi: TAction
      Category = 'Enti e Progetti'
      Caption = 'Bandi'
      ImageIndex = 992
      OnExecute = BandiExecute
    end
    object CalendarioAvvioCorsi: TAction
      Category = 'Formazione'
      Caption = 'Calendario Avvio Corsi'
      ImageIndex = 1003
      OnExecute = CalendarioAvvioCorsiExecute
    end
    object Riunioni: TAction
      Category = 'Accoglienza e Agende'
      Caption = 'Riunioni'
      ImageIndex = 1019
      OnExecute = RiunioniExecute
    end
    object Scadenze: TAction
      Category = 'Accoglienza e Agende'
      Caption = 'Scadenze'
      ImageIndex = 966
      OnExecute = ScadenzeExecute
    end
    object Attrezzature: TAction
      Category = 'Enti e Progetti'
      Caption = 'Attrezzature'
      ImageIndex = 990
      OnExecute = AttrezzatureExecute
    end
    object RichiesteAttivazione: TAction
      Category = 'Risorse'
      Caption = 'Richieste Attivazione'
      ImageIndex = 1029
      OnExecute = RichiesteAttivazioneExecute
    end
    object Sostegno: TAction
      Category = 'Formazione'
      Caption = 'Sostegno'
      ImageIndex = 1012
      OnExecute = SostegnoExecute
    end
    object InterventiIntegrativi: TAction
      Category = 'Formazione'
      Caption = 'Interventi Integrativi'
      ImageIndex = 1007
      OnExecute = InterventiIntegrativiExecute
    end
    object AssistenzaScolastica: TAction
      Category = 'Servizi alla Persona'
      Caption = 'Assistenza Scolastica'
      ImageIndex = 1039
      OnExecute = AssistenzaScolasticaExecute
    end
    object AS_Rendicontazione: TAction
      Category = 'Servizi alla Persona'
      Caption = 'A.S. Rendicontazione'
      ImageIndex = 1037
      OnExecute = AS_RendicontazioneExecute
    end
    object AbitareEmergenza: TAction
      Category = 'Servizi alla Persona'
      Caption = 'Abitare - Emergenza'
      ImageIndex = 1034
      OnExecute = AbitareEmergenzaExecute
    end
    object AbitareSostegno: TAction
      Category = 'Servizi alla Persona'
      Caption = 'Abitare - Sostegno'
      ImageIndex = 1035
      OnExecute = AbitareSostegnoExecute
    end
    object DiarioSociale: TAction
      Category = 'Servizi alla Persona'
      Caption = 'Diario Sociale'
      ImageIndex = 1040
      OnExecute = DiarioSocialeExecute
    end
    object AnalisiRilevamenti: TAction
      Category = 'Risorse'
      Caption = 'Analisi Rilevamenti'
      ImageIndex = 1021
      OnExecute = AnalisiRilevamentiExecute
    end
    object FrontOffice: TAction
      Category = 'Accoglienza e Agende'
      Caption = 'Front Office'
      ImageIndex = 964
      OnExecute = FrontOfficeExecute
    end
    object Candidature: TAction
      Category = 'Risorse'
      Caption = 'Candidature'
      ImageIndex = 1023
      OnExecute = CandidatureExecute
    end
    object ServizioInclusioneAdulti: TAction
      Category = 'Servizi alla Persona'
      Caption = 'Servizio Inclusione Adulti'
      ImageIndex = 1041
      OnExecute = ServizioInclusioneAdultiExecute
    end
    object AssistentiSociali: TAction
      Category = 'Servizi alla Persona'
      Caption = 'Assistenti Sociali'
      ImageIndex = 1038
      OnExecute = AssistentiSocialiExecute
    end
    object ServiziAlLavoro: TAction
      Category = 'Servizi alla Persona'
      Caption = 'Servizi Al Lavoro'
      ImageIndex = 1036
      OnExecute = ServiziAlLavoroExecute
    end
    object Anagrafiche: TAction
      Category = 'Enti e Progetti'
      Caption = 'Anagrafiche'
      ImageIndex = 970
      OnExecute = AnagraficheExecute
    end
    object Aziende: TAction
      Category = 'Risorse'
      Caption = 'Cruscotto Aziende'
      ImageIndex = 1022
      OnExecute = AziendeExecute
    end
    object Notifiche: TAction
      Category = 'Home'
      Caption = 'Notifiche'
      ImageIndex = 1093
      OnExecute = NotificheExecute
    end
    object Contratti: TAction
      Category = 'Risorse'
      Caption = 'Contratti'
      ImageIndex = 1024
      OnExecute = ContrattiExecute
    end
    object Timesheet: TAction
      Category = 'Risorse'
      Caption = 'Timesheet'
      ImageIndex = 1031
      OnExecute = TimesheetExecute
    end
    object AttivitaFuoriSede: TAction
      Category = 'Accoglienza e Agende'
      Caption = 'Attivit'#224' Fuori Sede'
      ImageIndex = 965
      OnExecute = AttivitaFuoriSedeExecute
    end
    object FormazioneInterna: TAction
      Category = 'Formazione'
      Caption = 'Formazione Interna'
      ImageIndex = 1006
      OnExecute = FormazioneInternaExecute
    end
    object AccordoStatoRegioni: TAction
      Category = 'Formazione '#183' Adempimenti'
      Caption = 'Accordo Stato Regioni'
      ImageIndex = 957
      OnExecute = AccordoStatoRegioniExecute
    end
    object Attestati: TAction
      Category = 'Formazione '#183' Adempimenti'
      Caption = 'Attestati'
      ImageIndex = 958
      OnExecute = AttestatiExecute
    end
    object CoGe_Bilancio: TAction
      Category = 'CoGe'
      Caption = 'Bilancio'
      ImageIndex = 974
      OnExecute = CoGe_BilancioExecute
    end
    object CoGe_Configurazione: TAction
      Category = 'CoGe'
      Caption = 'Configurazione Contabilit'#224
      ImageIndex = 975
      OnExecute = CoGe_ConfigurazioneExecute
    end
    object CoGe_Documenti: TAction
      Category = 'CoGe'
      Caption = 'Documenti'
      ImageIndex = 976
      OnExecute = CoGe_DocumentiExecute
    end
    object CoGe_FattureElettroniche: TAction
      Category = 'CoGe'
      Caption = 'Fatture Elettroniche'
      ImageIndex = 977
      OnExecute = CoGe_FattureElettronicheExecute
    end
    object CoGe_Incassi: TAction
      Category = 'CoGe'
      Caption = 'Incassi'
      ImageIndex = 980
      OnExecute = CoGe_IncassiExecute
    end
    object CoGe_Registrazioni: TAction
      Category = 'CoGe'
      Caption = 'Registrazioni Contabili'
      ImageIndex = 981
      OnExecute = CoGe_RegistrazioniExecute
    end
    object CoGe_Soggetti: TAction
      Category = 'CoGe'
      Caption = 'Soggetti Contabili'
      ImageIndex = 982
      OnExecute = CoGe_SoggettiExecute
    end
    object CoGe_Gateway_Contabile: TAction
      Category = 'CoGe'
      Caption = 'Gateway Contabile'
      ImageIndex = 979
      OnExecute = CoGe_Gateway_ContabileExecute
    end
  end
  object popActions: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton11'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton8'
      end>
    UseOwnFont = False
    OnPopup = popActionsPopup
    Left = 58
    Top = 334
    PixelsPerInch = 96
  end
  object dxUIAdornerManager: TdxUIAdornerManager
    Badges.Active = True
    Badges.Color = clRed
    Badges.Font.Charset = ANSI_CHARSET
    Badges.Font.Color = clWindow
    Badges.Font.Height = -13
    Badges.Font.Name = 'Segoe UI'
    Badges.Font.Style = []
    Badges.ParentFont = False
    Left = 58
    Top = 453
    object dxUIAdornerManager1Badge: TdxBadge
      TargetElementClassName = 'TdxAdornerTargetElementPath'
      TargetElement.Path = 'dxBarManager.dxBarManagerBarTabArea.dxBarButtonNotifiche'
      Visible = False
      OnClick = dxUIAdornerManager1BadgeClick
      Text = '0'
    end
  end
  object TimerStartup: TTimer
    Enabled = False
    Interval = 1800
    OnTimer = TimerStartupTimer
    Left = 58
    Top = 395
  end
  object TimerRegistrazione: TTimer
    Enabled = False
    OnTimer = TimerRegistrazioneTimer
    Left = 58
    Top = 451
  end
  object ModuliStyleRepository: TcxStyleRepository
    Left = 192
    Top = 216
    PixelsPerInch = 96
    object cxStyleValutazione: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsItalic]
      TextColor = clGrayText
    end
    object cxStyleNonAbilitato: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsItalic]
      TextColor = clGrayText
    end
    object cxStyleInSviluppo: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsItalic]
      TextColor = clGrayText
    end
  end
  object dxScreenTipRepository: TdxScreenTipRepository
    Left = 58
    Top = 512
    PixelsPerInch = 96
  end
end
