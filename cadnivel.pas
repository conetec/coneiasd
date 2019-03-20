unit cadnivel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ComCtrls, JvExComCtrls, JvComCtrls,
  JvCheckTreeView,funcoes;

type
  Tfrmcadnivel = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    nivel: TJvTreeView;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure nivelEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2Enter(Sender: TObject);
    procedure nivelDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadnivel: Tfrmcadnivel;

implementation

uses principal, datamodule10;

{$R *.dfm}


function seme(f:string):string;
var
  x:string;
  i:integer;
begin
  x:='';
  for i:=1 to length(f) do begin
    if f[i]<>'&' then begin
      x:=x+f[i];
    end;
  end;
  seme:=x;
end;


function voltacodnivel(frase:string):string;
var
  x:string;
  i,a:integer;
begin
  x:='';
  a:=0;
  if frase<>'' then begin
    for i:=1 to length(frase) do begin
      if (a=0) and (frase[i]<>'-') then begin
        x:=x+frase[i];
      end;
      if frase[i]='-' then begin
        a:=1;
      end;
    end;
  end;
  x:=trimleft(x);
  x:=trimright(x);
  voltacodnivel:=trim(x);
end;


procedure limpar();
var
  i:integer;
begin
  with frmcadnivel do begin
    edit1.text:='';
    edit2.text:='0';
    edit3.text:='';
    for i := 0 to nivel.Items.Count - 1 do begin
      nivel.Checked[nivel.Items[i]]:=true;
    end;
  end;
end;

procedure mostrar();
var
  i,k:integer;
  a,x:string;
begin
  with frmcadnivel do begin
    edit1.text:=data10.mytudo.fieldbyname('nivel').asstring;
    edit2.text:=data10.mytudo.fieldbyname('codigo').asstring;
    edit3.text:=data10.mytudo.fieldbyname('descricao').asstring;

    for i:=0 to nivel.items.count-1 do begin
      nivel.Checked[nivel.Items[i]]:=false;
    end;

    a:='';
    x:=edit1.text;
    for i:=1 to length(x) do begin
      if x[i]='*' then begin
        for k:=0 to nivel.items.count-1 do begin
          if voltacodnivel(nivel.Items[k].text)=a then begin
            nivel.Checked[nivel.Items[k]]:=true;
            break;
          end;
        end;
        a:='';
      end;
      if x[i]<>'*' then begin
        a:=a+x[i];
      end;
    end;




  end;
end;






procedure Tfrmcadnivel.FormActivate(Sender: TObject);
var
  i,i1,i2,i3,i4:integer;
  a:integer;
  x:string;
  n1,n2,n3,n4,n5: TTreeNode;
begin
  nivel.Items.Clear;
  for i:=0 to frmprincipal.MainMenu1.Items.count-1 do begin
    x:=trim(seme(frmprincipal.MainMenu1.Items[i].Caption));
    if x='-' then begin x:=x+' (Divisor de Menu)'; end;
    n1 := nivel.Items.Add(nil, inttostr(i)+' - '+x);
    for i1:=0 to frmprincipal.MainMenu1.Items[i].count-1 do begin
      x:=trim(seme(frmprincipal.MainMenu1.Items[i].Items[i1].Caption));
      if x='-' then begin x:=x+' (Divisor de Menu)'; end;
      n2:=nivel.Items.AddChild(n1,inttostr(i)+'.'+inttostr(i1)+' - '+x);
      for i2:=0 to frmprincipal.MainMenu1.Items[i].items[i1].count-1 do begin
        x:=trim(seme(frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Caption));
        if x='-' then begin x:=x+' (Divisor de Menu)'; end;
        n3:=nivel.Items.AddChild(n2,inttostr(i)+'.'+inttostr(i1)+'.'+inttostr(i2)+' - '+x);
        for i3:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].count-1 do begin
          x:=trim(seme(frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Caption));
          if x='-' then begin x:=x+' (Divisor de Menu)'; end;
          n4:=nivel.Items.AddChild(n3,inttostr(i)+'.'+inttostr(i1)+'.'+inttostr(i2)+'.'+inttostr(i3)+' - '+x);
          for i4:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].items[i3].count-1 do begin
            x:=trim(seme(frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Caption));
            if x='-' then begin x:=x+' (Divisor de Menu)'; end;
            n5:=nivel.Items.AddChild(n4,inttostr(i)+'.'+inttostr(i1)+'.'+inttostr(i2)+'.'+inttostr(i3)+'.'+inttostr(i4)+' - '+x);
          end;
        end;
      end;
    end;
  end;



  if frmcadnivel.tag=1 then begin
    frmcadnivel.Caption:='Inclusão de Nível';
    limpar();
    edit3.setfocus;
  end;
  if frmcadnivel.tag=2 then begin
    frmcadnivel.Caption:='Alteração de Nível';
    mostrar();
    edit3.setfocus;
  end;




