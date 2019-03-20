unit funcaolocal;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ZDataset, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable ,
  Dialogs, registry, Urlmon, clipbrd, WIninet, WinSock, Jpeg, StdCtrls, Tlhelp32,
  printers, datamodule10, funcoes, principal;

  function voltainfo(nbanco,ncampo,procura,nt,casas:string):string;
  function voltauc(nbanco,ncampo,valor01,adataid,ahoraid,aid:string):string;

var
  lt_mov: array of String;

implementation

function voltainfo(nbanco,ncampo,procura,nt,casas:string):string;
var
  t_w,t_ax,t_zero,jw,jw1,agf:string;
  j_w,cta:integer;
begin
  {nt = Numero ou Texto e casas decimais}
  ncampo:=StringReplace(ncampo,'|',',',[rfReplaceAll,rfIgnoreCase]);
  nt:=tmaiusculo(nt);
  t_ax:='';
  with data10.myinfo do begin
    close;
    sql.clear;
    t_w:='select '+ncampo+' from '+nbanco+' where ('+procura+') limit 0,1';
    sql.add(t_w);
    open;
    if recordcount=1 then begin
      t_zero:='###,###,###,###,###,0.'+trim(espaco('','0','dir',strtoint(casas)));
      t_ax:='';

      for j_w:=0 to 10 do begin
        jw:=voltacod(ncampo,',',j_w);

        if jw<>'' then begin
          jw1:=voltacod(nt,'|',j_w);
          if jw1='N' then begin
            t_ax:=t_ax+formatfloat(t_zero,fieldbyname(jw).value);
          end;
          if jw1='T' then begin
            agf:=fieldbyname(jw).asstring;
            t_ax:=t_ax+agf;
          end;
          if jw1='D' then begin
            if fieldbyname(jw).asstring<>'' then begin
              agf:=fieldbyname(jw).value;
              t_ax:=t_ax+agf;
            end else begin
              t_ax:=t_ax+'00-00-0000';
            end;
          end;
          t_ax:=t_ax+'|';
        end;
      end;
      t_ax:=copy(t_ax,1,length(t_ax)-1);
    end;
  end;
  voltainfo:=trim(t_ax);
end;


function voltauc(nbanco,ncampo,valor01,adataid,ahoraid,aid:string):string;
var
  codcad,x:string;
  tenta:integer;
begin
  codcad:='';
  tenta:=0;
  while codcad='' do begin
    tenta:=tenta+1;
    if tenta>30 then begin
      tenta:=0;
      x:='Falha de Conexão com o Servidor'+#13;
      x:=x+'O código não pode ser localizado'+#13;
      x:=x+'Banco: '+nbanco+#13;
      x:=x+'Se o problema persistir comunique a Conetec';
      application.MessageBox(pchar(x),'Atenção!!!',mb_ok);
      break;
    end;
    with data10.myucodigo do begin
      close;
      sql.clear;
      x:='select '+ncampo+' from '+nbanco;
      x:=x+' where(';
      x:=x+'('+voltacod(valor01,'=',0)+'='+#39+voltacod(valor01,'=',1)+#39+')';
      x:=x+' and (id='+#39+aid+#39+')';
      x:=x+' and (dataid='+#39+mydata(adataid)+#39+')';
      x:=x+' and (horaid='+#39+ahoraid+#39+')';
      x:=x+')';
      x:=x+' order by codigo DESC LIMIT 0,1';
      sql.add(x);
      open;
      if recordcount=1 then begin
        codcad:=fieldbyname(ncampo).asstring;
      end;
    end;
  end;
  voltauc:=codcad;
end;



end.
