unit uDMCliente;

interface

uses
  SysUtils, Classes, FMTBcd, DBClient, Provider, DB, SqlExpr, Grids, Clientes;

type
  TdmCliente = class(TDataModule)
    sqlSelect: TSQLDataSet;
    dspSelect: TDataSetProvider;
    cdsSelect: TClientDataSet;
    sqlInsert: TSQLDataSet;
    sqlUpdate: TSQLDataSet;
    sqlDelete: TSQLDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarId: Integer;
    procedure Search(sNome: string; var aStringGrid: TStringGrid);
    procedure Load(oCliente: TClientes; iId: Integer);
    function Insert(oCliente: TClientes; out iId: Integer; out sErro: string): Boolean;
    function Update(oCliente: TClientes; out sErro: string): Boolean;
    function Delete(iId: Integer; out sErro: string): Boolean;
  end;

var
  dmCliente: TdmCliente;

implementation

uses
  uDMConexao;

{$R *.dfm}

{ TdmCliente }

function TdmCliente.GerarId: Integer;
var
  sqlSequencia: TSQLDataSet;
begin
  sqlSequencia := TSQLDataSet.Create(nil);
  try
    with sqlSequencia do
    begin
      SQLConnection := dmConexao.SQLConn;
      CommandText := 'SELECT coalesce(max(Id), 0) + 1 as Seq FROM clientes';
      Open;
      Result := FieldByName('Seq').ASInteger;
    end;
  finally
    FreeAndNil(sqlSequencia);
  end;
end;

procedure TdmCliente.Search(sNome: string; var aStringGrid: TStringGrid);
var
  iTotal: Integer;
begin
  try
    iTotal := 1;
    with cdsSelect do
    begin
      if Active then
        Close;

      if sNome = EmptyStr then
        Params[0].AsString := '%'
      else
        Params[0].AsString := '%' + sNome + '%';

      Open;
      DisableControls;
      Last;

      with aStringGrid do
      begin
        RowCount := RecordCount + 1;
        ColCount := 4;
        Cells[0, 0] := 'Id';
        Cells[1, 0] := 'Nome';
        Cells[2, 0] := 'Telefone';
        Cells[3, 0] := 'Cidade';
        ColWidths[0] := 40;
        ColWidths[1] := 200;
        ColWidths[2] := 120;
        ColWidths[3] := 180;
      end;

      First;

      while not Eof do
      begin
        with aStringGrid do
        begin
          Cells[0, iTotal] := FieldByName('Id').AsString;
          Cells[1, iTotal] := FieldByName('Nome').AsString;
          Cells[2, iTotal] := FieldByName('Telefone').AsString;
          Cells[3, iTotal] := FieldByName('Cidade').AsString;
        end;
        Inc(iTotal);
        Next;
      end;
    end;

  finally
    cdsSelect.EnableControls;
    cdsSelect.Close;
  end;

end;

procedure TdmCliente.Load(oCliente: TClientes; iId: Integer);
var
  sqlCliente: TSQLDataSet;
begin
  sqlCliente := TSQLDataSet.Create(nil);
  try
    with sqlCliente do
    begin
      SQLConnection := dmConexao.SQLConn;
      CommandText := 'SELECT cli.*,  cid.nome AS cidade, est.uf '
                   + '  FROM clientes cli LEFT JOIN '
                   + '       cidades cid ON (cid.id = cli.id_cidade) LEFT JOIN '
                   + '       estados est ON (est.id = cid.id_estado) '
                   + ' WHERE cli.Id = '
                   + IntToStr(iId);
      Open;

      with oCliente do
      begin
        Id := FieldByName('Id').AsInteger;
        IdCidade := FieldByName('Id_Cidade').AsInteger;
        Nome := FieldByName('Nome').AsString;
        CPF := FieldByName('CPF').AsString;
        Telefone := FieldByName('Telefone').AsString;
        Cidade := FieldByName('Cidade').AsString;
        Estado := FieldByName('UF').AsString;
      end;
    end;

  finally
    FreeAndNil(sqlCliente);
  end;
end;

function TdmCliente.Insert(oCliente: TClientes; out iId: Integer; out sErro: string): Boolean;
begin
  with sqlInsert, oCliente do
  begin
    SQLConnection := dmConexao.SQLConn;
    if IdCidade = 0 then
      Params[0].Clear
    else
      Params[0].AsInteger := IdCidade;
    Params[1].AsString := Nome;
    Params[2].AsString := CPF;
    Params[3].AsString := Telefone;
    try
      ExecSQL();
      iId := Params[4].AsInteger;
      Result := True;
    except
      on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao Inserir o Cliente: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

function TdmCliente.Update(oCliente: TClientes; out sErro: string): Boolean;
begin
  with sqlUpdate, oCliente do
  begin
    SQLConnection := dmConexao.SQLConn;
    if IdCidade = 0 then
      Params[0].Clear
    else
      Params[0].AsInteger := IdCidade;
    Params[1].AsString := Nome;
    Params[2].AsString := CPF;
    Params[3].AsString := Telefone;
    Params[4].AsInteger := Id;
    try
      ExecSQL();
      Result := True;
    except
      on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao Atualizar o Cliente: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

function TdmCliente.Delete(iId: Integer; out sErro: string): Boolean;
begin
  with sqlDelete do
  begin
    SQLConnection := dmConexao.SQLConn;
    Params[0].AsInteger := iId;
    try
      ExecSQL();
      Result := True;
    except
      on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao Excluir o Cliente: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

procedure TdmCliente.DataModuleCreate(Sender: TObject);
begin
  sqlSelect.SQLConnection := dmConexao.SQLConn;
  sqlSelect.Open;
  sqlInsert.SQLConnection := dmConexao.SQLConn;
  sqlUpdate.SQLConnection := dmConexao.SQLConn;
  sqlDelete.SQLConnection := dmConexao.SQLConn;
end;

end.

