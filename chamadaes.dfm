object frmchamadaes: Tfrmchamadaes
  Left = 486
  Top = 405
  BorderStyle = bsDialog
  Caption = 'Chamada Escola Sabatina'
  ClientHeight = 444
  ClientWidth = 588
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
    Width = 29
    Height = 16
    Caption = 'Data'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 153
    Top = 14
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
  object Edit7: TEdit
    Left = 9
    Top = 32
    Width = 136
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
  end
  object Edit1: TEdit
    Left = 153
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
    TabOrder = 1
    OnEnter = Edit7Enter
  end
  object lista: TStringGrid
    Left = 8
    Top = 64
    Width = 561
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
    TabOrder = 2
    OnClick = listaClick
    OnDrawCell = listaDrawCell
    ColWidths = (
      64
      64
      165
      64
      64)
  end
  object BitBtn1: TBitBtn
    Left = 352
    Top = 394
    Width = 105
    Height = 41
    Cursor = crHandPoint
    Caption = '&Gravar'
    TabOrder = 3
    OnClick = BitBtn1Click
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
      FFFFFFFFFFFFFFFFFFFFFFFFE9E9E9D2D2D2C8C8C8C7C7C7C7C7C7C7C7C7C7C7
      C7C5C6C5C5C6C5C5C6C4C5C6C4C6C7C5C5C6C5C6C7C6C7C7C7C7C7C7C7C7C7C7
      C7C7C7C7C7C7C8C7D4D5D4F1F1F1FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF1F2F1BBC9BC42A44F2CA13D2B9E3C2B9E3C2B9E3C2B9E3D2B9F
      3D2C9F3E2CA03E2CA03E2CA03E2CA03E2CA03E2C9F3D2B9F3D2B9E3C2B9E3C2B
      9E3C2B9E3C2CA33E469C51A2AFA3E8E8E8FDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF75C07F34B14735CE5739DA603ADB613ADB623ADC633BDD653DDE
      663DDF673EDF683EDF683DE0693EDF683EDF683DDE673DDE663BDD643ADC633A
      DB623ADB6139D95F35CF5634A142BEC3BFF7F7F7FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF46AD5331BF4D38CF5C32B55031AF4F32B15133B35234B55435B7
      5535B95636B95736BA5736BA5836BA5736B95735B85635B65534B45333B35232
      B05031AF4F32B65138D25E31C14D82AC8AF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4FB65E31BE4F34BE5531AB4D32B05033B25234B55435B75636BA
      5737BC5937BD5A37BE5B38BE5B37BD5B37BD5A36BB5936B95735B75534B45333
      B25132AF5030AB4D34C05634C75273AA7EF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4FB55E30B84D33BB5532AF5033B35334B65535BA5837BC5A38C0
      5C39C25E39C35F3AC4603AC46039C35F39C35F38C15D38BF5B36BC5935B85733
      B55433B25231AF4F33BC5533C25174A97FF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4EB25E30B64C35BB5632B15234B65636BA5737BE5C39C05E3AC4
      603BC7623CC9633CCA6435C85E38C9613BC8633AC6613AC35F38C05D37BD5A35
      B95734B45432B15134BB5533BF4F77A981F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4EB25E30B54C35BB5734B55435BA5837BE5B39C25F3BC6613CC9
      643DCD663ACD6535CE616EDC8EA0E7B441CF6A3CCB653CC8623AC56138C05C36
      BC5A35B85633B45334BB5632BD4F77A881F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4EB15E30B44D36BD5835B75637BC5A39C05E3BC6613DCA643ACD
      6536CF6252D97BAFEDC1F6FDF9FFFFFF79E09737CF633ECD673CC9633AC45F38
      BF5C36BA5834B65535BD5732BC4F77A782F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4FB15E31B44D37BE5936BA5738C05C3AC3603DCA6436CD6246D5
      7192E8ACEBFBF0FFFFFFFFFFFFFFFFFFD9F7E349D7743AD1673DCD663BC76339
      C35F37BE5A35B85636BD5833BC5078A882F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4EB15E31B44E36C05A34BB5734C15A38C75F33C35C78D894D8F7
      E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF96EAAF38D3673FD0693ACA6237
      C45D36BF5A36BA5837BE5A33BC5078A982F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF4EB15E2DB34A34BF5844C06553C97557D27D43BE6A9DCCACFFFF
      FFFFFFFFE9FAEE9ADAAECFEBD7FFFFFFFFFFFFEFFCF366DD8D50D47A56D17B52
      CC7744C46833BA5732BD5532BB4F78AA83F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF56B46559BE7073D18E66CB855DCD7F5DD18259D28151B270D9E8
      DDCAEAD780D9A45AD28A86C79EFBFCFBFFFFFFFFFFFFB9F0CB56D7815AD3815B
      CF7F65CC856BCB8764CB8141BE5C77AB82F2F2F2FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF58B46750BC6957C97658C77860CD816AD48E74DD9B6CCB9174C7
      9575D79F80E9B08AEFBC6CC493C5E0D0FFFFFFFFFFFFF9FEFC94E4B367D68F62
      D1865ACA7C51C57161CB7E5FC87678AB82F2F2F2FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF5DB56C51BD6B68CE8868CB876CD08D70D59474D99A79DFA37CE5
      A881E8AD84EAB287EFB87BE1AA79BD95F5F9F7FFFFFFFFFFFFD8F5E471D7976F
      D3916BCE8C66CA845ECB7D4AC2657DAC86F3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF61B66F57BE7067CE8766CA846ACF8B6ED49273D89877DC9F7AE0
      A57EE5A982E6AE82E9B185ECB466C48EACD3BBFFFFFFFFFFFFFFFFFFA9E7BF66
      D08A69CD8965C98367CD8559C77383AD8CF3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF5FB66D55BE6E66CD8564C98269CD896DD28F71D69675DA9C78DE
      A17BE2A57EE4A980E6AB80E7AE76DDA16BB688E4EFE8FFFFFFFFFEFFBCE9CC63
      CE8767CC8763C88165CB8358C77182AD8CF3F3F3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF5FB66D54BE6D65CC8363C78067CB866ACF8B6ED49172D89776DB
      9C78DDA07ADFA47BE1A57BE1A67EE5A967CA8D93C3A4DCEEE393D2A866C78769
      CE8965CA8462C67F64CB8158C77182AB8BF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF5FB66D54BE6D64CB8161C57E65C98368CD886CD18E70D49272D7
      9774D99B76DB9D77DD9F78DD9F78DD9F74D89A65BE856AC38964CC876BD08C67
      CC8763C88160C47C62CA7F57C87081AB8BF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF5FB76D54C06C63CB805FC37A62C78066C98469CD896BD08D6ED3
      9170D69571D79772D89873D89972D79872D8976FD5946AD18D6BD08C68CC8765
      C98361C57E5EC27961CA7E57C97080AB8AF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF60B96D55C26D62CA7E5DC17861C47C63C68065CA8467CC876ACF
      8B6CD18E6DD28F6ED3916FD4926ED3906DD28F6CD08D6ACE8A67CC8664C98363
      C67F5FC37A5CC07661CB7D58CB7180AC8AF4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF5FB96E55C56E62CD7E5ABD745EC17760C37B62C67F64C88266CB
      8568CD8769CD896ACE8A6ACF8B69CE8A69CD8967CC8765CA8463C88161C57E5F
      C37A5DC1765ABE7361CC7D59CE747FAD8AF8F8F8FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF51AD5D53C36C69DA895DC4775CC1765EC37860C57B62C77F63C8
      8165CA8365CA8466CB8566CC8566CB8565CA8464C98263C78061C57E5FC47A5D
      C2785CC1765DC67869DB8952C86A93B79AFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF7EC28646AF565ED17B69DF8B6DE28F6EE2926FE39370E39572E4
      9874E49A74E59C75E49D75E59D75E49D74E49C73E49A72E39770E3956FE2936D
      E2906DE28F69DF8B5BCF7747AB54E0E3E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF5FAF6CEE9D258B36441AA5140A84E40A84F42A95144AD5444AC
      5545AD5644AD5545AD5645AD5645AC5544AD5544AD5544AC5543AC5441A85040
      A84F40A84E42AB5263B96ECAD6CBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFAFDFBF5FAF6F5FAF5F5F9F5F6FBF6F7FDF8F6FD
      F6F5FCF5F3FCF4F3FCF3F3FCF3F3FCF3F4FCF5F5FCF6F6FDF7F7FDF8F5FAF6F5
      FAF5F5FAF5F6FAF6FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
    Left = 464
    Top = 394
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
end
