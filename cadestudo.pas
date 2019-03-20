unit cadestudo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, ExtCtrls, Menus, ComCtrls,
  JvExMask, JvToolEdit, funcaolocal, Grids, DBGrids, jpeg;

type
  Tfrmcadestudo = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PopupMenu1: TPopupMenu;
    sair1: TMenuItem;
    codcad: TEdit;
    adataID: TEdit;
    ahoraID: TEdit;
    ProcurarFamlia1: TMenuItem;
    Label6: TLabel;
    Memo1: TMemo;
    Label4: TLabel;
    Edit3: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    eativo: TComboBox;
    Edit5: TEdit;
    Edit6: TEdit;
    dtinicio: TJvDateEdit;
    Edit1: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    Label17: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Label7: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    Edit7: TEdit;
    PopupMenu3: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Label9: TLabel;
    Edit8: TEdit;
    Label10: TLabel;
    dtvisita: TJvDateEdit;
    IncluirAmigo1: TMenuItem;
    IncluirDupla1: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Enter(Sender: TObject);
    procedure limpar;
    procedure mostrar;
    procedure ProcurarFamlia1Click(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure IncluirAmigo1Click(Sender: TObject);
    procedure IncluirDupla1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure Edit7Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadestudo: Tfrmcadestudo;
  ultnome,gravar:string;

implementation

uses datamodule10, principal, locinstrutor, locamigo, locdupla, cadamigo,
  caddupla, locestudob;


{$R *.DFM}


procedure Tfrmcadestudo.limpar;
begin
  bitbtn1.Enabled:=true;

  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);

  edit1.Text:='0';
  eativo.ItemIndex:=0;
  dtinicio.Text:=formatdatetime('dd/mm/yyyy',date);

  edit5.Text:='';
  edit6.Text:='';
  edit2.Text:='';
  edit3.Text:='';
  edit7.Text:='';
  edit4.Text:='';
  edit8.Text:='0';
  dtvisita.Text:='';

  memo1.Lines.Clear;

end;


procedure Tfrmcadestudo.mostrar;
var
  i:integer;
