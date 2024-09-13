unit unHttp;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, FPHttpServer, unNFe, fpjson, jsonparser;

type

  { TMyHttpServer }

  TMyHttpServer = class
  private
    FServer: TFPHttpServer;
  public
    constructor Create;
    procedure HandleRequest(Sender: TObject; var ARequest: TFPHTTPConnectionRequest; var AResponse: TFPHTTPConnectionResponse);
    procedure StartServer;
    procedure StopServer;
  end;


implementation

{ TMyHttpServer }

constructor TMyHttpServer.Create;
begin
  FServer := TFPHttpServer.Create(nil);
  FServer.OnRequest := @HandleRequest;
  FServer.Port := 8080; // Porta onde o servidor irá rodar
end;

procedure TMyHttpServer.HandleRequest(Sender: TObject;
  var ARequest: TFPHTTPConnectionRequest;
  var AResponse: TFPHTTPConnectionResponse);
var
  JSONResponse: TJSONObject;
  ChaveParam: string;
begin
  JSONResponse := TJSONObject.Create;
  try
    // Verifica se a rota é '/nfe'
    if ARequest.PathInfo = '/nfe' then
    begin
      ChaveParam := ARequest.QueryFields.Values['chave'];

      if ChaveParam = '' then
      begin
        // Se a chave não for fornecida, retorna uma mensagem de erro
        JSONResponse.Add('status', 'error');
        JSONResponse.Add('message', 'Chave não informada');
      end
      else
      begin
        // Se a chave for fornecida, retorna uma mensagem de sucesso
        JSONResponse.Add('status', 'success');
        JSONResponse.Add('message', 'Chave informada, ' + ChaveParam);
        unNFe.consultar(ChaveParam);

      end;
    end
    else
    begin
      // Se a rota não for '/nfe', retorna erro de rota inválida
      JSONResponse.Add('status', 'error');
      JSONResponse.Add('message', 'Rota não encontrada');
    end;

    AResponse.Content := JSONResponse.AsJSON;
    AResponse.ContentType := 'application/json';
  finally
    JSONResponse.Free;
  end;
end;

procedure TMyHttpServer.StartServer;
begin
  FServer.Active := True;
end;

procedure TMyHttpServer.StopServer;
begin
    FServer.Active := False;
end;

end.

