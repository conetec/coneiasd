unit semperiodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, funcoes, Grids, DBGrids, RLFilters,
  RLDraftFilter, RLXLSFilter, RLPDFFilter, RLHTMLFilter, Menus,Chart, Series,
  ExtCtrls, TeeProcs, TeEngine, CheckLst, JvExMask, JvToolEdit, QuickRpt, funcaolocal,
  ComCtrls;

type
  Tfrmsemperiodo = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    nlista02: TLabel;
    lista02: TComboBox;
    nlista01: TLabel;
    lista01: TComboBox;
    nlista03: TLabel;
    lista03: TComboBox;
    nlista04: TLabel;
    lista04: TComboBox;
    nlista05: TLabel;
    lista05: TComboBox;
    PopupMenu1: TPopupMenu;
    Procurar1: TMenuItem;
    Sair1: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    PopupMenu3: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    PopupMenu4: TPopupMenu;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    PopupMenu5: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    QRCompositeReport1: TQRCompositeReport;
    memoax: TMemo;
    barra: TProgressBar;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dataiKeyPress(Sender: TObject; var Key: Char);
    function voltap(xdt:string):integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmsemperiodo: Tfrmsemperiodo;

  
  rdata : array of string[10];
  rentrada : array of real;
  rsaida : array of real;
  rsaldo : array of real;
  racumula : array of real;
  eatraso : array of real;
  satraso : array of real;
  stotal  : array of real;
  wcheque : array of real;

  

implementation

uses datamodule10,  principal, imprel_001, imprel_008, imprel_012;

{$R *.dfm}


procedure Tfrmsemperiodo.FormShow(Sender: TObject);
var
  i:integer;
  x:string;
begin


{
  propriedade Height de acordo com numero de filtros
  com 5
  frmsemperiodo.Height:=300+120;
  com 4
  frmsemperiodo.Height:=250+120;
  com 3
  frmsemperiodo.Height:=200+120;
  com 2
  frmsemperiodo.Height:=150+120;
  com 1
  frmsemperiodo.Height:=105+120;

}

    lista01.Visible:=false;
    nlista01.Visible:=false;

    lista02.Visible:=false;
    nlista02.Visible:=false;

    lista03.Visible:=false;
    nlista03.Visible:=false;

    lista04.Visible:=false;
    nlista04.Visible:=false;

    lista05.Visible:=false;
    nlista05.Visible:=false;


  if frmsemperiodo.tag=2 then begin

    frmsemperiodo.caption:='Resumo de Apontamentos';
    frmsemperiodo.Height:=150+120;

    bitbtn1.Top:=lista02.Top+42;  // sempre ultima lista
    bitbtn2.Top:=bitbtn1.Top;

    label1.Top:=bitbtn1.Top+56;
    barra.top:=label1.Top+16;

    lista01.Visible:=true;
    nlista01.Visible:=true;
    nlista01.Caption:='Classe';
    lista01.Items.clear;

    lista02.Visible:=true;
    nlista02.Visible:=true;
    nlista02.Caption:='Trimestre';
    lista02.Items.clear;

    lista01.items.Add('TODAS AS CLASSES | 0');
    with data10.mytudo do begin
      close;
      sql.clear;
      x:='select Codigo,descricao,numero from classe ';
      x:=x+' where (';
      x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (ativo='+#39+'S'+#39+')';
      x:=x+' and (codigo>'+#39+'1'+#39+')';
      x:=x+')';
      x:=x+' order by numero';
      sql.add(x);
      open;
      first;
      while eof=false do begin
        lista01.items.Add(espaco(fieldbyname('numero').asstring,'0','dir',2)+' '+fieldbyname('descricao').asstring+' | '+fieldbyname('codigo').asstring);
        next;
      end;
      lista01.ItemIndex:=0;
    end;


    with data10.mytudo do begin
      close;
      sql.clear;
      x:='select codigo,descricao,datai,dataf from trimestre ';
      x:=x+' where (';
      x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+')';
      x:=x+' order by codigo desc';
      sql.add(x);
      open;
      first;
      while eof=false do begin
        lista02.items.Add(fieldbyname('descricao').asstring+' | '+fieldbyname('codigo').asstring);
        next;
      end;
      lista02.ItemIndex:=0;
    end;
  end;



  if frmsemperiodo.tag=1 then begin
    frmsemperiodo.caption:='ES Chamada e Apontamentos';
    frmsemperiodo.Height:=200+120;

    bitbtn1.Top:=lista03.Top+42;  // sempre ultima lista
    bitbtn2.Top:=bitbtn1.Top;

    label1.Top:=bitbtn1.Top+56;
    barra.top:=label1.Top+16;


    lista01.Visible:=true;
    nlista01.Visible:=true;
    nlista01.Caption:='Classe';
    lista01.Items.clear;


    lista02.Visible:=true;
    nlista02.Visible:=true;
    nlista02.Caption:='Trimestre';
    lista02.Items.clear;

    lista03.Visible:=true;
    nlista03.Visible:=true;
    nlista03.Caption:='Processar Faltas';
    lista03.Items.clear;

 //   lista01.items.Add('TODAS AS CLASSES | 0');

    with data10.mytudo do begin
      close;
      sql.clear;
      x:='select Codigo,descricao,numero from classe ';
      x:=x+' where (';
      x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (ativo='+#39+'S'+#39+')';
      x:=x+' and (codigo>'+#39+'1'+#39+')';
      x:=x+')';
      x:=x+' order by numero';
      sql.add(x);
      open;
      first;
      while eof=false do begin
        lista01.items.Add(espaco(fieldbyname('numero').asstring,'0','dir',2)+' '+fieldbyname('descricao').asstring+' | '+fieldbyname('codigo').asstring);
        next;
      end;
      lista01.ItemIndex:=0;
    end;
    with data10.mytudo do begin
      close;
      sql.clear;
      x:='select codigo,descricao,datai,dataf from trimestre ';
      x:=x+' where (';
      x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+')';
      x:=x+' order by codigo desc';
      sql.add(x);
      open;
      first;
      while eof=false do begin
        lista02.items.Add(fieldbyname('descricao').asstring+' | '+fieldbyname('codigo').asstring);
        next;
      end;
      lista02.ItemIndex:=0;
    end;

    lista03.items.Add('SIM');
    lista03.items.Add('NÃO');
    lista03.ItemIndex:=1;
  end;


