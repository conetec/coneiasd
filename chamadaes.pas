unit chamadaes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, funcoes, funcaolocal;

type
  Tfrmchamadaes = class(TForm)
    Label19: TLabel;
    Edit7: TEdit;
    Label1: TLabel;
    Edit1: TEdit;
    lista: TStringGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure carrega_alunos;
    procedure listaClick(Sender: TObject);
    procedure listaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Edit7Enter(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    function mtodos:boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmchamadaes: Tfrmchamadaes;

implementation

uses datamodule10, selchamada;

{$R *.dfm}


procedure MouseCell(Grid: TStringGrid;
var Coluna, Linha: integer);
var
Pt: TPoint;
begin
GetCursorPos(Pt);
Pt := Grid.ScreenToClient(Pt);
if PtInRect(Grid.ClientRect, Pt) then
Grid.MouseToCell(Pt.X, Pt.Y, Coluna, Linha)
else begin
Coluna := -1;
Linha := -1;
end;
end;


procedure Tfrmchamadaes.carrega_alunos;
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
  lista.ColCount:=5;
  lista.FixedRows:=1;
  lista.FixedCols:=0;
  lista.Cells[0,0]:='Código';
  lista.Cells[1,0]:='Nome';
  lista.Cells[2,0]:='P';
  lista.Cells[3,0]:='F';
  lista.Cells[4,0]:='J';

  lista.ColWidths[0]:=80;
  lista.ColWidths[1]:=350;
  lista.ColWidths[2]:=20;
  lista.ColWidths[3]:=20;
  lista.ColWidths[4]:=20;

  lista.Cells[0,1]:='';
  lista.Cells[1,1]:='';
  lista.Cells[2,1]:='';
  lista.Cells[3,1]:='';
  lista.Cells[4,1]:='';

   with data10.myauxsl do begin
     close;
     sql.clear;
     x:='select membro.codigo,membro.nome from membro';
     x:=x+' where (';
     x:=x+'(ativo='+#39+'S'+#39+')';
     x:=x+' and (classe='+#39+frmselchamada.cax1.Text+#39+')';
     x:=x+')';
     x:=x+' order by membro.nome';
     sql.add(x);
     open;
     first;
     while eof=false do begin
        if lista.cells[0,1]<>'' then begin
          lista.RowCount:=lista.RowCount+1;
        end;
        lista.Cells[0,lista.RowCount-1]:=fieldbyname('codigo').asstring;
        lista.Cells[1,lista.RowCount-1]:=fieldbyname('nome').asstring;

        ap:=voltainfo('lista_es','presenca','chamada='+#39+frmselchamada.achamada.Text+#39+' and aluno='+#39+fieldbyname('codigo').asstring+#39,'T','0');
        lista.Cells[2,lista.RowCount-1]:='';
        lista.Cells[3,lista.RowCount-1]:='';
        lista.Cells[4,lista.RowCount-1]:='';
        if ap='P' then begin lista.Cells[2,lista.RowCount-1]:='X'; end;
        if ap='F' then begin lista.Cells[3,lista.RowCount-1]:='X'; end;
        if ap='J' then begin lista.Cells[4,lista.RowCount-1]:='X'; end;
       next;
     end;
   end;


end;


procedure Tfrmchamadaes.FormShow(Sender: TObject);
begin
  carrega_alunos;
end;

procedure Tfrmchamadaes.listaClick(Sender: TObject);
var
  Coluna, Linha: integer;
begin
  MouseCell(lista, Coluna, Linha);
  if coluna=2 then begin
    lista.Cells[2,lista.Row]:='X';
    lista.Cells[3,lista.Row]:='';
    lista.Cells[4,lista.Row]:='';
  end;
  if coluna=3 then begin
    lista.Cells[2,lista.Row]:='';
    lista.Cells[3,lista.Row]:='X';
    lista.Cells[4,lista.Row]:='';
  end;
  if coluna=4 then begin
    lista.Cells[2,lista.Row]:='';
    lista.Cells[3,lista.Row]:='';
    lista.Cells[4,lista.Row]:='X';
  end;

end;

procedure Tfrmchamadaes.listaDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Alignment: TAlignment;
  x, y: integer;
  Value: string;

begin

  if ACol = 0 then begin Alignment:= taCenter; end;
  if ACol = 1 then begin Alignment:= taLeftJustify; end;
  if ACol = 2 then begin Alignment:= taCenter; end;
  if ACol = 3 then begin Alignment:= taCenter; end;
  if ACol = 4 then begin Alignment:= taCenter; end;

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

  if (ACol = 2) then begin
    if lista.Cells[Acol,ARow]='X' then begin
      lista.Canvas.Brush.Color := clGreen;
      lista.Canvas.FillRect(Rect);
    end else begin
      lista.Canvas.Brush.Color := clWhite;
      lista.Canvas.FillRect(Rect);
    end;
  end;
  if (ACol = 3) then begin
    if lista.Cells[Acol,ARow]='X' then begin
      lista.Canvas.Brush.Color := clRed;
      lista.Canvas.FillRect(Rect);
    end else begin
      lista.Canvas.Brush.Color := clWhite;
      lista.Canvas.FillRect(Rect);
    end;
  end;
  if (ACol = 4) then begin
    if lista.Cells[Acol,ARow]='X' then begin
      lista.Canvas.Brush.Color := clYellow;
      lista.Canvas.FillRect(Rect);
    end else begin
      lista.Canvas.Brush.Color := clWhite;
      lista.Canvas.FillRect(Rect);
    end;
  end;
  TStringGrid(Sender).Canvas.TextRect(Rect, x, y, Value);

end;

procedure Tfrmchamadaes.Edit7Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmchamadaes.BitBtn2Click(Sender: TObject);
begin
  frmchamadaes.Close;
end;

function Tfrmchamadaes.mtodos:boolean;
var
  i,k:integer;
  x:string;
begin
  x:='';
  k:=0;
  for i:=1 to lista.RowCount-1 do begin
    if (trim(lista.Cells[2,i])='') and (trim(lista.Cells[3,i])='') and (trim(lista.Cells[4,i])='') then begin
      k:=k+1;
      x:=x+trim(lista.Cells[1,i])+#13;
    end;
  end;
  if k>0 then begin
    x:=inttostr(k)+' Alunos não foram marcados:'+#13+#13+x;
    application.MessageBox(pchar(x),'Atenção',mb_ok);
    mtodos:=false;
  end else begin
    mtodos:=true;
  end;
end;


procedure Tfrmchamadaes.BitBtn1Click(Sender: TObject);
var
  a,i:integer;
  x,tp:string;
begin
  a:=0;
  if (a=0) and (mtodos=false) then begin a:=1; end;
  if (a=0) and (application.MessageBox('Confirma Chamada?','Atenção',mb_yesno)=id_no) then begin a:=1; end;
  if (a=0) then begin

    x:='delete from lista_es where chamada='+#39+frmselchamada.achamada.Text+#39;
    with data10.exemysql do begin
      sql.clear;
      sql.add(x);
      ExecSql;
    end;

    for i:=1 to lista.RowCount-1 do begin

      if trim(lista.Cells[2,i])='X' then begin tp:='P'; end;
      if trim(lista.Cells[3,i])='X' then begin tp:='F'; end;
      if trim(lista.Cells[4,i])='X' then begin tp:='J'; end;

      with data10.exemysql do begin
        sql.clear;
        x:='INSERT INTO lista_es ';
        x:=x+'(codigo, aluno, presenca, contato, chamada) ';
        x:=x+'VALUES (NULL,';                                            // codigo
        x:=x+#39+trim(lista.Cells[0,i])+#39+',';                         // aluno
        x:=x+#39+tp+#39+',';                                             // presenca
        x:=x+#39+'N'+#39+',';                                            // contato
        x:=x+#39+frmselchamada.achamada.Text+#39;                        // chamada
        x:=x+')';
        sql.add(x);
        ExecSql;
      end;
    end;
    frmchamadaes.close;
  end;
end;

end.
