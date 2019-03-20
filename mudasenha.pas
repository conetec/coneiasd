unit mudasenha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, funcoes, funcaolocal;

type
  Tfrmmudasenha = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Enter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmmudasenha: Tfrmmudasenha;
  asenha:string;

implementation

uses principal, datamodule10;

{$R *.dfm}

procedure Tfrmmudasenha.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmmudasenha.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmmudasenha.FormActivate(Sender: TObject);
begin
  edit1.Text:=frmprincipal.Configura[2];
  asenha:=voltainfo('nupass','senha','codigo='+#39+frmprincipal.Configura[1]+#39,'T','0');
end;

procedure Tfrmmudasenha.BitBtn1Click(Sender: TObject);
var
   a:integer;
   x:string;
begin

  a:=0;

  if ((trim(edit2.text)='') and (a=0)) then begin a:=1; application.MessageBox('Campo Obrigatório','Atenção',mb_ok); edit2.SetFocus; end;
  if ((trim(edit3.text)='') and (a=0)) then begin a:=1; application.MessageBox('Campo Obrigatório','Atenção',mb_ok); edit3.SetFocus; end;
  if ((trim(edit4.text)='') and (a=0)) then begin a:=1; application.MessageBox('Campo Obrigatório','Atenção',mb_ok); edit4.SetFocus; end;
  if ((trim(edit2.text)<>trim(asenha)) and (a=0)) then begin a:=1; application.MessageBox('Senha Inválida','Atenção',mb_ok); edit2.SetFocus; end;
  if ((trim(edit3.text)<>trim(edit4.Text)) and (a=0)) then begin a:=1; application.MessageBox('Nova Senha diferente da Confirmação','Atenção',mb_ok); edit3.SetFocus; end;

  if (a=0) then begin
    with data10.exemysql do begin
     sql.clear;
     x:='UPDATE nupass SET ';
     x:=x+'senha='+#39+trim(edit3.text)+#39;
     x:=x+' where codigo='+#39+frmprincipal.Configura[1]+#39;
     sql.add(x);
     ExecSql;
    end;
    application.MessageBox('Senha Alterada com Sucesso!','Atenção',mb_ok);
    frmmudasenha.close;
  end;

end;

procedure Tfrmmudasenha.BitBtn2Click(Sender: TObject);
begin
  frmmudasenha.close;
end;

end.
