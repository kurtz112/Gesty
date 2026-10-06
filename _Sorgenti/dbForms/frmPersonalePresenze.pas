unit frmPersonalePresenze;

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
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  System.Actions,
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  zFormController,
  Vcl.StdActns,
  dxFileActions,
  zDbView;

type
  TFormPersonalePresenze = class(TBaseForm)
    ActionList: TActionList;
    ImportaOmniaTime: TdxFileOpen;
    ElaboraOmniaTime: TAction;
    procedure ElaboraOmniaTimeExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImportaOmniaTimeAccept(Sender: TObject);
    procedure Personale_Ore_CedolinoCreateControls(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
  end;

var
  FormPersonalePresenze: TFormPersonalePresenze;

implementation

{$R *.dfm}

uses
  cxFilter,
  zdx,
  zDm_Images,
   
  dmPersonalePresenze;

procedure TFormPersonalePresenze.CreateDataModule;
begin
  inherited;
  CreateDM(TPersonalePresenze, PersonalePresenze);
end;

procedure TFormPersonalePresenze.DestroyDataModule;
begin
  inherited;
  FreeAndNil(PersonalePresenze);
end;

procedure TFormPersonalePresenze.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Personale Presenze';
  ReportGroup := 'PersonalePresenze';
end;

procedure TFormPersonalePresenze.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Presenze') then
    // begin
      // Tools.AddFiltroMese(view, PersonalePresenze.GetDataSet('Presenze'));
      // Tools.AddFiltroAnnoFormativo(view, PersonalePresenze.GetDataSet('Presenze'));
      // view.AddAction(NuovaRichiestaAttivazione, zDmImages.ImageList16).HideInCard;
      // view.InitToolActions;
    // end
    // else
      // if SameText(DataSetName, 'Riepilogo') then
      // begin
        // Tools.AddFiltroMese(view, PersonalePresenze.GetDataSet('Riepilogo'));
        // Tools.AddFiltroAnnoFormativo(view, PersonalePresenze.GetDataSet('Riepilogo'));
        // view.AddAction(NuovaRichiestaAttivazione, zDmImages.ImageList16).HideInCard;
        // view.InitToolActions;
      // end
      // else
        // if SameText(DataSetName, 'Personale_Ore_Cedolino_Elenco') then
        // begin
          // Tools.AddFiltroMese(view, PersonalePresenze.GetDataSet(DataSetName));
          // Tools.AddFiltroAnnoSolare(view, PersonalePresenze.GetDataSet(DataSetName));
// 
          // view.OnAfterCreateControls := Personale_Ore_CedolinoCreateControls;
          // view.AddAction(NuovaRichiestaAttivazione, zDmImages.ImageList16).HideInCard;
          // view.InitToolActions;
        // end
        // else
          // if SameText(DataSetName, 'OMNIATIME_FILES') then
          // begin
            // view.AddAction(ImportaOmniaTime, zDmImages.ImageList16).HideInCard;
            // view.AddAction(ElaboraOmniaTime, zDmImages.ImageList16).HideInCard;
            // view.InitToolActions;
          // end
          // else
            // if SameText(DataSetName, 'Omniatime_Righe') then
            // begin
              // Tools.AddFiltroBoolean(view, PersonalePresenze.GetDataSet(DataSetName), 'ERRORE', 'Errore elaborazione', '', '');
            // end
            // else
              // if SameText(DataSetName, 'Omniatime_Precaricamenti') then
              // begin
                // Tools.AddFiltroBoolean(view, PersonalePresenze.GetDataSet(DataSetName), 'ERRORE', 'Errore elaborazione', '', '');
              // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormPersonalePresenze.ElaboraOmniaTimeExecute(Sender: TObject);
begin
  inherited;
  PersonalePresenze.ElaboraOmniaTime;
end;

procedure TFormPersonalePresenze.ImportaOmniaTimeAccept(Sender: TObject);
var
  id: Integer;
  view: TzDbView;
begin
  inherited;

  id := PersonalePresenze.ImportaOmniaTime(ImportaOmniaTime.Dialog.Files);

  if id <> -1 then
  begin
    view := GetView('OMNIATIME_FILES');
    view.AddFilterCondition('ID_OMNIATIME_FILE', foEqual, id);
  end;
end;

procedure TFormPersonalePresenze.Personale_Ore_CedolinoCreateControls(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;

  // view := GetView('Personale_Ore_Cedolino_Elenco');
  // view.ColumnByName('ORE_CEDOLINO').Styles.Content := dx.cxStyleCream;
end;

procedure TFormPersonalePresenze.SetupComponent(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
begin
  inherited;

  if Component is TzDbView then
  begin
    view := TzDbView(Component);

    if SameText(DataSetName, 'Personale_Ore_Cedolino_Elenco') then
    begin
      view.OnAfterCreateControls := Personale_Ore_CedolinoCreateControls;
    end
    ;
  end;

end;

end.
