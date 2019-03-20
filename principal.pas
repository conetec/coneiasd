unit principal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ExtCtrls, Menus, ComCtrls, ToolWin, jpeg, StdCtrls, Grids, db,
  DBGrids, funcoes, JvSpeedbar, JvExControls, JvComponent, JvXPCore,
  JvXPButtons, JvExExtCtrls;

type
  Tfrmprincipal = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Utilitrios1: TMenuItem;
    Calculadora1: TMenuItem;
    Calendrio1: TMenuItem;
    Supervisor1: TMenuItem;
    Usurios1: TMenuItem;
    Image1: TImage;
    N2: TMenuItem;
    Agenda1: TMenuItem;
    AlteraodeOSS1: TMenuItem;
    Profisso1: TMenuItem;
    ClasseEscolaSabatina1: TMenuItem;
    Famlia1: TMenuItem;
    Cargos1: TMenuItem;
    Membros1: TMenuItem;
    MinPessoal1: TMenuItem;
    CaravanadoPoder1: TMenuItem;
    DuplasMissionrias1: TMenuItem;
    JvSpeedBar1: TJvSpeedBar;
    JvXPButton1: TJvXPButton;
    JvXPButton3: TJvXPButton;
    JvXPButton4: TJvXPButton;
    JvXPButton5: TJvXPButton;
    JvXPButton6: TJvXPButton;
    JvXPButton7: TJvXPButton;
    JvSpeedBarSection1: TJvSpeedBarSection;
    Image3: TImage;
    EscolaSabatina1: TMenuItem;
    N3: TMenuItem;
    Interessados1: TMenuItem;
    Chamada1: TMenuItem;
    Acompanhamento1: TMenuItem;
    Recepo1: TMenuItem;
    Visitantes2: TMenuItem;
    N4: TMenuItem;
    Materiais1: TMenuItem;
    Cadastro2: TMenuItem;
    EstudosBblicos1: TMenuItem;
    AmigosdaIgreja1: TMenuItem;
    N5: TMenuItem;
    Amigos1: TMenuItem;
    Solicitaes1: TMenuItem;
    N6: TMenuItem;
    Relatrio1: TMenuItem;
    ClasseBblica1: TMenuItem;
    N7: TMenuItem;
    InstrutorBblico1: TMenuItem;
    Pastoral1: TMenuItem;
    RegistrodeVisita1: TMenuItem;
    Conservao1: TMenuItem;
    ImageList1: TImageList;
    AbrirSbado1: TMenuItem;
    SadaDistribuio1: TMenuItem;
    Relatrio2: TMenuItem;
    Estoque1: TMenuItem;
    Relatrios1: TMenuItem;
    N9: TMenuItem;
    ClasseseAlunos1: TMenuItem;
    Categoria1: TMenuItem;
    N8: TMenuItem;
    MudarsuaSenha1: TMenuItem;
    tempoc_agora: TTimer;
    ASA1: TMenuItem;
    EntradadeMateriais1: TMenuItem;
    MateriaisDisponveis1: TMenuItem;
    SolicitaodeEstudo1: TMenuItem;
    SolicitaodeEstudo2: TMenuItem;
    SolicitaodeVisita1: TMenuItem;
    SolicitaodeAtendimento1: TMenuItem;
    OraoIntercessora1: TMenuItem;
    SolicitaodeEstudo3: TMenuItem;
    Solicitaes2: TMenuItem;
    RegistrodeVisitao1: TMenuItem;
    N10: TMenuItem;
    Relatrios2: TMenuItem;
    DuplasMissionrias2: TMenuItem;
    PequenosGrupos1: TMenuItem;
    ClassesBblicas1: TMenuItem;
    Chamada2: TMenuItem;
    Corrige1: TMenuItem;
    AbrirTrimestre1: TMenuItem;
    MembrosnoMatriculados1: TMenuItem;
    Relatrios3: TMenuItem;
    Membros2: TMenuItem;
    MatriculadeAlunos1: TMenuItem;
    N11: TMenuItem;
    ResumoApontamentos1: TMenuItem;
    N12: TMenuItem;
    Classe101: TMenuItem;
    corrige021: TMenuItem;
    procedure ToolButton2Click(Sender: TObject);
    procedure Calculadora1Click(Sender: TObject);
    procedure Calendrio1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sair1Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure Profisso1Click(Sender: TObject);
    procedure ClasseEscolaSabatina1Click(Sender: TObject);
    procedure Famlia1Click(Sender: TObject);
    procedure Membros1Click(Sender: TObject);
    procedure Cargos1Click(Sender: TObject);
    procedure Chamada1Click(Sender: TObject);
    procedure Acompanhamento1Click(Sender: TObject);
    procedure AmigosdaIgreja1Click(Sender: TObject);
    procedure Amigos1Click(Sender: TObject);
    procedure Solicitaes1Click(Sender: TObject);
    procedure Visitantes2Click(Sender: TObject);
    procedure Relatrio1Click(Sender: TObject);
    procedure gravaFotoMembro(DataSet : TDataSet; id,Campo01,Campo02:String; ImageExibicao :TImage);
    procedure ExibeFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao :TImage);
    procedure AbrirSbado1Click(Sender: TObject);
    procedure c_agora;
    procedure AlteraodeOSS1Click(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure Cadastro2Click(Sender: TObject);
    procedure SadaDistribuio1Click(Sender: TObject);
    procedure ClasseseAlunos1Click(Sender: TObject);
    procedure InstrutorBblico1Click(Sender: TObject);
    procedure DuplasMissionrias1Click(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure EstudosBblicos1Click(Sender: TObject);
    procedure Conservao1Click(Sender: TObject);
    procedure MudarsuaSenha1Click(Sender: TObject);
    procedure tempoc_agoraTimer(Sender: TObject);
    procedure EntradadeMateriais1Click(Sender: TObject);
    procedure SolicitaodeEstudo2Click(Sender: TObject);
    procedure SolicitaodeEstudo3Click(Sender: TObject);
    procedure SolicitaodeVisita1Click(Sender: TObject);
    procedure OraoIntercessora1Click(Sender: TObject);
    procedure Interessados1Click(Sender: TObject);
    procedure SolicitaodeAtendimento1Click(Sender: TObject);
    procedure CaravanadoPoder1Click(Sender: TObject);
    procedure ClasseBblica1Click(Sender: TObject);
    procedure Solicitaes2Click(Sender: TObject);
    procedure RegistrodeVisita1Click(Sender: TObject);
    procedure RegistrodeVisitao1Click(Sender: TObject);
    procedure DuplasMissionrias2Click(Sender: TObject);
    procedure PequenosGrupos1Click(Sender: TObject);
    procedure ClassesBblicas1Click(Sender: TObject);
    procedure Estoque1Click(Sender: TObject);
    procedure MateriaisDisponveis1Click(Sender: TObject);
    procedure Chamada2Click(Sender: TObject);
    procedure Corrige1Click(Sender: TObject);
    procedure AbrirTrimestre1Click(Sender: TObject);
    procedure MembrosnoMatriculados1Click(Sender: TObject);
    procedure Membros2Click(Sender: TObject);
    procedure MatriculadeAlunos1Click(Sender: TObject);
    procedure ResumoApontamentos1Click(Sender: TObject);
    procedure Classe101Click(Sender: TObject);
    procedure corrige021Click(Sender: TObject);
  private
    { Private declarations }
  public

    configura:array[1..9] of string;

    {
     Informacoes Gerais

     coluna
     1 Código Usuário
     2 Nome Usuário
     3 Cod. Igreja
     4 Descricao Igreja
     5 Cidade Igreja
     6 Estado Igreja
     7 Bairro Igreja
     8 Endereco Igreja
     9 Código do Material Estudo Biblico
     10 Dias de acompanhamento membros novos
    }


    { Public declarations }
  end;

var
  frmprincipal: Tfrmprincipal;

implementation

uses calendario, datamodule10, agenda, nivel, backup, pirata,
  senha, profissao, classe, familia, membro, cadmembro, cadfamilia,
  cadprofissao, cargo, cadcargo, cadclasse, selchamada, acompanhaes, amigo,
  cadamigo, solicitacao, cadsolicitacao, visita, cadvisita, periodo,
  abresabado, cadnivel, usuario, cadusuario, material, cadmaterial,
  material_saida, cadmaterial_saida, imprel_002, instrutor, dupla,
  caddupla, material_tipo, cadmaterial_tipo, estudo, cadestudo,
  conservacao, mudasenha, material_entrada, cadmaterial_entrada,
  acompanha_solicita, pequenogrupo, cadpequenogrupo, classebiblica,
  cadclassebiblica, solicitaja, visitacaomp, imprel_003, imprel_004,
  imprel_005, imprel_006, imprel_007, semperiodo, abretrimestre,
  imprel_010, imprel_011, aluno, cadaluno, classe10, skype,
  chamadacompleta;


{$R *.DFM}


procedure Tfrmprincipal.c_agora;
var
  a,tenta:integer;
  x:string;
begin
  a:=0;
  tenta:=0;
      try
       data10.myaxconecta.close;
       data10.myaxconecta.open;
      except
       on Exception do begin
         a:=1;
       end;
      end;

  if a=1 then begin
    data10.mysqldata.Connected:=false;
    while  data10.mysqldata.Connected=false do begin
      if tenta>=7 then begin application.Terminate; end;
      try
        data10.mysqldata.Connected:=true;
      except
        on Exception do begin

          tenta:=tenta+1;
          x:='Servidor Ocupado. Tentativa '+inttostr(tenta)+' de 30';
          application.MessageBox(pchar(x),'Erro de Conexão',mb_ok);
        end;
      end;
    end;
  end;
end;



procedure Tfrmprincipal.ExibeFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao :TImage);
var
  MemoryStream:TMemoryStream;
  jpg : TJpegImage;
begin
  if not(DataSet.IsEmpty) and not((DataSet.FieldByName(BlobFieldName) as TBlobField).IsNull) then
    try
      MemoryStream := TMemoryStream.Create;
      Jpg := TJpegImage.Create;
      (DataSet.FieldByName(BlobFieldName) as TBlobField).SaveToStream(MemoryStream);
      MemoryStream.Position := OffsetMemoryStream;
      Jpg.LoadFromStream(MemoryStream);
      ImageExibicao.Picture.Assign(Jpg);
    finally
      Jpg.Free;
      MemoryStream.Free;
    end
  else
    ImageExibicao.Picture := Nil;
end;


procedure Tfrmprincipal.gravaFotoMembro(DataSet : TDataSet; id,Campo01,Campo02:String; ImageExibicao :TImage);
var
  Stream : TMemoryStream;
begin
  try
    DataSet.Active:=false;
    Dataset.Filter:='codigo='+#39+id+#39;
    Dataset.Filtered:=true;
    DataSet.Active:=true;
    Stream := TMemoryStream.Create;
    ImageExibicao.Picture.Graphic.SaveToStream(Stream);
    if id='0' then begin
      DataSet.insert;
      DataSet.fieldbyname('cod_tipo').asstring:=Campo01;
      DataSet.fieldbyname('tipo').asstring:=Campo02;
      (DataSet.FieldByName('imagem') as TBlobField).LoadFromStream(Stream);
    end else begin
      DataSet.edit;
      (DataSet.FieldByName('imagem') as TBlobField).LoadFromStream(Stream);
    end;
    DataSet.Post;
  finally
    Stream.Free;
    DataSet.Active:=false;
  end;
end;


function decodifica(frase:string):string;
var
  f1,f2,x1,x:string;
  i,k:integer;
begin
  f2:='ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789-._=@';
  f1:='963-)%$@#!7415JNBGFD820,*&\(?[];:><OIKSAQW';
  x1:=frase;
  x:='';
  for i:=1 to length(trim(x1)) do begin
    for k:=1 to length(f1) do begin
       if x1[i]=f1[k] then begin
          x:=x+lowercase(f2[k]);
       end;
    end;
  end;
  decodifica:=x;
end;


function codifica(frase:string):string;
var
  f1,f2,x1,x:string;
  i,k:integer;
begin
  f1:='ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789-._=@';
  f2:='963-)%$@#!7415JNBGFD820,*&\(?[];:><OIKSAQW';
  x1:=frase;
  x:='';
  for i:=1 to length(trim(x1)) do begin
    for k:=1 to length(f1) do begin
       if uppercase(x1[i])=f1[k] then begin
          x:=x+f2[k];
       end;
    end;
  end;
  codifica:=x;
end;

Function ExtractDiskSerial(Drive:String):String;
Var
  Serial:DWord;
  DirLen,Flags: DWord;
  DLabel : Array[0..11] of Char;
begin
  GetVolumeInformation(PChar(Drive+':\'),dLabel,12,@Serial,DirLen,Flags,nil,0);
  Result := IntToHex(Serial,8);
end;


procedure Tfrmprincipal.ToolButton2Click(Sender: TObject);
begin
   frmprincipal.close;
end;

procedure Tfrmprincipal.Calculadora1Click(Sender: TObject);
begin
  if fileexists('c:\windows\calc.exe') then begin
    winexec('c:\windows\calc.exe',1);
  end;
  if fileexists('c:\windows\system32\calc.exe') then begin
    winexec('c:\windows\System32\calc.exe',1);
  end;
  if fileexists('c:\winnt\system32\calc.exe') then begin
    winexec('c:\winnt\system32\calc.exe',1);
  end;
end;

procedure Tfrmprincipal.Calendrio1Click(Sender: TObject);
begin
  frmcalendario.showmodal;
end;

procedure Tfrmprincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  data10.mysqldata.Connected:=false;
end;

procedure Tfrmprincipal.Sair1Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure Tfrmprincipal.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if data10.mySqldata.Connected=false then begin
    application.MessageBox('Falha de conexão com o Servidor','Seu programa será finalizado!');
    application.Terminate;
  end;
end;

procedure Tfrmprincipal.FormActivate(Sender: TObject);
begin
  tempoc_agora.Tag:=1;
  frmprincipal.WindowState:=wsMaximized	;
end;

procedure Tfrmprincipal.Profisso1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmprofissao, frmprofissao);
  Application.CreateForm(Tfrmcadprofissao, frmcadprofissao);
  frmprofissao.showmodal;
  frmprofissao.Free;
  frmcadprofissao.Free;
end;

procedure Tfrmprincipal.ClasseEscolaSabatina1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmclasse, frmclasse);
  Application.CreateForm(Tfrmcadclasse, frmcadclasse);
  frmclasse.showmodal;
  frmclasse.Free;
  frmcadclasse.Free;
end;

procedure Tfrmprincipal.Famlia1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmfamilia, frmfamilia);
  Application.CreateForm(Tfrmcadfamilia, frmcadfamilia);
  frmfamilia.showmodal;
  frmfamilia.Free;
  frmcadfamilia.Free;
