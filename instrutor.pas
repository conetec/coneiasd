unit instrutor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes,
  ComCtrls, funcaolocal ;

type
  Tfrminstrutor = class(TForm)
    Label3: TLabel;
    DBGrid1: TDBGrid;
    incluir: TBitBtn;
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
    procedure Edit1Exit(Sender: TObject);
    procedure sairClick(Sender: TObject);
    procedure incluirClick(Sender: TObject);
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
  frminstrutor: Tfrminstrutor;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses cadmembro, datamodule10 , principal, locmembro;


{$R *.DFM}


procedure Tfrminstrutor.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrminstrutor.sairClick(Sender: TObject);
begin
  frminstrutor.close;
end;

procedure Tfrminstrutor.incluirClick(Sender: TObject);
var
  omb,x,onome:string;
begin
  application.CreateForm(Tfrmlocmembro, frmlocmembro);
  frmlocmembro.showmodal;
  omb:=frmlocmembro.ocod.text;
  frmlocmembro.Free;
  onome:=voltainfo('membro','nome','codigo='+#39+omb+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
  if (trim(onome)<>'') then begin
    onome:='Deseja Incluir o membro:'+#13+onome+#13+'na lista do Ministério da Visitação?';
    if application.MessageBox(pchar(onome),'Atenção',mb_yesno)<>id_no then begin

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE membro SET ';
        x:=x+'instrutor='+#39+'SIM'+#39;                                  // instrutor
        x:=x+' where codigo='+#39+omb+#39;
        sql.add(x);
        ExecSql;
      end;
      data10.mytudo.Refresh;
      frminstrutor.Caption:='Ministério Visitação - Instrutor = '+inttostr(data10.mytudo.recordcount);

    end;
  end;


end;

procedure Tfrminstrutor.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrminstrutor.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('nome',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrminstrutor.BitBtn1Click(Sender: TObject);
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
    x:=x+' (a.ativo='+#39+'S'+#39+') and ';
    x:=x+' (a.instrutor='+#39+'SIM'+#39+') and ';
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
    frminstrutor.Caption:='Ministério Visitação - Instrutor = '+inttostr(recordcount);
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrminstrutor.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrminstrutor.FormShow(Sender: TObject);
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

procedure Tfrminstrutor.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrminstrutor.excluirClick(Sender: TObject);
var
  x,cod,amsn:string;
begin
   amsn:='Deseja RETIRAR o membro:'+#13+data10.mytudo.fieldbyname('nome').asstring+#13+'da lista do Ministério da Visitação?';
   if (application.MessageBox(pchar(amsn),'Atenção',mb_yesno)<>id_no) then begin
    excluir.Enabled:=false;
    if data10.mytudo.RecordCount>0 then begin
      cod:=data10.mytudo.fieldbyname('codigo').asstring;

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE membro SET ';
        x:=x+'instrutor='+#39+'NÃO'+#39;                                  // instrutor
        x:=x+' where codigo='+#39+cod+#39;
        sql.add(x);
        ExecSql;
      end;

      data10.mytudo.Refresh;
      frminstrutor.Caption:='Ministério Visitação - Instrutor = '+inttostr(data10.mytudo.recordcount);
    end;
  end;
  excluir.Enabled:=true;
end;

procedure Tfrminstrutor.DBGrid1TitleClick(Column: TColumn);
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
    frminstrutor.Caption:='Ministério Visitação - Instrutor = '+inttostr(recordcount);
  end;
end;

procedure Tfrminstrutor.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

end.
