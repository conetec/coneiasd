object data10: Tdata10
  OldCreateOrder = False
  Left = 484
  Top = 233
  Height = 726
  Width = 1022
  object ligamytudo: TDataSource
    DataSet = mytudo
    Left = 88
    Top = 64
  end
  object ligamyaux: TDataSource
    DataSet = myaux
    Left = 88
    Top = 120
  end
  object mysqldata: TZConnection
    Protocol = 'mysql-5'
    Database = 'conealug_iasd'
    User = 'conealug_igreja'
    ReadOnly = True
    Left = 32
    Top = 16
  end
  object mytudo: TZQuery
    Connection = mysqldata
    BeforeClose = mytudoBeforeClose
    Params = <>
    Left = 32
    Top = 64
  end
  object exemysql: TZReadOnlyQuery
    Connection = mysqldata
    AfterRefresh = exemysqlAfterRefresh
    Params = <>
    Left = 88
    Top = 16
  end
  object myaux: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 32
    Top = 120
  end
  object myinfo: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 216
    Top = 16
  end
  object ligamysenha: TDataSource
    DataSet = mysenha
    Left = 96
    Top = 256
  end
  object mysenha: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 32
    Top = 256
  end
  object ligamyagenda: TDataSource
    DataSet = myagenda
    Left = 96
    Top = 312
  end
  object myagenda: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 32
    Top = 312
  end
  object ligamycomp: TDataSource
    DataSet = mycomp
    Left = 96
    Top = 368
  end
  object mycomp: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 32
    Top = 368
  end
  object myucodigo: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 272
    Top = 16
  end
  object mymostra: TZQuery
    Connection = mysqldata
    BeforeClose = mytudoBeforeClose
    Params = <>
    Left = 216
    Top = 72
  end
  object ligamyaux10: TDataSource
    DataSet = myaux10
    Left = 88
    Top = 176
  end
  object myaux10: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 32
    Top = 176
  end
  object ligamyprocura: TDataSource
    DataSet = myprocura
    Left = 280
    Top = 152
  end
  object myprocura: TZQuery
    Connection = mysqldata
    BeforeClose = mytudoBeforeClose
    Params = <>
    Left = 216
    Top = 152
  end
  object ligamypresente: TDataSource
    DataSet = mypresente
    Left = 280
    Top = 216
  end
  object mypresente: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 208
    Top = 216
  end
  object ligamyfuncao: TDataSource
    DataSet = myfuncao
    Left = 280
    Top = 272
  end
  object myfuncao: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 216
    Top = 272
  end
  object myauxsl: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 272
    Top = 80
  end
  object ligamyrel: TDataSource
    DataSet = myrel
    Left = 504
    Top = 24
  end
  object myrel: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 440
    Top = 24
  end
  object mytabela: TZTable
    Connection = mysqldata
    TableName = 'logotipo'
    Left = 480
    Top = 120
  end
  object myfoto: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 432
    Top = 120
  end
  object myimgfoto: TZTable
    Connection = mysqldata
    TableName = 'fotos'
    Left = 432
    Top = 184
  end
  object myfsab: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 216
    Top = 352
  end
  object myaluno: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 280
    Top = 352
  end
  object RLExpressionParser1: TRLExpressionParser
    Left = 352
    Top = 560
  end
  object RLDraftFilter1: TRLDraftFilter
    Left = 440
    Top = 560
  end
  object RLRichFilter1: TRLRichFilter
    DisplayName = 'Formato RichText'
    Left = 512
    Top = 560
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'P'#225'gina da Web'
    Left = 584
    Top = 560
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport (Open Source) v3.70B \251 Copyright '#169' 1999-2009 For' +
      'tes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 656
    Top = 560
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel'
    Left = 720
    Top = 560
  end
  object RLPreviewSetup1: TRLPreviewSetup
    Left = 792
    Top = 560
  end
  object myaxconecta: TZQuery
    Connection = mysqldata
    SQL.Strings = (
      'select nupass.codigo from nupass limit 0,1')
    Params = <>
    Left = 624
    Top = 352
  end
  object myedupla: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 216
    Top = 408
  end
  object myitem1: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 424
    Top = 272
  end
  object mypg: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 216
    Top = 480
  end
  object ligamypg: TDataSource
    DataSet = mypg
    Left = 264
    Top = 480
  end
  object mypgax: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 216
    Top = 536
  end
  object myimp: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 368
    Top = 440
  end
  object ligamyimp: TDataSource
    DataSet = myimp
    Left = 432
    Top = 440
  end
  object myestornasabado: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 416
    Top = 360
  end
  object ligamyclasse: TDataSource
    DataSet = myclasse
    Left = 728
    Top = 64
  end
  object myclasse: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 664
    Top = 64
  end
  object myalunos: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 664
    Top = 128
  end
  object myapresente: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 664
    Top = 184
  end
  object myPerguntas: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 752
    Top = 128
  end
  object myAponta: TZQuery
    Connection = mysqldata
    Params = <>
    Left = 752
    Top = 192
  end
end
