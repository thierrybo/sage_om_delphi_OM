object ListeTiersForm: TListeTiersForm
  Left = 0
  Top = 0
  Caption = 'Tiers'
  ClientHeight = 517
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = pmMenuContextuel
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnDeactivate = FormDeactivate
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lvListeTiers: TListView
    Left = 0
    Top = 0
    Width = 408
    Height = 517
    Align = alClient
    Columns = <
      item
        Caption = 'Num'#233'ro'
        Width = 160
      end
      item
        Caption = 'Intitul'#233
        Width = 218
      end>
    RowSelect = True
    PopupMenu = pmMenuContextuel
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = lvListeTiersDblClick
    OnSelectItem = lvListeTiersSelectItem
  end
  object pmMenuContextuel: TPopupMenu
    Left = 248
    Top = 32
    object mmiEditionNouveau: TMenuItem
      Action = MainForm.aliEditionNouveau
    end
    object mmiEditionSupp: TMenuItem
      Action = MainForm.aliEditionSupp
    end
  end
end
