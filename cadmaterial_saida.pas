unit cadmaterial_saida;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, Menus,
  JvExMask, JvToolEdit, Grids ;

type
  Tfrmcadmaterial_saida = class(TForm)
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
    Label22: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    cdmembro: TEdit;
    nmmembro: TEdit;
    dtmov: TJvDateEdit;
    Memo1: TMemo;
    ppmembro: TPopupMenu;
    CadastrarClassedeEscolaSabatina1: TMenuItem;
    LocalizarClasseES1: TMenuItem;
    Sair3: TMenuItem;
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
    procedure cdmembroExit(Sender: TObject);
    procedure CadastrarClassedeEscolaSabatina1Click(Sender: TObject);
    procedure LocalizarClasseES1Click(Sender: TObject);
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
  frmcadmaterial_saida: Tfrmcadmaterial_saida;

implementation

uses datamodule10, principal, locmembro, cadmembro, locmaterial;

{$R *.DFM}

procedure Tfrmcadmaterial_saida.limpa_lista;
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

procedure Tfrmcadmaterial_saida.limpar;
begin
  limpa_lista;
  limpar_linha;
  edit1.Text:='0';
  dtmov.text:=formatdatetime('dd/mm/yyyy',date);
  cdmembro.text:='';
  nmmembro.text:='';
  memo1.lines.clear;
  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);
end;


procedure Tfrmcadmaterial_saida.mostrar;
var
  i:integer;