end;

procedure Tfrmprincipal.Membros1Click(Sender: TObject);
begin
  if frmprincipal.Membros1.visible=true then begin
    Application.CreateForm(Tfrmmembro, frmmembro);
    Application.CreateForm(Tfrmcadmembro, frmcadmembro);
    frmmembro.showmodal;
    frmmembro.Free;
    frmcadmembro.Free;
  end;
end;

procedure Tfrmprincipal.Cargos1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmcargo, frmcargo);
  Application.CreateForm(Tfrmcadcargo, frmcadcargo);
  frmcargo.showmodal;
  frmcargo.Free;
  frmcadcargo.Free;
end;

procedure Tfrmprincipal.Chamada1Click(Sender: TObject);
begin
  if frmprincipal.Chamada1.visible=true then begin
    Application.CreateForm(TfrmChamadaCompleta, frmChamadaCompleta);
    frmChamadaCompleta.showmodal;
    frmChamadaCompleta.Free;
  end;
end;

procedure Tfrmprincipal.Acompanhamento1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmacompanhaes, frmacompanhaes);
  frmacompanhaes.Showmodal;
  frmacompanhaes.Free;
end;

procedure Tfrmprincipal.AmigosdaIgreja1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmamigo, frmamigo);
  Application.CreateForm(Tfrmcadamigo, frmcadamigo);
  frmamigo.showmodal;
  frmamigo.Free;
  frmcadamigo.Free;
