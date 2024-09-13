unit unNFe;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ACBrNFe, unConfig;
  function consultar(chave: string): string;

var
  nfe: TACBrNFe;

implementation

function consultar(chave: string): string;
begin
  unConfig.configurar(nfe);
  nfe.NotasFiscais.Clear;
  nfe.WebServices.Consulta.NFeChave := chave;
  nfe.WebServices.Consulta.Executar;
  result := nfe.WebServices.Consulta.RetWS;
end;

end.

