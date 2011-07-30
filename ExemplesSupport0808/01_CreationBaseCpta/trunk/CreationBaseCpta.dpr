{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program CreationBaseCpta;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Objets100Lib_TLB,
  ActiveX,
  Windows;

var
  StreamCpta  : TBSCPTAApplication3;
  BaseCpta    : IBSCPTAApplication3;

function StrToOem(const AStr: string): AnsiString;
begin
  SetLength(Result, Length(AStr));
  if Length(Result) <> 0 then
    CharToOem(PChar(AStr), PAnsiChar(Result));
end;

function CreeBaseCpta(var ABaseCpta: IBSCPTAApplication3; ANomBase: string):
    Boolean;
begin
  try
    Writeln(StrToOem('Création de la base comptable '), ANomBase, ' en cours');
    ABaseCpta.Name := ANomBase;
    ABaseCpta.Create();
    Result := true;
  except on E: Exception do
    begin
      Writeln(StrToOem('Erreur en création de base comptable '),
        ABaseCpta.Name, ' : ', sLineBreak, E.ClassName, ': ', E.Message);
      Result := false;
    end;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  CoInitialize(nil);
  StreamCpta  := TBSCPTAApplication3.Create(nil);
  BaseCpta    := StreamCpta.DefaultInterface;
  try
    if CreeBaseCpta(BaseCpta, 'C:\Temp\test1.mae') then
    begin
        Writeln(StrToOem('Base comptable correctement créée !'));
    end;
  finally
    FreeAndNil(StreamCpta);
    CoUnInitialize;
    Readln;
  end;
end.