end;

procedure Tfrmsemperiodo.BitBtn2Click(Sender: TObject);
begin
  frmsemperiodo.close;
end;

function temmais(pos:integer;alista:Tchecklistbox):boolean;
var
  a,k:integer;
begin
 a:=0;
 for k:=pos to alista.items.count-1 do begin
   if alista.Checked[k]=true then begin
     a:=1;
     break;
   end;
 end;
 if a=0 then begin
   temmais:=false;
 end else begin
   temmais:=true;
 end;
end;


function difdata(dataf,datai:string):string;
var
  v : real;
begin
  v := strtodate(dataf) - strtodate(datai);
  v:=v+1;
  difdata := formatfloat('###,###,###,0',abs(v));
end;


function Tfrmsemperiodo.voltap(xdt:string):integer;
var
  k,kp:integer;

begin
  for k:=0 to Length(rdata)-1 do begin
    kp:=k;
    if rdata[k]=xdt then begin
      break;
    end;
  end;
  voltap:=kp;
end;


function verifica_presenca(codmembro,qdata:string):string;
var
  xp1:string;
begin
  if strtodate(qdata)>date then begin
    xp1:='';

  end else begin
   with data10.mypresente do begin
    close;
    sql.clear;
    xp1:='select a.presenca,a.contato,a.dtchama from lista_es a';
    xp1:=xp1+' where (';
    xp1:=xp1+' (a.aluno='+#39+codmembro+#39+')';
    xp1:=xp1+' and (a.dtchama='+#39+mydata(qdata)+#39+')';
    xp1:=xp1+')';
    xp1:=xp1+'order by a.presenca desc limit 0,1';
    sql.add(xp1);
    open;
    if recordcount=1 then begin
      xp1:=fieldbyname('presenca').asstring;
      if xp1='F' then begin
        xp1:=xp1+tminusculo(fieldbyname('contato').asstring);
      end;
    end else begin
      xp1:='';
    end;
  end;
  end;
  verifica_presenca:=xp1;
end;





procedure Tfrmsemperiodo.BitBtn1Click(Sender: TObject);
var
  x,opsel:string;
  ax1,ax2,ax3,ax4:real;
  sab,dom,qua,outro:real;
  f01,f02,f03,f04:real;
  xdti,xdtf,dtp,x1,x2,aclasse,nomeclasse:string;
  i,bt,ba,nalunos,k:integer;
  presenca:array[1..25] of string;
