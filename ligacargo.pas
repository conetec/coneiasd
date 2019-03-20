unit ligacargo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, Menus ;

type
  Tfrmligacargo = class(TForm)
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
    cdmembro: TEdit;
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
  frmligacargo: Tfrmligacargo;

implementation

uses datamodule10, principal, cadmembro, cadcargo, loccargo;

{$R *.DFM}

procedure Tfrmligacargo.FormActivate(Sender: TObject);
begin
  frmligacargo.caption:='Associa Cargo-Função a Membro';
  edit10.SetFocus;
end;

procedure Tfrmligacargo.BitBtn2Click(Sender: TObject);
begin
  frmligacargo.close;
end;

procedure Tfrmligacargo.BitBtn1Click(Sender: TObject);
var
  x:string;
  a:integer;
begin
  a:=0;
  if (edit10.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit10.setfocus; end;

  if (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO membro_funcao ';
      x:=x+'(codigo, membro, cargo) ';
      x:=x+'VALUES (NULL,';                                // codigo
      x:=x+#39+cdmembro.Text+#39+',';                      // membro
      x:=x+#39+edit10.Text+#39;                            // cargo
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    frmligacargo.close;
  end;

end;

procedure Tfrmligacargo.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmligacargo.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmligacargo.CadastrarClassedeEscolaSabatina1Click(
  Sender: TObject);
begin
  Application.CreateForm(Tfrmcadcargo, frmcadcargo);
  frmcadcargo.tag:=3;
  frmcadcargo.showmodal;
  edit10.Text:=frmcadcargo.codcad.Text;
  frmcadcargo.Free;
  edit10.setfocus;
end;

procedure Tfrmligacargo.LocalizarClasseES1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmloccargo, frmloccargo);
  frmloccargo.showmodal;
  edit10.Text:=frmloccargo.ocod.text;
  edit10.setfocus;
  frmloccargo.Free;
end;

procedure Tfrmligacargo.Edit10Exit(Sender: TObject);
var
  ax:string;
begin
  if edit10.text<>'' then begin
    ax:=trim(soletra(edit10.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmloccargo, frmloccargo);
      frmloccargo.auxp.text:=trim(ax);
      frmloccargo.showmodal;
      edit10.Text:=frmloccargo.ocod.text;
      edit10.setfocus;
      frmloccargo.Free;
    end else begin
      edit11.Text:=voltainfo('cargo','descricao','codigo='+#39+edit10.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(edit11.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit10.setfocus;
      end;
    end;
  end;
end;

end.
