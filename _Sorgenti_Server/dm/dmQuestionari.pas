unit dmQuestionari;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.IB,
  FireDAC.Phys.IBDef,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.StorageJSON,
  FireDAC.Comp.UI,
  FireDAC.Phys.IBBase,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Comp.BatchMove.SQL,
  FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.DataSet,
  Web.HTTPApp,
  lib.Context,
  Route,
  routes.Attributes;

type

  [Path('questionari')]
  TQuestionari = class(TRoute)
    FDStanStorageJSONLink: TFDStanStorageJSONLink;
    Docenti_Eliminare: TFDQuery;
    Sezioni: TFDQuery;
    SezioniSrc: TDataSource;
    Questionario: TFDQuery;
    Voci: TFDQuery;
    VociSrc: TDataSource;
    VociItems: TFDQuery;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [POST('questionario', pkNone)]
    procedure GetQuestionario(ctx: TzContext);
    [POST('risposte', pkNone)]
    procedure SetRisposte(ctx: TzContext);
  end;

implementation

uses
  System.ZLib,
  System.JSON,
  System.Math,
  System.IOUtils,
  System.Generics.Collections,
  // Vcl.Dialogs,
  // Vcl.Graphics,
  // Vcl.Imaging.pngimage,
  zz.Stream,
  zz.SmartInspect,
  zz.Folders,
  lib.Config,
  lib.JsonRest;

{$R *.dfm}

constructor TQuestionari.Create(AOwner: TComponent);
begin
  SiMain.EnterMethod(Self, 'Create');
  inherited;
  SiMain.LeaveMethod(Self, 'Create');
end;

destructor TQuestionari.Destroy;
begin
  SiMain.EnterMethod('TWtGeco.Destroy');
  inherited;
  SiMain.LeaveMethod('TWtGeco.Destroy');
end;

procedure TQuestionari.GetQuestionario(ctx: TzContext);
var
  Identificativo: string;
  JSONObject: TJSONObject;
begin
  SiMain.EnterMethod(Self, 'Questionario');

  Identificativo := ctx.Request.ParamByName('IDENTIFICATIVO');
  SiMain.LogString('Identificativo', Identificativo);

  Connect(ctx);
  try
    InitDataSet(Questionario);
    Questionario.ParamByName('IDENTIFICATIVO').AsString := Identificativo;

    InitDataSet(Sezioni);
    Sezioni.ParamByName('IDENTIFICATIVO').AsString := Identificativo;

    InitDataSet(Voci);
    InitDataSet(VociItems);

    // InitDataSet(Docenti);
    // Docenti.ParamByName('IDENTIFICATIVO').AsString := Identificativo;

    /// //////////////////////////////////////
    JSONObject := TJSONObject.Create;

    /// /////
    Questionario.Active := True;
    try
      JSONObject.AddPair('Questionario', TJsonEngine.DataSetToJSON(Questionario));
    finally
      Questionario.Active := false;
    end;

    Sezioni.Active := True;
    try
      // Docenti.Active := True;
      // try
      Voci.Active := True;
      try
        VociItems.Active := True;
        try
          JSONObject.AddPair('Sezioni', TJsonEngine.DataSetToJSON(Sezioni, [j2doDetailDatasets]));
        finally
          VociItems.Active := false;
        end;
      finally
        Voci.Active := false;
      end;
      // finally
      // Docenti.Active := false;
      // end;
    finally
      Sezioni.Active := false;
    end;
    //
    /// //////////////////////////////////////
    ctx.Response.Render(True, JSONObject);
    /// //////////////////////////////////////
  finally
    Disconnect;
  end;

  SiMain.LeaveMethod(Self, 'Questionario');
end;

