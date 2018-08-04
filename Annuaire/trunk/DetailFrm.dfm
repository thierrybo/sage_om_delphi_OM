object DetailForm: TDetailForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tiers'
  ClientHeight = 360
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcTiers: TPageControl
    Left = 8
    Top = 8
    Width = 416
    Height = 352
    ActivePage = tshCoord
    TabOrder = 0
    OnChange = pgcTiersChange
    object tshCoord: TTabSheet
      Caption = 'Coordonn'#233'es'
      object lblNum: TLabel
        Left = 8
        Top = 12
        Width = 43
        Height = 13
        Caption = 'Num'#233'ro :'
        Layout = tlCenter
      end
      object lblTxtNum: TLabel
        Left = 64
        Top = 12
        Width = 3
        Height = 13
        Layout = tlCenter
      end
      object lblTypeTiers: TLabel
        Left = 248
        Top = 12
        Width = 3
        Height = 13
        Layout = tlCenter
      end
      object lblType: TLabel
        Left = 200
        Top = 12
        Width = 30
        Height = 13
        Caption = 'Type :'
        Transparent = True
        Layout = tlCenter
      end
      object ledtIntitule: TLabeledEdit
        Left = 64
        Top = 40
        Width = 128
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.BiDiMode = bdLeftToRight
        EditLabel.Caption = 'Intitul'#233'       '
        EditLabel.ParentBiDiMode = False
        EditLabel.Layout = tlCenter
        LabelPosition = lpLeft
        MaxLength = 35
        TabOrder = 0
      end
      object ledtContact: TLabeledEdit
        Left = 248
        Top = 40
        Width = 144
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Contact   '
        EditLabel.Layout = tlCenter
        LabelPosition = lpLeft
        MaxLength = 35
        TabOrder = 1
      end
      object gb1: TGroupBox
        Left = 8
        Top = 72
        Width = 392
        Height = 128
        Caption = 'Coordonn'#233'es postales'
        TabOrder = 2
        object ledtCP: TLabeledEdit
          Left = 80
          Top = 72
          Width = 96
          Height = 21
          EditLabel.Width = 71
          EditLabel.Height = 13
          EditLabel.Caption = 'Code postal     '
          EditLabel.Layout = tlCenter
          LabelPosition = lpLeft
          MaxLength = 9
          TabOrder = 2
        end
        object ledtVille: TLabeledEdit
          Left = 232
          Top = 72
          Width = 152
          Height = 21
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Ville         '
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'MS Sans Serif'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          LabelPosition = lpLeft
          MaxLength = 35
          TabOrder = 3
        end
        object ledtRegion: TLabeledEdit
          Left = 80
          Top = 96
          Width = 96
          Height = 21
          EditLabel.Width = 70
          EditLabel.Height = 13
          EditLabel.Caption = 'R'#233'gion            '
          EditLabel.Layout = tlCenter
          LabelPosition = lpLeft
          MaxLength = 25
          TabOrder = 4
        end
        object ledtPays: TLabeledEdit
          Left = 232
          Top = 96
          Width = 152
          Height = 21
          EditLabel.Width = 47
          EditLabel.Height = 13
          EditLabel.Caption = 'Pays        '
          EditLabel.Layout = tlCenter
          LabelPosition = lpLeft
          MaxLength = 35
          TabOrder = 5
        end
        object ledtAdresse: TLabeledEdit
          Left = 80
          Top = 24
          Width = 304
          Height = 21
          EditLabel.Width = 68
          EditLabel.Height = 13
          EditLabel.Caption = 'Adresse          '
          EditLabel.Layout = tlCenter
          LabelPosition = lpLeft
          MaxLength = 35
          TabOrder = 0
        end
        object ledtComplement: TLabeledEdit
          Left = 80
          Top = 48
          Width = 304
          Height = 21
          EditLabel.Width = 70
          EditLabel.Height = 13
          EditLabel.Caption = 'Compl'#233'ment    '
          LabelPosition = lpLeft
          MaxLength = 35
          TabOrder = 1
        end
      end
      object gb2: TGroupBox
        Left = 8
        Top = 208
        Width = 392
        Height = 104
        Caption = 'T'#233'l'#233'communication'
        TabOrder = 3
        object ledtTelephone: TLabeledEdit
          Left = 72
          Top = 25
          Width = 112
          Height = 21
          EditLabel.Width = 51
          EditLabel.Height = 13
          EditLabel.Caption = 'T'#233'l'#233'phone'
          EditLabel.Layout = tlCenter
          LabelPosition = lpLeft
          LabelSpacing = 13
          MaxLength = 21
          TabOrder = 0
        end
        object ledtTelecopie: TLabeledEdit
          Left = 264
          Top = 24
          Width = 120
          Height = 21
          EditLabel.Width = 47
          EditLabel.Height = 13
          EditLabel.Caption = 'T'#233'l'#233'copie'
          LabelPosition = lpLeft
          LabelSpacing = 16
          MaxLength = 21
          TabOrder = 1
        end
        object ledtEMail: TLabeledEdit
          Left = 72
          Top = 48
          Width = 312
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'E-mail'
          EditLabel.Layout = tlCenter
          LabelPosition = lpLeft
          LabelSpacing = 35
          MaxLength = 69
          TabOrder = 2
        end
        object ledtSite: TLabeledEdit
          Left = 72
          Top = 72
          Width = 312
          Height = 21
          EditLabel.Width = 44
          EditLabel.Height = 13
          EditLabel.Caption = 'Site Web'
          EditLabel.Layout = tlCenter
          LabelPosition = lpLeft
          LabelSpacing = 19
          MaxLength = 69
          TabOrder = 3
        end
      end
    end
    object tshBanque: TTabSheet
      Caption = 'Banques'
      ImageIndex = 1
      PopupMenu = pmMnuBqe
      object lbl33: TLabel
        Left = 120
        Top = 16
        Width = 27
        Height = 13
        Alignment = taCenter
        Caption = 'R.I.B.'
        Transparent = True
      end
      object lbl34: TLabel
        Left = 288
        Top = 16
        Width = 33
        Height = 13
        Alignment = taCenter
        Caption = 'Devise'
        Transparent = True
      end
      object lbl13: TLabel
        Left = 8
        Top = 228
        Width = 33
        Height = 13
        Caption = 'Devise'
        Layout = tlCenter
      end
      object ledtBqIntitule: TLabeledEdit
        Left = 80
        Top = 200
        Width = 320
        Height = 21
        EditLabel.Width = 31
        EditLabel.Height = 13
        EditLabel.Caption = 'Intitul'#233
        EditLabel.Layout = tlCenter
        LabelPosition = lpLeft
        LabelSpacing = 41
        MaxLength = 35
        TabOrder = 0
      end
      object ledtBqCode: TLabeledEdit
        Left = 8
        Top = 272
        Width = 120
        Height = 21
        EditLabel.Width = 88
        EditLabel.Height = 13
        EditLabel.Caption = '        Code banque'
        EditLabel.Layout = tlCenter
        MaxLength = 5
        TabOrder = 3
      end
      object ledtBqGuichet: TLabeledEdit
        Left = 128
        Top = 272
        Width = 120
        Height = 21
        EditLabel.Width = 87
        EditLabel.Height = 13
        EditLabel.Caption = '        Code guichet'
        MaxLength = 5
        TabOrder = 4
      end
      object ledtBqNumCpte: TLabeledEdit
        Left = 248
        Top = 272
        Width = 120
        Height = 21
        EditLabel.Width = 89
        EditLabel.Height = 13
        EditLabel.Caption = '        N'#176' de compte'
        MaxLength = 11
        TabOrder = 5
      end
      object ledtBqCle: TLabeledEdit
        Left = 368
        Top = 272
        Width = 32
        Height = 21
        EditLabel.Width = 21
        EditLabel.Height = 13
        EditLabel.Caption = '  Cl'#233
        MaxLength = 2
        TabOrder = 6
      end
      object ledtBqCommentaire: TLabeledEdit
        Left = 80
        Top = 296
        Width = 240
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'Commentaire'
        LabelPosition = lpLeft
        LabelSpacing = 11
        MaxLength = 69
        TabOrder = 7
      end
      object chkBqPrincipale: TCheckBox
        Left = 256
        Top = 224
        Width = 106
        Height = 17
        Caption = 'Banque principale'
        TabOrder = 2
      end
      object cbBqDevise: TComboBox
        Left = 80
        Top = 224
        Width = 168
        Height = 21
        Style = csDropDownList
        TabOrder = 1
      end
      object btnBqValider: TButton
        Left = 328
        Top = 296
        Width = 75
        Height = 23
        Caption = 'Valider'
        Default = True
        TabOrder = 8
        OnClick = btnBqValiderClick
      end
      object lvBanque: TListView
        Left = 8
        Top = 32
        Width = 392
        Height = 160
        Columns = <
          item
            Caption = 'Banque'
            Width = 106
          end
          item
            Caption = 'R.I.B.'
            Width = 172
          end
          item
            Caption = 'Devise'
            Width = 105
          end>
        RowSelect = True
        ShowColumnHeaders = False
        TabOrder = 9
        ViewStyle = vsReport
        OnSelectItem = lvBanqueSelectItem
      end
    end
    object tshContact: TTabSheet
      Caption = 'Contacts'
      ImageIndex = 2
      PopupMenu = pmMnuCtc
      object lbl19: TLabel
        Left = 16
        Top = 16
        Width = 37
        Height = 13
        Caption = 'Contact'
      end
      object lbl20: TLabel
        Left = 104
        Top = 16
        Width = 41
        Height = 13
        Caption = 'Fonction'
        Layout = tlCenter
      end
      object lbl21: TLabel
        Left = 200
        Top = 16
        Width = 51
        Height = 13
        Caption = 'T'#233'l'#233'phone'
        Layout = tlCenter
      end
      object lbl22: TLabel
        Left = 296
        Top = 16
        Width = 39
        Height = 13
        Caption = 'Portable'
        Layout = tlCenter
      end
      object lbl23: TLabel
        Left = 8
        Top = 164
        Width = 22
        Height = 13
        Caption = 'Nom'
      end
      object lbl26: TLabel
        Left = 8
        Top = 188
        Width = 36
        Height = 13
        Caption = 'Service'
      end
      object cbCivilite: TComboBox
        Left = 72
        Top = 160
        Width = 48
        Height = 21
        Style = csDropDownList
        TabOrder = 1
      end
      object cbCtcService: TComboBox
        Left = 72
        Top = 184
        Width = 136
        Height = 21
        Style = csDropDownList
        TabOrder = 4
      end
      object edtCtcNom: TEdit
        Left = 120
        Top = 160
        Width = 88
        Height = 21
        MaxLength = 35
        TabOrder = 2
        Text = 'edtCtcNom'
      end
      object ledtCtcPrenom: TLabeledEdit
        Left = 272
        Top = 160
        Width = 128
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Pr'#233'nom'
        LabelPosition = lpLeft
        LabelSpacing = 19
        MaxLength = 35
        TabOrder = 3
      end
      object ledtCtcFonction: TLabeledEdit
        Left = 272
        Top = 184
        Width = 128
        Height = 21
        EditLabel.Width = 41
        EditLabel.Height = 13
        EditLabel.Caption = 'Fonction'
        LabelPosition = lpLeft
        LabelSpacing = 14
        MaxLength = 35
        TabOrder = 5
      end
      object gbCtc: TGroupBox
        Left = 8
        Top = 216
        Width = 392
        Height = 96
        Caption = 'T'#233'l'#233'communication'
        TabOrder = 6
        object Label4: TLabel
          Left = 8
          Top = 44
          Width = 42
          Height = 13
          Caption = 'Num'#233'ros'
        end
        object ledtCtcTel: TLabeledEdit
          Left = 72
          Top = 40
          Width = 104
          Height = 21
          EditLabel.Width = 75
          EditLabel.Height = 13
          EditLabel.Caption = '        T'#233'l'#233'phone'
          MaxLength = 35
          TabOrder = 0
        end
        object ledtCtcPortable: TLabeledEdit
          Left = 176
          Top = 40
          Width = 104
          Height = 21
          EditLabel.Width = 72
          EditLabel.Height = 13
          EditLabel.Caption = '           Portable'
          MaxLength = 35
          TabOrder = 1
        end
        object ledtCtcCopie: TLabeledEdit
          Left = 280
          Top = 40
          Width = 104
          Height = 21
          EditLabel.Width = 74
          EditLabel.Height = 13
          EditLabel.Caption = '         T'#233'l'#233'copie'
          MaxLength = 35
          TabOrder = 2
        end
        object ledtCtcMail: TLabeledEdit
          Left = 72
          Top = 64
          Width = 208
          Height = 21
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'E-Mail'
          LabelPosition = lpLeft
          LabelSpacing = 35
          MaxLength = 35
          TabOrder = 3
        end
        object btnCtcVald: TButton
          Left = 288
          Top = 64
          Width = 88
          Height = 22
          Caption = 'Valider'
          TabOrder = 4
          OnClick = btnCtcValdClick
        end
      end
      object lvContact: TListView
        Left = 8
        Top = 32
        Width = 392
        Height = 112
        Columns = <>
        RowSelect = True
        ShowColumnHeaders = False
        TabOrder = 0
        ViewStyle = vsReport
        OnSelectItem = lvContactSelectItem
      end
    end
  end
  object pmMnuBqe: TPopupMenu
    Left = 336
  end
  object pmMnuCtc: TPopupMenu
    Left = 272
  end
end
