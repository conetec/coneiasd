unit material_saida;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes ;

type
  Tfrmmaterial_saida = class(TForm)
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
  frmmaterial_saida: Tfrmmaterial_saida;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses datamodule10 , principal, cadmaterial_saida;


{$R *.DFM}


procedure Tfrmmaterial_saida.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmmaterial_saida.sairClick(Sender: TObject);
begin
  frmmaterial_saida.close;
end;

procedure Tfrmmaterial_saida.incluirClick(Sender: TObject);
begin
  frmcadmaterial_saida.tag:=1;
  frmcadmaterial_saida.showmodal;
  data10.mytudo.Refresh;
  frmmaterial_saida.Caption:='Saída de Materiais = '+inttostr(data10.mytudo.recordcount);
  TNumericField(data10.mytudo.FieldByName('vlrtotal')).DisplayFormat := ',0.00;-,0.00';
  TNumericField(data10.mytudo.FieldByName('vlrpago')).DisplayFormat := ',0.00;-,0.00';
  TNumericField(data10.mytudo.FieldByName('vlrsaldo')).DisplayFormat := ',0.00;-,0.00';
end;

procedure Tfrmmaterial_saida.editarClick(Sender: TObject);
var
  x,ocod:string;
begin
  if data10.mytudo.RecordCount>0 then begin
    ocod:=data10.mytudo.fieldbyname('codigo').asstring;
    ucd:=ocod;
    with data10.mymostra do begin
      close;
      sql.clear;
      x:='select * from material_saida';
      x:=x+' where codigo='+#39+ocod+#39;
      sql.add(x);
      open;
    end;
    frmcadmaterial_saida.tag:=2;
    frmcadmaterial_saida.showmodal;
    data10.mytudo.Refresh;
    frmmaterial_saida.Caption:='Saída de Materiais = '+inttostr(data10.mytudo.recordcount);
    TNumericField(data10.mytudo.FieldByName('vlrtotal')).DisplayFormat := ',0.00;-,0.00';
    TNumericField(data10.mytudo.FieldByName('vlrpago')).DisplayFormat := ',0.00;-,0.00';
    TNumericField(data10.mytudo.FieldByName('vlrsaldo')).DisplayFormat := ',0.00;-,0.00';
    data10.mytudo.Locate('codigo',ucd,[locaseinsensitive]);
  end;
end;

procedure Tfrmmaterial_saida.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmmaterial_saida.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmmaterial_saida.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  frmprincipal.c_agora;
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select a.Codigo,a.datamov,a.vlrtotal,a.vlrpago,(a.vlrtotal-a.vlrpago) as vlrsaldo,b.nome';
    x:=x+' from material_saida a left join membro b on a.membro=b.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+') and ';
    if op1.Checked=true then begin
      x:=x+'(b.nome';
      a:='b.nome';
    end;
    if op2.Checked=true then begin
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
    frmmaterial_saida.Caption:='Saída de Materiais = '+inttostr(recordcount);
    TNumericField(FieldByName('vlrtotal')).DisplayFormat := ',0.00;-,0.00';
    TNumericField(FieldByName('vlrpago')).DisplayFormat := ',0.00;-,0.00';
    TNumericField(FieldByName('vlrsaldo')).DisplayFormat := ',0.00;-,0.00';
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmmaterial_saida.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmmaterial_saida.FormShow(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DBGrid1.Columns.Count-1 Do Begin
    DBGrid1.Columns.Items[i].Title.Font.Style := [];
  end;
  aordem:='b.nome';
  tpo:=' ASC ';
  dbgrid1.Columns[1].Title.Font.Style := [fsBold];

  bitbtn1.Click;
  edit2.setfocus;
end;

procedure Tfrmmaterial_saida.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmmaterial_saida.excluirClick(Sender: TObject);
var
  x,cod:string;
begin
   if (application.MessageBox('Deseja excluir a Saída de Materiais?','Atenção',mb_yesno)<>id_no) then begin
    excluir.Enabled:=false;
    if data10.mytudo.RecordCount>0 then begin
      cod:=data10.mytudo.fieldbyname('codigo').asstring;


      with data10.myitem1 do begin
        close;
        sql.clear;
        sql.add('select * from material_saida_item where saida='+#39+cod+#39);
        open;
      end;

      data10.myitem1.first;
      while data10.myitem1.eof=false do begin
        x:='UPDATE material SET ';
        x:=x+'quantidade=quantidade+'+myvalor(formatfloat('###,###,###,0.000',data10.myitem1.fieldbyname('quantidade').value));
        x:=x+' WHERE codigo='+#39+data10.myitem1.fieldbyname('material').asstring+#39;
        with data10.exemysql do begin
          sql.clear;
          sql.add(x);
          ExecSql;
        end;
        data10.myitem1.next;
      end;

      x:='delete from material_saida_item where saida='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;


      x:='delete from material_saida where codigo='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      data10.mytudo.Refresh;
      frmmaterial_saida.Caption:='Saída de Materiais = '+inttostr(data10.mytudo.recordcount);
      TNumericField(data10.mytudo.FieldByName('vlrtotal')).DisplayFormat := ',0.00;-,0.00';
      TNumericField(data10.mytudo.FieldByName('vlrpago')).DisplayFormat := ',0.00;-,0.00';
      TNumericField(data10.mytudo.FieldByName('vlrsaldo')).DisplayFormat := ',0.00;-,0.00';
    end;
  end;
  excluir.Enabled:=true;
end;

procedure Tfrmmaterial_saida.DBGrid1TitleClick(Column: TColumn);
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
    frmmaterial_saida.Caption:='Materiais = '+inttostr(recordcount);
  end;
end;

procedure Tfrmmaterial_saida.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

end.
