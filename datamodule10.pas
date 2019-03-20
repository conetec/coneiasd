unit datamodule10;

interface

uses
  SysUtils, Classes, DB, Forms, QForms, ZDataset, ZAbstractRODataset,
  ZAbstractDataset, ZConnection, ZAbstractTable, RLPreviewForm,
  RLXLSFilter, RLPDFFilter, RLHTMLFilter, RLFilters, RLRichFilter,
  RLDraftFilter, RLParser,Dialogs, ExtCtrls,  StdCtrls, Buttons, Messages,Windows,Graphics, Controls;
//   ,
//  , Menus, jpeg, Grids, db,
//  DBGrids;


type
  Tdata10 = class(TDataModule)
    ligamytudo: TDataSource;
    ligamyaux: TDataSource;
    mysqldata: TZConnection;
    mytudo: TZQuery;
    exemysql: TZReadOnlyQuery;
    myaux: TZQuery;
    myinfo: TZQuery;
    ligamysenha: TDataSource;
    mysenha: TZQuery;
    ligamyagenda: TDataSource;
    myagenda: TZQuery;
    ligamycomp: TDataSource;
    mycomp: TZQuery;
    myucodigo: TZQuery;
    mymostra: TZQuery;
    ligamyaux10: TDataSource;
    myaux10: TZQuery;
    ligamyprocura: TDataSource;
    myprocura: TZQuery;
    ligamypresente: TDataSource;
    mypresente: TZQuery;
    ligamyfuncao: TDataSource;
    myfuncao: TZQuery;
    myauxsl: TZQuery;
    ligamyrel: TDataSource;
    myrel: TZQuery;
    mytabela: TZTable;
    myfoto: TZQuery;
    myimgfoto: TZTable;
    myfsab: TZQuery;
    myaluno: TZQuery;
    RLExpressionParser1: TRLExpressionParser;
    RLDraftFilter1: TRLDraftFilter;
    RLRichFilter1: TRLRichFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    RLPDFFilter1: TRLPDFFilter;
    RLXLSFilter1: TRLXLSFilter;
    RLPreviewSetup1: TRLPreviewSetup;
    myaxconecta: TZQuery;
    myedupla: TZQuery;
    myitem1: TZQuery;
    mypg: TZQuery;
    ligamypg: TDataSource;
    mypgax: TZQuery;
    myimp: TZQuery;
    ligamyimp: TDataSource;
    myestornasabado: TZQuery;
    ligamyclasse: TDataSource;
    myclasse: TZQuery;
    myalunos: TZQuery;
    myapresente: TZQuery;
    myPerguntas: TZQuery;
    myAponta: TZQuery;
    procedure exemysqlAfterRefresh(DataSet: TDataSet);
    procedure mytudoBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  data10: Tdata10;

implementation

uses principal;

{$R *.dfm}

procedure Tdata10.exemysqlAfterRefresh(DataSet: TDataSet);
begin
  frmprincipal.c_agora;
end;

procedure Tdata10.mytudoBeforeClose(DataSet: TDataSet);
begin
  frmprincipal.c_agora;
end;

end.
