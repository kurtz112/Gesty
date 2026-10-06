unit dmEventHandler;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Base_DataModule,
  zFbDataSet,
  dbMaster,
  IdSocketHandle,
  IdBaseComponent,
  IdComponent,
  IdCustomTCPServer,
  IdTCPServer;

type
  TEventHandler = class(TBaseDataModule)
  private
    procedure CodiceFiscaleChange(Sender: TField);
    procedure PartitaIvaChange(Sender: TField);

    procedure IndirizzoResidenzaChange(Sender: TField);
    procedure IndirizzoSedeLegale(Sender: TField);

    procedure CodiceCIG(Sender: TField);
  public
    procedure AssignFieldOnChangeEvent(Field: TField; const EventName: string);
  end;

var
  EventHandler: TEventHandler;

implementation

uses
  Vcl.Dialogs, zCodiceFiscale, Gesty_StoredProcs, SmartInspect.VCL,
  SmartInspect.VCL.SiAuto, zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TEventHandler.AssignFieldOnChangeEvent(Field: TField; const EventName: string);
begin

  if EventName.IsEmpty then
    exit;

  if not assigned(Field) then
    exit;

  if assigned(Field.OnChange) then
    exit;

  /// /////////////////////

  if SameText(EventName, 'CodiceFiscale') then
    Field.OnChange := CodiceFiscaleChange
  else if SameText(EventName, 'PartitaIva') then
    Field.OnChange := PartitaIvaChange
  else if SameText(EventName, 'IndirizzoResidenza') then
    Field.OnChange := IndirizzoResidenzaChange
  else if SameText(EventName, 'IndirizzoSedeLegale') then
    Field.OnChange := IndirizzoSedeLegale
  else if SameText(EventName, 'CIG') then
    Field.OnChange := CodiceCIG;
end;

procedure TEventHandler.CodiceFiscaleChange(Sender: TField);
var
  Belfiore: string;
  s: string;
  sp: TSP_zz_Comuni_Get;
  DataSet: TDataSet;
  Estero: Boolean;
  Azienda: Boolean;
begin
  if Sender.IsNull then
    exit;

  DataSet := Sender.DataSet;

  s := Sender.asString;

  Estero := False;
  Azienda := False;

  if assigned(DataSet.FindField('TIPO_RISORSA')) then
  begin
    if DataSet.FieldByName('TIPO_RISORSA').asString = 'A' then
    begin
      Azienda := True;

      if assigned(DataSet.FindField('SEDE_LEGALE_SIGLA_STATO')) then
        Estero := StatoEstero(DataSet.FieldByName('SEDE_LEGALE_SIGLA_STATO').asString);
    end
    else
    begin

      if assigned(DataSet.FindField('RESIDENZA_SIGLA_STATO')) then
      begin
        Azienda := False;
        Estero := StatoEstero(DataSet.FieldByName('RESIDENZA_SIGLA_STATO').asString);
      end
      else if assigned(DataSet.FindField('SIGLA_STATO')) then
      begin
        Azienda := False;
        Estero := StatoEstero(DataSet.FieldByName('SIGLA_STATO').asString);
      end;
    end;
  end;

  if s <> '' then
    if not CodiceFiscaleValido(s, Estero) then
    begin
      // if not(Azienda and PartitaIvaValida(s, Estero)) then
      if not PartitaIvaValida(s, Estero) then
        ConfirmOk('Codice fiscale non valido: ' + s);
    end
    else
    begin

      if assigned(DataSet.FindField('SESSO')) then
        DataSet.FieldByName('SESSO').asString := EstraiSessoDaCodiceFiscale(s);

      if assigned(DataSet.FindField('DATA_NASCITA')) then
        DataSet.FieldByName('DATA_NASCITA').AsDateTime := EstraiDataNascitaDaCodiceFiscale(s);

      Belfiore := EstraiBelfioreNascitaDaCodiceFiscale(s);

      sp := TSP_zz_Comuni_Get.Create(WriteTrans);
      try
        sp.Belfiore := Belfiore;
        sp.ExecuteWithoutCommit;

        if assigned(DataSet.FindField('LUOGO_NASCITA')) then
          DataSet.FieldByName('LUOGO_NASCITA').asString := sp.Comune;

        if assigned(DataSet.FindField('SIGLA_STATO_NASCITA')) then
          DataSet.FieldByName('SIGLA_STATO_NASCITA').asString := sp.Sigla_Stato;

        if assigned(DataSet.FindField('CITTADINANZA')) then
          DataSet.FieldByName('CITTADINANZA').asString := sp.Nazionalita;
      finally
        FreeAndNil(sp);
      end;
    end;
