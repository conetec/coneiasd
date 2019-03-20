unit locmaterial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes ;

type
  Tfrmlocmaterial = class(TForm)
    Label3: TLabel;
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
    sair: TBitBtn;
    ocod: TEdit;
    auxp: TEdit;
    DBGrid1: TDBGrid;
    procedure Edit1Exit(Sender: TObject);
    procedure sairClick(Sender: TObject);
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmlocmaterial: Tfrmlocmaterial;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses cadmaterial, datamodule10 , principal ;


{$R *.DFM}


procedure Tfrmlocmaterial.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmlocmaterial.sairClick(Sender: TObject);
begin
  frmlocmaterial.close;
end;

procedure Tfrmlocmaterial.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmlocmaterial.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.myprocura.recordcount>0) then begin
   data10.myprocura.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

procedure Tfrmlocmaterial.BitBtn1Click(Sender: TObject);
var
  x,a:string;
begin
  frmprincipal.c_agora;
  with data10.myprocura do begin
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
    frmlocmaterial.Caption:='Materiais = '+inttostr(recordcount);
    TNumericField(FieldByName('vlrvenda')).DisplayFormat := ',0.00;-,0.00';
    TNumericField(FieldByName('quantidade')).DisplayFormat := ',0.;-,0.';
  end;
  edit2.Text:='';
  dbgrid1.SetFocus;
end;

procedure Tfrmlocmaterial.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmlocmaterial.FormShow(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DBGrid1.Columns.Count-1 Do Begin
    DBGrid1.Columns.Items[i].Title.Font.Style := [];
  end;
  aordem:='a.descricao';
  tpo:=' ASC ';
  dbgrid1.Columns[1].Title.Font.Style := [fsBold];
  if trim(auxp.text)<>'' then begin
    edit2.Text:=auxp.text;
    bitbtn1.Click;
  end else begin
    bitbtn1.Click;
    edit2.setfocus;
  end;
end;

procedure Tfrmlocmaterial.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmlocmaterial.DBGrid1TitleClick(Column: TColumn);
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
  with data10.myprocura do begin
    close;
    sql.clear;
    sql.add(aprocura+' order by '+aordem+tpo+alimite);
    open;
    frmlocmaterial.Caption:='Materiais = '+inttostr(recordcount);
  end;
end;

procedure Tfrmlocmaterial.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
  if key = vk_escape then begin sair.Click; end;
  if key = vk_return then begin sair.Click; end;
end;

procedure Tfrmlocmaterial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if data10.myprocura.recordcount>0 then begin
    ocod.Text:=data10.myprocura.fieldbyname('codigo').asstring;
  end else begin
    ocod.Text:='0';
  end;
  data10.myprocura.Close;
end;

end.
