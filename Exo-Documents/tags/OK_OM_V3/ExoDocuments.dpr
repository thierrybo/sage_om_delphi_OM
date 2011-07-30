{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program ExoDocuments;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Commun in '..\Commun.pas',
  Objets100Lib_TLB,
  ActiveX;

var
  StreamCial    : TBSCIALApplication3;
  BaseCial      : IBSCIALApplication3;
  DocVente      : IBODocumentVente3;
  DocStock      : IBODocumentStock3;

function CreeEnteteStockME(
  var ABaseCial : IBSCIALApplication3;
  ADepot        : string;
  ADateDoc      : TDateTime): IBODocumentStock3;
var
  DocStock      : IBODocumentStock3;
begin

  try
    DocStock := ABaseCial.FactoryDocumentStock.CreateType(DocumentTypeStockMouvIn);
    with DocStock do
    begin
      DO_Date       := ADateDoc;
      DepotStockage := ABaseCial.FactoryDepot.ReadIntitule(ADepot);
      SetDefault;
      WriteDefault;
    end;
    Result := DocStock;
  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := nil;
    end;
  end;

end;

function CreeEnteteVenteBC(
  var ABaseCial : IBSCIALApplication3;
  AClient       : string;
  ADateDoc      : TDateTime): IBODocumentVente3;
var
  DocVente      : IBODocumentVente3;
begin

  try
    DocVente := ABaseCial.FactoryDocumentVente.CreateType(
                DocumentTypeVenteCommande);
    with DocVente do
    begin
      DO_Date := ADateDoc;
      SetDefaultClient(
        ABaseCial.CptaApplication.FactoryTiers.ReadNumero(AClient)
        as IBOClient3);
      Write;
    end;
    Result := DocVente;

  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := nil;
    end;
  end;

end;

function CreeLigneStock(
  var ADocStock       : IBODocumentStock3;
  ARefArticle         : string;
  AQte                : Double;
  ACodeEmplacement    : string = ''): IBODocumentStockLigne3;
var
  Depot               : IBODepot3;
  LigneDocStock       : IBODocumentStockLigne3;
  DocLigneEmplacement : IBODocumentLigneEmplacement;
begin

  try
    Depot             := ADocStock.DepotStockage;
    LigneDocStock     := ADocStock.FactoryDocumentLigne.Create
                         as IBODocumentStockLigne3;
    LigneDocStock.SetDefaultArticleReference(ARefArticle, AQte);

    if ACodeEmplacement = '' then
    begin

      { Mouvemente l'emplacement principal }
      LigneDocStock.WriteDefault;
    end
    else
    begin

      { Mouvement l'emplacement s�lectionn� }
      LigneDocStock.Write;
      DocLigneEmplacement := LigneDocStock.FactoryDocumentLigneEmplacement
                             .Create as IBODocumentLigneEmplacement;
      with DocLigneEmplacement do
      begin
        DL_Qte      := AQte;
        Emplacement := Depot.FactoryDepotEmplacement.ReadCode(ACodeEmplacement);
        WriteDefault;
      end;
    end;
    Result := LigneDocStock;

  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := nil;
    end;
  end;
end;

function CreeLot(
  var AArticle       : IBOArticle3;
  var ADepot         : IBODepot3;
  ANumLot            : string;
  ADatePeremption    : TDateTime;
  AComplementSerieLot: string): IBOArticleDepotLot;
var
  Lot                : IBOArticleDepotLot;
  I                  : Integer;
begin

  try
    { Parcours des d�p�ts de l'article : }
	{ TODO: ATTENTION d�placer l'appel jusqu'� la collection (.List) dans une 
		variable sinon chaque appel il doit recr�er la liste => peut etre long }
    for I := 1 to AArticle.FactoryArticleDepot.List.Count do
    begin

      { Identification du d�p�t de l'article correspondant � l'intitul� : }
      if (AArticle.FactoryArticleDepot.List.Item[I] as IBOArticleDepot3).Depot.
        DE_Intitule = ADepot.DE_Intitule then
      begin

        { Cr�ation d'un nouveau lot : }
        Lot := (AArticle.FactoryArticleDepot.List.Item[I] as IBOArticleDepot3).
               FactoryArticleDepotLot.Create as IBOArticleDepotLot;

        with Lot do
        begin
          NoSerie         := ANumLot;
          DatePeremption  := ADatePeremption;
          Complement      := AComplementSerieLot;
        end;

        Break;

      end;
    end;

    Result := Lot;

  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := nil;
    end;
  end;

end;

function CreeLigneStockLot(
  var ADocStock      : IBODocumentStock3;
  ARefArticle        : string;
  AQte               : Double;
  ANumLot            : string;
  ADatePeremption    : TDateTime;
  AComplementSerieLot: string;
  ACodeEmplacement   : string = ''): IBODocumentStockLigne3;
var
  BaseCial           : IBSCIALApplication3;
  Article            : IBOArticle3;
  Depot              : IBODepot3;
  Lot                : IBOArticleDepotLot;
  LigneDocStock      : IBODocumentStockLigne3;
begin

  try
    BaseCial  := ADocStock.Stream as IBSCIALApplication3;
    Article   := BaseCial.FactoryArticle.ReadReference(ARefArticle);
    Depot     := ADocStock.DepotStockage;

    { Cr�ation d'un lot en fonction de l'article et du d�p�t :}
    Lot := CreeLot(
              Article,
              Depot,
              ANumLot,
              ADatePeremption,
              AComplementSerieLot);

    LigneDocStock := ADocStock.FactoryDocumentLigne.Create
                     as IBODocumentStockLigne3;
    LigneDocStock.SetDefaultLot(Lot, AQte);
    LigneDocStock.WriteDefault;

    Result := LigneDocStock;

  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := nil;
    end;
  end;

end;

function CreeLigneVente(
  var ADocVente : IBODocumentVente3;
  ARefArticle   : string;
  AQte          : Double): IBODocumentVenteLigne3;
var
  LigneDocVente : IBODocumentVenteLigne3;
begin

  try
      LigneDocVente := ADocVente.FactoryDocumentLigne.Create as
                       IBODocumentVenteLigne3;
      with LigneDocVente do
      begin
        SetDefaultArticleReference(ARefArticle, AQte);
        SetDefaultRemise;
        WriteDefault;
      end;

      Result := LigneDocVente;

  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := nil;
    end;
  end;

end;

function CreeLigneVenteArtNomenclature(
  var ADocVente       : IBODocumentVente3;
  ARefArticle         : string;
  AQteCompose         : Double): IBODocumentVenteLigne3;
var
  LigneDocVente       : IBODocumentVenteLigne3;
  BaseCial            : IBSCIALApplication3;
  LArticleCompose     : IBOArticle3;
  QteComposant        : Double;
  I                   : Integer;
  ArticleNomenclature : IBOArticleNomenclature3;
begin

  try
    LigneDocVente     := ADocVente.FactoryDocumentLigne.Create as
                         IBODocumentVenteLigne3;
    BaseCial          := ADocVente.Stream as IBSCIALApplication3;
    LArticleCompose   := BaseCial.FactoryArticle.ReadReference(ARefArticle);

    { Insertion de la ligne du compos� : }
    with LigneDocVente do
    begin
      SetDefaultArticleReference(ARefArticle, AQteCompose);
      ArticleCompose := LArticleCompose;
      SetDefaultRemise;
      WriteDefault;
    end;

    { Parcours des composants de la nomenclature et insertion des lignes :  }
	{ TODO: ATTENTION d�placer l'appel jusqu'� la collection (.List) dans une 
		variable sinon chaque appel il doit recr�er la liste => peut etre long }
    for I := 1 to LArticleCompose.FactoryArticleNomenclature.List.Count do
    begin
      ArticleNomenclature := LArticleCompose.FactoryArticleNomenclature.List.
                             Item[I] as IBOArticleNomenclature3;
      LigneDocVente       := ADocVente.FactoryDocumentLigne.Create as
                             IBODocumentVenteLigne3;

      { Calcul de la qt� du composant en fonction du type (fixe ou variable) : }
      if ArticleNomenclature.NO_Type = ComposantTypeVariable then
      begin
          QteComposant := ArticleNomenclature.NO_Qte * AQteCompose
      end
      else
      begin
          QteComposant := ArticleNomenclature.NO_Qte
      end;
      with LigneDocVente do
      begin
        SetDefaultArticle(ArticleNomenclature.ArticleComposant, QteComposant);
        ArticleCompose := LArticleCompose;
        SetDefaultRemise;
        WriteDefault;
      end;
    end;

    Result := LigneDocVente;

  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := nil;
    end;
  end;

end;

function GetNumSerieDispo(
  var AArticle                 : IBOArticle3;
  ADepot                       : IBODepot3): IBOArticleDepotLot;
var
  ArticlesSerialisesNonEpuises : IBICollection;
  I                            : Integer;
  ArticleDepot                 : IBOArticleDepot3;
  I2                           : Integer;
begin

  try

    { Parcours des d�p�ts de l'article : }
	{ TODO: ATTENTION d�placer l'appel jusqu'� la collection (.List) dans une 
		variable sinon chaque appel il doit recr�er la liste => peut etre long }
    for I := 1 to AArticle.FactoryArticleDepot.List.Count do
    begin

      { Identification du d�p�t de l'article correspondant � l'intitul� : }
      ArticleDepot := AArticle.FactoryArticleDepot.List.Item[I] as
                      IBOArticleDepot3;
      if ArticleDepot.Depot.DE_Intitule = ADepot.DE_Intitule then
      begin

        { R�cup�ration d'une collection de N� s�rie non �puis�s : }
        ArticlesSerialisesNonEpuises :=
          ArticleDepot.FactoryArticleDepotLot.QueryNonEpuise;

        { Parcours de la collection et retour du 1er lot non r�serv� : }
        for I2 := 1 to ArticlesSerialisesNonEpuises.Count do
        begin
          if (ArticlesSerialisesNonEpuises.Item[I2] as IBOArticleDepotLot).
              StockATerme = 1 then
            Result := ArticlesSerialisesNonEpuises.Item[I2] as
                      IBOArticleDepotLot;
        end;
      end;
    end;

  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := nil;
    end;
  end;

end;

function CreeLigneVenteArtSerialise(
  ADocVente         : IBODocumentVente3;
  ARefArticle       : string): IBODocumentVenteLigne3;
var
  LigneDocVente     : IBODocumentVenteLigne3;
  BaseCial          : IBSCIALApplication3;
  LArticle          : IBOArticle3;
  LArticleSerialise : IBOArticleDepotLot;
begin

  try
    LigneDocVente   := ADocVente.FactoryDocumentLigne.Create as
                       IBODocumentVenteLigne3;
    BaseCial        := ADocVente.Stream as IBSCIALApplication3;
    LArticle        := BaseCial.FactoryArticle.ReadReference(ARefArticle);

    { Obtention d'un N� de s�rie non �puis� et non r�serv� : }
    LArticleSerialise := GetNumSerieDispo(LArticle, ADocVente.DepotStockage);

    if LArticleSerialise = nil then
    begin
      raise Exception.Create('Stock insuffisant pour l''article ' + ARefArticle
                             + ' !');
    end
    else
    begin
      with LigneDocVente do
      begin
        SetDefaultLot(LArticleSerialise, 1);
        SetDefaultRemise;
        WriteDefault;
      end;
    end;

    Result := LigneDocVente;

  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := nil;
    end;
  end;

end;

function ModifieInfoLibreLigne(
  ALigneDoc     : IBODocumentLigne3;
  ANomInfoLibre : string;
  AValInfoLibre : OleVariant): Boolean;
begin

  { Modifie une info libre d'une ligne existante : }
  try
    ALigneDoc.InfoLibre.Item[ANomInfoLibre] := AValInfoLibre;
    ALigneDoc.Write;
    Result := true;
  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := false;
    end;
  end;
end;

function CreeAcompte(
  var ADocVente   : IBODocumentVente3;
  AMontant        : Double;
  AModeRegl       : string;
  ADateRegl       : TDateTime): Boolean;
var
  Acompte         : IBODocumentAcompte3;
  BaseCpta        : IBSCPTAApplication3;
begin
  try
    Acompte       := ADocVente.FactoryDocumentAcompte.Create
                     as IBODocumentAcompte3;
    BaseCpta      := (ADocVente.Stream as BSCIALApplication3).CptaApplication;
    with Acompte do
    begin
      DR_Date     := ADateRegl;
      DR_Montant  := AMontant;
      Reglement   := BaseCpta.FactoryReglement.ReadIntitule(AModeRegl);
      WriteDefault;
    end;
    Result := true;
  except on E: Exception do
    begin
      Writeln(E.ClassName, ': ', StrToOem(E.Message));
      Result := false;
    end;
  end;
end;

procedure AfficheEcheances(var ADocVente: IBODocumentVente3);
var
  TotMontantTTC   : Double;
  MontantTTC      : Double;
  TotPourcentTTC  : Double;
  PourcentTTC     : Double;
  I               : Integer;
  Echeance        : IBODocumentEcheance3;
begin

  TotPourcentTTC  := 0;
  Writeln(sLineBreak);
  Writeln(StrToOem('Ech�ances :'));
  Writeln(StrToOem('Date         % TTC       Montant     Mode r�glement'));
  try

    { Calul du TTC du document, acomptes d�duits : }
    TotMontantTTC := ADocVente.Valorisation.TotalTTC
                   - ADocVente.Valorisation.TotalAcomptes;

    { Parcours des �ch�ances du document : }
	{ TODO: ATTENTION d�placer l'appel jusqu'� la collection (.List) dans une 
		variable sinon chaque appel il doit recr�er la liste => peut etre long }
    for I := 1 to ADocVente.FactoryDocumentEcheance.List.Count do
    begin

      { Calcul du montant TTC des �ch�ances et du % de la ligne d'�quilibre : }
      Echeance := ADocVente.FactoryDocumentEcheance.List.Item[I]
                  as IBODocumentEcheance3;
      with Echeance do
      begin

        { Si �ch�ance d'�quilibre, calcul du pourcentage : }
        if DR_Equil then
        begin
          PourcentTTC := 100 - TotPourcentTTC
        end

        { Sinon cumul du % (calcul ult�rieur % �quilibre) : }
        else
        begin
          PourcentTTC     := DR_Pourcent;
          TotPourcentTTC  := TotPourcentTTC + DR_Pourcent;
        end;

        { Calcul de TTC de l'�ch�ance }
        MontantTTC := TotMontantTTC / 100 * PourcentTTC;

        Writeln(
          DateToStr(DR_Date),
          '      ',
          FloatToStr(PourcentTTC),
          '%     ',
          FloatToStr(MontantTTC),
          '     ',
          StrToOem(Reglement.R_Intitule));
      end;
    end;

  except on E: Exception do
    Writeln(E.ClassName, ': ', StrToOem(E.Message));
  end;

end;

procedure AfficheValorisation(var ADocVente: IBODocumentVente3);
begin

  Writeln(sLineBreak);
  Writeln('Valorisation :');
  Writeln('Total HT         Total HT net       Total TTC');

  try
    with ADocVente.Valorisation do
    begin
      Writeln(
        FloatToStr(TotalHT),
        '      ',
        FloatToStr(TotalHTNet),
        '     ',
        FloatToStr(TotalTTC));
    end;
  except on E: Exception do
    Writeln(E.ClassName, ': ', StrToOem(E.Message));
  end;
end;

procedure AfficheTaxes(var ADocVente: IBODocumentVente3);
var
  I     : Integer;
  Taxe  : IDocValoTaxe;
begin

  Writeln(sLineBreak);
  Writeln('Taxes :');
  Writeln('Base         Taux       Montant');

  try

    { Affiche chacune des taxes de la ligne : }
    for I := 1 to ADocVente.Valorisation.Taxes.Count do
    begin
      Taxe := ADocVente.Valorisation.Taxes.Item[I];
      Writeln(
          FormatFloat('#0.##', Taxe.BaseCalcul),
          '      ',
          FormatFloat('#0.##', Taxe.Taux),
          '%     ',
          FormatFloat('#0.##', Taxe.Montant));
    end;
  except on E: Exception do
    Writeln(E.ClassName, ': ', StrToOem(E.Message));
  end;
end;

begin
  CoInitialize(nil);
  StreamCial  := TBSCIALApplication3.Create(nil);
  BaseCial    := StreamCial.DefaultInterface;
  try
    if OuvreBaseCial(BaseCial,
      'C:\Documents and Settings\All Users\Documents\Sage\Sage Entreprise\Bijou.gcm'
      , '<Administrateur>', 'sage') then
    begin

      { Cr�ation d'une Mouvement d'entr�e en stock : }
      DocStock := CreeEnteteStockME(BaseCial, 'Bijou SA', Now);
      if not (DocStock = nil) then
      begin

        { Entr�e en stock sur l'emplacement principal : }
        CreeLigneStock(DocStock, 'BRAAR10', 50);

        { Entr�e en stock sur l'emplacement indiqu� : }
        CreeLigneStock(DocStock, 'BAAR01', 100, 'A2T1N2P3');

        { Entr�e en stock d'un article g�r� par lot : }
        CreeLigneStockLot(
            DocStock,
            'LINGOR18',
            5,
            'LOT001',
            StrToDate('31/12/10'),
            '12345678',
            'A3T1N2P1');
      end;

      { Cr�ation d'un Bon de commande client : }
      DocVente := CreeEnteteVenteBC(BaseCial, 'CARAT', Now);
      if not (DocVente = nil) then
      begin

        { Article g�r� au CMUP : }
        CreeLigneVente(DocVente, 'BRAAR10', 5);

        { Article � conditionnement : }
        CreeLigneVente(DocVente, 'EM040/24', 2);

        { Article � double gamme : }
        CreeLigneVente(DocVente, 'CHAARVARC34', 2);

        { Affectation d'une valeur � une info libre ligne : }
        ModifieInfoLibreLigne(
            CreeLigneVente(DocVente, 'BRAAR10', 1) as IBODocumentLigne3,
            'Commentaires',
            'Extension de garantie : 3 ans');

        { Article � nomenclature commerciale : }
        CreeLigneVenteArtNomenclature(DocVente, 'ENSHF', 2);

        { Article g�r� par N� de s�rie : }
        CreeLigneVenteArtSerialise(DocVente, 'MOBWAC01');

        CreeAcompte(DocVente, 100, 'Ch�que', Now);
        AfficheValorisation(DocVente);
        AfficheTaxes(DocVente);
        AfficheEcheances(DocVente);
      end;
    end;

  finally
    FermeBaseCial(BaseCial);
    FreeAndNil(StreamCial);
    CoUnInitialize;
    Readln;
  end;

end.
