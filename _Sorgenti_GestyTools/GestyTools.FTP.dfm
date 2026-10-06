object FTP: TFTP
  Height = 176
  Width = 152
  object IdFTP: TIdFTP
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 56
    Top = 24
  end
end
