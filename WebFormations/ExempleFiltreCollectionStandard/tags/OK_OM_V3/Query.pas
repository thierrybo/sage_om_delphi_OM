unit Query;

interface

uses
  Sysutils, Objets100Lib_TLB, Classes, Generics.Collections;

function ArticlesStockInsuffisantDepotPrincipal(var
  BaseCommerciale: BSCIALApplication3): TList<IBOArticle3>;
function DocumentsVenteContenantArticle(var BaseCommerciale: BSCIALApplication3;
  ReferenceArticle: string): TList<IBODocument3>;


implementation

{ Liste des articles dont le stock réel du stock principal est inférieur au
  stock minimal paramétré pour le dépôt principal :
}
function ArticlesStockInsuffisantDepotPrincipal(
  var BaseCommerciale: BSCIALApplication3)
  : TList<IBOArticle3>;
var
  Articles : IBICollection;
  I        : Integer;
begin
  Articles := BaseCommerciale.FactoryArticle.List;
  Result   := TList<IBOArticle3>.Create;

  for I := 1 to Articles.Count do
  begin
    if
      ( (Articles.Item[I] as IBOArticle3).ArticleDepotPrincipal <> nil )
      and
      (
        Double((Articles.Item[I] as IBOArticle3).ArticleDepotPrincipal.StockReel)
        < Double((Articles.Item[I] as IBOArticle3).ArticleDepotPrincipal.AS_QteMini)
      )
    then
    begin
      Result.Add(Articles.Item[I] as IBOArticle3);
    end;
  end;
end;

{ Liste des entêtes des documents de vente comportant au moins une ligne
  d'article CERTIFE :
}
function DocumentsVenteContenantArticle(
  var BaseCommerciale : BSCIALApplication3;
  ReferenceArticle    : string)
  : TList<IBODocument3>;
var
  Documents, DocumentLignes : IBICollection;
  I, J      : Integer;
begin
  Documents := BaseCommerciale.FactoryDocumentVente.List;
  Result    := TList<IBODocument3>.Create;

  for I := 1 to Documents.Count do
  begin
    DocumentLignes := (Documents.Item[I] as IBODocument3).FactoryDocumentLigne.
      List;
    for J := 1 to DocumentLignes.Count do
    begin
      if
        ( (DocumentLignes.Item[J] as IBODocumentLigne3).Article <> nil )
        and
        (
          (DocumentLignes.Item[J] as IBODocumentLigne3).Article.AR_Ref
          = ReferenceArticle
        )
      then
      begin
        Result.Add(Documents.Item[I] as IBODocument3);
      end;
    end;
  end;
end;

end.