begin

  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  dtinicio.Text:=data10.mymostra.fieldbyname('datainicio').asstring;

  edit5.Text:=data10.mymostra.fieldbyname('amigo').asstring;
  edit6.Text:=voltainfo('amigo','nome','codigo='+#39+edit5.Text+#39,'T','0');

  edit2.Text:=data10.mymostra.fieldbyname('dupla').asstring;
  edit3.Text:=voltainfo('dupla','descricao','codigo='+#39+edit2.Text+#39,'T','0');

  edit7.Text:=data10.mymostra.fieldbyname('estudo').asstring;
  edit4.Text:=voltainfo('material','descricao','codigo='+#39+edit7.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39+' and categoria='+#39+frmprincipal.Configura[9]+#39,'T','0');

  edit8.Text:=data10.mymostra.fieldbyname('licao').asstring;
  dtvisita.Text:=data10.mymostra.fieldbyname('datavisita').asstring;

  eativo.ItemIndex:=-1;
  for i:=0 to eativo.Items.Count-1 do begin
    if copy(eativo.Items[i],1,1)=data10.mymostra.fieldbyname('ativo').asstring then begin
      eativo.ItemIndex:=i;
      break;
    end;
  end;

  memo1.Lines.clear;
  memo1.lines.add(data10.mymostra.fieldbyname('observacoes').value);
  memo1.Text:=trim(memo1.Text);

end;


procedure Tfrmcadestudo.FormActivate(Sender: TObject);
begin
  if (frmcadestudo.tag=1) or (frmcadestudo.tag=3) then begin
    frmcadestudo.caption:='Inclusão de Estudo';
    limpar();
    edit1.SetFocus;
  end;
  if frmcadestudo.tag=2 then begin
    frmcadestudo.caption:='Alteração de Estudo';
    limpar;
    mostrar;
    edit1.SetFocus;
  end;
end;

procedure Tfrmcadestudo.BitBtn2Click(Sender: TObject);
begin
  frmcadestudo.close;
end;

procedure Tfrmcadestudo.BitBtn1Click(Sender: TObject);
var
  x:string;
  a:integer;
begin
  bitbtn1.Enabled:=false;
  frmprincipal.c_agora;
  a:=0;
  if (trim(edit5.text)='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','Atenção',mb_ok); a:=1; edit5.setfocus; end;
  if (trim(edit2.text)='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','Atenção',mb_ok); a:=1; edit2.setfocus; end;
  if (trim(edit7.text)='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','Atenção',mb_ok); a:=1; edit7.setfocus; end;


  if (a=0) then begin

    if ((frmcadestudo.tag=1) or (frmcadestudo.tag=3)) then begin
      if ((trim(edit1.text)='0') or (trim(edit1.text)='')) then begin
        with data10.exemysql do begin
          sql.clear;
          x:='INSERT INTO estudo ';
          x:=x+'(codigo, ativo, igreja ,datainicio, amigo, dupla, estudo,licao,datavisita, observacoes, dataid, horaid, id) ';
          x:=x+'VALUES (NULL,';                               // codigo
          x:=x+#39+copy(eativo.Text,1,1)+#39+',';             // ativo
          x:=x+#39+frmprincipal.Configura[3]+#39+',';         // igreja
          x:=x+#39+mydata(dtinicio.text)+#39+',';             // datainicio
          x:=x+#39+edit5.text+#39+',';                        // amigo
          x:=x+#39+edit2.text+#39+',';                        // dupla
          x:=x+#39+edit7.text+#39+',';                        // estudo
          x:=x+#39+edit8.text+#39+',';                        // licao
          x:=x+#39+mydata(dtvisita.text)+#39+',';             // datavisita
          x:=x+#39+trim(memo1.Lines.Text)+#39+',';            // observacoes
          x:=x+#39+mydata(adataID.text)+#39+',';              // dataid
          x:=x+#39+ahoraID.text+#39+',';                      // horaid
          x:=x+#39+frmprincipal.Configura[1]+#39;             // id
          x:=x+')';
          sql.add(x);
          ExecSql;
          codcad.text:=voltauc('estudo','codigo','amigo='+edit5.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
          edit1.Text:=codcad.text;
        end;
      end;
      if (frmcadestudo.tag=1) then begin
        limpar;
        edit1.SetFocus;
      end;
      if (frmcadestudo.tag=3) then begin
        frmcadestudo.close;
      end;
    end;

    if (frmcadestudo.tag=2) then begin

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE estudo SET ';
        x:=x+'ativo='+#39+copy(eativo.Text,1,1)+#39+',';                        // ativo
        x:=x+'datainicio='+#39+mydata(dtinicio.text)+#39+',';                   // datainicio
        x:=x+'amigo='+#39+edit5.text+#39+',';                                   // amigo
        x:=x+'dupla='+#39+edit2.text+#39+',';                                   // dupla
        x:=x+'estudo='+#39+edit7.text+#39+',';                                  // estudo
        x:=x+'licao='+#39+edit8.text+#39+',';                                   // licao
        x:=x+'datavisita='+#39+mydata(dtvisita.text)+#39+',';                   // datavisita
        x:=x+'observacoes='+#39+trim(memo1.Lines.Text)+#39;                     // observacoes
        x:=x+' where codigo='+#39+edit1.text+#39;
        sql.add(x);
        ExecSql;
      end;
      frmcadestudo.close;
    end;
  end;
  bitbtn1.Enabled:=true;
end;

procedure Tfrmcadestudo.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadestudo.Edit1Enter(Sender: TObject);
begin
  TEdit(sender).SelStart:=1;
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcadestudo.ProcurarFamlia1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocamigo, frmlocamigo);
  frmlocamigo.showmodal;
  edit5.Text:=frmlocamigo.ocod.text;
  edit5.setfocus;
  frmlocamigo.Free;
end;


procedure Tfrmcadestudo.Edit5Exit(Sender: TObject);
var
  ax:string;
begin
  if edit5.text<>'' then begin
    ax:=trim(soletra(edit5.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocamigo, frmlocamigo);
      frmlocamigo.auxp.text:=trim(ax);
      frmlocamigo.showmodal;
      edit5.Text:=frmlocamigo.ocod.text;
      edit5.setfocus;
      frmlocamigo.Free;
    end else begin
      edit6.Text:=voltainfo('amigo','nome','codigo='+#39+edit5.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(edit6.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit5.setfocus;
      end;
    end;
  end;
end;

procedure Tfrmcadestudo.MenuItem1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocdupla, frmlocdupla);
  frmlocdupla.showmodal;
  edit2.Text:=frmlocdupla.ocod.text;
  edit2.setfocus;
  frmlocdupla.Free;
end;

procedure Tfrmcadestudo.Edit2Exit(Sender: TObject);
var
  ax:string;
begin
  if edit2.text<>'' then begin
    ax:=trim(soletra(edit2.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocdupla, frmlocdupla);
      frmlocdupla.auxp.text:=trim(ax);
      frmlocdupla.showmodal;
      edit2.Text:=frmlocdupla.ocod.text;
      edit2.setfocus;
      frmlocdupla.Free;
    end else begin
      edit3.Text:=voltainfo('dupla','descricao','codigo='+#39+edit2.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(edit3.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit2.setfocus;
      end;
    end;
  end;
end;

procedure Tfrmcadestudo.IncluirAmigo1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcadamigo, frmcadamigo);
  frmcadamigo.tag:=3;
  frmcadamigo.showmodal;
  edit5.Text:=frmcadamigo.codcad.Text;
  frmcadamigo.Free;
  edit5.setfocus;
end;

procedure Tfrmcadestudo.IncluirDupla1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcaddupla, frmcaddupla);
  frmcaddupla.tag:=3;
  frmcaddupla.showmodal;
  edit2.Text:=frmcaddupla.codcad.Text;
  frmcaddupla.Free;
  edit2.setfocus;
end;

procedure Tfrmcadestudo.MenuItem3Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocestudob, frmlocestudob);
  frmlocestudob.showmodal;
  edit7.Text:=frmlocestudob.ocod.text;
  edit7.setfocus;
  frmlocestudob.Free;
end;

procedure Tfrmcadestudo.Edit7Exit(Sender: TObject);
var
  ax:string;
begin
  if edit7.text<>'' then begin
    ax:=trim(soletra(edit7.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocestudob, frmlocestudob);
      frmlocestudob.auxp.text:=trim(ax);
      frmlocestudob.showmodal;
      edit7.Text:=frmlocestudob.ocod.text;
      edit7.setfocus;
      frmlocestudob.Free;
    end else begin
      edit4.Text:=voltainfo('material','descricao','codigo='+#39+edit7.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39+' and categoria='+#39+frmprincipal.Configura[9]+#39,'T','0');
      if (trim(edit4.Text)='') then begin
        application.MessageBox('Código não Encontrado','Atenção',mb_ok);
        edit7.setfocus;
      end;
    end;
  end;
end;

end.
