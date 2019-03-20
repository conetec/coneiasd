unit cadmembro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, ExtCtrls, Menus, ComCtrls,
  JvExMask, JvToolEdit, funcaolocal, Grids, DBGrids, jpeg;

type
  Tfrmcadmembro = class(TForm)
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
    DBGrid1: TDBGrid;
    Label2: TLabel;
    TabSheet1: TTabSheet;
    BitBtn3: TBitBtn;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Label3: TLabel;
    eativo: TComboBox;
    Label18: TLabel;
    ComboBox4: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure CadastrarFamilia1Click(Sender: TObject);
    procedure CadastrarProfisso1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
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
    procedure p2Show(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadmembro: Tfrmcadmembro;
  ultnome,gravar:string;

implementation

uses datamodule10, membro, principal, cadfamilia, cadprofissao, captura,
  cadclasse, locfamilia, locprofissao, locclasse, ligacargo, editaimg,
  testes, captura01;


{$R *.DFM}


procedure Tfrmcadmembro.limpar;
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

  image1.Picture:=nil;
  narq:=ExtractFilePath(ParamStr(0));
  narq:=narq+'\limpo.jpg';
  if fileexists(narq) then begin
    image1.Picture.LoadFromFile(narq);
  end;

end;


procedure Tfrmcadmembro.mostrar;
var
  i:integer;
  narq:string;
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
  edit6.Text:=voltainfo('familia','descricao','codigo='+#39+edit5.Text+#39,'T','0');

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

  memo1.Lines.clear;
  memo1.lines.add(data10.mymostra.fieldbyname('observacoes').value);
  memo1.Text:=trim(memo1.Text);

  with data10.myfoto do begin
    close;
    sql.clear;
    sql.add('select codigo,imagem from fotos where ((cod_tipo='+#39+edit1.text+#39+') and (tipo='+#39+'1'+#39+')) limit 0,1');
    open;
    if recordcount=1 then begin
      frmprincipal.ExibeFoto(data10.myfoto,'imagem',image1);
    end else begin
      image1.Picture:=nil;
      narq:=ExtractFilePath(ParamStr(0));
      narq:=narq+'\limpo.jpg';
      if fileexists(narq) then begin
        image1.Picture.LoadFromFile(narq);
      end;
    end;
  end;

end;


procedure Tfrmcadmembro.FormActivate(Sender: TObject);
begin
  if (frmcadmembro.tag=1) or (frmcadmembro.tag=3) then begin
    frmcadmembro.caption:='Inclusão de Membro';
    limpar();
    p1.Show;
    edit1.SetFocus;
  end;
  if frmcadmembro.tag=2 then begin
    frmcadmembro.caption:='Alteração de Membro';
    limpar;
    mostrar;
    p1.Show;
    edit1.SetFocus;
  end;
end;

procedure Tfrmcadmembro.BitBtn2Click(Sender: TObject);
begin
  frmcadmembro.close;
end;

procedure Tfrmcadmembro.BitBtn1Click(Sender: TObject);
var
  x,narq:string;
  a:integer;
begin
  bitbtn1.Enabled:=false;
  frmprincipal.c_agora;
  a:=0;
  if (edit4.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','Atenção',mb_ok); a:=1; p1.Show; edit4.setfocus; end;
  if (edit5.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','Atenção',mb_ok); a:=1; p1.Show; edit5.setfocus; end;

  if (a=0) then begin

    if ((frmcadmembro.tag=1) or (frmcadmembro.tag=3)) then begin
      if ((trim(edit1.text)='0') or (trim(edit1.text)='')) then begin
        with data10.exemysql do begin
          sql.clear;
          x:='INSERT INTO membro ';
          x:=x+'(codigo, ativo, instrutor, igreja ,nome, nascimento, familia, estadocivil, celular, comercial, email, profissao, batizado, databatismo, carta, observacoes, sexo, genitor, anp, classe, dataid, horaid, id) ';
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
          codcad.text:=voltauc('membro','codigo','nome='+edit4.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
          edit1.Text:=codcad.text;
          frmprincipal.gravaFotoMembro(data10.myimgfoto,'0',edit1.text,'1',frmcadmembro.image1);
        end;
      end;
      if bitbtn5.tag<>10 then begin
        if (frmcadmembro.tag=1) then begin
          limpar;
          edit1.SetFocus;
        end;
        if (frmcadmembro.tag=3) then begin
          frmcadmembro.close;
        end;
      end;
    end;

    if (frmcadmembro.tag=2) then begin

      with data10.myfoto do begin
        close;
        sql.clear;
        sql.add('select codigo from fotos where ((cod_tipo='+#39+edit1.text+#39+') and (tipo='+#39+'1'+#39+')) limit 0,1');
        open;
        if recordcount=1 then begin
          frmprincipal.gravaFotoMembro(data10.myimgfoto,data10.myfoto.fieldbyname('codigo').asstring,edit1.text,'1',frmcadmembro.image1);
        end else begin
          frmprincipal.gravaFotoMembro(data10.myimgfoto,'0',edit1.text,'1',frmcadmembro.image1);
        end;
      end;

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE membro SET ';
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
      frmcadmembro.close;
    end;
  end;

end;

procedure Tfrmcadmembro.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadmembro.CadastrarFamilia1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcadfamilia, frmcadfamilia);
  frmcadfamilia.tag:=3;
  frmcadfamilia.showmodal;
  edit5.Text:=frmcadfamilia.codcad.Text;
  frmcadfamilia.Free;
  edit5.setfocus;
end;

procedure Tfrmcadmembro.CadastrarProfisso1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcadprofissao, frmcadprofissao);
  frmcadprofissao.tag:=3;
  frmcadprofissao.showmodal;
  edit8.Text:=frmcadprofissao.codcad.Text;
  frmcadprofissao.Free;
  edit8.setfocus;
end;

procedure Tfrmcadmembro.BitBtn3Click(Sender: TObject);
var
  oJPEG : TJPEGImage;
begin
  Application.CreateForm(Tfrmcaptura01,frmcaptura01);
  Application.CreateForm(Tfrmeditaimg,frmeditaimg);
  frmcaptura01.showmodal;
  oJPEG := TJPEGImage.Create;
  oJPEG.Assign(frmeditaimg.Image2.Picture.Graphic);
  image1.Picture:=nil;
  image1.Picture.Assign(oJpeg);
  oJpeg.Free;
  frmcaptura01.free;
  frmeditaimg.Free;
end;

procedure Tfrmcadmembro.CadastrarClassedeEscolaSabatina1Click(
  Sender: TObject);
begin
  Application.CreateForm(Tfrmcadclasse, frmcadclasse);
  frmcadclasse.tag:=3;
  frmcadclasse.showmodal;
  edit10.Text:=frmcadclasse.codcad.Text;
  frmcadclasse.Free;
  edit10.setfocus;
end;

procedure Tfrmcadmembro.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcadmembro.ProcurarFamlia1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocfamilia, frmlocfamilia);
  frmlocfamilia.showmodal;
  edit5.Text:=frmlocfamilia.ocod.text;
  edit5.setfocus;
  frmlocfamilia.Free;
end;

procedure Tfrmcadmembro.LocalizarProfisso1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocprofissao, frmlocprofissao);
  frmlocprofissao.showmodal;
  edit8.Text:=frmlocprofissao.ocod.text;
  edit8.setfocus;
  frmlocprofissao.Free;
end;

procedure Tfrmcadmembro.LocalizarClasseES1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocclasse, frmlocclasse);
  frmlocclasse.showmodal;
  edit10.Text:=frmlocclasse.ocod.text;
  edit10.setfocus;
  frmlocclasse.Free;
end;

procedure Tfrmcadmembro.Edit5Exit(Sender: TObject);
var
  ax:string;
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
      edit6.Text:=voltainfo('familia','descricao','codigo='+#39+edit5.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(edit6.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit5.setfocus;
      end;
    end;
  end;
end;

procedure Tfrmcadmembro.Edit8Exit(Sender: TObject);
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

procedure Tfrmcadmembro.Edit10Exit(Sender: TObject);
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

procedure Tfrmcadmembro.BitBtn6Click(Sender: TObject);
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

procedure Tfrmcadmembro.p4Show(Sender: TObject);
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

procedure Tfrmcadmembro.BitBtn5Click(Sender: TObject);
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

procedure Tfrmcadmembro.p2Show(Sender: TObject);
var
  x:string;
begin
  with data10.mypresente do begin
    close;
    sql.clear;
    x:='select a.presenca, b.datamov from lista_es a left join chamada_es b on a.chamada=b.codigo';
    x:=x+' where (';
    x:=x+' (a.aluno='+#39+edit1.Text+#39+')';
    x:=x+')';
    x:=x+' order by b.datamov desc limit 0,10';
    sql.add(x);
    open;
  end;

end;

end.
