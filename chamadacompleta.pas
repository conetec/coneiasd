unit chamadacompleta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, NiceGrid, Mask, ExtCtrls, funcoes;

type
  TfrmChamadaCompleta = class(TForm)
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    grid: TNiceGrid;
    cbAux: TComboBox;
    Panel3: TPanel;
    Grid2: TNiceGrid;
    btnGravar: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    btnLocalizar: TBitBtn;
    cbClasse: TComboBox;
    procedure btnLocalizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridDblClick(Sender: TObject);
    procedure gridKeyPress(Sender: TObject; var Key: Char);
    procedure Grid2DblClick(Sender: TObject);
    procedure Grid2KeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Verpresentes;
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChamadaCompleta: TfrmChamadaCompleta;

implementation

uses datamodule10, principal, participa_classe, resumoes;

{$R *.dfm}


procedure TfrmChamadaCompleta.Verpresentes;
var
  lin,Col,i,totp:integer;
begin

  for Col:=2 to Grid.ColCount-1 do begin
    totp:=0;
    for lin:=0 to Grid.RowCount-1 do begin
      if Grid[Col,Lin]='P' then begin
        totp:=totp+1;
      end;
    end;
    Grid.Columns[Col].Footer:=inttostr(totp);
  end;
end;

procedure TfrmChamadaCompleta.btnLocalizarClick(Sender: TObject);
var
  x,xdatai,xdatabase,np:string;
  i,k,lin,col,nsab, nperguntas:integer;
