unit uFCadastrarCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, ComCtrls, DB, DBGrids;

type
  TOperacao = (opNovo, opAlterar, opNavegacao);

  TfrmCadastrarCliente = class(TForm)
    pnlFooter: TPanel;
    btnClose: TBitBtn;
    pgcPrincipal: TPageControl;
    tsList: TTabSheet;
    pnlFilter: TPanel;
    edtFilter: TLabeledEdit;
    btnFilter: TBitBtn;
    pnlSelect: TPanel;
    btnNew: TBitBtn;
    btnDetail: TBitBtn;
    btnDelete: TBitBtn;
    gridClientes: TStringGrid;
    tsDetails: TTabSheet;
    edtId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCPF: TLabeledEdit;
    edtTelefone: TLabeledEdit;
    edtCidadeId: TLabeledEdit;
    edtCidadeNome: TLabeledEdit;
    edtCidadeUF: TLabeledEdit;
    pnlBtnDetail: TPanel;
    btnListar: TBitBtn;
    btnAlterar: TBitBtn;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCloseClick(Sender: TObject);
    procedure gridClientesSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure gridClientesDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure gridClientesDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDetailClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    FOperacao: TOperacao;
    FIdSelecionado: Integer;
    procedure SetUp;
    procedure Searchs;
    procedure New;
    procedure Details;
    procedure Loads;
    procedure Lists;
    procedure Inserts;
    procedure Updates;
    procedure Deletes;
    procedure Saves;
    procedure EnableControls;
  public
    { Public declarations }
    property IdSelecionado: Integer read FIdSelecionado write FIdSelecionado;
  end;

var
  frmCadastrarCliente: TfrmCadastrarCliente;

implementation

uses
  uClienteController, Clientes;

{$R *.dfm}

procedure TfrmCadastrarCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastrarCliente.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastrarCliente.SetUp;
begin
  tsList.TabVisible       := False;
  tsDetails.TabVisible    := False;
  pgcPrincipal.ActivePage := tsList;
  IdSelecionado           := 0;
  Searchs;
end;

procedure TfrmCadastrarCliente.Searchs;
var
  oClienteController: TClienteController;
begin
  oClienteController := TClienteController.Create;
  try
    oClienteController.Search(edtFilter.Text, gridClientes);
  finally
    FreeAndNil(oClienteController);
  end;
end;

procedure TfrmCadastrarCliente.New;
begin
  FOperacao := opNovo;
  pgcPrincipal.ActivePage := tsDetails;
end;

procedure TfrmCadastrarCliente.Details;
begin
  if gridClientes.Cells[0, 1] = EmptyStr then
    raise Exception.Create('Não há registro para ser detalhado!');
  Loads;
  pgcPrincipal.ActivePage := tsDetails;
end;

procedure TfrmCadastrarCliente.Loads;
var
  oClienteController: TClienteController;
begin
  oClienteController := TClienteController.Create;
  try
    with oClienteController do
    begin
      Load(oCliente, StrToInt(gridClientes.Cells[0, IdSelecionado]));
      with oCliente do
      begin
        edtId.Text         := IntToStr(Id);
        edtNome.Text       := Nome;
        edtCPF.Text        := CPF;
        edtCidadeId.Text   := IntToStr(IdCidade);
        edtCidadeNome.Text := Cidade;
        edtCidadeUF.Text   := Estado;
      end;
    end;
  finally
    FreeAndNil(oClienteController);
  end;

end;

procedure TfrmCadastrarCliente.Lists;
begin
  pgcPrincipal.ActivePage := tsList;
end;

procedure TfrmCadastrarCliente.Inserts;
var
  oClienteController: TClienteController;
  iId: Integer;
  sErro: string;
begin
  oClienteController := TClienteController.Create;
  try
    with oClienteController do
    begin
      with oCliente do
      begin
        IdCidade := StrToIntDef(edtCidadeId.Text, 0);
        Nome     := edtNome.Text;
        CPF      := edtCPF.Text;
        Telefone := edtTelefone.Text;
      end;
      if not oClienteController.Insert(oCliente, iId, sErro) then
        raise Exception.Create(sErro);
    end;
  finally
    FreeAndNil(oClienteController);
  end;
end;

