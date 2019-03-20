unit caddupla;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, ExtCtrls, Menus, ComCtrls,
  JvExMask, JvToolEdit, funcaolocal, Grids, DBGrids, jpeg;

type
  Tfrmcaddupla = class(TForm)
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
    dtcadastro: TJvDateEdit;
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
    GroupBox1: TGroupBox;
    d1: TCheckBox;
    d2: TCheckBox;
    d3: TCheckBox;
    d4: TCheckBox;
    GroupBox2: TGroupBox;
    d01: TCheckBox;
    d01m: TCheckBox;
    d01t: TCheckBox;
    d01n: TCheckBox;
    d02: TCheckBox;
    d02m: TCheckBox;
    d02t: TCheckBox;
    d02n: TCheckBox;
    d03: TCheckBox;
    d03m: TCheckBox;
    d03t: TCheckBox;
    d03n: TCheckBox;
    d04: TCheckBox;
    d04m: TCheckBox;
    d04t: TCheckBox;
    d04n: TCheckBox;
    d05: TCheckBox;
    d05m: TCheckBox;
    d05t: TCheckBox;
    d05n: TCheckBox;
    d06: TCheckBox;
    d06m: TCheckBox;
    d06t: TCheckBox;
    d06n: TCheckBox;
    d07: TCheckBox;
    d07m: TCheckBox;
    d07t: TCheckBox;
    d07n: TCheckBox;
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
    function jaedupla(ocodp:string):boolean;
    procedure Edit7Exit(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure d01mClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcaddupla: Tfrmcaddupla;
  ultnome,gravar:string;

implementation

uses datamodule10, principal, locinstrutor;


{$R *.DFM}


procedure Tfrmcaddupla.limpar;
begin
  bitbtn1.Enabled:=true;

  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);

  edit1.Text:='0';
  eativo.ItemIndex:=0;
  dtcadastro.Text:=formatdatetime('dd/mm/yyyy',date);

  edit5.Text:='';
  edit6.Text:='';
  edit2.Text:='';
  edit3.Text:='';
  edit7.Text:='';
  edit4.Text:='';

  d1.Checked:=false;
  d2.Checked:=false;
  d3.Checked:=false;
  d4.Checked:=false;

  d01.Checked:=false;
  d02.Checked:=false;
  d03.Checked:=false;
  d04.Checked:=false;
  d05.Checked:=false;
  d06.Checked:=false;
  d07.Checked:=false;

  d01m.Checked:=false;
  d02m.Checked:=false;
  d03m.Checked:=false;
  d04m.Checked:=false;
  d05m.Checked:=false;
  d06m.Checked:=false;
  d07m.Checked:=false;

  d01t.Checked:=false;
  d02t.Checked:=false;
  d03t.Checked:=false;
  d04t.Checked:=false;
  d05t.Checked:=false;
  d06t.Checked:=false;
  d07t.Checked:=false;

  d01n.Checked:=false;
  d02n.Checked:=false;
  d03n.Checked:=false;
  d04n.Checked:=false;
  d05n.Checked:=false;
  d06n.Checked:=false;
  d07n.Checked:=false;


  memo1.Lines.Clear;

end;


procedure Tfrmcaddupla.mostrar;
var
  i:integer;
