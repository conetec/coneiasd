unit acompanha_solicita;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, db, ExtCtrls, dbtables, funcoes,
  ComCtrls, funcaolocal, NxColumns, NxColumnClasses, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, JvExGrids, JvStringGrid,DateUtils  ;

type
  Tfrmacompanha_solicita = class(TForm)
    sair: TBitBtn;
    lista: TNextGrid;
    nome: TNxMemoColumn;
    codigo: TNxTextColumn;
    observa: TNxTextColumn;
    dtsolicita: TNxMemoColumn;
    tipo: TNxMemoColumn;
    GroupBox3: TGroupBox;
    m01: TRadioButton;
    m02: TRadioButton;
    m03: TRadioButton;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    resposta: TNxTextColumn;
    BitBtn2: TBitBtn;
    solicita: TNxTextColumn;
    BitBtn3: TBitBtn;
    procedure sairClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      function DataIdade(DataNascimento : String) : Integer;
      function voltaupresenca(codmembro:string):string;
    procedure m01Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmacompanha_solicita: Tfrmacompanha_solicita;
  aordem,aprocura,alimite,tpo,ucd:string;

implementation

uses datamodule10 , principal, cadacompanha, imprel_009;


{$R *.DFM}


procedure Tfrmacompanha_solicita.sairClick(Sender: TObject);
begin
  frmacompanha_solicita.close;
end;

Function Tfrmacompanha_solicita.DataIdade(DataNascimento : String) : Integer;
 begin
   try
     strtodate(datanascimento); //-- Verifica se a data é valida
   except
     messagedlg('Data de nascimento inválida!', MTERROR, [MBOK], 0);
    abort;
   end;
   result := Trunc((Date - Strtodate(DataNascimento))/365.25);
 end;

function Tfrmacompanha_solicita.voltaupresenca(codmembro:string):string;
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


procedure Tfrmacompanha_solicita.BitBtn1Click(Sender: TObject);
var
  x,a,xnome:string;
  dtinicio,tmeses,tnasc,tativ:string;
  meses:word;
