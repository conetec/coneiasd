unit aluno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes,
  ComCtrls, funcaolocal ;

type
  Tfrmaluno = class(TForm)
    Label3: TLabel;
    DBGrid1: TDBGrid;
    incluir: TBitBtn;
    editar: TBitBtn;
    sair: TBitBtn;
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
    PopupMenu1: TPopupMenu;
    Sair1: TMenuItem;
    InativarMembro1: TMenuItem;
    op4: TRadioButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    ckfoto: TCheckBox;
    timerfoto: TTimer;
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
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure InativarMembro1Click(Sender: TObject);
    procedure timerfotoTimer(Sender: TObject);
    procedure ckfotoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmaluno: Tfrmaluno;
  aordem,aprocura,alimite,tpo,ucd,ucodfoto:string;

implementation

uses cadaluno, datamodule10 , principal;


{$R *.DFM}


procedure Tfrmaluno.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmaluno.sairClick(Sender: TObject);
begin
  frmaluno.close;
end;

procedure Tfrmaluno.incluirClick(Sender: TObject);
begin
 frmcadaluno.tag:=1;
 frmcadaluno.showmodal;
 data10.mytudo.Refresh;
 frmaluno.Caption:='Alunos da Escola Sabatina = '+inttostr(data10.mytudo.recordcount);
end;

procedure Tfrmaluno.editarClick(Sender: TObject);
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
    frmcadaluno.tag:=2;
    frmcadaluno.showmodal;
    data10.mytudo.Refresh;
    data10.mytudo.Locate('codigo',ucd,[locaseinsensitive]);
    frmaluno.Caption:='Alunos da Escola Sabatina = '+inttostr(data10.mytudo.recordcount);
  end;
end;

procedure Tfrmaluno.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmaluno.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmaluno.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  frmprincipal.c_agora;
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select a.classe,a.Codigo,a.nome,a.celular,a.comercial,a.email,a.ativo,';
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

    if op4.Checked=true then begin
      x:=x+'(a.classe';
      a:='a.nome';
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
    frmaluno.Caption:='Alunos da Escola Sabatina = '+inttostr(recordcount);
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmaluno.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmaluno.FormShow(Sender: TObject);
var
  i:integer;
begin
  ucodfoto:='0';
  ckfoto.Checked:=false;
  timerfoto.Tag:=0;

  for i:=0 to DBGrid1.Columns.Count-1 Do Begin
    DBGrid1.Columns.Items[i].Title.Font.Style := [];
  end;
  aordem:='descricao';
  tpo:=' ASC ';
  dbgrid1.Columns[1].Title.Font.Style := [fsBold];

  bitbtn1.Click;
  edit2.setfocus;
end;

procedure Tfrmaluno.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmaluno.DBGrid1TitleClick(Column: TColumn);
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
    frmaluno.Caption:='Alunos da Escola Sabatina = '+inttostr(recordcount);
  end;
end;

procedure Tfrmaluno.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

procedure Tfrmaluno.InativarMembro1Click(Sender: TObject);
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

procedure Tfrmaluno.timerfotoTimer(Sender: TObject);
begin
  if data10.mytudo.RecordCount>0 then begin

    if timerfoto.Tag=1 then begin
      if ckfoto.Checked=true then begin
        if ucodfoto<>data10.mytudo.fieldbyname('codigo').asstring then begin
          ucodfoto:=data10.mytudo.fieldbyname('codigo').asstring;

          with data10.myfoto do begin
            close;
            sql.clear;
            sql.add('select codigo,imagem from fotos where ((cod_tipo='+#39+ucodfoto+#39+') and (tipo='+#39+'1'+#39+')) limit 0,1');
            open;
            if recordcount=1 then begin
              frmprincipal.ExibeFoto(data10.myfoto,'imagem',image1);

            end else begin
              image1.Picture:=nil;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure Tfrmaluno.ckfotoExit(Sender: TObject);
begin
  ucodfoto:='0';
  if ckfoto.Checked=false then begin
    timerfoto.Tag:=0;
    image1.Picture:=nil;
  end else begin
    timerfoto.Tag:=1;

  end;

end;

end.