end;

procedure Tfrmprincipal.Amigos1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmamigo, frmamigo);
  Application.CreateForm(Tfrmcadamigo, frmcadamigo);
  frmamigo.showmodal;
  frmamigo.Free;
  frmcadamigo.Free;
end;

procedure Tfrmprincipal.Solicitaes1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmsolicitacao, frmsolicitacao);
  Application.CreateForm(Tfrmcadsolicitacao, frmcadsolicitacao);
  frmsolicitacao.showmodal;
  frmsolicitacao.Free;
  frmcadsolicitacao.Free;
end;

procedure Tfrmprincipal.Visitantes2Click(Sender: TObject);
begin
  if frmprincipal.Visitantes2.visible=true then begin
    Application.CreateForm(Tfrmvisita, frmvisita);
    Application.CreateForm(Tfrmcadvisita, frmcadvisita);
    frmvisita.showmodal;
    frmvisita.Free;
    frmcadvisita.Free;
  end;
end;

procedure Tfrmprincipal.Relatrio1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmperiodo, frmperiodo);
  frmperiodo.tag:=1;
  frmperiodo.showmodal;
  frmperiodo.Free;
end;

procedure Tfrmprincipal.AbrirSbado1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmabresabado, frmabresabado);
  frmabresabado.showmodal;
  frmabresabado.Free;
