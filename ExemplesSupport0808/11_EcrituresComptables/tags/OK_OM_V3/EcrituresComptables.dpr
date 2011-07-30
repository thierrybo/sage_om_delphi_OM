{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program EcrituresComptables;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  StreamCpta  : TBSCPTAApplication3;
  BaseCpta    : IBSCPTAApplication3;
  Ecriture    : IBOEcriture3;

begin
  CoInitialize(nil);
  StreamCpta  := TBSCPTAApplication3.Create(nil);
  BaseCpta    := StreamCpta.DefaultInterface;
  try
    try
      if OuvreBaseCpta(BaseCpta,
        'C:\Documents and Settings\All Users\Documents\Sage\Sage Entreprise\BIJOU.MAE'
        ) then
      begin
        Ecriture := BaseCpta.FactoryEcriture.Create as IBOEcriture3;
        with Ecriture do
        begin
          Journal     := BaseCpta.FactoryJournal.ReadNumero('BEU');
          Date        := StrToDateTime('03/07/07');
          Tiers       := BaseCpta.FactoryClient.ReadNumero('CARAT');
          EC_Intitule := 'Acompte';
          EC_RefPiece := 'FA1234';
          EC_Piece    := Journal.NextEC_Piece[StrToDateTime('03/07/07')];
          EC_Montant  := 123.45;
          EC_Sens     := EcritureSensTypeCredit;
          SetDefault;
          WriteDefault;
        end;
      end;
    except
      on E:Exception do
      begin
        Writeln(E.Classname, ': ', StrToOem(E.Message));
        Readln;
      end;
    end;
  finally
    FermeBaseCpta(BaseCpta);
    FreeAndNil(StreamCpta);
    CoUnInitialize;
    Readln;
  end;
end.
