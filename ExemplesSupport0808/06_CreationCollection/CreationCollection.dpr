{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program CreationCollection;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  StreamCpta : TBSCPTAApplication3;
  BaseCpta   : IBSCPTAApplication3;
  CollTiers  : IBICollection;
  Tiers      : IBOTiers3;
  I          : Integer;

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
      try
        CollTiers := BaseCpta.FactoryTiers.List;
        Writeln(
          StrToOem('La base de données contient '),
          CollTiers.Count,
          ' tiers.');
        Tiers := CollTiers.Item[CollTiers.Count] as IBOTiers3;
        Writeln('Le dernier tiers se nomme ', Tiers.CT_Intitule, '.');
        Writeln(sLineBreak, 'Liste des tiers :');
        for I := 1 to CollTiers.Count do
        begin
          Writeln((CollTiers.Item[I] as IBOTiers3).CT_Num);
        end;
      except
        on E:Exception do
          Writeln(
            StrToOem('Erreur en création d''une collection de tiers : '),
            sLineBreak,
            E.Classname,
            ': ',
            StrToOem(E.Message));
      end;
    end;
  finally
    FermeBaseCpta(BaseCpta);
    FreeAndNil(StreamCpta);
    CoUnInitialize;
    Readln;
   end;
end.
