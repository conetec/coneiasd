unit cadmaterial_entrada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, Menus,
  JvExMask, JvToolEdit, Grids ;

type
  Tfrmcadmaterial_entrada = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    codcad: TEdit;
    adataID: TEdit;
    ahoraID: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Label21: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    cdmembro: TEdit;
    dtmov: TJvDateEdit;
    Memo1: TMemo;
    lista: TStringGrid;
    Label11: TLabel;
    totalf: TMaskEdit;
    Label6: TLabel;
    quant: TEdit;
    Label7: TLabel;
    cdmaterial: TEdit;
    ppmaterial: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Label8: TLabel;
    nmmaterial: TEdit;
    Label9: TLabel;
    vunitario: TEdit;
    Label10: TLabel;
    vtotal: TEdit;
    BitBtn3: TBitBtn;
    pplista: TPopupMenu;
    ExcluirMaterial1: TMenuItem;
    Sair1: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure limpar;
    procedure mostrar;
    procedure Edit1Enter(Sender: TObject);
    procedure limpa_lista;
    procedure quantExit(Sender: TObject);
    procedure cdmaterialExit(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure vunitarioKeyPress(Sender: TObject; var Key: Char);
    procedure vunitarioExit(Sender: TObject);
    procedure vtotalExit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure limpar_linha;
    procedure calcular;
    procedure ExcluirMaterial1Click(Sender: TObject);
    procedure listaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadmaterial_entrada: Tfrmcadmaterial_entrada;

implementation

uses datamodule10, principal, locmembro, cadmembro, locmaterial;

{$R *.DFM}

procedure Tfrmcadmaterial_entrada.limpa_lista;
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
  lista.Cells[0,0]:='Quant.';
  lista.Cells[1,0]:='Material';
  lista.Cells[2,0]:='Descrição';
  lista.Cells[3,0]:='Total R$';

  lista.ColWidths[0]:=100;
  lista.ColWidths[1]:=120;
  lista.ColWidths[2]:=400;
  lista.ColWidths[3]:=150;

  lista.Cells[0,1]:='';
  lista.Cells[1,1]:='';
  lista.Cells[2,1]:='';
  lista.Cells[3,1]:='';

end;

procedure Tfrmcadmaterial_entrada.limpar;
begin
  limpa_lista;
  limpar_linha;
  edit1.Text:='0';
  dtmov.text:=formatdatetime('dd/mm/yyyy',date);
  cdmembro.text:='';
  memo1.lines.clear;
  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);
end;


procedure Tfrmcadmaterial_entrada.mostrar;
var
  i:integer;
