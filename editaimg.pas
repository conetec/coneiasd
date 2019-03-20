unit editaimg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Camera, StdCtrls, Buttons, jpeg, Menus;

type
  Tfrmeditaimg = class(TForm)
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Image2: TImage;
    Shape1: TShape;
    Panel3: TPanel;
    Edit1: TEdit;
    Image3: TImage;
    PopupMenu1: TPopupMenu;
    PadroFoto1: TMenuItem;
    procedure BitBtn2Click(Sender: TObject);


    procedure cortar;
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PadroFoto1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmeditaimg: Tfrmeditaimg;
  moveX, moveY: Integer;
  mover: boolean;


implementation

{$R *.dfm}

type
  TMoveControle = class(TControl);


procedure Tfrmeditaimg.cortar;
var
  py,px,ptop,pleft:integer;
  PC:TColor;
begin
  image2.Picture:=image3.Picture;
  ptop:=shape1.Top-image1.top;
  pleft:=shape1.left-image1.left;
  for py:=ptop to shape1.Height+ptop do begin
    for px:=pleft to shape1.Width+pleft do begin
      pc:=Image1.Picture.Bitmap.Canvas.Pixels[px,py];
      image2.Picture.Bitmap.Canvas.Pixels[px-pleft,py-ptop]:=pc;
    end;
  end;
  image2.Repaint;
end;

procedure Tfrmeditaimg.ControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  moveX := X;
  moveY := Y;
  mover := True;
  TMoveControle(Sender).MouseCapture := True;
end;

procedure Tfrmeditaimg.ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if mover then begin
    with Sender As TControl Do
    Begin
      Left := X-moveX+Left;
      Top := Y-moveY+Top;
    End;
  end;
end;

procedure Tfrmeditaimg.ControlMouseUp(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if mover then begin
    mover := False;
    TMoveControle(Sender).MouseCapture := False;
  end;
  shape1.Cursor:=crHourGlass;
  cortar;
  shape1.Cursor:=crSizeAll;
end;


procedure Tfrmeditaimg.BitBtn2Click(Sender: TObject);
var
  bmp, tbmp: TBitmap;
  drect: TRect;

begin
  image2.Height:=shape1.Height;
  image2.Width:=shape1.Width;

  bmp := TBitmap.Create;
  bmp.Height := shape1.Height;
  bmp.Width := shape1.Width;
  drect := Bounds(0, 0, bmp.Width, bmp.Height);
  try
    tbmp := TBitmap.Create;
    tbmp.Height := Image2.Height;
    tbmp.Width := Image2.Width;
    tbmp.Canvas.Draw(0,0,Image2.Picture.Graphic);
    bmp.Canvas.CopyRect(drect, tbmp.Canvas, drect);
    Image2.Picture.Bitmap.Assign(Bmp);
  finally
    bmp.Free;
    tbmp.Free;
  end;
  frmeditaimg.close;
end;

procedure Tfrmeditaimg.FormShow(Sender: TObject);
begin
  cortar;
end;

procedure Tfrmeditaimg.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    x:string;
begin
  x:=inttostr(key);
  application.MessageBox(pchar(x),'',mb_ok);

end;

procedure Tfrmeditaimg.FormKeyPress(Sender: TObject; var Key: Char);
var
    x:string;
begin
  x:=key;
  application.MessageBox(pchar(x),'',mb_ok);

end;

procedure Tfrmeditaimg.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    x:string;
begin
  if key=38 then begin
    shape1.Height:=shape1.Height-5;
  end;
  if key=40 then begin
    shape1.Height:=shape1.Height+5;
  end;
  if key=37 then begin
    shape1.Width:=shape1.Width-5;
  end;
  if key=39 then begin
    shape1.Width:=shape1.Width+5;
  end;
end;

procedure Tfrmeditaimg.PadroFoto1Click(Sender: TObject);
begin
  shape1.Height:=276;
  shape1.Width:=246;
  cortar;
end;

end.