end;

procedure Tfrmprincipal.AlteraodeOSS1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmnivel,frmnivel);
  Application.CreateForm(Tfrmcadnivel,frmcadnivel);
  frmnivel.showmodal;
  frmnivel.Free;
  frmcadnivel.Free;
end;

procedure Tfrmprincipal.Usurios1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmusuario,frmusuario);
  Application.CreateForm(Tfrmcadusuario,frmcadusuario);
  frmusuario.showmodal;
  frmusuario.Free;
  frmcadusuario.Free;
end;

procedure Tfrmprincipal.Cadastro2Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmmaterial, frmmaterial);
  Application.CreateForm(Tfrmcadmaterial, frmcadmaterial);
  frmmaterial.showmodal;
  frmmaterial.Free;
  frmcadmaterial.Free;
end;

procedure Tfrmprincipal.SadaDistribuio1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmmaterial_saida, frmmaterial_saida);
  Application.CreateForm(Tfrmcadmaterial_saida, frmcadmaterial_saida);
  frmmaterial_saida.showmodal;
  frmmaterial_saida.Free;
  frmcadmaterial_saida.Free;
end;

procedure Tfrmprincipal.ClasseseAlunos1Click(Sender: TObject);
var
  x:string;
begin
  frmprincipal.c_agora;
  with data10.mytudo do begin
    close;
    sql.clear;
    x:='select a.Codigo,a.nome,a.celular,a.comercial,a.email,a.batizado,a.classe,';
    x:=x+' b.descricao,b.telefone, ';
    x:=x+' c.numero,c.descricao as dclasse';
    x:=x+' from membro a left join familia b on a.familia=b.codigo left join classe c on a.classe=c.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
    x:=x+' and (a.ativo='+#39+'S'+#39+')';
    x:=x+')';
    x:=x+' order by a.classe,a.nome';
    sql.add(x);
    open;
    Application.CreateForm(Tfrmimprel_002, frmimprel_002);
    frmimprel_002.titulo.Caption:='Relatório de Alunos por Classe ES';
    frmimprel_002.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
    frmimprel_002.empresa.Caption:=frmprincipal.Configura[4];
    frmimprel_002.RLReport1.Preview;
    frmimprel_002.free;
  end;
