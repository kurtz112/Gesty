unit CalendarioCorsi.classes;

interface

uses
  System.SysUtils,
  System.classes,
  System.Generics.Collections,
  System.UITypes,
  Vcl.ExtCtrls,
  data.DB,
  cxTL,
  zFbDataSet,
  zz.GenericCollection,
  Gesty.Types;

type
  /// /////////////////////////

  TDocente = class(TCollectionItem)
  private
    FIdDocente: integer;
    FNominativo: string;
  public
    constructor Create(Collection: TCollection); override;

    property IdDocente: integer read FIdDocente write FIdDocente;
    property Nominativo: string read FNominativo write FNominativo;
  end;

  TDocenti = class(TzGenericCollection<TDocente>)
  public
    // function Get(const IdDocente: integer; const Nominativo: string):TDocente;
  end;

  /// /////////////////////////

  TOra = class(TCollectionItem)
  public
    // constructor Create(Collection: TCollection); override;
  end;

  TOre = class(TzGenericCollection<TOra>)
  end;

  /// /////////////////////////

  TGiorno = class(TCollectionItem)
  public
    // constructor Create(Collection: TCollection); override;
  end;

  TGiorni = class(TzGenericCollection<TGiorno>)
  end;

  /// /////////////////////////

  TLezione = class(TCollectionItem)
  public
    // constructor Create(Collection: TCollection); override;
  end;

  TLezioni = class(TzGenericCollection<TLezione>)
  end;

implementation

{ TDocente }

constructor TDocente.Create(Collection: TCollection);
begin
  inherited;
  FIdDocente := -1;
  FNominativo := '';
end;

end.

zdbcarddlg

