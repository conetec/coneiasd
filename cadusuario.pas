unit cadusuario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, db, funcoes, ComCtrls,
  CheckLst;

type
  Tfrmcadusuario = class(TForm)
    gravar: TBitBtn;
    sair: TBitBtn;
    PageControl1: TPageControl;
    p1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    edit4: TComboBox;
    Label8: TLabel;
    ComboBox4: TComboBox;
    Label13: TLabel;
    Edit5: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure sairClick(Sender: TObject);
    procedure gravarClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadusuario: Tfrmcadusuario;
  ultnome:string;

implementation

uses usuario, datamodule10 , principal;

{$R *.DFM}

procedure limpar;
var
  i:integer;
begin
  with frmcadusuario do begin
    edit1.Text:='';
    edit2.Text:='';
    edit3.Text:='';
    edit5.Text:='';
    edit4.itemindex:=0;
    combobox4.itemindex:=0;
  end;
end;


procedure mostrar;
var
  pos,i,k:integer;
  x,vproc:string;
begin
  with frmcadusuario do begin
    edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
    edit2.Text:=data10.mymostra.fieldbyname('nome').asstring;
    edit3.Text:=data10.mymostra.fieldbyname('senha').asstring;
    edit5.Text:=edit3.Text;

    edit4.Text:=data10.mymostra.fieldbyname('nivel').asstring;

    vproc:=data10.mymostra.fieldbyname('ativo').asstring;
    if ((trim(vproc)='') or (trim(vproc)='S')) then begin vproc:='SIM'; end else begin vproc:='NÃO'; end;
    combobox4.ItemIndex:=-1;
    for i:=0 to combobox4.Items.Count-1 do begin
      if combobox4.items[i]=vproc then begin
        combobox4.ItemIndex:=i;
        break;
      end;
    end;

    edit4.ItemIndex:=-1;
    for i:=0 to edit4.Items.Count-1 do begin
      if voltacod(edit4.items[i],'|',0)=data10.mymostra.fieldbyname('nivel').asstring then begin
        edit4.ItemIndex:=i;
        break;
      end;
    end;

  end;
end;

procedure Tfrmcadusuario.FormActivate(Sender: TObject);
begin
  p1.Show;
  ultnome:='';
  if frmcadusuario.tag=1 then begin
    frmcadusuario.caption:='Inclusão de Usuário';
    limpar();
    edit1.text:='0';
    edit2.SetFocus;
  end;
  if frmcadusuario.tag=2 then begin
    frmcadusuario.caption:='Alteração de Usuário';
    ultnome:=data10.mymostra.fieldbyname('nome').asstring;
    mostrar();
    edit2.SetFocus;
  end;
end;

procedure Tfrmcadusuario.sairClick(Sender: TObject);
begin
  frmcadusuario.close;
end;

procedure Tfrmcadusuario.gravarClick(Sender: TObject);
var
  x,ae,vproc:string;
  i,a:integer;
begin
  a:=0;
  if ((a=0) and (edit2.text='')) then begin application.MessageBox('Campo Obrigatório.','Atenção!',mb_ok); a:=1; p1.show; edit2.setfocus; end;
  if ((a=0) and (edit3.text<>edit5.Text)) then begin application.MessageBox('Senhas não conferem.','Atenção!',mb_ok); a:=1; p1.show; edit3.setfocus; end;

  if (a=0) then begin

    if ((trim(combobox4.text)='SIM')) then begin vproc:='S'; end else begin vproc:='N'; end;
    if trim(edit1.text)='1' then begin vproc:='S'; end;

    ultnome:=edit2.Text;
    if frmcadusuario.Tag=1 then begin
      x:='INSERT INTO nupass (Codigo, igreja, ativo, Nome, Senha, Nivel ) VALUES (NULL, ';
      x:=x+#39+frmprincipal.Configura[3]+#39+','; // igreja
      x:=x+#39+vproc+#39+','; // ativo
      x:=x+#39+edit2.text+#39+','; // nome
      x:=x+#39+edit3.text+#39+','; // senha
      x:=x+#39+voltacod(edit4.text,'|',0)+#39; // nivel
      x:=x+')';
    end;
    if frmcadusuario.Tag=2 then begin
      x:='UPDATE nupass SET';
      x:=x+' Nome='+#39+edit2.text+#39+',';
      x:=x+' ativo='+#39+vproc+#39+','; // ativo
      x:=x+' Senha='+#39+edit3.text+#39+',';
      x:=x+' Nivel='+#39+voltacod(edit4.text,'|',0)+#39;
      x:=x+' WHERE Codigo='+edit1.text;
    end;
    with data10.exemysql do begin
      sql.clear;
      sql.add(x);
      ExecSql;
    end;
    frmcadusuario.close;
  end;
end;

procedure Tfrmcadusuario.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

end.
