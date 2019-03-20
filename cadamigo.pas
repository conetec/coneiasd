unit cadamigo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, ExtCtrls, Menus, ComCtrls,
  JvExMask, JvToolEdit, funcaolocal, Grids, DBGrids ;

type
  Tfrmcadamigo = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    codcad: TEdit;
    adataID: TEdit;
    ahoraID: TEdit;
    PageControl1: TPageControl;
    p1: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label12: TLabel;
    dtnasc: TJvDateEdit;
    ComboBox1: TComboBox;
    Label13: TLabel;
    Label15: TLabel;
    ComboBox3: TComboBox;
    ComboBox2: TComboBox;
    Label14: TLabel;
    Label10: TLabel;
    MaskEdit1: TMaskEdit;
    Edit9: TEdit;
    Label7: TLabel;
    p3: TTabSheet;
    Memo1: TMemo;
    Label2: TLabel;
    dtcad: TJvDateEdit;
    Label5: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit5: TEdit;
    Label8: TLabel;
    MaskEdit3: TMaskEdit;
    Edit6: TEdit;
    Label9: TLabel;
    MaskEdit4: TMaskEdit;
    Label16: TLabel;
    Label17: TLabel;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    f1: TRadioButton;
    f2: TRadioButton;
    f3: TRadioButton;
    f4: TRadioButton;
    Label6: TLabel;
    eativo: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Enter(Sender: TObject);
    procedure limpar;
    procedure mostrar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadamigo: Tfrmcadamigo;
  ultnome,gravar:string;

implementation

uses datamodule10, principal;



{$R *.DFM}


procedure Tfrmcadamigo.limpar;
begin

  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);

  edit1.Text:='0';
  dtcad.Text:=formatdatetime('dd/mm/yyyy',date);
  dtnasc.Text:='';
  f4.Checked:=true;

  edit4.Text:='';
  combobox1.ItemIndex:=0;
  combobox3.ItemIndex:=4;
  combobox2.ItemIndex:=2;
  edit2.Text:='';
  edit5.Text:='';
  maskedit3.Text:='';

  edit6.Text:=frmprincipal.Configura[5];
  edit3.Text:=frmprincipal.Configura[6];

  maskedit4.Text:='';
  maskedit1.Text:='';
  edit9.Text:='';
  memo1.Lines.Clear;
end;


procedure Tfrmcadamigo.mostrar;
var
  i:integer;
  narq:string;
  x:string;
begin

  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  dtcad.Text:=data10.mymostra.fieldbyname('datacad').asstring;
  dtnasc.Text:=data10.mymostra.fieldbyname('nascimento').asstring;

  x:=data10.mymostra.fieldbyname('faixa').asstring;
  if x='CRIANÇA' then begin f1.Checked:=true; end;
  if x='ADOLESCENTE' then begin f2.Checked:=true; end;
  if x='JOVEM' then begin f3.Checked:=true; end;
  if x='ADULTO' then begin f4.Checked:=true; end;

  edit4.Text:=data10.mymostra.fieldbyname('nome').asstring;
  combobox1.ItemIndex:=-1;

  for i:=0 to combobox1.Items.Count-1 do begin
    if combobox1.Items[i]=data10.mymostra.fieldbyname('sexo').asstring then begin
      combobox1.ItemIndex:=i;
      break;
    end;
  end;

  combobox3.ItemIndex:=-1;
  for i:=0 to combobox3.Items.Count-1 do begin
    if combobox3.Items[i]=data10.mymostra.fieldbyname('estadocivil').asstring then begin
      combobox3.ItemIndex:=i;
      break;
    end;
  end;

  combobox2.ItemIndex:=-1;
  for i:=0 to combobox2.Items.Count-1 do begin
    if combobox2.Items[i]=data10.mymostra.fieldbyname('genitor').asstring then begin
      combobox2.ItemIndex:=i;
      break;
    end;
  end;

  edit2.Text:=data10.mymostra.fieldbyname('endereco').asstring;
  edit5.Text:=data10.mymostra.fieldbyname('bairro').asstring;
  maskedit3.Text:=data10.mymostra.fieldbyname('cep').asstring;
  edit6.Text:=data10.mymostra.fieldbyname('cidade').asstring;
  edit3.Text:=data10.mymostra.fieldbyname('estado').asstring;

  maskedit4.Text:=data10.mymostra.fieldbyname('telefone').asstring;
  maskedit1.Text:=data10.mymostra.fieldbyname('celular').asstring;
  edit9.Text:=data10.mymostra.fieldbyname('email').asstring;

  memo1.Lines.clear;
  memo1.lines.add(data10.mymostra.fieldbyname('observacoes').value);
  memo1.Text:=trim(memo1.Text);

end;


procedure Tfrmcadamigo.FormActivate(Sender: TObject);
begin
  if (frmcadamigo.tag=1) or (frmcadamigo.tag=3) then begin
    frmcadamigo.caption:='Inclusão de Amigo';
    limpar();
    p1.Show;
    edit1.SetFocus;
  end;
  if frmcadamigo.tag=2 then begin
    frmcadamigo.caption:='Alteração de Amigo';
    limpar;
    mostrar;
    p1.Show;
    edit1.SetFocus;
  end;
end;

