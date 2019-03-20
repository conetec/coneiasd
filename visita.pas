unit visita;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes,
  ComCtrls, funcaolocal, Mask, JvExMask, JvToolEdit ;

type
  Tfrmvisita = class(TForm)
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
    ck1: TCheckBox;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    datai: TJvDateEdit;
    Label4: TLabel;
    dataf: TJvDateEdit;
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
  frmvisita: Tfrmvisita;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses cadvisita, datamodule10 , principal;


{$R *.DFM}


procedure Tfrmvisita.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmvisita.sairClick(Sender: TObject);
begin
  frmvisita.close;
end;

procedure Tfrmvisita.incluirClick(Sender: TObject);
begin
 frmcadvisita.tag:=1;
 frmcadvisita.showmodal;
 data10.mytudo.Refresh;
 frmvisita.Caption:='Relação de Visitas = '+inttostr(data10.mytudo.recordcount);
end;

procedure Tfrmvisita.editarClick(Sender: TObject);
var
  x,ocod:string;
begin
  if data10.mytudo.RecordCount>0 then begin
    ocod:=data10.mytudo.fieldbyname('codigo').asstring;
    ucd:=ocod;
    with data10.mymostra do begin
      close;
      sql.clear;
      x:='select * from visita';
      x:=x+' where codigo='+#39+ocod+#39;
      sql.add(x);
      open;
    end;
    frmcadvisita.tag:=2;
    frmcadvisita.showmodal;
    data10.mytudo.Refresh;
    data10.mytudo.Locate('codigo',ucd,[locaseinsensitive]);
    frmvisita.Caption:='Relação de Visitas = '+inttostr(data10.mytudo.recordcount);
  end;
end;

procedure Tfrmvisita.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmvisita.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmvisita.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  frmprincipal.c_agora;
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select a.Codigo,a.datamov,a.pvez,a.adventista,';
    x:=x+' b.nome,b.cidade,b.estado ';
    x:=x+' from visita a left join amigo b on a.amigo=b.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+') and ';
    if ck1.Checked=true then begin
      x:=x+' and (a.datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (a.datamov<='+#39+mydata(dataf.text)+#39+')';
    end;
    if op1.Checked=true then begin
      x:=x+'(b.nome';
      a:='b.nome';
    end;
    if op2.Checked=true then begin
      x:=x+'(b.cidade';
      a:='b.cidade,b.nome';
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
    frmvisita.Caption:='Relação de Visitas = '+inttostr(recordcount);
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmvisita.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmvisita.FormShow(Sender: TObject);
var
  i:integer;
  x:string;
begin
  datai.Text:='01/'+formatdatetime('mm/yyyy',date);
  dataf.Text:=formatdatetime('dd/mm/yyyy',date);

  frmcadvisita.osolicita.items.Clear;
  frmcadvisita.acopia.lines.Clear;
  with data10.myaux10 do begin
    close;
    sql.clear;
    x:='select solicitacao.codigo,solicitacao.descricao from solicitacao';
    x:=x+' where (';
    x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
    x:=x+' and (ativo='+#39+'S'+#39+')';
    x:=x+')';
    x:=x+' order by solicitacao.codigo';
    sql.add(x);
    open;
    first;
    while eof=false do begin
      frmcadvisita.osolicita.Items.Add(fieldbyname('descricao').asstring);
      frmcadvisita.osolicita.Checked[frmcadvisita.osolicita.Items.Count-1]:=false;
      frmcadvisita.acopia.lines.add(fieldbyname('codigo').asstring);
      next;
    end;
  end;

  for i:=0 to DBGrid1.Columns.Count-1 Do Begin
    DBGrid1.Columns.Items[i].Title.Font.Style := [];
  end;
  aordem:='descricao';
  tpo:=' ASC ';
  dbgrid1.Columns[1].Title.Font.Style := [fsBold];

  bitbtn1.Click;
  edit2.setfocus;
end;

procedure Tfrmvisita.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmvisita.excluirClick(Sender: TObject);
var
  x,cod:string;
begin
   if (application.MessageBox('Deseja excluir o visita?','Atenção',mb_yesno)<>id_no) then begin
    excluir.Enabled:=false;
    if data10.mytudo.RecordCount>0 then begin
      cod:=data10.mytudo.fieldbyname('codigo').asstring;

      x:='delete from visita_solicita where visita='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      x:='delete from visita where codigo='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      data10.mytudo.Refresh;
      frmvisita.Caption:='Relação de Visitas = '+inttostr(data10.mytudo.recordcount);
    end;
  end;
  excluir.Enabled:=true;
end;

procedure Tfrmvisita.DBGrid1TitleClick(Column: TColumn);
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
    frmvisita.Caption:='Relação de Visitas = '+inttostr(recordcount);
  end;
end;

procedure Tfrmvisita.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

end.
