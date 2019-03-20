unit usuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db;

type
  Tfrmusuario = class(TForm)
    Label3: TLabel;
    DBGrid1: TDBGrid;
    incluir: TBitBtn;
    editar: TBitBtn;
    sair: TBitBtn;
    excluir: TBitBtn;
    Edit1: TEdit;
    PopupMenu1: TPopupMenu;
    OrdemdeCdigo1: TMenuItem;
    OrdemdeUsurio1: TMenuItem;
    procedure sairClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure incluirClick(Sender: TObject);
    procedure editarClick(Sender: TObject);
    procedure excluirClick(Sender: TObject);
    procedure OrdemdeCdigo1Click(Sender: TObject);
    procedure OrdemdeUsurio1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmusuario: Tfrmusuario;

implementation

uses datamodule10, cadusuario;

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

procedure Tfrmusuario.sairClick(Sender: TObject);
begin
  frmusuario.close;
end;

procedure Tfrmusuario.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    data10.mysenha.Locate('nome',edit1.text,[lopartialkey]);
end;

procedure Tfrmusuario.FormActivate(Sender: TObject);
begin
  with data10.mysenha do begin
    close;
    sql.Clear;
    sql.add('select * from nupass order by nome');
    open;
    frmusuario.Caption:='Usuários = '+inttostr(recordcount);
  end;

  with data10.myaux do begin
    close;
    sql.clear;
    sql.add('select * from nivel order by codigo');
    open;
    first;
    frmcadusu.edit4.Items.Clear;
    while eof=false do begin
      frmcadusu.edit4.Items.Add(fieldbyname('descricao').asstring+' | '+fieldbyname('codigo').asstring);
      next;
    end;
    frmcadusu.edit4.ItemIndex:=-1;
  end;

end;

procedure Tfrmusuario.Edit1Exit(Sender: TObject);
begin
  edit1.text:=''
end;

procedure Tfrmusuario.incluirClick(Sender: TObject);
begin
  frmcadusu.tag:=1;
  frmcadusu.showmodal;
end;

procedure Tfrmusuario.editarClick(Sender: TObject);
begin
  frmcadusu.tag:=2;
  frmcadusu.showmodal;
end;

procedure Tfrmusuario.excluirClick(Sender: TObject);
var
  x:string;
begin
  if application.MessageBox('Confirma Exclusão?','ATENÇÃO!!!',mb_okcancel)<>idcancel then begin
    x:='delete from nupass where codigo='+data10.mysenha.fieldbyname('codigo').asstring;
    with data10.exemysql do begin
      sql.clear;
      sql.add(x);
      ExecSql;
    end;
    data10.mysenha.Refresh;
    frmusuario.Caption:='Usuários = '+inttostr(data10.mysenha.recordcount);
  end;
end;

procedure Tfrmusuario.OrdemdeCdigo1Click(Sender: TObject);
begin
 with data10.mysenha do begin
   close;
   sql.Clear;
   sql.Add('select * from nupass order by codigo');
   open;
 end;
end;

procedure Tfrmusuario.OrdemdeUsurio1Click(Sender: TObject);
begin
    with data10.mysenha do begin
      close;
      sql.Clear;
      sql.Add('select * from nupass order by nome');
      open;
    end;
end;

end.
