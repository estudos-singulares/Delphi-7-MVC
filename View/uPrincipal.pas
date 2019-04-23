unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, uFCadastrarCliente;

type
  TfrmPrincipal = class(TForm)
    btnCliente: TBitBtn;
    procedure btnClienteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnClienteClick(Sender: TObject);
begin
  frmCadastrarCliente := TfrmCadastrarCliente.Create(nil);
  try
    frmCadastrarCliente.ShowModal;
  finally
    FreeAndNil(frmCadastrarCliente);
  end;
end;

end.
