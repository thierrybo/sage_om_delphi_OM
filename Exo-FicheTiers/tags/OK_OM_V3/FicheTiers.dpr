{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program FicheTiers;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  BaseCpta              : IBSCPTAApplication3;
  StreamCial            : TBSCIALApplication3;
  BaseCial              : IBSCIALApplication3;
  Client                : IBOClient3;
  Contact               : IBOTiersContact3;
  ModeleReglement       : IBOModeleReglement;
  LigneModeleReglement  : IBOModeleReglementLigne;
  I                     : Integer;

begin
  CoInitialize(nil);
  StreamCial            := TBSCIALApplication3.Create(nil);
  BaseCial              := StreamCial.DefaultInterface;

  try
    try
      if OuvreBaseCial(BaseCial,
        'C:\Documents and Settings\All Users\Documents\Sage\Sage Entreprise\Bijou.gcm'
        ) then
      begin

        { ' Base comptable li�e : }
        BaseCpta := BaseCial.CptaApplication;

        { ' 1 - Cr�ation d'un nouveau client MATHIS : }
        Client := BaseCpta.FactoryClient.Create as IBOClient3;
        With Client do
        begin
          CT_Num        := 'MATHIS';
          CT_Intitule   := 'Mathis SARL';
          CompteGPrinc  := BaseCpta.FactoryCompteG.ReadNumero('4110000');
          Representant  := BaseCial.FactoryRepresentant.ReadNomPrenom('GENDRON',
                           'Bernard');
          CT_Stat[1]    := 'Est';
          Write;

          InfoLibre.Item['Capital_social'] := 100000;
          Write;
        end;

        { 2 - Cr�ation d'un nouveau contact pour le client MATHIS : }
        Contact := Client.FactoryTiersContact.Create as IBOTiersContact3;
        With Contact do
        begin
          Nom             := 'Bolle';
          Prenom          := 'Virginie';
          Fonction        := 'Comptable';
          Telephone       := '03 12 34 56 78';
          TelPortable     := '06 12 34 56 78';
          ServiceContact  := BaseCpta.FactoryServiceContact.ReadIntitule(
                             'Comptabilit�');
          WriteDefault;
        end;

        { 3 - Affichage de la liste des contacts du Client MATHIS : }
		{ TODO: ATTENTION d�placer l'appel jusqu'� la collection (.List) dans une 
			variable sinon chaque appel il doit recr�er la liste => peut etre long }
        Writeln(#10, 'Contacts du client ', Client.CT_Num, ' :');
        for I := 1 to Client.FactoryTiersContact.List.Count do
        begin
          Writeln(StrToOem(
            (Client.FactoryTiersContact.List.Item[I] as IBOTiersContact3).Nom),
            ' ', StrToOem(
            (Client.FactoryTiersContact.List.Item[I] as IBOTiersContact3).
            Prenom));
        end;
        Writeln(#10, 'Total : ', Client.FactoryTiersContact.List.Count);

        { 4 - Cr�ation d'un mod�le de r�glement "Paiement en 2 fois (acompte
          10 %)" :  }
        ModeleReglement          := BaseCpta.FactoryModeleReglement.Create as
                                    IBOModeleReglement;
        ModeleReglement.Intitule := 'Paiement en 2 fois (acompte 10 %)';
        ModeleReglement.WriteDefault;

        { 1ere ligne de r�glement : }
        LigneModeleReglement := ModeleReglement.FactoryModeleReglementLigne.
          Create as IBOModeleReglementLigne;
        with LigneModeleReglement do
        begin
          Condition := ReglementConditionTypeJour;
          NbJour    := 0;
          Reglement := BaseCpta.FactoryReglement.ReadIntitule('Carte bancaire');
          TRepart   := ReglementRepartitionTypePourcent;
          VRepart   := 10;
          WriteDefault;
        end;

        { 2eme ligne de r�glement : }
        LigneModeleReglement := ModeleReglement.FactoryModeleReglementLigne.
          Create as IBOModeleReglementLigne;
        with LigneModeleReglement do
        begin
          Condition := ReglementConditionTypeJour;
          NbJour    := 90;
          Reglement := BaseCpta.FactoryReglement.ReadIntitule('Pr�l�vement');
          TRepart   := ReglementRepartitionTypeEquilib;
          WriteDefault;
        end;

        { 5 - Affectation du mod�le de r�glement au client MATHIS : }
        Client.ModeleReglement := ModeleReglement;
        Client.WriteDefault;
      end;

    except
      on E:Exception do
        Writeln(E.Classname, ': ', StrToOem(E.Message));
    end;
  finally
    FermeBaseCial(BaseCial);
    FreeAndNil(StreamCial);
    CoUnInitialize;
    Readln;
  end;
end.
