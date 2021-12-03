object SvrForm: TSvrForm
  Left = 641
  Top = 224
  Caption = 'Server'
  ClientHeight = 601
  ClientWidth = 1055
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 445
    Width = 1055
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 0
    ExplicitWidth = 535
  end
  object Memo1: TMemo
    Left = 0
    Top = 448
    Width = 1055
    Height = 153
    Align = alBottom
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    ExplicitWidth = 610
  end
  object CloseOnCloseBox: TCheckBox
    Left = 8
    Top = 8
    Width = 137
    Height = 17
    Caption = 'Close on socket close'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object CloseSocketBtn: TButton
    Left = 8
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Close socket'
    TabOrder = 2
    OnClick = CloseSocketBtnClick
  end
  object GroupBox1: TGroupBox
    Left = 239
    Top = 8
    Width = 57
    Height = 218
    Caption = 'LEDS'
    TabOrder = 3
    object Led0Shape: TShape
      Left = 14
      Top = 185
      Width = 17
      Height = 17
      OnMouseDown = Led0ShapeMouseDown
    end
    object Led1Shape: TShape
      Left = 14
      Top = 162
      Width = 17
      Height = 17
      OnMouseDown = Led0ShapeMouseDown
    end
    object Led2Shape: TShape
      Left = 14
      Top = 139
      Width = 17
      Height = 17
      OnMouseDown = Led0ShapeMouseDown
    end
    object Led3Shape: TShape
      Left = 14
      Top = 116
      Width = 17
      Height = 17
      OnMouseDown = Led0ShapeMouseDown
    end
    object Led4Shape: TShape
      Left = 14
      Top = 93
      Width = 17
      Height = 17
      OnMouseDown = Led0ShapeMouseDown
    end
    object Led5Shape: TShape
      Left = 14
      Top = 70
      Width = 17
      Height = 17
      OnMouseDown = Led0ShapeMouseDown
    end
    object Led6Shape: TShape
      Left = 14
      Top = 47
      Width = 17
      Height = 17
      OnMouseDown = Led0ShapeMouseDown
    end
    object Led7Shape: TShape
      Left = 14
      Top = 24
      Width = 17
      Height = 17
      OnMouseDown = Led0ShapeMouseDown
    end
  end
  object GroupBox2: TGroupBox
    Left = 308
    Top = 8
    Width = 273
    Height = 281
    Caption = 'Analogs'
    TabOrder = 4
    object MeasLabel: TLabel
      Left = 112
      Top = 247
      Width = 33
      Height = 19
      Alignment = taCenter
      Caption = '...'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
    end
    object An1TrackBar: TTrackBar
      Left = 13
      Top = 20
      Width = 45
      Height = 221
      Max = 4095
      Orientation = trVertical
      PageSize = 100
      Frequency = 100
      Position = 4095
      TabOrder = 0
    end
    object An2TrackBar: TTrackBar
      Left = 64
      Top = 20
      Width = 45
      Height = 221
      Max = 4095
      Orientation = trVertical
      PageSize = 100
      Frequency = 100
      Position = 4095
      TabOrder = 1
    end
    object An3TrackBar: TTrackBar
      Left = 115
      Top = 20
      Width = 45
      Height = 221
      Max = 4095
      Orientation = trVertical
      PageSize = 100
      Frequency = 100
      Position = 4095
      TabOrder = 2
    end
    object An4TrackBar: TTrackBar
      Left = 166
      Top = 20
      Width = 45
      Height = 221
      Max = 4095
      Orientation = trVertical
      PageSize = 100
      Frequency = 100
      Position = 4095
      TabOrder = 3
    end
    object An5TrackBar: TTrackBar
      Left = 213
      Top = 20
      Width = 45
      Height = 221
      Max = 4095
      Orientation = trVertical
      PageSize = 100
      Frequency = 100
      Position = 4095
      TabOrder = 4
    end
  end
  object KalibrGrid: TStringGrid
    Left = 587
    Top = 8
    Width = 412
    Height = 185
    ColCount = 4
    DefaultColWidth = 30
    FixedCols = 2
    RowCount = 7
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    TabOrder = 5
    ColWidths = (
      30
      160
      92
      122)
  end
  object Panel4: TPanel
    Left = 587
    Top = 215
    Width = 369
    Height = 34
    TabOrder = 6
    object PK1Box: TCheckBox
      Left = 15
      Top = 10
      Width = 49
      Height = 17
      Caption = 'PK1'
      TabOrder = 0
      OnClick = PK1BoxClick
    end
    object PK2Box: TCheckBox
      Left = 70
      Top = 10
      Width = 49
      Height = 17
      Caption = 'PK2'
      TabOrder = 1
      OnClick = PK1BoxClick
    end
    object PK3Box: TCheckBox
      Left = 133
      Top = 10
      Width = 49
      Height = 17
      Caption = 'PK3'
      TabOrder = 2
      OnClick = PK1BoxClick
    end
    object PK4Box: TCheckBox
      Left = 188
      Top = 10
      Width = 49
      Height = 17
      Caption = 'PK4'
      TabOrder = 3
      OnClick = PK1BoxClick
    end
    object PK5Box: TCheckBox
      Left = 243
      Top = 11
      Width = 49
      Height = 17
      Caption = 'PK5'
      TabOrder = 4
      OnClick = PK1BoxClick
    end
    object PK6Box: TCheckBox
      Left = 306
      Top = 11
      Width = 49
      Height = 17
      Caption = 'PK6'
      TabOrder = 5
      OnClick = PK1BoxClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 63
    Width = 185
    Height = 147
    Caption = 'TCP/IP'
    TabOrder = 7
    object IP_Edit: TLabeledEdit
      Left = 16
      Top = 34
      Width = 121
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'IP'
      TabOrder = 0
    end
    object Mask_Edit: TLabeledEdit
      Left = 16
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 32
      EditLabel.Height = 13
      EditLabel.Caption = 'Maska'
      TabOrder = 1
    end
    object GW_Edit: TLabeledEdit
      Left = 16
      Top = 114
      Width = 121
      Height = 21
      EditLabel.Width = 45
      EditLabel.Height = 13
      EditLabel.Caption = 'GateWay'
      TabOrder = 2
    end
  end
  object GroupBox4: TGroupBox
    Left = 587
    Top = 255
    Width = 412
    Height = 160
    Caption = 'ServiceCfg'
    TabOrder = 8
    object MaxPressureEdit: TLabeledEdit
      Left = 16
      Top = 34
      Width = 121
      Height = 21
      EditLabel.Width = 64
      EditLabel.Height = 13
      EditLabel.Caption = 'Max Pressure'
      TabOrder = 0
    end
    object LedSepGrid: TStringGrid
      Left = 16
      Top = 64
      Width = 393
      Height = 57
      ColCount = 8
      DefaultColWidth = 30
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
      TabOrder = 1
      ColWidths = (
        30
        47
        41
        41
        46
        48
        45
        44)
    end
  end
  object AnalogTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = AnalogTimerTimer
    Left = 456
    Top = 48
  end
  object KalibrMeasTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = KalibrMeasTimerTimer
    Left = 456
    Top = 112
  end
end
