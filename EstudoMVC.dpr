program EstudoMVC;

uses
  Forms,
  uPrincipal in 'View\uPrincipal.pas' {frmPrincipal},
  uFCadastrarCliente in 'View\uFCadastrarCliente.pas' {frmCadastrarCliente},
  Clientes in 'Model\Clientes.pas',
  uDMConexao in 'DAO\uDMConexao.pas' {dmConexao: TDataModule},
  uDMCliente in 'DAO\uDMCliente.pas' {dmCliente: TDataModule},
  uClienteController in 'Controller\uClienteController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;
end.
