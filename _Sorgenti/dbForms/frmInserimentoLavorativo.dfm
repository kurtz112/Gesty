inherited FormInserimentoLavorativo: TFormInserimentoLavorativo
  Caption = 'FormInserimentoLavorativo'
  ClientHeight = 464
  OnCreate = FormCreate
  ExplicitHeight = 503
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 296
    Top = 160
    object RicercaProfili: TAction
      Caption = 'Ricerca Profili'
      ImageIndex = 94
      OnExecute = RicercaProfiliExecute
    end
    object PianificaColloquio: TAction
      Caption = 'Pianifica Colloquio'
      ImageIndex = 180
      OnExecute = PianificaColloquioExecute
    end
    object ProponiCandidato: TAction
      Caption = 'Proponi Candidato'
      ImageIndex = 93
      OnExecute = ProponiCandidatoExecute
    end
  end
end
