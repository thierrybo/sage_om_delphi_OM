{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program ExoEcrituresComptables;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  StreamCpta        : TBSCPTAApplication3;
  BaseCpta          : IBSCPTAApplication3;
  Ecriture          : IBOEcriture3;
  Journal           : IBOJournal3;
  CpteContrepartie  : IBOCompteG3;
  Tiers             : IBOTiers3;
  DatePiece         : TDateTime;
  IntitulePiece     : string;
  NumFacture        : string;
  NumPiece          : string;
  Montant           : Double;

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
        Journal       := BaseCpta.FactoryJournal.ReadNumero('VTE');
        DatePiece     := StrToDateTime('01/07/07');
        IntitulePiece := 'Vente Bague Or';
        NumFacture    := 'FA1234';
        Tiers         := BaseCpta.FactoryClient.ReadNumero('BAGUES');

        Ecriture      := BaseCpta.FactoryEcriture.Create as IBOEcriture3;
        with Ecriture do
        begin
          Journal     := ExoEcrituresComptables.Journal;
          NumPiece    := Ecriture.Journal.NextEC_Piece[StrToDateTime('03/07/07')];
          Date        := DatePiece;
          Tiers       := ExoEcrituresComptables.Tiers;
          EC_Intitule := IntitulePiece;
          EC_RefPiece := NumFacture;
          EC_Piece    := NumPiece;
          EC_Sens     := EcritureSensTypeDebit;
          Devise      := BaseCpta.FactoryDevise.ReadIntitule('Dollar US');
          EC_Devise   := 100;

          { Initialisation champs (ex : montant, compte général, compte de
            contrepartie) }
          SetDefault;
          WriteDefault;
          Montant           := EC_Montant;
          CpteContrepartie  := CompteG;
        end;

        Ecriture := BaseCpta.FactoryEcriture.Create as IBOEcriture3;
        with Ecriture do
        begin
          Journal             := ExoEcrituresComptables.Journal;
          Date                := DatePiece;
          CompteG             := BaseCpta.FactoryCompteG.ReadNumero('701090');
          CompteGContrepartie := CpteContrepartie;
          TiersContrepartie   := Tiers;
          EC_Intitule         := IntitulePiece;
          EC_RefPiece         := NumFacture;
          EC_Piece            := NumPiece;
          EC_Sens             := EcritureSensTypeCredit;
          EC_Montant          := Montant;
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
  end;
end.
