unit amigo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes,
  ComCtrls, funcaolocal ;

type
  Tfrmamigo = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmamigo: Tfrmamigo;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses cadamigo, datamodule10 , principal;


{$R *.DFM}


procedure Tfrmamigo.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmamigo.sairClick(Sender: TObject);
begin
  frmamigo.close;
end;

procedure Tfrmamigo.incluirClick(Sender: TObject);
begin
 frmcadamigo.tag:=1;
 frmcadamigo.showmodal;
 data10.mytudo.Refresh;
 frmamigo.Caption:='Amigos = '+inttostr(data10.mytudo.recordcount);
end;

procedure Tfrmamigo.editarClick(Sender: TObject);
var
  x,ocod:string;
begin
  if data10.mytudo.RecordCount>0 then begin
    ocod:=data10.mytudo.fieldbyname('codigo').asstring;
    ucd:=ocod;
    with data10.mymostra do begin
      close;
      sql.clear;
      x:='select * from amigo';
      x:=x+' where codigo='+#39+ocod+#39;
      sql.add(x);
      open;
    end;
    frmcadamigo.tag:=2;
    frmcadamigo.showmodal;
    data10.mytudo.Refresh;
    data10.mytudo.Locate('codigo',ucd,[locaseinsensitive]);
    frmamigo.Caption:='Amigos = '+inttostr(data10.mytudo.recordcount);
  end;
end;

procedure Tfrmamigo.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmamigo.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmamigo.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select Codigo,nome,celular,telefone,ativo,';
    x:=x+' visitante,interessado,estudante,classe,pg ';
    x:=x+' from amigo';
    x:=x+' where (';
    x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+') and ';
    if a1.Checked=true then begin
      x:=x+' (ativo='+#39+'S'+#39+') and ';
    end;
    if a2.Checked=true then begin
      x:=x+' (ativo='+#39+'N'+#39+') and ';
    end;
    if op1.Checked=true then begin
      x:=x+'(nome';
      a:='nome';
    end;
    if op2.Checked=true then begin
      x:=x+'(telefone';
      a:='telefone';
    end;
    if op3.Checked=true then begin
      x:=x+'(codigo';
      a:='codigo';
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
    frmamigo.Caption:='Amigos = '+inttostr(recordcount);
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmamigo.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmamigo.FormShow(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DBGrid1.Columns.Count-1 Do Begin
    DBGrid1.Columns.Items[i].Title.Font.Style := [];
  end;
  aordem:='nome';
  tpo:=' ASC ';
  dbgrid1.Columns[1].Title.Font.Style := [fsBold];

  bitbtn1.Click;
  edit2.setfocus;
end;

procedure Tfrmamigo.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmamigo.excluirClick(Sender: TObject);
var
  x,cod:string;
begin
   if (application.MessageBox('Deseja excluir o amigo?','Aten��o',mb_yesno)<>id_no) then begin
    excluir.Enabled:=false;
    if data10.mytudo.RecordCount>0 then begin
      cod:=data10.mytudo.fieldbyname('codigo').asstring;

      x:='delete from amigo where codigo='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      data10.mytudo.Refresh;
      frmamigo.Caption:='Amigos = '+inttostr(data10.mytudo.recordcount);
    end;
  end;
  excluir.Enabled:=true;
end;

procedure Tfrmamigo.DBGrid1TitleClick(Column: TColumn);
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
    frmamigo.Caption:='Amigos = '+inttostr(recordcount);
  end;
end;

procedure Tfrmamigo.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

end.
