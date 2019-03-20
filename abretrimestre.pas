unit abretrimestre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, funcoes, funcaolocal, Buttons, Mask, JvExMask,
  JvToolEdit, ComCtrls;

type
  Tfrmabretrimestre = class(TForm)
    GroupBox1: TGroupBox;
    i1: TLabel;
    i2: TLabel;
    i3: TLabel;
    i4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    datai: TJvDateEdit;
    Label3: TLabel;
    dataf: TJvDateEdit;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmabretrimestre: Tfrmabretrimestre;

implementation

uses principal, datamodule10;

{$R *.dfm}

procedure Tfrmabretrimestre.FormShow(Sender: TObject);
var
  x,dtp:string;
  nsab,osdias:integer;
begin
  x:=voltainfo('trimestre','codigo|descricao|datai|dataf','ativo='+#39+'S'+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T|T|D|D','0');
  if trim(x)='' then begin
    frmabretrimestre.Close;
  end else begin
    i1.Caption:='Código    = '+voltacod(x,'|',0);
    i2.Caption:='Descrição = '+voltacod(x,'|',1);
    i3.Caption:='Início    = '+voltacod(x,'|',2);
    i4.Caption:='Término   = '+voltacod(x,'|',3);
    nsab:=1;
    datai.Text:=formatdatetime('dd/mm/yyyy',strtodate(voltacod(x,'|',3))+1);
    osdias:=0;
    while (nsab<14) do begin
      osdias:=osdias+1;
      dtp:=formatdatetime('dd/mm/yyyy',strtodate(datai.Text)+osdias);
      if DayOfWeek(strtodate(dtp))=7 then begin
        nsab:=nsab+1;
      end;
    end;
    dataf.Text:=formatdatetime('dd/mm/yyyy',strtodate(dtp)-1);
    edit1.Text:='0 TRIMESTRE DE '+formatdatetime('yyyy',date);

  end;
end;

procedure Tfrmabretrimestre.BitBtn2Click(Sender: TObject);
begin
  frmabretrimestre.close;
end;

procedure Tfrmabretrimestre.BitBtn1Click(Sender: TObject);
var
  x,xp,cdtrimestre:string;
  a,i:integer;
begin
  a:=0;
  if (a=0) and (trim(edit1.text)='') then begin a:=1; application.MessageBox('Campo Obrigatório','Atenção',mb_ok); edit1.SetFocus;  end;
  if (a=0) and (application.MessageBox('Deseja Abrir Novo Trimestre?','Atenção',mb_yesno)=id_no) then begin a:=1; end;

  if (a=0) then begin
    frmprincipal.c_agora;
    bitbtn1.Enabled:=false;

    with data10.myaux do begin
      close;
      sql.clear;
      sql.add('select * from igreja where codigo='+#39+frmprincipal.Configura[3]+#39+' limit 0,1');
      open;
    end;


    data10.exemysql.sql.clear;
    x:='UPDATE trimestre SET ';
    x:=x+'ativo='+#39+'N'+#39;                                            // ativo
    x:=x+' where codigo='+#39+voltacod(i1.Caption,'=',1)+#39;
    data10.exemysql.sql.add(x);
    data10.exemysql.ExecSql;

    data10.exemysql.sql.clear;
    x:='INSERT INTO trimestre ';
    x:=x+'(codigo, ativo, datai, dataf, descricao, pergunta01,pergunta02,pergunta03,pergunta04,pergunta05,pergunta06,pergunta07,foco01,foco02,foco03,foco04,foco05,foco06,igreja) ';
    x:=x+'VALUES (NULL,';                                                     // codigo
    x:=x+#39+'S'+#39+',';                                                     // ativo
    x:=x+#39+mydata(datai.Text)+#39+',';                                      // datai
    x:=x+#39+mydata(dataf.Text)+#39+',';                                      // dataf
    x:=x+#39+trim(edit1.Text)+#39+',';                                        // descricao
    x:=x+#39+trim(data10.myaux.fieldbyname('esp01').asstring)+#39+',';        // pergunta01
    x:=x+#39+trim(data10.myaux.fieldbyname('esp02').asstring)+#39+',';        // pergunta02
    x:=x+#39+trim(data10.myaux.fieldbyname('esp03').asstring)+#39+',';        // pergunta03
    x:=x+#39+trim(data10.myaux.fieldbyname('esp04').asstring)+#39+',';        // pergunta04
    x:=x+#39+trim(data10.myaux.fieldbyname('esp05').asstring)+#39+',';        // pergunta05
    x:=x+#39+trim(data10.myaux.fieldbyname('esp06').asstring)+#39+',';        // pergunta06
    x:=x+#39+trim(data10.myaux.fieldbyname('esp07').asstring)+#39+',';        // pergunta07
    x:=x+#39+trim(data10.myaux.fieldbyname('foco01').asstring)+#39+',';       // foco01
    x:=x+#39+trim(data10.myaux.fieldbyname('foco02').asstring)+#39+',';       // foco02
    x:=x+#39+trim(data10.myaux.fieldbyname('foco03').asstring)+#39+',';       // foco03
    x:=x+#39+trim(data10.myaux.fieldbyname('foco04').asstring)+#39+',';       // foco04
    x:=x+#39+trim(data10.myaux.fieldbyname('foco05').asstring)+#39+',';       // foco05
    x:=x+#39+trim(data10.myaux.fieldbyname('foco06').asstring)+#39+',';       // foco06
    x:=x+#39+frmprincipal.Configura[3]+#39;                          // igreja
    x:=x+')';
    data10.exemysql.sql.add(x);
    data10.exemysql.ExecSql;
    cdtrimestre:='0';

    with data10.myaux do begin
      close;
      sql.clear;
      sql.add('select codigo from trimestre where ativo='+#39+'S'+#39+' limit 0,1');
      open;
      if recordcount=1 then begin
        cdtrimestre:=fieldbyname('codigo').asstring;
      end;
    end;

    with data10.myaux do begin
      close;
      sql.clear;
      sql.add('select codigo from classe where ativo='+#39+'S'+#39+' and departamento='+#39+'ADULTO'+#39+' order by numero');
      open;
      first;
      while eof=false do begin

        data10.exemysql.sql.clear;
        x:='INSERT INTO trimestre_objetivo ';
        x:=x+'(codigo, classe, trimestre, igreja) ';
        x:=x+'VALUES (NULL,';                                                     // codigo
        x:=x+#39+fieldbyname('codigo').asstring+#39+',';                          // classe
        x:=x+#39+cdtrimestre+#39+',';                                             // trimestre
        x:=x+#39+frmprincipal.Configura[3]+#39;                                   // igreja
        x:=x+')';
        data10.exemysql.sql.add(x);
        data10.exemysql.ExecSql;
        next;
      end;
    end;



    application.MessageBox('Concluido com Sucesso!','Atenção',mb_ok);
    frmabretrimestre.close;
  end;
end;

end.