end;

procedure Tfrmprincipal.InstrutorBblico1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrminstrutor, frminstrutor);
  frminstrutor.showmodal;
  frminstrutor.Free;
end;

procedure Tfrmprincipal.DuplasMissionrias1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmdupla, frmdupla);
  Application.CreateForm(Tfrmcaddupla, frmcaddupla);
  frmdupla.showmodal;
  frmdupla.Free;
  frmcaddupla.Free;
end;

procedure Tfrmprincipal.Categoria1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmmaterial_tipo, frmmaterial_tipo);
  Application.CreateForm(Tfrmcadmaterial_tipo, frmcadmaterial_tipo);
  frmmaterial_tipo.showmodal;
  frmmaterial_tipo.Free;
  frmcadmaterial_tipo.Free;
end;

procedure Tfrmprincipal.EstudosBblicos1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmestudo, frmestudo);
  Application.CreateForm(Tfrmcadestudo, frmcadestudo);
  frmestudo.showmodal;
  frmestudo.Free;
  frmcadestudo.Free;
end;

procedure Tfrmprincipal.Conservao1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmconservacao, frmconservacao);
  frmconservacao.showmodal;
  frmconservacao.Free;
end;

procedure Tfrmprincipal.MudarsuaSenha1Click(Sender: TObject);
begin
   Application.CreateForm(Tfrmmudasenha, frmmudasenha);
   frmmudasenha.showmodal;
   frmmudasenha.Free;
end;

procedure Tfrmprincipal.tempoc_agoraTimer(Sender: TObject);
begin
  if tempoc_agora.tag=1 then begin
  //  application.MessageBox('','',mb_ok);
    frmprincipal.c_agora;
  end;
end;

procedure Tfrmprincipal.EntradadeMateriais1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmmaterial_entrada, frmmaterial_entrada);
  Application.CreateForm(Tfrmcadmaterial_entrada, frmcadmaterial_entrada);
  frmmaterial_entrada.showmodal;
  frmmaterial_entrada.Free;
  frmcadmaterial_entrada.Free;
end;

procedure Tfrmprincipal.SolicitaodeEstudo2Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmacompanha_solicita, frmacompanha_solicita);
  frmacompanha_solicita.tag:=3;
  frmacompanha_solicita.showmodal;
  frmacompanha_solicita.Free;
end;

procedure Tfrmprincipal.SolicitaodeEstudo3Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmacompanha_solicita, frmacompanha_solicita);
  frmacompanha_solicita.tag:=4;
  frmacompanha_solicita.showmodal;
  frmacompanha_solicita.Free;
end;

procedure Tfrmprincipal.SolicitaodeVisita1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmacompanha_solicita, frmacompanha_solicita);
  frmacompanha_solicita.tag:=2;
  frmacompanha_solicita.showmodal;
  frmacompanha_solicita.Free;
end;

procedure Tfrmprincipal.OraoIntercessora1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmacompanha_solicita, frmacompanha_solicita);
  frmacompanha_solicita.tag:=1;
  frmacompanha_solicita.showmodal;
  frmacompanha_solicita.Free;
end;

procedure Tfrmprincipal.Interessados1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmacompanha_solicita, frmacompanha_solicita);
  frmacompanha_solicita.tag:=0;
  frmacompanha_solicita.showmodal;
  frmacompanha_solicita.Free;
end;

procedure Tfrmprincipal.SolicitaodeAtendimento1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmacompanha_solicita, frmacompanha_solicita);
  frmacompanha_solicita.tag:=5;
  frmacompanha_solicita.showmodal;
  frmacompanha_solicita.Free;
