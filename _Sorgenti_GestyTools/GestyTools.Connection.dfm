object Connection: TConnection
  Height = 346
  Width = 285
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\FB4\WOW64\fbclient.dll'
    Left = 73
    Top = 104
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 73
    Top = 164
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=X:\Gesty\DB\master\Gesty.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=orso'
      'Port=3054'
      'CharacterSet=UTF8'
      'DriverID=FB')
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 73
    Top = 44
  end
  object FDIBBackup: TFDIBBackup
    OnError = FDIBBackupError
    DriverLink = FDPhysFBDriverLink
    Protocol = ipTCPIP
    OnProgress = FDIBBackupProgress
    Verbose = True
    Left = 209
    Top = 44
  end
  object FDIBRestore: TFDIBRestore
    OnError = FDIBRestoreError
    DriverLink = FDPhysFBDriverLink
    OnProgress = FDIBRestoreProgress
    Verbose = True
    Left = 209
    Top = 104
  end
  object FDStoredProc: TFDStoredProc
    Connection = FDConnection
    Left = 208
    Top = 223
  end
  object procShutdown: TFDStoredProc
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    StoredProcName = 'ZZ_SHUTDOWN'
    Left = 208
    Top = 164
  end
  object UtentiAttivi: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT *'
      'FROM USR_UTENTI_ATTIVI')
    Left = 72
    Top = 224
  end
  object procLogin: TFDStoredProc
    Connection = FDConnection
    StoredProcName = 'USR_LOGIN'
    Left = 205
    Top = 280
    ParamData = <
      item
        Position = 1
        Name = 'APP'
        DataType = ftWideString
        ParamType = ptInput
        Size = 50
      end
      item
        Position = 2
        Name = 'USER_NAME'
        DataType = ftWideString
        ParamType = ptInput
        Size = 50
      end
      item
        Position = 3
        Name = 'PASSWORD_'
        DataType = ftWideString
        ParamType = ptInput
        Size = 255
      end
      item
        Position = 4
        Name = 'COMPUTER_NAME'
        DataType = ftWideString
        ParamType = ptInput
        Size = 255
      end
      item
        Position = 5
        Name = 'USER_ID'
        DataType = ftLargeint
        ParamType = ptOutput
      end
      item
        Position = 6
        Name = 'ID_SESSIONE'
        DataType = ftLargeint
        ParamType = ptOutput
      end
      item
        Position = 7
        Name = 'NOMINATIVO'
        DataType = ftWideString
        ParamType = ptOutput
        Size = 150
      end
      item
        Position = 8
        Name = 'TIPO_USER'
        DataType = ftWideString
        ParamType = ptOutput
        Size = 1
      end
      item
        Position = 9
        Name = 'DATA_SCADENZA_PASSWORD'
        DataType = ftDate
        ParamType = ptOutput
      end
      item
        Position = 10
        Name = 'ADMIN_USER'
        DataType = ftBoolean
        ParamType = ptOutput
      end
      item
        Position = 11
        Name = 'HOST_LDAP'
        DataType = ftWideString
        ParamType = ptOutput
        Size = 255
      end>
  end
end
