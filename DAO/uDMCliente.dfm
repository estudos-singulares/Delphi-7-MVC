object dmCliente: TdmCliente
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 1170
  Top = 426
  Height = 243
  Width = 284
  object sqlSelect: TSQLDataSet
    CommandText = 
      'SELECT CLI.*,  CID.nome as cidade, EST.uf FROM clientes CLI LEFT' +
      ' JOIN cidades CID ON (CID.id = CLI.id_cidade) LEFT JOIN estados ' +
      'EST ON (EST.id = CID.id_estado) WHERE CLI.nome = :Nome'
    Params = <
      item
        DataType = ftString
        ParamType = ptUnknown
      end>
    Left = 16
    Top = 16
  end
  object dspSelect: TDataSetProvider
    DataSet = sqlSelect
    Left = 16
    Top = 80
  end
  object sqlInsert: TSQLDataSet
    CommandText = 
      'INSERT INTO clientes (id_cidade, nome, cpf, telefone) VALUES (:i' +
      'd_cidade, :nome, :cpf, :telefone) RETURNING id INTO :id'
    Params = <
      item
        DataType = ftInteger
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        ParamType = ptUnknown
      end>
    Left = 72
    Top = 16
  end
  object sqlUpdate: TSQLDataSet
    CommandText = 
      'UPDATE clientes SET id_cidade = :id_cidade, nome = :nome, cpf = ' +
      ':cpf, telefone = :telefone WHERE (id = :id)'
    Params = <
      item
        DataType = ftInteger
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        ParamType = ptUnknown
      end>
    Left = 128
    Top = 16
  end
  object sqlDelete: TSQLDataSet
    CommandText = 'DELETE FROM clientes WHERE (id = :id)'
    Params = <
      item
        DataType = ftInteger
        Name = 'Id'
        ParamType = ptInput
      end>
    Left = 184
    Top = 16
  end
  object cdsSelect: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        ParamType = ptUnknown
      end>
    ProviderName = 'dspSelect'
    Left = 16
    Top = 144
  end
end
