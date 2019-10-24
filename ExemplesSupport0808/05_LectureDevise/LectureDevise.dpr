{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program LectureDevise;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  StreamCpta      : TBSCPTAApplication3;
  BaseCpta        : IBSCPTAApplication3;
  IntituleDevise  : string;
  Devise          : IBPDevise2;

begin
  CoInitialize(nil);
  StreamCpta      := TBSCPTAApplication3.Create(nil);
  BaseCpta        := StreamCpta.DefaultInterface;
  try
    if OuvreBaseCpta(BaseCpta,
        'C:\Documents and Settings\All Users\Documents\Sage\Sage Entreprise\BIJOU.MAE',
        '<Administrateur>'
        ) then
    begin
      try
        IntituleDevise := 'Dollar US';
        Devise         := BaseCpta.FactoryDevise.ReadIntitule(IntituleDevise);
        With Devise do
        begin
          Writeln(StrToOem('Intitulé : '), D_Intitule);
          Writeln(StrToOem('Unité : ')   , D_Monnaie);
          Writeln(StrToOem('Cours ')     , FormatFloat('#0.##' ,D_Cours));
        end;
      except
        on E:Exception do
          Writeln(
            'Erreur en lecture de l''enregistrement ',
            IntituleDevise,
            ' de la table P DEVISE : ',
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
