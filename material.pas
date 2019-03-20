unit material;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes ;

type
  Tfrmmaterial = class(TForm)
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
    Button1: TButton;
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
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmmaterial: Tfrmmaterial;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses cadmaterial, datamodule10 , principal;


{$R *.DFM}


procedure Tfrmmaterial.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmmaterial.sairClick(Sender: TObject);
begin
  frmmaterial.close;
end;

procedure Tfrmmaterial.incluirClick(Sender: TObject);
begin
 frmcadmaterial.tag:=1;
 frmcadmaterial.showmodal;
 data10.mytudo.Refresh;
 TNumericField(data10.mytudo.FieldByName('vlrvenda')).DisplayFormat := ',0.00;-,0.00';
 TNumericField(data10.mytudo.FieldByName('quantidade')).DisplayFormat := ',0.;-,0.';
 frmmaterial.Caption:='Materiais = '+inttostr(data10.mytudo.recordcount);
end;

procedure Tfrmmaterial.editarClick(Sender: TObject);
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
      x:='select * from material';
      x:=x+' where codigo='+#39+ocod+#39;
      sql.add(x);
      open;
    end;
    frmcadmaterial.tag:=2;
    frmcadmaterial.showmodal;
    data10.mytudo.Refresh;
    TNumericField(data10.mytudo.FieldByName('vlrvenda')).DisplayFormat := ',0.00;-,0.00';
    TNumericField(data10.mytudo.FieldByName('quantidade')).DisplayFormat := ',0.;-,0.';
    data10.mytudo.Locate('codigo',ucd,[locaseinsensitive]);
    frmmaterial.Caption:='Materiais = '+inttostr(data10.mytudo.recordcount);
  end;
end;

procedure Tfrmmaterial.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmmaterial.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmmaterial.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  frmprincipal.c_agora;
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select a.Codigo,a.descricao,a.quantidade,a.vlrvenda,b.descricao as ncategoria from material a left join material_tipo b on a.categoria=b.codigo ';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+') and ';
    if a1.Checked=true then begin
      x:=x+' (a.ativo='+#39+'S'+#39+') and ';
    end;
    if a2.Checked=true then begin
      x:=x+' (a.ativo='+#39+'N'+#39+') and ';
    end;
    if op1.Checked=true then begin
      x:=x+'(a.descricao';
      a:='a.descricao';
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
    frmmaterial.Caption:='Materiais = '+inttostr(recordcount);
    TNumericField(FieldByName('vlrvenda')).DisplayFormat := ',0.00;-,0.00';
    TNumericField(FieldByName('quantidade')).DisplayFormat := ',0.;-,0.';
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmmaterial.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmmaterial.FormShow(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DBGrid1.Columns.Count-1 Do Begin
    DBGrid1.Columns.Items[i].Title.Font.Style := [];
  end;
  aordem:='a.descricao';
  tpo:=' ASC ';
  dbgrid1.Columns[1].Title.Font.Style := [fsBold];

  bitbtn1.Click;
  edit2.setfocus;
end;

procedure Tfrmmaterial.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmmaterial.excluirClick(Sender: TObject);
var
  x,cod:string;
begin
   if (application.MessageBox('Deseja excluir o Material?','Atenção',mb_yesno)<>id_no) then begin
    excluir.Enabled:=false;
    if data10.mytudo.RecordCount>0 then begin
      cod:=data10.mytudo.fieldbyname('codigo').asstring;

      x:='delete from material where codigo='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      data10.mytudo.Refresh;
      TNumericField(data10.mytudo.FieldByName('vlrvenda')).DisplayFormat := ',0.00;-,0.00';
      TNumericField(data10.mytudo.FieldByName('quantidade')).DisplayFormat := ',0.;-,0.';
      frmmaterial.Caption:='Materiais = '+inttostr(data10.mytudo.recordcount);
    end;
  end;
  excluir.Enabled:=true;
end;

procedure Tfrmmaterial.DBGrid1TitleClick(Column: TColumn);
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
    frmmaterial.Caption:='Materiais = '+inttostr(recordcount);
  end;
end;

procedure Tfrmmaterial.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

procedure Tfrmmaterial.Button1Click(Sender: TObject);
var
  x:string;
begin

    with data10.exemysql do begin
      sql.clear;
      x:='TRUNCATE material_entrada';
      sql.add(x);
      ExecSql;
    end;

    with data10.exemysql do begin
      sql.clear;
      x:='TRUNCATE material_entrada_item';
      sql.add(x);
      ExecSql;
    end;

    with data10.exemysql do begin
      sql.clear;
      x:='TRUNCATE material_saida';
      sql.add(x);
      ExecSql;
    end;

    with data10.exemysql do begin
      sql.clear;
      x:='TRUNCATE material_saida_item';
      sql.add(x);
      ExecSql;
    end;


    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO material_entrada ';
      x:=x+'(codigo, igreja, datamov, descricao, vlrtotal, observacoes, id) ';
      x:=x+'VALUES (NULL,';                                  // codigo
      x:=x+#39+frmprincipal.Configura[3]+#39+',';            // igreja
      x:=x+#39+mydata('16/04/2013')+#39+',';                 // datamov
      x:=x+#39+'ESTOQUE INICIAL'+#39+',';                    // descricao
      x:=x+myvalor('0,00')+',';                              // vlrtotal
      x:=x+#39+trim('')+#39+',';                             // observacoes
      x:=x+#39+frmprincipal.Configura[1]+#39; // id
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;

    with data10.mymostra do begin
      close;
      sql.clear;
      x:='select * from material';
      sql.add(x);
      open;
      first;
      while eof=false do begin


        data10.exemysql.sql.clear;
        x:='INSERT INTO material_entrada_item ';
        x:=x+' (codigo, entrada, quantidade, material) ';
        x:=x+'VALUES (NULL,';                                       // codigo
        x:=x+#39+'1'+#39+',';                                       // entrada
        x:=x+#39+fieldbyname('quantidade').asstring+#39+',';       // quantidade
        x:=x+#39+fieldbyname('codigo').asstring+#39;                // material
        x:=x+')';
        data10.exemysql.sql.add(x);
        data10.exemysql.ExecSql;




        next;
      end;
    end;

    application.MessageBox('Concluido','Atenção',mb_ok);

end;

end.
