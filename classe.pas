unit classe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes ;

type
  Tfrmclasse = class(TForm)
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
    pt4: TRadioButton;
    GroupBox3: TGroupBox;
    a1: TRadioButton;
    a2: TRadioButton;
    a3: TRadioButton;
    op3: TRadioButton;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmclasse: Tfrmclasse;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses cadclasse, datamodule10 , principal, participa_classe;


{$R *.DFM}


procedure Tfrmclasse.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmclasse.sairClick(Sender: TObject);
begin
  frmclasse.close;
end;

procedure Tfrmclasse.incluirClick(Sender: TObject);
begin
 frmcadclasse.tag:=1;
 frmcadclasse.showmodal;
 data10.mytudo.Refresh;
 frmclasse.Caption:='Classes da Escola Sabatina = '+inttostr(data10.mytudo.recordcount);
end;

procedure Tfrmclasse.editarClick(Sender: TObject);
var
  x,ocod:string;
begin
  if data10.mytudo.RecordCount>0 then begin
    ocod:=data10.mytudo.fieldbyname('codigo').asstring;
    ucd:=ocod;
    with data10.mymostra do begin
      close;
      sql.clear;
      x:='select * from classe';
      x:=x+' where codigo='+#39+ocod+#39;
      sql.add(x);
      open;
    end;
    frmcadclasse.tag:=2;
    frmcadclasse.showmodal;
    data10.mytudo.Refresh;
    data10.mytudo.Locate('codigo',ucd,[locaseinsensitive]);
    frmclasse.Caption:='Classes da Escola Sabatina = '+inttostr(data10.mytudo.recordcount);
  end;
end;

procedure Tfrmclasse.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmclasse.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmclasse.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select Codigo,descricao,numero from classe ';
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
      a:='numero,descricao';
    end;
    if op2.Checked=true then begin
      x:=x+'(codigo';
      a:='codigo';
    end;
    if op3.Checked=true then begin
      x:=x+'(numero';
      a:='numero';
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
    frmclasse.Caption:='Classes da Escola Sabatina = '+inttostr(recordcount);
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmclasse.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmclasse.FormShow(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DBGrid1.Columns.Count-1 Do Begin
    DBGrid1.Columns.Items[i].Title.Font.Style := [];
  end;
  aordem:='numero';
  tpo:=' ASC ';
  dbgrid1.Columns[2].Title.Font.Style := [fsBold];

  bitbtn1.Click;
  edit2.setfocus;
end;

procedure Tfrmclasse.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmclasse.excluirClick(Sender: TObject);
var
  x,cod:string;
begin
   if (application.MessageBox('Deseja excluir a Classe?','Atenção',mb_yesno)<>id_no) then begin
    excluir.Enabled:=false;
    if data10.mytudo.RecordCount>0 then begin
      cod:=data10.mytudo.fieldbyname('codigo').asstring;

      x:='delete from classe where codigo='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      data10.mytudo.Refresh;
      frmclasse.Caption:='Classes da Escola Sabatina = '+inttostr(data10.mytudo.recordcount);
    end;
  end;
  excluir.Enabled:=true;
end;

procedure Tfrmclasse.DBGrid1TitleClick(Column: TColumn);
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
    frmclasse.Caption:='Classes da Escola Sabatina = '+inttostr(recordcount);
  end;
end;

procedure Tfrmclasse.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

procedure Tfrmclasse.BitBtn2Click(Sender: TObject);
begin
  frmprincipal.c_agora;
  if data10.mytudo.RecordCount>0 then begin
    Application.CreateForm(Tfrmparticipa_classe, frmparticipa_classe);
    frmparticipa_classe.edit1.text:=data10.mytudo.fieldbyname('codigo').asstring;
    frmparticipa_classe.edit2.text:=data10.mytudo.fieldbyname('descricao').asstring;
    frmparticipa_classe.showmodal;
    frmparticipa_classe.Free;
    data10.mytudo.Refresh;
  end;
end;

end.
