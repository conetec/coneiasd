unit classebiblica;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes,
  ComCtrls, funcaolocal ;

type
  Tfrmclassebiblica = class(TForm)
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
    BitBtn2: TBitBtn;
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
    procedure BitBtn2Click(Sender: TObject);
    procedure marca_pg(wtipo,wcodigo:string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmclassebiblica: Tfrmclassebiblica;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses cadclassebiblica, datamodule10 , principal, participa_cb;


{$R *.DFM}


procedure Tfrmclassebiblica.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmclassebiblica.sairClick(Sender: TObject);
begin
  frmclassebiblica.close;
end;

procedure Tfrmclassebiblica.incluirClick(Sender: TObject);
begin
 frmcadclassebiblica.tag:=1;
 frmcadclassebiblica.showmodal;
 data10.mytudo.Refresh;
 frmclassebiblica.Caption:='Classes Bíblicas = '+inttostr(data10.mytudo.recordcount);
end;

procedure Tfrmclassebiblica.editarClick(Sender: TObject);
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
      x:='select * from classebiblica';
      x:=x+' where codigo='+#39+ocod+#39;
      sql.add(x);
      open;
    end;
    frmcadclassebiblica.tag:=2;
    frmcadclassebiblica.showmodal;
    data10.mytudo.Refresh;
    data10.mytudo.Locate('codigo',ucd,[locaseinsensitive]);
    frmclassebiblica.Caption:='Classes Bíblicas = '+inttostr(data10.mytudo.recordcount);
  end;
end;

procedure Tfrmclassebiblica.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmclassebiblica.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmclassebiblica.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  frmprincipal.c_agora;
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select a.Codigo,a.descricao,a.endereco,a.descricaodia,a.horario,a.numpessoas,';
    x:=x+' b.nome,c.telefone ';
    x:=x+' from classebiblica a left join membro b on a.membro=b.codigo left join familia c on b.familia=c.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+') and ';
    if a1.Checked=true then begin
      x:=x+' (a.ativo='+#39+'S'+#39+') and ';
    end;
    if a2.Checked=true then begin
      x:=x+' (a.ativo='+#39+'N'+#39+') and ';
    end;
    if op1.Checked=true then begin
      x:=x+'(b.nome';
      a:='b.nome';
    end;
    if op2.Checked=true then begin
      x:=x+'(a.descricao';
      a:='a.descricao,b.nome';
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
    frmclassebiblica.Caption:='Classes Bíblicas = '+inttostr(recordcount);
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmclassebiblica.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmclassebiblica.FormShow(Sender: TObject);
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

procedure Tfrmclassebiblica.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;


procedure Tfrmclassebiblica.marca_pg(wtipo,wcodigo:string);
var
  w,wa,wb:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  w:='select codigo from participa_cb where tipo='+#39+wtipo+#39+' and codtipo='+#39+wcodigo+#39+' limit 0,1';
  data10.mypgax.close;
  data10.mypgax.sql.clear;
  data10.mypgax.sql.add(w);
  data10.mypgax.open;
  if data10.mypgax.recordcount=1 then begin
    a:=1;
  end;
  if (wtipo='A') then begin
    wb:='amigo';
    if (a=0) then begin wa:='N'; end else begin wa:='S'; end;

    with data10.exemysql do begin
      sql.clear;
      w:='UPDATE '+wb+' SET ';
      w:=w+'pg='+#39+wa+#39;                                  // pg
      w:=w+' where codigo='+#39+wcodigo+#39;
      sql.add(w);
      ExecSql;
    end;
  end;

end;

procedure Tfrmclassebiblica.excluirClick(Sender: TObject);
var
  x,cod:string;
  xmemo:Tmemo;
  i:integer;
begin
  if data10.mytudo.RecordCount>0 then begin
    if (application.MessageBox('Deseja excluir o Pequeno Grupo?','Atenção',mb_yesno)<>id_no) then begin
      excluir.Enabled:=false;
      cod:=data10.mytudo.fieldbyname('codigo').asstring;

      x:='delete from classebiblica where codigo='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      // Maiuscula no onkeypress do memo -->   Key := AnsiUpperCase( Key )[1];
      xmemo := TMemo.Create(self);
      xmemo.Parent:=Self;
      xmemo.Visible:=false;
      xmemo.ScrollBars:=ssBoth;
      xmemo.Clear;

      data10.mypg.close;
      data10.mypg.sql.clear;
      data10.mypg.sql.add('select * from participa_cb where classebiblica='+#39+cod+#39);
      data10.mypg.open;
      data10.mypg.first;
      while data10.mypg.eof=false do begin
        x:=data10.mypg.fieldbyname('tipo').asstring+'|'+data10.mypg.fieldbyname('codtipo').asstring;
        xmemo.lines.add(x);
        data10.mypg.next;
      end;

      x:='delete from participa_cb where classebiblica='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      for i:=1 to xmemo.Lines.Count-1 do begin
        x:=xmemo.lines[i];
        marca_pg(voltacod(x,'|',0),voltacod(x,'|',1));
      end;

      xmemo.free;
      xmemo:=nil;
      data10.mytudo.Refresh;
      frmclassebiblica.Caption:='Classes Bíblicas = '+inttostr(data10.mytudo.recordcount);
    end;
  end;
  excluir.Enabled:=true;
end;

procedure Tfrmclassebiblica.DBGrid1TitleClick(Column: TColumn);
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
    frmclassebiblica.Caption:='Classes Bíblicas = '+inttostr(recordcount);
  end;
end;

procedure Tfrmclassebiblica.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

procedure Tfrmclassebiblica.BitBtn2Click(Sender: TObject);
begin
  frmprincipal.c_agora;
  if data10.mytudo.RecordCount>0 then begin
    Application.CreateForm(Tfrmparticipa_cb, frmparticipa_cb);
    frmparticipa_cb.edit1.text:=data10.mytudo.fieldbyname('codigo').asstring;
    frmparticipa_cb.showmodal;
    frmparticipa_cb.Free;
    data10.mytudo.Refresh;
  end;
end;

end.
