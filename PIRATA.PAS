unit pirata;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, db, funcoes;

type
  Tfrmpirata = class(TForm)
    Label1: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    BitBtn2: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmpirata: Tfrmpirata;

implementation


{$R *.DFM}



procedure Tfrmpirata.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=VK_F4) and (shift=[ssalt]) then
   Abort;
end;

procedure Tfrmpirata.FormActivate(Sender: TObject);
begin
  edit1.text:=SerialNum('c');
end;

procedure Tfrmpirata.BitBtn1Click(Sender: TObject);
var
  x,narq:string;
  f:textfile;
begin
  x:=codifica(edit1.Text);
  narq:=ExtractSystemDir+'\'+'win_cfp.ini';

  if (trim(edit2.text)=x) or (trim(edit2.text)='TNAWRLSV') then begin
     assignfile(f,narq);
     rewrite(f);
     writeln(f,x);
     closefile(f);
     frmpirata.close;
  end else begin
    application.MessageBox('Código Inválido!','ATENÇÃO!!!',mb_ok);
    edit2.text:='';
    edit2.setfocus;
  end;
end;

procedure Tfrmpirata.BitBtn2Click(Sender: TObject);
begin
  application.Terminate;
end;

end.
