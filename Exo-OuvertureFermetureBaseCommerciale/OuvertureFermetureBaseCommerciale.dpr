{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program OuvertureFermetureBaseCommerciale;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Objets100Lib_TLB,
  ActiveX,
  Commun in '..\Commun.pas';

var
  StreamCial  : TBSCIALApplication3;
  BaseCial    : IBSCIALApplication3;

begin
  CoInitialize(nil);
  StreamCial := TBSCIALApplication3.Create(nil);
  try
    { Au préalable, sur les 2 bases comptable et commerciale,
      créer un utilisateur DURANT ayant pour mot de passe 1234 : }
    begin
      BaseCial := StreamCial.DefaultInterface;
      if (OuvreBaseCial(BaseCial, 'C:\Temp\test2.gcm', 'DURANT', '1234')) then
      begin
        writeln('Base commerciale ', BaseCial.Name, ' ouverte !');
        if FermeBaseCial(BaseCial) then
        begin
          Writeln('Base commerciale ', BaseCial.Name, ' fermée !');
        end;
      end;
    end;
  finally
    FreeAndNil(StreamCial);
    CoUnInitialize;
    Readln;
  end;
end.

