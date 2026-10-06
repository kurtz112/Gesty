unit DevExtreme_SaveProps;

interface

implementation

uses
  System.SysUtils,
  System.JSON,
  Vcl.Clipbrd,
  Vcl.Dialogs,
  Data.DB,
  FireDAC.DatS,
  zBaseLib,
  zSystem,
  zDbView,
  zDbCard,
  zFbDataSet,
  Gesty_StoredProcs;

procedure SaveDataset(const id: string; zFbDataSet: TzFbDataSet; canInsert, canUpdate, canDelete: boolean);
var
  sp: TSP_ZZ_WEB_DATASETS_SET;
  spField: TSP_ZZ_WEB_DATASETS_FIELDS_ADD;
  idDataSet: string;
  zDataSet: TzDataSet;
  field: TField;
  FDDatSColumn: TFDDatSColumn;
  Idx: Integer;
begin

  if not assigned(zFbDataSet) then
    exit;

  idDataSet := base.Get_IdDataSet(zFbDataSet);

  if trim(idDataSet) = '' then
    exit;

  Idx := base.zDataSets.IndexOf(idDataSet);
  if Idx = -1 then
    exit;

  zDataSet := base.zDataSets[Idx];

  sp := TSP_ZZ_WEB_DATASETS_SET.Create(base.zFbTransaction);
  try
    sp.DATASET := id;
    sp.PK_FIELDS := zDataSet.PrimaryKeyFields;
    sp.RELATION_NAME := sp.RELATION_NAME;
    sp.SEQUENCE_NAME := sp.SEQUENCE_NAME;
    sp.MASTER_RELATION := sp.MASTER_RELATION;
    sp.MASTER_DETAIL_MAPINGS := sp.MASTER_DETAIL_MAPINGS;
    sp.CAN_INSERT := canInsert;
    sp.CAN_UPDATE := canUpdate;
    sp.CAN_DELETE := canUpdate;
    sp.SQL_SELECT.text := zDataSet.SQL_SELECT.text;
    sp.SQL_COUNT.text := ''; // zDataSet.SQL_COUNT.text;
    sp.SQL_REFRESH.text := zDataSet.SQL_REFRESH.text;
    sp.SQL_INSERT.text := zDataSet.SQL_INSERT.text;
    sp.SQL_UPDATE.text := zDataSet.SQL_UPDATE.text;
    sp.SQL_DELETE.text := zDataSet.SQL_DELETE.text;
    sp.IS_CUSTOM := false;
    //
    sp.ExecuteWithoutCommit;
  finally
    FreeAndNil(sp);
  end;

  spField := TSP_ZZ_WEB_DATASETS_FIELDS_ADD.Create(base.zFbTransaction);
  try

    for field in zFbDataSet.fields do
    begin
      FDDatSColumn := zFbDataSet.table.columns.ColumnByName(field.FieldName);

      spField.DATASET := id;
      spField.field := field.FieldName;
      spField.FIELD_ORIGIN := field.Origin;

      if assigned(FDDatSColumn) then
      begin
        spField.TABLE_NAME := FDDatSColumn.OriginTabName;
        spField.FIELD_NAME := FDDatSColumn.OriginColName;
      end;

      if spField.TABLE_NAME.IsNull then
        spField.TABLE_NAME := zDataSet.TableName;

      if spField.TABLE_NAME.IsNull then
        spField.FIELD_NAME := field.FieldName;

      spField.ExecuteWithoutCommit;
    end;
  finally
    FreeAndNil(spField);
  end;
end;

function SaveDbCardProps(cardId: string; zDbCardProps: TzDbCardProps): string;

  function ColSpan(ctrl: TzControlProps): Integer;
  begin
    result := 1;

    if ctrl.size < 20 then
      result := 1
    else
      IF (ctrl.size < 50) THEN
        result := 2
      else
        IF (ctrl.size = 50) THEN
          result := 3
        else
          result := 4;
  end;

  function editorType(ctrl: TzControlProps): string;
  var
    zCtrlType: TzCtrlType;
  begin
    result := 'dxTextBox';

    zCtrlType := ctrl.zCtrlType;
    if zCtrlType = ctDefault then
      if assigned(ctrl.Domain) then
        zCtrlType := ctrl.Domain.zCtrlType;

    /// //////////////

    if zCtrlType = ctCheckBox then
      result := 'dxCheckBox'
    else
      if zCtrlType = ctSpin then
        result := 'dxNumberBox'
      else

        if zCtrlType in [ctDate, ctTime, ctDateTime] then
          result := 'dxDateBox'
        else
          if zCtrlType in [ctPickList, ctPickListImage, ctLookup, ctLookupExt, ctLookupHyperLink] then
            result := 'dxSelectBox'
          else
            if zCtrlType = ctMemo then
              result := 'dxTextArea';
  end;

var
  ctrl: TzControlProps;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  i: Integer;
  s: String;
  IsLineBreak: boolean;
  sp: TSP_ZZ_WEB_DATASETS_FIELD_SAVE_CONTROL_PROS;
