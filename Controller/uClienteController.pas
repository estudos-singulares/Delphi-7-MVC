unit uClienteController;

interface

uses
  Grids, SqlExpr, Clientes, uDMCliente;

type
  TClienteController = class
  public
    oCliente: TClientes;
    constructor Create;
    destructor Destroy; override;
    procedure Search(sNome: string; var aStringGrid: TStringGrid);
    procedure Load(oCliente: TClientes; iId: Integer);
    function Insert(oCliente: TClientes; out iId: Integer; out sErro: string): Boolean;
    function Update(oCliente: TClientes; out sErro: string): Boolean;
    function Delete(iId: Integer; out sErro: string): Boolean;
  end;

implementation

uses
  SysUtils;

{ TClienteController }

constructor TClienteController.Create;
begin
  dmCliente := TdmCliente.Create(nil);
  oCliente := TClientes.Create;
end;

destructor TClienteController.Destroy;
begin
  FreeAndNil(oCliente);
  FreeAndNil(dmCliente);
  inherited;
end;

procedure TClienteController.Search(sNome: string; var aStringGrid: TStringGrid);
begin
  dmCliente.Search(sNome, aStringGrid);
end;

procedure TClienteController.Load(oCliente: TClientes; iId: Integer);
begin
  dmCliente.Load(oCliente, iId);
end;

function TClienteController.Insert(oCliente: TClientes; out iId: Integer; out sErro: string): Boolean;
begin
  Result := dmCliente.Insert(oCliente, iId, sErro);
end;

function TClienteController.Update(oCliente: TClientes; out sErro: string): Boolean;
begin
  Result := dmCliente.Update(oCliente, sErro);
end;

function TClienteController.Delete(iId: Integer; out sErro: string): Boolean;
begin
  Result := dmCliente.Delete(iId, sErro);
end;

end.

