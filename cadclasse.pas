unit cadclasse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, JvExMask,
  JvToolEdit ;

type
  Tfrmcadclasse = class(TForm)
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
    datacad: TJvDateEdit;
    Label5: TLabel;
    Label6: TLabel;
    Edit2: TEdit;
    Label7: TLabel;
    Edit3: TEdit;
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
  frmcadclasse: Tfrmcadclasse;

implementation

uses datamodule10, principal;

{$R *.DFM}

procedure Tfrmcadclasse.limpar;
begin
  edit1.Text:='0';
  combobox1.ItemIndex:=0;
  datacad.Text:=formatdatetime('dd/mm/yyyy',date);
  edit2.Text:='';
  edit3.Text:='';
  edit4.Text:='';
  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);
end;


procedure Tfrmcadclasse.mostrar;
var
  i:integer;
begin
  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  edit4.Text:=data10.mymostra.fieldbyname('descricao').asstring;
  datacad.Text:=data10.mymostra.fieldbyname('datacad').asstring;
  edit2.Text:=data10.mymostra.fieldbyname('numero').asstring;
  edit3.Text:=data10.mymostra.fieldbyname('senhaacesso').asstring;

  combobox1.ItemIndex:=-1;
  for i:=0 to combobox1.Items.Count-1 do begin
    if copy(combobox1.Items[i],1,1)=data10.mymostra.fieldbyname('ativo').asstring then begin
      combobox1.ItemIndex:=i;
      break;
    end;
  end;

end;


procedure Tfrmcadclasse.FormActivate(Sender: TObject);
begin
  if (frmcadclasse.tag=1) or (frmcadclasse.tag=3) then begin
    frmcadclasse.caption:='Inclusão de Classe de Escola Sabatina';
    limpar;
    datacad.SetFocus;
  end;
  if frmcadclasse.tag=2 then begin
    frmcadclasse.caption:='Alteração de Classe de Escola Sabatina';
    limpar;
    mostrar;
    datacad.SetFocus;
  end;
end;

procedure Tfrmcadclasse.BitBtn2Click(Sender: TObject);
begin
  frmcadclasse.close;
end;

procedure Tfrmcadclasse.BitBtn1Click(Sender: TObject);
var
  x:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  if (edit4.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit4.setfocus; end;

  if ((frmcadclasse.tag=1) or (frmcadclasse.tag=3)) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO classe ';
      x:=x+'(codigo, ativo, igreja, datacad, numero, descricao,senhaacesso, dataid, horaid, id) ';
      x:=x+'VALUES (NULL,';                   // codigo
      x:=x+#39+'S'+#39+',';                   // ativo
      x:=x+#39+frmprincipal.Configura[3]+#39+','; // igreja
      x:=x+#39+mydata(datacad.text)+#39+',';  // datacad
      x:=x+#39+edit2.text+#39+',';            // numero
      x:=x+#39+edit4.text+#39+',';            // descricao
      x:=x+#39+edit3.text+#39+',';            // senhaacesso
      x:=x+#39+mydata(adataid.text)+#39+',';  // dataid
      x:=x+#39+ahoraid.text+#39+',';          // horaid
      x:=x+#39+frmprincipal.Configura[1]+#39; // id
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    if (frmcadclasse.tag=1) then begin
      limpar;
      datacad.SetFocus;
    end;
    if (frmcadclasse.tag=3) then begin
      codcad.text:=voltauc('classe','codigo','descricao='+edit4.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
      frmcadclasse.close;
    end;
  end;

  if (frmcadclasse.tag=2) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE classe SET ';
      x:=x+'descricao='+#39+edit4.text+#39+',';           // descricao
      x:=x+'senhaacesso='+#39+edit3.text+#39+',';            // senhaacesso
      x:=x+'datacad='+#39+mydata(datacad.text)+#39+',';   // datacad
      x:=x+'numero='+#39+edit2.text+#39+',';              // numero
      x:=x+'ativo='+#39+copy(combobox1.Text,1,1)+#39;     // ativo
      x:=x+' where codigo='+#39+edit1.text+#39;
      sql.add(x);
      ExecSql;
    end;
    frmcadclasse.close;
  end;

end;

procedure Tfrmcadclasse.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadclasse.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

end.
