object NewTiersForm: TNewTiersForm
  Left = 0
  Top = 0
  Caption = 'Nouveau tiers'
  ClientHeight = 109
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblType: TLabel
    Left = 8
    Top = 43
    Width = 24
    Height = 13
    Caption = 'Type'
  end
  object ledtNumTiers: TLabeledEdit
    Left = 80
    Top = 16
    Width = 184
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 70
    EditLabel.Height = 13
    EditLabel.Caption = 'Num'#233'ro tiers   '
    LabelPosition = lpLeft
    TabOrder = 0
  end
  object cbPopType: TComboBox
    Left = 80
    Top = 40
    Width = 184
    Height = 21
    CharCase = ecUpperCase
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'CLIENT'
    Items.Strings = (
      'CLIENT'
      'FOURNISSEUR'
      'SALARI'#201)
  end
  object btnOK: TButton
    Left = 80
    Top = 80
    Width = 88
    Height = 23
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnAnnuler: TButton
    Left = 176
    Top = 80
    Width = 88
    Height = 23
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 3
  end
end
