unit senha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, db, DBCtrls,funcoes, funcaolocal, RLConsts;

  const
  OffsetMemoryStream : Int64 = 0;

type
  Tfrmsenha = class(TForm)
    Label2: TLabel;
    senha: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    usuario: TEdit;
    oservidor: TComboBox;
    versao: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure senhaKeyPress(Sender: TObject; var Key: Char);
    procedure usuarioKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure somemenu;
    procedure mostramenu;
    procedure mostranivel(anivel:string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmsenha: Tfrmsenha;

implementation

uses principal, datamodule10;

{$R *.DFM}



procedure Tfrmsenha.somemenu();
var
  i,i1,i2,i3,i4,i5,i6,i7:integer;
begin
  for i:=0 to frmprincipal.MainMenu1.Items.count-1 do begin
    frmprincipal.MainMenu1.Items[i].visible:=false;
    frmprincipal.MainMenu1.Items[i].enabled:=false;
    for i1:=0 to frmprincipal.MainMenu1.Items[i].count-1 do begin
      frmprincipal.MainMenu1.Items[i].Items[i1].visible:=false;
      frmprincipal.MainMenu1.Items[i].Items[i1].enabled:=false;
      for i2:=0 to frmprincipal.MainMenu1.Items[i].items[i1].count-1 do begin
        frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].visible:=false;
        frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].enabled:=false;
        for i3:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].count-1 do begin
          frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].visible:=false;
          frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].enabled:=false;
          for i4:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].items[i3].count-1 do begin
            frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].visible:=false;
            frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].enabled:=false;
            for i5:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].items[i3].items[i4].count-1 do begin
              frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].visible:=false;
              frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].enabled:=false;
              for i6:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].items[i3].items[i4].items[i5].count-1 do begin
                frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].Items[i6].visible:=false;
                frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].Items[i6].enabled:=false;
                for i7:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].items[i3].items[i4].items[i5].items[i6].count-1 do begin
                  frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].Items[i6].Items[i7].visible:=false;
                  frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].Items[i6].Items[i7].enabled:=false;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure Tfrmsenha.mostramenu();
var
  i,i1,i2,i3,i4,i5,i6,i7:integer;
begin
  for i:=0 to frmprincipal.MainMenu1.Items.count-1 do begin
    frmprincipal.MainMenu1.Items[i].visible:=true;
    frmprincipal.MainMenu1.Items[i].enabled:=true;
    for i1:=0 to frmprincipal.MainMenu1.Items[i].count-1 do begin
      frmprincipal.MainMenu1.Items[i].Items[i1].visible:=true;
      frmprincipal.MainMenu1.Items[i].Items[i1].enabled:=true;
      for i2:=0 to frmprincipal.MainMenu1.Items[i].items[i1].count-1 do begin
        frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].visible:=true;
        frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].enabled:=true;
        for i3:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].count-1 do begin
          frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].visible:=true;
          frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].enabled:=true;
          for i4:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].items[i3].count-1 do begin
            frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].visible:=true;
            frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].enabled:=true;
            for i5:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].items[i3].items[i4].count-1 do begin
              frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].visible:=true;
              frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].enabled:=true;
              for i6:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].items[i3].items[i4].items[i5].count-1 do begin
                frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].Items[i6].visible:=true;
                frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].Items[i6].enabled:=true;
                for i7:=0 to frmprincipal.MainMenu1.Items[i].items[i1].items[i2].items[i3].items[i4].items[i5].items[i6].count-1 do begin
                  frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].Items[i6].Items[i7].visible:=true;
                  frmprincipal.MainMenu1.Items[i].Items[i1].Items[i2].Items[i3].Items[i4].Items[i5].Items[i6].Items[i7].enabled:=true;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;


procedure Tfrmsenha.mostranivel(anivel:string);
var
  i,r,k:integer;
  x,a:string;
  n1,n2,n3,n4,n5,n6,n7:string;