procedure Tfrmcadamigo.BitBtn2Click(Sender: TObject);
begin
  frmcadamigo.close;
end;

procedure Tfrmcadamigo.BitBtn1Click(Sender: TObject);
var
  x,narq,fase:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  if (edit4.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','Atenção',mb_ok); a:=1; p1.Show; edit4.setfocus; end;

  if (a=0) then begin

    if f1.Checked=true then begin fase:='CRIANÇA'; end;
    if f2.Checked=true then begin fase:='ADOLESCENTE'; end;
    if f3.Checked=true then begin fase:='JOVEM'; end;
    if f4.Checked=true then begin fase:='ADULTO'; end;

    if ((frmcadamigo.tag=1) or (frmcadamigo.tag=3)) then begin
      if ((trim(edit1.text)='0') or (trim(edit1.text)='')) then begin
        with data10.exemysql do begin
          sql.clear;
          x:='INSERT INTO amigo ';
          x:=x+' (codigo, igreja, ativo, datacad, nascimento, faixa, nome, endereco, bairro, cep, cidade, estado, estadocivil, telefone, celular, email, observacoes,';
          x:=x+'sexo, genitor, visitante, interessado, estudante, classe, pg, dataid, horaid, id) ';
          x:=x+'VALUES (NULL,';                               // codigo
          x:=x+#39+frmprincipal.Configura[3]+#39+',';         // igreja
          x:=x+#39+'S'+#39+',';                               // ativo
          x:=x+#39+mydata(dtcad.text)+#39+',';                // datacad
          x:=x+#39+mydata(dtnasc.text)+#39+',';               // nascimento
          x:=x+#39+fase+#39+',';                              // faixa
          x:=x+#39+edit4.text+#39+',';                        // nome
          x:=x+#39+edit2.text+#39+',';                        // endereco
          x:=x+#39+edit5.text+#39+',';                        // bairro
          x:=x+#39+maskedit3.text+#39+',';                    // cep
          x:=x+#39+edit6.text+#39+',';                        // cidade
          x:=x+#39+edit3.text+#39+',';                        // estado
          x:=x+#39+combobox3.text+#39+',';                    // estadocivil
          x:=x+#39+maskedit4.text+#39+',';                    // comercial
          x:=x+#39+maskedit1.text+#39+',';                    // celular
          x:=x+#39+edit9.text+#39+',';                        // email
          x:=x+#39+trim(memo1.Lines.Text)+#39+',';            // observacoes
          x:=x+#39+combobox1.text+#39+',';                    // sexo
          x:=x+#39+combobox2.text+#39+',';                    // genitor
          x:=x+#39+'N'+#39+',';                               // visitante
          x:=x+#39+'N'+#39+',';                               // interessado
          x:=x+#39+'N'+#39+',';                               // estudante
          x:=x+#39+'N'+#39+',';                               // classe
          x:=x+#39+'N'+#39+',';                               // pg
          x:=x+#39+mydata(adataID.text)+#39+',';              // dataid
          x:=x+#39+ahoraID.text+#39+',';                      // horaid
          x:=x+#39+frmprincipal.Configura[1]+#39;             // id
          x:=x+')';
          sql.add(x);
          ExecSql;
          codcad.text:=voltauc('amigo','codigo','nome='+edit4.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
          edit1.Text:=codcad.text;
        end;
      end;
      if (frmcadamigo.tag=1) then begin
        limpar;
        edit1.SetFocus;
      end;
      if (frmcadamigo.tag=3) then begin
        frmcadamigo.close;
      end;
    end;

    if (frmcadamigo.tag=2) then begin
      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE amigo SET ';
        x:=x+'ativo='+#39+copy(eativo.Text,1,1)+#39+',';                      // ativo
        x:=x+'nascimento='+#39+mydata(dtnasc.text)+#39+',';                   // nascimento
        x:=x+'faixa='+#39+fase+#39+',';                                       // faixa
        x:=x+'nome='+#39+edit4.text+#39+',';                                  // nome
        x:=x+'endereco='+#39+edit2.text+#39+',';                              // endereco
        x:=x+'bairro='+#39+edit5.text+#39+',';                                // bairro
        x:=x+'cep='+#39+maskedit3.text+#39+',';                               // cep
        x:=x+'cidade='+#39+edit6.text+#39+',';                                // cidade
        x:=x+'estado='+#39+edit3.text+#39+',';                                // estado
        x:=x+'estadocivil='+#39+combobox3.text+#39+',';                       // estadocivil
        x:=x+'telefone='+#39+maskedit4.text+#39+',';                          // comercial
        x:=x+'celular='+#39+maskedit1.text+#39+',';                           // celular
        x:=x+'email='+#39+edit9.text+#39+',';                                 // email
        x:=x+'observacoes='+#39+trim(memo1.Lines.Text)+#39+',';               // observacoes
        x:=x+'sexo='+#39+combobox1.text+#39+',';                              // sexo
        x:=x+'genitor='+#39+combobox2.text+#39;                               // genitor
        x:=x+' where codigo='+#39+edit1.text+#39;
        mandamemoria(x);
        sql.add(x);
        ExecSql;
      end;
      frmcadamigo.close;
    end;
  end;

end;

procedure Tfrmcadamigo.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadamigo.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

end.