end;

procedure Tfrmprincipal.CaravanadoPoder1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmpequenogrupo, frmpequenogrupo);
  Application.CreateForm(Tfrmcadpequenogrupo, frmcadpequenogrupo);
  frmpequenogrupo.showmodal;
  frmpequenogrupo.Free;
  frmcadpequenogrupo.Free;
end;

procedure Tfrmprincipal.ClasseBblica1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmclassebiblica, frmclassebiblica);
  Application.CreateForm(Tfrmcadclassebiblica, frmcadclassebiblica);
  frmclassebiblica.showmodal;
  frmclassebiblica.Free;
  frmcadclassebiblica.Free;
end;

procedure Tfrmprincipal.Solicitaes2Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmsolicitaja, frmsolicitaja);
  frmsolicitaja.showmodal;
  frmsolicitaja.Free;
end;

procedure Tfrmprincipal.RegistrodeVisita1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmvisitacaomp, frmvisitacaomp);
  frmvisitacaomp.tag:=1;
  frmvisitacaomp.showmodal;
  frmvisitacaomp.Free;
end;

procedure Tfrmprincipal.RegistrodeVisitao1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmvisitacaomp, frmvisitacaomp);
  frmvisitacaomp.tag:=2;
  frmvisitacaomp.showmodal;
  frmvisitacaomp.Free;
end;

procedure Tfrmprincipal.DuplasMissionrias2Click(Sender: TObject);
var
  x:string;
begin
  with data10.myimp do begin
    x:='select a.codigo,a.descricao as nomes,a.descricaoop,a.disponivel,';
    x:=x+'b.amigo,b.estudo,b.licao,b.ativo,b.estudo,b.licao,b.datavisita,';
    x:=x+'c.nome,c.faixa,c.telefone,';
    x:=x+'d.descricao as omaterial';
    x:=x+' from dupla a left join estudo b on b.dupla=a.codigo';
    x:=x+' left join amigo c on b.amigo=c.codigo';
    x:=x+' left join material d on b.estudo=d.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
    x:=x+' and (a.ativo='+#39+'S'+#39+')';
    x:=x+')';
    x:=x+' order by nomes';
    close;
    sql.clear;
    sql.add(x);
    open;
  end;
  Application.CreateForm(Tfrmimprel_003, frmimprel_003);
  frmimprel_003.titulo.Caption:='Relatório de Duplas Missionárias';
  frmimprel_003.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
  frmimprel_003.empresa.Caption:=frmprincipal.Configura[4];
  frmimprel_003.RLReport1.Preview;
  frmimprel_003.free;
end;

procedure Tfrmprincipal.PequenosGrupos1Click(Sender: TObject);
var
  x:string;
begin
  with data10.myimp do begin
    x:='select a.codigo,a.descricao,a.endereco,a.descricaodia,a.horario,a.numpessoas,';
    x:=x+' if(b.tipo='+#39+'M'+#39+',c.nome,d.nome) as onome,b.codtipo,';
    x:=x+' if(b.tipo='+#39+'M'+#39+','+#39+'MEMBRO'+#39+','+#39+'AMIGO'+#39+') as otipo';
    x:=x+' from pequenogrupo a left join participa_pg b on b.pequenogrupo=a.codigo';
    x:=x+' left join membro c on b.codtipo=c.codigo';
    x:=x+' left join amigo d on b.codtipo=d.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
    x:=x+' and (a.ativo='+#39+'S'+#39+')';
    x:=x+')';
    x:=x+' order by a.descricao';
    close;
    sql.clear;
    sql.add(x);
    open;
  end;
  Application.CreateForm(Tfrmimprel_004, frmimprel_004);
  frmimprel_004.titulo.Caption:='Relatório de Pequenos Grupos';
  frmimprel_004.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
  frmimprel_004.empresa.Caption:=frmprincipal.Configura[4];
  frmimprel_004.RLReport1.Preview;
  frmimprel_004.free;
end;

procedure Tfrmprincipal.ClassesBblicas1Click(Sender: TObject);
var
  x:string;
begin
  with data10.myimp do begin
    x:='select a.codigo,a.descricao,a.endereco,a.descricaodia,a.horario,a.numpessoas,';
    x:=x+' if(b.tipo='+#39+'M'+#39+',c.nome,d.nome) as onome,b.codtipo,';
    x:=x+' if(b.tipo='+#39+'M'+#39+','+#39+'MEMBRO'+#39+','+#39+'AMIGO'+#39+') as otipo';
    x:=x+' from classebiblica a left join participa_cb b on b.classebiblica=a.codigo';
    x:=x+' left join membro c on b.codtipo=c.codigo';
    x:=x+' left join amigo d on b.codtipo=d.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
    x:=x+' and (a.ativo='+#39+'S'+#39+')';
    x:=x+')';
    x:=x+' order by a.descricao';
    close;
    sql.clear;
    sql.add(x);
    open;
  end;
  Application.CreateForm(Tfrmimprel_005, frmimprel_005);
  frmimprel_005.titulo.Caption:='Relatório de Classes Bíblicas';
  frmimprel_005.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
  frmimprel_005.empresa.Caption:=frmprincipal.Configura[4];
  frmimprel_005.RLReport1.Preview;
  frmimprel_005.free;
