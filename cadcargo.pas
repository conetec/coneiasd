unit cadcargo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal ;

type
  Tfrmcadcargo = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit4: TEdit;
    codcad: TEdit;
    adataID: TEdit;
    ahoraID: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label11: TLabel;
    Label12: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure limpar;
    procedure mostrar;
    procedure Edit1Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadcargo: Tfrmcadcargo;

implementation

uses datamodule10, principal;

{$R *.DFM}

procedure Tfrmcadcargo.limpar;
begin
  edit1.Text:='0';
  combobox1.ItemIndex:=0;
  edit4.Text:='';
  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);
end;


procedure Tfrmcadcargo.mostrar;
var
  i:integer;
begin
  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  edit4.Text:=data10.mymostra.fieldbyname('descricao').asstring;

  combobox1.ItemIndex:=-1;
  for i:=0 to combobox1.Items.Count-1 do begin
    if copy(combobox1.Items[i],1,1)=data10.mymostra.fieldbyname('ativo').asstring then begin
      combobox1.ItemIndex:=i;
      break;
    end;
  end;

end;


procedure Tfrmcadcargo.FormActivate(Sender: TObject);
begin
  if (frmcadcargo.tag=1) or (frmcadcargo.tag=3) then begin
    frmcadcargo.caption:='Inclus�o de Cargo/Fun��o';
    limpar;
    edit4.SetFocus;
  end;
  if frmcadcargo.tag=2 then begin
    frmcadcargo.caption:='Altera��o de Cargo/Fun��o';
    limpar;
    mostrar;
    edit4.SetFocus;
  end;
end;

procedure Tfrmcadcargo.BitBtn2Click(Sender: TObject);
begin
  frmcadcargo.close;
end;

procedure Tfrmcadcargo.BitBtn1Click(Sender: TObject);
var
  x:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  if (edit4.text='') and (a=0) then begin application.MessageBox('Campo Obrigat�rio','Aten��o',mb_ok); a:=1; edit4.setfocus; end;

  if ((frmcadcargo.tag=1) or (frmcadcargo.tag=3)) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO cargo ';
      x:=x+'(codigo, ativo, igreja, descricao, dataid, horaid, id) ';
      x:=x+'VALUES (NULL,';                   // codigo
      x:=x+#39+'S'+#39+',';                   // ativo
      x:=x+#39+frmprincipal.Configura[3]+#39+','; // igreja
      x:=x+#39+edit4.text+#39+',';            // descricao
      x:=x+#39+mydata(adataid.text)+#39+',';  // dataid
      x:=x+#39+ahoraid.text+#39+',';          // horaid
      x:=x+#39+frmprincipal.Configura[1]+#39; // id
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    if (frmcadcargo.tag=1) then begin
      limpar;
      edit4.SetFocus;
    end;
    if (frmcadcargo.tag=3) then begin
      codcad.text:=voltauc('cargo','codigo','descricao='+edit4.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
      frmcadcargo.close;
    end;
  end;

  if (frmcadcargo.tag=2) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE cargo SET ';
      x:=x+'descricao='+#39+edit4.text+#39+',';           // descricao
      x:=x+'ativo='+#39+copy(combobox1.Text,1,1)+#39;     // ativo
      x:=x+' where codigo='+#39+edit1.text+#39;
      sql.add(x);
      ExecSql;
    end;
    frmcadcargo.close;
  end;

end;

procedure Tfrmcadcargo.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadcargo.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

end.
