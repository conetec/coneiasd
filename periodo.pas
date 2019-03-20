unit periodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, funcoes, Grids, DBGrids, RLFilters,
  RLDraftFilter, RLXLSFilter, RLPDFFilter, RLHTMLFilter, Menus,Chart, Series,
  ExtCtrls, TeeProcs, TeEngine, CheckLst, JvExMask, JvToolEdit, QuickRpt, funcaolocal;

type
  Tfrmperiodo = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
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
    cklista: TCheckListBox;
    ncklista: TLabel;
    datai: TJvDateEdit;
    dataf: TJvDateEdit;
    QRCompositeReport1: TQRCompositeReport;
    och: TEdit;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dataiKeyPress(Sender: TObject; var Key: Char);
    procedure MenuItem1Click(Sender: TObject);
    function voltap(xdt:string):integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmperiodo: Tfrmperiodo;

  
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

uses datamodule10,  principal, imprel_001, imprel_008;

{$R *.dfm}


procedure Tfrmperiodo.FormShow(Sender: TObject);
var
  i:integer;
  x:string;
begin


{
  propriedade Height de acordo com numero de filtros
  com 5
  frmperiodo.Height:=457;
  com 4
  frmperiodo.Height:=410;
  com 3
  frmperiodo.Height:=360;
  com 2
  frmperiodo.Height:=312;
  com 1
  frmperiodo.Height:=268;
  com 0
  frmperiodo.Height:=200;

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

    cklista.Visible:=false;
    ncklista.Visible:=false;

  datai.text:='01/'+formatdatetime('mm/yyyy',date);
  dataf.text:=formatdatetime('dd/mm/yyyy',date);

  

  if frmperiodo.tag=1 then begin
    frmperiodo.caption:='Visitantes';
    frmperiodo.Height:=268;

    lista01.Visible:=true;
    nlista01.Visible:=true;
    nlista01.Caption:='Filtro de Pesquisa';
    lista01.Items.clear;
    lista01.items.Add('TODOS OS VISITANTES');
    lista01.items.Add('AMIGOS');
    lista01.items.Add('ADVENTISTAS');
    lista01.ItemIndex:=0;

  end;


end;

procedure Tfrmperiodo.BitBtn2Click(Sender: TObject);
begin
  frmperiodo.close;
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


function Tfrmperiodo.voltap(xdt:string):integer;
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
  verifica_presenca:=xp1;
end;





procedure Tfrmperiodo.BitBtn1Click(Sender: TObject);
var
  x,opsel:string;
  ax1,ax2,ax3,ax4:real;
  sab,dom,qua,outro:real;
  f01,f02,f03,f04:real;
  xdti,xdtf,dtp,x1,x2:string;
  i:integer;
  presenca:array[1..15] of string;
begin
  frmprincipal.c_agora;
  bitbtn1.Enabled:=false;


 

  if frmperiodo.tag=1 then begin

    Application.CreateForm(Tfrmimprel_001, frmimprel_001);
    frmimprel_001.RLLabel5.Caption:='Estatísticas - Perfil ('+lista01.Text+')';
    frmimprel_001.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
    opsel:=trim(lista01.Text);

    with data10.myrel do begin
      close;
      sql.clear;
      x:='select distinct amigo from visita';
      x:=x+' where (';
      x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (datamov<='+#39+mydata(dataf.text)+#39+')';
      if opsel='AMIGOS' then begin
        x:=x+' and (adventista='+#39+'N'+#39+')';
      end;
      if opsel='ADVENTISTAS' then begin
        x:=x+' and (adventista='+#39+'S'+#39+')';
      end;
      x:=x+')';
      sql.add(x);
      open;
      ax1:=recordcount;
    end;


    with data10.myrel do begin
      close;
      sql.clear;
      x:='select count(codigo) as total from visita';
      x:=x+' where (';
      x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (datamov<='+#39+mydata(dataf.text)+#39+')';
      if opsel='AMIGOS' then begin
        x:=x+' and (adventista='+#39+'N'+#39+')';
      end;
      if opsel='ADVENTISTAS' then begin
        x:=x+' and (adventista='+#39+'S'+#39+')';
      end;
      x:=x+')';
      sql.add(x);
      open;
      first;
      ax2:=0;
      while eof=false do begin
        if fieldbyname('total').asstring<>'' then begin
          ax2:=ax2+fieldbyname('total').value;
        end;
        next;
      end;
    end;

    //// Cidade  ////////////////////////////////////////////////////////////////////////////////////


    with data10.myrel do begin
      close;
      sql.clear;
      x:='select distinct b.nome as total from visita a left join amigo b';
      x:=x+' on a.amigo=b.codigo';
      x:=x+' where (';
      x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (a.datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (a.datamov<='+#39+mydata(dataf.text)+#39+')';
      x:=x+' and (b.cidade='+#39+frmprincipal.Configura[5]+#39+')';
      if opsel='AMIGOS' then begin
        x:=x+' and (a.adventista='+#39+'N'+#39+')';
      end;
      if opsel='ADVENTISTAS' then begin
        x:=x+' and (a.adventista='+#39+'S'+#39+')';
      end;
      x:=x+')';
      x:=x+' group by b.nome';
      sql.add(x);
      open;
      ax3:=recordcount;
    end;
    frmimprel_001.RLLabel12.caption:=frmprincipal.Configura[5];
    frmimprel_001.i3.caption:=formatfloat('###,###,###,0.',ax3);
    frmimprel_001.i4.caption:=formatfloat('###,###,###,0.',ax1-ax3);
    frmimprel_001.p1.caption:=formatfloat('###,###,###,0.0',ax3*100/ax1)+'%';
    frmimprel_001.p2.caption:=formatfloat('###,###,###,0.0',(ax1-ax3)*100/ax1)+'%';

    //// Acompanhado  ////////////////////////////////////////////////////////////////////////////////////

    with data10.myrel do begin
      close;
      sql.clear;
      x:='select count(codigo) as total from visita';
      x:=x+' where (';
      x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (datamov<='+#39+mydata(dataf.text)+#39+')';
      x:=x+' and (membro=0)';
      if opsel='AMIGOS' then begin
        x:=x+' and (adventista='+#39+'N'+#39+')';
      end;
      if opsel='ADVENTISTAS' then begin
        x:=x+' and (adventista='+#39+'S'+#39+')';
      end;
      x:=x+')';
      sql.add(x);
      open;
      first;
      ax3:=0;
      while eof=false do begin
        if fieldbyname('total').asstring<>'' then begin
          ax3:=ax3+fieldbyname('total').value;
        end;
        next;
      end;
    end;
    frmimprel_001.i5.caption:=formatfloat('###,###,###,0.',ax2-ax3);
    frmimprel_001.i6.caption:=formatfloat('###,###,###,0.',ax3);
    frmimprel_001.p3.caption:=formatfloat('###,###,###,0.0',(ax2-ax3)*100/ax2)+'%';
    frmimprel_001.p4.caption:=formatfloat('###,###,###,0.0',ax3*100/ax2)+'%';

    //// Dia da Semana  ////////////////////////////////////////////////////////////////////////////////////

    sab:=0; dom:=0; qua:=0; outro:=0;
    with data10.myrel do begin
      close;
      sql.clear;
      x:='select count(DATE_FORMAT(a.datamov,'+#39+'%w'+#39+')) as total, DATE_FORMAT(a.datamov,'+#39+'%w'+#39+') as dia from visita a';
      x:=x+' where (';
      x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (a.datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (a.datamov<='+#39+mydata(dataf.text)+#39+')';
      if opsel='AMIGOS' then begin
        x:=x+' and (a.adventista='+#39+'N'+#39+')';
      end;
      if opsel='ADVENTISTAS' then begin
        x:=x+' and (a.adventista='+#39+'S'+#39+')';
      end;
      x:=x+')';
      x:=x+' group by dia';
      sql.add(x);
      open;
      first;
      while eof=false do begin
        if fieldbyname('total').asstring<>'' then begin
          if fieldbyname('dia').asstring='0' then begin dom:=dom+fieldbyname('total').value; end;
          if fieldbyname('dia').asstring='1' then begin outro:=outro+fieldbyname('total').value; end;
          if fieldbyname('dia').asstring='2' then begin outro:=outro+fieldbyname('total').value; end;
          if fieldbyname('dia').asstring='3' then begin qua:=qua+fieldbyname('total').value; end;
          if fieldbyname('dia').asstring='4' then begin outro:=outro+fieldbyname('total').value; end;
          if fieldbyname('dia').asstring='5' then begin outro:=outro+fieldbyname('total').value; end;
          if fieldbyname('dia').asstring='6' then begin sab:=sab+fieldbyname('total').value; end;
        end;
        next;
      end;
    end;
    frmimprel_001.i7.caption:=formatfloat('###,###,###,0.',sab);
    frmimprel_001.i8.caption:=formatfloat('###,###,###,0.',dom);
    frmimprel_001.i9.caption:=formatfloat('###,###,###,0.',qua);
    frmimprel_001.i10.caption:=formatfloat('###,###,###,0.',outro);
    frmimprel_001.p5.caption:=formatfloat('###,###,###,0.0',sab*100/ax2)+'%';
    frmimprel_001.p6.caption:=formatfloat('###,###,###,0.0',dom*100/ax2)+'%';
    frmimprel_001.p7.caption:=formatfloat('###,###,###,0.0',qua*100/ax2)+'%';
    frmimprel_001.p8.caption:=formatfloat('###,###,###,0.0',outro*100/ax2)+'%';

    //// Adventistas ou Não  ////////////////////////////////////////////////////////////////////////////////////

    with data10.myrel do begin
      close;
      sql.clear;
      x:='select count(codigo) as total from visita';
      x:=x+' where (';
      x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (datamov<='+#39+mydata(dataf.text)+#39+')';
      x:=x+' and (adventista='+#39+'S'+#39+')';
      if opsel='AMIGOS' then begin
        x:=x+' and (adventista='+#39+'N'+#39+')';
      end;
      if opsel='ADVENTISTAS' then begin
        x:=x+' and (adventista='+#39+'S'+#39+')';
      end;
      x:=x+')';
      sql.add(x);
      open;
      first;
      ax3:=0;
      while eof=false do begin
        if fieldbyname('total').asstring<>'' then begin
          ax3:=ax3+fieldbyname('total').value;
        end;
        next;
      end;
    end;
    frmimprel_001.i21.caption:=formatfloat('###,###,###,0.',ax3);
    frmimprel_001.i22.caption:=formatfloat('###,###,###,0.',ax1-ax3);
    frmimprel_001.p19.caption:=formatfloat('###,###,###,0.0',ax3*100/ax1)+'%';
    frmimprel_001.p20.caption:=formatfloat('###,###,###,0.0',(ax1-ax3)*100/ax1)+'%';

    //// Homens e Mulheres  ////////////////////////////////////////////////////////////////////////////////////

    with data10.myrel do begin
      close;
      sql.clear;
      x:='select distinct b.nome as total from visita a left join amigo b';
      x:=x+' on a.amigo=b.codigo';
      x:=x+' where (';
      x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (a.datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (a.datamov<='+#39+mydata(dataf.text)+#39+')';
      x:=x+' and (b.sexo='+#39+'MASCULINO'+#39+')';
      if opsel='AMIGOS' then begin
        x:=x+' and (a.adventista='+#39+'N'+#39+')';
      end;
      if opsel='ADVENTISTAS' then begin
        x:=x+' and (a.adventista='+#39+'S'+#39+')';
      end;
      x:=x+')';
      x:=x+' group by b.nome';
      sql.add(x);
      open;
      ax3:=recordcount;
    end;
    frmimprel_001.i11.caption:=formatfloat('###,###,###,0.',ax3);
    frmimprel_001.i12.caption:=formatfloat('###,###,###,0.',ax1-ax3);
    frmimprel_001.p9.caption:=formatfloat('###,###,###,0.0',ax3*100/ax1)+'%';
    frmimprel_001.p10.caption:=formatfloat('###,###,###,0.0',(ax1-ax3)*100/ax1)+'%';

    //// 1ª vez na igreja  ////////////////////////////////////////////////////////////////////////////////////

    with data10.myrel do begin
      close;
      sql.clear;
      x:='select count(codigo) as total from visita';
      x:=x+' where (';
      x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (datamov<='+#39+mydata(dataf.text)+#39+')';
      x:=x+' and (pvez='+#39+'S'+#39+')';
      if opsel='AMIGOS' then begin
        x:=x+' and (adventista='+#39+'N'+#39+')';
      end;
      if opsel='ADVENTISTAS' then begin
        x:=x+' and (adventista='+#39+'S'+#39+')';
      end;
      x:=x+')';
      sql.add(x);
      open;
      first;
      ax3:=0;
      while eof=false do begin
        if fieldbyname('total').asstring<>'' then begin
          ax3:=ax3+fieldbyname('total').value;
        end;
        next;
      end;
    end;
    frmimprel_001.i13.caption:=formatfloat('###,###,###,0.',ax3);
    frmimprel_001.i14.caption:=formatfloat('###,###,###,0.',ax2-ax3);
    frmimprel_001.p11.caption:=formatfloat('###,###,###,0.0',ax3*100/ax2)+'%';
    frmimprel_001.p12.caption:=formatfloat('###,###,###,0.0',(ax2-ax3)*100/ax2)+'%';

    //// Solicitou Algo  ////////////////////////////////////////////////////////////////////////////////////

    with data10.myrel do begin
      close;
      sql.clear;
      x:='select count(codigo) as total from visita';
      x:=x+' where (';
      x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (datamov<='+#39+mydata(dataf.text)+#39+')';
      x:=x+' and (solicitacao='+#39+'S'+#39+')';
      if opsel='AMIGOS' then begin
        x:=x+' and (adventista='+#39+'N'+#39+')';
      end;
      if opsel='ADVENTISTAS' then begin
        x:=x+' and (adventista='+#39+'S'+#39+')';
      end;
      x:=x+')';
      sql.add(x);
      open;
      first;
      ax3:=0;
      while eof=false do begin
        if fieldbyname('total').asstring<>'' then begin
          ax3:=ax3+fieldbyname('total').value;
        end;
        next;
      end;
    end;
    frmimprel_001.i15.caption:=formatfloat('###,###,###,0.',ax3);
    frmimprel_001.i16.caption:=formatfloat('###,###,###,0.',ax2-ax3);
    frmimprel_001.p13.caption:=formatfloat('###,###,###,0.0',ax3*100/ax2)+'%';
    frmimprel_001.p14.caption:=formatfloat('###,###,###,0.0',(ax2-ax3)*100/ax2)+'%';

    //// Crianças, Adolescentes, Jovens e Adultos  ////////////////////////////////////////////////////////////////////////////////////

    f01:=0; f02:=0; f03:=0; f04:=0;
    with data10.myrel do begin
      close;
      sql.clear;
      x:='select b.faixa from visita a left join amigo b';
      x:=x+' on a.amigo=b.codigo';
      x:=x+' where (';
      x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (a.datamov>='+#39+mydata(datai.text)+#39+')';
      x:=x+' and (a.datamov<='+#39+mydata(dataf.text)+#39+')';
      if opsel='AMIGOS' then begin
        x:=x+' and (a.adventista='+#39+'N'+#39+')';
      end;
      if opsel='ADVENTISTAS' then begin
        x:=x+' and (a.adventista='+#39+'S'+#39+')';
      end;
      x:=x+')';
      x:=x+' group by a.amigo';
      sql.add(x);
      open;
      first;
      while eof=false do begin
          if fieldbyname('faixa').asstring='CRIANÇA' then begin f01:=f01+1; end;
          if fieldbyname('faixa').asstring='ADOLESCENTE' then begin f02:=f02+1; end;
          if fieldbyname('faixa').asstring='JOVEM' then begin f03:=f03+1; end;
          if fieldbyname('faixa').asstring='ADULTO' then begin f04:=f04+1; end;
        next;
      end;
    end;
    frmimprel_001.i17.caption:=formatfloat('###,###,###,0.',f01);
    frmimprel_001.i18.caption:=formatfloat('###,###,###,0.',f02);
    frmimprel_001.i19.caption:=formatfloat('###,###,###,0.',f03);
    frmimprel_001.i20.caption:=formatfloat('###,###,###,0.',f04);
    frmimprel_001.p15.caption:=formatfloat('###,###,###,0.0',f01*100/ax1)+'%';
    frmimprel_001.p16.caption:=formatfloat('###,###,###,0.0',f02*100/ax1)+'%';
    frmimprel_001.p17.caption:=formatfloat('###,###,###,0.0',f03*100/ax1)+'%';
    frmimprel_001.p18.caption:=formatfloat('###,###,###,0.0',f04*100/ax1)+'%';

    ////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////


    frmimprel_001.titulo.Caption:='Relatório de Visitantes';
    frmimprel_001.empresa.Caption:=frmprincipal.Configura[4];
    frmimprel_001.periodo.Caption:='Período de '+datai.Text+' à '+dataf.text;

    frmimprel_001.i1.caption:=formatfloat('###,###,###,0.',ax1);
    frmimprel_001.i2.caption:=formatfloat('###,###,###,0.',ax2);

    frmimprel_001.RLReport1.Preview;
    frmimprel_001.free;

  end;

  bitbtn1.Enabled:=true;

end;

procedure Tfrmperiodo.dataiKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmperiodo.MenuItem1Click(Sender: TObject);
var
  i:integer;
begin
 {
  if frmperiodo.tag=1 then begin
    Application.CreateForm(Tfrmlocvend,frmlocvend);
    frmlocvend.showmodal;
    lista02.ItemIndex:=-1;
    for i:=0 to lista02.Items.Count-1 do begin
      if (voltacod(lista02.Items[i],'|',1)=trim(frmlocvend.codcad.text)) then begin
        lista02.ItemIndex:=i;
        break;
      end;
    end;
    frmlocvend.Free;
  end;
  }
end;

end.
