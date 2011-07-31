{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program EnregistrementObjet;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  StreamCpta : TBSCPTAApplication3;
  BaseCpta   : IBSCPTAApplication3;
  Client     : IBOClient3;

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
        Client := BaseCpta.FactoryClient.Create as IBOClient3;
        With Client do
        begin
          CT_Num       := 'BOLLE';
          CT_Intitule  := 'Bolle Virginie';
          TiersPayeur  := Client;
          CompteGPrinc := BaseCpta.FactoryCompteG.ReadNumero('4110000');
          Write;
        end;
        Writeln(StrToOem('Client correctement créé'));
      except
        on E:Exception do
          Writeln(
            StrToOem('Erreur en création du client : '),
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