begin
  if anivel<>'1' then begin
   with data10.myaux do begin
     close;
     sql.clear;
     sql.add('select * from nivel where codigo='+#39+anivel+#39);
     open;
     x:=fieldbyname('nivel').asstring;
   end;
   a:='';
   for i:=1 to length(x) do begin
     if x[i]='*' then begin
       r:=1;
       n1:=''; n2:=''; n3:=''; n4:=''; n5:=''; n6:=''; n7:='';
       for k:=1 to length(a) do begin
         if a[k]='.' then begin r:=r+1; end;
         if (r=1) and (a[k]<>'.') then begin
           n1:=n1+a[k];
         end;
         if (r=2) and (a[k]<>'.') then begin
           n2:=n2+a[k];
         end;
         if (r=3) and (a[k]<>'.') then begin
           n3:=n3+a[k];
         end;
         if (r=4) and (a[k]<>'.') then begin
           n4:=n4+a[k];
         end;
         if (r=5) and (a[k]<>'.') then begin
           n5:=n5+a[k];
         end;
         if (r=6) and (a[k]<>'.') then begin
           n6:=n6+a[k];
         end;
         if (r=7) and (a[k]<>'.') then begin
           n7:=n7+a[k];
         end;
       end;
       if n1<>'' then begin
         try
           frmprincipal.MainMenu1.Items[strtoint(n1)].Visible:=true;
           frmprincipal.MainMenu1.Items[strtoint(n1)].enabled:=true;
         except end;
       end;
       if n2<>'' then begin
         try
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Visible:=true;
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].enabled:=true;
         except end;
       end;
       if n3<>'' then begin
         try
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Items[strtoint(n3)].Visible:=true;
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Items[strtoint(n3)].enabled:=true;
         except end;
       end;
       if n4<>'' then begin
         try
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Items[strtoint(n3)].Items[strtoint(n4)].Visible:=true;
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Items[strtoint(n3)].Items[strtoint(n4)].enabled:=true;
         except end;
       end;
       if n5<>'' then begin
         try
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Items[strtoint(n3)].Items[strtoint(n4)].Items[strtoint(n5)].Visible:=true;
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Items[strtoint(n3)].Items[strtoint(n4)].Items[strtoint(n5)].enabled:=true;
         except end;
       end;
       if n6<>'' then begin
         try
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Items[strtoint(n3)].Items[strtoint(n4)].Items[strtoint(n5)].Items[strtoint(n6)].Visible:=true;
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Items[strtoint(n3)].Items[strtoint(n4)].Items[strtoint(n5)].Items[strtoint(n6)].enabled:=true;
         except end;
       end;
       if n7<>'' then begin
         try
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Items[strtoint(n3)].Items[strtoint(n4)].Items[strtoint(n5)].Items[strtoint(n6)].Items[strtoint(n7)].Visible:=true;
           frmprincipal.MainMenu1.Items[strtoint(n1)].Items[strtoint(n2)].Items[strtoint(n3)].Items[strtoint(n4)].Items[strtoint(n5)].Items[strtoint(n6)].Items[strtoint(n7)].enabled:=true;
         except end;
       end;
       a:='';
     end else begin
       a:=a+x[i];
     end;
   end;
  end;
end;


procedure Tfrmsenha.FormActivate(Sender: TObject);
begin
  usuario.text:='';
  senha.text:='';
  usuario.setfocus;
end;

procedure Tfrmsenha.BitBtn1Click(Sender: TObject);
var
  a:integer;
  asenha,aigreja,x:string;
