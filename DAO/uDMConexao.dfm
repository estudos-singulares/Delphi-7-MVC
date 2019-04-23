object dmConexao: TdmConexao
  OldCreateOrder = False
  Left = 1161
  Top = 231
  Height = 150
  Width = 215
  object SQLConn: TSQLConnection
    ConnectionName = 'Estudos.FDB'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoadParamsOnConnect = True
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=C:\_DB\Firebird\ESTUDOS.FDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=1'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    Left = 16
    Top = 8
  end
end