begin
  limpar;
  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  dtmov.Text:=data10.mymostra.fieldbyname('datamov').asstring;
  cdmembro.Text:=data10.mymostra.fieldbyname('descricao').asstring;

  memo1.Lines.clear;
  memo1.lines.add(data10.mymostra.fieldbyname('observacoes').value);
  memo1.Text:=trim(memo1.Text);

  with data10.myaux do begin
    close;
    sql.clear;
    sql.add('select * from material_entrada_item where entrada='+#39+edit1.text+#39);
    open;
    first;
    while eof=false do begin
      if lista.cells[0,1]<>'' then begin
        lista.RowCount:=lista.RowCount+1;
      end;
      lista.Cells[0,lista.RowCount-1]:=data10.myaux.fieldbyname('quantidade').asstring;
      lista.Cells[1,lista.RowCount-1]:=data10.myaux.fieldbyname('material').asstring;
      lista.Cells[2,lista.RowCount-1]:=voltainfo('material','descricao','codigo='+#39+data10.myaux.fieldbyname('material').asstring+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      lista.Cells[3,lista.RowCount-1]:=formatfloat('###,###,###,0.00',data10.myaux.fieldbyname('vlrtotal').value);
      next;
    end;
    calcular;
  end;

end;


procedure Tfrmcadmaterial_entrada.FormActivate(Sender: TObject);
begin
  if (frmcadmaterial_entrada.tag=1) or (frmcadmaterial_entrada.tag=3) then begin
    frmcadmaterial_entrada.caption:='Inclusão de Entrada de Material';
    limpar;
    edit1.SetFocus;
  end;
  if frmcadmaterial_entrada.tag=2 then begin
    frmcadmaterial_entrada.caption:='Alteração de Entrada de Material';
    limpar;
    mostrar;
    edit1.SetFocus;
  end;
end;

procedure Tfrmcadmaterial_entrada.BitBtn2Click(Sender: TObject);
begin
  frmcadmaterial_entrada.close;
end;

procedure Tfrmcadmaterial_entrada.BitBtn1Click(Sender: TObject);
var
  x,xvlunitario:string;
  a,i:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  if (cdmembro.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; cdmembro.setfocus; end;
  if (lista.cells[0,1]='') and (a=0) then begin application.MessageBox('Nenhum Item Lançado','Atenção',mb_ok); a:=1; quant.setfocus; end;

  if ((frmcadmaterial_entrada.tag=1) or (frmcadmaterial_entrada.tag=3)) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO material_entrada ';
      x:=x+'(codigo, igreja, datamov, descricao, vlrtotal, observacoes, dataid, horaid, id) ';
      x:=x+'VALUES (NULL,';                                  // codigo
      x:=x+#39+frmprincipal.Configura[3]+#39+',';            // igreja
      x:=x+#39+mydata(dtmov.text)+#39+',';                   // datamov
      x:=x+#39+cdmembro.text+#39+',';                        // descricao
      x:=x+myvalor(totalf.text)+',';                         // vlrtotal
      x:=x+#39+trim(memo1.Text)+#39+',';                     // observacoes
      x:=x+#39+mydata(adataid.text)+#39+',';  // dataid
      x:=x+#39+ahoraid.text+#39+',';          // horaid
      x:=x+#39+frmprincipal.Configura[1]+#39; // id
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    codcad.text:=voltauc('material_entrada','codigo','descricao='+cdmembro.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
    edit1.text:=codcad.text;

    for i:=1 to lista.rowcount-1 do begin
      with data10.exemysql do begin
        sql.clear;
        x:='INSERT INTO material_entrada_item ';
        x:=x+' (codigo, entrada, quantidade, material, vlrtotal) ';
        x:=x+'VALUES (NULL,';                           // codigo
        x:=x+#39+edit1.text+#39+',';                    // entrada
        x:=x+myvalor(trim(lista.Cells[0,i]))+',';       // quantidade
        x:=x+#39+trim(lista.Cells[1,i])+#39+',';        // material
        x:=x+myvalor(trim(lista.Cells[3,i]));           // vlrtotal
        x:=x+')';
        sql.add(x);
        ExecSql;
      end;

      xvlunitario:=formatfloat('###,###,###,###,0.00',vc(trim(lista.Cells[3,i]))/vc(trim(lista.Cells[0,i])));

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE material SET ';
        x:=x+'quantidade=quantidade+'+myvalor(trim(lista.Cells[0,i]))+',';
        x:=x+'vlrcompra='+myvalor(xvlunitario);
        x:=x+' WHERE codigo='+#39+trim(lista.Cells[1,i])+#39;
        sql.add(x);
        ExecSql;
      end;
    end;

    if (frmcadmaterial_entrada.tag=1) then begin
      limpar;
      edit1.SetFocus;
    end;
    if (frmcadmaterial_entrada.tag=3) then begin
      frmcadmaterial_entrada.close;
    end;
  end;

  if (frmcadmaterial_entrada.tag=2) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE material_entrada SET ';
      x:=x+'datamov='+#39+mydata(dtmov.text)+#39+',';                   // datamov
      x:=x+'descricao='+#39+cdmembro.text+#39+',';                      // descricao
      x:=x+'vlrtotal='+myvalor(totalf.text)+',';                        // vlrtotal
      x:=x+'observacoes='+#39+trim(memo1.Text)+#39;                     // observacoes
      x:=x+' where codigo='+#39+edit1.text+#39;
      sql.add(x);
      ExecSql;
    end;

    with data10.myitem1 do begin
      close;
      sql.clear;
      sql.add('select * from material_entrada_item where entrada='+#39+edit1.text+#39);
      open;
    end;

    data10.myitem1.first;
    while data10.myitem1.eof=false do begin
      x:='UPDATE material SET ';
      x:=x+'quantidade=quantidade-'+myvalor(formatfloat('###,###,###,0.000',data10.myitem1.fieldbyname('quantidade').value));
      x:=x+' WHERE codigo='+#39+data10.myitem1.fieldbyname('material').asstring+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;
      data10.myitem1.next;
    end;

    x:='delete from material_entrada_item where entrada='+#39+edit1.Text+#39;
    with data10.exemysql do begin
      sql.clear;
      sql.add(x);
      ExecSql;
    end;

    for i:=1 to lista.rowcount-1 do begin
      with data10.exemysql do begin
        sql.clear;
        x:='INSERT INTO material_entrada_item ';
        x:=x+' (codigo, entrada, quantidade, material, vlrtotal) ';
        x:=x+'VALUES (NULL,';                           // codigo
        x:=x+#39+edit1.text+#39+',';                    // entrada
        x:=x+myvalor(trim(lista.Cells[0,i]))+',';       // quantidade
        x:=x+#39+trim(lista.Cells[1,i])+#39+',';        // material
        x:=x+myvalor(trim(lista.Cells[3,i]));           // vlrtotal
        x:=x+')';
        sql.add(x);
        ExecSql;
      end;

      xvlunitario:=formatfloat('###,###,###,###,0.00',vc(trim(lista.Cells[3,i]))/vc(trim(lista.Cells[0,i])));

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE material SET ';
        x:=x+'quantidade=quantidade+'+myvalor(trim(lista.Cells[0,i]))+',';
        x:=x+'vlrcompra='+myvalor(xvlunitario);
        x:=x+' WHERE codigo='+#39+trim(lista.Cells[1,i])+#39;
        sql.add(x);
        ExecSql;
      end;
    end;

    frmcadmaterial_entrada.close;
  end;

end;

procedure Tfrmcadmaterial_entrada.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadmaterial_entrada.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcadmaterial_entrada.quantExit(Sender: TObject);
begin
  if trim(quant.text)='' then begin quant.Text:='1'; end;
  if trim(quant.text)='0' then begin quant.Text:='1'; end;
end;

procedure Tfrmcadmaterial_entrada.cdmaterialExit(Sender: TObject);
var
  ax,xd:string;
begin
  if cdmaterial.text<>'' then begin
    ax:=trim(soletra(cdmaterial.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocmaterial, frmlocmaterial);
      frmlocmaterial.auxp.text:=trim(ax);
      frmlocmaterial.showmodal;
      cdmaterial.Text:=frmlocmaterial.ocod.text;
      cdmaterial.setfocus;
      frmlocmaterial.Free;
    end else begin
      xd:=voltainfo('material','descricao|vlrcompra','codigo='+#39+cdmaterial.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T|N','2');
      if (trim(xd)='') then begin
        nmmaterial.Text:='';
        vunitario.Text:='0,00';
        vtotal.Text:='0,00';
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        cdmaterial.setfocus;
      end else begin
        nmmaterial.Text:=voltacod(xd,'|',0);
        vunitario.Text:=voltacod(xd,'|',1);
        vtotal.Text:=formatfloat('###,###,###,0.00',vc(vunitario.text)*vc(quant.Text));
      end;
    end;
  end;
end;

procedure Tfrmcadmaterial_entrada.MenuItem2Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocmaterial, frmlocmaterial);
  frmlocmaterial.showmodal;
  cdmaterial.Text:=frmlocmaterial.ocod.text;
  cdmaterial.setfocus;
  frmlocmaterial.Free;
end;

procedure Tfrmcadmaterial_entrada.vunitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key in ['.',','] Then Key := DecimalSeparator;
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadmaterial_entrada.vunitarioExit(Sender: TObject);
begin
  if trim(vunitario.Text)='' then begin vunitario.Text:='0,00'; end;
  vtotal.Text:=formatfloat('###,###,###,0.00',vc(vunitario.text)*vc(quant.Text));
end;

procedure Tfrmcadmaterial_entrada.vtotalExit(Sender: TObject);
begin
  if trim(vtotal.Text)='' then begin vtotal.Text:='0,00'; end;
  vunitario.Text:=formatfloat('###,###,###,0.00',vc(vtotal.text)/vc(quant.Text));
end;


procedure Tfrmcadmaterial_entrada.calcular;
var
  i:integer;
  vt:real;
begin
  vt:=0;
  for i:=1 to lista.rowcount-1 do begin
    if trim(lista.cells[3,i])<>'' then begin
      vt:=vt+vc(lista.cells[3,i]);
    end;
  end;
  totalf.text:=formatfloat('###,###,###,0.00',vt);
end;

procedure Tfrmcadmaterial_entrada.limpar_linha;
begin
  quant.text:='1';
  cdmaterial.text:='';
  nmmaterial.text:='';
  vunitario.text:='0,00';
  vtotal.text:='0,00';
end;


procedure Tfrmcadmaterial_entrada.BitBtn3Click(Sender: TObject);
var
  a:integer;
begin
  a:=0;
  if (cdmaterial.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; cdmaterial.setfocus; end;
  if (a=0) then begin
    if lista.cells[0,1]<>'' then begin
      lista.RowCount:=lista.RowCount+1;
    end;
    lista.Cells[0,lista.RowCount-1]:=quant.text;
    lista.Cells[1,lista.RowCount-1]:=cdmaterial.Text;
    lista.Cells[2,lista.RowCount-1]:=nmmaterial.Text;
    lista.Cells[3,lista.RowCount-1]:=vtotal.text;
    calcular;
    limpar_linha;
  end;
  quant.SetFocus;
end;

procedure Tfrmcadmaterial_entrada.ExcluirMaterial1Click(Sender: TObject);
var
  i:integer;
begin
  if application.MessageBox('Confirma Exclusão?','Atenção',mb_yesno)<>id_no then begin
    with lista do begin
      for i:=lista.row  to RowCount do begin
        Rows[i]:= Rows[i+1];
      end;
      if RowCount >2 then begin
        RowCount:=RowCount-1;
      end;
    end;
    calcular;
  end;
end;

procedure Tfrmcadmaterial_entrada.listaDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Alignment: TAlignment;
  x, y: integer;
  Value: string;

begin

  if ACol = 0 then begin Alignment:= taCenter; end;
  if ACol = 1 then begin Alignment:= taCenter; end;
  if ACol = 2 then begin Alignment:= taLeftJustify; end;
  if ACol = 3 then begin Alignment:= taRightJustify; end;

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

  TStringGrid(Sender).Canvas.TextRect(Rect, x, y, Value);
end;

end.
