{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program ExempleFiltreCollectionStandard;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Objets100Lib_TLB,
  ActiveX,
  Query in 'Query.pas',
  Classes,
  Commun in '..\..\Commun.pas',
  Generics.Collections;

var
  StreamCial      : TBSCIALApplication3;
  BaseCommerciale : IBSCIALApplication3;
  Compteur        : TDateTime;
  ListeArticlesStockInsuffisantDepotPrincipal : TList<IBOArticle3>;
  DocumentsVenteContenantCERTIFE : TList<IBODocument3>;
  I : Integer;

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  CoInitialize(nil);
  StreamCial      := TBSCIALApplication3.Create(nil);
  BaseCommerciale := StreamCial.DefaultInterface;

  if (OuvreBaseCial(BaseCommerciale, 'C:\Documents and Settings\All Users\Documents\Sage\Sage Entreprise\Bijou.gcm', '<Administrateur>')) then
  begin

    { Sélection des articles dont le stock du dépôt principal est inférieur
      au stock minimal : }
    Writeln(
      sLineBreak,
      StrToOem('Sélection des articles dont le stock du dépôt principal est inférieur au stock minimal :')
    );

    for I := 1 to 3 do
    begin
      If ListeArticlesStockInsuffisantDepotPrincipal <> nil then
      begin
        ListeArticlesStockInsuffisantDepotPrincipal.Clear
      end;
      Compteur := Now;
      ListeArticlesStockInsuffisantDepotPrincipal :=
        ArticlesStockInsuffisantDepotPrincipal(BaseCommerciale);
      Writeln(FormatDateTime('hh:mm:ss.z', Now - Compteur));
    end;

    If ListeArticlesStockInsuffisantDepotPrincipal <> nil then
    begin
      Writeln(
        sLineBreak,
        inttostr(ListeArticlesStockInsuffisantDepotPrincipal.Count),
        ' enregistrements'
      );
    end;

    { Sélection des documents de vente comportant une ligne d'article CERTIFE :
    }
    Writeln(
      sLineBreak,
      StrToOem('Sélection des documents de vente comportant une ligne d''article CERTIFE :')
    );

    for I := 1 to 3 do
    begin
      If DocumentsVenteContenantCERTIFE <> nil then
      begin
        DocumentsVenteContenantCERTIFE.Clear
      end;
      Compteur := Now;
      DocumentsVenteContenantCERTIFE :=
        DocumentsVenteContenantArticle(BaseCommerciale, 'CERTIFE');
      Writeln(FormatDateTime('hh:mm:ss.z', Now - Compteur));
    end;

    If DocumentsVenteContenantCERTIFE <> nil then
    begin
      Writeln(
        sLineBreak,
        inttostr(DocumentsVenteContenantCERTIFE.Count),
        ' enregistrements'
      );
    end;

    FreeAndNil(ListeArticlesStockInsuffisantDepotPrincipal);
    FreeAndNil(DocumentsVenteContenantCERTIFE);
  end;

  FermeBaseCial(BaseCommerciale);
  FreeAndNil(StreamCial);
  CoUnInitialize;
  Readln;

end.