begin
  a:=0;
  if (a=0) and (trim(usuario.text)='') then begin a:=1; application.MessageBox('Campo Obrigatório','Atenção',mb_ok); usuario.setfocus; end;
  if (a=0) and (trim(senha.text)='') then begin a:=1; application.MessageBox('Campo Obrigatório','Atenção',mb_ok); senha.setfocus; end;
  if (a=0) then begin
    asenha:=voltainfo('nupass','codigo|senha|igreja|nome|nivel|ativo','nome='+#39+usuario.Text+#39,'T|T|T|T|T|T','0');
    if (trim(voltacod(asenha,'|',5))='S') then begin
      if (trim(voltacod(asenha,'|',1))=trim(senha.Text)) then begin
        Application.CreateForm(Tfrmprincipal, frmprincipal);
        frmsenha.Visible:=false;
        try
          frmprincipal.Configura[1]:=trim(voltacod(asenha,'|',0));
          frmprincipal.Configura[2]:=trim(voltacod(asenha,'|',3));
          frmprincipal.Configura[3]:=trim(voltacod(asenha,'|',2));
          x:=voltainfo('igreja','descricao|cidade|estado|bairro|endereco|codigo_estudo','codigo='+#39+frmprincipal.Configura[3]+#39,'T|T|T|T|T|T','0');
          frmprincipal.Configura[4]:=trim(voltacod(x,'|',0));
          frmprincipal.Configura[5]:=trim(voltacod(x,'|',1));
          frmprincipal.Configura[6]:=trim(voltacod(x,'|',2));
          frmprincipal.Configura[7]:=trim(voltacod(x,'|',3));
          frmprincipal.Configura[8]:=trim(voltacod(x,'|',4));
          frmprincipal.Configura[9]:=trim(voltacod(x,'|',5));

          if (trim(voltacod(asenha,'|',4))='1') then begin
            mostramenu;
          end else begin
            somemenu;
            mostranivel(trim(voltacod(asenha,'|',4)));
          end;
          frmprincipal.Caption:='Sistema de Controle IASD - '+versao.Text;
          frmprincipal.ShowModal;
          frmprincipal.Free
        finally
          data10.mySqldata.Disconnect;
        end;
      end else begin
        application.MessageBox('Usuário ou Senha Incorreta','Atenção',mb_ok);
        senha.text:='';
        usuario.text:='';
        usuario.setfocus;
      end;
    end else begin
      application.MessageBox('Usuário ou Senha Incorreta','Atenção',mb_ok);
      senha.text:='';
      usuario.text:='';
      usuario.setfocus;
    end;
  end;
end;

procedure Tfrmsenha.BitBtn2Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure Tfrmsenha.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_F4) and (shift=[ssalt]) then
  Abort;
end;

procedure Tfrmsenha.senhaKeyPress(Sender: TObject; var Key: Char);
begin
If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmsenha.usuarioKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then Begin SelectNext(Sender as tWinControl, True, True ); Key := #0; end;
end;

procedure Tfrmsenha.FormShow(Sender: TObject);
var
  x,ver:string;
begin
  try
    data10.mysqldata.HostName:=voltacod(oservidor.text,'|',0);
    data10.mysqldata.Password:=voltacod(oservidor.text,'|',1);
    data10.mySqldata.Connected:=true;
    ver:=voltainfo('configura','versao|versaoescrita','codigo='+#39+'1'+#39,'T|T','0');
    if trim(voltacod(ver,'|',0))<>trim(versao.Text) then begin
      x:='Existe uma NOVA versão do Sistema'+#13;
      x:=x+'Baixe a nova versão '+voltacod(ver,'|',1)+' em:'+#13;
      x:=x+'www.conesistemas.com.br/iasd';
      application.MessageBox(pchar(x),'Atenção',mb_ok);
      data10.mySqldata.Disconnect;
      application.Terminate;
    end else begin
      versao.Text:=voltacod(ver,'|',1);
    end;
   except
     on Exception do begin
      x:='Erro ao Conectar o Sistema'+#13;
      x:=x+'Tente mais tarde!';
      application.MessageBox(pchar(x),'Atenção',mb_ok);
      application.Terminate;
     end;
  end;
end;

initialization
RLConsts.SetVersion(3,72,'B');

end.
