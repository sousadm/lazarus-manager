program manager;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp,
    fphttpserver, fpjson, jsonparser, unHttp
  { you can add units after this };

type

  { TManager }

  TManager = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TManager }

procedure TManager.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }

  // stop program loop
  Terminate;
end;

constructor TManager.Create(TheOwner: TComponent);
var
  MyServer: TMyHttpServer;
begin
  inherited Create(TheOwner);
  StopOnException:=True;

  MyServer := TMyHttpServer.Create;
  try
    Writeln('Servidor REST rodando em http://localhost:8080');
    MyServer.StartServer;
    Readln; // Aguarda uma entrada do usuário para encerrar o servidor
  finally
    MyServer.StopServer;
    MyServer.Free;
  end;

end;

destructor TManager.Destroy;
begin
  inherited Destroy;
end;

procedure TManager.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: TManager;
begin
  Application:=TManager.Create(nil);
  Application.Title:='Gerenciador Fiscal';
  Application.Run;
  Application.Free;
end.