end;

procedure Tfrmprincipal.Estoque1Click(Sender: TObject);
var
  x:string;
begin
  with data10.myimp do begin
    x:='select a.codigo,a.descricao,a.categoria,a.quantidade,a.vlrcompra,a.vlrvenda,';
    x:=x+' b.descricao as dcategoria';
    x:=x+' from material a left join material_tipo b on a.categoria=b.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
    x:=x+' and (a.ativo='+#39+'S'+#39+')';
    x:=x+')';
    x:=x+' order by a.categoria,a.descricao';
    close;
    sql.clear;
    sql.add(x);
    open;
  end;
  Application.CreateForm(Tfrmimprel_006, frmimprel_006);
  frmimprel_006.titulo.Caption:='Relatório de Estoque de Materiais';
  frmimprel_006.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
  frmimprel_006.empresa.Caption:=frmprincipal.Configura[4];
  frmimprel_006.RLReport1.Preview;
  frmimprel_006.free;
end;

procedure Tfrmprincipal.MateriaisDisponveis1Click(Sender: TObject);
var
  x:string;
begin
  with data10.myimp do begin
    x:='select a.codigo,a.descricao,a.categoria,a.quantidade,a.vlrvenda,';
    x:=x+' b.descricao as dcategoria';
    x:=x+' from material a left join material_tipo b on a.categoria=b.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+frmprincipal.Configura[3]+#39+')';
    x:=x+' and (a.ativo='+#39+'S'+#39+')';
    x:=x+' and (a.quantidade>0)';
    x:=x+')';
    x:=x+' order by a.categoria,a.descricao';
    close;
    sql.clear;
    sql.add(x);
    open;
  end;
  Application.CreateForm(Tfrmimprel_007, frmimprel_007);
  frmimprel_007.titulo.Caption:='Materiais Disponíveis';
  frmimprel_007.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
  frmimprel_007.empresa.Caption:=frmprincipal.Configura[4];
  frmimprel_007.RLReport1.Preview;
  frmimprel_007.free;
end;

procedure Tfrmprincipal.Chamada2Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmsemperiodo, frmsemperiodo);
  frmsemperiodo.tag:=1;
  frmsemperiodo.showmodal;
  frmsemperiodo.Free;
end;

procedure Tfrmprincipal.Corrige1Click(Sender: TObject);
var
  x,otrimestre,nalunos:string;
  erro:integer;
begin
  otrimestre:='6';

    with data10.myimp do begin
      close;
      sql.Clear;
      x:='select a.codigo,a.datamov,a.trimestre';
      x:=x+' from chamada_es a';
      x:=x+' where (';
      x:=x+' (a.trimestre='+#39+otrimestre+#39+')';
      x:=x+')';
      sql.add(x);
      open;
      first;
      while eof=false do begin
        nalunos:='0';
        data10.mytudo.Close;
        data10.mytudo.sql.clear;
        data10.mytudo.sql.add('select count(codigo) as npresente from lista_es where chamada='+#39+data10.myimp.fieldbyname('codigo').asstring+#39+' and presenca='+#39+'P'+#39);
        data10.mytudo.Open;
        if data10.mytudo.recordcount>0 then begin
          nalunos:=data10.mytudo.fieldbyname('npresente').asstring;
        end;

        with data10.exemysql do begin
          sql.clear;
          x:='UPDATE chamada_aponta SET ';
          x:=x+'p01='+#39+nalunos+#39;
          x:=x+' where chamada='+#39+data10.myimp.fieldbyname('codigo').asstring+#39;
          sql.add(x);
          ExecSql;
        end;


        next;
      end;
    end;



  x:='Concluído';
  application.MessageBox(pchar(x),'Atenção',mb_ok);
end;

procedure Tfrmprincipal.AbrirTrimestre1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmabretrimestre, frmabretrimestre);
  frmabretrimestre.showmodal;
  frmabretrimestre.Free;
end;

procedure Tfrmprincipal.MembrosnoMatriculados1Click(Sender: TObject);
var
  x:string;