end;

procedure Tfrmcadnivel.BitBtn1Click(Sender: TObject);
var
  i,a:integer;
  x:string;
begin

  x:='';
  for i:=nivel.items.count-1 downto 0 do begin
    if nivel.Checked[nivel.Items[i]]=true then begin
      x:=x+voltacodnivel(nivel.Items[i].Text)+'*';
    end;
  end;
  edit1.Text:=x;

  a:=0;
  if (edit3.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','ATENÇÃO!!!',mb_ok); a:=1; edit3.setfocus; end;
  if (frmcadnivel.tag=1) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='INSERT INTO nivel ';
      x:=x+'(Codigo, igreja, Descricao, nivel) ';
      x:=x+'VALUES (NULL,';             // codigo
      x:=x+#39+frmprincipal.Configura[3]+#39+','; // igreja
      x:=x+#39+edit3.text+#39+',';      // descricao
      x:=x+#39+edit1.text+#39;          // nivel
      x:=x+')';
      sql.add(x);
      ExecSql;
    end;
    limpar();
  end;

  if (frmcadnivel.tag=2) and (a=0) then begin
    with data10.exemysql do begin
      sql.clear;
      x:='UPDATE nivel SET ';
      x:=x+'descricao='+#39+edit3.text+#39+',';      // descricao
      x:=x+'nivel='+#39+edit1.text+#39;      // unidade
      x:=x+' where codigo='+#39+edit2.text+#39;
      sql.add(x);
      ExecSql;
    end;
  end;

  frmcadnivel.close;

end;

procedure Tfrmcadnivel.BitBtn3Click(Sender: TObject);
begin
  frmcadnivel.close;
end;

procedure Tfrmcadnivel.BitBtn2Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to nivel.items.count-1 do begin
    nivel.Checked[nivel.Items[i]]:=true;
    nivel.Checked[nivel.Items[i]]:=false;
  end;
  nivel.Refresh;
end;

procedure Tfrmcadnivel.BitBtn4Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to nivel.items.count-1 do begin
    nivel.Checked[nivel.Items[i]]:=false;
    nivel.Checked[nivel.Items[i]]:=true;
  end;
  nivel.Refresh;
end;

procedure Tfrmcadnivel.nivelEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit:=false;
end;

procedure Tfrmcadnivel.BitBtn5Click(Sender: TObject);
var
  x: byte;
begin
  For x := 0 to nivel.Items.Count - 1 do begin
    nivel.Items.Item[x].Expand(True);
  end;
  
end;

procedure Tfrmcadnivel.BitBtn6Click(Sender: TObject);
var
  x: byte;
begin
  For x := 0 to nivel.Items.Count - 1 do begin
    nivel.Items.Item[x].Collapse(True);
  end;
end;

procedure Tfrmcadnivel.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadnivel.Edit2Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcadnivel.nivelDblClick(Sender: TObject);
var
  x,x1:string;
  onivel,i:integer;
  opb,opb2:boolean;
begin
  opb:=true;
  opb2:=false;
  onivel:=nivel.ItemIndex;
  if nivel.Checked[nivel.Items[onivel]]=true then begin opb:=false; opb2:=true; end;
  x:=voltacod(nivel.Items[onivel].Text,'-',0);
  x:=voltacod(x,'.',0);
  for i:=nivel.items.count-1 downto 0 do begin
    x1:=voltacod(nivel.Items[i].Text,'-',0);
    x1:=voltacod(x1,'.',0);
    if (trim(x1)=trim(x)) then begin
      nivel.Checked[nivel.Items[i]]:=opb;
      nivel.Checked[nivel.Items[i]]:=opb2;
      nivel.Refresh;


    end;
  end;
end;

end.