end;

procedure TEventHandler.PartitaIvaChange(Sender: TField);
var
  PartitaIVA: string;
  DataSet: TDataSet;
  Estero: Boolean;
begin
  if Sender.IsNull then
    exit;

  DataSet := Sender.DataSet;
  PartitaIVA := Sender.asString;
  Estero := False;

  if assigned(DataSet.FindField('TIPO_RISORSA')) then
  begin
    if DataSet.FieldByName('TIPO_RISORSA').asString = 'A' then
    begin
      if assigned(DataSet.FindField('SEDE_LEGALE_SIGLA_STATO')) then
        Estero := StatoEstero(DataSet.FieldByName('SEDE_LEGALE_SIGLA_STATO').asString);
    end
    else
    begin
      if assigned(DataSet.FindField('RESIDENZA_SIGLA_STATO')) then
        Estero := StatoEstero(DataSet.FieldByName('RESIDENZA_SIGLA_STATO').asString);

      if assigned(DataSet.FindField('SEDE_LEGALE_SIGLA_STATO')) then
        Estero := StatoEstero(DataSet.FieldByName('SEDE_LEGALE_SIGLA_STATO').asString);
    end;
  end
  else
    Estero := False;

  if not PartitaIVA.IsEmpty then
    if not PartitaIvaValida(PartitaIVA, Estero) then
      ConfirmOk('Partita IVA non valida.');
end;

procedure TEventHandler.IndirizzoSedeLegale(Sender: TField);
  procedure Copia(Field: TField; Source, Dest: string);
  var
    DataSet: TDataSet;
  begin
    DataSet := Field.DataSet;

    if Field.FieldName = Source then
      if assigned(DataSet.FindField(Dest)) then
        DataSet.FieldByName(Dest).Value := Field.Value;
  end;

begin
  if Sender.IsNull then
    exit;

  Copia(Sender, 'SEDE_LEGALE_INDIRIZZO', 'SEDE_OPERAT_INDIRIZZO');
  Copia(Sender, 'SEDE_LEGALE_NUMERO_CIVICO', 'SEDE_OPERAT_NUMERO_CIVICO');
  Copia(Sender, 'SEDE_LEGALE_CAP', 'SEDE_OPERAT_CAP');
  Copia(Sender, 'SEDE_LEGALE_CITTA', 'SEDE_OPERAT_CITTA');
  Copia(Sender, 'SEDE_LEGALE_PROVINCIA', 'SEDE_OPERAT_PROVINCIA');
  Copia(Sender, 'SEDE_LEGALE_SIGLA_STATO', 'SEDE_OPERAT_SIGLA_STATO');
end;

procedure TEventHandler.IndirizzoResidenzaChange(Sender: TField);
  procedure Copia(Field: TField; Source, Dest: string);
  var
    DataSet: TDataSet;
  begin
    DataSet := Field.DataSet;

    if Field.FieldName = Source then
      if assigned(DataSet.FindField(Dest)) then
        DataSet.FieldByName(Dest).Value := Field.Value;
  end;

