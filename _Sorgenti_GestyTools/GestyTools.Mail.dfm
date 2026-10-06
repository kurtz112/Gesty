object Mail: TMail
  Height = 219
  Width = 130
  object IdSMTP: TIdSMTP
    AuthType = satSASL
    Host = 'mail.tophost.it'
    Port = 587
    SASLMechanisms = <>
    UseTLS = utUseExplicitTLS
    Left = 48
    Top = 24
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 48
    Top = 144
  end
end
