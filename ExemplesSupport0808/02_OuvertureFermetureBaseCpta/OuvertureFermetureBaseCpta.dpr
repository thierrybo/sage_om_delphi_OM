{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program OuvertureFermetureBaseCpta;

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

function OuvreBaseCpta(
  var ABaseCpta : IBSCPTAApplication3;
  ANomBaseCpta  : string;
  AUtilisateur  : string = '';
  AMotDePasse   : string = ''): Boolean;
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

begin
  CoInitialize(nil);
  StreamCpta  := TBSCPTAApplication3.Create(nil);
  BaseCpta    := StreamCpta.DefaultInterface;
  try

    { Au préalable, créer un utilisateur DURANT ayant pour mot de passe 1234 : }
    if (OuvreBaseCpta(BaseCpta, 'C:\Temp\BIJOU.MAE', 'DURANT', '1234')) then
    begin
      writeln('Base comptable ', BaseCpta.Name, ' ouverte !');
      if FermeBaseCpta(BaseCpta) then
      begin
        Writeln('Base comptable ', BaseCpta.Name, StrToOem(' fermée !'));
      end;
    end;
  finally
    FreeAndNil(StreamCpta);
    CoUnInitialize;
    Readln;
  end;
end.