begin
  limpar;
  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  dtmov.Text:=data10.mymostra.fieldbyname('datamov').asstring;
  cdmembro.Text:=data10.mymostra.fieldbyname('membro').asstring;
  nmmembro.Text:=voltainfo('membro','nome','codigo='+#39+cdmembro.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');

  memo1.Lines.clear;
  memo1.lines.add(data10.mymostra.fieldbyname('observacoes').value);
  memo1.Text:=trim(memo1.Text);

  with data10.myaux do begin
    close;
    sql.clear;
    sql.add('select * from material_saida_item where saida='+#39+edit1.text+#39);
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


procedure Tfrmcadmaterial_saida.FormActivate(Sender: TObject);
begin
  if (frmcadmaterial_saida.tag=1) or (frmcadmaterial_saida.tag=3) then begin
    frmcadmaterial_saida.caption:='Inclusão de Saída de Material';
    limpar;
    edit1.SetFocus;
  end;
  if frmcadmaterial_saida.tag=2 then begin
    frmcadmaterial_saida.caption:='Alteração de Saída de Material';
    limpar;
    mostrar;
    edit1.SetFocus;
  end;
end;

procedure Tfrmcadmaterial_saida.BitBtn2Click(Sender: TObject);
begin
  frmcadmaterial_saida.close;
end;

procedure Tfrmcadmaterial_saida.BitBtn1Click(Sender: TObject);
var
  x:string;
  a,i:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  if (cdmembro.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; cdmembro.setfocus; end;
  if (lista.cells[0,1]='') and (a=0) then begin application.MessageBox('Nenhum Item Lançado','Atenção',mb_ok); a:=1; quant.setfocus; end;

  if ((frmcadmaterial_saida.tag=1) or (frmcadmaterial_saida.tag=3)) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO material_saida ';
      x:=x+'(codigo, igreja, datamov, membro, vlrtotal, vlrpago, observacoes, dataid, horaid, id) ';
      x:=x+'VALUES (NULL,';                                  // codigo
      x:=x+#39+frmprincipal.Configura[3]+#39+',';            // igreja
      x:=x+#39+mydata(dtmov.text)+#39+',';                   // datamov
      x:=x+#39+cdmembro.text+#39+',';                        // membro
      x:=x+myvalor(totalf.text)+',';                         // vlrtotal
      x:=x+myvalor('0,00')+',';                              // vlrpago
      x:=x+#39+trim(memo1.Text)+#39+',';                     // observacoes
      x:=x+#39+mydata(adataid.text)+#39+',';  // dataid
      x:=x+#39+ahoraid.text+#39+',';          // horaid
      x:=x+#39+frmprincipal.Configura[1]+#39; // id
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    codcad.text:=voltauc('material_saida','codigo','membro='+cdmembro.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
    edit1.text:=codcad.text;

    for i:=1 to lista.rowcount-1 do begin
      with data10.exemysql do begin
        sql.clear;
        x:='INSERT INTO material_saida_item ';
        x:=x+' (codigo, saida, quantidade, material, vlrtotal) ';
        x:=x+'VALUES (NULL,';                           // codigo
        x:=x+#39+edit1.text+#39+',';                    // saida
        x:=x+myvalor(trim(lista.Cells[0,i]))+',';       // quantidade
        x:=x+#39+trim(lista.Cells[1,i])+#39+',';        // material
        x:=x+myvalor(trim(lista.Cells[3,i]));           // vlrtotal
        x:=x+')';
        sql.add(x);
        ExecSql;
      end;

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE material SET ';
        x:=x+'quantidade=quantidade-'+myvalor(trim(lista.Cells[0,i]));
        x:=x+' WHERE codigo='+#39+trim(lista.Cells[1,i])+#39;
        sql.add(x);
        ExecSql;
      end;
    end;

    if (frmcadmaterial_saida.tag=1) then begin
      limpar;
      edit1.SetFocus;
    end;
    if (frmcadmaterial_saida.tag=3) then begin
      frmcadmaterial_saida.close;
    end;
  end;

  if (frmcadmaterial_saida.tag=2) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE material_saida SET ';
      x:=x+'datamov='+#39+mydata(dtmov.text)+#39+',';                   // datamov
      x:=x+'membro='+#39+cdmembro.text+#39+',';                         // membro
      x:=x+'vlrtotal='+myvalor(totalf.text)+',';                        // vlrtotal
      x:=x+'observacoes='+#39+trim(memo1.Text)+#39;                     // observacoes
      x:=x+' where codigo='+#39+edit1.text+#39;
      sql.add(x);
      ExecSql;
    end;


    with data10.myitem1 do begin
      close;
      sql.clear;
      sql.add('select * from material_saida_item where saida='+#39+edit1.text+#39);
      open;
    end;

    data10.myitem1.first;
    while data10.myitem1.eof=false do begin
      x:='UPDATE material SET ';
      x:=x+'quantidade=quantidade+'+myvalor(formatfloat('###,###,###,0.000',data10.myitem1.fieldbyname('quantidade').value));
      x:=x+' WHERE codigo='+#39+data10.myitem1.fieldbyname('material').asstring+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;
      data10.myitem1.next;
    end;

    x:='delete from material_saida_item where saida='+#39+edit1.Text+#39;
    with data10.exemysql do begin
      sql.clear;
      sql.add(x);
      ExecSql;
    end;

    for i:=1 to lista.rowcount-1 do begin
      with data10.exemysql do begin
        sql.clear;
        x:='INSERT INTO material_saida_item ';
        x:=x+' (codigo, saida, quantidade, material, vlrtotal) ';
        x:=x+'VALUES (NULL,';                           // codigo
        x:=x+#39+edit1.text+#39+',';                    // saida
        x:=x+myvalor(trim(lista.Cells[0,i]))+',';       // quantidade
        x:=x+#39+trim(lista.Cells[1,i])+#39+',';        // material
        x:=x+myvalor(trim(lista.Cells[3,i]));           // vlrtotal
        x:=x+')';
        sql.add(x);
        ExecSql;
      end;

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE material SET ';
        x:=x+'quantidade=quantidade-'+myvalor(trim(lista.Cells[0,i]));
        x:=x+' WHERE codigo='+#39+trim(lista.Cells[1,i])+#39;
        sql.add(x);
        ExecSql;
      end;
    end;

    frmcadmaterial_saida.close;
  end;

end;

procedure Tfrmcadmaterial_saida.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadmaterial_saida.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcadmaterial_saida.cdmembroExit(Sender: TObject);
var
  ax:string;
begin
  if cdmembro.text<>'' then begin
    ax:=trim(soletra(cdmembro.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocmembro, frmlocmembro);
      frmlocmembro.auxp.text:=trim(ax);
      frmlocmembro.showmodal;
      cdmembro.Text:=frmlocmembro.ocod.text;
      cdmembro.setfocus;
      frmlocmembro.Free;
    end else begin
      nmmembro.Text:=voltainfo('membro','nome','codigo='+#39+cdmembro.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(nmmembro.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        cdmembro.setfocus;
      end;
    end;
  end;
end;

procedure Tfrmcadmaterial_saida.CadastrarClassedeEscolaSabatina1Click(
  Sender: TObject);
begin
  Application.CreateForm(Tfrmcadmembro, frmcadmembro);
  frmcadmembro.tag:=3;
  frmcadmembro.showmodal;
  cdmembro.Text:=frmcadmembro.codcad.Text;
  frmcadmembro.Free;
  cdmembro.setfocus;
end;

procedure Tfrmcadmaterial_saida.LocalizarClasseES1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocmembro, frmlocmembro);
  frmlocmembro.showmodal;
  cdmembro.Text:=frmlocmembro.ocod.text;
  cdmembro.setfocus;
  frmlocmembro.Free;
end;

procedure Tfrmcadmaterial_saida.quantExit(Sender: TObject);
begin
  if trim(quant.text)='' then begin quant.Text:='1'; end;
  if trim(quant.text)='0' then begin quant.Text:='1'; end;
end;

procedure Tfrmcadmaterial_saida.cdmaterialExit(Sender: TObject);
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
      xd:=voltainfo('material','descricao|vlrvenda','codigo='+#39+cdmaterial.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T|N','2');
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

procedure Tfrmcadmaterial_saida.MenuItem2Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocmaterial, frmlocmaterial);
  frmlocmaterial.showmodal;
  cdmaterial.Text:=frmlocmaterial.ocod.text;
  cdmaterial.setfocus;
  frmlocmaterial.Free;
end;

procedure Tfrmcadmaterial_saida.vunitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key in ['.',','] Then Key := DecimalSeparator;
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadmaterial_saida.vunitarioExit(Sender: TObject);
begin
  if trim(vunitario.Text)='' then begin vunitario.Text:='0,00'; end;
  vtotal.Text:=formatfloat('###,###,###,0.00',vc(vunitario.text)*vc(quant.Text));
end;

procedure Tfrmcadmaterial_saida.vtotalExit(Sender: TObject);
begin
  if trim(vtotal.Text)='' then begin vtotal.Text:='0,00'; end;
  vunitario.Text:=formatfloat('###,###,###,0.00',vc(vtotal.text)/vc(quant.Text));
end;


procedure Tfrmcadmaterial_saida.calcular;
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

procedure Tfrmcadmaterial_saida.limpar_linha;
begin
  quant.text:='1';
  cdmaterial.text:='';
  nmmaterial.text:='';
  vunitario.text:='0,00';
  vtotal.text:='0,00';
end;


procedure Tfrmcadmaterial_saida.BitBtn3Click(Sender: TObject);
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

procedure Tfrmcadmaterial_saida.ExcluirMaterial1Click(Sender: TObject);
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

procedure Tfrmcadmaterial_saida.listaDrawCell(Sender: TObject; ACol,
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