begin
  result := '';

  i := 0;
  IsLineBreak := false;

  sp := TSP_ZZ_WEB_DATASETS_FIELD_SAVE_CONTROL_PROS.Create(base.zFbTransaction);
  try
    JSONArray := TJSONArray.Create;
    try
      for ctrl in zDbCardProps.Controls do
      begin

        if ctrl.zCtrlType in [ctLineBreak, ctSeparator] then
          IsLineBreak := true
        else
        begin
          inc(i);
          JSONObject := TJSONObject.Create;
          JSONObject.AddPair('dataField', ctrl.Name);
          JSONObject.AddPair('cardVisible', ctrl.Visible);
          JSONObject.AddPair('cardIndex', i);
          JSONObject.AddPair('readOnly', ctrl.ReadOnly);
          JSONObject.AddPair('required', ctrl.Required);
          JSONObject.AddPair('lineBreak', IsLineBreak);
          // zCtrlType
          // colSpan := 2;
          // JSONObject.AddPair('colSpan', colSpan);
          // group?

          JSONArray.Add(JSONObject);

          sp.DATASET := cardId;
          sp.field := ctrl.Name;
          sp.CAPTION := ctrl.DisplayLabel;
          sp.Required := ctrl.Required;
          sp.ReadOnly := ctrl.ReadOnly;

          if assigned(ctrl.Domain) then
          begin
            sp.FIELDS_2_CLEAR := ctrl.Domain.FieldsToClear;
            sp.EDITOR_TYPE := editorType(ctrl);;
            sp.LOOKUP := ctrl.Domain.LOOKUP;
            sp.PICKLIST := ctrl.Domain.PICKLIST;
          end;

          sp.COL_SPAN := ColSpan(ctrl);
          sp.LINEBREAK := IsLineBreak;
          sp.CARD_VISIBLE := ctrl.Visible;
          sp.CARD_INDEX := i;
          sp.ExecuteWithoutCommit;

          IsLineBreak := false;
        end;
      end;

      s := JSONArray.Format(4);
    finally
      FreeAndNil(JSONArray);
    end;
  finally
    FreeAndNil(sp);
  end;

  result := s;
end;

procedure SaveDbCard(card: TzDbCard);
var
  id: string;
  s: string;
begin

  if not assigned(card) then
    exit;

  id := card.cardId;

  if not InputQuery('Id', 'Id', id) then
    exit;

  base.zFbTransaction.StartTransaction;
  try
    SaveDataset(id, card.zDataSet, card.zDbCardProps.flags.ButtonInsert, card.zDbCardProps.flags.ButtonUpdate, card.zDbCardProps.flags.ButtonDelete);

    s := SaveDbCardProps(id, card.zDbCardProps);
    base.zFbTransaction.Commit;
  except
    on e: exception do
    begin
      base.zFbTransaction.Rollback;
      raise;
    end;
  end;

  ClipBoard.AsText := s;
  ConfirmOk('Impostazioni copiate nella clipboard');

end;

procedure SaveDbView(view: TzDbView);
var
  col: TzColumn;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  i: Integer;
  id: string;
  s: String;
  sp: TSP_ZZ_WEB_DATASETS_FIELD_SAVE_COLUMN_PROS;
  zDbCardProps: TzDbCardProps;
begin
  // racchiudere tutto sotto transazione.
  // verificare le varie proc

  if not assigned(view) then
    exit;

  id := view.viewId;

  if not InputQuery('Id', 'Id', id) then
    exit;

  base.zFbTransaction.StartTransaction;
  try
    SaveDataset(id, view.zDataSet, view.GetDbViewProps.flags.ButtonInsert, view.GetDbViewProps.flags.ButtonUpdate, view.GetDbViewProps.flags.ButtonDelete);

    zDbCardProps := base.zDbCards.Get(id, false);
    if assigned(zDbCardProps) then
      SaveDbCardProps(id, zDbCardProps);

    view.GetDbViewProps.columns.AssignFromGridColumns(view.cxGridDBTableView, view.viewId);

    sp := TSP_ZZ_WEB_DATASETS_FIELD_SAVE_COLUMN_PROS.Create(base.zFbTransaction);
    try
      i := 0;
      JSONArray := TJSONArray.Create;
      try
        for col in view.GetDbViewProps.columns do
        begin
          inc(i);
          JSONObject := TJSONObject.Create;
          JSONObject.AddPair('dataField', col.Name);
          JSONObject.AddPair('viewVisible', col.Visible);
          JSONObject.AddPair('viewIndex', i);
          JSONArray.Add(JSONObject);
          //
          sp.DATASET := id;
          sp.field := col.Name;
          sp.VIEW_VISIBLE := col.Visible;
          sp.VIEW_INDEX := col.index;
        end;

        sp.ExecuteWithoutCommit;

        s := JSONArray.Format(4);

      finally
        FreeAndNil(JSONArray);
      end;
    finally
      FreeAndNil(sp);
    end;

    base.zFbTransaction.Commit;
  except
    on e: exception do
    begin
      base.zFbTransaction.Rollback;
      raise;
    end;
  end;

  ClipBoard.AsText := s;

  ConfirmOk('Colonne copiate nella clipboard');
end;

initialization

DevExtremeSaveDbView := SaveDbView;
DevExtremeSaveDbCard := SaveDbCard;

end.

// SaveDbView salva anche la Card
// SaveDbCard;
// Entrambe salvano il dataset
// Entrambe sono sotto transazione
