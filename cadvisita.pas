unit cadvisita;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons,db, funcoes, funcaolocal, JvExMask,
  JvToolEdit, Menus, CheckLst ;

type
  Tfrmcadvisita = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    codcad: TEdit;
    adataID: TEdit;
    ahoraID: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    dtcad: TJvDateEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label17: TLabel;
    PopupMenu1: TPopupMenu;
    CadastrarFamilia1: TMenuItem;
    ProcurarFamlia1: TMenuItem;
    sair1: TMenuItem;
    GroupBox1: TGroupBox;
    r1: TRadioButton;
    r2: TRadioButton;
    GroupBox2: TGroupBox;
    r3: TRadioButton;
    r4: TRadioButton;
    GroupBox3: TGroupBox;
    osolicita: TCheckListBox;
    Label6: TLabel;
    Edit2: TEdit;
    acopia: TMemo;
    Label7: TLabel;
    Label8: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure limpar;
    procedure mostrar;
    procedure Edit1Enter(Sender: TObject);
    procedure CadastrarFamilia1Click(Sender: TObject);
    procedure ProcurarFamlia1Click(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadvisita: Tfrmcadvisita;
  uamigo:string;

implementation

uses datamodule10, principal, cadamigo, locamigo, locmembro, cadmembro;

{$R *.DFM}

procedure Tfrmcadvisita.limpar;
var
  i:integer;
begin
  edit1.Text:='0';
  dtcad.Text:=formatdatetime('dd/mm/yyyy',date);
  edit5.text:='';
  edit6.Text:='';
  edit2.text:='';
  edit3.text:='';
  edit4.Text:='';
  for i:=0 to frmcadvisita.osolicita.Items.Count-1 do begin
    frmcadvisita.osolicita.Checked[i]:=false;
  end;
  adataID.text:=formatdatetime('dd/mm/yyyy',date);
  ahoraID.text:=timetostr(time);
end;


procedure Tfrmcadvisita.mostrar;
var
  i:integer;
  x:string;
begin
  edit1.Text:=data10.mymostra.fieldbyname('codigo').asstring;
  dtcad.Text:=data10.mymostra.fieldbyname('datamov').asstring;
  edit5.text:=data10.mymostra.fieldbyname('amigo').asstring;
  edit6.Text:=voltainfo('amigo','nome','codigo='+#39+edit5.Text+#39,'T','0');
  uamigo:=edit5.text;
  edit2.text:=data10.mymostra.fieldbyname('observacoes').asstring;
  edit3.text:=data10.mymostra.fieldbyname('membro').asstring;
  edit4.Text:=voltainfo('membro','nome','codigo='+#39+edit3.Text+#39,'T','0');
  if data10.mymostra.fieldbyname('pvez').asstring='S' then begin r1.Checked:=true; end else begin r2.Checked:=true; end;
  if data10.mymostra.fieldbyname('adventista').asstring='S' then begin r3.Checked:=true; end else begin r4.Checked:=true; end;
  for i:=0 to osolicita.Items.Count-1 do begin
    if trim(voltainfo('visita_solicita','codigo','visita='+#39+edit1.Text+#39+' and solicitacao='+#39+trim(acopia.Lines[i])+#39,'T','0'))<>'' then begin
      osolicita.Checked[i]:=true;
    end;
  end;
end;


procedure Tfrmcadvisita.FormActivate(Sender: TObject);
begin
  if (frmcadvisita.tag=1) or (frmcadvisita.tag=3) then begin
    frmcadvisita.caption:='Inclusão de Visita';
    limpar;
    dtcad.SetFocus;
  end;
  if frmcadvisita.tag=2 then begin
    frmcadvisita.caption:='Alteração de Visita';
    limpar;
    mostrar;
    dtcad.SetFocus;
  end;
end;

procedure Tfrmcadvisita.BitBtn2Click(Sender: TObject);
begin
  frmcadvisita.close;
end;

procedure Tfrmcadvisita.BitBtn1Click(Sender: TObject);
var
  x,sl,a1,a2,xadv:string;
  a,i:integer;
begin
  if r3.Checked=true then begin
    xadv:='M';
  end else begin
    xadv:='V';
  end;

  frmprincipal.c_agora;
  a:=0;
  if (trim(dtcad.text)='/  /') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; dtcad.setfocus; end;
  if (edit5.text='') and (a=0) then begin application.MessageBox('Campo Obrigatório','Atenção',mb_ok); a:=1; edit5.setfocus; end;

  if (a=0) then begin
    if r1.Checked=true then begin a1:='S'; end else begin a1:='N'; end;  // 1ª Vez
    if r3.Checked=true then begin a2:='S'; end else begin a2:='N'; end;  // Adventista

    sl:='N';
    for i:=0 to osolicita.Items.Count-1 do begin
      if osolicita.Checked[i]=true then begin
        sl:='S';
        break;
      end;
    end;

    if ((frmcadvisita.tag=1) or (frmcadvisita.tag=3)) and (a=0) then begin

      with data10.exemysql do begin
        sql.clear;
        x:='INSERT INTO visita ';
        x:=x+'(codigo, igreja, datamov, amigo, pvez, adventista, solicitacao, observacoes, membro, dataid, horaid, id) ';
        x:=x+'VALUES (NULL,';                                                   // codigo
        x:=x+#39+frmprincipal.Configura[3]+#39+',';                             // igreja
        x:=x+#39+mydata(dtcad.text)+#39+',';                                    // datamov
        x:=x+#39+edit5.text+#39+',';                                            // amigo
        x:=x+#39+a1+#39+',';                                                    // 1vez
        x:=x+#39+a2+#39+',';                                                    // adventista
        x:=x+#39+sl+#39+',';                                                    // solicitacao
        x:=x+#39+edit2.Text+#39+',';                                            // observacoes
        x:=x+#39+edit3.text+#39+',';                                            // membro
        x:=x+#39+mydata(adataid.text)+#39+',';                                  // dataid
        x:=x+#39+ahoraid.text+#39+',';                                          // horaid
        x:=x+#39+frmprincipal.Configura[1]+#39;                                 // id
        x:=x+')';
        sql.add(x);
        ExecSql;
      end;
      codcad.text:=voltauc('visita','codigo','amigo='+edit5.text,adataid.text,ahoraid.text,frmprincipal.Configura[1]);

      for i:=0 to osolicita.Items.Count-1 do begin
        if osolicita.Checked[i]=true then begin
          with data10.exemysql do begin
            sql.clear;
            x:='INSERT INTO visita_solicita ';
            x:=x+'(codigo, igreja, datamov, tipo, visita, amigo, solicitacao, observacao, resposta) ';
            x:=x+'VALUES (NULL,';                           // codigo
            x:=x+#39+frmprincipal.Configura[3]+#39+',';     // igreja
            x:=x+#39+mydata(dtcad.text)+#39+',';            // datamov
            x:=x+#39+xadv+#39+',';                          // tipo
            x:=x+#39+codcad.text+#39+',';                   // visita
            x:=x+#39+edit5.text+#39+',';                    // amigo
            x:=x+#39+trim(acopia.Lines[i])+#39+',';         // solicitacao
            x:=x+#39+trim(edit2.text)+#39+',';              // observacao
            x:=x+#39+'N'+#39;                               // resposta
            x:=x+')';
            sql.add(x);
            ExecSql;
          end;
        end;
      end;

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE amigo SET ';
        x:=x+'visitante='+#39+'S'+#39+',';                     // visitante
        x:=x+'interessado='+#39+sl+#39;                        // interessado
        x:=x+' where codigo='+#39+edit5.text+#39;
        sql.add(x);
        ExecSql;
      end;

      if (frmcadvisita.tag=1) then begin
        limpar;
        dtcad.SetFocus;
      end;
      if (frmcadvisita.tag=3) then begin
        frmcadvisita.close;
      end;
    end;

    if (frmcadvisita.tag=2) and (a=0) then begin

      x:='delete from visita_solicita where visita='+#39+edit1.text+#39;
      with data10.exemysql do begin
        sql.clear;
        sql.add(x);
        ExecSql;
      end;

      for i:=0 to osolicita.Items.Count-1 do begin
        if osolicita.Checked[i]=true then begin
          with data10.exemysql do begin
            sql.clear;
            x:='INSERT INTO visita_solicita ';
            x:=x+'(codigo, igreja, datamov, tipo, visita, amigo, solicitacao, observacao, resposta) ';
            x:=x+'VALUES (NULL,';                           // codigo
            x:=x+#39+frmprincipal.Configura[3]+#39+',';     // igreja
            x:=x+#39+mydata(dtcad.text)+#39+',';            // datamov
            x:=x+#39+xadv+#39+',';                          // tipo
            x:=x+#39+codcad.text+#39+',';                   // visita
            x:=x+#39+edit5.text+#39+',';                    // amigo
            x:=x+#39+trim(acopia.Lines[i])+#39+',';         // solicitacao
            x:=x+#39+trim(edit2.text)+#39+',';              // observacao
            x:=x+#39+'N'+#39;                               // resposta
            x:=x+')';
            sql.add(x);
            ExecSql;
          end;
        end;
      end;

      with data10.exemysql do begin
        sql.clear;
        x:='UPDATE visita SET ';
        x:=x+'datamov='+#39+mydata(dtcad.text)+#39+',';                         // datamov
        x:=x+'amigo='+#39+edit5.text+#39+',';                                   // amigo
        x:=x+'pvez='+#39+a1+#39+',';                                            // 1vez
        x:=x+'adventista='+#39+a2+#39+',';                                      // adventista
        x:=x+'solicitacao='+#39+sl+#39+',';                                     // solicitacao
        x:=x+'observacoes='+#39+edit2.Text+#39+',';                             // observacoes
        x:=x+'membro='+#39+edit3.text+#39;                                      // membro
        x:=x+' where codigo='+#39+edit1.text+#39;
        sql.add(x);
        ExecSql;
      end;
      if (uamigo<>edit5.Text) then begin
        with data10.exemysql do begin
          sql.clear;
          x:='UPDATE amigo SET ';
          x:=x+'visitante='+#39+'N'+#39+',';                     // visitante
          x:=x+'interessado='+#39+'N'+#39;                       // interessado
          x:=x+' where codigo='+#39+uamigo+#39;
          sql.add(x);
          ExecSql;
        end;
        with data10.exemysql do begin
          sql.clear;
          x:='UPDATE amigo SET ';
          x:=x+'visitante='+#39+'S'+#39+',';                     // visitante
          x:=x+'interessado='+#39+sl+#39;                        // interessado
          x:=x+' where codigo='+#39+edit5.text+#39;
          sql.add(x);
          ExecSql;
        end;
      end;

      frmcadvisita.close;
    end;
  end;

end;

procedure Tfrmcadvisita.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmcadvisita.Edit1Enter(Sender: TObject);
begin
  SelectNext(Sender as tWinControl, True, True );
end;

procedure Tfrmcadvisita.CadastrarFamilia1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcadamigo, frmcadamigo);
  frmcadamigo.tag:=3;
  frmcadamigo.showmodal;
  edit5.Text:=frmcadamigo.codcad.Text;
  frmcadamigo.Free;
  edit5.setfocus;
end;

procedure Tfrmcadvisita.ProcurarFamlia1Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocamigo, frmlocamigo);
  frmlocamigo.showmodal;
  edit5.Text:=frmlocamigo.ocod.text;
  edit5.setfocus;
  frmlocamigo.Free;
end;

procedure Tfrmcadvisita.Edit5Exit(Sender: TObject);
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


procedure Tfrmcadvisita.Edit3Exit(Sender: TObject);
var
  ax:string;
begin
  if edit3.text<>'' then begin
    ax:=trim(soletra(edit3.text));
    if trim(ax)<>'' then begin
      application.CreateForm(Tfrmlocmembro, frmlocmembro);
      frmlocmembro.auxp.text:=trim(ax);
      frmlocmembro.showmodal;
      edit3.Text:=frmlocmembro.ocod.text;
      edit3.setfocus;
      frmlocmembro.Free;
    end else begin
      edit4.Text:=voltainfo('membro','nome','codigo='+#39+edit3.Text+#39+' and igreja='+#39+frmprincipal.Configura[3]+#39,'T','0');
      if (trim(edit4.Text)='') then begin
        application.MessageBox('Código não encontrado','Atenção',mb_ok);
        edit3.setfocus;
      end;
    end;
  end;
end;

procedure Tfrmcadvisita.MenuItem1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcadmembro, frmcadmembro);
  frmcadmembro.tag:=3;
  frmcadmembro.showmodal;
  edit3.Text:=frmcadmembro.codcad.Text;
  frmcadmembro.Free;
  edit3.setfocus;
end;

procedure Tfrmcadvisita.MenuItem2Click(Sender: TObject);
begin
  application.CreateForm(Tfrmlocmembro, frmlocmembro);
  frmlocmembro.showmodal;
  edit3.Text:=frmlocmembro.ocod.text;
  edit3.setfocus;
  frmlocmembro.Free;
end;

end.
