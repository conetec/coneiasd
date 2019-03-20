unit abresabado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, funcaolocal, funcoes, JvExForms, JvScrollBox,
  CheckLst, JvExCheckLst, JvCheckListBox, ComCtrls, ExtCtrls, Menus;

type
  Tfrmabresabado = class(TForm)
    Label19: TLabel;
    Edit7: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    otrimestre: TEdit;
    cax1: TComboBox;
    achamada: TEdit;
    lsab: TJvCheckListBox;
    Label2: TLabel;
    Memo1: TMemo;
    barra1: TProgressBar;
    barra2: TProgressBar;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    Estornar1: TMenuItem;
    Sair1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7Enter(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure lsabClickCheck(Sender: TObject);
    procedure Estornar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmabresabado: Tfrmabresabado;
  xdti,xdtf:string;
  osab: array [0..15] of char;

implementation

uses principal, datamodule10, chamadaes;

{$R *.dfm}

function jafeitosab(xdt:string):char;
var
  x:string;
begin
  x:='select codigo from chamada_es ';
  x:=x+' where (';
  x:=x+' (datamov='+#39+mydata(xdt)+#39+')';
  x:=x+' and (igreja='+#39+frmprincipal.Configura[3]+#39+')';
  x:=x+')';
  x:=x+' limit 0,1';
  data10.myfsab.close;
  data10.myfsab.sql.clear;
  data10.myfsab.sql.add(x);
  data10.myfsab.open;
  x:='N';
  if data10.myfsab.recordcount=1 then begin
    x:='S';
  end;
  jafeitosab:=x[1];
end;

procedure Tfrmabresabado.FormShow(Sender: TObject);
var
  x,dtp:string;
  nsab,pos:integer;
begin
  barra1.Position:=0;
  barra2.Position:=0;
  memo1.lines.clear;
  memo1.lines.add('Feliz Sábado!');

  with data10.myaux do begin
    close;
    sql.clear;
    x:='select codigo,descricao from classe where igreja='+#39+frmprincipal.Configura[3]+#39+' and ativo='+#39+'S'+#39+' and codigo>1 order by descricao';
    sql.add(x);
    open;
    first;
    cax1.Clear;
    while eof=false do begin
      cax1.Items.add(fieldbyname('codigo').asstring);
      next;
    end;
    cax1.ItemIndex:=0;
  end;

  x:=voltainfo('trimestre','codigo|descricao|datai|dataf','ativo='+#39+'S'+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T|T|D|D','0');
  if trim(x)='' then begin
    frmabresabado.Close;
  end else begin
    otrimestre.text:=voltacod(x,'|',0);
    edit7.text:=voltacod(x,'|',1);
    xdti:=voltacod(x,'|',2);
    xdtf:=voltacod(x,'|',3);

    nsab:=0;
    lsab.Items.clear;
    dtp:=xdti;
    pos:=0;
    while (strtodate(dtp)<=strtodate(xdtf)) do begin
      if DayOfWeek(strtodate(dtp))=7 then begin
        nsab:=nsab+1;
        osab[nsab-1]:=jafeitosab(dtp);
        lsab.Items.Add(espaco(inttostr(nsab),'0','dir',2)+' '+dtp);
        if (osab[nsab-1]='S') then begin
          panel1.Caption:='Sábado Aberto = '+lsab.Items[nsab-1];
          lsab.Checked[nsab-1]:=true;
          pos:=nsab;
        end;
      end;
      dtp:=formatdatetime('dd/mm/yyyy',strtodate(dtp)+1);
    end;
    lsab.ItemIndex:=pos;
  end;




end;

procedure Tfrmabresabado.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmabresabado.Edit7Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmabresabado.BitBtn2Click(Sender: TObject);
begin
  frmabresabado.close;
end;

procedure Tfrmabresabado.BitBtn1Click(Sender: TObject);
var
  x,xp,nsabado,dtsabado:string;
  a,i:integer;
begin

  a:=0;
  if (a=0) and (lsab.Checked[lsab.itemindex]=true) then begin a:=1; application.MessageBox('Sábado já Aberto','Atenção',mb_ok); lsab.SetFocus; end;
  if (lsab.itemindex>0) then begin
    if (a=0) and (lsab.Checked[lsab.itemindex-1]=false) then begin a:=1; application.MessageBox('Sábado anterior Fechado','Atenção',mb_ok); lsab.SetFocus; end;
  end;
  if (a=0) then begin

    frmprincipal.c_agora;
    bitbtn1.Enabled:=false;
    barra1.Position:=0;
    barra2.Position:=0;
    barra1.Max:=cax1.items.count-1;
    nsabado:=voltacod(lsab.Items[lsab.itemindex],' ',0);
    dtsabado:=voltacod(lsab.Items[lsab.itemindex],' ',1);

    for i:=0 to cax1.items.count-1 do begin
      application.ProcessMessages;
      barra1.Position:=barra1.Position+1;
      xp:='trimestre='+#39+otrimestre.text+#39;
      xp:=xp+' and igreja='+#39+frmprincipal.Configura[3]+#39;
      xp:=xp+' and classe='+#39+cax1.Items[i]+#39;
      xp:=xp+' and datamov='+#39+mydata(dtsabado)+#39;
      data10.exemysql.sql.clear;
      x:='INSERT INTO chamada_es ';
      x:=x+'(codigo, datamov, sabado, classe, recados, trimestre, igreja) ';
      x:=x+'VALUES (NULL,';                                          // codigo
      x:=x+#39+mydata(dtsabado)+#39+',';                             // datamov
      x:=x+#39+nsabado+#39+',';                                      // sabado
      x:=x+#39+cax1.Items[i]+#39+',';                                // classe
      x:=x+#39+trim(memo1.text)+#39+',';                             // recados
      x:=x+#39+otrimestre.text+#39+',';                              // trimestre
      x:=x+#39+frmprincipal.Configura[3]+#39;                        // igreja
      x:=x+')';
      data10.exemysql.sql.add(x);
      data10.exemysql.ExecSql;
      achamada.text:=voltainfo('chamada_es','codigo',xp,'T','0');

      data10.exemysql.sql.clear;
      x:='INSERT INTO chamada_aponta ';
      x:=x+'(codigo, chamada, datamov, sabado, classe, trimestre, igreja) ';
      x:=x+'VALUES (NULL,';                                          // codigo
      x:=x+#39+achamada.Text+#39+',';                                // chamada
      x:=x+#39+mydata(dtsabado)+#39+',';                             // datamov
      x:=x+#39+nsabado+#39+',';                                      // sabado
      x:=x+#39+cax1.Items[i]+#39+',';                                // classe
      x:=x+#39+otrimestre.text+#39+',';                              // trimestre
      x:=x+#39+frmprincipal.Configura[3]+#39;                        // igreja
      x:=x+')';
      data10.exemysql.sql.add(x);
      data10.exemysql.ExecSql;

      x:='select codigo from membro ';
      x:=x+' where (';
      x:=x+' (classe='+#39+cax1.Items[i]+#39+')';
      x:=x+' and (igreja='+#39+frmprincipal.Configura[3]+#39+')';
      x:=x+' and (ativo='+#39+'S'+#39+')';
      x:=x+')';
      data10.myaluno.close;
      data10.myaluno.sql.clear;
      data10.myaluno.sql.add(x);
      data10.myaluno.open;
      data10.myaluno.first;
      barra2.Position:=0;
      barra2.Max:=data10.myaluno.recordcount;
      while data10.myaluno.eof=false do begin
        application.ProcessMessages;
        barra2.Position:=barra2.Position+1;
        data10.exemysql.sql.clear;
        x:='INSERT INTO lista_es ';
        x:=x+'(codigo, dtchama, sabado, aluno, presenca, contato, chamada, classe, trimestre, igreja) ';
        x:=x+'VALUES (NULL,';                                                   // codigo
        x:=x+#39+mydata(dtsabado)+#39+',';                                      // dtchama
        x:=x+#39+nsabado+#39+',';                                               // sabado
        x:=x+#39+data10.myaluno.fieldbyname('codigo').asstring+#39+',';         // aluno
        x:=x+#39+'F'+#39+',';                                                   // presenca
        x:=x+#39+'N'+#39+',';                                                   // contato
        x:=x+#39+achamada.Text+#39+',';                                         // chamada
        x:=x+#39+cax1.Items[i]+#39+',';                                         // classe
        x:=x+#39+otrimestre.text+#39+',';                                       // trimestre
        x:=x+#39+frmprincipal.Configura[3]+#39;                                 // igreja
        x:=x+')';
        data10.exemysql.sql.add(x);
        data10.exemysql.ExecSql;
        data10.myaluno.next;
      end;
    end;
    application.MessageBox('Concluido com Sucesso!','Atenção',mb_ok);
    frmabresabado.close;
  end;
end;

procedure Tfrmabresabado.lsabClickCheck(Sender: TObject);
begin

  if osab[lsab.ItemIndex]='S' then begin
    lsab.Checked[lsab.ItemIndex]:=true;
  end else begin
    lsab.Checked[lsab.ItemIndex]:=false;
  end;
end;

procedure Tfrmabresabado.Estornar1Click(Sender: TObject);
var
  x,xd:string;
begin
  x:='Deseja Estornar Sábado?'+#13+voltacod(lsab.Items[lsab.itemindex],' ',1);
  if application.MessageBox(pchar(x),'Atenção',mb_yesno)<>id_no then begin
    xd:=voltacod(lsab.Items[lsab.itemindex],' ',1);
    with data10.myestornasabado do begin
      close;
      sql.clear;
      sql.add('select codigo from chamada_es where datamov='+#39+mydata(xd)+#39);
      open;
      first;
      while eof=false do begin
        x:='delete from lista_es where chamada='+data10.myestornasabado.fieldbyname('codigo').asstring;
        data10.exemysql.sql.clear;
        data10.exemysql.sql.add(x);
        data10.exemysql.ExecSql;

        x:='delete from chamada_aponta where chamada='+data10.myestornasabado.fieldbyname('codigo').asstring;
        data10.exemysql.sql.clear;
        data10.exemysql.sql.add(x);
        data10.exemysql.ExecSql;

        next;
      end;
    end;

    x:='delete from chamada_es where datamov='+#39+mydata(xd)+#39;
    data10.exemysql.sql.clear;
    data10.exemysql.sql.add(x);
    data10.exemysql.ExecSql;

  end;
end;

end.
