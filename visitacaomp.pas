unit visitacaomp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, JvExMask,
  JvToolEdit, Menus, CheckLst ;

type
  Tfrmvisitacaomp = class(TForm)
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
    Label6: TLabel;
    Memo1: TMemo;
    Label7: TLabel;
    Label8: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
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
    procedure Edit3Exit(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmvisitacaomp: Tfrmvisitacaomp;
  uamigo:string;

implementation

uses datamodule10, principal, cadamigo, locamigo, locmembro, cadmembro;

{$R *.DFM}

procedure Tfrmvisitacaomp.limpar;
var
  i:integer;
begin
  edit1.Text:='0';
  dtcad.Text:=formatdatetime('dd/mm/yyyy',date);
  edit5.text:='';
  edit6.Text:='';
  edit3.text:='';
  edit4.Text:='';
  r4.Checked:=true;
  memo1.lines.Clear;
  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);
end;

procedure Tfrmvisitacaomp.FormActivate(Sender: TObject);
begin
  frmvisitacaomp.caption:='Visita à Membros e Amigos';
  limpar;
  edit1.SetFocus;
end;

procedure Tfrmvisitacaomp.BitBtn2Click(Sender: TObject);
begin
  frmvisitacaomp.close;
end;

procedure Tfrmvisitacaomp.BitBtn1Click(Sender: TObject);
var
  x,sl,a1,a2,xadv,xquem:string;
  a,i:integer;
begin
  if r3.Checked=true then begin
    xadv:='M';
  end else begin
    xadv:='V';
  end;

  if frmvisitacaomp.tag=1 then begin
    xquem:='P';
  end else begin
    xquem:='M';
  end;

  frmprincipal.c_agora;
  a:=0;
  if (trim(dtcad.text)='/  /') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; dtcad.setfocus; end;
  if (edit5.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit5.setfocus; end;
  if (edit3.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit5.setfocus; end;

  if (a=0) then begin

    frmprincipal.c_agora;
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO visitacaomp ';
      x:=x+'(codigo, igreja, datamov, tipo, codtipo, tipoquem, codquem, observacao) ';
      x:=x+'VALUES (NULL,';                           // codigo
      x:=x+#39+frmprincipal.Configura[3]+#39+',';     // igreja
      x:=x+#39+mydata(dtcad.text)+#39+',';            // datamov
      x:=x+#39+xadv+#39+',';                          // tipo
      x:=x+#39+edit5.text+#39+',';                    // codtipo
      x:=x+#39+xquem+#39+',';                         // tipoquem
      x:=x+#39+edit3.text+#39+',';                    // codquem
      x:=x+#39+trim(memo1.text)+#39;                  // observacao
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    application.MessageBox('Visita Registrada','Atenção',mb_ok);
    limpar;
    edit1.SetFocus;
  end;


end;

procedure Tfrmvisitacaomp.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmvisitacaomp.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmvisitacaomp.CadastrarFamilia1Click(Sender: TObject);
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

procedure Tfrmvisitacaomp.ProcurarFamlia1Click(Sender: TObject);
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

procedure Tfrmvisitacaomp.Edit5Exit(Sender: TObject);
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


procedure Tfrmvisitacaomp.r3Click(Sender: TObject);
begin
  edit5.text:='';
  edit6.Text:='';
  edit5.setfocus;
end;

procedure Tfrmvisitacaomp.FormShow(Sender: TObject);
begin
  frmprincipal.c_agora;
end;

procedure Tfrmvisitacaomp.Edit3Exit(Sender: TObject);
var
  ax:string;
begin
  if edit3.text<>'' then begin
    ax:=trim(soletra(edit3.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocmembro, frmlocmembro);
      frmlocmembro.auxp.text:=trim(ax);
      frmlocmembro.showmodal;
      edit3.Text:=frmlocmembro.ocod.text;
      edit3.setfocus;
      frmlocmembro.Free;
    end else begin
      edit4.Text:=voltainfo('membro','nome','codigo='+#39+edit3.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(edit4.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit3.setfocus;
      end;
    end;
  end;
end;

procedure Tfrmvisitacaomp.MenuItem1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcadmembro, frmcadmembro);
  frmcadmembro.tag:=3;
  frmcadmembro.showmodal;
  edit3.Text:=frmcadmembro.codcad.Text;
  frmcadmembro.Free;
  edit3.setfocus;
end;

procedure Tfrmvisitacaomp.MenuItem2Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocmembro, frmlocmembro);
  frmlocmembro.showmodal;
  edit3.Text:=frmlocmembro.ocod.text;
  edit3.setfocus;
  frmlocmembro.Free;
end;

end.