procedure TQuestionari.SetRisposte(ctx: TzContext);
var
  checked: Boolean;
  idDocente: Integer;
  s: String;
  o: TJSONObject;
  Questionario: TJSONObject;
  tmp: TJSONObject;
  Sezione: TJSONObject;
  Sezioni: TJSONArray;
  Voce: TJSONObject;
  Voci: TJSONArray;

  Identificativo: string;
  idQuestionario: Integer;

  idRisposta: Integer;
  idVoce: Integer;
  spQuestionario, spVoce, spSaveDone: TFDStoredproc;
  jSezione: TJSONValue;
  jVoce: TJSONValue;
  Valutazione: Integer;

  Item: TJSONObject;
  Items: TJSONArray;
  jItem: TJSONValue;
  Suggerimenti: string;

  function GetInteger(JSONObject: TJSONObject; const Ident: string; const RaiseIfNotExists: Boolean = True): Integer;
  var
    v: TJSONValue;
  begin
    v := JSONObject.FindValue(Ident);

    if not(assigned(v) and (v is TJSONNumber) and JSONObject.tryGetValue<Integer>(Ident, result)) then
    begin
      if RaiseIfNotExists then
        raise Exception.Create('Proprietà ' + Ident + ' non trovata.')
      else
        result := -1;
    end;
  end;

  function GetBoolean(JSONObject: TJSONObject; const Ident: string; const RaiseIfNotExists: Boolean = True): Boolean;
  begin

    if not JSONObject.tryGetValue<Boolean>(Ident, result) then
    begin
      if RaiseIfNotExists then
        raise Exception.Create('Proprietà ' + Ident + ' non trovata.')
      else
        result := false;
    end;
  end;

  function GetString(JSONObject: TJSONObject; const Ident: string; const doRaise: Boolean = True): string;
  begin
    if not JSONObject.tryGetValue<string>(Ident, result) then
      if doRaise then
        raise Exception.Create('Proprietà ' + Ident + ' non trovata.')
  end;

  function GetObject(JSONObject: TJSONObject; const Ident: string): TJSONObject;
  begin
    if not JSONObject.tryGetValue<TJSONObject>(Ident, result) then
      raise Exception.Create('Proprietà ' + Ident + ' non trovata.')
  end;

  function GetArray(JSONObject: TJSONObject; const Ident: string): TJSONArray;
  begin
    if not JSONObject.tryGetValue<TJSONArray>(Ident, result) then
      raise Exception.Create('Proprietà ' + Ident + ' non trovata.')
  end;

