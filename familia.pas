unit familia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes ;

type
  Tfrmfamilia = class(TForm)
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
    op5: TRadioButton;
    op4: TRadioButton;
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
  frmfamilia: Tfrmfamilia;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses cadfamilia, datamodule10 , principal;


{$R *.DFM}


procedure Tfrmfamilia.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmfamilia.sairClick(Sender: TObject);
begin
  frmfamilia.close;
end;

procedure Tfrmfamilia.incluirClick(Sender: TObject);
begin
 frmcadfamilia.tag:=1;
 frmcadfamilia.showmodal;
 data10.mytudo.Refresh;
 frmfamilia.Caption:='Fam�lias = '+inttostr(data10.mytudo.recordcount);
end;

procedure Tfrmfamilia.editarClick(Sender: TObject);
var
  x,ocod:string;
begin
  if data10.mytudo.RecordCount>0 then begin
    ocod:=data10.mytudo.fieldbyname('codigo').asstring;
    ucd:=ocod;
    with data10.mymostra do begin
      close;
      sql.clear;
      x:='select * from familia';
      x:=x+' where codigo='+#39+ocod+#39;
      sql.add(x);
      open;
    end;
    frmcadfamilia.tag:=2;
    frmcadfamilia.showmodal;
    data10.mytudo.Refresh;
    data10.mytudo.Locate('codigo',ucd,[locaseinsensitive]);
    frmfamilia.Caption:='Fam�lias = '+inttostr(data10.mytudo.recordcount);
  end;
end;

procedure Tfrmfamilia.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmfamilia.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmfamilia.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  frmprincipal.c_agora;
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select Codigo,descricao,endereco,bairro,telefone,ativo from familia ';
    x:=x+' where (';
    x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+') and ';
    if a1.Checked=true then begin
      x:=x+' (ativo='+#39+'S'+#39+') and ';
    end;
    if a2.Checked=true then begin
      x:=x+' (ativo='+#39+'N'+#39+') and ';
    end;
    if op1.Checked=true then begin
      x:=x+'(descricao';
      a:='descricao';
    end;
    if op2.Checked=true then begin
      x:=x+'(telefone';
      a:='telefone,descricao';
    end;
    if op3.Checked=true then begin
      x:=x+'(endereco';
      a:='endereco,descricao';
    end;
    if op4.Checked=true then begin
      x:=x+'(bairro';
      a:='bairro,descricao';
    end;
    if op5.Checked=true then begin
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
    frmfamilia.Caption:='Fam�lias = '+inttostr(recordcount);
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmfamilia.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmfamilia.FormShow(Sender: TObject);
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

procedure Tfrmfamilia.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmfamilia.excluirClick(Sender: TObject);
var
  x,cod:string;
begin
   if (application.MessageBox('Deseja excluir a Fam�lia?','Aten��o',mb_yesno)<>id_no) then begin
    excluir.Enabled:=false;
    if data10.mytudo.RecordCount>0 then begin
      cod:=data10.mytudo.fieldbyname('codigo').asstring;

      x:='delete from familia where codigo='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      data10.mytudo.Refresh;
      frmfamilia.Caption:='Fam�lias = '+inttostr(data10.mytudo.recordcount);
    end;
  end;
  excluir.Enabled:=true;
end;

procedure Tfrmfamilia.DBGrid1TitleClick(Column: TColumn);
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
    frmfamilia.Caption:='Fam�lias = '+inttostr(recordcount);
  end;
end;

procedure Tfrmfamilia.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

end.
