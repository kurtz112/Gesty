object Mail: TMail
  Height = 438
  Width = 260
  PixelsPerInch = 192
  object IdSMTP: TIdSMTP
    AuthType = satSASL
    Host = 'mail.tophost.it'
    SASLMechanisms = <>
    Left = 96
    Top = 48
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
    Left = 96
    Top = 288
  end
end
