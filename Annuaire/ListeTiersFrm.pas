unit ListeTiersFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Objets100cLib_TLB, Menus, ComCtrls, Actions;

type
  TListeTiersForm = class(TForm)
    pmMenuContextuel: TPopupMenu;
    lvListeTiers: TListView;
    mmiEditionNouveau: TMenuItem;
    mmiEditionSupp: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure lvListeTiersDblClick(Sender: TObject);
    procedure lvListeTiersSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormDeactivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { D�clarations priv�es }
      FBaseCpta: IBSCPTAApplication3;
      FTiersCourant: IBOTiers3;
  public
    { D�clarations publiques }
    constructor Create(AOwner: TComponent; ABaseCpta: IBSCPTAApplication3);
    class var ListeTiersForm: TListeTiersForm;
    procedure CreeTiers(Sender: TObject); virtual;
    procedure InitListe; virtual;
    procedure SuppTiers(Sender: TObject); virtual;
  end;

implementation

uses NewTiersFrm, DetailFrm, Commun, MainFrm, ActnList;

{$R *.dfm}

{ TListeTiersForm }

{$region 'Events Frm'}

constructor TListeTiersForm.Create(AOwner: TComponent;
  ABaseCpta: IBSCPTAApplication3);
begin
  inherited Create(AOwner);
  FBaseCpta := ABaseCpta;
end;
procedure TListeTiersForm.FormShow(Sender: TObject);
begin
  InitListe();
end;
procedure TListeTiersForm.lvListeTiersDblClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    try
      if Assigned(TDetailForm.FDetailForm) then
        TDetailForm.FDetailForm.Close;
      TDetailForm.FDetailForm := TDetailForm.Create(Self, FTiersCourant);
      TDetailForm.FDetailForm.Show;
    except on E: Exception do
      MessageErreur(E.Message);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;
procedure TListeTiersForm.lvListeTiersSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  try
    if lvListeTiers.SelCount = 1 then
      FTiersCourant :=
          FBaseCpta.FactoryTiers.ReadNumero(lvListeTiers.Selected.Caption);
  except on E: Exception do
    MessageErreur(E.Message);
  end;
end;
procedure TListeTiersForm.FormActivate(Sender: TObject);
(*
var
  MenuItemEditionNouveau : TMenuItem;
  MenuItemEditionSupp    : TMenuItem;
*)
begin
  MainForm.aliEditionNouveau.OnExecute := CreeTiers;
  MainForm.aliEditionSupp.OnExecute    := SuppTiers;

  { Delphi/Lazarus. Le menu contextuel est d�j� cr�� en conception ainsi quel les deux item Nouveau et Supprimer,
  pas besoin comme en VB de cloner MainForm.mnuEditionNouveau et Supp et de les ajouter � pmMenuContextuel }

    { Activer le TActionList }
    MainForm.alEdition.State := asNormal;

