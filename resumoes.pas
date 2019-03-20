unit resumoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, NiceGrid, funcoes, StdCtrls, db;

type
  TfrmResumoES = class(TForm)
    Panel1: TPanel;
    grid: TNiceGrid;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SomarColunas(nsb,nper:integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmResumoES: TfrmResumoES;

implementation

uses datamodule10, principal;

{$R *.dfm}


procedure TfrmResumoES.SomarColunas(nsb,nper:integer);
var
  lin,Col,i,totp:integer;
begin

  totp:=0;
  for lin:=0 to Grid.RowCount-1 do begin
    if trim(Grid[2,Lin])<>'' then begin
      totp:=totp+strtoint(Grid[2,Lin]);
    end;
  end;
  Grid.Columns[2].Footer:=inttostr(totp);

  col:=2;
  for i:=3 to Grid.ColCount-1 do begin
    col:=col+1;
    if Odd(col) then begin
      totp:=0;
      for lin:=0 to Grid.RowCount-1 do begin
        if trim(Grid[col,Lin])<>'' then begin
          totp:=totp+strtoint(Grid[col,Lin]);
        end;
      end;
      Grid.Columns[col].Footer:=inttostr(totp);
    end;
  end;



end;

procedure TfrmResumoES.FormShow(Sender: TObject);
var
  x,xdatabase,xdatai,ax,xdti,xdtf:string;
  nsab,i,k, lin, col, num_per, nalunos,nperguntas:integer;
begin


  nperguntas:=0;
  data10.myPerguntas.Close;
  data10.myPerguntas.Sql.Clear;
  data10.myPerguntas.sql.Add('select a.* from aponta_perguntas a where a.ativo='+#39+'S'+#39+' limit 0,1');
  data10.myPerguntas.Open;
  if trim(data10.myPerguntas.fieldbyname('pergunta01').asstring)<>'' then begin nperguntas:=nperguntas+1; end;
  if trim(data10.myPerguntas.fieldbyname('pergunta02').asstring)<>'' then begin nperguntas:=nperguntas+1; end;
  if trim(data10.myPerguntas.fieldbyname('pergunta03').asstring)<>'' then begin nperguntas:=nperguntas+1; end;
  if trim(data10.myPerguntas.fieldbyname('pergunta04').asstring)<>'' then begin nperguntas:=nperguntas+1; end;
  if trim(data10.myPerguntas.fieldbyname('pergunta05').asstring)<>'' then begin nperguntas:=nperguntas+1; end;
  if trim(data10.myPerguntas.fieldbyname('pergunta06').asstring)<>'' then begin nperguntas:=nperguntas+1; end;
  if trim(data10.myPerguntas.fieldbyname('pergunta07').asstring)<>'' then begin nperguntas:=nperguntas+1; end;
  if trim(data10.myPerguntas.fieldbyname('pergunta08').asstring)<>'' then begin nperguntas:=nperguntas+1; end;
  if trim(data10.myPerguntas.fieldbyname('pergunta09').asstring)<>'' then begin nperguntas:=nperguntas+1; end;
  if trim(data10.myPerguntas.fieldbyname('pergunta10').asstring)<>'' then begin nperguntas:=nperguntas+1; end;


  num_per:=nperguntas+1;  // Numero de Perguntas + 1 Dos alunos presentes
  num_per:=num_per*2;     // Alunos e Percentual sao 2 colunas

  xdatabase:='04/07/15';

  xdti:=mydata(xdatabase);

  xdatai:=xdatabase;
  nsab:=0;
  while strtodate(xdatai)<=date do begin
    xdtf:=mydata(xdatai);
    nsab:=nsab+1;
    xdatai:=formatdatetime('dd/mm/yyyy',strtodate(xdatai)+7);
  end;

  Grid.BeginUpdate;
  Grid.Clear;



  Grid.Columns.Add; // Classe  |Código
  Grid.Columns.Add; // Classe  |Descrição
  Grid.Columns.Add; // Classe  |Alunos

  for i:=1 to nsab do begin
    for k:=1 to num_per do begin
      Grid.Columns.Add;
    end;
  end;

  Grid.ColCount:=(nsab*num_per)+3;

  Grid.Columns[0].Title:='Classe|Código';
  Grid.Columns[0].Width:=40;
  Grid.Columns[0].HorzAlign:=haCenter;
  Grid.Columns[0].ReadOnly:=true;
  Grid.Columns[0].Color:=$00D2FFFF;

  Grid.Columns[1].Title:='Classe|Descrição';
  Grid.Columns[1].Width:=130;
  Grid.Columns[1].HorzAlign:=haLeft;
  Grid.Columns[1].ReadOnly:=true;
  Grid.Columns[1].Color:=$00D2FFFF;

  Grid.Columns[2].Title:='Classe|Alunos';
  Grid.Columns[2].Width:=40;
  Grid.Columns[2].HorzAlign:=haCenter;
  Grid.Columns[2].ReadOnly:=true;
  Grid.Columns[2].Color:=$00D2FFFF;

  xdatai:=xdatabase;
  Col:=2;

  for i:=1 to nsab do begin
    application.ProcessMessages;

    for k:=1 to nperguntas+1 do begin
      Col:=col+1;
      Case k of
        1 : x:='Presença';
        2 : x:=trim(data10.myPerguntas.fieldbyname('cp01').asstring);
        3 : x:=trim(data10.myPerguntas.fieldbyname('cp02').asstring);
        4 : x:=trim(data10.myPerguntas.fieldbyname('cp03').asstring);
        5 : x:=trim(data10.myPerguntas.fieldbyname('cp04').asstring);
        6 : x:=trim(data10.myPerguntas.fieldbyname('cp05').asstring);
        7 : x:=trim(data10.myPerguntas.fieldbyname('cp06').asstring);
        8 : x:=trim(data10.myPerguntas.fieldbyname('cp07').asstring);
        9 : x:=trim(data10.myPerguntas.fieldbyname('cp08').asstring);
        10 : x:=trim(data10.myPerguntas.fieldbyname('cp09').asstring);
        11 : x:=trim(data10.myPerguntas.fieldbyname('cp10').asstring);
      end;

      ax:='Sáb '+espaco(inttostr(i),'0','dir',2)+' '+xdatai+'|'+x+'|Num.';
      Grid.Columns[Col].Title:=ax;
      Grid.Columns[Col].ReadOnly:=true;
      Grid.Columns[Col].HorzAlign:=haCenter;
      Grid.Columns[Col].Width:=30;

      Col:=col+1;
      ax:='Sáb '+espaco(inttostr(i),'0','dir',2)+' '+xdatai+'|'+x+'|Per%';
      Grid.Columns[Col].Title:=ax;
      Grid.Columns[Col].ReadOnly:=true;
      Grid.Columns[Col].HorzAlign:=haCenter;
      Grid.Columns[Col].Width:=35;

    end;
    xdatai:=formatdatetime('dd/mm/yy',strtodate(xdatai)+7);
  end;

  with data10.myaux do begin
    close;
    sql.clear;
    x:='select codigo,descricao,numero from classe where igreja='+#39+frmprincipal.Configura[3]+#39+' and ativo='+#39+'S'+#39+' and codigo<>'+#39+'1'+#39+' order by numero';
    sql.add(x);
    open;
    first;
    Grid.RowCount:=recordcount;
    lin:=0;
    while eof=false do begin
      Grid[0,lin]:=fieldbyname('codigo').asstring;
      Grid[1,lin]:=espaco(fieldbyname('numero').asstring,'0','dir',3)+' '+fieldbyname('descricao').asstring;
      next;
      lin:=lin+1;
    end;
  end;


  with data10.myaux do begin
    close;
    sql.clear;
    x:='select count(a.codigo) as nalunos,a.classe from membro a where igreja='+#39+frmprincipal.Configura[3]+#39+' and ativo='+#39+'S'+#39+' group by classe order by classe';
    sql.add(x);
    open;
    first;
    for lin:=0 to Grid.RowCount-1 do begin
      data10.myaux.Locate('classe',trim(Grid[0,lin]),[lopartialkey]) ;
      if trim(data10.myaux.fieldbyname('classe').asstring)=trim(Grid[0,lin]) then begin
        Grid[2,lin]:=fieldbyname('nalunos').asstring;
      end else begin
        Grid[2,lin]:='0';
      end;
    end;
    data10.myaux.Locate('classe','1',[lopartialkey]) ;
    label1.Caption:='Membros não Matriculados = '+fieldbyname('nalunos').asstring;
  end;


  xdatai:=xdatabase;
  col:=3;
  for i:=1 to nsab do begin

    with data10.myaux do begin
      close;
      sql.clear;
      x:='select count(a.codigo) as nalunos,b.classe from chamada a, membro b';
      x:=x+' where (';
      x:=x+' (a.aluno=b.codigo)';
      x:=x+' and (a.dtchamada='+#39+mydata(xdatai)+#39+')';
      x:=x+' and (a.presenca='+#39+'P'+#39+')';
      x:=x+')';
      x:=x+' group by b.classe';
      x:=x+' order by b.classe';
      sql.add(x);
      open;
    end;
    for lin:=0 to Grid.RowCount-1 do begin
      data10.myaux.Locate('classe',trim(Grid[0,lin]),[lopartialkey]) ;
      if trim(data10.myaux.fieldbyname('classe').asstring)=trim(Grid[0,lin]) then begin
        Grid[col,lin]:=data10.myaux.fieldbyname('nalunos').asstring;
      end else begin
        Grid[col,lin]:='0';
      end;
      nalunos:=strtoint(Grid[2,lin]);
      if nalunos=0 then begin nalunos:=1; end;
      Grid[col+1,lin]:=formatfloat('###,###,###,0.',vc(Grid[col,lin])/nalunos*100)+'%';
    end;
    xdatai:=formatdatetime('dd/mm/yyyy',strtodate(xdatai)+7);
    col:=col+12;
  end;


  xdatai:=xdatabase;

  for i:=1 to nsab do begin



    with data10.myaux do begin
      close;
      sql.clear;
      x:='select a.p01,a.p02,a.p03,a.p04,a.p05,a.p06,a.p07,a.p08,a.p09,a.p10,a.codclasse from apontamentos a';
      x:=x+' where (';
      x:=x+' (a.dtchamada='+#39+mydata(xdatai)+#39+')';
      x:=x+')';
      x:=x+' order by a.codclasse';
      sql.add(x);
      open;
    end;

    for lin:=0 to Grid.RowCount-1 do begin
      col:=4+((i-1)*((nperguntas+1)*2));
      nalunos:=strtoint(Grid[2,lin]);
      if nalunos=0 then begin nalunos:=1; end;
      data10.myaux.Locate('codclasse',trim(Grid[0,lin]),[lopartialkey]) ;
      if trim(data10.myaux.fieldbyname('codclasse').asstring)=trim(Grid[0,lin]) then begin
        for k:=1 to nperguntas do begin
          col:=col+1;
          Grid[col,lin]:=data10.myaux.fieldbyname('p'+espaco(inttostr(k),'0','dir',2)).asstring;
          col:=col+1;
          Grid[col,lin]:=formatfloat('###,###,###,0.',vc(Grid[col-1,lin])/nalunos*100)+'%';;
        end;
      end else begin
        for k:=1 to nperguntas do begin
          col:=col+1;
          Grid[col,lin]:='0';
          col:=col+1;
          Grid[col,lin]:='0%';
        end;
      end;
    end;
    xdatai:=formatdatetime('dd/mm/yyyy',strtodate(xdatai)+7);
  end;


 SomarColunas(nsab,nperguntas+1);






  Grid.EndUpdate;
  application.ProcessMessages;


end;

end.
