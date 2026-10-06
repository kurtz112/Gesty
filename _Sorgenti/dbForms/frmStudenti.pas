unit frmStudenti;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.StdActns,
  Data.DB,
  dxBar,
  dxBarExtItems,
  dxLayoutContainer,
  dxLayoutControl,
  dxFileActions,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxLabel,
  BaseFrm,
  zDbView,
  zFormController,
  zFileViewer,
  Base_DataModule,
  zDbCard,
  zz.Tuples;

type
  TFormStudenti = class(TBaseForm)
    ActionList: TActionList;
    InserimentoStudente: TAction;
    RegistraRitiroStudente: TAction;
    RettificaDataIscrizione: TAction;
    ImportSidi: TdxFileOpen;
    ImportSpaggiari: TdxFileOpen;
    CreaUtenteSistema: TAction;
    ElaboraDomandeIscrizione: TAction;
    ImportDomandeIscrizione: TdxFileOpen;
    procedure CreaUtentiSistemaExecute(Sender: TObject);
    procedure ElaboraDomandeIscrizioneExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImportDomandeIscrizioneAccept(Sender: TObject);
    procedure ImportSidiAccept(Sender: TObject);
    procedure ImportSpaggiariAccept(Sender: TObject);
    procedure InserimentoStudenteExecute(Sender: TObject);
    procedure RegistraRitiroStudenteExecute(Sender: TObject);
    procedure RettificaDataIscrizioneExecute(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetPK(const Value: Variant); override;
  public
  end;

var
  FormStudenti: TFormStudenti;

implementation

uses
  System.IOUtils,
  System.Math,
  cxFilter,
  dmStudenti,
  zHyperLinks,
  Files.Lib,
  zDm_Images,
  WizInserimentoStudenteFrm,
  zMsg,
  zBaseLib,
  zFbDataSet,
  Gesty.Types,
   
  dmCommon;
{$R *.dfm}

procedure TFormStudenti.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
  // card: TzDbCard;
// begin
  // inherited;
// 
  // if Component is TzDbCard then
  // begin
    // card := TzDbCard(Component);
// 
    // if SameText(DataSetName, 'Studenti') then
    // begin
      // card.AddAction(CreaUtenteSistema, zDmImages.ImageList16);
      // card.InitToolActions;
    // end;
  // end
  // else
    // if Component is TzDbView then
    // begin
      // view := TzDbView(Component);
// 
      // if SameText(DataSetName, 'Studenti') then
      // begin
        // view.AddAction(InserimentoStudente, zDmImages.ImageList16);
        // view.AddAction(GeneraDocumentazioneStudenti, zDmImages.ImageList16);
        // view.AddAction(CreaUtenteSistema, zDmImages.ImageList16);
        // view.InitToolActions;
      // end
      // else
        // if SameText(DataSetName, 'Studenti_Corsi') then
        // begin
          // view.AddAction(RettificaDataIscrizione, zDmImages.ImageList16);
          // view.AddAction(RegistraRitiroStudente, zDmImages.ImageList16);
          // view.InitToolActions;
        // end
        // else
          // if SameText(DataSetName, 'Studenti_Tirocini') then
          // begin
            // view.AddAction(GeneraDocumentazioneTirocini, zDmImages.ImageList16);
            // view.InitToolActions;
          // end
          // else
            // if SameText(DataSetName, 'Elenco_Presenze_Studenti') then
            // begin
              // view.AddAction(GeneraDocumentazioneTirocini, zDmImages.ImageList16);
              // Tools.AddFiltroAnnoFormativo(view, Studenti.GetDataSet(DataSetName));
              // view.InitToolActions;
            // end
            // else
              // if SameText(DataSetName, 'Studenti_Domande_Iscrizione_Files') then
              // begin
                // view.AddAction(ImportDomandeIscrizione, zDmImages.ImageList16);
                // view.AddAction(ElaboraDomandeIscrizione, zDmImages.ImageList16);
                // view.InitToolActions;
              // end
              // else
                // if SameText(DataSetName, 'Studenti_Domande_Iscrizione') then
                // begin
                  // Tools.AddFiltroBoolean(view, Studenti.GetDataSet(DataSetName), 'ISCRITTO', 'Iscrizione', 'stato iscrizione', '');
                  // view.InitToolActions;
                // end
                // else
                  // if SameText(DataSetName, 'Miur_Progetti') then
                  // begin
                    // Tools.AddFiltroAnnoFormativo(view, Studenti.GetDataSet(DataSetName));
                  // end;
    // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormStudenti.CreateDataModule;
begin
  inherited;
  CreateDM(TStudenti, Studenti);
end;

procedure TFormStudenti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Studenti);
end;

