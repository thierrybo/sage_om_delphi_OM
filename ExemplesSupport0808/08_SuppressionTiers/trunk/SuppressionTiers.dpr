{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program SuppressionTiers;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  StreamCpta : TBSCPTAApplication3;
  BaseCpta   : IBSCPTAApplication3;

function SupprimeTiers(var ABaseCpta: IBSCPTAApplication3; ANumTiers: string):
  Boolean;
var
  ObjetTiers : IBOTiers3;
begin
  try
    ObjetTiers  := ABaseCpta.FactoryTiers.ReadNumero(ANumTiers);
    ObjetTiers.Remove;
    Result      := true;
  except on E: Exception do
    begin
    Writeln(
      'Erreur en suppression de l''enregistrement ',
      ANumTiers,
      ' dans la table F_COMPTET : ',
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
  StreamCpta := TBSCPTAApplication3.Create(nil);
  BaseCpta   := StreamCpta.DefaultInterface;
  try
    if OuvreBaseCpta(BaseCpta,
      'C:\Documents and Settings\All Users\Documents\Sage\Sage Entreprise\BIJOU.MAE',
      '<Administrateur>'
      ) then
    begin
      if SupprimeTiers(BaseCpta, 'ZAN') then
        Writeln(StrToOem('Tiers ZAN supprimé !'));
      if SupprimeTiers(BaseCpta, 'CARAT') then
        Writeln(StrToOem('Tiers CARAT supprimé !'));
    end;
  finally
    FermeBaseCpta(BaseCpta);
    FreeAndNil(StreamCpta);
    CoUnInitialize;
    Readln;
   end;
end.
