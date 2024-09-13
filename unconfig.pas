unit unConfig;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, blcksock, pcnConversaoNFe, pcnConversao,
  ACBrNFeConfiguracoes, ACBrDFeSSL, ACBrNFe;
  procedure Configurar(var nfe: TACBrNFe);

implementation

procedure Configurar(var nfe: TACBrNFe);
begin
  nfe := TACBrNFe.Create(NIL);
  //nfe.Configuracoes.Certificados.URLPFX      :=
  nfe.Configuracoes.Certificados.ArquivoPFX  := 'asasul.pfx';
  nfe.Configuracoes.Certificados.Senha       := 'edtSenha.Text';
  nfe.Configuracoes.Certificados.NumeroSerie := 'edtNumSerie.Text';
  nfe.SSL.DescarregarCertificado;

  with nfe.Configuracoes.Geral do
  begin
    SSLLib        := TSSLLib.libOpenSSL;
    SSLCryptLib   := TSSLCryptLib.cryOpenSSL;
    SSLHttpLib    := TSSLHttpLib.httpOpenSSL;
    SSLXmlSignLib := TSSLXmlSignLib.xsNone;
    AtualizarXMLCancelado := false;
    Salvar           := false;
    ExibirErroSchema := false;
    RetirarAcentos   := false;
    FormatoAlerta    := '';
    FormaEmissao     := TpcnTipoEmissao.teNormal;
    ModeloDF         := TpcnModeloDF.moNFe;
    VersaoDF         := TpcnVersaoDF.ve400;
    //IdCSC            := edtIdToken.Text;
    //CSC              := edtToken.Text;
    VersaoQRCode     := veqr200;
  end;

  with nfe.Configuracoes.WebServices do
  begin
    UF         := 'CE';
    Ambiente   := TpcnTipoAmbiente.taHomologacao;
    Visualizar := false;
    Salvar     := false;
    AjustaAguardaConsultaRet := false;
    AguardarConsultaRet := 1000;
    Tentativas := 10;
    IntervaloTentativas := 1000;
  end;

  nfe.SSL.SSLType := TSSLType.LT_TLSv1_3;

  with nfe.Configuracoes.Arquivos do
  begin
    Salvar           := true;
    SepararPorMes    := true;
    AdicionarLiteral := true;
    EmissaoPathNFe   := true;
    SalvarEvento     := true;
    SepararPorCNPJ   := true;
    SepararPorModelo := true;
    PathSchemas      := 'schemas';
    PathNFe          := 'nfe';
    PathInu          := 'nfe/inutilizadas';
    PathEvento       := 'nfe/eventos';
    //PathMensal       := TArquivosConfNFe.GetPathNFe(0)
    //PathSalvar       := PathMensal;
  end;

end;

end.