procedure TFormStudenti.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Studenti';
  Caption := 'Studenti';
end;

procedure TFormStudenti.SetPK(const Value: Variant);
var
  view: TzDbView;
begin
  inherited;
  //
  if pkMode then
  begin
    view := getView('Studenti');
    if assigned(view) then
    begin
      view.ClearFilter(false);
      view.AddFilterCondition('ID_STUDENTE', foEqual, pk);
    end;
  end;
end;

procedure TFormStudenti.InserimentoStudenteExecute(Sender: TObject);
var
  idStudente: integer;
  view: TzDbView;

begin
  inherited;

  idStudente := ApriInserimentoStudente;

  if idStudente = -1 then
    exit;

  view := getView('Studenti');
  if assigned(view) then
  begin
    view.ClearFilter(false);
    view.AddFilterCondition('ID_STUDENTE', foEqual, idStudente);
  end;
end;

procedure TFormStudenti.RegistraRitiroStudenteExecute(Sender: TObject);
begin
  inherited;
  Studenti.RegistraRitiroStudente;
end;

procedure TFormStudenti.RettificaDataIscrizioneExecute(Sender: TObject);
begin
  inherited;
  Studenti.RettificaDataIscrizione;
end;

procedure TFormStudenti.ImportSidiAccept(Sender: TObject);
begin
  inherited;
  Studenti.ImportSidi(ImportSidi.Dialog.FileName);
end;

procedure TFormStudenti.ImportSpaggiariAccept(Sender: TObject);
begin
  inherited;
  Studenti.ImportSpaggiari(ImportSpaggiari.Dialog.FileName);
end;

procedure TFormStudenti.CreaUtentiSistemaExecute(Sender: TObject);
var
  ElencoStudenti: TList<TTuple<integer, string, string>>;
  DataSet: TzFbDataSet;
  studente: TTuple<integer, string, string>;
  view: TzDbView;
begin
  inherited;

  DataSet := GetDataSet('Studenti');
  view := getView('Studenti');

  if view.CardVisible then
    Studenti.CreaUtenteSistema
  else
  begin
    ElencoStudenti := TList < TTuple < integer, string, string >>.Create;
    try
      view.GetSelectedRows(
        procedure
        var
          tupla: TTuple<integer, string, string>;
          idStudente: integer;
          Cognome, Nome: string;
        begin
          idStudente := DataSet.FieldByName('ID_STUDENTE').asInteger;
          Cognome := DataSet.FieldByName('COGNOME').AsString;
          Nome := DataSet.FieldByName('NOME').AsString;

          if DataSet.FieldExists('USER_NAME') then
            if not DataSet.FieldByName('USER_NAME').IsNull then
              exit; // solo da questo studente

          tupla := TTuple<integer, string, string>.Create(idStudente, Cognome, Nome);
          ElencoStudenti.Add(tupla);
        end);

      if ElencoStudenti.Count > 0 then
        Studenti.CreaUtentiSistema(ElencoStudenti)
      else
        ConfirmOk('Nessuno studente selezionato.');
    finally
      FreeAndNil(ElencoStudenti);
    end;
  end;
end;

procedure TFormStudenti.ImportDomandeIscrizioneAccept(Sender: TObject);
var
  id: integer;
  view: TzDbView;
begin
  inherited;

  id := Studenti.ImportDomandeIscrizione(ImportDomandeIscrizione.Dialog.FileName);

  if id <> -1 then
  begin
    view := getView('Studenti_Domande_Iscrizione_Files');

    view.AddFilterCondition('ID_FILE_IMPORT_DOMANDE_ISCRIZIONE', foEqual, id);

    view.ShowRecord(false);
  end;
end;

procedure TFormStudenti.ElaboraDomandeIscrizioneExecute(Sender: TObject);
begin
  inherited;
  Studenti.ElaboraDomandeIscrizione;
end;

initialization

HyperLinks.RegisterHandler('ID_STUDENTE', TFormStudenti);

end.

  zFormController
