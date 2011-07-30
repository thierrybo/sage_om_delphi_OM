{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program CreationBaseCial;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Objets100Lib_TLB,
  ActiveX,
  Windows;

var
  StreamCpta  : TBSCPTAApplication3;
  BaseCpta    : IBSCPTAApplication3;
  StreamCial  : TBSCIALApplication3;
  BaseCial    : IBSCIALApplication3;

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
    Writeln(StrToOem('Création de la base comptable ') , ANomBase , ' en cours');
    ABaseCpta.Name := ANomBase;
    ABaseCpta.Create();
    Result := true;
  except on E: Exception do
    begin
      Writeln(
        StrToOem('Erreur en création de base comptable : '),
        ABaseCpta.Name,
        ' : ',
        sLineBreak,
        E.ClassName,
        ': ',
        StrToOem(E.Message));
      Result := false;
    end;
  end;
end;

function OuvreBaseCpta(var ABaseCpta: IBSCPTAApplication3; ANomBaseCpta: string;
    AUtilisateur: string = ''; AMotDePasse: string = ''): Boolean;
begin
  try
    ABaseCpta.Name := ANomBaseCpta;
    if (AUtilisateur <> '') then
    begin
      ABaseCpta.Loggable.UserName := AUtilisateur;
      ABaseCpta.Loggable.UserPwd  := AMotDePasse;
    end;
    ABaseCpta.Open;
    Result := true;
  except on E: Exception do
    begin
      Writeln(
        'Erreur en ouverture de base comptable ',
        ABaseCpta.Name,
        ' : ',
        sLineBreak,
        E.ClassName,
        ': ',
        StrToOem(E.Message));
      Result := false;
    end;
  end;
end;

function FermeBaseCpta(var ABaseCpta: IBSCPTAApplication3): Boolean;
begin
  try
    if ((ABaseCpta <> nil) and ABaseCpta.IsOpen) then
    begin
      ABaseCpta.Close;
      Result := true;
    end;
  except on E: Exception do
    begin
      Writeln(
        'Erreur en fermeture de base comptable ',
        ABaseCpta.Name,
        ' : ',
        sLineBreak,
        E.ClassName,
        ': ',
        StrToOem(E.Message));
      Result := false;
    end;
  end;
end;

function CreeBaseCial(var ABaseCial: IBSCIALApplication3; ANomBaseCial: string;
    var ABaseCpta: IBSCPTAApplication3; ANomBaseCpta: string):  Boolean;
begin
  try
    if not FileExists(ANomBaseCpta) then
    begin
      CreeBaseCpta(ABaseCpta, ANomBaseCpta);
    end;
    if OuvreBaseCpta(ABaseCpta, ANomBaseCpta) then
    begin
      Writeln(
        StrToOem('Création de la base commerciale '),
        ANomBaseCial,
        ' en cours');
      ABaseCial.CptaApplication  := ABaseCpta;
      ABaseCial.Name             := ANomBaseCial;
      ABaseCial.Create();
      FermeBaseCpta(ABaseCpta);
      Result := true;
    end
    else
    begin
      Result := false;
    end;
  except on E: Exception do
    begin
      Writeln(
        StrToOem('Erreur en création de base commerciale '),
        ABaseCial.Name,
        ' : ',
        sLineBreak,
        E.ClassName,
        ': ',
        StrToOem(E.Message));
      Result := false;
    end;
  end;
end;

begin
  CoInitialize(nil);
  StreamCpta  := TBSCPTAApplication3.Create(nil);
  BaseCpta    := StreamCpta.DefaultInterface;
  StreamCial  := TBSCIALApplication3.Create(nil);
  BaseCial    := StreamCial.DefaultInterface;
  try
    if CreeBaseCial(BaseCial, 'C:\Temp\test2.gcm', BaseCpta, 'C:\Temp\test2.mae')
        then
    begin
        Writeln(StrToOem('Base commerciale créée !'));
    end;
  finally
    FreeAndNil(StreamCial);
    FreeAndNil(StreamCpta);
    CoUnInitialize;
    Readln;
  end;
end.
