unit membro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes,
  ComCtrls, funcaolocal ;

type
  Tfrmmembro = class(TForm)
    Label3: TLabel;
    DBGrid1: TDBGrid;
    incluir: TBitBtn;
    editar: TBitBtn;
    sair: TBitBtn;
    excluir: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    op1: TRadioButton;
    op2: TRadioButton;
    op3: TRadioButton;
    GroupBox2: TGroupBox;
    pt1: TRadioButton;
    pt2: TRadioButton;
    pt3: TRadioButton;
    pt4: TRadioButton;
    GroupBox3: TGroupBox;
    a1: TRadioButton;
    a2: TRadioButton;
    a3: TRadioButton;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    ExportarFotos1: TMenuItem;
    Sair1: TMenuItem;
    InativarMembro1: TMenuItem;
    procedure Edit1Exit(Sender: TObject);
    procedure sairClick(Sender: TObject);
    procedure incluirClick(Sender: TObject);
    procedure editarClick(Sender: TObject);
    procedure op1Click(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure excluirClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure InativarMembro1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmmembro: Tfrmmembro;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses cadmembro, datamodule10 , principal;


{$R *.DFM}


procedure Tfrmmembro.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmmembro.sairClick(Sender: TObject);
begin
  frmmembro.close;
end;

procedure Tfrmmembro.incluirClick(Sender: TObject);
begin
 frmcadmembro.tag:=1;
 frmcadmembro.showmodal;
 data10.mytudo.Refresh;
 frmmembro.Caption:='Membros = '+inttostr(data10.mytudo.recordcount);
end;

procedure Tfrmmembro.editarClick(Sender: TObject);
var
  x,ocod:string;
begin
  frmprincipal.c_agora;
  if data10.mytudo.RecordCount>0 then begin
    ocod:=data10.mytudo.fieldbyname('codigo').asstring;
    ucd:=ocod;
    with data10.mymostra do begin
      close;
      sql.clear;
      x:='select * from membro';
      x:=x+' where codigo='+#39+ocod+#39;
      sql.add(x);
      open;
    end;
    frmcadmembro.tag:=2;
    frmcadmembro.showmodal;
    data10.mytudo.Refresh;
    data10.mytudo.Locate('codigo',ucd,[locaseinsensitive]);
    frmmembro.Caption:='Membros = '+inttostr(data10.mytudo.recordcount);
  end;
end;

procedure Tfrmmembro.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmmembro.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmmembro.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  frmprincipal.c_agora;
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select a.Codigo,a.nome,a.celular,a.comercial,a.email,a.ativo,';
    x:=x+' b.descricao,b.telefone ';
    x:=x+' from membro a left join familia b on a.familia=b.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+') and ';
    if a1.Checked=true then begin
      x:=x+' (a.ativo='+#39+'S'+#39+') and ';
    end;
    if a2.Checked=true then begin
      x:=x+' (a.ativo='+#39+'N'+#39+') and ';
    end;
    if op1.Checked=true then begin
      x:=x+'(a.nome';
      a:='a.nome';
    end;
    if op2.Checked=true then begin
      x:=x+'(b.descricao';
      a:='b.descricao,a.nome';
    end;
    if op3.Checked=true then begin
      x:=x+'(a.codigo';
      a:='a.codigo';
    end;

    alimite:=' limit 0,'+edit3.text;
    if pt1.Checked=true then begin
      x:=x+' like '+#39+edit2.Text+'%'+#39;
    end;
    if pt2.Checked=true then begin
      x:=x+' like '+#39+'%'+edit2.Text+#39;
    end;
    if pt3.Checked=true then begin
      x:=x+' like '+#39+'%'+edit2.Text+'%'+#39;
    end;
    if pt4.Checked=true then begin
      x:=x+' = '+#39+edit2.Text+#39;
    end;
    x:=x+'))';
    aprocura:=x;
    aordem:=a;
    x:=x+' order by '+aordem+tpo+' limit 0,'+edit3.text;
    sql.add(x);
    open;
    frmmembro.Caption:='Membros = '+inttostr(recordcount);
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmmembro.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmmembro.FormShow(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DBGrid1.Columns.Count-1 Do Begin
    DBGrid1.Columns.Items[i].Title.Font.Style := [];
  end;
  aordem:='descricao';
  tpo:=' ASC ';
  dbgrid1.Columns[1].Title.Font.Style := [fsBold];

  bitbtn1.Click;
  edit2.setfocus;
end;

procedure Tfrmmembro.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmmembro.excluirClick(Sender: TObject);
var
  x,cod:string;
begin
   if (application.MessageBox('Deseja excluir o Membro?','Atenção',mb_yesno)<>id_no) then begin
    excluir.Enabled:=false;
    if data10.mytudo.RecordCount>0 then begin
      cod:=data10.mytudo.fieldbyname('codigo').asstring;

      x:='delete from membro where codigo='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      data10.mytudo.Refresh;
      frmmembro.Caption:='Membros = '+inttostr(data10.mytudo.recordcount);
    end;
  end;
  excluir.Enabled:=true;
end;

procedure Tfrmmembro.DBGrid1TitleClick(Column: TColumn);
Var
  i, iTemp : Integer;
begin
  i := 0;
  iTemp := DBGrid1.Columns.Count;
  While i < iTemp Do Begin
    DBGrid1.Columns.Items[i].Title.Font.Style := [];
    i := i + 1;
  End;
  Column.Title.Font.Style := [fsBold];
  if tpo=' ASC ' then begin
    tpo:=' DESC ';
  end else begin
    tpo:=' ASC ';
  end;
  aordem:=column.FieldName;
  with data10.mytudo do begin
    close;
    sql.clear;
    sql.add(aprocura+' order by '+aordem+tpo+alimite);
    open;
    frmmembro.Caption:='Membros = '+inttostr(recordcount);
  end;
end;

procedure Tfrmmembro.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

procedure Tfrmmembro.Button1Click(Sender: TObject);
var
  narq,x,c0,c1,c2,c3,c4,c5:string;
  f:textfile;
begin
  narq:='C:\Users\ConeTec\Desktop\membros\lista_importar.txt';
  assignfile(f,narq);
  reset(f);
  while not eof(f) do begin
    readln(f,x);
    c0:=voltacod(x,'|',0);
    c1:=voltacod(x,'|',1);
    c2:=voltacod(x,'|',2);
    c3:=voltacod(x,'|',3);
    c4:=voltacod(x,'|',4);
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO membro ';
      x:=x+'(codigo, igreja ,nome, nascimento, familia, estadocivil, celular, comercial, email, profissao, batizado, databatismo, carta, observacoes, sexo, genitor, anp, classe) ';
      x:=x+'VALUES (NULL,';                               // codigo
      x:=x+#39+frmprincipal.Configura[3]+#39+',';         // igreja
      x:=x+#39+tmaiusculo(c0)+#39+',';                                // nome
      x:=x+#39+mydata(c1)+#39+',';                        // nascimento
      x:=x+#39+'1'+#39+',';                               // familia
      x:=x+#39+tmaiusculo(c4)+#39+',';                    // estadocivil
      x:=x+#39+''+#39+',';                    // celular
      x:=x+#39+''+#39+',';                    // comercial
      x:=x+#39+''+#39+',';                        // email
      x:=x+#39+'1'+#39+',';                        // profissao
      x:=x+#39+'SIM'+#39+',';                    // batizado
      x:=x+#39+mydata(c2)+#39+',';                // databatismo
      x:=x+#39+'CENTRAL FOZ'+#39+',';                        // carta
      x:=x+#39+''+#39+',';            // observacoes
      x:=x+#39+TMAIUSCULO(c3)+#39+',';                    // sexo
      x:=x+#39+'NÃO'+#39+',';                    // genitor
      x:=x+#39+''+#39+',';                        // associacao
      x:=x+#39+''+#39;                       // classe
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
  end;
  closefile(f);
  application.messagebox('','',mb_ok);
end;

procedure Tfrmmembro.InativarMembro1Click(Sender: TObject);
var
  x:string;
begin
  x:='Deseja Inativar o Membro?'+#13+data10.mytudo.fieldbyname('nome').asstring;
  if (application.MessageBox(pchar(x),'Atenção',mb_yesno)<>id_no) then begin
    if data10.mytudo.RecordCount>0 then begin

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE membro SET ';
        x:=x+'ativo='+#39+'N'+#39;                                             // ativo
        x:=x+' where codigo='+#39+data10.mytudo.fieldbyname('codigo').asstring+#39;
        sql.add(x);
        ExecSql;
      end;
      data10.mytudo.Refresh;
    end;
  end;
end;

end.
