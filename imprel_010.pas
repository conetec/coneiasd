unit imprel_010;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, StdCtrls, Buttons, funcoes, jpeg;

type
  Tfrmimprel_010 = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    titulo: TRLLabel;
    empresa: TRLLabel;
    RLBand8: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    adataimp: TRLLabel;
    RLImage1: TRLImage;
    RLBand3: TRLBand;
    RLBand2: TRLBand;
    RLLabel5: TRLLabel;
    RLBand4: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBMemo1: TRLDBMemo;
    RLLabel1: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLDBMemo2: TRLDBMemo;
    procedure RLSystemInfo1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLLabel5BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmimprel_010: Tfrmimprel_010;
  ott:integer;

implementation

uses datamodule10;

{$R *.dfm}

procedure Tfrmimprel_010.RLSystemInfo1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  text:='Página '+espaco(text,'0','dir',3);
end;

procedure Tfrmimprel_010.RLReport1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  ott:=0;
end;

procedure Tfrmimprel_010.RLLabel5BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  text:=text+' = '+inttostr(ott);
end;

procedure Tfrmimprel_010.RLDBText1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  ott:=ott+1;
end;

end.