(* Ancien code avant de passer par un TActionList pour le menu Edition
var
  MenuItemEditionNouveau : TMenuItem;
  MenuItemEditionSupp    : TMenuItem;
begin
  MainForm.mmiEditionNouveau.OnClick := CreeTiers;
  MainForm.mmiEditionSupp.OnClick    := SuppTiers;
  if pmMenuContextuel.Items.Count = 0 then
  begin
//    pmMenuContextuel.Items.add(MainForm.mmiEditionNouveau);
//    pmMenuContextuel.Items[0].Assign(MainForm.mmiEditionNouveau);
    MenuItemEditionNouveau :=
        TMenuItem
          (StringToComponentProc
            (ComponentToStringProc
              (MainForm.mmiEditionNouveau)
            )
          );

    { Cr�e bien le menu mais ne r�cup�re pas l'�v�nement }
    MenuItemEditionNouveau.OnClick := CreeTiers;
    pmMenuContextuel.Items.add(MenuItemEditionNouveau);

//    pmMenuContextuel.Items.add(MainForm.mmiEditionSupp);
//    pmMenuContextuel.Items[1].Assign(MainForm.mmiEditionSupp);
    MenuItemEditionSupp :=
        TMenuItem
          (StringToComponentProc
            (ComponentToStringProc
              (MainForm.mmiEditionSupp)
            )
          );
    { Cr�e bien le menu mais ne r�cup�re pas l'�v�nement }
    MenuItemEditionSupp.OnClick := SuppTiers;
    pmMenuContextuel.Items.add(MenuItemEditionSupp);

    { Parce qu'en VB n'ont pas cr�� le menu en conception }
//    lvListeTiers.PopupMenu := pmMenuContextuel;
  end;
*)
end;
procedure TListeTiersForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(TDetailForm.FDetailForm) then
  begin
    TDetailForm.FDetailForm.Close();
  end;
  // +++++++++++++++++++++++++++++++ TActionList
  MainForm.alEdition.State := asSuspended;
//  MainForm.mmiEditionNouveau.Enabled := false;
//  MainForm.mmiEditionSupp.Enabled    := false;

  Action := caFree;
  ListeTiersForm := nil;
end;
procedure TListeTiersForm.FormDeactivate(Sender: TObject);
begin

{ NON, il ne faut pas d�sactiver le menu ici car en Delphi cet �v�nement
  se d�clenche m�me si on clique sur le form principal, du coup on a plus
  le menu. En VB l'�v�nement ne se d�clenche pas si on passe sur le main form
}
  // ****** modif TActionList ******
//  MainForm.mmiEditionNouveau.OnClick := nil;
//  MainForm.mmiEditionSupp.OnClick    := nil;

//  MainForm.mmiEditionNouveau.Enabled := false;
//  MainForm.mmiEditionSupp.Enabled    := false;

//  MainForm.alEdition.State := asSuspended;
{ Besoin uniquement pour BDS2006 pour que la fen�tre ne passe pas derri�re la
  fiche principale quand on clique sur le menu. D2009 pas besoin !?
  201806 Delphi 10.2 Je commente sinon le form d�tail reste derri�re}
//  Self.FormStyle := fsStayOnTop;
end;
procedure TListeTiersForm.FormResize(Sender: TObject);
var Coef : Double;
begin
  try
    Coef := Width / (lvListeTiers.Column[0].Width + lvListeTiers.Column[1].Width);
    lvListeTiers.Column[0].Width := round(lvListeTiers.Column[0].Width * Coef);
    lvListeTiers.Column[1].Width := round(lvListeTiers.Column[1].Width * Coef);
  except on E: Exception do
    MessageErreur(E.Message);
  end;
end;
procedure TListeTiersForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;
end;

{$endregion}

{$region 'M�thodes Tiers'}

procedure TListeTiersForm.InitListe;
var
  i            : Integer;
  IndexCourant : Integer;
  TiersCol     : IBICollection;
begin
  try
    with lvListeTiers do
    begin
      Items.BeginUpdate();
      Items.Clear();
      TiersCol := FBaseCpta.FactoryTiers.List;
      if TiersCol.Count > 0 then
      begin
        { Evite de faire 2 boucles comme plus bas en clonant ex VB }
        IndexCourant := -1;
        for I := 1 to TiersCol.Count do
        begin
          with Items.Add() do
          begin
            Caption := (TiersCol.Item[I] as IBOTiers3).CT_Num;
            SubItems.Add((TiersCol.Item[I] as IBOTiers3).CT_Intitule);
            { Evite de faire 2 boucles comme plus bas en clonant ex VB }
            if FTiersCourant <> nil then
              if Caption = FTiersCourant.CT_Num then IndexCourant := I - 1;
          end;
        end;
      end;
      Items.EndUpdate();
      if IndexCourant <> -1 then
      begin
        Items.Item[IndexCourant].Selected := True;
        Items.Item[IndexCourant].MakeVisible(False);
      end;
    end;

    { Code comme exmple VB avec deux boucles }
//    with lvListeTiers do
//    begin
//      Items.BeginUpdate();
//      Items.Clear();
//      TiersCol := FBaseCpta.FactoryTiers.List;
//      if (*FBaseCpta.FactoryTiers.List*)TiersCol.Count > 0 then
//      begin
//        for I := 1 to (*FBaseCpta.FactoryTiers.List*)TiersCol.Count do
//        begin
//          ListItem := Items.Add();
//          ListItem.Caption := ((*FBaseCpta.FactoryTiers.List*)TiersCol.Item[I] as
//              IBOTiers3).CT_Num;
////          lvListeTiers.Items.Add.Caption := ((*FBaseCpta.FactoryTiers.List*)TiersCol.Item[I]
////              as IBOTiers3).CT_Num;
//          ListItem.SubItems.Add(((*FBaseCpta.FactoryTiers.List*)TiersCol.Item[I] as
//              IBOTiers3).CT_Intitule);
//        end;
//      end;
//      Items.EndUpdate();
//      if FTiersCourant <> nil then
//      begin
//        i := 0;
//        for I := 0 to Items.Count - 1 do
//        begin
//          if Items[i].Caption = FTiersCourant.CT_Num then
//          begin
//            Items.Item[i].Selected := True;
//            Items.Item[i].MakeVisible(False);
//          end;
//        end;
//      end;
//    end;
  except on E: Exception do
    MessageErreur(E.Message);
  end;
end;
procedure TListeTiersForm.CreeTiers(Sender: TObject);
var
  FormTiers    : TDetailForm;
  TypeDeTiers  : String;
  NumDuTiers   : String;
begin
  try
    if TNewTiersForm.GetNewTiers(TForm(Sender), TypeDeTiers, NumDuTiers) = mrOk
    then
    begin
      case TypeTiers(TypeDeTiers) of
        TiersTypeClient :
            FTiersCourant := (FBaseCpta.FactoryClient.Create) as IBOTiers3;
        TiersTypeFournisseur :
            FTiersCourant := (FBaseCpta.FactoryFournisseur.Create) as IBOTiers3;
        TiersTypeSalarie :
            FTiersCourant := (FBaseCpta.FactoryTiersSalarie.Create) as IBOTiers3;
        TiersTypeAutre :
            FTiersCourant := (FBaseCpta.FactoryTiersAutre.Create) as IBOTiers3;
      end;
      with FTiersCourant do
      begin
        CT_Num := NumDuTiers;
        SetDefault();
        WriteDefault();
      end;
      InitListe();
      if Assigned (TDetailForm.FDetailForm) then
        TDetailForm.FDetailForm.Close;
      TDetailForm.FDetailForm := TDetailForm.Create(Self, FTiersCourant);
      TDetailForm.FDetailForm.Show;
    end;
  except on E: Exception do
    MessageErreur(E.Message);
  end;
end;
procedure TListeTiersForm.SuppTiers(Sender: TObject);
begin
  try
    if Assigned(FTiersCourant) then
      if MessageDlg(
          'Voulez-vous vraiment supprimer le tiers ' +
              string(FTiersCourant.CT_Num) +
              ' ?',
          mtWarning,
          [mbYes, mbNo],
          0,
          mbNo) = mrYes
      then
      begin
        { ' Pour �viter message 'Impossible de trouver la proc�dure stock�e
          'CB_Prev' lors du Remove si Write pr�lable.  }
        FTiersCourant.Read();
        FTiersCourant.Remove();
        FTiersCourant := nil;
        InitListe();
    end;
  except on E: Exception do
    MessageErreur(E.Message);
  end;
end;

{$endregion}

end.
