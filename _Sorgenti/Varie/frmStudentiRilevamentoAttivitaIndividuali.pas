unit frmStudentiRilevamentoAttivitaIndividuali;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  OkCancel,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  dxLayoutcxEditAdapters,
  cxContainer,
  cxEdit,
  cxDropDownEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  dxLayoutContainer,
  cxTextEdit,
  cxMaskEdit,
  cxSpinEdit,
  cxClasses,
  dxLayoutControl,
  dxRibbonForm, cxDBExtLookupComboBox;

type
  TFormStudentiRilevamentoAttivitaIndividuali = class(TdxRibbonForm)
    OkCancel: TOkCancel;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutControl: TdxLayoutControl;
    edOrePresenza: TcxSpinEdit;
    dxLayoutItemOrePresenza: TdxLayoutItem;
    edMateria: TcxExtLookupComboBox;
    dxLayoutItemMateria: TdxLayoutItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private

  public
    function Edit(out Ore: double; out Materia: string): Boolean;
  end;

function ApriFormStudentiRilevamentoAttivitaIndividuali(out Ore: double; out Materia: string): Boolean;

implementation

uses
  zDX, dmStudentiRilevamentoPresenzeAssenze, zBaseLib, zMsg;

{$R *.dfm}

function ApriFormStudentiRilevamentoAttivitaIndividuali(out Ore: double; out Materia: string): Boolean;
var
  FormStudentiRilevamentoAttivitaIndividuali: TFormStudentiRilevamentoAttivitaIndividuali;
begin

  Application.CreateForm(TFormStudentiRilevamentoAttivitaIndividuali, FormStudentiRilevamentoAttivitaIndividuali);
  try
    result := FormStudentiRilevamentoAttivitaIndividuali.Edit(Ore, Materia);
  finally
    FreeAndNil(FormStudentiRilevamentoAttivitaIndividuali);
  end;
end;

procedure TFormStudentiRilevamentoAttivitaIndividuali.FormCreate(Sender: TObject);
begin
  dx.InitLayoutControl(dxLayoutControl);

  dx.InitLookup('', edMateria, StudentiRilevamentoPresenzeAssenze.lkMaterie, StudentiRilevamentoPresenzeAssenze.lkMaterieSrc, 'MATERIA', 'MATERIA');
end;

function TFormStudentiRilevamentoAttivitaIndividuali.Edit(out Ore: double; out Materia: string): Boolean;
begin
  //
  StudentiRilevamentoPresenzeAssenze.lkMaterie.RevertSQL(True);
  try
    edOrePresenza.EditValue := 0;
    edMateria.Clear;

    Self.PopupParent := Screen.ActiveForm;

    ActiveControl := edOrePresenza;

    result := ShowModal = mrOk;

    if result then
    begin
      Ore := dx.ValueDouble(edOrePresenza);
      Materia := dx.ValueStr(edMateria);
    end;

  finally
    StudentiRilevamentoPresenzeAssenze.lkMaterie.Active := False;
  end;
end;

procedure TFormStudentiRilevamentoAttivitaIndividuali.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Ore: double;
begin

  if ModalResult = mrCancel then
  begin
    CanClose := True;
    exit;
  end;

  Ore := dx.ValueDouble(edOrePresenza);

  CanClose := Ore > 0;

  if not CanClose then
    ConfirmOk('Ore presenza non specificate.');

  // valutare se la materia deve essere obbligatoria
  // Materia := dx.ValueStr(edMateria);
end;

end.