begin
  if Sender.IsNull then
    exit;

  if assigned(Sender.DataSet.FindField('RESIDENZA_INDIRIZZO')) then
  begin
    Copia(Sender, 'RESIDENZA_INDIRIZZO', 'DOMICILIO_INDIRIZZO');
    Copia(Sender, 'RESIDENZA_NUMERO_CIVICO', 'DOMICILIO_NUMERO_CIVICO');
    Copia(Sender, 'RESIDENZA_BELFIORE', 'DOMICILIO_BELFIORE');
    Copia(Sender, 'RESIDENZA_CAP', 'DOMICILIO_CAP');
    Copia(Sender, 'RESIDENZA_CITTA', 'DOMICILIO_CITTA');
    Copia(Sender, 'RESIDENZA_PROVINCIA', 'DOMICILIO_PROVINCIA');
    Copia(Sender, 'RESIDENZA_LOCALITA', 'DOMICILIO_LOCALITA');
    Copia(Sender, 'RESIDENZA_SIGLA_STATO', 'DOMICILIO_SIGLA_STATO');
  end
  else
  begin

    if assigned(Sender.DataSet.FindField('INQUILINO_RESIDENZA_INDIRIZZO')) then
    begin
      Copia(Sender, 'INQUILINO_RESIDENZA_INDIRIZZO', 'INQUILINO_DOMICILIO_INDIRIZZO');
      Copia(Sender, 'INQUILINO_RESIDENZA_NUMERO_CIVICO', 'INQUILINO_DOMICILIO_NUMERO_CIVICO');
      Copia(Sender, 'INQUILINO_RESIDENZA_BELFIORE', 'INQUILINO_DOMICILIO_BELFIORE');
      Copia(Sender, 'INQUILINO_RESIDENZA_CAP', 'INQUILINO_DOMICILIO_CAP');
      Copia(Sender, 'INQUILINO_RESIDENZA_CITTA', 'INQUILINO_DOMICILIO_CITTA');
      Copia(Sender, 'INQUILINO_RESIDENZA_PROVINCIA', 'INQUILINO_DOMICILIO_PROVINCIA');
      Copia(Sender, 'INQUILINO_RESIDENZA_LOCALITA', 'INQUILINO_DOMICILIO_LOCALITA');
      Copia(Sender, 'INQUILINO_RESIDENZA_SIGLA_STATO', 'INQUILINO_DOMICILIO_SIGLA_STATO');
    end;

    if assigned(Sender.DataSet.FindField('PROPRIETARIO_RESIDENZA_INDIRIZZO')) then
    begin
      Copia(Sender, 'PROPRIETARIO_RESIDENZA_INDIRIZZO', 'PROPRIETARIO_DOMICILIO_INDIRIZZO');
      Copia(Sender, 'PROPRIETARIO_RESIDENZA_NUMERO_CIVICO', 'PROPRIETARIO_DOMICILIO_NUMERO_CIVICO');
      Copia(Sender, 'PROPRIETARIO_RESIDENZA_BELFIORE', 'PROPRIETARIO_DOMICILIO_BELFIORE');
      Copia(Sender, 'PROPRIETARIO_RESIDENZA_CAP', 'PROPRIETARIO_DOMICILIO_CAP');
      Copia(Sender, 'PROPRIETARIO_RESIDENZA_CITTA', 'PROPRIETARIO_DOMICILIO_CITTA');
      Copia(Sender, 'PROPRIETARIO_RESIDENZA_PROVINCIA', 'PROPRIETARIO_DOMICILIO_PROVINCIA');
      Copia(Sender, 'PROPRIETARIO_RESIDENZA_LOCALITA', 'PROPRIETARIO_DOMICILIO_LOCALITA');
      Copia(Sender, 'PROPRIETARIO_RESIDENZA_SIGLA_STATO', 'PROPRIETARIO_DOMICILIO_SIGLA_STATO');
    end;
  end;
end;

procedure TEventHandler.CodiceCIG(Sender: TField);
begin
  // https://www.agid.gov.it/sites/default/files/repository_files/scheda_33.pdf

  if not Sender.IsNull then
    if Sender.asString.Length <> 10 then
      ConfirmOk('Codice CIG non valido: ' + Sender.asString);
end;

end.