begin

  btnLocalizar.Enabled:=false;
  cbAux.ItemIndex:=cbClasse.ItemIndex;
  xdatabase:='04/07/15';

  xdatai:=xdatabase;
  nsab:=0;
  while strtodate(xdatai)<=date do begin
    nsab:=nsab+1;
    xdatai:=formatdatetime('dd/mm/yyyy',strtodate(xdatai)+7);
  end;


  Grid.BeginUpdate;
  Grid.Clear;


  Grid.Columns.Add; // Aluno  |Código                                           0
  Grid.Columns.Add; // Aluno  |Nome                                             0

  for i:=1 to nsab do begin
    Grid.Columns.Add; // 01 Sábado                                                2
  end;

  Grid.Columns[0].Title:='Aluno|Código';
  Grid.Columns[0].Width:=40;
  Grid.Columns[0].HorzAlign:=haCenter;
  Grid.Columns[0].ReadOnly:=true;
  Grid.Columns[0].Color:=$00D2FFFF;

  Grid.Columns[1].Title:='Aluno|Nome';
  Grid.Columns[1].Width:=250;
  Grid.Columns[1].HorzAlign:=haLeft;
  Grid.Columns[1].ReadOnly:=true;
  Grid.Columns[1].Color:=$00D2FFFF;

  xdatai:=xdatabase;
  for i:=1 to nsab do begin
    application.ProcessMessages;
    Grid.Columns[i+1].Title:='Registro de Presença|Sáb '+espaco(inttostr(i),'0','dir',2)+';'+xdatai;
    Grid.Columns[i+1].Width:=50;
    Grid.Columns[i+1].ReadOnly:=true;
    Grid.Columns[i+1].HorzAlign:=haCenter;
    xdatai:=formatdatetime('dd/mm/yy',strtodate(xdatai)+7);
  end;

  Grid.ColCount:=nsab+2;


  data10.myalunos.Close;
  data10.myalunos.Sql.Clear;
  data10.myalunos.sql.Add('select a.codigo,a.nome from membro a where ((a.classe='+#39+cbAux.Text+#39+') and (a.ativo='+#39+'S'+#39+')) order by a.nome');
  data10.myalunos.Open;
  data10.myalunos.First;
  Grid.RowCount:=data10.myalunos.RecordCount;
  lin:=0;
  while data10.myalunos.eof=false do begin
    application.ProcessMessages;

    Grid[0,lin]:=data10.myalunos.fieldbyname('codigo').asstring;
    Grid[1,lin]:=data10.myalunos.fieldbyname('nome').asstring;
    col:=1;
    xdatai:=xdatabase;
    for i:=1 to nsab do begin
      data10.myapresente.Close;
      data10.myapresente.Sql.Clear;
      data10.myapresente.sql.Add('select a.presenca,a.codigo from chamada a where ((a.aluno='+#39+Grid[0,lin]+#39+') and (a.dtchamada='+#39+mydata(xdatai)+#39+')) limit 0,1');
      data10.myapresente.Open;
      if data10.myapresente.recordcount=1 then begin
        x:=data10.myapresente.fieldbyname('presenca').asstring;
      end else begin
       x:='';
      end;
      Grid[col+i,lin]:=x;
      xdatai:=formatdatetime('dd/mm/yyyy',strtodate(xdatai)+7);

    end;

    lin:=lin+1;
    data10.myalunos.Next;
  end;
  Verpresentes;

  Grid.EndUpdate;
  application.ProcessMessages;




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


  Grid2.BeginUpdate;
  Grid2.Clear;


  Grid2.Columns.Add; // Pergunta|Num.                                           0
  Grid2.Columns.Add; // Pergunta|Descrição                                      0

  for i:=1 to nsab do begin
    Grid2.Columns.Add;
  end;

  Grid2.ColCount:=nsab+2;

  Grid2.Columns[0].Title:='Pergunta|Num.';
  Grid2.Columns[0].Width:=40;
  Grid2.Columns[0].HorzAlign:=haCenter;
  Grid2.Columns[0].ReadOnly:=true;
  Grid2.Columns[0].Color:=$00D2FFFF;

  Grid2.Columns[1].Title:='Pergunta|Descrição';
  Grid2.Columns[1].Width:=250;
  Grid2.Columns[1].HorzAlign:=haLeft;
  Grid2.Columns[1].ReadOnly:=true;
  Grid2.Columns[1].Color:=$00D2FFFF;

  xdatai:=xdatabase;
  for i:=1 to nsab do begin
    application.ProcessMessages;
    Grid2.Columns[i+1].Title:='Registro de Apontamentos|Sáb '+espaco(inttostr(i),'0','dir',2)+';'+xdatai;
    Grid2.Columns[i+1].Width:=50;
    Grid2.Columns[i+1].ReadOnly:=true;
    Grid2.Columns[i+1].HorzAlign:=haCenter;
    xdatai:=formatdatetime('dd/mm/yy',strtodate(xdatai)+7);
  end;

  Grid2.RowCount:=nperguntas;

  np:='';
  for i:=1 to nperguntas do begin
   np:=espaco(inttostr(i),'0','dir',2);
   Grid2[0,i-1]:=np;
   Grid2[1,i-1]:=trim(data10.myPerguntas.fieldbyname('pergunta'+np).asstring);
  end;

  xdatai:=xdatabase;
  for i:=1 to nsab do begin

    data10.myAponta.Close;
    data10.myAponta.Sql.Clear;
    x:='select a.* from apontamentos a where a.dtchamada='+#39+mydata(xdatai)+#39+' and a.codclasse='+#39+cbAux.Text+#39+' limit 0,1';
    data10.myAponta.sql.Add(x);
    data10.myAponta.Open;
    if data10.myAponta.RecordCount=1 then begin
      np:='';
      for k:=1 to nperguntas do begin
        np:=espaco(inttostr(k),'0','dir',2);
        Grid2[i+1,k-1]:=np;
        Grid2[i+1,k-1]:=trim(data10.myAponta.fieldbyname('p'+np).asstring);
      end;

    end;
    xdatai:=formatdatetime('dd/mm/yyyy',strtodate(xdatai)+7);
  end;

  Grid2.EndUpdate;
  application.ProcessMessages;
  btnLocalizar.Enabled:=true;
  btnLocalizar.Tag:=1;
  btnGravar.Tag:=0;
end;

procedure TfrmChamadaCompleta.FormShow(Sender: TObject);
var
  x:string;
begin
  cbClasse.Items.Clear;
  cbAux.Items.Clear;
  with data10.myaux do begin
    close;
    sql.clear;
    x:='select codigo,descricao,numero from classe where igreja='+#39+frmprincipal.Configura[3]+#39+' and ativo='+#39+'S'+#39+' and codigo<>'+#39+'1'+#39+' order by numero';
    sql.add(x);
    open;
    first;
    while eof=false do begin
      cbClasse.Items.add(espaco(fieldbyname('numero').asstring,'0','dir',3)+' '+fieldbyname('descricao').asstring);
      cbAux.Items.add(fieldbyname('codigo').asstring);
      next;
    end;
    cbClasse.ItemIndex:=0;
  end;
end;

procedure TfrmChamadaCompleta.gridDblClick(Sender: TObject);
var
  x:string;
  a:integer;
begin
  if (Grid.Col)>1 then begin
    x:=trim(Grid[Grid.Col,Grid.Row]);
    a:=0;
    if (x='') and (a=0) then begin
      x:='F';
      a:=1;
    end;

    if (x='F') and (a=0) then begin
      x:='P';
      a:=1;
    end;

    if (x='P') and (a=0) then begin
      x:='J';
      a:=1;
    end;

    if (x='J') and (a=0) then begin
      x:='F';
      a:=1;
    end;


    Grid[Grid.Col,Grid.Row]:=x;
    Verpresentes;
  end;
end;

procedure TfrmChamadaCompleta.gridKeyPress(Sender: TObject; var Key: Char);
begin
  if (Grid.Col)>1 then begin
    if ((key='F') or (key='f')) then begin Grid[Grid.Col,Grid.Row]:='F'; Verpresentes; end;
    if ((key='P') or (key='p')) then begin Grid[Grid.Col,Grid.Row]:='P'; Verpresentes; end;
    if ((key='J') or (key='j')) then begin Grid[Grid.Col,Grid.Row]:='J'; Verpresentes; end;
    if (key=' ') then begin Grid[Grid.Col,Grid.Row]:=' '; Verpresentes; end;
  end;
end;

procedure TfrmChamadaCompleta.Grid2DblClick(Sender: TObject);
var
  x,xdt:string;
begin
  if (Grid2.Col)>1 then begin
    xdt:=voltacod(voltacod(Grid2.Columns[Grid2.col].Title,'|',1),';',1);
    x:=InputBox('Apontamento '+xdt,Grid2[1,Grid2.row], Grid2[Grid2.col,Grid2.row]);
    Grid2.BeginUpdate;
    Grid2[Grid2.col,Grid2.row]:=x;
    Grid2.EndUpdate;
    application.ProcessMessages;
  end;
end;

procedure TfrmChamadaCompleta.Grid2KeyPress(Sender: TObject;
  var Key: Char);
var
  x,xdt:string;
begin
  if (Grid2.Col)>1 then begin
    if ((key='A') or (key='a')) then begin
      xdt:=voltacod(voltacod(Grid2.Columns[Grid2.col].Title,'|',1),';',1);
      x:=InputBox('Apontamento '+xdt,Grid2[1,Grid2.row], Grid2[Grid2.col,Grid2.row]);
      Grid2.BeginUpdate;
      Grid2[Grid2.col,Grid2.row]:=x;
      Grid2.EndUpdate;
      application.ProcessMessages;
    end;
  end;
end;


procedure TfrmChamadaCompleta.btnGravarClick(Sender: TObject);
var
  i,lin,col:integer;
  x,xcdAluno,xdata,xinfo,xcdClasse:string;

  xp:array[1..10] of string;
begin
  if btnLocalizar.Tag=1 then begin
    btnGravar.Enabled:=false;
    for lin:=0 to Grid.RowCount-1 do begin
      application.ProcessMessages;
      xcdAluno:=Grid[0,lin];
      for Col:=2 to Grid.Colcount-1 do begin
        application.ProcessMessages;
        xdata:=voltacod(voltacod(Grid.Columns[col].Title,'|',1),';',1);
        xinfo:=trim(Grid[Col,Lin]);
        if xinfo='' then begin
          xinfo:='F';
        end;

        data10.myapresente.Close;
        data10.myapresente.Sql.Clear;
        data10.myapresente.sql.Add('select a.codigo from chamada a where ((a.aluno='+#39+xcdAluno+#39+') and (a.dtchamada='+#39+mydata(xdata)+#39+')) limit 0,1');
        data10.myapresente.Open;
        if data10.myapresente.recordcount=1 then begin

          with data10.exemysql do begin
            sql.clear;
            x:='UPDATE chamada SET ';
            x:=x+'presenca='+#39+xinfo+#39;
            x:=x+' where codigo='+#39+data10.myapresente.fieldbyname('codigo').asstring+#39;
            sql.add(x);
            ExecSql;
          end;


        end else begin

          data10.exemysql.sql.clear;
          x:='INSERT INTO chamada ';
          x:=x+'(codigo, aluno, dtchamada, presenca, sincro) ';
          x:=x+'VALUES (NULL,';                                          // codigo
          x:=x+#39+xcdAluno+#39+',';                                     // aluno
          x:=x+#39+mydata(xdata)+#39+',';                                // dtchamada
          x:=x+#39+xinfo+#39+',';                                        // presenca
          x:=x+#39+'N'+#39;                                              // sincro
          x:=x+')';
          data10.exemysql.sql.add(x);
          data10.exemysql.ExecSql;

        end;



      end;
    end;


    for Col:=2 to Grid.ColCount-1 do begin

      application.ProcessMessages;

      xdata:=voltacod(voltacod(Grid.Columns[col].Title,'|',1),';',1);
      xcdClasse:=cbAux.Text;

      for i:=1 to 10 do begin
        xp[i]:='0';
      end;
      for i:=0 to Grid2.RowCount-1 do begin
        xp[i+1]:=Grid2[Col,i];
      end;

      data10.myAponta.Close;
      data10.myAponta.Sql.Clear;
      x:='select a.codigo from apontamentos a where a.dtchamada='+#39+mydata(xdata)+#39+' and a.codclasse='+#39+xcdClasse+#39+' limit 0,1';
      data10.myAponta.sql.Add(x);
      data10.myAponta.Open;
      if data10.myAponta.recordcount=1 then begin

        with data10.exemysql do begin
          sql.clear;
          x:='UPDATE apontamentos SET ';
          x:=x+'p01='+#39+xp[1]+#39+',';
          x:=x+'p02='+#39+xp[2]+#39+',';
          x:=x+'p03='+#39+xp[3]+#39+',';
          x:=x+'p04='+#39+xp[4]+#39+',';
          x:=x+'p05='+#39+xp[5]+#39+',';
          x:=x+'p06='+#39+xp[6]+#39+',';
          x:=x+'p07='+#39+xp[7]+#39+',';
          x:=x+'p08='+#39+xp[8]+#39+',';
          x:=x+'p09='+#39+xp[9]+#39+',';
          x:=x+'p10='+#39+xp[10]+#39;
          x:=x+' where codigo='+#39+data10.myAponta.fieldbyname('codigo').asstring+#39;
          sql.add(x);
          ExecSql;
        end;


      end else begin

        data10.exemysql.sql.clear;
        x:='INSERT INTO apontamentos ';
        x:=x+'(codigo, codclasse, dtchamada, p01,p02,p03,p04,p05,p06,p07,p08,p09,p10, sincro) ';
        x:=x+'VALUES (NULL,';                                          // codigo
        x:=x+#39+xcdClasse+#39+',';                                    // codclasse
        x:=x+#39+mydata(xdata)+#39+',';                                // dtchamada
        x:=x+#39+xp[1]+#39+',';                                        // p01
        x:=x+#39+xp[2]+#39+',';                                        // p02
        x:=x+#39+xp[3]+#39+',';                                        // p03
        x:=x+#39+xp[4]+#39+',';                                        // p04
        x:=x+#39+xp[5]+#39+',';                                        // p05
        x:=x+#39+xp[6]+#39+',';                                        // p06
        x:=x+#39+xp[7]+#39+',';                                        // p07
        x:=x+#39+xp[8]+#39+',';                                        // p08
        x:=x+#39+xp[9]+#39+',';                                        // p09
        x:=x+#39+xp[10]+#39+',';                                       // p10
        x:=x+#39+'N'+#39;                                              // sincro
        x:=x+')';
        data10.exemysql.sql.add(x);
        data10.exemysql.ExecSql;

      end;
    end;

    btnGravar.Enabled:=true;
    btnGravar.Tag:=1;
    application.MessageBox('Concluído com Sucesso','Atenção',mb_ok);
  end;

end;

procedure TfrmChamadaCompleta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ((btnLocalizar.tag=1) and (btnGravar.tag=0)) then begin
    if application.MessageBox('Deseja SAIR sem Gravar?','Atenção',mb_yesno)=id_no then begin
      abort;
    end;
  end;
end;

procedure TfrmChamadaCompleta.BitBtn2Click(Sender: TObject);
begin
  cbAux.ItemIndex:=cbClasse.ItemIndex;
  frmprincipal.c_agora;
  if btnLocalizar.Tag=1 then begin
    Application.CreateForm(Tfrmparticipa_classe, frmparticipa_classe);
    frmparticipa_classe.edit1.text:=cbAux.Text;
    frmparticipa_classe.edit2.text:=cbClasse.Text;
    frmparticipa_classe.showmodal;
    frmparticipa_classe.Free;
  end;
  btnLocalizar.Click;
end;

procedure TfrmChamadaCompleta.BitBtn3Click(Sender: TObject);
begin
  frmChamadaCompleta.Close;
end;

procedure TfrmChamadaCompleta.BitBtn4Click(Sender: TObject);
begin
    Application.CreateForm(TfrmResumoES, frmResumoES);
    frmResumoES.showmodal;
    frmResumoES.Free;
end;

end.
