object frmbackup: Tfrmbackup
  Left = 323
  Top = 155
  BorderStyle = bsDialog
  Caption = 'C'#243'pia de Seguran'#231'a'
  ClientHeight = 263
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 144
    Top = 168
    Width = 34
    Height = 13
    Caption = 'Hor'#225'rio'
  end
  object Label1: TLabel
    Left = 8
    Top = 168
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object BitBtn1: TBitBtn
    Left = 121
    Top = 217
    Width = 129
    Height = 40
    Cursor = crHandPoint
    Caption = 'Realizar Backup'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 257
    Top = 216
    Width = 121
    Height = 41
    Cursor = crHandPoint
    Caption = 'Sair'
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object Edit1: TEdit
    Left = 144
    Top = 184
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 8
    Top = 184
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 3
    Text = 'Edit1'
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 369
    Height = 153
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 4
  end
end
