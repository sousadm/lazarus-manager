unit unNFe;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ACBrNFe;
  function consultar(chave: string): string;

implementation

function consultar(chave: string): string;
var
  nfe: TACBrNFe;
begin
  result := chave;

end;

end.

