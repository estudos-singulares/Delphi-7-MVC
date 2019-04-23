unit Clientes;

interface

uses
  SysUtils;

type
  TClientes = class
  private
    FId: Integer;
    FIdCidade: Integer;
    FNome: string;
    FCPF: string;
    FTelefone: string;
    FCidade: string;
    FEstado: string;
    procedure SetNome(const Value: string);
    procedure SetCPF(const Value: string);
  public
    property Id: Integer read FId write FId;
    property IdCidade: Integer read FIdCidade write FIdCidade;
    property Nome: string read FNome write SetNome;
    property CPF: string read FCPF write SetCPF;
    property Telefone: string read FTelefone write FTelefone;
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;
  end;

implementation

uses Math;

{ TClientes }

procedure TClientes.SetNome(const Value: string);
begin
  if Value = EmptyStr then
    raise EInvalidArgument.Create('O "Nome" precisa ser preenchido!')
  else
    FNome := Value;
end;

procedure TClientes.SetCPF(const Value: string);
begin
  if Value = EmptyStr then
    raise EInvalidArgument.Create('O "CPF" precisa ser preenchido!')
  else
    FCPF := Value;
end;

end.

