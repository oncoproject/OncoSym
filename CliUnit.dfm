object CliForm: TCliForm
  Left = 641
  Top = 224
  Width = 529
  Height = 345
  Caption = 'CliForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 153
    Top = 0
    Width = 368
    Height = 318
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 153
    Height = 318
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object SaveBtn: TSpeedButton
      Left = 8
      Top = 176
      Width = 73
      Height = 22
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Save to file'
      OnClick = SaveBtnClick
    end
    object CloseSocketBtn: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Close socket'
      TabOrder = 0
      OnClick = CloseSocketBtnClick
    end
    object SendText: TEdit
      Left = 8
      Top = 40
      Width = 129
      Height = 21
      TabOrder = 1
      Text = 'to jest napis testowy.'
    end
    object WrSocket: TButton
      Left = 8
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Write'
      TabOrder = 2
      OnClick = WrSocketClick
    end
    object Write2xBtn: TButton
      Left = 8
      Top = 104
      Width = 75
      Height = 25
      Caption = 'Write x 2'
      TabOrder = 3
      OnClick = Write2xBtnClick
    end
    object Write8kbBtn: TButton
      Left = 8
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Write 8kB'
      TabOrder = 4
      OnClick = Write8kbBtnClick
    end
  end
end
