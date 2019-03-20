unit cadaluno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, ExtCtrls, Menus, ComCtrls,
  JvExMask, JvToolEdit, funcaolocal, Grids, DBGrids, jpeg;

type
  Tfrmcadaluno = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PopupMenu1: TPopupMenu;
    CadastrarFamilia1: TMenuItem;
    sair1: TMenuItem;
    PopupMenu2: TPopupMenu;
    CadastrarProfisso1: TMenuItem;
    Sair2: TMenuItem;
    PopupMenu3: TPopupMenu;
    CadastrarClassedeEscolaSabatina1: TMenuItem;
    Sair3: TMenuItem;
    codcad: TEdit;
    adataID: TEdit;
    ahoraID: TEdit;
    PageControl1: TPageControl;
    p1: TTabSheet;
    p2: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    Edit3: TEdit;
    Label11: TLabel;
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
    Label17: TLabel;
    Edit6: TEdit;
    Edit5: TEdit;
    Label5: TLabel;
    Label10: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Edit9: TEdit;
    Label7: TLabel;
    Label6: TLabel;
    Label19: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Label20: TLabel;
    Label8: TLabel;
    ComboBox6: TComboBox;
    dtbat: TJvDateEdit;
    Label9: TLabel;
    Label16: TLabel;
    Edit2: TEdit;
    Label21: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    Label22: TLabel;
    p3: TTabSheet;
    Memo1: TMemo;
    ProcurarFamlia1: TMenuItem;
    LocalizarProfisso1: TMenuItem;
    LocalizarClasseES1: TMenuItem;
    p4: TTabSheet;
    BitBtn6: TBitBtn;
    BitBtn5: TBitBtn;
    DBGrid2: TDBGrid;
    Label3: TLabel;
    eativo: TComboBox;
    Label18: TLabel;
    ComboBox4: TComboBox;
    GroupBox1: TGroupBox;
    g01: TCheckBox;
    g02: TCheckBox;
    g03: TCheckBox;
    g04: TCheckBox;
    g05: TCheckBox;
    g06: TCheckBox;
    g07: TCheckBox;
    g08: TCheckBox;
    g09: TCheckBox;
    g10: TCheckBox;
    g11: TCheckBox;
    goutros: TEdit;
    edendereco: TLabel;
    edbairro: TLabel;
    edcep: TLabel;
    edcidade: TLabel;
    edestado: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure CadastrarFamilia1Click(Sender: TObject);
    procedure CadastrarProfisso1Click(Sender: TObject);
    procedure CadastrarClassedeEscolaSabatina1Click(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure limpar;
    procedure mostrar;
    procedure ProcurarFamlia1Click(Sender: TObject);
    procedure LocalizarProfisso1Click(Sender: TObject);
    procedure LocalizarClasseES1Click(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
    procedure Edit10Exit(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure p4Show(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadaluno: Tfrmcadaluno;
  ultnome,gravar:string;

implementation

uses datamodule10, membro, principal, cadfamilia, cadprofissao, captura,
  cadclasse, locfamilia, locprofissao, locclasse, ligacargo, editaimg,
  testes, captura01;


{$R *.DFM}


procedure Tfrmcadaluno.limpar;
var
  narq:string;
begin
  bitbtn1.Enabled:=true;

  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);

  edit1.Text:='0';
  eativo.ItemIndex:=0;
  edit3.Text:='';
  edit4.Text:='';
  dtnasc.Text:='';
  combobox1.ItemIndex:=0;
  combobox3.ItemIndex:=0;
  combobox2.ItemIndex:=0;
  edit5.Text:='';
  edit6.Text:='';
  maskedit1.Text:='';
  maskedit2.Text:='';
  edit9.Text:='';
  edit8.Text:='';
  edit7.Text:='';
  combobox6.ItemIndex:=0;
  combobox4.ItemIndex:=1;
  dtbat.Text:='';
  edit2.Text:='';
  edit10.Text:='';
  edit11.Text:='';
  memo1.Lines.Clear;

  g01.Checked:=false;
  g02.Checked:=false;
  g03.Checked:=false;
  g04.Checked:=false;
  g05.Checked:=false;
  g06.Checked:=false;
  g07.Checked:=false;
  g08.Checked:=false;
  g09.Checked:=false;
  g10.Checked:=false;
  g11.Checked:=false;

  goutros.Text:='';

  edendereco.Caption:='Endereço:';
  edbairro.Caption:='Bairro:';
  edcep.Caption:='CEP:';
  edcidade.Caption:='Cidade:';
  edestado.Caption:='Estado:';

end;


procedure Tfrmcadaluno.mostrar;
var
  i:integer;
  narq,x:string;
begin

  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  edit3.Text:=data10.mymostra.fieldbyname('anp').asstring;
  edit4.Text:=data10.mymostra.fieldbyname('nome').asstring;
  dtnasc.Text:=data10.mymostra.fieldbyname('nascimento').asstring;

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

  combobox4.ItemIndex:=1;
  for i:=0 to combobox4.Items.Count-1 do begin
    if combobox4.Items[i]=data10.mymostra.fieldbyname('instrutor').asstring then begin
      combobox4.ItemIndex:=i;
      break;
    end;
  end;

  edit5.Text:=data10.mymostra.fieldbyname('familia').asstring;
  x:=voltainfo('familia','descricao|endereco|bairro|cep|cidade|estado','codigo='+#39+edit5.Text+#39,'T|T|T|T|T|T','0');
  edit6.Text:=voltacod(x,'|',0);
  edendereco.Caption:='Endereço: '+voltacod(x,'|',1);
  edbairro.Caption:='Bairro: '+voltacod(x,'|',2);
  edcep.Caption:='CEP: '+voltacod(x,'|',3);
  edcidade.Caption:='Cidade: '+voltacod(x,'|',4);
  edestado.Caption:='Estado: '+voltacod(x,'|',5);

  maskedit1.Text:=data10.mymostra.fieldbyname('celular').asstring;
  maskedit2.Text:=data10.mymostra.fieldbyname('comercial').asstring;
  edit9.Text:=data10.mymostra.fieldbyname('email').asstring;

  edit8.Text:=data10.mymostra.fieldbyname('profissao').asstring;
  edit7.Text:=voltainfo('profissao','descricao','codigo='+#39+edit8.Text+#39,'T','0');

  combobox6.ItemIndex:=-1;
  for i:=0 to combobox6.Items.Count-1 do begin
    if combobox6.Items[i]=data10.mymostra.fieldbyname('batizado').asstring then begin
      combobox6.ItemIndex:=i;
      break;
    end;
  end;


  eativo.ItemIndex:=-1;
  for i:=0 to eativo.Items.Count-1 do begin
    if copy(eativo.Items[i],1,1)=data10.mymostra.fieldbyname('ativo').asstring then begin
      eativo.ItemIndex:=i;
      break;
    end;
  end;

  dtbat.Text:=data10.mymostra.fieldbyname('databatismo').asstring;
  edit2.Text:=data10.mymostra.fieldbyname('carta').asstring;

  edit10.Text:=data10.mymostra.fieldbyname('classe').asstring;
  edit11.Text:=voltainfo('classe','descricao','codigo='+#39+edit10.Text+#39,'T','0');

  if data10.mymostra.fieldbyname('gostaria01').asstring='S' then begin g01.Checked:=true; end else begin g01.Checked:=false; end;
  if data10.mymostra.fieldbyname('gostaria02').asstring='S' then begin g02.Checked:=true; end else begin g02.Checked:=false; end;
  if data10.mymostra.fieldbyname('gostaria03').asstring='S' then begin g03.Checked:=true; end else begin g03.Checked:=false; end;
  if data10.mymostra.fieldbyname('gostaria04').asstring='S' then begin g04.Checked:=true; end else begin g04.Checked:=false; end;
  if data10.mymostra.fieldbyname('gostaria05').asstring='S' then begin g05.Checked:=true; end else begin g05.Checked:=false; end;
  if data10.mymostra.fieldbyname('gostaria06').asstring='S' then begin g06.Checked:=true; end else begin g06.Checked:=false; end;
  if data10.mymostra.fieldbyname('gostaria07').asstring='S' then begin g07.Checked:=true; end else begin g07.Checked:=false; end;
  if data10.mymostra.fieldbyname('gostaria08').asstring='S' then begin g08.Checked:=true; end else begin g08.Checked:=false; end;
  if data10.mymostra.fieldbyname('gostaria09').asstring='S' then begin g09.Checked:=true; end else begin g09.Checked:=false; end;
  if data10.mymostra.fieldbyname('gostaria10').asstring='S' then begin g10.Checked:=true; end else begin g10.Checked:=false; end;

  goutros.Text:=data10.mymostra.fieldbyname('gostariaoutros').asstring;
  if trim(data10.mymostra.fieldbyname('gostariaoutros').asstring)='' then begin
    g11.Checked:=false;
  end else begin
    g11.Checked:=true;
  end;


  memo1.Lines.clear;
  memo1.lines.add(data10.mymostra.fieldbyname('observacoes').value);
  memo1.Text:=trim(memo1.Text);
end;


procedure Tfrmcadaluno.FormActivate(Sender: TObject);
begin
  if (frmcadaluno.tag=1) or (frmcadaluno.tag=3) then begin
    frmcadaluno.caption:='Inclusão de Aluno';
    limpar();
    p1.Show;
    edit1.SetFocus;
  end;
  if frmcadaluno.tag=2 then begin
    frmcadaluno.caption:='Alteração de Aluno';
    limpar;
    mostrar;
    p1.Show;
    edit1.SetFocus;
  end;
end;

procedure Tfrmcadaluno.BitBtn2Click(Sender: TObject);
begin
  frmcadaluno.close;
end;

procedure Tfrmcadaluno.BitBtn1Click(Sender: TObject);
var
  x,narq:string;
  xg1,xg2,xg3,xg4,xg5,xg6,xg7,xg8,xg9,xg10,xg11:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  if (edit4.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','Atenção',mb_ok); a:=1; p1.Show; edit4.setfocus; end;
  if (edit5.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','Atenção',mb_ok); a:=1; p1.Show; edit5.setfocus; end;

  if (a=0) then begin
    bitbtn1.Enabled:=false;

    if g01.Checked=true then begin xg1:='S' end else begin xg1:='N'; end;
    if g02.Checked=true then begin xg2:='S' end else begin xg2:='N'; end;
    if g03.Checked=true then begin xg3:='S' end else begin xg3:='N'; end;
    if g04.Checked=true then begin xg4:='S' end else begin xg4:='N'; end;
    if g05.Checked=true then begin xg5:='S' end else begin xg5:='N'; end;
    if g06.Checked=true then begin xg6:='S' end else begin xg6:='N'; end;
    if g07.Checked=true then begin xg7:='S' end else begin xg7:='N'; end;
    if g08.Checked=true then begin xg8:='S' end else begin xg8:='N'; end;
    if g09.Checked=true then begin xg9:='S' end else begin xg9:='N'; end;
    if g10.Checked=true then begin xg10:='S' end else begin xg10:='N'; end;
    if trim(goutros.Text)<>'' then begin xg11:='S' end else begin xg11:='N'; end;


    if ((frmcadaluno.tag=1) or (frmcadaluno.tag=3)) then begin
      if ((trim(edit1.text)='0') or (trim(edit1.text)='')) then begin
        with data10.exemysql do begin
          sql.clear;
          x:='INSERT INTO membro ';
          x:=x+'(codigo, ativo, instrutor, igreja ,nome, nascimento, familia, estadocivil, celular, comercial, email, profissao,';
          x:=x+' gostaria01,gostaria02,gostaria03,gostaria04,gostaria05,gostaria06,gostaria07,gostaria08,gostaria09,gostaria10,gostaria11,gostariaoutros,';
          x:=x+' dataatualizacao,batizado, databatismo, carta, observacoes, sexo, genitor, anp, classe, dataid, horaid, id) ';
          x:=x+'VALUES (NULL,';                               // codigo
          x:=x+#39+copy(eativo.Text,1,1)+#39+',';             // ativo
          x:=x+#39+combobox4.text+#39+',';                    // instrutor
          x:=x+#39+frmprincipal.Configura[3]+#39+',';         // igreja
          x:=x+#39+edit4.text+#39+',';                        // nome
          x:=x+#39+mydata(dtnasc.text)+#39+',';               // nascimento
          x:=x+#39+edit5.Text+#39+',';                        // familia
          x:=x+#39+combobox3.text+#39+',';                    // estadocivil
          x:=x+#39+maskedit1.text+#39+',';                    // celular
          x:=x+#39+maskedit2.text+#39+',';                    // comercial
          x:=x+#39+edit9.text+#39+',';                        // email
          x:=x+#39+edit8.text+#39+',';                        // profissao

          x:=x+#39+xg1+#39+',';                               // gostaria01
          x:=x+#39+xg2+#39+',';                               // gostaria02
          x:=x+#39+xg3+#39+',';                               // gostaria03
          x:=x+#39+xg4+#39+',';                               // gostaria04
          x:=x+#39+xg5+#39+',';                               // gostaria05
          x:=x+#39+xg6+#39+',';                               // gostaria06
          x:=x+#39+xg7+#39+',';                               // gostaria07
          x:=x+#39+xg8+#39+',';                               // gostaria08
          x:=x+#39+xg9+#39+',';                               // gostaria09
          x:=x+#39+xg10+#39+',';                              // gostaria10
          x:=x+#39+xg11+#39+',';                              // gostaria11
          x:=x+#39+goutros.Text+#39+',';                      // gostariaoutros
          x:=x+#39+formatdatetime('yyy-mm-dd',date)+#39+',';  // dataatualizacao

          x:=x+#39+combobox6.text+#39+',';                    // batizado
          x:=x+#39+mydata(dtbat.text)+#39+',';                // databatismo
          x:=x+#39+edit2.text+#39+',';                        // carta
          x:=x+#39+trim(memo1.Lines.Text)+#39+',';            // observacoes
          x:=x+#39+combobox1.text+#39+',';                    // sexo
          x:=x+#39+combobox2.text+#39+',';                    // genitor
          x:=x+#39+edit3.text+#39+',';                        // associacao
          x:=x+#39+edit10.Text+#39+',';                       // classe
          x:=x+#39+mydata(adataID.text)+#39+',';              // dataid
          x:=x+#39+ahoraID.text+#39+',';                      // horaid
          x:=x+#39+frmprincipal.Configura[1]+#39;             // id
          x:=x+')';
          sql.add(x);
          ExecSql;
        end;
      end;
      if bitbtn5.tag<>10 then begin
        if (frmcadaluno.tag=1) then begin
          limpar;
          edit1.SetFocus;
        end;
        if (frmcadaluno.tag=3) then begin
          frmcadaluno.close;
        end;
      end;
    end;

    if (frmcadaluno.tag=2) then begin

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE membro SET ';
        x:=x+'gostaria01='+#39+xg1+#39+',';                               // gostaria01
        x:=x+'gostaria02='+#39+xg2+#39+',';                               // gostaria02
        x:=x+'gostaria03='+#39+xg3+#39+',';                               // gostaria03
        x:=x+'gostaria04='+#39+xg4+#39+',';                               // gostaria04
        x:=x+'gostaria05='+#39+xg5+#39+',';                               // gostaria05
        x:=x+'gostaria06='+#39+xg6+#39+',';                               // gostaria06
        x:=x+'gostaria07='+#39+xg7+#39+',';                               // gostaria07
        x:=x+'gostaria08='+#39+xg8+#39+',';                               // gostaria08
        x:=x+'gostaria09='+#39+xg9+#39+',';                               // gostaria09
        x:=x+'gostaria10='+#39+xg10+#39+',';                              // gostaria10
        x:=x+'gostaria11='+#39+xg11+#39+',';                              // gostaria11
        x:=x+'gostariaoutros='+#39+goutros.Text+#39+',';                      // gostariaoutros
        x:=x+'dataatualizacao='+#39+formatdatetime('yyy-mm-dd',date)+#39+',';  // dataatualizacao
        x:=x+'ativo='+#39+copy(eativo.Text,1,1)+#39+',';                        // ativo
        x:=x+'instrutor='+#39+combobox4.text+#39+',';                           // instrutor
        x:=x+'nome='+#39+edit4.text+#39+',';                                    // nome
        x:=x+'nascimento='+#39+mydata(dtnasc.text)+#39+',';                     // nascimento
        x:=x+'familia='+#39+edit5.Text+#39+',';                                 // familia
        x:=x+'estadocivil='+#39+combobox3.text+#39+',';                         // estadocivil
        x:=x+'celular='+#39+maskedit1.text+#39+',';                             // celular
        x:=x+'comercial='+#39+maskedit2.text+#39+',';                           // comercial
        x:=x+'email='+#39+edit9.text+#39+',';                                   // email
        x:=x+'profissao='+#39+edit8.Text+#39+',';                               // profissao
        x:=x+'batizado='+#39+combobox6.text+#39+',';                            // batizado
        x:=x+'databatismo='+#39+mydata(dtbat.text)+#39+',';                     // databatismo
        x:=x+'carta='+#39+edit2.text+#39+',';                                   // carta
        x:=x+'observacoes='+#39+trim(memo1.Lines.Text)+#39+',';                 // observacoes
        x:=x+'sexo='+#39+combobox1.text+#39+',';                                // sexo
        x:=x+'genitor='+#39+combobox2.text+#39+',';                             // genitor
        x:=x+'classe='+#39+edit10.text+#39+',';                                 // classe
        x:=x+'anp='+#39+edit3.text+#39;                                         // associacao
        x:=x+' where codigo='+#39+edit1.text+#39;
        sql.add(x);
        ExecSql;
      end;
      frmcadaluno.close;
    end;
  end;

end;

procedure Tfrmcadaluno.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadaluno.CadastrarFamilia1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcadfamilia, frmcadfamilia);
  frmcadfamilia.tag:=3;
  frmcadfamilia.showmodal;
  edit5.Text:=frmcadfamilia.codcad.Text;
  frmcadfamilia.Free;
  edit5.setfocus;
end;

procedure Tfrmcadaluno.CadastrarProfisso1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcadprofissao, frmcadprofissao);
  frmcadprofissao.tag:=3;
  frmcadprofissao.showmodal;
  edit8.Text:=frmcadprofissao.codcad.Text;
  frmcadprofissao.Free;
  edit8.setfocus;
end;

procedure Tfrmcadaluno.CadastrarClassedeEscolaSabatina1Click(
  Sender: TObject);
begin
  Application.CreateForm(Tfrmcadclasse, frmcadclasse);
  frmcadclasse.tag:=3;
  frmcadclasse.showmodal;
  edit10.Text:=frmcadclasse.codcad.Text;
  frmcadclasse.Free;
  edit10.setfocus;
end;

procedure Tfrmcadaluno.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcadaluno.ProcurarFamlia1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocfamilia, frmlocfamilia);
  frmlocfamilia.showmodal;
  edit5.Text:=frmlocfamilia.ocod.text;
  edit5.setfocus;
  frmlocfamilia.Free;
end;

procedure Tfrmcadaluno.LocalizarProfisso1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocprofissao, frmlocprofissao);
  frmlocprofissao.showmodal;
  edit8.Text:=frmlocprofissao.ocod.text;
  edit8.setfocus;
  frmlocprofissao.Free;
end;

procedure Tfrmcadaluno.LocalizarClasseES1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocclasse, frmlocclasse);
  frmlocclasse.showmodal;
  edit10.Text:=frmlocclasse.ocod.text;
  edit10.setfocus;
  frmlocclasse.Free;
end;

procedure Tfrmcadaluno.Edit5Exit(Sender: TObject);
var
  ax,x:string;
begin
  if edit5.text<>'' then begin
    ax:=trim(soletra(edit5.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocfamilia, frmlocfamilia);
      frmlocfamilia.auxp.text:=trim(ax);
      frmlocfamilia.showmodal;
      edit5.Text:=frmlocfamilia.ocod.text;
      edit5.setfocus;
      frmlocfamilia.Free;
    end else begin

      x:=voltainfo('familia','descricao|endereco|bairro|cep|cidade|estado','codigo='+#39+edit5.Text+#39,'T|T|T|T|T|T','0');
      edit6.Text:=voltacod(x,'|',0);
      edendereco.Caption:='Endereço: '+voltacod(x,'|',1);
      edbairro.Caption:='Bairro: '+voltacod(x,'|',2);
      edcep.Caption:='CEP: '+voltacod(x,'|',3);
      edcidade.Caption:='Cidade: '+voltacod(x,'|',4);
      edestado.Caption:='Estado: '+voltacod(x,'|',5);
      if (trim(edit6.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit5.setfocus;
        edendereco.Caption:='Endereço:';
        edbairro.Caption:='Bairro:';
        edcep.Caption:='CEP:';
        edcidade.Caption:='Cidade:';
        edestado.Caption:='Estado:';
      end;
    end;
  end;
end;

procedure Tfrmcadaluno.Edit8Exit(Sender: TObject);
var
  ax:string;
begin
  if edit8.text<>'' then begin
    ax:=trim(soletra(edit8.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocprofissao, frmlocprofissao);
      frmlocprofissao.auxp.text:=trim(ax);
      frmlocprofissao.showmodal;
      edit8.Text:=frmlocprofissao.ocod.text;
      edit8.setfocus;
      frmlocprofissao.Free;
    end else begin
      edit7.Text:=voltainfo('profissao','descricao','codigo='+#39+edit8.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(edit7.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit8.setfocus;
      end;
    end;
  end;
end;

procedure Tfrmcadaluno.Edit10Exit(Sender: TObject);
var
  ax:string;
begin
  if edit10.text<>'' then begin
    ax:=trim(soletra(edit10.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocclasse, frmlocclasse);
      frmlocclasse.auxp.text:=trim(ax);
      frmlocclasse.showmodal;
      edit10.Text:=frmlocclasse.ocod.text;
      edit10.setfocus;
      frmlocclasse.Free;
    end else begin
      edit11.Text:=voltainfo('classe','descricao','codigo='+#39+edit10.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(edit11.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit10.setfocus;
      end;
    end;
  end;
end;

procedure Tfrmcadaluno.BitBtn6Click(Sender: TObject);
var
  x:string;
begin
  if (data10.myfuncao.RecordCount>0) then begin
    if (application.MessageBox('Deseja Cargo-Função do Membro?','Atenção',mb_yesno)<>id_no) then begin
      x:='delete from membro_funcao where codigo='+#39+data10.myfuncao.fieldbyname('codigo').asstring+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;
      data10.myfuncao.close;
      data10.myfuncao.open;
    end;
  end;
end;

procedure Tfrmcadaluno.p4Show(Sender: TObject);
var
  x:string;
begin
  with data10.myfuncao do begin
    close;
    sql.clear;
    x:='select a.codigo, b.descricao from membro_funcao a left join cargo b on a.cargo=b.codigo';
    x:=x+' where (';
    x:=x+' (a.membro='+#39+edit1.Text+#39+')';
    x:=x+')';
    x:=x+' order by b.descricao';
    sql.add(x);
    open;
  end;
end;

procedure Tfrmcadaluno.BitBtn5Click(Sender: TObject);
var
  x:string;
  a:integer;
begin
  bitbtn5.Tag:=0;
  a:=0;
  if ((trim(edit1.Text)='') or (trim(edit1.Text)='0')) then begin
    x:='O Cadastro deve ser Gravado antes da inclusão'+#13;
    x:=x+'Deseja Gravar Agora?';
    if application.MessageBox(pchar(x),'Atenção',mb_yesno)<>id_no then begin
      bitbtn5.Tag:=10;
      bitbtn1.Click;
      bitbtn5.Tag:=0;
    end else begin
      bitbtn5.Tag:=0;
      a:=1;
    end;
  end;
  if (a=0) then begin
    Application.CreateForm(Tfrmligacargo, frmligacargo);
    frmligacargo.cdmembro.Text:=edit1.Text;
    frmligacargo.showmodal;
    frmligacargo.free;
    data10.myfuncao.close;
    data10.myfuncao.open;
  end;
end;

end.
