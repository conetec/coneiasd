unit solicitaja;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, JvExMask,
  JvToolEdit, Menus, CheckLst ;

type
  Tfrmsolicitaja = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    codcad: TEdit;
    adataID: TEdit;
    ahoraID: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    dtcad: TJvDateEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label17: TLabel;
    PopupMenu1: TPopupMenu;
    CadastrarFamilia1: TMenuItem;
    ProcurarFamlia1: TMenuItem;
    sair1: TMenuItem;
    GroupBox2: TGroupBox;
    r3: TRadioButton;
    r4: TRadioButton;
    GroupBox3: TGroupBox;
    osolicita: TCheckListBox;
    Label6: TLabel;
    acopia: TMemo;
    Memo1: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure limpar;
    procedure Edit1Enter(Sender: TObject);
    procedure CadastrarFamilia1Click(Sender: TObject);
    procedure ProcurarFamlia1Click(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure r3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmsolicitaja: Tfrmsolicitaja;
  uamigo:string;

implementation

uses datamodule10, principal, cadamigo, locamigo, locmembro, cadmembro;

{$R *.DFM}

procedure Tfrmsolicitaja.limpar;
var
  i:integer;
begin
  edit1.Text:='0';
  dtcad.Text:=formatdatetime('dd/mm/yyyy',date);
  edit5.text:='';
  edit6.Text:='';
  r4.Checked:=true;
  for i:=0 to frmsolicitaja.osolicita.Items.Count-1 do begin
    frmsolicitaja.osolicita.Checked[i]:=false;
  end;
  memo1.lines.Clear;
  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);
end;

procedure Tfrmsolicitaja.FormActivate(Sender: TObject);
begin
  frmsolicitaja.caption:='Solicitação de Membros e Amigos';
  limpar;
  edit1.SetFocus;
end;

procedure Tfrmsolicitaja.BitBtn2Click(Sender: TObject);
begin
  frmsolicitaja.close;
end;

procedure Tfrmsolicitaja.BitBtn1Click(Sender: TObject);
var
  x,sl,a1,a2,xadv:string;
  a,i:integer;
