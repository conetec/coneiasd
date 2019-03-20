program ConeIASD;

uses
  Forms,
  principal in 'principal.pas' {frmprincipal},
  splash in 'splash.pas' {frmsplash},
  cadusuario in 'cadusuario.pas' {frmcadusu},
  senha in 'senha.pas' {frmsenha},
  datamodule10 in 'datamodule10.pas' {data10: TDataModule},
  cadnivel in 'cadnivel.pas' {frmcadnivel},
  agenda in 'agenda\agenda.pas' {frmagenda},
  cadagenda in 'agenda\cadagenda.pas' {frmcadagenda},
  cadcompromisso in 'agenda\cadcompromisso.pas' {frmcadcompromisso},
  calendario in 'calendario.pas' {frmcalendario},
  nivel in 'nivel.pas' {frmnivel},
  pirata in 'PIRATA.PAS' {frmpirata},
  telarelato in 'agenda\telarelato.pas' {frmtelarelato1},
  cadamigo in 'cadamigo.pas' {frmcadamigo},
  imp3 in 'agenda\imp3.pas' {frmimp3},
  imp1 in 'agenda\imp1.pas' {frmimp1},
  imp2 in 'agenda\imp2.pas' {frmimp2},
  cadclasse in 'cadclasse.pas' {frmcadclasse},
  PiconeBarreTache in 'webcam\Composant\piconebarretache.pas',
  AviCaptura in 'webcam\Composant\avicaptura.pas',
  Camera in 'webcam\Composant\camera.pas',
  funcaolocal in 'funcaolocal.pas',
  locclasse in 'locclasse.pas' {frmlocclasse},
  classe in 'classe.pas' {frmclasse},
  amigo in 'amigo.pas' {frmamigo},
  cadfamilia in 'cadfamilia.pas' {frmcadfamilia},
  locamigo in 'locamigo.pas' {frmlocamigo},
  solicitacao in 'solicitacao.pas' {frmsolicitacao},
  cadsolicitacao in 'cadsolicitacao.pas' {frmcadsolicitacao},
  locmaterial_tipo in 'locmaterial_tipo.pas' {frmlocmaterial_tipo},
  cargo in 'cargo.pas' {frmcargo},
  contatoes in 'contatoes.pas' {frmcontatoes},
  loccargo in 'loccargo.pas' {frmloccargo},
  familia in 'familia.pas' {frmfamilia},
  cadacompanha in 'cadacompanha.pas' {frmcadacompanha},
  acompanhaes in 'acompanhaes.pas' {frmacompanhaes},
  chamadaes in 'chamadaes.pas' {frmchamadaes},
  abresabado in 'abresabado.pas' {frmabresabado},
  ligacargo in 'ligacargo.pas' {frmligacargo},
  locfamilia in 'locfamilia.pas' {frmlocfamilia},
  visita in 'visita.pas' {frmvisita},
  cadestudo in 'cadestudo.pas' {frmcadestudo},
  locinstrutor in 'locinstrutor.pas' {frmlocinstrutor},
  material_entrada in 'material_entrada.pas' {frmmaterial_entrada},
  visitacaomp in 'visitacaomp.pas' {frmvisitacaomp},
  instrutor in 'instrutor.pas' {frminstrutor},
  cadmaterial_entrada in 'cadmaterial_entrada.pas' {frmcadmaterial_entrada},
  semperiodo in 'semperiodo.pas' {frmsemperiodo},
  imprel_007 in 'relatorios\imprel_007.pas' {frmimprel_007},
  editaimg in 'editaimg.pas' {frmeditaimg},
  testes in 'temporario\testes.pas' {frmtestes},
  captura01 in 'captura01.pas' {frmcaptura01},
  selchamada in 'selchamada.pas' {frmselchamada},
  usuario in 'usuario.pas' {frmusuario},
  material_tipo in 'material_tipo.pas' {frmmaterial_tipo},
  cadmaterial_tipo in 'cadmaterial_tipo.pas' {frmcadmaterial_tipo},
  locmaterial in 'locmaterial.pas' {frmlocmaterial},
  cadmaterial in 'cadmaterial.pas' {frmcadmaterial},
  captura in 'captura.pas' {frmcaptura},
  imprel_001 in 'relatorios\imprel_001.pas' {frmimprel_001},
  estudo in 'estudo.pas' {frmestudo},
  acompanha_solicita in 'acompanha_solicita.pas' {frmacompanha_solicita},
  cadaluno in 'cadaluno.pas' {frmcadaluno},
  locmembro in 'locmembro.pas' {frmlocmembro},
  profissao in 'profissao.pas' {frmprofissao},
  cadprofissao in 'cadprofissao.pas' {frmcadprofissao},
  locestudob in 'locestudob.pas' {frmlocestudob},
  dupla in 'dupla.pas' {frmdupla},
  caddupla in 'caddupla.pas' {frmcaddupla},
  locprofissao in 'locprofissao.pas' {frmlocprofissao},
  locdupla in 'locdupla.pas' {frmlocdupla},
  classebiblica in 'classebiblica.pas' {frmclassebiblica},
  mudasenha in 'mudasenha.pas' {frmmudasenha},
  material in 'material.pas' {frmmaterial},
  material_saida in 'material_saida.pas' {frmmaterial_saida},
  cadmaterial_saida in 'cadmaterial_saida.pas' {frmcadmaterial_saida},
  conservacao in 'conservacao.pas' {frmconservacao},
  cadclassebiblica in 'cadclassebiblica.pas' {frmcadclassebiblica},
  aluno in 'aluno.pas' {frmaluno},
  cadcargo in 'cadcargo.pas' {frmcadcargo},
  participa_cb in 'participa_cb.pas' {frmparticipa_cb},
  pequenogrupo in 'pequenogrupo.pas' {frmpequenogrupo},
  cadpequenogrupo in 'cadpequenogrupo.pas' {frmcadpequenogrupo},
  participa_classe in 'participa_classe.pas' {frmparticipa_classe},
  cadvisita in 'cadvisita.pas' {frmcadvisita},
  solicitaja in 'solicitaja.pas' {frmsolicitaja},
  imprel_008 in 'relatorios\imprel_008.pas' {frmimprel_008},
  imprel_003 in 'relatorios\imprel_003.pas' {frmimprel_003},
  imprel_004 in 'relatorios\imprel_004.pas' {frmimprel_004},
  imprel_011 in 'relatorios\imprel_011.pas' {frmimprel_011},
  imprel_006 in 'relatorios\imprel_006.pas' {frmimprel_006},
  participa_pg in 'participa_pg.pas' {frmparticipa_pg},
  imprel_002 in 'relatorios\imprel_002.pas' {frmimprel_002},
  periodo in 'periodo.pas' {frmperiodo},
  abretrimestre in 'abretrimestre.pas' {frmabretrimestre},
  imprel_012 in 'relatorios\imprel_012.pas' {frmimprel_012},
  imprel_009 in 'relatorios\imprel_009.pas' {frmimprel_009},
  imprel_010 in 'imprel_010.pas' {frmimprel_010},
  membro in 'membro.pas' {frmmembro},
  cadmembro in 'cadmembro.pas' {frmcadmembro},
  imprel_005 in 'relatorios\imprel_005.pas' {frmimprel_005},
  classe10 in 'classe10.pas' {frmclasse10},
  skype in 'skype.pas' {frmskype},
  chamadacompleta in 'chamadacompleta.pas' {frmChamadaCompleta},
  resumoes in 'resumoes.pas' {frmResumoES};

{$R *.RES}






begin
//  if HprevHist = 0 then begin

  frmsplash:=Tfrmsplash.Create(application);
  frmsplash.show;
  frmsplash.update;
  Application.Initialize;
  Application.Title := 'ConeIASD Administração';
  Application.CreateForm(Tdata10, data10);
  Application.CreateForm(Tfrmsenha, frmsenha);
  Application.CreateForm(TfrmResumoES, frmResumoES);
  frmsplash.hide;
  frmsplash.free;
  Application.Run;
//  end

//else

//MessageDlg( 'Você não pode executar outra copia do aplicativo',

//mtInformation, [ mbOK ], 0 )

end.
