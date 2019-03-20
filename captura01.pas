unit captura01;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Camera, StdCtrls, Buttons, DirectShow9, Dsutil, funcoes,
  ComCtrls, DSPack;

type
  Tfrmcaptura01 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Image1: TImage;
    TelaVideo: TVideoWindow;
    CaptureGraph: TFilterGraph;
    SampleGrabber1: TSampleGrabber;
    VideoSourceFilter: TFilter;
    cameras: TComboBox;
    Label1: TLabel;
    resolucao: TComboBox;
    Label2: TLabel;
    btiniciar: TBitBtn;
    btparar: TBitBtn;
    btpadrao: TBitBtn;
    resolucao_resumo: TComboBox;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btiniciarClick(Sender: TObject);
    procedure camerasExit(Sender: TObject);
    procedure btpararClick(Sender: TObject);
    procedure carregaresolucao;
    procedure btpadraoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcaptura01: Tfrmcaptura01;
  CapEnum: TSySDevEnum;
  VideoMediaTypes: TEnumMediaType;

implementation

uses editaimg ;

{$R *.dfm}

procedure Tfrmcaptura01.BitBtn2Click(Sender: TObject);
begin
  if image1.Picture<>nil then begin
    frmeditaimg.image1.Picture:=image1.Picture;
    frmeditaimg.showmodal;
    frmcaptura01.close;
  end;
end;

procedure Tfrmcaptura01.BitBtn1Click(Sender: TObject);
begin
  samplegrabber1.GetBitmap(Image1.Picture.Bitmap);
end;

procedure Tfrmcaptura01.FormCreate(Sender: TObject);
var
  i: integer;
  narq,x,x1:string;
  f:textfile;
begin
  image1.Picture:=nil;
  CapEnum := TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
  for i := 0 to CapEnum.CountFilters - 1 do begin
    cameras.Items.Add(CapEnum.Filters[i].FriendlyName);
  end;
  CapEnum.SelectGUIDCategory(CLSID_AudioInputDeviceCategory);
  VideoMediaTypes := TEnumMediaType.Create;
  cameras.ItemIndex:=0;
  carregaresolucao;
  btparar.Enabled:=false;


  narq:=ExtractFilePath(ParamStr(0));
  narq:=narq+'conf_camera.ini';
  if fileexists(narq) then begin
    assignfile(f,narq);
    reset(f);
    x1:='';
    while not eof(f) do begin
      readln(f,x);
      if trim(x)<>'' then begin
        x1:=x;
      end;
    end;
    closefile(f);
    if trim(x1)<>'' then begin
      cameras.ItemIndex:=strtoint(voltacod(x1,'|',0));
      resolucao_resumo.ItemIndex:=strtoint(voltacod(x1,'|',1));
      btiniciar.Click;


    end;
  end;

end;


procedure Tfrmcaptura01.btiniciarClick(Sender: TObject);
var
  multiplexer: IBaseFilter;
  Writer: IFileSinkFilter;
  PinList: TPinList;
  i: integer;
begin
  try
    cameras.Enabled:=false;
    resolucao_resumo.Enabled:=false;
    btiniciar.Enabled:=false;
    btparar.Enabled:=true;
    resolucao.ItemIndex:=resolucao_resumo.ItemIndex;

    CaptureGraph.Active := true;

    if VideoSourceFilter.FilterGraph <> nil then begin
      PinList := TPinList.Create(VideoSourceFilter as IBaseFilter);
      if resolucao.ItemIndex <> -1 then
        with (PinList.First as IAMStreamConfig) do
          SetFormat(VideoMediaTypes.Items[resolucao.ItemIndex].AMMediaType^);
      PinList.Free;
    end;
    with CaptureGraph as IcaptureGraphBuilder2 do  begin
      if VideoSourceFilter.BaseFilter.DataLength > 0 then begin
        RenderStream(@PIN_CATEGORY_PREVIEW, nil, VideoSourceFilter as IBaseFilter, SampleGrabber1 as IBaseFilter , TelaVideo as IBaseFilter);
      end;
    end;

    CaptureGraph.Play;
  except

    cameras.Enabled:=true;
    resolucao_resumo.Enabled:=true;
    btiniciar.Enabled:=true;
    btparar.Enabled:=false;
    CaptureGraph.Stop;
    CaptureGraph.Active := False;
    application.MessageBox('Erro ao Iniciar Câmera!','Atenção',mb_ok);

  end;
end;

procedure Tfrmcaptura01.carregaresolucao;
var
  PinList: TPinList;
  i: integer;
begin
  CapEnum.SelectGUIDCategory(CLSID_VideoInputDeviceCategory);
  if cameras.ItemIndex <> -1 then
  begin
    VideoSourceFilter.BaseFilter.Moniker := CapEnum.GetMoniker(cameras.ItemIndex);
    VideoSourceFilter.FilterGraph := CaptureGraph;
    CaptureGraph.Active := true;
    PinList := TPinList.Create(VideoSourceFilter as IBaseFilter);
    resolucao.Clear;
    resolucao_resumo.clear;

    VideoMediaTypes.Assign(PinList.First);
    for i := 0 to VideoMediaTypes.Count - 1 do begin
      resolucao.Items.Add(VideoMediaTypes.MediaDescription[i]);
      resolucao_resumo.items.add(voltacod(VideoMediaTypes.MediaDescription[i],':',3));
    end;
    CaptureGraph.Active := false;
    PinList.Free;
  end;
  resolucao.ItemIndex:=0;
  resolucao_resumo.ItemIndex:=0;
end;

procedure Tfrmcaptura01.camerasExit(Sender: TObject);
begin
  carregaresolucao;
end;

procedure Tfrmcaptura01.btpararClick(Sender: TObject);
begin
  cameras.Enabled:=true;
  resolucao_resumo.Enabled:=true;
  btiniciar.Enabled:=true;
  btparar.Enabled:=false;
  CaptureGraph.Stop;
  CaptureGraph.Active := False;
end;

procedure Tfrmcaptura01.btpadraoClick(Sender: TObject);
var
  f:textfile;
  x,narq:string;
begin
  if btiniciar.enabled=false then begin
    narq:=ExtractFilePath(ParamStr(0));
    narq:=narq+'conf_camera.ini';
    assignfile(f,narq);
    rewrite(f);
    x:=inttostr(cameras.itemindex)+'|'+inttostr(resolucao_resumo.itemindex);
    writeln(f,x);
    closefile(f);
    application.MessageBox('Padrão Definido','Atenção',mb_ok);
  end;
end;

procedure Tfrmcaptura01.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CaptureGraph.Stop;
  CaptureGraph.Active := False;
  CapEnum.Free;
  VideoMediaTypes.Free;
end;

end.
