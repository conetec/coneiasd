unit skype;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SKYPE4COMLib_TLB;

type
  Tfrmskype = class(TForm)
    Skype1: TSkype;
    procedure Skype1SmsMessageStatusChanged(ASender: TObject;
      const pMessage: ISmsMessage; Status: TOleEnum);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmskype: Tfrmskype;

implementation

uses classe10, datamodule10;

{$R *.dfm}

procedure Tfrmskype.Skype1SmsMessageStatusChanged(ASender: TObject;
  const pMessage: ISmsMessage; Status: TOleEnum);
var
  a:string;
begin
  a:=skype1.Convert.SmsMessageStatusToText(status);
  frmclasse10.amensagem.Lines.add(a);
  if trim(a)='Delivered' then begin
     frmclasse10.bitbtn2.Enabled:=true;
     data10.myclasse.next;
  end;
end;

end.
