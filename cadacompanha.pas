unit cadacompanha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, JvExMask,
  JvToolEdit ;

type
  Tfrmcadacompanha = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    codcad: TEdit;
    adataID: TEdit;
    ahoraID: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label11: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    dtmov: TJvDateEdit;
    Memo1: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure mostrar;
    procedure Edit1Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadacompanha: Tfrmcadacompanha;

implementation

uses datamodule10, principal;

{$R *.DFM}


procedure Tfrmcadacompanha.mostrar;
var
  i:integer;
  x:string;
begin
  frmprincipal.c_agora;

  with data10.mymostra do begin
    close;
    sql.clear;
    x:='select * from visita_solicita';
    x:=x+' where codigo='+#39+edit1.Text+#39;
    sql.add(x);
    open;
  end;

  dtmov.Text:=data10.mymostra.fieldbyname('dataresposta').asstring;

  combobox1.ItemIndex:=-1;
  for i:=0 to combobox1.Items.Count-1 do begin
    if copy(combobox1.Items[i],1,1)=data10.mymostra.fieldbyname('resposta').asstring then begin
      combobox1.ItemIndex:=i;
      break;
    end;
  end;

  memo1.lines.clear;
  memo1.lines.add(data10.mymostra.fieldbyname('observacao').value);
  memo1.text:=trim(memo1.Text);


end;


procedure Tfrmcadacompanha.FormActivate(Sender: TObject);
begin
  frmcadacompanha.caption:='Resposta de Acompanhamento';
  mostrar;
  edit1.SetFocus;
end;

procedure Tfrmcadacompanha.BitBtn2Click(Sender: TObject);
begin
  frmcadacompanha.close;
end;

procedure Tfrmcadacompanha.BitBtn1Click(Sender: TObject);
var
  x:string;
  a:integer;
begin
  frmprincipal.c_agora;
  a:=0;
  if combobox1.text='SIM' then begin
    if trim(dtmov.Text)='/  /' then begin
      dtmov.Text:=formatdatetime('dd/mm/yyyy',date);
    end;
  end else begin
    dtmov.Text:='';
  end;

  if (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE visita_solicita SET ';
      x:=x+'observacao='+#39+trim(memo1.Text)+#39+',';               // observacao
      x:=x+'dataresposta='+#39+mydata(dtmov.Text)+#39+',';           // dataresposta
      x:=x+'resposta='+#39+copy(combobox1.Text,1,1)+#39;             // ativo
      x:=x+' where codigo='+#39+edit1.text+#39;
      sql.add(x);
      ExecSql;
    end;
    frmcadacompanha.close;
  end;

end;

procedure Tfrmcadacompanha.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadacompanha.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

end.
