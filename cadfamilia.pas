unit cadfamilia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal ;

type
  Tfrmcadfamilia = class(TForm)
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
    Label5: TLabel;
    Edit2: TEdit;
    Label7: TLabel;
    Edit5: TEdit;
    Label8: TLabel;
    Edit6: TEdit;
    Label9: TLabel;
    Edit7: TEdit;
    MaskEdit1: TMaskEdit;
    Label6: TLabel;
    MaskEdit2: TMaskEdit;
    Label10: TLabel;
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
  frmcadfamilia: Tfrmcadfamilia;

implementation

uses datamodule10, familia, principal;

{$R *.DFM}

procedure Tfrmcadfamilia.limpar;
begin
  edit1.Text:='0';
  combobox1.ItemIndex:=0;
  edit4.Text:='';
  edit2.Text:='';
  edit5.Text:=frmprincipal.Configura[7];
  maskedit2.Text:='';
  edit6.Text:=frmprincipal.Configura[5];
  edit7.Text:=frmprincipal.Configura[6];
  maskedit1.Text:='';
  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);
end;


procedure Tfrmcadfamilia.mostrar;
var
  i:integer;
begin
  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  edit4.Text:=data10.mymostra.fieldbyname('descricao').asstring;
  edit2.Text:=data10.mymostra.fieldbyname('endereco').asstring;
  edit5.Text:=data10.mymostra.fieldbyname('bairro').asstring;
  edit6.Text:=data10.mymostra.fieldbyname('cidade').asstring;
  edit7.Text:=data10.mymostra.fieldbyname('estado').asstring;
  maskedit1.Text:=data10.mymostra.fieldbyname('telefone').asstring;
  maskedit2.Text:=data10.mymostra.fieldbyname('cep').asstring;

  combobox1.ItemIndex:=-1;
  for i:=0 to combobox1.Items.Count-1 do begin
    if copy(combobox1.Items[i],1,1)=data10.mymostra.fieldbyname('ativo').asstring then begin
      combobox1.ItemIndex:=i;
      break;
    end;
  end;

end;


procedure Tfrmcadfamilia.FormActivate(Sender: TObject);
begin
  if (frmcadfamilia.tag=1) or (frmcadfamilia.tag=3) then begin
    frmcadfamilia.caption:='Inclusão de Família';
    limpar;
    edit4.SetFocus;
  end;
  if frmcadfamilia.tag=2 then begin
    frmcadfamilia.caption:='Alteração de Família';
    limpar;
    mostrar;
    edit4.SetFocus;
  end;
end;

procedure Tfrmcadfamilia.BitBtn2Click(Sender: TObject);
begin
  frmcadfamilia.close;
end;

procedure Tfrmcadfamilia.BitBtn1Click(Sender: TObject);
var
  x:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  if (edit4.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit4.setfocus; end;

  if ((frmcadfamilia.tag=1) or (frmcadfamilia.tag=3)) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO familia ';
      x:=x+'(codigo, ativo, igreja, descricao, endereco, bairro, cep, cidade, estado, telefone, dataid, horaid, id) ';
      x:=x+'VALUES (NULL,';                   // codigo
      x:=x+#39+'S'+#39+',';                   // ativo
      x:=x+#39+frmprincipal.Configura[3]+#39+','; // igreja
      x:=x+#39+edit4.text+#39+',';            // descricao
      x:=x+#39+edit2.text+#39+',';            // endereco
      x:=x+#39+edit5.text+#39+',';            // bairro
      x:=x+#39+maskedit2.text+#39+',';        // cep
      x:=x+#39+edit6.text+#39+',';            // cidade
      x:=x+#39+edit7.text+#39+',';            // estado
      x:=x+#39+maskedit1.text+#39+',';        // telefone
      x:=x+#39+mydata(adataid.text)+#39+',';  // dataid
      x:=x+#39+ahoraid.text+#39+',';          // horaid
      x:=x+#39+frmprincipal.Configura[1]+#39; // id
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    if (frmcadfamilia.tag=1) then begin
      limpar;
      edit4.SetFocus;
    end;
    if (frmcadfamilia.tag=3) then begin
      codcad.text:=voltauc('familia','codigo','descricao='+edit4.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
      frmcadfamilia.close;
    end;
  end;

  if (frmcadfamilia.tag=2) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE familia SET ';
      x:=x+'descricao='+#39+edit4.text+#39+',';           // descricao
      x:=x+'ativo='+#39+copy(combobox1.Text,1,1)+#39+',';    // ativo
      x:=x+'endereco='+#39+edit2.text+#39+',';           // endereco
      x:=x+'bairro='+#39+edit5.text+#39+',';           // bairro
      x:=x+'cep='+#39+maskedit2.text+#39+',';          // cep
      x:=x+'cidade='+#39+edit6.text+#39+',';           // cidade
      x:=x+'estado='+#39+edit7.text+#39+',';           // estado
      x:=x+'telefone='+#39+maskedit1.text+#39;       // telefone
      x:=x+' where codigo='+#39+edit1.text+#39;
      sql.add(x);
      ExecSql;
    end;
    frmcadfamilia.close;
  end;

end;

procedure Tfrmcadfamilia.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadfamilia.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

end.
