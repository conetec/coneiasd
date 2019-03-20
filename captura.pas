unit captura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Camera, StdCtrls, Buttons;

type
  Tfrmcaptura = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Image1: TImage;
    Camera1: TCamera;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcaptura: Tfrmcaptura;

implementation

uses editaimg;

{$R *.dfm}

procedure Tfrmcaptura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  camera1.Actif:=false;
end;

procedure Tfrmcaptura.FormShow(Sender: TObject);
begin


  camera1.Actif:=true;
  bitbtn1.Click;
end;

procedure Tfrmcaptura.BitBtn2Click(Sender: TObject);
begin
  frmeditaimg.image1.Picture:=image1.Picture;
  frmeditaimg.showmodal;
  frmcaptura.close;
end;

procedure Tfrmcaptura.BitBtn1Click(Sender: TObject);
begin
  camera1.CaptureImageDisque;
  image1.Picture.LoadFromFile(camera1.FichierImage);
end;

procedure Tfrmcaptura.BitBtn3Click(Sender: TObject);
begin
  camera1.SelectFormat;
end;

procedure Tfrmcaptura.BitBtn4Click(Sender: TObject);
begin
  camera1.SelectConfig;
end;

procedure Tfrmcaptura.BitBtn5Click(Sender: TObject);
begin
  camera1.SelectCompress;
end;

end.
