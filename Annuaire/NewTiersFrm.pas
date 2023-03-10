unit NewTiersFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TNewTiersForm = class(TForm)
    ledtNumTiers: TLabeledEdit;
    cbPopType: TComboBox;
    lblType: TLabel;
    btnOK: TButton;
    btnAnnuler: TButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    class function GetNewTiers(var AProprio: TForm; var ATypeTiers: String;
      var ANumTiers: string): Word; virtual;
  end;

implementation

{$R *.dfm}

{ TNewTiersForm }

procedure TNewTiersForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then btnOK.Click;
end;

class function TNewTiersForm.GetNewTiers(
    var AProprio: TForm;
    var ATypeTiers: String;
    var ANumTiers: String): Word;
var
  NewTiersForm: TNewTiersForm;
begin
  NewTiersForm := TNewTiersForm.Create(AProprio);
  try
    Result := NewTiersForm.ShowModal;
    if Result = mrOK then
    begin
      ATypeTiers := NewTiersForm.cbPopType.Text;
      ANumTiers  := NewTiersForm.ledtNumTiers.Text;
    end;
  finally
    NewTiersForm.Free;
  end;
end;

end.
