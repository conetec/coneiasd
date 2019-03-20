unit nivel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db;

type
  Tfrmnivel = class(TForm)
    Label3: TLabel;
    DBGrid1: TDBGrid;
    incluir: TBitBtn;
    editar: TBitBtn;
    sair: TBitBtn;
    excluir: TBitBtn;
    Edit1: TEdit;
    procedure sairClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure incluirClick(Sender: TObject);
    procedure editarClick(Sender: TObject);
    procedure excluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmnivel: Tfrmnivel;

implementation

uses datamodule10, cadnivel, principal;

{$R *.DFM}

function espaco(frase:string;tam:integer):string;
var
  x:string;
  i:integer;
begin
  x:='';
  for i:=1 to tam-length(frase) do begin
    x:=x+' ';
  end;
  espaco:=frase+x;
end;

procedure Tfrmnivel.sairClick(Sender: TObject);
begin
  frmnivel.close;
end;

procedure Tfrmnivel.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
end;

procedure Tfrmnivel.FormActivate(Sender: TObject);
begin
  with data10.mytudo do begin
    close;
    sql.Clear;
    sql.add('select * from nivel where igreja='+#39+frmprincipal.Configura[3]+#39+' order by codigo');
    open;
    frmnivel.Caption:='Níveis de Acesso = '+inttostr(recordcount);
  end;
end;

procedure Tfrmnivel.Edit1Exit(Sender: TObject);
begin
  edit1.text:=''
end;

procedure Tfrmnivel.incluirClick(Sender: TObject);
begin
  frmcadnivel.tag:=1;
  frmcadnivel.showmodal;
  with data10.mytudo do begin
    close;
    sql.Clear;
    sql.add('select * from nivel order by codigo');
    open;
    frmnivel.Caption:='Níveis de Acesso = '+inttostr(recordcount);
  end;
  
end;

procedure Tfrmnivel.editarClick(Sender: TObject);
begin
  frmcadnivel.tag:=2;
  frmcadnivel.showmodal;
  with data10.mytudo do begin
    close;
    sql.Clear;
    sql.add('select * from nivel order by codigo');
    open;
    frmnivel.Caption:='Níveis de Acesso = '+inttostr(recordcount);
  end;
  
end;

procedure Tfrmnivel.excluirClick(Sender: TObject);
var
  x:string;
begin
  if trim(data10.mytudo.FieldByName('codigo').asstring)<>'1' then begin
  if application.MessageBox('Confirma Exclusão?','ATENÇÃO!!!',mb_okcancel)<>idcancel then begin
    x:='delete from nivel where codigo='+data10.mytudo.fieldbyname('codigo').asstring;
    with data10.exemysql do begin
      sql.clear;
      sql.add(x);
      ExecSql;
    end;
    data10.mytudo.Refresh;
    frmnivel.Caption:='Níveis de Acesso = '+inttostr(data10.mytudo.recordcount);
  end;
  end else begin
    application.MessageBox('Nível Código = 1 NÃO pode ser Excluído','Atenção',mb_ok);
  end;
end;

end.
