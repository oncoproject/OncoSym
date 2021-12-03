object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 421
  ClientWidth = 806
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SymKPPanel: TPanel
    Left = 0
    Top = 0
    Width = 153
    Height = 421
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    Visible = False
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 51
      Height = 13
      Caption = 'Listen port'
    end
    object ListenPortEdit: TSpinEdit
      Left = 16
      Top = 24
      Width = 81
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 8400
    end
    object ListenBtn: TButton
      Left = 16
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Listen'
      TabOrder = 1
      OnClick = ListenBtnClick
    end
    object StopBtn: TButton
      Left = 16
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 2
    end
    object Memo1: TMemo
      Left = 0
      Top = 156
      Width = 153
      Height = 265
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      Lines.Strings = (
        'Memo1')
      TabOrder = 3
    end
  end
  object MainMenu1: TMainMenu
    Left = 456
    Top = 216
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
      end
    end
    object SymulatorAndroida1: TMenuItem
      Caption = 'Symulator_Androida'
      OnClick = SymulatorAndroida1Click
    end
    object SymulatorKP1: TMenuItem
      Caption = 'Symulator_KP'
      OnClick = SymulatorKP1Click
    end
  end
end
