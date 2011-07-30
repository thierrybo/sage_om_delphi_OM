object frmFraisTransport: TfrmFraisTransport
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Frais de transport'
  ClientHeight = 150
  ClientWidth = 454
  Color = clBtnFace
  Constraints.MaxHeight = 184
  Constraints.MaxWidth = 462
  Constraints.MinHeight = 177
  Constraints.MinWidth = 462
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblNumFacture: TLabel
    Left = 8
    Top = 16
    Width = 50
    Height = 13
    Caption = 'N'#176' facture'
  end
  object lblTransporteur: TLabel
    Left = 8
    Top = 48
    Width = 63
    Height = 13
    Caption = 'Transporteur'
  end
  object lblRefPiece: TLabel
    Left = 8
    Top = 80
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object lblMontant: TLabel
    Left = 8
    Top = 112
    Width = 62
    Height = 13
    Caption = 'Montant TTC'
  end
  object lblDate: TLabel
    Left = 232
    Top = 16
    Width = 23
    Height = 13
    Caption = 'Date'
  end
  object lblNomTransporteur: TLabel
    Left = 232
    Top = 48
    Width = 3
    Height = 13
  end
  object edtNumFacture: TEdit
    Left = 96
    Top = 16
    Width = 120
    Height = 21
    TabOrder = 0
  end
  object cbTransporteur: TComboBox
    Left = 96
    Top = 48
    Width = 120
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 2
    OnChange = cbTransporteurChange
  end
  object edtRefPiece: TEdit
    Left = 96
    Top = 80
    Width = 344
    Height = 21
    MaxLength = 35
    TabOrder = 3
  end
  object edtMontantTTC: TEdit
    Left = 96
    Top = 112
    Width = 120
    Height = 21
    TabOrder = 4
    OnKeyPress = edtMontantTTCKeyPress
  end
  object dtpDatePick: TDateTimePicker
    Left = 320
    Top = 16
    Width = 120
    Height = 20
    Date = 0.507488599527278000
    Format = 'dd/MM/yy'
    Time = 0.507488599527278000
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 360
    Top = 120
    Width = 75
    Height = 24
    Caption = 'Valider'
    TabOrder = 5
    OnClick = btnOKClick
  end
  object StreamCpta: TBSCPTAApplication3
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 264
    Top = 104
  end
end
