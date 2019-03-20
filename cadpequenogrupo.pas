unit cadpequenogrupo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, JvExMask,
  JvToolEdit, Menus ;

type
  Tfrmcadpequenogrupo = class(TForm)
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
    dtinicio: TJvDateEdit;
    GroupBox1: TGroupBox;
    d1: TCheckBox;
    d2: TCheckBox;
    d3: TCheckBox;
    d4: TCheckBox;
    d5: TCheckBox;
    d6: TCheckBox;
    d7: TCheckBox;
    Label7: TLabel;
    Edit3: TEdit;
    Memo1: TMemo;
    Label8: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    cdmembro: TEdit;
    nmmembro: TEdit;
    ppmembro: TPopupMenu;
    CadastrarClassedeEscolaSabatina1: TMenuItem;
    LocalizarClasseES1: TMenuItem;
    Sair3: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure limpar;
    procedure mostrar;
    procedure Edit1Enter(Sender: TObject);
    procedure cdmembroExit(Sender: TObject);
    procedure CadastrarClassedeEscolaSabatina1Click(Sender: TObject);
    procedure LocalizarClasseES1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadpequenogrupo: Tfrmcadpequenogrupo;

implementation

uses datamodule10, principal, locmembro, cadmembro;

{$R *.DFM}

procedure Tfrmcadpequenogrupo.limpar;
begin
  edit1.Text:='0';
  combobox1.ItemIndex:=0;
  dtinicio.Text:=formatdatetime('dd/mm/yyyy',date);
  cdmembro.text:='';
  nmmembro.text:='';
  edit4.Text:='';
  edit2.Text:='';
  edit3.Text:='';
  d1.Checked:=false;
  d2.Checked:=false;
  d3.Checked:=false;
  d4.Checked:=false;
  d5.Checked:=false;
  d6.Checked:=false;
  d7.Checked:=false;
  memo1.lines.clear;

  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);
end;


procedure Tfrmcadpequenogrupo.mostrar;
var
  i:integer;
