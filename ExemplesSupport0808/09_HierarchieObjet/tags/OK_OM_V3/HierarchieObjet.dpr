{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program HierarchieObjet;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  StreamCpta  : TBSCPTAApplication3;
  BaseCpta    : IBSCPTAApplication3;

procedure AfficheHierarchie(ABanque: IBOTiersBanque3);
begin
  try
    Writeln('La banque est : ', StrToOem(ABanque.BT_Intitule));
    Writeln(
      'Le stream est la base comptable : ',
      (ABanque.Stream as IBSCPTAApplication3).Name);
    Writeln(StrToOem('L''objet maître est le tiers : '), ABanque.Tiers.CT_Num);

    { Au préalable, crééer une seconde ABanque pour le tiers CARAT }
    Writeln(
      'La seconde banque est : ',
      StrToOem((
        ABanque.FactoryTiersBanque.List.Item[2] as IBOTiersBanque3)
        .BT_Intitule));
  except
    on E:Exception do
      Writeln(E.Classname, ': ', StrToOem(E.Message));
  end;
end;

begin
  CoInitialize(nil);
  StreamCpta := TBSCPTAApplication3.Create(nil);
  BaseCpta   := StreamCpta.DefaultInterface;
  try
    if OuvreBaseCpta(BaseCpta,
      'C:\Documents and Settings\All Users\Documents\Sage\Sage Entreprise\BIJOU.MAE'
      ) then
    begin
      AfficheHierarchie((BaseCpta.FactoryTiers.ReadNumero('CARAT').
        FactoryTiersBanque.List.Item[1]) as IBOTiersBanque3);
    end;
  finally
    FermeBaseCpta(BaseCpta);
    FreeAndNil(StreamCpta);
    CoUnInitialize;
    Readln;
  end;
end.
