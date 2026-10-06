inherited FormRegistroStudenti: TFormRegistroStudenti
  Caption = 'Registro Presenze Studenti'
  ClientHeight = 393
  ClientWidth = 693
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 709
  ExplicitHeight = 432
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 480
    Top = 80
    object InserimentoStudente: TAction
      Caption = 'Inserimento Studente'
      ImageIndex = 164
    end
    object RettificaDataIscrizione: TAction
      Caption = 'Rettifica Data Iscrizione'
      ImageIndex = 48
    end
    object RegistraRitiroStudente: TAction
      Caption = 'Registra Ritiro Studente'
      ImageIndex = 49
    end
  end
end
