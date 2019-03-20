unit classe10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, OleCtrls, SKYPE4COMLib_TLB, Grids, DBGrids, funcoes, funcaolocal,
  ExtCtrls;

type
  Tfrmclasse10 = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    amensagem: TMemo;
    Label2: TLabel;
    cbsabado: TComboBox;
    RadioGroup1: TRadioGroup;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    BitBtn3: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmclasse10: Tfrmclasse10;

implementation

uses skype, datamodule10, principal;

{$R *.dfm}

procedure Tfrmclasse10.FormShow(Sender: TObject);
var
  x,xdti,xdtf,dtp:string;
  nsab:integer;
begin
  memo1.Lines.clear;
  try
    if (frmskype.Skype1.Client.IsRunning=false) then begin
      frmskype.Skype1.Client.Start(false, false);
    end;
    frmskype.Skype1.Attach(5, false);
  Except
  end;
  with data10.myclasse do begin
    close;
    sql.clear;
    sql.add('select a.codigo,a.numero,a.descricao,a.celular from classe a where (a.ativo='+#39+'S'+#39+' and a.departamento='+#39+'ADULTO'+#39+') order by a.numero');
    open;
    first;
  end;

  x:=voltainfo('trimestre','codigo|descricao|datai|dataf','ativo='+#39+'S'+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T|T|D|D','0');
  xdti:=voltacod(x,'|',2);
  xdtf:=voltacod(x,'|',3);

    nsab:=0;
    cbsabado.items.clear;
    dtp:=xdti;
    while (strtodate(dtp)<=strtodate(xdtf)) do begin
      if DayOfWeek(strtodate(dtp))=7 then begin
        nsab:=nsab+1;
        cbsabado.Items.Add(espaco(inttostr(nsab),'0','dir',2)+' '+dtp);
      end;
      dtp:=formatdatetime('dd/mm/yyyy',strtodate(dtp)+1);
    end;
    cbsabado.ItemIndex:=0;


end;

procedure Tfrmclasse10.BitBtn1Click(Sender: TObject);
begin
//  frmskype.Skype1.SendSms('+554591454555', 'oi Teste rsss', '');
end;

procedure Tfrmclasse10.BitBtn2Click(Sender: TObject);
var
  x,x1:string;
  a:integer;
begin
  amensagem.Clear;
      bitbtn2.Enabled:=false;
      data10.myclasse.first;
    while data10.myclasse.eof=false do begin
      data10.myalunos.Close;
      data10.myalunos.SQL.Clear;
      x:='select a.presenca,b.nome,b.celular,c.telefone';
      x:=x+' from lista_es a left join membro b on a.aluno=b.codigo left join familia c on b.familia=c.codigo';
      x:=x+' where (';
      x:=x+' (a.dtchama='+#39+mydata(voltacod(cbsabado.Text,' ',1))+#39+')';
      x:=x+' and (a.classe='+#39+data10.myclasse.fieldbyname('codigo').asstring+#39+')';
      x:=x+' and (a.presenca='+#39+'F'+#39+')';
      x:=x+')';
      x:=x+' order by b.nome';
      data10.myalunos.SQL.Add(x);
      data10.myalunos.Open;
      x:='Professor '+pmaiusculo(trim(data10.myclasse.fieldbyname('descricao').asstring))+', Sáb. '+copy(voltacod(cbsabado.Text,' ',1),1,5)+' Faltaram '+inttostr(data10.myalunos.RecordCount)+' Alunos: ';
      data10.myalunos.First;

      while data10.myalunos.eof=false do begin
        a:=0;
        x:=x+voltacod(data10.myalunos.fieldbyname('nome').asstring,' ',0);
        x1:=' (';
        if length(sonumero(data10.myalunos.fieldbyname('celular').asstring))>0 then begin
          x1:=x1+voltacod(data10.myalunos.fieldbyname('celular').asstring,')',1);
          a:=a+1;
        end;
        if length(sonumero(data10.myalunos.fieldbyname('telefone').asstring))>0 then begin
          if (a>0) then begin x1:=x1+' - '; end;
          x1:=x1+voltacod(data10.myalunos.fieldbyname('telefone').asstring,')',1);
          a:=a+1;
        end;
        x1:=x1+'), ';
        if a>0 then begin
          x:=x+x1;
        end else begin
          x:=x+', ';
        end;
        data10.myalunos.next;
      end;
      memo1.lines.Add(x);
      memo1.lines.Add('  ');
      memo1.lines.Add('  ');

{      if (trim(data10.myclasse.FieldByName('celular').asstring)<>'') then begin
        frmskype.Skype1.SendSms(trim(data10.myclasse.FieldByName('celular').asstring),x,'');
      end else begin
        frmclasse10.bitbtn2.Enabled:=true;
        data10.myclasse.next;
      end;
      }
        frmclasse10.bitbtn2.Enabled:=true;
        data10.myclasse.next;
      end;

end;

procedure Tfrmclasse10.BitBtn3Click(Sender: TObject);
var
  x,x1:string;
  a,nat:integer;
begin
  bitbtn2.Enabled:=false;
  data10.myclasse.first;
  while data10.myclasse.eof=false do begin

    data10.myalunos.Close;
    data10.myalunos.SQL.Clear;
    x:='select count(a.presenca) as nalunos';
    x:=x+' from lista_es a';
    x:=x+' where (';
    x:=x+' (a.dtchama='+#39+mydata(voltacod(cbsabado.Text,' ',1))+#39+')';
    x:=x+' and (a.classe='+#39+data10.myclasse.fieldbyname('codigo').asstring+#39+')';
    x:=x+')';
    data10.myalunos.SQL.Add(x);
    data10.myalunos.Open;
    data10.myalunos.First;
    nat:=0;
    while data10.myalunos.eof=false do begin
      if trim(data10.myalunos.fieldbyname('nalunos').asstring)<>'' then begin
        nat:=nat+data10.myalunos.fieldbyname('nalunos').value;
      end;
      data10.myalunos.next;
    end;


    data10.myalunos.Close;
    data10.myalunos.SQL.Clear;
    x:='select count(a.presenca) as nalunos';
    x:=x+' from lista_es a';
    x:=x+' where (';
    x:=x+' (a.dtchama='+#39+mydata(voltacod(cbsabado.Text,' ',1))+#39+')';
    x:=x+' and (a.classe='+#39+data10.myclasse.fieldbyname('codigo').asstring+#39+')';
    x:=x+' and (a.presenca='+#39+'P'+#39+')';
    x:=x+')';
    data10.myalunos.SQL.Add(x);
    data10.myalunos.Open;
    data10.myalunos.First;
    a:=0;
    while data10.myalunos.eof=false do begin
      if trim(data10.myalunos.fieldbyname('nalunos').asstring)<>'' then begin
        a:=a+data10.myalunos.fieldbyname('nalunos').value;
      end;
      data10.myalunos.next;
    end;
    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE chamada_aponta SET ';
      x:=x+'p01='+#39+inttostr(a)+#39+',';
      x:=x+'numalunos='+#39+inttostr(nat)+#39;
      x:=x+' where classe='+#39+data10.myclasse.fieldbyname('codigo').asstring+#39+' and datamov='+#39+mydata(voltacod(cbsabado.Text,' ',1))+#39;
      sql.add(x);
      ExecSql;
    end;

    data10.myclasse.next;
  end;
  frmclasse10.bitbtn2.Enabled:=true;

end;

end.