begin
  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  dtinicio.Text:=data10.mymostra.fieldbyname('datainicio').asstring;
  cdmembro.Text:=data10.mymostra.fieldbyname('membro').asstring;
  nmmembro.Text:=voltainfo('membro','nome','codigo='+#39+cdmembro.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
  edit4.Text:=data10.mymostra.fieldbyname('descricao').asstring;
  edit2.text:=data10.mymostra.fieldbyname('endereco').asstring;
  edit3.text:=data10.mymostra.fieldbyname('horario').asstring;
  if data10.mymostra.fieldbyname('dom').value=1 then begin d1.Checked:=true; end else begin d1.Checked:=false; end;
  if data10.mymostra.fieldbyname('seg').value=1 then begin d2.Checked:=true; end else begin d2.Checked:=false; end;
  if data10.mymostra.fieldbyname('ter').value=1 then begin d3.Checked:=true; end else begin d3.Checked:=false; end;
  if data10.mymostra.fieldbyname('qua').value=1 then begin d4.Checked:=true; end else begin d4.Checked:=false; end;
  if data10.mymostra.fieldbyname('qui').value=1 then begin d5.Checked:=true; end else begin d5.Checked:=false; end;
  if data10.mymostra.fieldbyname('sex').value=1 then begin d6.Checked:=true; end else begin d6.Checked:=false; end;
  if data10.mymostra.fieldbyname('sab').value=1 then begin d7.Checked:=true; end else begin d7.Checked:=false; end;

  memo1.lines.clear;
  memo1.lines.add(data10.mymostra.fieldbyname('observacoes').value);
  memo1.Text:=trim(memo1.text);


  combobox1.ItemIndex:=-1;
  for i:=0 to combobox1.Items.Count-1 do begin
    if copy(combobox1.Items[i],1,1)=data10.mymostra.fieldbyname('ativo').asstring then begin
      combobox1.ItemIndex:=i;
      break;
    end;
  end;

end;


procedure Tfrmcadpequenogrupo.FormActivate(Sender: TObject);
begin
  if (frmcadpequenogrupo.tag=1) or (frmcadpequenogrupo.tag=3) then begin
    frmcadpequenogrupo.caption:='Inclusão de Pequeno Grupo';
    limpar;
    edit1.SetFocus;
  end;
  if frmcadpequenogrupo.tag=2 then begin
    frmcadpequenogrupo.caption:='Alteração de Pequeno Grupo';
    limpar;
    mostrar;
    edit1.SetFocus;
  end;
end;

procedure Tfrmcadpequenogrupo.BitBtn2Click(Sender: TObject);
begin
  frmcadpequenogrupo.close;
end;

procedure Tfrmcadpequenogrupo.BitBtn1Click(Sender: TObject);
var
  x,xd1,xd2,xd3,xd4,xd5,xd6,xd7,dd:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  xd1:='0'; xd2:='0'; xd3:='0'; xd4:='0'; xd5:='0'; xd6:='0'; xd7:='0';
  dd:='';
  if d1.Checked=true then begin xd1:='1'; dd:=dd+' Domingo'; end;
  if d2.Checked=true then begin xd2:='1'; dd:=dd+' Segunda'; end;
  if d3.Checked=true then begin xd3:='1'; dd:=dd+' Terça'; end;
  if d4.Checked=true then begin xd4:='1'; dd:=dd+' Quarta'; end;
  if d5.Checked=true then begin xd5:='1'; dd:=dd+' Quinta'; end;
  if d6.Checked=true then begin xd6:='1'; dd:=dd+' Sexta'; end;
  if d7.Checked=true then begin xd7:='1'; dd:=dd+' Sábado'; end;
  dd:=trim(dd);

  if (cdmembro.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; cdmembro.setfocus; end;
  if (edit4.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit4.setfocus; end;



  if ((frmcadpequenogrupo.tag=1) or (frmcadpequenogrupo.tag=3)) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO pequenogrupo ';
      x:=x+'(codigo, ativo, datainicio, igreja, membro, descricao, endereco, descricaodia, dom, seg, ter, qua, qui, sex, sab, horario, observacoes, dataid, horaid, id) ';
      x:=x+'VALUES (NULL,';                                                     // codigo
      x:=x+#39+copy(combobox1.Text,1,1)+#39+',';                                // ativo
      x:=x+#39+mydata(dtinicio.Text)+#39+',';                                   // datainicio
      x:=x+#39+frmprincipal.Configura[3]+#39+',';                               // igreja
      x:=x+#39+cdmembro.text+#39+',';                                           // membro
      x:=x+#39+edit4.text+#39+',';                                              // descricao
      x:=x+#39+edit2.text+#39+',';                                              // endereco
      x:=x+#39+dd+#39+',';                                                      // descricaodia
      x:=x+#39+xd1+#39+',';                                                     // dom
      x:=x+#39+xd2+#39+',';                                                     // seg
      x:=x+#39+xd3+#39+',';                                                     // ter
      x:=x+#39+xd4+#39+',';                                                     // qua
      x:=x+#39+xd5+#39+',';                                                     // qui
      x:=x+#39+xd6+#39+',';                                                     // sex
      x:=x+#39+xd7+#39+',';                                                     // sab
      x:=x+#39+edit3.text+#39+',';                                              // horario
      x:=x+#39+trim(memo1.text)+#39+',';                                        // observacoes
      x:=x+#39+mydata(adataid.text)+#39+',';                                    // dataid
      x:=x+#39+ahoraid.text+#39+',';                                            // horaid
      x:=x+#39+frmprincipal.Configura[1]+#39;                                   // id
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    if (frmcadpequenogrupo.tag=1) then begin
      limpar;
      edit1.SetFocus;
    end;
    if (frmcadpequenogrupo.tag=3) then begin
      codcad.text:=voltauc('pequenogrupo','codigo','membro='+cdmembro.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
      frmcadpequenogrupo.close;
    end;
  end;

  if (frmcadpequenogrupo.tag=2) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE pequenogrupo SET ';
      x:=x+'ativo='+#39+copy(combobox1.Text,1,1)+#39+',';                              // ativo
      x:=x+'datainicio='+#39+mydata(dtinicio.Text)+#39+',';                            // datainicio
      x:=x+'membro='+#39+cdmembro.text+#39+',';                                        // membro
      x:=x+'descricao='+#39+edit4.text+#39+',';                                        // descricao
      x:=x+'endereco='+#39+edit2.text+#39+',';                                         // endereco
      x:=x+'descricaodia='+#39+dd+#39+',';                                             // descricaodia
      x:=x+'dom='+#39+xd1+#39+',';                                                     // dom
      x:=x+'seg='+#39+xd2+#39+',';                                                     // seg
      x:=x+'ter='+#39+xd3+#39+',';                                                     // ter
      x:=x+'qua='+#39+xd4+#39+',';                                                     // qua
      x:=x+'qui='+#39+xd5+#39+',';                                                     // qui
      x:=x+'sex='+#39+xd6+#39+',';                                                     // sex
      x:=x+'sab='+#39+xd7+#39+',';                                                     // sab
      x:=x+'horario='+#39+edit3.text+#39+',';                                          // horario
      x:=x+'observacoes='+#39+trim(memo1.text)+#39;                                    // observacoes
      x:=x+' where codigo='+#39+edit1.text+#39;
      sql.add(x);
      ExecSql;
    end;
    frmcadpequenogrupo.close;
  end;

end;

procedure Tfrmcadpequenogrupo.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadpequenogrupo.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcadpequenogrupo.cdmembroExit(Sender: TObject);
var
  ax:string;
begin
  if cdmembro.text<>'' then begin
    ax:=trim(soletra(cdmembro.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocmembro, frmlocmembro);
      frmlocmembro.auxp.text:=trim(ax);
      frmlocmembro.showmodal;
      cdmembro.Text:=frmlocmembro.ocod.text;
      cdmembro.setfocus;
      frmlocmembro.Free;
    end else begin
      nmmembro.Text:=voltainfo('membro','nome','codigo='+#39+cdmembro.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(nmmembro.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        cdmembro.setfocus;
      end;
    end;
  end;
end;

procedure Tfrmcadpequenogrupo.CadastrarClassedeEscolaSabatina1Click(
  Sender: TObject);
begin
  Application.CreateForm(Tfrmcadmembro, frmcadmembro);
  frmcadmembro.tag:=3;
  frmcadmembro.showmodal;
  cdmembro.Text:=frmcadmembro.codcad.Text;
  frmcadmembro.Free;
  cdmembro.setfocus;
end;

procedure Tfrmcadpequenogrupo.LocalizarClasseES1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocmembro, frmlocmembro);
  frmlocmembro.showmodal;
  cdmembro.Text:=frmlocmembro.ocod.text;
  cdmembro.setfocus;
  frmlocmembro.Free;
end;

end.