begin
  frmprincipal.c_agora;
  bitbtn1.Enabled:=false;
  barra.Position:=0;


  if frmsemperiodo.tag=2 then begin

    with data10.myaux do begin
      close;
      sql.Clear;
      x:='select a.*';
      x:=x+' from trimestre a';
      x:=x+' where (';
      x:=x+' (a.codigo='+#39+voltacod(lista02.text,'|',1)+#39+')';
      x:=x+')';
      x:=x+' limit 0,1';
      sql.add(x);
      open;
    end;

    with data10.myimp do begin
      close;
      sql.Clear;
      x:='select a.codigo,a.descricao,b.datamov,c.p01,c.p02,c.p03,c.p04,c.p05,c.p06';
      x:=x+' from classe a left join chamada_es b on a.codigo=b.classe left join chamada_aponta c on b.codigo=c.chamada';
      x:=x+' where (';
      x:=x+' (a.ativo='+#39+'S'+#39+')';
      x:=x+' and (a.departamento='+#39+'ADULTO'+#39+')';
      x:=x+' and (b.trimestre='+#39+voltacod(lista02.text,'|',1)+#39+')';
      if voltacod(lista01.text,'|',1)<>'0' then begin
        x:=x+' and (a.codigo='+#39+voltacod(lista01.text,'|',1)+#39+')';
      end;
      x:=x+')';
      x:=x+' order by a.codigo,b.datamov';
      sql.add(x);
      open;
    end;
    Application.CreateForm(Tfrmimprel_012, frmimprel_012);

    frmimprel_012.mnpergunta.Lines.Clear;
    frmimprel_012.mnpergunta.Lines.add('Apontamentos:');
    frmimprel_012.mnpergunta.Lines.add('01 - '+data10.myaux.fieldbyname('pergunta01').asstring);
    frmimprel_012.mnpergunta.Lines.add('02 - '+data10.myaux.fieldbyname('pergunta02').asstring);
    frmimprel_012.mnpergunta.Lines.add('03 - '+data10.myaux.fieldbyname('pergunta03').asstring);
    frmimprel_012.mnpergunta.Lines.add('04 - '+data10.myaux.fieldbyname('pergunta04').asstring);
    frmimprel_012.mnpergunta.Lines.add('05 - '+data10.myaux.fieldbyname('pergunta05').asstring);



    frmimprel_012.titulo.Caption:='Resumo de Apontamentos';
    frmimprel_012.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
    frmimprel_012.empresa.Caption:=frmprincipal.Configura[4];
    frmimprel_012.RLReport1.Prepare;
    frmimprel_012.RLReport1.Preview;
    frmimprel_012.free;

  end;



  if frmsemperiodo.tag=1 then begin


    //Sabados do Trimestre

    memoax.lines.clear;
    x:=voltainfo('trimestre','codigo|descricao|datai|dataf','codigo='+#39+voltacod(lista02.Text,'|',1)+#39,'T|T|D|D','0');
    xdti:=voltacod(x,'|',2);
    xdtf:=voltacod(x,'|',3);

    dtp:=xdti;
    while (strtodate(dtp)<=strtodate(xdtf)) do begin
      if DayOfWeek(strtodate(dtp))=7 then begin
        memoax.lines.Add(dtp);
      end;
      dtp:=formatdatetime('dd/mm/yyyy',strtodate(dtp)+1);
    end;
    memoax.Text:=trim(memoax.text);


    x:='truncate relatorio_chamada';
    with data10.exemysql do begin
      sql.clear;
      sql.add(x);
      ExecSql;
    end;

    // Cria o Arquivo do Relatorio

    with data10.myrel do begin
      close;
      sql.clear;
      x:='select a.codigo,a.nome,a.classe,';
      x:=x+'b.numero,b.descricao';
      x:=x+' from membro a left join classe b on a.classe=b.codigo';
      x:=x+' where (';
      x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (a.ativo='+#39+'S'+#39+')';
      x:=x+' and (a.classe>1)';
      if voltacod(lista01.text,'|',1)<>'0' then begin
        x:=x+' and (a.classe='+#39+voltacod(lista01.text,'|',1)+#39+')';
      end;

      x:=x+')';
      x:=x+' order by a.classe,a.nome';
      sql.add(x);
      open;
      barra.Max:=recordcount;
      nalunos:=recordcount;
    //  application.MessageBox(pchar(inttostr(nalunos)),'',mb_ok);
      if nalunos>=14 then begin
        nalunos:=0;
      end else begin
        nalunos:=14-nalunos;
      end;
      first;
      aclasse:=voltacod(lista01.text,'|',1);
      x:=voltacod(lista01.text,'|',0);
      nomeclasse:=espaco(voltacod(x,' ',0),'0','dir',2)+' '+voltacod(x,' ',1);

      while eof=false do begin
        aclasse:=data10.myrel.fieldbyname('classe').asstring;
        barra.Position:=barra.Position+1;
        label1.Caption:='Progresso '+inttostr(barra.position)+' / '+inttostr(barra.Max);
        application.ProcessMessages;
        for i:=1 to 15 do begin
          presenca[i]:='';
        end;
        if trim(lista03.Text)='SIM' then begin
          for i:=0 to memoax.Lines.Count-1 do begin
            presenca[i+1]:=verifica_presenca(data10.myrel.fieldbyname('codigo').asstring,memoax.lines[i]);
          end;
        end;

        data10.exemysql.sql.clear;
        x1:=pmaiusculo(data10.myrel.fieldbyname('nome').asstring)+' ('+espaco(data10.myrel.fieldbyname('codigo').asstring,'0','dir',4)+')';
        x2:=espaco(data10.myrel.fieldbyname('numero').asstring,'0','dir',2)+' '+data10.myrel.fieldbyname('descricao').asstring;
        x:='INSERT INTO relatorio_chamada ';
        x:=x+'(codigo, nome, igreja, classe, dclasse, usuario, s01, s02, s03, s04, s05, s06, s07, s08, s09, s10, s11, s12, s13, s14, s15) ';
        x:=x+'VALUES (NULL,';                                                 // codigo
        x:=x+#39+x1+#39+',';                                                  // nome
        x:=x+#39+frmprincipal.Configura[3]+#39+',';                           // igreja
        x:=x+#39+aclasse+#39+',';                                             // classe
        x:=x+#39+x2+#39+',';                                                  // dclasse
        x:=x+#39+frmprincipal.configura[1]+#39+',';                           // usuario
        x:=x+#39+presenca[1]+#39+',';                                         // s01
        x:=x+#39+presenca[2]+#39+',';                                         // s02
        x:=x+#39+presenca[3]+#39+',';                                         // s03
        x:=x+#39+presenca[4]+#39+',';                                         // s04
        x:=x+#39+presenca[5]+#39+',';                                         // s05
        x:=x+#39+presenca[6]+#39+',';                                         // s06
        x:=x+#39+presenca[7]+#39+',';                                         // s07
        x:=x+#39+presenca[8]+#39+',';                                         // s08
        x:=x+#39+presenca[9]+#39+',';                                         // s09
        x:=x+#39+presenca[10]+#39+',';                                        // s10
        x:=x+#39+presenca[11]+#39+',';                                        // s11
        x:=x+#39+presenca[12]+#39+',';                                        // s12
        x:=x+#39+presenca[13]+#39+',';                                        // s13
        x:=x+#39+presenca[14]+#39+',';                                        // s14
        x:=x+#39+presenca[15]+#39;                                            // s15
        x:=x+')';
        data10.exemysql.sql.add(x);
        data10.exemysql.ExecSql;

        next;
      end;
    end;


    for k:=0 to nalunos do begin

      application.ProcessMessages;
      for i:=1 to 15 do begin
        presenca[i]:='';
      end;

      data10.exemysql.sql.clear;
      x1:='ZZZZZZZZZZ';
      x:='INSERT INTO relatorio_chamada ';
      x:=x+'(codigo, nome, igreja, classe, dclasse, usuario, s01, s02, s03, s04, s05, s06, s07, s08, s09, s10, s11, s12, s13, s14, s15) ';
      x:=x+'VALUES (NULL,';                                                 // codigo
      x:=x+#39+x1+#39+',';                                                  // nome
      x:=x+#39+frmprincipal.Configura[3]+#39+',';                           // igreja
      x:=x+#39+aclasse+#39+',';                                             // classe
      x:=x+#39+nomeclasse+#39+',';                                          // dclasse
      x:=x+#39+frmprincipal.configura[1]+#39+',';                           // usuario
      x:=x+#39+presenca[1]+#39+',';                                         // s01
      x:=x+#39+presenca[2]+#39+',';                                         // s02
      x:=x+#39+presenca[3]+#39+',';                                         // s03
      x:=x+#39+presenca[4]+#39+',';                                         // s04
      x:=x+#39+presenca[5]+#39+',';                                         // s05
      x:=x+#39+presenca[6]+#39+',';                                         // s06
      x:=x+#39+presenca[7]+#39+',';                                         // s07
      x:=x+#39+presenca[8]+#39+',';                                         // s08
      x:=x+#39+presenca[9]+#39+',';                                         // s09
      x:=x+#39+presenca[10]+#39+',';                                        // s10
      x:=x+#39+presenca[11]+#39+',';                                        // s11
      x:=x+#39+presenca[12]+#39+',';                                        // s12
      x:=x+#39+presenca[13]+#39+',';                                        // s13
      x:=x+#39+presenca[14]+#39+',';                                        // s14
      x:=x+#39+presenca[15]+#39;                                            // s15
      x:=x+')';
      data10.exemysql.sql.add(x);
      data10.exemysql.ExecSql;
    end;


    with data10.mytudo do begin
      close;
      sql.Clear;
      sql.add('select * from relatorio_chamada where usuario='+#39+frmprincipal.configura[1]+#39+' order by classe,nome');
      open;
    end;
    Application.CreateForm(Tfrmimprel_008, frmimprel_008);

    frmimprel_008.RLmemo1.Lines.Clear;
    frmimprel_008.RLMemo2.Lines.Clear;
    frmimprel_008.RLMemo3.Lines.Clear;
    frmimprel_008.RLMemo4.Lines.Clear;
    frmimprel_008.RLMemo5.Lines.Clear;
    frmimprel_008.RLMemo6.Lines.Clear;
    frmimprel_008.RLMemo7.Lines.Clear;


    frmimprel_008.mt01.Lines.Clear;
    frmimprel_008.mt02.Lines.Clear;
    frmimprel_008.mt03.Lines.Clear;
    frmimprel_008.mt04.Lines.Clear;
    frmimprel_008.mt05.Lines.Clear;
    frmimprel_008.mt06.Lines.Clear;


    frmimprel_008.mt01.Lines.add('01 ');
    frmimprel_008.mt02.Lines.add('02 ');
    frmimprel_008.mt03.Lines.add('03 ');
    frmimprel_008.mt04.Lines.add('04 ');
    frmimprel_008.mt05.Lines.add('05 ');
    frmimprel_008.mt06.Lines.add('06 ');



    with data10.myrel do begin
      close;
      sql.clear;
      sql.add('select * from aponta_perguntas where ativo='+#39+'S'+#39+' limit 0,1');
      open;
      frmimprel_008.RLmemo1.Lines.Add(fieldbyname('pergunta01').value);
      frmimprel_008.RLMemo2.Lines.Add(fieldbyname('pergunta02').value);
      frmimprel_008.RLMemo3.Lines.Add(fieldbyname('pergunta03').value);
      frmimprel_008.RLMemo4.Lines.Add(fieldbyname('pergunta04').value);
      frmimprel_008.RLMemo5.Lines.Add(fieldbyname('pergunta05').value);
      frmimprel_008.RLMemo6.Lines.Add(fieldbyname('pergunta06').value);
      frmimprel_008.RLMemo7.Lines.Add(fieldbyname('pergunta07').value);
      close;
    end;

    frmimprel_008.titulo.Caption:='Chamada e Apontamentos';
    frmimprel_008.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
    frmimprel_008.empresa.Caption:=frmprincipal.Configura[4];

    frmimprel_008.s01.Caption:='01 '+copy(trim(memoax.lines[0]),1,5);
    frmimprel_008.s02.Caption:='02 '+copy(trim(memoax.lines[1]),1,5);
    frmimprel_008.s03.Caption:='03 '+copy(trim(memoax.lines[2]),1,5);
    frmimprel_008.s04.Caption:='04 '+copy(trim(memoax.lines[3]),1,5);
    frmimprel_008.s05.Caption:='05 '+copy(trim(memoax.lines[4]),1,5);
    frmimprel_008.s06.Caption:='06 '+copy(trim(memoax.lines[5]),1,5);
    frmimprel_008.s07.Caption:='07 '+copy(trim(memoax.lines[6]),1,5);
    frmimprel_008.s08.Caption:='08 '+copy(trim(memoax.lines[7]),1,5);
    frmimprel_008.s09.Caption:='09 '+copy(trim(memoax.lines[8]),1,5);
    frmimprel_008.s10.Caption:='10 '+copy(trim(memoax.lines[9]),1,5);
    frmimprel_008.s11.Caption:='11 '+copy(trim(memoax.lines[10]),1,5);
    frmimprel_008.s12.Caption:='12 '+copy(trim(memoax.lines[11]),1,5);
    frmimprel_008.s13.Caption:='13 '+copy(trim(memoax.lines[12]),1,5);
    if memoax.lines.count>13 then begin
      frmimprel_008.s14.Caption:=trim(memoax.lines[13]);
    end;
    if memoax.lines.count>14 then begin
      frmimprel_008.s15.Caption:=trim(memoax.lines[14]);
    end;
    barra.Position:=0;
    label1.Caption:='Progresso';
    
    frmimprel_008.RLReport1.Prepare;
    frmimprel_008.RLReport1.Print;
    frmimprel_008.free;

  end;


  bitbtn1.Enabled:=true;

end;

procedure Tfrmsemperiodo.dataiKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

end.
