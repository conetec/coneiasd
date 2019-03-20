unit contatoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, Menus,
  JvExMask, JvToolEdit ;

type
  Tfrmcontatoes = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Label21: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    Label22: TLabel;
    PopupMenu3: TPopupMenu;
    CadastrarClassedeEscolaSabatina1: TMenuItem;
    LocalizarClasseES1: TMenuItem;
    Sair3: TMenuItem;
    Label12: TLabel;
    dtmov: TJvDateEdit;
    Label13: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Memo1: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Enter(Sender: TObject);
    procedure CadastrarClassedeEscolaSabatina1Click(Sender: TObject);
    procedure LocalizarClasseES1Click(Sender: TObject);
    procedure Edit10Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcontatoes: Tfrmcontatoes;

implementation

uses datamodule10, principal, cadmembro, cadcargo, loccargo, locmembro,
  acompanhaes;

{$R *.DFM}

procedure Tfrmcontatoes.FormActivate(Sender: TObject);
begin
  frmcontatoes.caption:='Registro de Contato';
  dtmov.Text:=formatdatetime('dd/mm/yyyy',date);
  edit10.Text:='';
  edit11.Text:='';
  combobox1.ItemIndex:=0;
  memo1.lines.Clear;
  dtmov.SetFocus;
end;

procedure Tfrmcontatoes.BitBtn2Click(Sender: TObject);
begin
  frmcontatoes.close;
end;

procedure Tfrmcontatoes.BitBtn1Click(Sender: TObject);
var
  x:string;
  a:integer;
begin
  a:=0;
  if (edit10.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit10.setfocus; end;
  if (trim(dtmov.text)='/ /') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; dtmov.setfocus; end;

  if (a=0) then begin
    bitbtn1.tag:=10;

    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE lista_es SET ';
      x:=x+'contato='+#39+'S'+#39;                                            // contato
      x:=x+' where codigo='+#39+frmacompanhaes.alista.text+#39;
      sql.add(x);
      ExecSql;
    end;

    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO contato_es ';
      x:=x+'(codigo, dtcontato, lista, tp, quem, aluno, observacao) ';
      x:=x+'VALUES (NULL,';                                // codigo
      x:=x+#39+mydata(dtmov.Text)+#39+',';                 // dtcontato
      x:=x+#39+frmacompanhaes.alista.text+#39+',';         // lista
      x:=x+#39+combobox1.text+#39+',';                     // tp
      x:=x+#39+edit10.text+#39+',';                        // quem
      x:=x+#39+voltacod(frmacompanhaes.lista.Cells[2,frmacompanhaes.lista.Row],'-',0)+#39+',';  // aluno
      x:=x+#39+trim(memo1.Text)+#39;                       // observacao
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;


    frmcontatoes.close;
  end;

end;

procedure Tfrmcontatoes.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcontatoes.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcontatoes.CadastrarClassedeEscolaSabatina1Click(
  Sender: TObject);
begin
  Application.CreateForm(Tfrmcadmembro, frmcadmembro);
  frmcadmembro.tag:=3;
  frmcadmembro.showmodal;
  edit10.Text:=frmcadmembro.codcad.Text;
  frmcadmembro.Free;
  edit10.setfocus;
end;

procedure Tfrmcontatoes.LocalizarClasseES1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocmembro, frmlocmembro);
  frmlocmembro.showmodal;
  edit10.Text:=frmlocmembro.ocod.text;
  edit10.setfocus;
  frmlocmembro.Free;
end;

procedure Tfrmcontatoes.Edit10Exit(Sender: TObject);
var
  ax:string;
begin
  if edit10.text<>'' then begin
    ax:=trim(soletra(edit10.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocmembro, frmlocmembro);
      frmlocmembro.auxp.text:=trim(ax);
      frmlocmembro.showmodal;
      edit10.Text:=frmlocmembro.ocod.text;
      edit10.setfocus;
      frmlocmembro.Free;
    end else begin
      edit11.Text:=voltainfo('membro','nome','codigo='+#39+edit10.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(edit11.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit10.setfocus;
      end;
    end;
  end;
end;

end.
