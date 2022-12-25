{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

unit Commun;

interface

uses
  SysUtils,
  Objets100cLib_TLB,
  Windows;

function StrToOem(const AStr: string): AnsiString;
function OuvreBaseCpta(var ABaseCpta: IBSCPTAApplication3; ANomBaseCpta: string;
    AUtilisateur: string = ''; AMotDePasse: string = ''): Boolean;
function FermeBaseCpta(var ABaseCpta: IBSCPTAApplication3): Boolean;
function OuvreBaseCial(var ABaseCial: IBSCIALApplication3; ANomBaseCial: string;
    AUtilisateur: string = ''; AMotDePasse: string = ''): Boolean;
function FermeBaseCial(var ABaseCial: IBSCIALApplication3): Boolean;

implementation

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
        'Erreur en fermeture de base commerciale ',
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

function OuvreBaseCial(var ABaseCial: IBSCIALApplication3; ANomBaseCial: string;
    AUtilisateur: string = ''; AMotDePasse: string = ''): Boolean;
begin
  try
    ABaseCial.Name := ANomBaseCial;
    if (AUtilisateur <> '') then
    begin
      ABaseCial.Loggable.UserName := AUtilisateur;
      ABaseCial.Loggable.UserPwd  := AMotDePasse;
    end;
    ABaseCial.Open;
    Result := true;
  except on E: Exception do
    begin
      Writeln(
        'Erreur en ouverture de base comptable ',
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

function FermeBaseCial(var ABaseCial: IBSCIALApplication3): Boolean;
begin
  try
    if ((ABaseCial <> nil) and ABaseCial.IsOpen) then
    begin
      ABaseCial.Close;
      Result := true;
    end;
  except on E: Exception do
    begin
      Writeln(
        'Erreur en fermeture de base comptable ',
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

end.
