unit acompanhaes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, funcaolocal, funcoes, Grids;

type
  Tfrmacompanhaes = class(TForm)
    Label19: TLabel;
    Edit7: TEdit;
    Label13: TLabel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox2: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    otrimestre: TEdit;
    cax1: TComboBox;
    achamada: TEdit;
    lista: TStringGrid;
    alista: TEdit;
    procedure FormShow(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7Enter(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure limpa_alunos;
    procedure listaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure listaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmacompanhaes: Tfrmacompanhaes;
  xdti,xdtf:string;

implementation

uses principal, datamodule10, chamadaes, contatoes;

{$R *.dfm}


procedure Tfrmacompanhaes.limpa_alunos;
var
  i,k:integer;
  x,ap:string;
begin

  for i:=1 to lista.rowcount-1 do begin
    for k:=0 to lista.colcount-1 do begin
      lista.cells[k,i]:='';
    end;
  end;

  lista.RowCount:=2;
  lista.ColCount:=4;
  lista.FixedRows:=1;
  lista.FixedCols:=0;
  lista.Cells[0,0]:='Código';
  lista.Cells[1,0]:='Classe';
  lista.Cells[2,0]:='Nome';
  lista.Cells[3,0]:='Contato';

  lista.ColWidths[0]:=70;
  lista.ColWidths[1]:=250;
  lista.ColWidths[2]:=350;
  lista.ColWidths[3]:=60;

  lista.Cells[0,1]:='';
  lista.Cells[1,1]:='';
  lista.Cells[2,1]:='';
  lista.Cells[3,1]:='';

end;


procedure Tfrmacompanhaes.FormShow(Sender: TObject);
var
  x,dtp:string;
  nsab:integer;
begin
  limpa_alunos;
  x:=voltainfo('trimestre','codigo|descricao|datai|dataf','ativo='+#39+'S'+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T|T|D|D','0');
  if trim(x)='' then begin
    frmacompanhaes.Close;
  end else begin
    otrimestre.text:=voltacod(x,'|',0);
    edit7.text:=voltacod(x,'|',1);
    xdti:=voltacod(x,'|',2);
    xdtf:=voltacod(x,'|',3);

    combobox1.Items.Clear;
    cax1.Items.clear;

    with data10.myaux do begin
      close;
      sql.clear;
      x:='select codigo,descricao from classe where igreja='+#39+frmprincipal.Configura[3]+#39+' and ativo='+#39+'S'+#39+' order by descricao';
      sql.add(x);
      open;
      first;
      combobox1.Items.add('TODAS AS CLASSES');
      cax1.Items.add('0');
      while eof=false do begin
        combobox1.Items.add(fieldbyname('descricao').asstring);
        cax1.Items.add(fieldbyname('codigo').asstring);
        next;
      end;
      combobox1.ItemIndex:=0;
    end;
    nsab:=0;
    combobox2.Items.clear;
    dtp:=xdti;
    while (strtodate(dtp)<=strtodate(xdtf)) do begin
      if DayOfWeek(strtodate(dtp))=7 then begin
        nsab:=nsab+1;
        combobox2.Items.add(espaco(inttostr(nsab),'0','dir',2)+' '+dtp);
      end;
      dtp:=formatdatetime('dd/mm/yyyy',strtodate(dtp)+1);
    end;
    combobox2.ItemIndex:=0;
  end;
end;

procedure Tfrmacompanhaes.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmacompanhaes.Edit7Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmacompanhaes.BitBtn2Click(Sender: TObject);
begin
  frmacompanhaes.close;
end;

procedure Tfrmacompanhaes.BitBtn1Click(Sender: TObject);
var
  x,xp,nchama:string;
begin
  limpa_alunos;
  cax1.ItemIndex:=combobox1.ItemIndex;
  with data10.myaux do begin
    close;
    sql.clear;
    x:='select a.codigo,a.contato,b.nome,b.codigo as nmembro,d.descricao from ';
    x:=x+' lista_es a left join membro b on a.aluno=b.codigo';
    x:=x+' left join chamada_es c on a.chamada=c.codigo';
    x:=x+' left join classe d on c.classe=d.codigo';
    x:=x+' where (';
    x:=x+' (c.datamov='+#39+mydata(voltacod(combobox2.Text,' ',1))+#39+')';
    x:=x+' and (c.igreja='+#39+frmprincipal.Configura[3]+#39+')';
    x:=x+' and (a.presenca='+#39+'F'+#39+')';
    if cax1.text<>'0' then begin
      x:=x+' and (c.classe='+#39+cax1.text+#39+')';
    end;
    x:=x+')';
    x:=x+' order by d.descricao,b.nome';
    sql.add(x);
    open;
    if recordcount>0 then begin
      first;
      while eof=false do begin
        if lista.cells[0,1]<>'' then begin
          lista.RowCount:=lista.RowCount+1;
        end;
        lista.Cells[0,lista.RowCount-1]:=fieldbyname('codigo').asstring;
        lista.Cells[1,lista.RowCount-1]:=fieldbyname('descricao').asstring;
        lista.Cells[2,lista.RowCount-1]:=fieldbyname('nmembro').asstring+' - '+fieldbyname('nome').asstring;
        lista.Cells[3,lista.RowCount-1]:=fieldbyname('contato').asstring;
        next;
      end;
    end else begin
      application.MessageBox('Nenhum Aluno ou Chamada não Localizada','Atenção',mb_ok);
    end;
  end;
end;

procedure Tfrmacompanhaes.listaDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Alignment: TAlignment;
  x, y: integer;
  Value: string;

begin

  if ACol = 0 then begin Alignment:= taCenter; end;
  if ACol = 1 then begin Alignment:= taLeftJustify; end;
  if ACol = 2 then begin Alignment:= taLeftJustify; end;
  if ACol = 3 then begin Alignment:= taCenter; end;

//  if ACol = 2 then begin Alignment:= taRightJustify; end;

  Value:= TStringGrid(Sender).Cells[ACol, ARow];

  y:= Rect.Top + (Rect.Bottom - Rect.Top - TStringGrid(Sender).Canvas.TextHeight(Value)) div 2;
  x:= 0;
  case Alignment of
    taCenter:
      x:= Rect.Left + (Rect.Right - Rect.Left -  TStringGrid(Sender).Canvas.TextWidth(Value)) div 2 - 1;
    taRightJustify:
      x:= Rect.Right - TStringGrid(Sender).Canvas.TextWidth(Value) - 2;
    taLeftJustify:
      x:= Rect.Left + 2;
  end;

  if (ACol = 3) and (ARow>0) then begin
    if lista.Cells[Acol,ARow]='S' then begin
      lista.Canvas.Brush.Color := clGreen;
      lista.Canvas.FillRect(Rect);
    end else begin
      lista.Canvas.Brush.Color := clRed;
      lista.Canvas.FillRect(Rect);
    end;
  end;
  TStringGrid(Sender).Canvas.TextRect(Rect, x, y, Value);

end;

procedure Tfrmacompanhaes.listaClick(Sender: TObject);
begin
  alista.text:=lista.Cells[0,lista.row];
  Application.CreateForm(Tfrmcontatoes, frmcontatoes);
  frmcontatoes.showmodal;
  if frmcontatoes.bitbtn1.tag=10 then begin
    lista.Cells[3,lista.row]:='S';
  end;
  frmcontatoes.Free;
end;

end.