begin
  with data10.myimp do begin
    close;
    sql.clear;
    x:='select a.codigo,a.ativo,a.nome,a.nascimento,a.estadocivil,a.batizado,b.descricao as nfamilia';
    x:=x+' from membro a left join familia b on a.familia=b.codigo';
    x:=x+' where (';
    x:=x+' (a.ativo='+#39+'S'+#39+')';
    x:=x+' and (a.igreja='+#39+'1'+#39+')';
    x:=x+' and (a.classe<=1)';
    x:=x+')';
    x:=x+' order by a.nome';
    sql.add(x);
    open;
  end;

  Application.CreateForm(Tfrmimprel_010, frmimprel_010);
  frmimprel_010.titulo.Caption:='Relatório de Membros não Matriculados';
  frmimprel_010.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
  frmimprel_010.empresa.Caption:=frmprincipal.Configura[4];
  frmimprel_010.RLReport1.Preview;
  frmimprel_010.free;

end;

procedure Tfrmprincipal.Membros2Click(Sender: TObject);
var
  x:string;
begin
  with data10.myimp do begin
    close;
    sql.clear;
    x:='select a.codigo,a.ativo,a.nome,a.nascimento,a.estadocivil,a.batizado,a.classe,b.descricao as nfamilia,c.descricao as dclasse,';
    x:=x+' PERIOD_DIFF(DATE_FORMAT(now(),"%Y%m%d"),DATE_FORMAT(a.nascimento,"%Y%m%d"))/1200 AS idade';
    x:=x+' from membro a left join familia b on a.familia=b.codigo left join classe c on a.classe=c.codigo';
    x:=x+' where (';
    x:=x+' (a.igreja='+#39+'1'+#39+')';
    x:=x+')';
    x:=x+' order by a.batizado,a.nome';
    sql.add(x);
    open;
  end;

  Application.CreateForm(Tfrmimprel_011, frmimprel_011);
  frmimprel_011.titulo.Caption:='Relatório de Membros Cadastrados';
  frmimprel_011.adataimp.Caption:='Impresso em '+formatdatetime('dd/mm/yy',date)+' às '+formatdatetime('hh:mm',time);
  frmimprel_011.empresa.Caption:=frmprincipal.Configura[4];
  frmimprel_011.RLReport1.Preview;
  frmimprel_011.free;
end;

procedure Tfrmprincipal.MatriculadeAlunos1Click(Sender: TObject);
begin
  if frmprincipal.MatriculadeAlunos1.visible=true then begin
    Application.CreateForm(Tfrmaluno, frmaluno);
    Application.CreateForm(Tfrmcadaluno, frmcadaluno);
    frmaluno.showmodal;
    frmaluno.Free;
    frmcadaluno.Free;
  end;
end;

procedure Tfrmprincipal.ResumoApontamentos1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmsemperiodo, frmsemperiodo);
  frmsemperiodo.tag:=2;
  frmsemperiodo.showmodal;
  frmsemperiodo.Free;
end;

procedure Tfrmprincipal.Classe101Click(Sender: TObject);
begin
  Application.CreateForm(Tfrmclasse10, frmclasse10);
  Application.CreateForm(Tfrmskype, frmskype);
  frmclasse10.showmodal;
  frmskype.Free;
  frmclasse10.Free;
end;

procedure Tfrmprincipal.corrige021Click(Sender: TObject);
var
  x,xdt:string;
  a1,a2:integer;
begin


  with data10.myimp do begin
    close;
    sql.Clear;
    x:='select a.codigo,a.datamov from chamada_aponta a';
    sql.add(x);
    open;
    first;
    a1:=0;
    a2:=0;
    while eof=false do begin
      data10.myaux.Close;
      data10.myaux.SQL.Clear;
      data10.myaux.SQL.Add('select codigo from sabado where datamov='+#39+mydata(data10.myimp.fieldbyname('datamov').asstring)+#39+' limit 0,1');
      data10.myaux.Open;
      if data10.myaux.recordcount=1 then begin

        a1:=a1+1;
        data10.exemysql.sql.clear;
        x:='UPDATE chamada_aponta SET ';
        x:=x+'codsabado='+#39+data10.myaux.fieldbyname('codigo').asstring+#39;
        x:=x+' where codigo='+#39+data10.myimp.fieldbyname('codigo').asstring+#39;
        data10.exemysql.sql.add(x);
        data10.exemysql.ExecSql;
      end else begin
        a2:=a2+1;
      end;
      statusbar1.Panels[0].Text:='Total = '+inttostr(a1+a2);
      application.ProcessMessages;
      next;
    end;
  end;
  x:='Sabados Encontrados = '+inttostr(a1)+#13;
  x:=x+'Sabados Criados = '+inttostr(a2)+#13;
  application.MessageBox(pchar(x),'Atenção',mb_ok);
end;

end.