begin
  bitbtn1.Enabled:=false;
  frmprincipal.c_agora;
  aordem:='a.datamov';
  dtinicio:=formatdatetime('dd/mm/yyyy',date-strtoint(voltainfo('igreja','dias_conservacao','codigo='+#39+frmprincipal.Configura[3]+#39,'T','0')));
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select a.Codigo,a.visita,a.resposta,a.datamov,a.resposta,a.dataresposta,a.observacao,';
    x:=x+' if(a.tipo='+#39+'M'+#39+','+#39+'MEMBRO'+#39+','+#39+'AMIGO'+#39+') as otipo,';
    x:=x+' if(a.tipo='+#39+'M'+#39+',c.nome,b.nome) as onome,';
    x:=x+' if(a.tipo='+#39+'M'+#39+',CONCAT('+#39+'Fone Cel. '+#39+',c.celular,'+#39+' Fone Com. '+#39+',c.comercial),CONCAT('+#39+'Fone Cel. '+#39+',b.celular,'+#39+' Fone Res. '+#39+',b.telefone)) as otelefone,';
    x:=x+' if(a.tipo='+#39+'M'+#39+','+#39+' '+#39+',CONCAT(b.endereco,'+#39+' '+#39+',b.bairro)) as oendereco,';
    x:=x+' if(a.tipo='+#39+'M'+#39+',c.email,b.email) as oemail,';
    x:=x+' if(a.solicitacao='+#39+'1'+#39+','+#39+'Oração'+#39+',if(a.solicitacao='+#39+'2'+#39+','+#39+'Visita'+#39+',if(a.solicitacao='+#39+'3'+#39+','+#39+'Estudo'+#39+',if(a.solicitacao='+#39+'4'+#39+','+#39+'Estudo Online'+#39+',if(a.solicitacao='+#39+'5'+#39+','+#39+'ASA'+#39+','+#39+'Outro'+#39+'))))) as tpsolicita';
    x:=x+' from visita_solicita a left join amigo b on a.amigo=b.codigo left join membro c on a.amigo=c.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';

    if frmacompanha_solicita.tag=1 then begin
      x:=x+' and (a.solicitacao='+#39+'1'+#39+')';
    end;
    if frmacompanha_solicita.tag=2 then begin
      x:=x+' and (a.solicitacao='+#39+'2'+#39+')';
    end;
    if frmacompanha_solicita.tag=3 then begin
      x:=x+' and (a.solicitacao='+#39+'3'+#39+')';
    end;
    if frmacompanha_solicita.tag=4 then begin
      x:=x+' and (a.solicitacao='+#39+'4'+#39+')';
    end;
    if frmacompanha_solicita.tag=5 then begin
      x:=x+' and (a.solicitacao='+#39+'5'+#39+')';
    end;

    if m01.Checked=true then begin
      x:=x+' and (a.resposta<>'+#39+'S'+#39+')';
    end;
    if m02.Checked=true then begin
      x:=x+' and (a.resposta='+#39+'S'+#39+')';
    end;
    x:=x+') order by a.datamov desc';
    mandamemoria(x);
    sql.add(x);
    open;
    first;
    lista.ClearRows;
    while eof=false do begin

      lista.AddRow;
      x:='';
      if trim(data10.mytudo.fieldbyname('dataresposta').asstring)<>'' then begin
        x:='Data: '+data10.mytudo.fieldbyname('dataresposta').asstring+#13#10;
      end;
      xnome:=data10.mytudo.fieldbyname('onome').asstring+#13#10;
      xnome:=xnome+data10.mytudo.fieldbyname('otelefone').asstring+#13#10;
      xnome:=xnome+data10.mytudo.fieldbyname('oemail').asstring+#13#10;
      xnome:=xnome+data10.mytudo.fieldbyname('oendereco').asstring;

      lista.CellByName['codigo', 'Last'].AsString := data10.mytudo.fieldbyname('codigo').asstring;
      lista.CellByName['dtsolicita', 'Last'].AsString := data10.mytudo.fieldbyname('datamov').asstring;
      lista.CellByName['solicita', 'Last'].AsString := data10.mytudo.fieldbyname('tpsolicita').asstring;
      lista.CellByName['tipo', 'Last'].AsString := data10.mytudo.fieldbyname('otipo').asstring;
      lista.CellByName['nome', 'Last'].AsString := xnome;
      lista.CellByName['resposta', 'Last'].AsString := x;
      lista.CellByName['observa', 'Last'].AsString := data10.mytudo.fieldbyname('observacao').asstring;
      lista.RowHeight[lista.RowCount-1]:=20*4;
      if data10.mytudo.fieldbyname('resposta').asstring='S' then begin
        lista.Cell[0,lista.RowCount-1].Color:=clGreen;
      end else begin
        lista.Cell[0,lista.RowCount-1].Color:=clred;
      end;
      next;
    end;

    if frmacompanha_solicita.tag=0 then begin
      frmacompanha_solicita.Caption:='Solicitações Interessados = '+inttostr(recordcount);
    end;
    if frmacompanha_solicita.tag=1 then begin
      frmacompanha_solicita.Caption:='Oração = '+inttostr(recordcount);
    end;
    if frmacompanha_solicita.tag=2 then begin
      frmacompanha_solicita.Caption:='Solicitações de Visita Pastoral = '+inttostr(recordcount);
    end;
    if frmacompanha_solicita.tag=3 then begin
      frmacompanha_solicita.Caption:='Solicitações de Estudo Bíblico TRADICIONAL = '+inttostr(recordcount);
    end;
    if frmacompanha_solicita.tag=4 then begin
      frmacompanha_solicita.Caption:='Solicitações de Estudo Bíblico ON-LINE = '+inttostr(recordcount);
    end;
    if frmacompanha_solicita.tag=5 then begin
      frmacompanha_solicita.Caption:='Solicitações de Assistência Social = '+inttostr(recordcount);
    end;

  end;
  bitbtn1.Enabled:=true;

end;

procedure Tfrmacompanha_solicita.FormShow(Sender: TObject);
begin
  bitbtn1.Click;
end;

procedure Tfrmacompanha_solicita.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmacompanha_solicita.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (key = vk_delete)) then begin Abort; end;
end;

procedure Tfrmacompanha_solicita.m01Click(Sender: TObject);
begin
  bitbtn1.Click;
end;

procedure Tfrmacompanha_solicita.BitBtn2Click(Sender: TObject);
begin
  if lista.RowCount>0 then begin
    if lista.SelectedCount>0 then begin
      Application.CreateForm(Tfrmcadacompanha, frmcadacompanha);
      frmcadacompanha.Edit1.Text:=lista.CellByName['codigo',lista.SelectedRow].AsString;
      frmcadacompanha.showmodal;
      frmcadacompanha.Free;
      bitbtn1.click;
    end;
  end;
end;

procedure Tfrmacompanha_solicita.BitBtn3Click(Sender: TObject);
var
  x:string;
  i:integer;
begin
  x:='delete from rel_solicitacoes where id='+#39+frmprincipal.Configura[1]+#39;
  with data10.exemysql do begin
    sql.clear;
    sql.add(x);
    ExecSql;
  end;
  for i:=0 to lista.RowCount-1 do begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO rel_solicitacoes ';
      x:=x+'(codigo, movimento, solicitacao, tipo, data, nome,observacoes, id) ';
      x:=x+'VALUES (NULL,';                   // codigo
      x:=x+#39+lista.CellByName['codigo',i].AsString+#39+',';                   // movimento
      x:=x+#39+lista.CellByName['solicita',i].AsString+#39+',';                   // solicitacao
      x:=x+#39+lista.CellByName['tipo',i].AsString+#39+',';                   // tipo
      x:=x+#39+mydata(lista.CellByName['dtsolicita',i].AsString)+#39+',';                   // data
      x:=x+#39+lista.CellByName['nome',i].AsString+#39+',';                   // nome
      x:=x+#39+lista.CellByName['observa',i].AsString+#39+',';                   // observacoes
      x:=x+#39+frmprincipal.Configura[1]+#39;                                   // id
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
  end;
  with data10.myimp do begin
    x:='select * from rel_solicitacoes a ';
    x:=x+' where (';
    x:=x+' (a.id='+#39+frmprincipal.Configura[1]+#39+')';
    x:=x+')';
    x:=x+' order by a.codigo';
    close;
    sql.clear;
    sql.add(x);
    open;
  end;
  Application.CreateForm(Tfrmimprel_009, frmimprel_009);
  frmimprel_009.titulo.Caption:='Relatório de Solicitações';
  frmimprel_009.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
  frmimprel_009.empresa.Caption:=frmprincipal.Configura[4];
  frmimprel_009.RLReport1.Preview;
  frmimprel_009.free;
end;

end.