begin
  if r3.Checked=true then begin
    xadv:='M';
  end else begin
    xadv:='V';
  end;

  frmprincipal.c_agora;
  a:=0;
  if (trim(dtcad.text)='/  /') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; dtcad.setfocus; end;
  if (edit5.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit5.setfocus; end;

  if (a=0) then begin
    sl:='N';
    for i:=0 to osolicita.Items.Count-1 do begin
      if osolicita.Checked[i]=true then begin
        sl:='S';
        break;
      end;
    end;
  end;

  if (sl='N') and (a=0) then begin application.MessageBox('Nada foi Solicitado!','Atenção',mb_ok); a:=1; osolicita.setfocus; end;

  if (a=0) then begin

    frmprincipal.c_agora;
    for i:=0 to osolicita.Items.Count-1 do begin
      if osolicita.Checked[i]=true then begin
        with data10.exemysql do begin
          sql.clear;
          x:='INSERT INTO visita_solicita ';
          x:=x+'(codigo, igreja, datamov, tipo, amigo, solicitacao, observacao, resposta) ';
          x:=x+'VALUES (NULL,';                           // codigo
          x:=x+#39+frmprincipal.Configura[3]+#39+',';     // igreja
          x:=x+#39+mydata(dtcad.text)+#39+',';            // datamov
          x:=x+#39+xadv+#39+',';                          // tipo
          x:=x+#39+edit5.text+#39+',';                    // amigo
          x:=x+#39+trim(acopia.Lines[i])+#39+',';         // solicitacao
          x:=x+#39+trim(memo1.text)+#39+',';              // observacao
          x:=x+#39+'N'+#39;                               // resposta
          x:=x+')';
          sql.add(x);
          ExecSql;
        end;
      end;
    end;

    limpar;
    edit1.SetFocus;
  end;


end;

procedure Tfrmsolicitaja.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmsolicitaja.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmsolicitaja.CadastrarFamilia1Click(Sender: TObject);
begin
  if r4.Checked=true then begin
    Application.CreateForm(Tfrmcadamigo, frmcadamigo);
    frmcadamigo.tag:=3;
    frmcadamigo.showmodal;
    edit5.Text:=frmcadamigo.codcad.Text;
    frmcadamigo.Free;
    edit5.setfocus;
  end else begin
    Application.CreateForm(Tfrmcadmembro, frmcadmembro);
    frmcadmembro.tag:=3;
    frmcadmembro.showmodal;
    edit5.Text:=frmcadmembro.codcad.Text;
    frmcadmembro.Free;
    edit5.setfocus;
  end;
end;

procedure Tfrmsolicitaja.ProcurarFamlia1Click(Sender: TObject);
begin
  if r4.Checked=true then begin
    application.CreateForm(Tfrmlocamigo, frmlocamigo);
    frmlocamigo.showmodal;
    edit5.Text:=frmlocamigo.ocod.text;
    edit5.setfocus;
    frmlocamigo.Free;
  end else begin
    application.CreateForm(Tfrmlocmembro, frmlocmembro);
    frmlocmembro.showmodal;
    edit5.Text:=frmlocmembro.ocod.text;
    edit5.setfocus;
    frmlocmembro.Free;
  end;
end;

procedure Tfrmsolicitaja.Edit5Exit(Sender: TObject);
var
  ax:string;
begin
  if r4.Checked=true then begin
    if edit5.text<>'' then begin
      ax:=trim(soletra(edit5.text));
      if trim(ax)<>'' then begin
        application.CreateForm(Tfrmlocamigo, frmlocamigo);
        frmlocamigo.auxp.text:=trim(ax);
        frmlocamigo.showmodal;
        edit5.Text:=frmlocamigo.ocod.text;
        edit5.setfocus;
        frmlocamigo.Free;
      end else begin
        edit6.Text:=voltainfo('amigo','nome','codigo='+#39+edit5.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
        if (trim(edit6.Text)='') then begin
          application.MessageBox('Código não encontrado','Atenção',mb_ok);
          edit5.setfocus;
        end;
      end;
    end;
  end else begin
    if edit5.text<>'' then begin
      ax:=trim(soletra(edit5.text));
      if trim(ax)<>'' then begin
        application.CreateForm(Tfrmlocmembro, frmlocmembro);
        frmlocmembro.auxp.text:=trim(ax);
        frmlocmembro.showmodal;
        edit5.Text:=frmlocmembro.ocod.text;
        edit5.setfocus;
        frmlocmembro.Free;
      end else begin
        edit6.Text:=voltainfo('membro','nome','codigo='+#39+edit5.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
        if (trim(edit6.Text)='') then begin
          application.MessageBox('Código não encontrado','Atenção',mb_ok);
          edit5.setfocus;
        end;
      end;
    end;
  end;
end;


procedure Tfrmsolicitaja.r3Click(Sender: TObject);
begin
  edit5.text:='';
  edit6.Text:='';
  edit5.setfocus;
end;

procedure Tfrmsolicitaja.FormShow(Sender: TObject);
var
  x:string;
begin
  frmprincipal.c_agora;
  osolicita.items.Clear;
  acopia.lines.Clear;
  with data10.myaux10 do begin
    close;
    sql.clear;
    x:='select solicitacao.codigo,solicitacao.descricao from solicitacao';
    x:=x+' where (';
    x:=x+' (igreja='+#39+frmprincipal.Configura[3]+#39+')';
    x:=x+' and (ativo='+#39+'S'+#39+')';
    x:=x+')';
    x:=x+' order by solicitacao.codigo';
    sql.add(x);
    open;
    first;
    while eof=false do begin
      osolicita.Items.Add(fieldbyname('descricao').asstring);
      osolicita.Checked[osolicita.Items.Count-1]:=false;
      acopia.lines.add(fieldbyname('codigo').asstring);
      next;
    end;
  end;

end;

end.
