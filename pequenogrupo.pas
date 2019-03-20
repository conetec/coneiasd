unit pequenogrupo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes,
  ComCtrls, funcaolocal ;

type
  Tfrmpequenogrupo = class(TForm)
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
  frmpequenogrupo: Tfrmpequenogrupo;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses cadpequenogrupo, datamodule10 , principal, participa_pg;


{$R *.DFM}


procedure Tfrmpequenogrupo.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmpequenogrupo.sairClick(Sender: TObject);
begin
  frmpequenogrupo.close;
end;

procedure Tfrmpequenogrupo.incluirClick(Sender: TObject);
begin
 frmcadpequenogrupo.tag:=1;
 frmcadpequenogrupo.showmodal;
 data10.mytudo.Refresh;
 frmpequenogrupo.Caption:='Pequenos Grupos = '+inttostr(data10.mytudo.recordcount);
end;

procedure Tfrmpequenogrupo.editarClick(Sender: TObject);
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
      x:='select * from pequenogrupo';
      x:=x+' where codigo='+#39+ocod+#39;
      sql.add(x);
      open;
    end;
    frmcadpequenogrupo.tag:=2;
    frmcadpequenogrupo.showmodal;
    data10.mytudo.Refresh;
    data10.mytudo.Locate('codigo',ucd,[locaseinsensitive]);
    frmpequenogrupo.Caption:='Pequenos Grupos = '+inttostr(data10.mytudo.recordcount);
  end;
end;

procedure Tfrmpequenogrupo.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmpequenogrupo.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmpequenogrupo.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  frmprincipal.c_agora;
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select a.Codigo,a.descricao,a.endereco,a.descricaodia,a.horario,a.numpessoas,';
    x:=x+' b.nome,c.telefone ';
    x:=x+' from pequenogrupo a left join membro b on a.membro=b.codigo left join familia c on b.familia=c.codigo';
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
    frmpequenogrupo.Caption:='Pequenos Grupos = '+inttostr(recordcount);
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmpequenogrupo.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmpequenogrupo.FormShow(Sender: TObject);
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

procedure Tfrmpequenogrupo.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;


procedure Tfrmpequenogrupo.marca_pg(wtipo,wcodigo:string);
var
  w,wa,wb:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  w:='select codigo from participa_pg where tipo='+#39+wtipo+#39+' and codtipo='+#39+wcodigo+#39+' limit 0,1';
  data10.mypgax.close;
  data10.mypgax.sql.clear;
  data10.mypgax.sql.add(w);
  data10.mypgax.open;
  if data10.mypgax.recordcount=1 then begin
    a:=1;
  end;
  if (wtipo='M') then begin
    wb:='membro';
    if (a=0) then begin wa:='NÃO'; end else begin wa:='SIM'; end;
  end;
  if (wtipo='A') then begin
    wb:='amigo';
    if (a=0) then begin wa:='N'; end else begin wa:='S'; end;
  end;

  with data10.exemysql do begin
    sql.clear;
    w:='UPDATE '+wb+' SET ';
    w:=w+'pg='+#39+wa+#39;                                  // pg
    w:=w+' where codigo='+#39+wcodigo+#39;
    sql.add(w);
    ExecSql;
  end;

end;

procedure Tfrmpequenogrupo.excluirClick(Sender: TObject);
var
  x,cod:string;
  xmemo:Tmemo;
  i:integer;
begin
  if data10.mytudo.RecordCount>0 then begin
    if (application.MessageBox('Deseja excluir o Pequeno Grupo?','Atenção',mb_yesno)<>id_no) then begin
      excluir.Enabled:=false;
      cod:=data10.mytudo.fieldbyname('codigo').asstring;

      x:='delete from pequenogrupo where codigo='+#39+cod+#39;
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
      data10.mypg.sql.add('select * from participa_pg where pequenogrupo='+#39+cod+#39);
      data10.mypg.open;
      data10.mypg.first;
      while data10.mypg.eof=false do begin
        x:=data10.mypg.fieldbyname('tipo').asstring+'|'+data10.mypg.fieldbyname('codtipo').asstring;
        xmemo.lines.add(x);
        data10.mypg.next;
      end;

      x:='delete from participa_pg where pequenogrupo='+#39+cod+#39;
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
      frmpequenogrupo.Caption:='Pequenos Grupos = '+inttostr(data10.mytudo.recordcount);
    end;
  end;
  excluir.Enabled:=true;
end;

procedure Tfrmpequenogrupo.DBGrid1TitleClick(Column: TColumn);
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
    frmpequenogrupo.Caption:='Pequenos Grupos = '+inttostr(recordcount);
  end;
end;

procedure Tfrmpequenogrupo.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

procedure Tfrmpequenogrupo.BitBtn2Click(Sender: TObject);
begin
  frmprincipal.c_agora;
  if data10.mytudo.RecordCount>0 then begin
    Application.CreateForm(Tfrmparticipa_pg, frmparticipa_pg);
    frmparticipa_pg.edit1.text:=data10.mytudo.fieldbyname('codigo').asstring;
    frmparticipa_pg.showmodal;
    frmparticipa_pg.Free;
    data10.mytudo.Refresh;
  end;
end;

end.
