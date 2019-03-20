object frmResumoES: TfrmResumoES
  Left = 325
  Top = 263
  Width = 1022
  Height = 662
  Caption = 'Resumo Escola Sabatina'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1006
    Height = 51
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 792
      Top = 24
      Width = 43
      Height = 16
      Caption = 'Label1'
    end
  end
  object grid: TNiceGrid
    Left = 0
    Top = 51
    Width = 1006
    Height = 572
    Cursor = 101
    Hint = 'oi'
    ColCount = 12
    Color = clWhite
    AlternateColor = 15263976
    HeaderLine = 3
    HeaderDarkColor = clSilver
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clRed
    FooterFont.Height = -12
    FooterFont.Name = 'Arial'
    FooterFont.Style = [fsBold]
    ReadOnly = True
    Columns = <
      item
        Title = 'sab 01|Teste|01'
        Width = 80
        Color = clWhite
      end
      item
        Title = 'sab 01|Teste|02'
        Width = 80
        Color = clWhite
      end
      item
        Title = 'sab 01|Coisa|01'
        Width = 80
        Color = clWhite
      end
      item
        Title = 'sab 01|Coisa|02'
        Width = 80
        Color = clWhite
      end
      item
        Width = 80
        Color = clWhite
      end
      item
        Width = 80
        Color = clWhite
      end
      item
        Width = 80
        Color = clWhite
      end
      item
        Width = 80
        Color = clWhite
      end
      item
        Width = 80
        Color = clWhite
      end
      item
        Width = 80
        Color = clWhite
      end
      item
        Width = 80
        Color = clWhite
      end
      item
        Width = 80
        Color = clWhite
      end>
    GutterKind = gkNumber
    GutterFont.Charset = DEFAULT_CHARSET
    GutterFont.Color = clWindowText
    GutterFont.Height = -11
    GutterFont.Name = 'MS Sans Serif'
    GutterFont.Style = []
    ShowFooter = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Align = alClient
    BevelOuter = bvLowered
    BevelInner = bvLowered
    TabOrder = 1
  end
end
