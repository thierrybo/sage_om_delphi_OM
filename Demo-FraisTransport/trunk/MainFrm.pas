{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleServer, Objets100Lib_TLB, StdCtrls, ComCtrls,
  StrUtils,
  Math,
  Character;

type
  TfrmFraisTransport = class(TForm)
    StreamCpta: TBSCPTAApplication3;
    lblNumFacture: TLabel;
    lblTransporteur: TLabel;
    lblRefPiece: TLabel;
    lblMontant: TLabel;
    lblDate: TLabel;
    edtNumFacture: TEdit;
    cbTransporteur: TComboBox;
    edtRefPiece: TEdit;
    edtMontantTTC: TEdit;
    dtpDatePick: TDateTimePicker;
    btnOK: TButton;
    lblNomTransporteur: TLabel;
    procedure cbTransporteurChange(Sender: TObject);
    procedure edtMontantTTCKeyPress(Sender: TObject; var Key: Char);
    procedure btnOKClick(Sender: TObject);
    procedure InitForm(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
    FBaseCpta : IBSCPTAApplication3;
  public
    { Déclarations publiques }
  end;

var
  frmFraisTransport: TfrmFraisTransport;

implementation

{$R *.dfm}

procedure TfrmFraisTransport.btnOKClick(Sender: TObject);
var
  PieceComptable  : IPMEncoder;
  Transporteur    : IBOTiers3;
  CompteColl      : IBOCompteG3;
  CompteGene      : IBOCompteG3;
  CompteTaxe      : IBOCompteG3;
  MontantTTC      : Double;
  I               : Integer;
begin
  PieceComptable  := FBaseCpta.CreateProcess_Encoder;
  with PieceComptable do
  try
    { Initialisation des valeurs du process : }
    Date        := dtpDatePick.DateTime;
    Journal     := FBaseCpta.FactoryJournal.ReadNumero('ACH');
    EC_RefPiece := edtNumFacture.Text;
    EC_Intitule := edtRefPiece.Text;

    try
      Transporteur := FBaseCpta.FactoryTiers.ReadNumero(cbTransporteur.Text);
    except on E: Exception do
      begin
        cbTransporteur.SetFocus;
        raise Exception.Create('Transporteur invalide !');
      end;
    end;

    CompteColl := FBaseCpta.FactoryCompteG.ReadNumero(
      Transporteur.CompteGPrinc.CG_Num);
    CompteGene := FBaseCpta.FactoryCompteG.ReadNumero('708500');
    CompteTaxe := FBaseCpta.FactoryCompteG.ReadNumero('4457119');

    try
      MontantTTC := StrtoFloat(ReplaceStr(edtMontantTTC.Text, '.', ','));
      if IsNaN(MontantTTC) then
        raise Exception.Create('Montant TTC invalide !');
    except on E: Exception do
      begin
        edtMontantTTC.SetFocus;
        raise Exception.Create('Montant TTC invalide !');
      end;
    end;

    bAnalytiqueAuto     := true;
    bMultiEcheanceAuto  := true;
    AddTiersPart(
      Transporteur as IBOTiersPart3,
      MontantTTC,
      CompteGene,
      CompteTaxe,
      CompteColl);

    { Validation du process et récupération des erreurs : }
    if CanProcess then
    begin
      Process;
      InitForm(Self);
    end
    else
    begin
      raise Exception.Create('La pièce comptable ne peut pas être validée !');
    end;
  except on E: Exception do
    begin
      Application.MessageBox(
        PWideChar(E.Message),
        'Validation de la pièce',
        MB_OK + MB_ICONWARNING);
      for I := 1 to PieceComptable.Errors.Count do
        Application.MessageBox(
          PWideChar(PieceComptable.Errors.Item[I].Text),
          'Validation de la pièce',
          MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TfrmFraisTransport.cbTransporteurChange(Sender: TObject);
begin
  if FBaseCpta.FactoryTiers.ExistNumero(cbTransporteur.Text) then
    lblNomTransporteur.Caption :=
      FBaseCpta.FactoryTiers.ReadNumero(cbTransporteur.Text).CT_Intitule;
end;

procedure TfrmFraisTransport.edtMontantTTCKeyPress(Sender: TObject;
  var Key: Char);
begin
(*
    { Delphi < 2009 }
    if not (Key in [#8, '0'..'9', '.']) then
      Key := #0;
*)
  if not (IsDigit(Key) or (Key = '.') or Character.IsControl(Key) ) then
    Key := #0;
end;

procedure TfrmFraisTransport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ((FBaseCpta <> nil) and FBaseCpta.IsOpen) then
    FBaseCpta.Close;
    FreeAndNil(StreamCpta);
end;

procedure TfrmFraisTransport.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(VK_RETURN) then btnOKClick(Sender);
end;

procedure TfrmFraisTransport.FormShow(Sender: TObject);
var
  I : Integer;
  CollectionTiers : IBICollection;
begin
  if ParamCount <> 6 then
  begin
    Application.MessageBox(
        PWideChar('Nombre d''arguments invalide !'),
        'Erreur',
        MB_OK + MB_ICONERROR);
  end
  else
  begin
    try
      { Ouverture de la base comptable : }
      StreamCpta                  := TBSCPTAApplication3.Create(Self);
      FBaseCpta                   := StreamCpta.DefaultInterface;
      FBaseCpta.Name              := ParamStr(1);
      FBaseCpta.Loggable.UserName := ParamStr(2);
      FBaseCpta.Loggable.UserPwd  := ParamStr(3);
      FBaseCpta.Open;

      { Initialisation combo Compte tiers : }
	  { TODO: ATTENTION déplacer l'appel jusqu'à la collection (.List) dans une 
		variable sinon chaque appel il doit recréer la liste => peut etre long }
      CollectionTiers := FBaseCpta.FactoryTiers.List;
      for I := 1 to CollectionTiers.Count do
      begin
        if (CollectionTiers.Item[I] as IBOTiers3).CT_Type =
            TiersTypeFournisseur then
          cbTransporteur.AddItem(
            (CollectionTiers.Item[I] as IBOTiers3).CT_Num,
            nil);
      end;
      InitForm(Self);
    except on E: Exception do
      Application.MessageBox(
        PWideChar(E.Message),
        'Initialisation',
        MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TfrmFraisTransport.InitForm(Sender: TObject);
begin
  edtNumFacture.Text          := '';
  dtpDatePick.DateTime        := Date;
  cbTransporteur.ItemIndex    := -1;
  lblNomTransporteur.Caption  := '';
  edtRefPiece.Text            := '';
  edtMontantTTC.Text          := '';
  edtNumFacture.SetFocus;
end;

end.