begin

  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  dtcadastro.Text:=data10.mymostra.fieldbyname('datacad').asstring;

  edit5.Text:=data10.mymostra.fieldbyname('instrutor1').asstring;
  edit6.Text:=voltainfo('membro','nome','codigo='+#39+edit5.Text+#39,'T','0');

  edit2.Text:=data10.mymostra.fieldbyname('instrutor2').asstring;
  edit3.Text:=voltainfo('membro','nome','codigo='+#39+edit2.Text+#39,'T','0');

  edit7.Text:=data10.mymostra.fieldbyname('instrutor3').asstring;
  edit4.Text:=voltainfo('membro','nome','codigo='+#39+edit7.Text+#39,'T','0');


  if data10.mymostra.fieldbyname('op1').value=1 then begin d1.Checked:=true; end else begin d1.Checked:=false; end;
  if data10.mymostra.fieldbyname('op2').value=1 then begin d2.Checked:=true; end else begin d2.Checked:=false; end;
  if data10.mymostra.fieldbyname('op3').value=1 then begin d3.Checked:=true; end else begin d3.Checked:=false; end;
  if data10.mymostra.fieldbyname('op4').value=1 then begin d4.Checked:=true; end else begin d4.Checked:=false; end;

  if data10.mymostra.fieldbyname('dom').value='S' then begin d01.Checked:=true; end else begin d01.Checked:=false; end;
  if data10.mymostra.fieldbyname('seg').value='S' then begin d02.Checked:=true; end else begin d02.Checked:=false; end;
  if data10.mymostra.fieldbyname('ter').value='S' then begin d03.Checked:=true; end else begin d03.Checked:=false; end;
  if data10.mymostra.fieldbyname('qua').value='S' then begin d04.Checked:=true; end else begin d04.Checked:=false; end;
  if data10.mymostra.fieldbyname('qui').value='S' then begin d05.Checked:=true; end else begin d05.Checked:=false; end;
  if data10.mymostra.fieldbyname('sex').value='S' then begin d06.Checked:=true; end else begin d06.Checked:=false; end;
  if data10.mymostra.fieldbyname('sab').value='S' then begin d07.Checked:=true; end else begin d07.Checked:=false; end;

  if data10.mymostra.fieldbyname('d01m').value='S' then begin d01m.Checked:=true; end else begin d01m.Checked:=false; end;
  if data10.mymostra.fieldbyname('d02m').value='S' then begin d02m.Checked:=true; end else begin d02m.Checked:=false; end;
  if data10.mymostra.fieldbyname('d03m').value='S' then begin d03m.Checked:=true; end else begin d03m.Checked:=false; end;
  if data10.mymostra.fieldbyname('d04m').value='S' then begin d04m.Checked:=true; end else begin d04m.Checked:=false; end;
  if data10.mymostra.fieldbyname('d05m').value='S' then begin d05m.Checked:=true; end else begin d05m.Checked:=false; end;
  if data10.mymostra.fieldbyname('d06m').value='S' then begin d06m.Checked:=true; end else begin d06m.Checked:=false; end;
  if data10.mymostra.fieldbyname('d07m').value='S' then begin d07m.Checked:=true; end else begin d07m.Checked:=false; end;

  if data10.mymostra.fieldbyname('d01t').value='S' then begin d01t.Checked:=true; end else begin d01t.Checked:=false; end;
  if data10.mymostra.fieldbyname('d02t').value='S' then begin d02t.Checked:=true; end else begin d02t.Checked:=false; end;
  if data10.mymostra.fieldbyname('d03t').value='S' then begin d03t.Checked:=true; end else begin d03t.Checked:=false; end;
  if data10.mymostra.fieldbyname('d04t').value='S' then begin d04t.Checked:=true; end else begin d04t.Checked:=false; end;
  if data10.mymostra.fieldbyname('d05t').value='S' then begin d05t.Checked:=true; end else begin d05t.Checked:=false; end;
  if data10.mymostra.fieldbyname('d06t').value='S' then begin d06t.Checked:=true; end else begin d06t.Checked:=false; end;
  if data10.mymostra.fieldbyname('d07t').value='S' then begin d07t.Checked:=true; end else begin d07t.Checked:=false; end;

  if data10.mymostra.fieldbyname('d01n').value='S' then begin d01n.Checked:=true; end else begin d01n.Checked:=false; end;
  if data10.mymostra.fieldbyname('d02n').value='S' then begin d02n.Checked:=true; end else begin d02n.Checked:=false; end;
  if data10.mymostra.fieldbyname('d03n').value='S' then begin d03n.Checked:=true; end else begin d03n.Checked:=false; end;
  if data10.mymostra.fieldbyname('d04n').value='S' then begin d04n.Checked:=true; end else begin d04n.Checked:=false; end;
  if data10.mymostra.fieldbyname('d05n').value='S' then begin d05n.Checked:=true; end else begin d05n.Checked:=false; end;
  if data10.mymostra.fieldbyname('d06n').value='S' then begin d06n.Checked:=true; end else begin d06n.Checked:=false; end;
  if data10.mymostra.fieldbyname('d07n').value='S' then begin d07n.Checked:=true; end else begin d07n.Checked:=false; end;

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


procedure Tfrmcaddupla.FormActivate(Sender: TObject);
begin
  if (frmcaddupla.tag=1) or (frmcaddupla.tag=3) then begin
    frmcaddupla.caption:='Inclusão de Dupla Missionária';
    limpar();
    edit1.SetFocus;
  end;
  if frmcaddupla.tag=2 then begin
    frmcaddupla.caption:='Alteração de Dupla Missionária';
    limpar;
    mostrar;
    edit1.SetFocus;
  end;
end;

procedure Tfrmcaddupla.BitBtn2Click(Sender: TObject);
begin
  frmcaddupla.close;
end;

function peu(wnome:string):string;
var
  wax,wp,wu:string;
  nespacos,s:integer;
begin
  nespacos:=0;
  for s:=0 to length(wnome) do begin
    if wnome[s]=' ' then begin
      nespacos:=nespacos+1;
    end;
  end;
  wp:=voltacod(wnome,' ',0);
  wu:=voltacod(wnome,' ',nespacos);
  wax:=wp+' '+wu;
  peu:=wax;
end;

procedure Tfrmcaddupla.BitBtn1Click(Sender: TObject);
var
  x,narq,nomedupla:string;
  xo1,xo2,xo3,xo4,xo5,dd:string;
  a:integer;
  dsemana:string;
begin


  // Domingo - M T N | Segunda - M T N | Terça - M T N | Quarta - M T N | Quinta M T N | Sexta - M T N | Sábado - M T N |
  dsemana:='';
  if d01.Checked=true then begin
    dsemana:=dsemana+'| Dom -';
    if d01m.Checked=true then begin dsemana:=dsemana+' M ';end;
    if d01t.Checked=true then begin dsemana:=dsemana+' T ';end;
    if d01n.Checked=true then begin dsemana:=dsemana+' N ';end;
  end;

  if d02.Checked=true then begin
    dsemana:=dsemana+'| Seg -';
    if d02m.Checked=true then begin dsemana:=dsemana+' M ';end;
    if d02t.Checked=true then begin dsemana:=dsemana+' T ';end;
    if d02n.Checked=true then begin dsemana:=dsemana+' N ';end;
  end;

  if d03.Checked=true then begin
    dsemana:=dsemana+'| Ter -';
    if d03m.Checked=true then begin dsemana:=dsemana+' M ';end;
    if d03t.Checked=true then begin dsemana:=dsemana+' T ';end;
    if d03n.Checked=true then begin dsemana:=dsemana+' N ';end;
  end;

  if d04.Checked=true then begin
    dsemana:=dsemana+'| Qua -';
    if d04m.Checked=true then begin dsemana:=dsemana+' M ';end;
    if d04t.Checked=true then begin dsemana:=dsemana+' T ';end;
    if d04n.Checked=true then begin dsemana:=dsemana+' N ';end;
  end;

  if d05.Checked=true then begin
    dsemana:=dsemana+'| Qui -';
    if d05m.Checked=true then begin dsemana:=dsemana+' M ';end;
    if d05t.Checked=true then begin dsemana:=dsemana+' T ';end;
    if d05n.Checked=true then begin dsemana:=dsemana+' N ';end;
  end;

  if d06.Checked=true then begin
    dsemana:=dsemana+'| Sex -';
    if d06m.Checked=true then begin dsemana:=dsemana+' M ';end;
    if d06t.Checked=true then begin dsemana:=dsemana+' T ';end;
    if d06n.Checked=true then begin dsemana:=dsemana+' N ';end;
  end;

  if d07.Checked=true then begin
    dsemana:=dsemana+'| Sáb -';
    if d07m.Checked=true then begin dsemana:=dsemana+' M ';end;
    if d07t.Checked=true then begin dsemana:=dsemana+' T ';end;
    if d07n.Checked=true then begin dsemana:=dsemana+' N ';end;
  end;

  xo1:='0'; xo2:='0'; xo3:='0'; xo4:='0'; xo5:='0';
  dd:='';
  if d1.Checked=true then begin xo1:='1'; dd:=dd+'- Estudo '; end;
  if d2.Checked=true then begin xo2:='1'; dd:=dd+'- Visitação '; end;
  if d3.Checked=true then begin xo3:='1'; dd:=dd+'- Literatura '; end;
  if d4.Checked=true then begin xo4:='1'; dd:=dd+'- Membros '; end;
  if length(trim(dd))>0 then begin dd:=copy(dd,2,length(trim(dd))-1); end;
  dd:=trim(dd);



  bitbtn1.Enabled:=false;
  frmprincipal.c_agora;


  nomedupla:=peu(edit6.Text)+' - '+peu(edit3.Text);
  if trim(edit4.text)<>'' then begin
    nomedupla:=nomedupla+' - '+peu(edit4.Text);
  end;
  a:=0;
  if (edit5.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','Atenção',mb_ok); a:=1; edit5.setfocus; end;
  if (edit2.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório!','Atenção',mb_ok); a:=1; edit2.setfocus; end;
  if (trim(edit2.text)=trim(edit5.text)) and (a=0) then begin application.MessageBox('Instrutor 01 e Instrutor 02 são Iguais!','Atenção',mb_ok); a:=1; edit2.setfocus; end;


  if (a=0) then begin

    if ((frmcaddupla.tag=1) or (frmcaddupla.tag=3)) then begin
      if ((trim(edit1.text)='0') or (trim(edit1.text)='')) then begin
        with data10.exemysql do begin
          sql.clear;
          x:='INSERT INTO dupla ';
          x:=x+'(codigo, ativo, igreja ,datacad,  disponivel,descricao, instrutor1, instrutor2, instrutor3,op1,op2,op3,op4,op5,descricaoop, observacoes,';
          x:=x+' dom,seg,ter,qua,qui,sex,sab,d01m,d02m,d03m,d04m,d05m,d06m,d07m,d01t,d02t,d03t,d04t,d05t,d06t,d07t,d01n,d02n,d03n,d04n,d05n,d06n,d07n,';
          x:=x+' dataid, horaid, id) ';
          x:=x+'VALUES (NULL,';                               // codigo
          x:=x+#39+copy(eativo.Text,1,1)+#39+',';             // ativo
          x:=x+#39+frmprincipal.Configura[3]+#39+',';         // igreja
          x:=x+#39+mydata(dtcadastro.text)+#39+',';           // datacad
          x:=x+#39+trim(dsemana)+#39+',';                     // disponivel
          x:=x+#39+nomedupla+#39+',';                         // descricao
          x:=x+#39+edit5.text+#39+',';                        // instrutor1
          x:=x+#39+edit2.text+#39+',';                        // instrutor2
          x:=x+#39+edit7.text+#39+',';                        // instrutor3
          x:=x+#39+xo1+#39+',';                               // op1
          x:=x+#39+xo2+#39+',';                               // op2
          x:=x+#39+xo3+#39+',';                               // op3
          x:=x+#39+xo4+#39+',';                               // op4
          x:=x+#39+xo5+#39+',';                               // op5
          x:=x+#39+dd+#39+',';                                // descricaoop
          x:=x+#39+trim(memo1.Lines.Text)+#39+',';            // observacoes
          if d01.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d02.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d03.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d04.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d05.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d06.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d07.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d01m.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d02m.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d03m.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d04m.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d05m.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d06m.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d07m.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d01t.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d02t.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d03t.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d04t.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d05t.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d06t.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d07t.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d01n.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d02n.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d03n.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d04n.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d05n.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d06n.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          if d07n.Checked=true then begin x:=x+#39+'S'+#39+','; end else begin x:=x+#39+'N'+#39+','; end;
          x:=x+#39+mydata(adataID.text)+#39+',';              // dataid
          x:=x+#39+ahoraID.text+#39+',';                      // horaid
          x:=x+#39+frmprincipal.Configura[1]+#39;             // id
          x:=x+')';
          sql.add(x);
          ExecSql;
          codcad.text:=voltauc('dupla','codigo','instrutor1='+edit5.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);
          edit1.Text:=codcad.text;
        end;
      end;
      if (frmcaddupla.tag=1) then begin
        limpar;
        edit1.SetFocus;
      end;
      if (frmcaddupla.tag=3) then begin
        frmcaddupla.close;
      end;
    end;

    if (frmcaddupla.tag=2) then begin

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE dupla SET ';
        x:=x+'ativo='+#39+copy(eativo.Text,1,1)+#39+',';                        // ativo
        x:=x+'datacad='+#39+mydata(dtcadastro.text)+#39+',';                    // datacad
        x:=x+'descricao='+#39+nomedupla+#39+',';                                // descricao
        x:=x+'instrutor1='+#39+edit5.text+#39+',';                              // instrutor1
        x:=x+'instrutor2='+#39+edit2.text+#39+',';                              // instrutor2
        x:=x+'instrutor3='+#39+edit7.text+#39+',';                              // instrutor3

        x:=x+'op1='+#39+xo1+#39+',';                                            // op1
        x:=x+'op2='+#39+xo2+#39+',';                                            // op2
        x:=x+'op3='+#39+xo3+#39+',';                                            // op3
        x:=x+'op4='+#39+xo4+#39+',';                                            // op4
        x:=x+'op5='+#39+xo5+#39+',';                                            // op5
        x:=x+'descricaoop='+#39+dd+#39+',';                                     // descricaoop
        x:=x+'disponivel='+#39+trim(dsemana)+#39+',';                           // disponivel


          if d01.Checked=true then begin x:=x+'dom='+#39+'S'+#39+','; end else begin x:=x+'dom='+#39+'N'+#39+','; end;
          if d02.Checked=true then begin x:=x+'seg='+#39+'S'+#39+','; end else begin x:=x+'seg='+#39+'N'+#39+','; end;
          if d03.Checked=true then begin x:=x+'ter='+#39+'S'+#39+','; end else begin x:=x+'ter='+#39+'N'+#39+','; end;
          if d04.Checked=true then begin x:=x+'qua='+#39+'S'+#39+','; end else begin x:=x+'qua='+#39+'N'+#39+','; end;
          if d05.Checked=true then begin x:=x+'qui='+#39+'S'+#39+','; end else begin x:=x+'qui='+#39+'N'+#39+','; end;
          if d06.Checked=true then begin x:=x+'sex='+#39+'S'+#39+','; end else begin x:=x+'sex='+#39+'N'+#39+','; end;
          if d07.Checked=true then begin x:=x+'sab='+#39+'S'+#39+','; end else begin x:=x+'sab='+#39+'N'+#39+','; end;

          if d01m.Checked=true then begin x:=x+'d01m='+#39+'S'+#39+','; end else begin x:=x+'d01m='+#39+'N'+#39+','; end;
          if d02m.Checked=true then begin x:=x+'d02m='+#39+'S'+#39+','; end else begin x:=x+'d02m='+#39+'N'+#39+','; end;
          if d03m.Checked=true then begin x:=x+'d03m='+#39+'S'+#39+','; end else begin x:=x+'d03m='+#39+'N'+#39+','; end;
          if d04m.Checked=true then begin x:=x+'d04m='+#39+'S'+#39+','; end else begin x:=x+'d04m='+#39+'N'+#39+','; end;
          if d05m.Checked=true then begin x:=x+'d05m='+#39+'S'+#39+','; end else begin x:=x+'d05m='+#39+'N'+#39+','; end;
          if d06m.Checked=true then begin x:=x+'d06m='+#39+'S'+#39+','; end else begin x:=x+'d06m='+#39+'N'+#39+','; end;
          if d07m.Checked=true then begin x:=x+'d07m='+#39+'S'+#39+','; end else begin x:=x+'d07m='+#39+'N'+#39+','; end;

          if d01t.Checked=true then begin x:=x+'d01t='+#39+'S'+#39+','; end else begin x:=x+'d01t='+#39+'N'+#39+','; end;
          if d02t.Checked=true then begin x:=x+'d02t='+#39+'S'+#39+','; end else begin x:=x+'d02t='+#39+'N'+#39+','; end;
          if d03t.Checked=true then begin x:=x+'d03t='+#39+'S'+#39+','; end else begin x:=x+'d03t='+#39+'N'+#39+','; end;
          if d04t.Checked=true then begin x:=x+'d04t='+#39+'S'+#39+','; end else begin x:=x+'d04t='+#39+'N'+#39+','; end;
          if d05t.Checked=true then begin x:=x+'d05t='+#39+'S'+#39+','; end else begin x:=x+'d05t='+#39+'N'+#39+','; end;
          if d06t.Checked=true then begin x:=x+'d06t='+#39+'S'+#39+','; end else begin x:=x+'d06t='+#39+'N'+#39+','; end;
          if d07t.Checked=true then begin x:=x+'d07t='+#39+'S'+#39+','; end else begin x:=x+'d07t='+#39+'N'+#39+','; end;


          if d01n.Checked=true then begin x:=x+'d01n='+#39+'S'+#39+','; end else begin x:=x+'d01n='+#39+'N'+#39+','; end;
          if d02n.Checked=true then begin x:=x+'d02n='+#39+'S'+#39+','; end else begin x:=x+'d02n='+#39+'N'+#39+','; end;
          if d03n.Checked=true then begin x:=x+'d03n='+#39+'S'+#39+','; end else begin x:=x+'d03n='+#39+'N'+#39+','; end;
          if d04n.Checked=true then begin x:=x+'d04n='+#39+'S'+#39+','; end else begin x:=x+'d04n='+#39+'N'+#39+','; end;
          if d05n.Checked=true then begin x:=x+'d05n='+#39+'S'+#39+','; end else begin x:=x+'d05n='+#39+'N'+#39+','; end;
          if d06n.Checked=true then begin x:=x+'d06n='+#39+'S'+#39+','; end else begin x:=x+'d06n='+#39+'N'+#39+','; end;
          if d07n.Checked=true then begin x:=x+'d07n='+#39+'S'+#39+','; end else begin x:=x+'d07n='+#39+'N'+#39+','; end;




        x:=x+'observacoes='+#39+trim(memo1.Lines.Text)+#39;                     // observacoes
        x:=x+' where codigo='+#39+edit1.text+#39;
        sql.add(x);
        ExecSql;
      end;
      frmcaddupla.close;
    end;
  end;
end;

procedure Tfrmcaddupla.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcaddupla.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcaddupla.ProcurarFamlia1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocinstrutor, frmlocinstrutor);
  frmlocinstrutor.showmodal;
  edit5.Text:=frmlocinstrutor.ocod.text;
  edit5.setfocus;
  frmlocinstrutor.Free;
end;

function Tfrmcaddupla.jaedupla(ocodp:string):boolean;
var
  edp:string;
  resposta:boolean;
begin
  resposta:=false;
  edp:='select a.nome,b.codigo,b.descricao from membro a left join dupla b on (a.codigo=b.instrutor1) where ((b.instrutor1='+#39+ocodp+#39+')) limit 0,1';
  data10.myedupla.close;
  data10.myedupla.sql.clear;
  data10.myedupla.sql.add(edp);
  data10.myedupla.open;
  if data10.myedupla.recordcount=1 then begin
    resposta:=true;
    edp:='Membro: '+data10.myedupla.fieldbyname('nome').asstring+#13;
    edp:=edp+'já pertence a uma dupla missionária!'+#13;
    edp:=edp+'Cód. '+data10.myedupla.fieldbyname('codigo').asstring+#13;
    edp:=edp+data10.myedupla.fieldbyname('descricao').asstring;
    application.MessageBox(pchar(edp),'Atenção',mb_ok);
  end;
  if resposta=false then begin
    edp:='select a.nome,b.codigo,b.descricao from membro a left join dupla b on (a.codigo=b.instrutor2) where ((b.instrutor2='+#39+ocodp+#39+')) limit 0,1';
    data10.myedupla.close;
    data10.myedupla.sql.clear;
    data10.myedupla.sql.add(edp);
    data10.myedupla.open;
    if data10.myedupla.recordcount=1 then begin
      resposta:=true;
      edp:='Membro: '+data10.myedupla.fieldbyname('nome').asstring+#13;
      edp:=edp+'já pertence a uma dupla missionária!'+#13;
      edp:=edp+'Cód. '+data10.myedupla.fieldbyname('codigo').asstring+#13;
      edp:=edp+data10.myedupla.fieldbyname('descricao').asstring;
      application.MessageBox(pchar(edp),'Atenção',mb_ok);
    end;
  end;

  jaedupla:=resposta;
end;

procedure Tfrmcaddupla.Edit5Exit(Sender: TObject);
var
  ax:string;
begin
  if edit5.text<>'' then begin
    ax:=trim(soletra(edit5.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocinstrutor, frmlocinstrutor);
      frmlocinstrutor.auxp.text:=trim(ax);
      frmlocinstrutor.showmodal;
      edit5.Text:=frmlocinstrutor.ocod.text;
      edit5.setfocus;
      frmlocinstrutor.Free;
    end else begin
      edit6.Text:=voltainfo('membro','nome','codigo='+#39+edit5.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39+' and instrutor='+#39+'SIM'+#39,'T','0');
      if (trim(edit6.Text)='') then begin
        application.MessageBox('Código não Encontrado','Atenção',mb_ok);
        edit5.setfocus;
      end else begin
        if jaedupla(edit5.Text)=true then begin
         // edit5.setfocus;
        end;
      end;
    end;
  end;
end;

procedure Tfrmcaddupla.MenuItem1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocinstrutor, frmlocinstrutor);
  frmlocinstrutor.showmodal;
  edit2.Text:=frmlocinstrutor.ocod.text;
  edit2.setfocus;
  frmlocinstrutor.Free;
end;

procedure Tfrmcaddupla.Edit2Exit(Sender: TObject);
var
  ax:string;
begin
  if edit2.text<>'' then begin
    ax:=trim(soletra(edit2.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocinstrutor, frmlocinstrutor);
      frmlocinstrutor.auxp.text:=trim(ax);
      frmlocinstrutor.showmodal;
      edit2.Text:=frmlocinstrutor.ocod.text;
      edit2.setfocus;
      frmlocinstrutor.Free;
    end else begin
      edit3.Text:=voltainfo('membro','nome','codigo='+#39+edit2.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39+' and instrutor='+#39+'SIM'+#39,'T','0');
      if (trim(edit3.Text)='') then begin
        application.MessageBox('Código não Encontrado','Atenção',mb_ok);
        edit2.setfocus;
      end else begin
        if jaedupla(edit2.Text)=true then begin
          // edit2.setfocus;
        end;
      end;
    end;
  end;
end;

procedure Tfrmcaddupla.Edit7Exit(Sender: TObject);
var
  ax:string;
begin
  if edit7.text<>'' then begin
    ax:=trim(soletra(edit7.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocinstrutor, frmlocinstrutor);
      frmlocinstrutor.auxp.text:=trim(ax);
      frmlocinstrutor.showmodal;
      edit7.Text:=frmlocinstrutor.ocod.text;
      edit7.setfocus;
      frmlocinstrutor.Free;
    end else begin
      edit4.Text:=voltainfo('membro','nome','codigo='+#39+edit7.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39+' and instrutor='+#39+'SIM'+#39,'T','0');
      if (trim(edit4.Text)='') then begin
        application.MessageBox('Código não Encontrado','Atenção',mb_ok);
        edit7.setfocus;
      end else begin
        if jaedupla(edit7.Text)=true then begin
          // edit7.setfocus;
        end;
      end;
    end;
  end;

end;

procedure Tfrmcaddupla.MenuItem3Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocinstrutor, frmlocinstrutor);
  frmlocinstrutor.showmodal;
  edit7.Text:=frmlocinstrutor.ocod.text;
  edit7.setfocus;
  frmlocinstrutor.Free;
end;

procedure Tfrmcaddupla.d01mClick(Sender: TObject);
var
  marca:boolean;
begin
 marca:=false;
 if d01m.Checked=true then begin marca:=true; end;
 if d01t.Checked=true then begin marca:=true; end;
 if d01n.Checked=true then begin marca:=true; end;
 d01.Checked:=marca;

 marca:=false;
 if d02m.Checked=true then begin marca:=true; end;
 if d02t.Checked=true then begin marca:=true; end;
 if d02n.Checked=true then begin marca:=true; end;
 d02.Checked:=marca;

 marca:=false;
 if d03m.Checked=true then begin marca:=true; end;
 if d03t.Checked=true then begin marca:=true; end;
 if d03n.Checked=true then begin marca:=true; end;
 d03.Checked:=marca;

 marca:=false;
 if d04m.Checked=true then begin marca:=true; end;
 if d04t.Checked=true then begin marca:=true; end;
 if d04n.Checked=true then begin marca:=true; end;
 d04.Checked:=marca;

 marca:=false;
 if d05m.Checked=true then begin marca:=true; end;
 if d05t.Checked=true then begin marca:=true; end;
 if d05n.Checked=true then begin marca:=true; end;
 d05.Checked:=marca;

 marca:=false;
 if d06m.Checked=true then begin marca:=true; end;
 if d06t.Checked=true then begin marca:=true; end;
 if d06n.Checked=true then begin marca:=true; end;
 d06.Checked:=marca;

 marca:=false;
 if d07m.Checked=true then begin marca:=true; end;
 if d07t.Checked=true then begin marca:=true; end;
 if d07n.Checked=true then begin marca:=true; end;
 d07.Checked:=marca;


end;

end.
