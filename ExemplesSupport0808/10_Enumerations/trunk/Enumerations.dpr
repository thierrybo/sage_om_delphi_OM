{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program Enumerations;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  StreamCpta  : TBSCPTAApplication3;
  BaseCpta    : IBSCPTAApplication3;
  Journal     : IBOJournal3;

begin
  CoInitialize(nil);
  StreamCpta  := TBSCPTAApplication3.Create(nil);
  BaseCpta    := StreamCpta.DefaultInterface;
  try
    if OuvreBaseCpta(BaseCpta,
      'C:\Documents and Settings\All Users\Documents\Sage\Sage Entreprise\BIJOU.MAE',
      '<Administrateur>'
      ) then
    begin
      Journal             := BaseCpta.FactoryJournal.Create as IBOJournal3;
      Journal.JO_Type     := JournalTypeVente;
      Journal.JO_Num      := 'VTE2';
      Journal.JO_Intitule := 'Vente 2';
      Journal.Write;
    end;
  finally
    FermeBaseCpta(BaseCpta);
    FreeAndNil(StreamCpta);
    CoUnInitialize;
    Readln;
  end;
end.
