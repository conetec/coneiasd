unit imprel_003;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, StdCtrls, Buttons, funcoes, jpeg;

type
  Tfrmimprel_003 = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    titulo: TRLLabel;
    empresa: TRLLabel;
    RLBand8: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    adataimp: TRLLabel;
    RLImage1: TRLImage;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLLabel1: TRLLabel;
    RLDBText1: TRLDBText;
    RLLabel2: TRLLabel;
    RLDBText2: TRLDBText;
    RLLabel3: TRLLabel;
    RLBand4: TRLBand;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand5: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBText5: TRLDBText;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    procedure RLSystemInfo1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmimprel_003: Tfrmimprel_003;

implementation

uses datamodule10;

{$R *.dfm}

procedure Tfrmimprel_003.RLSystemInfo1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  text:='Página '+espaco(text,'0','dir',3);
end;

end.