procedure TfrmCadastrarCliente.Updates;
var
  oClienteController: TClienteController;
  sErro: string;
begin
  oClienteController := TClienteController.Create;
  try
    with oClienteController do
    begin
      with oCliente do
      begin
        Id       := StrToIntDef(edtId.Text, 0);
        IdCidade := StrToIntDef(edtCidadeId.Text, 0);
        Nome     := edtNome.Text;
        CPF      := edtCPF.Text;
        Telefone := edtTelefone.Text;
      end;
      if not Update(oCliente, sErro) then
        raise Exception.Create(sErro);
    end;
  finally
    FreeAndNil(oClienteController);
  end;
end;

procedure TfrmCadastrarCliente.Deletes;
var
  oClienteController: TClienteController;
  sErro: string;
begin
  oClienteController := TClienteController.Create;
  try
    if gridClientes.Cells[0, 1] = EmptyStr then
      raise Exception.Create('Não há registro para ser excluído!');
    if not oClienteController.Delete(StrToIntDef(gridClientes.Cells[0, gridClientes.Row], 0), sErro) then
      raise Exception.Create(sErro);
    oClienteController.Search(EmptyStr, gridClientes);
  finally
    FreeAndNil(oClienteController);
  end;

end;

procedure TfrmCadastrarCliente.Saves;
var
  oClienteController: TClienteController;
begin
  case FOperacao of
    opNovo:
      Inserts;
    opAlterar:
      Updates;
  end;
  oClienteController := TClienteController.Create;
  try
    oClienteController.Search(EmptyStr, gridClientes);
  finally
    FreeAndNil(oClienteController);
  end;
end;

procedure TfrmCadastrarCliente.EnableControls;
begin
  edtNome.Enabled     := FOperacao in [opNovo, opAlterar];
  edtCPF.Enabled      := FOperacao in [opNovo, opAlterar];
  edtCidadeId.Enabled := FOperacao in [opNovo, opAlterar];
  edtTelefone.Enabled := FOperacao in [opNovo, opAlterar];
  btnListar.Enabled   := FOperacao in [opNavegacao];
  btnClose.Enabled    := FOperacao in [opNavegacao];
  btnAlterar.Enabled  := FOperacao in [opNavegacao];
  btnSalvar.Enabled   := FOperacao in [opNovo, opAlterar];
  btnCancelar.Enabled := FOperacao in [opNovo, opAlterar];
end;

procedure TfrmCadastrarCliente.gridClientesSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if ARow > 0 then
    IdSelecionado := StrToIntDef(gridClientes.Cells[0, ARow], 0);
end;

procedure TfrmCadastrarCliente.gridClientesDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with gridClientes do
  begin
    if ARow = 0 then
    begin
      Canvas.Brush.Color := clGray;
      Canvas.Font.Color := $00ADD2FC;
      Canvas.Font.Style := [fsBold];
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left, Rect.Top, Cells[ACol, ARow]);
    end;
  end;
end;

procedure TfrmCadastrarCliente.gridClientesDblClick(Sender: TObject);
begin
  Details;
end;

procedure TfrmCadastrarCliente.FormShow(Sender: TObject);
begin
  SetUp;
end;

procedure TfrmCadastrarCliente.btnFilterClick(Sender: TObject);
begin
  Searchs;
end;

procedure TfrmCadastrarCliente.btnNewClick(Sender: TObject);
begin
  New;
  EnableControls;
end;

procedure TfrmCadastrarCliente.btnDetailClick(Sender: TObject);
begin
  Details;
end;

procedure TfrmCadastrarCliente.btnDeleteClick(Sender: TObject);
begin
  Deletes;
end;

procedure TfrmCadastrarCliente.btnListarClick(Sender: TObject);
begin
  Lists;
end;

procedure TfrmCadastrarCliente.btnAlterarClick(Sender: TObject);
begin
  FOperacao := opAlterar;
  EnableControls;
end;

procedure TfrmCadastrarCliente.btnSalvarClick(Sender: TObject);
begin
  Saves;
  EnableControls;
end;

procedure TfrmCadastrarCliente.btnCancelarClick(Sender: TObject);
begin
  FOperacao := opNavegacao;
  EnableControls;
end;

end.
