object frmclasse10: Tfrmclasse10
  Left = 457
  Top = 304
  BorderStyle = bsDialog
  Caption = 'Classe 10'
  ClientHeight = 592
  ClientWidth = 740
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
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 47
    Height = 16
    Caption = 'Classes'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 400
    Top = 13
    Width = 48
    Height = 16
    Caption = 'S'#225'bado'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 592
    Top = 264
    Width = 145
    Height = 49
    Caption = '&Processar'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 32
    Width = 377
    Height = 337
    DataSource = data10.ligamyclasse
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codigo'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -13
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsItalic]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'numero'
        Title.Caption = 'N'#250'mero'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -13
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsItalic]
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Professor'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -13
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsItalic]
        Width = 133
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'celular'
        Title.Caption = 'Celular'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -13
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsItalic]
        Width = 85
        Visible = True
      end>
  end
  object amensagem: TMemo
    Left = 400
    Top = 272
    Width = 185
    Height = 89
    Lines.Strings = (
      'amensagem')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object cbsabado: TComboBox
    Left = 400
    Top = 32
    Width = 185
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentFont = False
    TabOrder = 3
  end
  object RadioGroup1: TRadioGroup
    Left = 400
    Top = 64
    Width = 185
    Height = 65
    Caption = 'Classe'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      'Todas'
      'Selecionada')
    ParentFont = False
    TabOrder = 4
  end
  object BitBtn2: TBitBtn
    Left = 400
    Top = 144
    Width = 145
    Height = 49
    Caption = 'Alunos Faltosos'
    TabOrder = 5
    OnClick = BitBtn2Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 376
    Width = 721
    Height = 209
    Lines.Strings = (
      'amensagem')
    ScrollBars = ssBoth
    TabOrder = 6
  end
  object BitBtn3: TBitBtn
    Left = 560
    Top = 144
    Width = 145
    Height = 49
    Caption = 'Corrigir Quantidade'
    TabOrder = 7
    OnClick = BitBtn3Click
  end
end
