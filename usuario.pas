unit usuario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables ;

type
  Tfrmusuario = class(TForm)
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
    GroupBox2: TGroupBox;
    pt1: TRadioButton;
    pt2: TRadioButton;
    pt3: TRadioButton;
    GroupBox3: TGroupBox;
    a1: TRadioButton;
    a2: TRadioButton;
    a3: TRadioButton;
    pt4: TRadioButton;
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
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure excluirClick(Sender: TObject);
    procedure a1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmusuario: Tfrmusuario;
  aordem,aprocura,alimite,tpo:string;

implementation

uses cadusuario, datamodule10, principal;


{$R *.DFM}

procedure Tfrmusuario.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmusuario.sairClick(Sender: TObject);
begin
  frmusuario.close;
end;

procedure Tfrmusuario.incluirClick(Sender: TObject);
begin
 frmcadusuario.tag:=1;
 frmcadusuario.showmodal;
 data10.mytudo.Refresh;
 frmusuario.Caption:='Usuários = '+inttostr(data10.mytudo.recordcount);
end;

procedure Tfrmusuario.editarClick(Sender: TObject);
var
  x,ocod:string;
begin
  if data10.mytudo.RecordCount>0 then begin
    ocod:=data10.mytudo.fieldbyname('codigo').asstring;
    with data10.mymostra do begin
      close;
      sql.clear;
      x:='select * from nupass';
      x:=x+' where codigo='+#39+ocod+#39;
      sql.add(x);
      open;
    end;
    frmcadusuario.tag:=2;
    frmcadusuario.showmodal;
    data10.mytudo.Refresh;
    frmusuario.Caption:='Usuários = '+inttostr(data10.mytudo.recordcount);
  end;
end;

procedure Tfrmusuario.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmusuario.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('nome',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmusuario.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select nupass.Codigo,nupass.nome,nivel.descricao as dnivel';
    x:=x+' ,IF(nupass.ativo='+#39+'N'+#39+','+#39+'NÃO'+#39+','+#39+'SIM'+#39+') as mativo';
    x:=x+' from nupass,nivel ';
    x:=x+' where ';
    x:=x+' (nupass.igreja='+#39+frmprincipal.Configura[3]+#39+')';
    x:=x+' and (nupass.nivel=nivel.codigo) and ';
    if a1.Checked=true then begin
      x:=x+'(nupass.ativo<>'+#39+'N'+#39+') and ';
    end;
    if a2.Checked=true then begin
      x:=x+'(nupass.ativo='+#39+'N'+#39+') and ';
    end;

    if op1.Checked=true then begin
      x:=x+'nupass.nome';
    end;
    if op2.Checked=true then begin
      x:=x+'nupass.codigo';
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
    aprocura:=x;
    x:=x+' order by '+aordem+tpo+' limit 0,'+edit3.text;
    sql.add(x);
    open;
    frmusuario.Caption:='Usuários = '+inttostr(recordcount);
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmusuario.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmusuario.FormShow(Sender: TObject);
var
  x:string;
  i:integer;
begin



  with data10.myaux do begin
    close;
    sql.clear;
    sql.add('select * from nivel order by codigo');
    open;
    first;
    frmcadusuario.edit4.Items.Clear;
    while eof=false do begin
      frmcadusuario.edit4.Items.Add(fieldbyname('codigo').asstring+' | '+fieldbyname('descricao').asstring);
      next;
    end;
    frmcadusuario.edit4.ItemIndex:=0;
  end;

  for i:=0 to DBGrid1.Columns.Count-1 Do Begin
    DBGrid1.Columns.Items[i].Title.Font.Style := [];
  end;
  aordem:='nupass.nome';
  tpo:=' ASC ';
  dbgrid1.Columns[1].Title.Font.Style := [fsBold];

  bitbtn1.Click;
  edit2.setfocus;
end;

procedure Tfrmusuario.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmusuario.DBGrid1TitleClick(Column: TColumn);
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
    frmusuario.Caption:='Usuários = '+inttostr(recordcount);
  end;
end;

procedure Tfrmusuario.excluirClick(Sender: TObject);
var
  x:string;
begin
  if data10.mytudo.RecordCount>0 then begin
    if data10.mytudo.fieldbyname('codigo').asstring='1' then begin
      application.MessageBox('Usuário SUPERVIDOR não pode ser excluído','ATENÇÃO!!!',mb_ok);
    end else begin
      if application.MessageBox('Confirma Exclusão?','ATENÇÃO!!!',mb_yesno)<>id_no then begin
        x:='delete from usuario where codigo='+data10.mytudo.fieldbyname('codigo').asstring;
        with data10.exemysql do begin
          sql.clear;
          sql.add(x);
          ExecSql;
        end;
        data10.mytudo.Refresh;
        frmusuario.Caption:='Usuários = '+inttostr(data10.mytudo.recordcount);
      end;
    end;
  end;
end;

procedure Tfrmusuario.a1Click(Sender: TObject);
begin
  bitbtn1.Click;
  edit2.SetFocus;
end;

end.
