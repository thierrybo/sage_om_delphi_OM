{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program CreationObjetClient;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  StreamCpta  : TBSCPTAApplication3;
  BaseCpta    : IBSCPTAApplication3;
  ObjetClient : IBOClient3;

begin
  CoInitialize(nil);
  StreamCpta  := TBSCPTAApplication3.Create(nil);
  BaseCpta    := StreamCpta.DefaultInterface;
  try
    if OuvreBaseCpta(BaseCpta,
        'C:\Documents and Settings\All Users\Documents\Sage\Sage Entreprise\BIJOU.MAE'
        ) then
    begin
      try
        ObjetClient := BaseCpta.FactoryClient.Create as IBOClient3;
        Writeln(StrToOem('Objet client créé !'));
      except
        on E:Exception do
          Writeln(
            StrToOem('Erreur en création d''un nouvel objet client : '),
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
