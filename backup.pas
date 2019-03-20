unit backup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tfrmbackup = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmbackup: Tfrmbackup;

implementation

{$R *.dfm}

Function StrToPChar(const Str: string): PChar;
type
  TRingIndex = 0..255;
var
  Ring: array[TRingIndex] of PChar;
  RingIndex: TRingIndex;
  Ptr: PChar;
begin
  Ptr := @Str[Length(Str)];
  Inc(Ptr);
  if Ptr^ = #0 then begin
    Result := @Str[1];
  end else begin
    Result := StrAlloc(Length(Str)+1);
    RingIndex := (RingIndex + 1) mod (High(TRingIndex) + 1);
    StrPCopy(Result,Str);
    StrDispose(Ring[RingIndex]);
    Ring[RingIndex]:= Result;
  end;
end;



procedure Tfrmbackup.BitBtn1Click(Sender: TObject);
var
  x:string;
  f:textfile;
begin
  x:='c:\mysql\bin\mysqldump -u root --password=  -A > ';
  x:=x+ExtractFilePath(ParamStr(0))+'backup\'+'back'+'_'+formatdatetime('dd_mm_yy',date)+'.txt';
  assignfile(f,ExtractFilePath(ParamStr(0))+'backup.bat');
  rewrite(f);
  writeln(f,x);
  closefile(f);
  x:=ExtractFilePath(ParamStr(0))+'backup.bat';
  winexec(strtopchar(x),sw_show);
end;

procedure Tfrmbackup.BitBtn2Click(Sender: TObject);
begin
  frmbackup.close;
end;

procedure Tfrmbackup.FormActivate(Sender: TObject);
begin
  edit1.text:=timetostr(time);
  edit2.Text:=formatdatetime('dd/mm/yyyy',date);
  memo1.lines.Clear;
  memo1.lines.Add('O arquivo de cópia de segurança estará na pasta');
  memo1.lines.Add('');
  memo1.lines.Add(ExtractFilePath(ParamStr(0))+'backup\');
  memo1.lines.Add('');
  memo1.lines.Add('É altamente recomendável que se faça cópias desse arquivo em uma mídia externa (cd, disquete, zip, etc)');
  memo1.lines.Add('');
end;

end.
