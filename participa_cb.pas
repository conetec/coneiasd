unit participa_cb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, funcoes, funcaolocal;

type
  Tfrmparticipa_cb = class(TForm)
    excluir: TBitBtn;
    sair: TBitBtn;
    incluir: TBitBtn;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    procedure sairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure incluirClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure excluirClick(Sender: TObject);
    procedure marca_pg(wtipo,wcodigo:string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmparticipa_cb: Tfrmparticipa_cb;

implementation

uses principal, datamodule10, locmembro, locamigo;

{$R *.dfm}

procedure Tfrmparticipa_cb.sairClick(Sender: TObject);
begin
  frmparticipa_cb.Close;
end;

procedure Tfrmparticipa_cb.FormShow(Sender: TObject);
var
  x:string;
begin
  frmprincipal.c_agora;
  with data10.mypg do begin
    close;
    sql.clear;
    x:='select a.codigo,a.codtipo,a.tipo,';
    x:=x+'if(a.tipo='+#39+'M'+#39+','+#39+'Membro'+#39+','+#39+'Amigo'+#39+') as otipo,';
    x:=x+'if(a.tipo='+#39+'M'+#39+',b.nome,c.nome) as onome';
    x:=x+' from participa_cb a left join membro b on a.codtipo=b.codigo left join amigo c on a.codtipo=c.codigo';
    x:=x+' where (';
    x:=x+'(a.classebiblica='+#39+edit1.Text+#39+')';
    x:=x+')';
    x:=x+' order by otipo,onome';
    sql.add(x);
    open;
  end;
  frmparticipa_cb.Caption:='Membros da Classe Bíblica = '+inttostr(data10.mypg.recordcount);
end;

procedure Tfrmparticipa_cb.incluirClick(Sender: TObject);
var
  omb,x,onome:string;
begin
  frmprincipal.c_agora;
  application.CreateForm(Tfrmlocmembro, frmlocmembro);
  frmlocmembro.showmodal;
  omb:=frmlocmembro.ocod.text;
  frmlocmembro.Free;
  onome:=voltainfo('membro','nome','codigo='+#39+omb+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
  if (trim(onome)<>'') then begin
    onome:='Deseja Incluir o membro:'+#13+onome+#13+'na Classe Bíblica?';
    if application.MessageBox(pchar(onome),'Atenção',mb_yesno)<>id_no then begin

      with data10.exemysql do begin
        sql.clear;
        x:='INSERT INTO participa_cb ';
        x:=x+'(codigo, classebiblica, tipo, codtipo) ';
        x:=x+'VALUES (NULL,';                           // codigo
        x:=x+#39+edit1.text+#39+',';                    // classebiblica
        x:=x+#39+'M'+#39+',';                           // tipo
        x:=x+#39+omb+#39;                               // codtipo
        x:=x+')';
        sql.add(x);
        ExecSql;
      end;

      data10.mypg.Refresh;

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE classebiblica SET ';
        x:=x+'numpessoas='+#39+inttostr(data10.mypg.recordcount)+#39;                                  // pg
        x:=x+' where codigo='+#39+edit1.Text+#39;
        sql.add(x);
        ExecSql;
      end;

      frmparticipa_cb.Caption:='Membros da Classe Bíblica = '+inttostr(data10.mypg.recordcount);

    end;
  end;

end;

procedure Tfrmparticipa_cb.BitBtn1Click(Sender: TObject);
var
  omb,x,onome:string;
begin
  frmprincipal.c_agora;
  application.CreateForm(Tfrmlocamigo, frmlocamigo);
  frmlocamigo.showmodal;
  omb:=frmlocamigo.ocod.text;
  frmlocamigo.Free;
  onome:=voltainfo('amigo','nome','codigo='+#39+omb+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
  if (trim(onome)<>'') then begin
    onome:='Deseja Incluir o Amigo:'+#13+onome+#13+'na Classe Bíblica?';
    if application.MessageBox(pchar(onome),'Atenção',mb_yesno)<>id_no then begin

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE amigo SET ';
        x:=x+'classe='+#39+'S'+#39;                                  // pg
        x:=x+' where codigo='+#39+omb+#39;
        sql.add(x);
        ExecSql;
      end;

      with data10.exemysql do begin
        sql.clear;
        x:='INSERT INTO participa_cb ';
        x:=x+'(codigo, classebiblica, tipo, codtipo) ';
        x:=x+'VALUES (NULL,';                           // codigo
        x:=x+#39+edit1.text+#39+',';                    // classebiblica
        x:=x+#39+'A'+#39+',';                           // tipo
        x:=x+#39+omb+#39;                               // codtipo
        x:=x+')';
        sql.add(x);
        ExecSql;
      end;

      data10.mypg.Refresh;

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE classebiblica SET ';
        x:=x+'numpessoas='+#39+inttostr(data10.mypg.recordcount)+#39;                                  // pg
        x:=x+' where codigo='+#39+edit1.Text+#39;
        sql.add(x);
        ExecSql;
      end;

      frmparticipa_cb.Caption:='Membros da Classe Bíblica = '+inttostr(data10.mypg.recordcount);

    end;
  end;

end;


procedure Tfrmparticipa_cb.marca_pg(wtipo,wcodigo:string);
var
  w,wa,wb:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  w:='select codigo from participa_cb where tipo='+#39+wtipo+#39+' and codtipo='+#39+wcodigo+#39+' limit 0,1';
  data10.mypgax.close;
  data10.mypgax.sql.clear;
  data10.mypgax.sql.add(w);
  data10.mypgax.open;
  if data10.mypgax.recordcount=1 then begin
    a:=1;
  end;
  if (wtipo='A') then begin
    wb:='amigo';
    if (a=0) then begin wa:='N'; end else begin wa:='S'; end;

    with data10.exemysql do begin
      sql.clear;
      w:='UPDATE '+wb+' SET ';
      w:=w+'pg='+#39+wa+#39;                                  // pg
      w:=w+' where codigo='+#39+wcodigo+#39;
      sql.add(w);
      ExecSql;
    end;
  end;

end;

procedure Tfrmparticipa_cb.excluirClick(Sender: TObject);
var
  x,cod,xtp,xcdtp:string;
begin

  if data10.mypg.RecordCount>0 then begin
    x:='Deseja Excluir o Membro da Classe Bíblica?'+#13+data10.mypg.fieldbyname('onome').asstring;
    if (application.MessageBox(pchar(x),'Atenção',mb_yesno)<>id_no) then begin
      excluir.Enabled:=false;
      cod:=data10.mypg.fieldbyname('codigo').asstring;
      xtp:=data10.mypg.fieldbyname('tipo').asstring;
      xcdtp:=data10.mypg.fieldbyname('codtipo').asstring;

      x:='delete from participa_cb where codigo='+#39+cod+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      data10.mypg.Refresh;

      marca_pg(xtp,xcdtp);

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE classebiblica SET ';
        x:=x+'numpessoas='+#39+inttostr(data10.mypg.recordcount)+#39;                                  // pg
        x:=x+' where codigo='+#39+edit1.Text+#39;
        sql.add(x);
        ExecSql;
      end;

      frmparticipa_cb.Caption:='Membros da Classe Bíblica = '+inttostr(data10.mypg.recordcount);
      excluir.Enabled:=true;
    end;
  end;
end;

end.
