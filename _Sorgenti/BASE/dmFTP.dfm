object FTP: TFTP
  Height = 242
  Width = 131
  object IdFTP: TIdFTP
    OnWork = IdFTPWork
    OnWorkBegin = IdFTPWorkBegin
    OnWorkEnd = IdFTPWorkEnd
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 56
    Top = 24
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 56
    Top = 168
  end
end
