unit selchamada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, funcaolocal, funcoes;

type
  Tfrmselchamada = class(TForm)
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
    procedure FormShow(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7Enter(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmselchamada: Tfrmselchamada;
  xdti,xdtf:string;

implementation

uses principal, datamodule10, chamadaes;

{$R *.dfm}

procedure Tfrmselchamada.FormShow(Sender: TObject);
var
  x,dtp:string;
  nsab:integer;
begin
  x:=voltainfo('trimestre','codigo|descricao|datai|dataf','ativo='+#39+'S'+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T|T|D|D','0');
  if trim(x)='' then begin
    frmselchamada.Close;
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
      while eof=false do begin
        combobox1.Items.add(fieldbyname('descricao').asstring);
        cax1.Items.add(fieldbyname('codigo').asstring);
        next;
      end;
      combobox1.ItemIndex:=0;
    end;


    combobox2.Items.Clear;

    with data10.myaux do begin
      close;
      sql.clear;
      x:='select codigo,descricao from classe where igreja='+#39+frmprincipal.Configura[3]+#39+' and ativo='+#39+'S'+#39+' order by descricao';
      sql.add(x);
      open;
      first;
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

procedure Tfrmselchamada.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmselchamada.Edit7Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmselchamada.BitBtn2Click(Sender: TObject);
begin
  frmselchamada.close;
end;

procedure Tfrmselchamada.BitBtn1Click(Sender: TObject);
var
  x,xp:string;
begin
  cax1.ItemIndex:=combobox1.ItemIndex;
  xp:='trimestre='+#39+otrimestre.text+#39;
  xp:=xp+' and igreja='+#39+frmprincipal.Configura[3]+#39;
  xp:=xp+' and classe='+#39+cax1.Text+#39;
  xp:=xp+' and datamov='+#39+mydata(voltacod(combobox2.Text,' ',1))+#39;
  x:=voltainfo('chamada_es','codigo',xp,'T','0');
  if trim(x)='' then begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO chamada_es ';
      x:=x+'(codigo, datamov, classe, trimestre, igreja) ';
      x:=x+'VALUES (NULL,';                                          // codigo
      x:=x+#39+mydata(voltacod(combobox2.Text,' ',1))+#39+',';       // datamov
      x:=x+#39+cax1.Text+#39+',';                                    // classe
      x:=x+#39+otrimestre.text+#39+',';                              // trimestre
      x:=x+#39+frmprincipal.Configura[3]+#39;                        // igreja
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    achamada.text:=voltainfo('chamada_es','codigo',xp,'T','0');
  end else begin
    achamada.text:=x;
  end;
  Application.CreateForm(Tfrmchamadaes, frmchamadaes);
  frmchamadaes.Edit7.Text:=voltacod(combobox2.Text,' ',1);
  frmchamadaes.Edit1.Text:=combobox1.text;
  frmchamadaes.showmodal;
  frmchamadaes.Free;
end;

end.
