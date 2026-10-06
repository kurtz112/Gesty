inherited FormFbExpert: TFormFbExpert
  Caption = 'FormFbExpert'
  ClientHeight = 717
  ClientWidth = 978
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 994
  ExplicitHeight = 756
  TextHeight = 15
  inline zFBExpertFrame: TzFBExpertFrame [1]
    Left = 0
    Top = 0
    Width = 978
    Height = 717
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    ExplicitWidth = 978
    ExplicitHeight = 717
    inherited cxPageControl: TcxPageControl
      Width = 972
      Height = 707
      Properties.ActivePage = zFBExpertFrame.tabEditor
      ExplicitWidth = 972
      ExplicitHeight = 707
      ClientRectBottom = 703
      ClientRectRight = 968
      inherited tabEditor: TcxTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 964
        ExplicitHeight = 678
        inherited editor: TFrameEditor_Sql
          Width = 617
          Height = 678
          ExplicitWidth = 623
          ExplicitHeight = 684
        end
        inherited cxSplitter: TcxSplitter
          Height = 678
          ExplicitHeight = 684
        end
        inherited pnlMetadata: TPanel
          Height = 668
          StyleElements = [seFont, seClient, seBorder]
          ExplicitHeight = 668
          inherited MetaTree: TcxTreeView
            Height = 617
            ExplicitHeight = 617
          end
          inherited edSearch: TcxButtonEdit
            Top = 644
            ExplicitTop = 650
          end
        end
      end
      inherited tabQueryBuilder: TcxTabSheet
        ExplicitLeft = 1
        ExplicitTop = 22
        ExplicitWidth = 899
        ExplicitHeight = 671
      end
      inherited tabConfig: TcxTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 893
        ExplicitHeight = 665
        inherited layoutConfig: TdxLayoutControl
          Width = 893
          Height = 665
          ExplicitWidth = 893
          ExplicitHeight = 665
          inherited inspScript: TcxRTTIInspector
            Left = 54
            Top = 11
            Width = 828
            Height = 174
            ExplicitLeft = 54
            ExplicitTop = 11
            ExplicitWidth = 828
            ExplicitHeight = 174
            Version = 1
          end
          inherited inspGrid: TcxRTTIInspector
            Left = 54
            Top = 199
            Width = 828
            Height = 455
            ExplicitLeft = 54
            ExplicitTop = 199
            ExplicitWidth = 828
            ExplicitHeight = 455
            Version = 1
          end
        end
      end
    end
    inherited cxImageList: TcxImageList
      FormatVersion = 1
    end
    inherited dxBarManager: TdxBarManager
      PixelsPerInch = 96
    end
    inherited metaImages: TcxImageList
      FormatVersion = 1
    end
    inherited dragDropPopup: TdxBarPopupMenu
      PixelsPerInch = 96
    end
    inherited queryBuilder16Images: TcxImageList
      FormatVersion = 1
    end
    inherited queryBuilder32Images: TcxImageList
      FormatVersion = 1
    end
  end
  inherited dxBarManager: TdxBarManager [2]
    PixelsPerInch = 96
    inherited barTitolo: TdxBar
      Visible = False
    end
    inherited barFree: TdxBar
      Visible = False
    end
    inherited barSistema: TdxBar
      Visible = False
    end
  end
  inherited BaseActions: TActionList [3]
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
end
