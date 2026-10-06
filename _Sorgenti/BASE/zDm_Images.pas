unit zDm_Images;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ImgList,
  ActnList,
  System.ImageList,
  cxGraphics,
  cxImageList;

type
  TzDmImages = class(TDataModule)
    ImageList16: TcxImageList;
    ImageList24: TcxImageList;
    imagesImmobili: TImageList;
    ImagesPartitario: TImageList;
    BaseFormImageList: TcxImageList;
  private
  public
  end;

var
  zDmImages: TzDmImages;

implementation

{$R *.DFM}

end.

  zsystemfrm