begin
  SiMain.EnterMethod(Self, 'Risposte');

  s := ctx.Request.Content;

  // TFile.ReadAllText(TFolders.GetModuleFileName('.json')); // debug
  TFile.WriteAllText(TFolders.GetModuleFileName('.json'), s);

  SiMain.LogString('Content', ctx.Request.Content);

  o := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(s), 0) as TJSONObject;
  try
    if assigned(o) then
    begin
      SiMain.LogString('Result', o.ToString);

      Identificativo := GetString(o, 'IDENTIFICATIVO');
      Questionario := GetObject(o, 'QUESTIONARIO');
      idQuestionario := GetInteger(Questionario, 'ID_QUESTIONARIO');
      Suggerimenti := GetString(Questionario, 'SUGGERIMENTI', false);

      tmp := GetObject(o, 'SEZIONI');
      Sezioni := GetArray(tmp, 'data');

      SiMain.LogString('Identificativo', Identificativo);
      SiMain.LogInteger('idQuestionario', idQuestionario);
      SiMain.LogString('Suggerimenti', Suggerimenti);

      AdminConnect;
      try
        StartTrans;
        try
          // CREATE OR ALTER PROCEDURE QUESTIONARI_RISPOSTE_SAVE (
          // IDENTIFICATIVO GUID,
          // SUGGERIMENTI   MEMO,
          // JSON   MEMO
          // RETURNS (
          // ID_RISPOSTA ID)

          spQuestionario := CreateStoredProc('QUESTIONARI_RISPOSTE_SAVE');
          try
            spQuestionario.ParamByName('IDENTIFICATIVO').AsString := Identificativo;
            spQuestionario.ParamByName('SUGGERIMENTI').AsString := Suggerimenti;
            spQuestionario.ParamByName('JSON').AsString := s;
            spQuestionario.ExecProc;
            try
              idRisposta := spQuestionario.ParamByName('ID_RISPOSTA').asInteger;
            finally
              spQuestionario.Close;
            end;
          finally
            FreeAndNil(spQuestionario);
          end;

          Commit;
        except
          on E: Exception do
          begin
            Rollback;
            raise;
          end;
        end;

        SiMain.LogInteger('IdRisposta', idRisposta);

        /// ////////////////////////////////////////////////////
        ///
        if idRisposta = -1 then
        begin
          ctx.Response.RenderOk;
          Exit;
        end;

        /// ////////////////////////////////////////////////////
        // CREATE OR ALTER PROCEDURE QUESTIONARI_RISPOSTE_SAVE_VOCE (
        // ID_RISPOSTA     ID,
        // ID_QUESTIONARIO ID,
        // ID_SEZIONE      ID,
        // ID_VOCE         ID,
        // RISPOSTA        DESCRIZIONE,
        // ID_DOCENTE      ID,
        // VALORE          SMALL)
        StartTrans;
        try
          spVoce := CreateStoredProc('QUESTIONARI_RISPOSTE_SAVE_VOCE');
          try
            spVoce.ParamByName('ID_RISPOSTA').AsLargeInt := idRisposta;

            for jSezione in Sezioni do
            begin
              Sezione := jSezione as TJSONObject;

              spVoce.ParamByName('ID_QUESTIONARIO').Value := GetInteger(Sezione, 'ID_QUESTIONARIO');
              spVoce.ParamByName('ID_SEZIONE').Value := GetInteger(Sezione, 'ID_SEZIONE');
              spVoce.ParamByName('ID_DOCENTE').Value := GetInteger(Sezione, 'ID_DOCENTE', false);

              Voci := GetArray(Sezione, 'Voci');

              for jVoce in Voci do
              begin
                Voce := jVoce as TJSONObject;

                spVoce.ParamByName('ID_VOCE').Value := GetInteger(Voce, 'ID_VOCE');

                if Voce.tryGetValue<Integer>('VALUTAZIONE', Valutazione) then
                begin
                  spVoce.ParamByName('RISPOSTA').Clear;
                  spVoce.ParamByName('VALORE').Value := Valutazione;
                  spVoce.ExecProc;
                end
                else
                begin
                  Items := GetArray(Voce, 'VociItems');

                  for jItem in Items do
                  begin
                    Item := jItem as TJSONObject;

                    spVoce.ParamByName('RISPOSTA').AsString := GetString(Item, 'RISPOSTA');
                    checked := GetBoolean(Item, 'CHECKED', false);

                    if checked then
                      spVoce.ParamByName('VALORE').Value := 1
                    else
                      spVoce.ParamByName('VALORE').Value := 0;
                    /// ////////////
                    spVoce.ExecProc;
                  end;
                end;
              end;
            end;
          finally
            FreeAndNil(spVoce);
          end;

          // Registra il flag SALVATAGGIO_COMPLETATO su risposte

          spSaveDone := CreateStoredProc('QUESTIONARI_RISPOSTE_SAVE_DONE');
          try
            spSaveDone.ParamByName('ID_RISPOSTA').AsLargeInt := idRisposta;
            spSaveDone.ExecProc;
          finally
            FreeAndNil(spSaveDone);
          end;

          Commit;

          /// ////////////////////////////////////////////////////
        except
          on E: Exception do
          begin
            Rollback;
            raise;
          end;
        end;
      finally;
        Disconnect;
      end;

      ctx.Response.RenderOk;
    end
    else
      raise Exception.Create('Struttura risposta non valida.');
  finally
    FreeAndNil(o);
  end;

  SiMain.LeaveMethod(Self, 'Risposte');
end;

initialization

RegisterClass(TQuestionari);

end.

  QUESTIONARI_GET_SEZ_VOCI_ITEMS zdbcard
