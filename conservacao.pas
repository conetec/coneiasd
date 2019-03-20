unit conservacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes,
  ComCtrls, funcaolocal, NxColumns, NxColumnClasses, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, JvExGrids, JvStringGrid,DateUtils  ;

type
  Tfrmconservacao = class(TForm)
    Label3: TLabel;
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
    lista: TNextGrid;
    nome: TNxMemoColumn;
    codigo: TNxTextColumn;
    familia: TNxTextColumn;
    dtbatismo: TNxMemoColumn;
    dtnascimento: TNxMemoColumn;
    atividade: TNxMemoColumn;
    procedure Edit1Exit(Sender: TObject);
    procedure sairClick(Sender: TObject);
    procedure op1Click(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      function DataIdade(DataNascimento : String) : Integer;
      function voltaupresenca(codmembro:string):string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmconservacao: Tfrmconservacao;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses datamodule10 , principal;


{$R *.DFM}


procedure Tfrmconservacao.Edit1Exit(Sender: TObject);
begin
  edit1.text:='';
end;

procedure Tfrmconservacao.sairClick(Sender: TObject);
begin
  frmconservacao.close;
end;

procedure Tfrmconservacao.op1Click(Sender: TObject);
begin
 edit2.SetFocus;
end;

procedure Tfrmconservacao.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (edit1.text<>'') and (data10.mytudo.recordcount>0) then begin
   data10.mytudo.Locate('descricao',edit1.text,[lopartialkey]);
 end;
end;

Function Tfrmconservacao.DataIdade(DataNascimento : String) : Integer;
 begin
   try
     strtodate(datanascimento); //-- Verifica se a data é valida
   except
     messagedlg('Data de nascimento inválida!', MTERROR, [MBOK], 0);
    abort;
   end;
   result := Trunc((Date - Strtodate(DataNascimento))/365.25);
 end;

function Tfrmconservacao.voltaupresenca(codmembro:string):string;
var
  x:string;
begin
   with data10.mypresente do begin
    close;
    sql.clear;
    x:='select a.presenca, b.datamov from lista_es a left join chamada_es b on a.chamada=b.codigo';
    x:=x+' where (';
    x:=x+' (a.aluno='+#39+codmembro+#39+')';
    x:=x+')';
    x:=x+' order by b.datamov desc limit 0,1';
    sql.add(x);
    open;
    if recordcount=1 then begin
      x:=fieldbyname('datamov').asstring;
    end else begin
      x:='Nenhuma Anotação';
    end;
  end;
  voltaupresenca:=x;
end;


procedure Tfrmconservacao.BitBtn1Click(Sender: TObject);
var
  x,a:string;
  dtinicio,tmeses,tnasc,tativ:string;
  meses:word;
begin
  frmprincipal.c_agora;
  dtinicio:=formatdatetime('dd/mm/yyyy',date-strtoint(voltainfo('igreja','dias_conservacao','codigo='+#39+frmprincipal.Configura[3]+#39,'T','0')));
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select a.Codigo,a.nome,a.celular,a.comercial,a.email,a.ativo,a.databatismo,a.nascimento,';
    x:=x+' b.descricao,b.telefone,b.endereco,b.bairro, ';
    x:=x+' c.descricao as aclasse';
    x:=x+' from membro a left join familia b on a.familia=b.codigo left join classe c on a.classe=c.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+') and ';
    x:=x+' (a.ativo='+#39+'S'+#39+') and ';
    x:=x+' (a.batizado='+#39+'SIM'+#39+') and ';
    x:=x+' (a.databatismo>='+#39+mydata(dtinicio)+#39+') and ';
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
    first;
    lista.ClearRows;
    while eof=false do begin

      lista.AddRow;
      meses:=MonthsBetween(data10.mytudo.fieldbyname('databatismo').value,date);
      tmeses:=data10.mytudo.fieldbyname('databatismo').asstring+#13#10;
      tmeses:=tmeses+inttostr(meses)+' meses';

      tnasc:=data10.mytudo.fieldbyname('nascimento').asstring+#13#10;
      tnasc:=tnasc+inttostr(dataidade(data10.mytudo.fieldbyname('nascimento').asstring))+' anos';

      tativ:='Classe ES: '+data10.mytudo.fieldbyname('aclasse').asstring+#13#10;
      tativ:=tativ+'Última Presença ES: '+voltaupresenca(data10.mytudo.fieldbyname('codigo').asstring)+#13#10;
      tativ:=tativ+'Última Visita: '+#13#10;
      tativ:=tativ+'Pequeno Grupo: '+#13#10;
      tativ:=tativ+'Cargos e Funções: ';


      x:='Nome: '+data10.mytudo.fieldbyname('nome').asstring+#13#10;
      x:=x+'Fone Res: '+data10.mytudo.fieldbyname('telefone').asstring+' Fone Cel: '+data10.mytudo.fieldbyname('celular').asstring+#13#10;
      x:=x+'Endereço: '+data10.mytudo.fieldbyname('endereco').asstring+' - '+data10.mytudo.fieldbyname('bairro').asstring+#13#10;
      lista.CellByName['codigo', 'Last'].AsString := data10.mytudo.fieldbyname('codigo').asstring;
      lista.CellByName['nome', 'Last'].AsString := x;
      lista.CellByName['dtbatismo', 'Last'].AsString := tmeses;
      lista.CellByName['dtnascimento', 'Last'].AsString := tnasc;
      lista.CellByName['familia', 'Last'].AsString := data10.mytudo.fieldbyname('descricao').asstring;
      lista.CellByName['atividade', 'Last'].AsString := tativ;
      lista.RowHeight[lista.RowCount-1]:=20*4;
      lista.Cell[0,lista.RowCount-1].Color:=clred;
      next;
    end;





    frmconservacao.Caption:='Membros = '+inttostr(recordcount);
  end;
  edit2.Text:='';
//  dbgrid1.SetFocus;
end;

procedure Tfrmconservacao.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin
    edit3.Text:='100';
  end;
end;

procedure Tfrmconservacao.FormShow(Sender: TObject);
var
  i:integer;
begin
  bitbtn1.Click;
  edit2.setfocus;
end;

procedure Tfrmconservacao.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmconservacao.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

end.
