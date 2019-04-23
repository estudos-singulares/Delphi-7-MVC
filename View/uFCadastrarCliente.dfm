object frmCadastrarCliente: TfrmCadastrarCliente
  Left = 391
  Top = 171
  Width = 725
  Height = 557
  Caption = 'Cadastro de Clientes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFooter: TPanel
    Left = 0
    Top = 496
    Width = 717
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      717
      34)
    object btnClose: TBitBtn
      Left = 627
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 717
    Height = 496
    ActivePage = tsList
    Align = alClient
    HotTrack = True
    Style = tsFlatButtons
    TabOrder = 1
    object tsList: TTabSheet
      Caption = 'Lista'
      object pnlFilter: TPanel
        Left = 0
        Top = 0
        Width = 709
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          709
          49)
        object edtFilter: TLabeledEdit
          Left = 8
          Top = 20
          Width = 601
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          EditLabel.Width = 79
          EditLabel.Height = 13
          EditLabel.Caption = 'Digite para Filtrar'
          TabOrder = 0
        end
        object btnFilter: TBitBtn
          Left = 623
          Top = 17
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Filtrar'
          TabOrder = 1
          OnClick = btnFilterClick
        end
      end
      object pnlSelect: TPanel
        Left = 0
        Top = 421
        Width = 709
        Height = 44
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          709
          44)
        object btnNew: TBitBtn
          Left = 475
          Top = 10
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Novo'
          TabOrder = 0
          OnClick = btnNewClick
        end
        object btnDetail: TBitBtn
          Left = 549
          Top = 10
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Detalhar'
          TabOrder = 1
          OnClick = btnDetailClick
        end
        object btnDelete: TBitBtn
          Left = 623
          Top = 10
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Excluir'
          TabOrder = 2
          OnClick = btnDeleteClick
        end
      end
      object gridClientes: TStringGrid
        Left = 0
        Top = 49
        Width = 709
        Height = 372
        Align = alClient
        BorderStyle = bsNone
        RowCount = 2
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 2
        OnDblClick = gridClientesDblClick
        OnDrawCell = gridClientesDrawCell
        OnSelectCell = gridClientesSelectCell
      end
    end
    object tsDetails: TTabSheet
      Caption = 'Detalhes'
      ImageIndex = 1
      object edtId: TLabeledEdit
        Left = 8
        Top = 24
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        ReadOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Left = 8
        Top = 72
        Width = 553
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        TabOrder = 1
      end
      object edtCPF: TLabeledEdit
        Left = 576
        Top = 72
        Width = 121
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'CPF'
        TabOrder = 2
      end
      object edtTelefone: TLabeledEdit
        Left = 8
        Top = 120
        Width = 65
        Height = 21
        EditLabel.Width = 55
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'd Cidade'
        TabOrder = 3
      end
      object edtCidadeId: TLabeledEdit
        Left = 88
        Top = 120
        Width = 561
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        TabOrder = 4
      end
      object edtCidadeNome: TLabeledEdit
        Left = 664
        Top = 120
        Width = 33
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Estado'
        TabOrder = 5
      end
      object edtCidadeUF: TLabeledEdit
        Left = 8
        Top = 168
        Width = 121
        Height = 21
        EditLabel.Width = 42
        EditLabel.Height = 13
        EditLabel.Caption = 'Telefone'
        TabOrder = 6
      end
      object pnlBtnDetail: TPanel
        Left = 0
        Top = 421
        Width = 709
        Height = 44
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 7
        DesignSize = (
          709
          44)
        object btnListar: TBitBtn
          Left = 369
          Top = 9
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Listar'
          TabOrder = 0
          OnClick = btnListarClick
        end
        object btnAlterar: TBitBtn
          Left = 475
          Top = 9
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Alterar'
          TabOrder = 1
          OnClick = btnAlterarClick
        end
        object btnSalvar: TBitBtn
          Left = 549
          Top = 9
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Salvar'
          TabOrder = 2
          OnClick = btnSalvarClick
        end
        object btnCancelar: TBitBtn
          Left = 623
          Top = 9
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Cancelar'
          TabOrder = 3
          OnClick = btnCancelarClick
        end
      end
    end
  end
end
