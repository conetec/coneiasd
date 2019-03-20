unit participa_classe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, funcoes, funcaolocal;

type
  Tfrmparticipa_classe = class(TForm)
    excluir: TBitBtn;
    sair: TBitBtn;
    incluir: TBitBtn;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure sairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure incluirClick(Sender: TObject);
    procedure excluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmparticipa_classe: Tfrmparticipa_classe;

implementation

uses principal, datamodule10, locmembro, locamigo;

{$R *.dfm}

procedure Tfrmparticipa_classe.sairClick(Sender: TObject);
begin
  frmparticipa_classe.Close;
end;

procedure Tfrmparticipa_classe.FormShow(Sender: TObject);
var
  x:string;
begin
  frmprincipal.c_agora;
  with data10.mypg do begin
    close;
    sql.clear;
    x:='select a.codigo,a.nome,a.batizado,a.email,a.celular,a.familia,a.ativo,a.dataatualizacao';
    x:=x+' from membro a';
    x:=x+' where (';
    x:=x+'(a.classe='+#39+edit1.Text+#39+')';
    x:=x+')';
    x:=x+' order by a.nome';
    sql.add(x);
    open;
  end;
  frmparticipa_classe.Caption:='Membros da Classe ES '+trim(edit2.text)+' = '+inttostr(data10.mypg.recordcount);
end;

procedure Tfrmparticipa_classe.incluirClick(Sender: TObject);
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
    onome:='Deseja Incluir o membro:'+#13+onome+#13+'na Classe da ES?';
    if application.MessageBox(pchar(onome),'Atenção',mb_yesno)<>id_no then begin

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE membro SET ';
        x:=x+'classe='+#39+edit1.text+#39;                                  // classe
        x:=x+' where codigo='+#39+omb+#39;
        sql.add(x);
        ExecSql;
      end;

      data10.mypg.Refresh;

      frmparticipa_classe.Caption:='Membros da Classe ES '+trim(edit2.text)+' = '+inttostr(data10.mypg.recordcount);

    end;
  end;

end;

procedure Tfrmparticipa_classe.excluirClick(Sender: TObject);
var
  x,cod,xtp,xcdtp:string;
begin
  frmprincipal.c_agora;
  if data10.mypg.RecordCount>0 then begin
    x:='Deseja Excluir o Membro da Classe da ES?'+#13+data10.mypg.fieldbyname('nome').asstring;
    if (application.MessageBox(pchar(x),'Atenção',mb_yesno)<>id_no) then begin
      excluir.Enabled:=false;
      cod:=data10.mypg.fieldbyname('codigo').asstring;

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE membro SET ';
        x:=x+'classe='+#39+'1'+#39;                                  // classe
        x:=x+' where codigo='+#39+cod+#39;
        sql.add(x);
        ExecSql;
      end;
      data10.mypg.Refresh;

      frmparticipa_classe.Caption:='Membros da Classe ES '+trim(edit2.text)+' = '+inttostr(data10.mypg.recordcount);
      excluir.Enabled:=true;
    end;
  end;
end;

end.
