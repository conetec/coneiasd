object frmacompanhaes: Tfrmacompanhaes
  Left = 287
  Top = 214
  BorderStyle = bsDialog
  Caption = 'Acompanhamento de Alunos'
  ClientHeight = 501
  ClientWidth = 798
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
  object Label19: TLabel
    Left = 9
    Top = 14
    Width = 59
    Height = 16
    Caption = 'Trimestre'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label13: TLabel
    Left = 9
    Top = 62
    Width = 41
    Height = 16
    Caption = 'Classe'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 433
    Top = 62
    Width = 49
    Height = 16
    Caption = 'S'#225'bado'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit7: TEdit
    Left = 9
    Top = 32
    Width = 416
    Height = 24
    CharCase = ecUpperCase
    Color = 14680063
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnEnter = Edit7Enter
    OnKeyPress = Edit7KeyPress
  end
  object ComboBox1: TComboBox
    Left = 9
    Top = 80
    Width = 416
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentFont = False
    TabOrder = 1
    OnKeyPress = Edit7KeyPress
    Items.Strings = (
      'MASCULINO'
      'FEMININO')
  end
  object ComboBox2: TComboBox
    Left = 433
    Top = 80
    Width = 240
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentFont = False
    TabOrder = 2
    OnKeyPress = Edit7KeyPress
    Items.Strings = (
      'MASCULINO'
      'FEMININO')
  end
  object BitBtn1: TBitBtn
    Left = 680
    Top = 74
    Width = 105
    Height = 41
    Cursor = crHandPoint
    Caption = '&Selecionar'
    TabOrder = 3
    OnClick = BitBtn1Click
    Glyph.Data = {
      360C0000424D360C000000000000360000002800000020000000200000000100
      180000000000000C0000120B0000120B00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFDFDFDF7F7F7F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
      F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
      F6F6F6F6F6F7F7F7FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF8F8F8F2F2F2F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
      F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
      F3F3F3F3F3EDEDEDF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFB2B2B29B9B9BA0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0
      A0A0A0A0A1A1A1A1A1A1A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0
      A0A09F9F9FBEBEBEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFEDEDEDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF6F6F6B1B1B1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE9E9E9F7F7F7EAEAEAE6E6E6E7E7E7ECECECEBEBEBEBEBEBEBEBEBEBEB
      EBEBEBEBE7E7E7E9E9E9F2F2F2E6E6E6EBEBEBECECECECECECECECECEEEEEEF3
      F3F3F0F0F0AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE8E8E8F7F7F7EEEEEEDADADAB9B9B9C1C1C1C0C0C0C0C0C0C1C1C1C0C0
      C0B5B5B5A7A7A7BAB8BAEEEDEED4D4D4D0D0D0D2D2D2D2D2D2D0D0D0DDDDDDF7
      F7F7F0F0F0AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE8E8E8F8F8F8F0F0F0DDDDDDC0C0C0C7C7C7C6C6C6C6C6C6C6C6C6BEBE
      BEA7A7A7A19DA0919D94B7C1B9DAD9DAD5D5D5D6D6D6D6D6D6D4D4D4E0E0E0F8
      F8F8F0F0F0AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE8E8E8F9F9F9F2F2F2E0E0E0C2C2C2C9C9C9C8C8C8C8C8C8C1C1C1A7A7
      A79994988691892D8B42849C8AD5D2D4CBCBCBCCCCCCCCCCCCCACACAD5D5D5EB
      EBEBE3E3E3A7A7A7F9F9F9FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE8E8E8F9F9F9F5F5F5E1E1E1C3C3C3CACACAC9C9C9C0C0C0A6A6A69A95
      99757E77268A3E1FA33D7A857CAEA4ACA49DA2A59EA3A59EA3A49DA2ADA6ABBF
      B8BDB7B0B68C8B8CCECECEE4E4E4F6F6F6F8F8F8FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE8E8E8FAFAFAF6F6F6E1E1E1B8B8B8BCBCBCB2B2B29B9B9B908B906B74
      6E2F914626AF4627A6443E7D4D48775341734D42744E42744E41734D46785250
      815C4D7D58406A4A507759598162919E93D0D1D1FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE8E8E8FAFAFAF5F5F5F5F5F5F9F9F9F9F9F9DDDDDDBFBBBE96A19839A2
      5225AF462AAC4929AB4825B04623B14524B24524B24624B24624B24624B24523
      B04423AF4429B34A2AB44C2BBB4D5C8A67C0C4C1FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE8E8E8FBFBFBF8F8F8EEEEEEDDDDDDE0E0E0DAD6DA9BAA9F2AA74625BD
      482AB44B2AB64B2AB84C2BB74C2BB74C2BB84C2BB94D2BB94D2BB94D2BBA4D2B
      BC4D2BBE4E2BBF4F2BC04F2CC851669270C4C7C4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FBFBFBFBFBFBF1F1F1E1E1E1E3E3E3E7E4E7C3D0C64CBA6623C7
      492BBE4D2BBE4E2BBF4E26CF4D21D14A21D14A21D14A21D14A21D14A21D0491D
      CE481FD04929D5522DD2532ED85561946DC4C7C5FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FCFCFCFCFCFCF2F2F2E3E3E3E5E5E5E5E5E5EAE6E9CED3CF4DBC
      6722CB4A2CC14F2BCC503FBB5C54C36E54C66E53C56E54C56E53C46D59CA7367
      D78161CD7A55BB6C65CC7E61D47C9DBEA4E4E5E4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FCFCFCFEFEFEF4F4F4E3E3E3E5E5E5E5E5E5E5E5E5EAE5E9CDD6
      D050C56A1FD04829DD5296A99AF1E5EFEDE8ECECE7EBECE7EBEBE6EAF2EFF2FF
      FFFFF3EFF2B5B7B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFF5F5F5E2E2E2E4E4E4E4E4E4E4E4E4E5E5E5E9E3
      E7C7D1C954CE7023E14F92AF99EAE6E9E6E6E6E5E5E5E5E5E5E3E3E3EEEDEEFF
      FFFFF2F1F2B0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFF5F5F5E0E0E0E3E3E3E5E5E5E5E5E5E5E5E5E6E6
      E6E9E4E8C9D3CB4ECA6B94B49CECE8EBE5E5E5E5E5E5E5E5E5E3E3E3EEEEEEFF
      FFFFF1F1F1AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFFDFDFDFBFBFBF3F3F3E4E4E4E5E5E5E5E5E5E5E5
      E5E5E6E6EEE9EDC1D9C7BECBC1E9E8E9E5E5E5E5E5E5E5E5E5E3E3E3EEEEEEFF
      FFFFF1F1F1AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFFFFFFFFFFFFFF8F8F8EAEAEAEBEBEBEBEBEBEBEB
      EBEBEBEBEBEBEBF0EDF0EFEEEFEBEBEBEBEBEBEBEBEBEBEBEBEAEAEAF2F2F2FF
      FFFFF1F1F1AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF1F1F1AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFFCFCFCF6F6F6F7F7F7F7F7F7F7F7F7F7F7F7F7F7
      F7F7F7F7F7F7F7F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF1F1F1AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFC8C8C84B4B4B5757575757575757575757575757
      575757575555555F5F5FF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF1F1F1AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFC8C8C84B4B4B5757575757575757575757575757
      575757575555555F5F5FF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF1F1F1AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFFCFCFCF6F6F6F7F7F7F7F7F7F7F7F7F7F7F7F7F7
      F7F7F7F7F7F7F7F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF1F1F1AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCF5F5F5F6F6F6F5F5F5F9F9F9FF
      FFFFF1F1F1AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEEEEC8C8C8CCCCCCC9C9C9DDDDDDFF
      FFFFF1F1F1B0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE7E7E7FCFCFCFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFF
      FFFFF1F1F1B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFE8E8E8E6E6E6E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
      E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E8
      E8E8EEEEEECCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  end
  object BitBtn2: TBitBtn
    Left = 680
    Top = 453
    Width = 105
    Height = 41
    Cursor = crHandPoint
    Caption = '&Sair'
    TabOrder = 4
    OnClick = BitBtn2Click
    Glyph.Data = {
      360C0000424D360C000000000000360000002800000020000000200000000100
      180000000000000C0000120B0000120B00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF7F7F7F6F6F6F6F6F6F6F6F6F6F6
      F6F6F6F6F6F6F6F5F5F5F5F5F5F5F5F5F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
      F6F6F6F6F6F6F6F6F7F7F7FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFE9E9EAD2D3D2C8C9C8C7C8C7C7C8C7C7C8C7C7C8
      C7C5C6C6C5C6C7C4C6C6C4C6C6C5C7C7C5C6C7C6C7C7C7C8C7C7C8C7C7C8C7C7
      C8C7C7C8C7C7C8C8D4D4D5F1F1F1FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF0F1F3B7BFCC2C5BBA1348BA1246B81246B81146B81246B81246
      B81246B91347BA1347BA1347BA1347BA1347BA1246B91246B81246B81146B812
      46B81246B81148BE335DAE9EA6B3E8E8E8FDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF6489D0184FCA1349EF1549FD1548FE1548FE1648FF1747FF1849
      FF1849FF1948FF1947FF1947FF1947FF1948FF1847FF1847FF1747FF1648FF15
      48FE1549FE1549FC134AF01B50B9BDC0C3F7F7F7FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF2E60C31147DD1546F11540D0133DCA143DCD153FCF163FD1173F
      D4173FD61840D61840D7183FD71840D71840D61740D5173FD2163FD1153ECF14
      3DCC143DCB1540D31646F3114AE0788AB5F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF3765CD1246DD1542DD153DC6153ECB163ECE173ED1173FD41840
      D71940D9193FDB193FDC1A41DD193FDB193FDB1840D91840D5183FD3173ED016
      3ECD153ECA153DC61441DF134AE8677DB5F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF3864CB1144D61540D9153DCA163FCE173ED2183FD61941DA1A40
      DE1B41E01A40E11B40E21B41E21B40E11B40E11A41DF1A40DC1840D8183FD516
      3FD1163FCE143DCA1540DA1248E1697CB4F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF3763C81244D31741DA163ECD173ED2183FD7193FDB1B40DF1B41
      E21940E4173EE71C42E81C42E81D42E81D42E71239E3153BE01A40DE193FDA17
      3FD5173ED0153ECD1641D81348DE6C7FB4F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF3763C81243D21741D9173ED1183FD6193FDC1A40E01C41E4173E
      E82B4DE47188F3163CEF1D41F01E43EF1137E94A68ED3556EA123AE11B40DF18
      3FDA183FD4163ED01540D91347DB6C7EB2F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF3862C71342D01841DB173FD31940DA1B40DE1B41E41940EA1C40
      E8A9B6F3F3F5FE536FF91439F70F34F14F6AECF3F5FDD9DFFC3B5CEB143AE11A
      40DE1840D8173FD31641DA1346DA6D7EB2F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF3863C71443D01941DC1840D71A41DE1B41E21A40EA1B3EE0B9C4
      F8FFFFFFFFFFFFFAFBFF657DFE4561F6F7F8FEFFFFFFFFFFFFD3DAFC1E43E719
      3FE11940DC1840D51840DA1346DA6D7FB3F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF3863C61442D01841DD163DD9163DE0173FE41C42EF1A39CD8994
      CAFFFFFFFFFFFFFFFFFFE0E4FFE0E5FFFFFFFFFFFFFFFFFFFFA4B3F4163DE915
      3DE3173FDE183FD71840DB1345D96C7EB4F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF3863C61040D0153FDE284ADC3856E33B56E83953EF3550F11530
      BF8D99D0F7F8FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9DAAF82D4AEB3754EC36
      53E6284AE0153DD8133DDC1344D96D80B5F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF426BC74266D55E76E55068E0445FE5425AEA4057EE4158F7455A
      FB3242CDA4A9DFFFFFFFFFFFFFFFFFFFFFFFFFD8DCFE374DF83D56F3405AEE40
      5AE84D64E3556DE04C67E22553DA6B7FB6F2F2F2FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF426AC8385DD43D5DE23F5BDF4760E55264EA5B68F0626CF55C63
      F7878AF4EEEFFBFFFFFFFFFFFFFFFFFFFFFFFFE1E2FE898FFA5B67F35465EF48
      60E9415BE23858DD4864E1476BDE6C80B6F2F2F2FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF496EC8385BD55168E45167E05669E55968EA5D6AF05963ED858B
      F0F5F6FEFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFDFDFF8C93F55563ED58
      69E85569E34F67DF4661E32F59DD7283B7F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4E72C94060D55067E44F66DF5367E45769EA5B69EF5863D3F7F7
      FAFFFFFFFFFFFFFFFFFFA8AAE98D91D0FFFFFFFFFFFFFFFFFFFFFFFF626FED54
      66E85267E24E66DE5069E34165DF7988B7F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4B72C93D60D54F68E34D66DE5267E25668E75B6AF04D5AC97A83
      C3E6E7F2FFFFFFB9BCF85E63F44850C6A8ADD2FFFFFFFFFFFFA8AFF05565E955
      67E65067E14C65DD4E67E23F65DF7987B5F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4B72C93C60D54E67E24C65DC5067E05368E45869E95B69EE4855
      D67E86C2BABEF15B64F1636AFA646BF8434EBDA3A9CFA6ACE94C5BE25567E753
      68E34E66DF4B64DB4D68E23E66DF7886B4F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4B72C93C60D54D68E14A65DA4E66DE5167E25568E5596AEA5A67
      EA515ED95E68E15F69F3616BF3606BF45C67ED5662D34F5FDE5769E85467E550
      67E14C65DD4965D94B67E13E66E07886B4F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4B72CB3C61D84C68E14864D84B64DC4F66DE5267E25468E45769
      E95A6AEF5867EC5B69EF5C6AEE5B69ED5B6AEE5767EB5669E95467E55166E04E
      66DE4A64DA4764D74A68E23E66E27787B4F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4B72CC3C61D94A67E14663D54A64D94C65DB4E66DF5067E15368
      E35568E75668E85768E85869E95769E85668E85568E55268E35067E14D66DE4C
      64DB4864D84662D54967E23E67E57686B6F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4B72CD3C61DD4A68E34362D24764D64964D84B64DB4D66DD4F66
      E05167E25267E25367E35368E45267E35267E25067E14E66DF4C65DD4A64DA48
      64D84664D64362D34868E43E67E87586B7F8F8F8FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF3C68C13961DB4F6DF24664DB4563D64764D84964DA4B65DC4C65
      DD4E66DF4E66E04F67E04F67E14F67E04E66E04D66DE4C65DD4A65DA4864D946
      63D74563D64665DC506DF33864E18B9ABFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF6F91D22D5DC64467EB4F6EFA5270FB546FFC556EFB566DFB586E
      FC5A6DFC5B6DFD5C6EFC5C6EFD5C6EFC5A6DFC596EFD586EFC566EFB556EFB53
      6FFB5270FB4E6DF84166E83161C2DFE1E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF4F6FCC9D6EE446EC72A59C12959BF2959BF2B59C12D5CC32D5B
      C32D5BC32D5CC32E5CC32E5BC32E5CC22D5CC32D5BC32D5BC32C5BC32959C029
      59BF2859BF2B5BC25079CCC8CDD8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFAFBFDF4F7FBF4F7FBF4F7FAF5F8FCF6F9FEF4F8
      FEF3F7FEF1F6FEF1F6FEF1F6FEF1F6FEF2F7FEF4F8FEF5F9FEF6F9FEF4F7FBF4
      F7FBF4F7FBF5F7FBFCFDFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  end
  object otrimestre: TEdit
    Left = 456
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '0'
    Visible = False
  end
  object cax1: TComboBox
    Left = 584
    Top = 8
    Width = 105
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentFont = False
    TabOrder = 6
    Visible = False
    Items.Strings = (
      'MASCULINO'
      'FEMININO')
  end
  object achamada: TEdit
    Left = 456
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '0'
    Visible = False
  end
  object lista: TStringGrid
    Left = 8
    Top = 120
    Width = 777
    Height = 321
    Cursor = crHandPoint
    FixedColor = 14938351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs, goRowSelect]
    ParentFont = False
    TabOrder = 8
    OnClick = listaClick
    OnDrawCell = listaDrawCell
    ColWidths = (
      64
      64
      165
      64
      64)
  end
  object alista: TEdit
    Left = 16
    Top = 456
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '0'
    Visible = False
  end
end
