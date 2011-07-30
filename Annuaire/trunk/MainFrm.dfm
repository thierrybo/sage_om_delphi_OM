object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderWidth = 1
  Caption = 'Annuaire'
  ClientHeight = 264
  ClientWidth = 260
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  Menu = mmMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 260
    Height = 264
    Align = alClient
    BevelEdges = [beLeft, beRight, beBottom]
    Color = clAppWorkSpace
    ParentBackground = False
    TabOrder = 0
  end
  object mmMenu1: TMainMenu
    object mmiFichier: TMenuItem
      Caption = 'Fichier'
      object mmiFichierOuvrir: TMenuItem
        Caption = 'Ouvrir...'
        ShortCut = 16463
        OnClick = mmiFichierOuvrirClick
      end
      object mmiFichierFermer: TMenuItem
        Caption = 'Fermer'
        ShortCut = 16471
        OnClick = mmiFichierFermerClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mmiFichierQuitter: TMenuItem
        Caption = 'Quitter'
        ShortCut = 16465
        OnClick = mmiFichierQuitterClick
      end
    end
    object mmiEdition: TMenuItem
      Caption = 'Edition'
      object mmiEditionNouveau: TMenuItem
        Action = aliEditionNouveau
      end
      object mmiEditionSupp: TMenuItem
        Action = aliEditionSupp
        ShortCut = 16469
      end
    end
    object mmiStruct: TMenuItem
      Caption = 'Structure'
      object mmiStructTiers: TMenuItem
        Caption = 'Tiers'
        OnClick = mmiStructTiersClick
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 96
    Top = 208
  end
  object OpenDialoglSelFic: TOpenDialog
    Filter = 'Fichier comptable (*.mae)|*.mae'
    Left = 168
    Top = 160
  end
  object alEdition: TActionList
    State = asSuspended
    Left = 80
    Top = 104
    object aliEditionNouveau: TAction
      Caption = 'Ajouter'
    end
    object aliEditionSupp: TAction
      Caption = 'Supprimer'
    end
  end
end
