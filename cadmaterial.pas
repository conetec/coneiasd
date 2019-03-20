unit cadmaterial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, Menus ;

type
  Tfrmcadmaterial = class(TForm)
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
    Label5: TLabel;
    Edit2: TEdit;
    Label6: TLabel;
    Edit3: TEdit;
    Label7: TLabel;
    Edit5: TEdit;
    Label8: TLabel;
    Edit6: TEdit;
    Label9: TLabel;
    Label20: TLabel;
    Edit8: TEdit;
    Edit7: TEdit;
    PopupMenu2: TPopupMenu;
    CadastrarProfisso1: TMenuItem;
    LocalizarProfisso1: TMenuItem;
    Sair2: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure limpar;
    procedure mostrar;
    procedure Edit1Enter(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure CadastrarProfisso1Click(Sender: TObject);
    procedure LocalizarProfisso1Click(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadmaterial: Tfrmcadmaterial;

implementation

uses datamodule10, principal, cadmaterial_tipo, locmaterial_tipo;

{$R *.DFM}

procedure Tfrmcadmaterial.limpar;
begin
  edit1.Text:='0';

  edit2.Text:='0';
  edit3.Text:='0';
  edit5.Text:='0,00';
  edit6.Text:='0,00';

  edit8.Text:='';
  edit7.Text:='';

  combobox1.ItemIndex:=0;
  edit4.Text:='';
  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);
end;


procedure Tfrmcadmaterial.mostrar;
var
  i:integer;
begin
  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  edit4.Text:=data10.mymostra.fieldbyname('descricao').asstring;

  edit2.Text:=formatfloat('###,###,###,0.',data10.mymostra.fieldbyname('quantidade').value);
  edit3.Text:=formatfloat('###,###,###,0.',data10.mymostra.fieldbyname('minimo').value);
  edit5.Text:=formatfloat('###,###,###,0.00',data10.mymostra.fieldbyname('vlrcompra').value);
  edit6.Text:=formatfloat('###,###,###,0.00',data10.mymostra.fieldbyname('vlrvenda').value);


  edit8.Text:=data10.mymostra.fieldbyname('categoria').asstring;
  edit7.Text:=voltainfo('material_tipo','descricao','codigo='+#39+edit8.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');

  combobox1.ItemIndex:=-1;
  for i:=0 to combobox1.Items.Count-1 do begin
    if copy(combobox1.Items[i],1,1)=data10.mymostra.fieldbyname('ativo').asstring then begin
      combobox1.ItemIndex:=i;
      break;
    end;
  end;

end;


procedure Tfrmcadmaterial.FormActivate(Sender: TObject);
begin
  if (frmcadmaterial.tag=1) or (frmcadmaterial.tag=3) then begin
    frmcadmaterial.caption:='Inclusão de Material';
    limpar;
    edit4.SetFocus;
  end;
  if frmcadmaterial.tag=2 then begin
    frmcadmaterial.caption:='Alteração de Material';
    limpar;
    mostrar;
    edit4.SetFocus;
  end;
end;

procedure Tfrmcadmaterial.BitBtn2Click(Sender: TObject);
begin
  frmcadmaterial.close;
end;

procedure Tfrmcadmaterial.BitBtn1Click(Sender: TObject);
var
  x:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  if (edit4.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit4.setfocus; end;
  if (trim(edit8.text)='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit8.setfocus; end;

  if ((frmcadmaterial.tag=1) or (frmcadmaterial.tag=3)) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO material ';
      x:=x+'(codigo, ativo, igreja, descricao, categoria, quantidade, minimo, vlrcompra, vlrvenda, dataid, horaid, id) ';
      x:=x+'VALUES (NULL,';                   // codigo
      x:=x+#39+'S'+#39+',';                   // ativo
      x:=x+#39+frmprincipal.Configura[3]+#39+','; // igreja
      x:=x+#39+edit4.text+#39+',';            // descricao
      x:=x+#39+edit8.text+#39+',';            // categoria
      x:=x+#39+sonumero(edit2.text)+#39+',';  // quantidade
      x:=x+#39+sonumero(edit3.text)+#39+',';  // minimo
      x:=x+myvalor(edit5.text)+',';           // vlrcompra
      x:=x+myvalor(edit6.text)+',';           // vlrvenda
      x:=x+#39+mydata(adataid.text)+#39+',';  // dataid
      x:=x+#39+ahoraid.text+#39+',';          // horaid
      x:=x+#39+frmprincipal.Configura[1]+#39; // id
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    if (frmcadmaterial.tag=1) then begin
      limpar;
      edit4.SetFocus;
    end;
    if (frmcadmaterial.tag=3) then begin
      codcad.text:=voltauc('material','codigo','descricao='+edit4.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
      frmcadmaterial.close;
    end;
  end;

  if (frmcadmaterial.tag=2) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE material SET ';
      x:=x+'descricao='+#39+edit4.text+#39+',';           // descricao
      x:=x+'categoria='+#39+edit8.text+#39+',';            // categoria
      x:=x+'quantidade='+#39+sonumero(edit2.text)+#39+',';  // quantidade
      x:=x+'minimo='+#39+sonumero(edit3.text)+#39+',';     // minimo
      x:=x+'vlrcompra='+myvalor(edit5.text)+',';           // vlrcompra
      x:=x+'vlrvenda='+myvalor(edit6.text)+',';           // vlrvenda
      x:=x+'ativo='+#39+copy(combobox1.Text,1,1)+#39;     // ativo
      x:=x+' where codigo='+#39+edit1.text+#39;
      sql.add(x);
      ExecSql;
    end;
    frmcadmaterial.close;
  end;

end;

procedure Tfrmcadmaterial.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadmaterial.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcadmaterial.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key in ['.',','] Then Key := DecimalSeparator;
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadmaterial.Edit3Exit(Sender: TObject);
begin
  if edit3.text='' then begin edit3.text:='0'; end;
  edit3.text:=formatfloat('###,###,###,0.',vc(edit3.text));
end;

procedure Tfrmcadmaterial.Edit5Exit(Sender: TObject);
begin
  if edit5.text='' then begin edit5.text:='0'; end;
  edit5.text:=formatfloat('###,###,###,0.00',vc(edit5.text));
end;

procedure Tfrmcadmaterial.Edit6Exit(Sender: TObject);
begin
  if edit6.text='' then begin edit6.text:='0'; end;
  edit6.text:=formatfloat('###,###,###,0.00',vc(edit6.text));
end;

procedure Tfrmcadmaterial.CadastrarProfisso1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcadmaterial_tipo, frmcadmaterial_tipo);
  frmcadmaterial_tipo.tag:=3;
  frmcadmaterial_tipo.showmodal;
  edit8.Text:=frmcadmaterial_tipo.codcad.Text;
  frmcadmaterial_tipo.Free;
  edit8.setfocus;
end;

procedure Tfrmcadmaterial.LocalizarProfisso1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocmaterial_tipo, frmlocmaterial_tipo);
  frmlocmaterial_tipo.showmodal;
  edit8.Text:=frmlocmaterial_tipo.ocod.text;
  edit8.setfocus;
  frmlocmaterial_tipo.Free;
end;

procedure Tfrmcadmaterial.Edit8Exit(Sender: TObject);
var
  ax:string;
begin
  if edit8.text<>'' then begin
    ax:=trim(soletra(edit8.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocmaterial_tipo, frmlocmaterial_tipo);
      frmlocmaterial_tipo.auxp.text:=trim(ax);
      frmlocmaterial_tipo.showmodal;
      edit8.Text:=frmlocmaterial_tipo.ocod.text;
      edit8.setfocus;
      frmlocmaterial_tipo.Free;
    end else begin
      edit7.Text:=voltainfo('material_tipo','descricao','codigo='+#39+edit8.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(edit7.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit8.setfocus;
      end;
    end;
  end;
end;


end.
