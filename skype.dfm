object frmskype: Tfrmskype
  Left = 893
  Top = 421
  Width = 384
  Height = 311
  Caption = 'frmskype'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Skype1: TSkype
    Left = 168
    Top = 104
    Width = 32
    Height = 32
    OnSmsMessageStatusChanged = Skype1SmsMessageStatusChanged
    ControlData = {000A0000D8130000D8130000}
  end
end
