object ClientForm: TClientForm
  Left = 872
  Top = 639
  Caption = 'Client'
  ClientHeight = 628
  ClientWidth = 1027
  Color = clBtnFace
  Constraints.MinHeight = 450
  Constraints.MinWidth = 700
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 433
    Width = 1027
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 225
    ExplicitWidth = 393
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 609
    Width = 1027
    Height = 19
    Panels = <
      item
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1027
    Height = 433
    Align = alTop
    TabOrder = 1
    DesignSize = (
      1027
      433)
    object cmdMemo: TMemo
      Left = 174
      Top = 7
      Width = 132
      Height = 122
      Lines.Strings = (
        'Memo1')
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 10
      Top = 7
      Width = 145
      Height = 153
      TabOrder = 0
      object CloseSocketBtn: TButton
        Left = 56
        Top = 85
        Width = 75
        Height = 25
        Caption = 'Close socket'
        TabOrder = 0
        OnClick = CloseSocketBtnClick
      end
      object IpEdit: TLabeledEdit
        Left = 8
        Top = 16
        Width = 121
        Height = 21
        EditLabel.Width = 10
        EditLabel.Height = 13
        EditLabel.Caption = 'IP'
        TabOrder = 1
        Text = '192.168.254.191'
      end
      object OpenBtn: TButton
        Left = 55
        Top = 54
        Width = 75
        Height = 25
        Caption = 'Open'
        TabOrder = 2
        OnClick = OpenBtnClick
      end
      object PortEdit: TLabeledEdit
        Left = 8
        Top = 56
        Width = 41
        Height = 21
        EditLabel.Width = 19
        EditLabel.Height = 13
        EditLabel.Caption = 'Port'
        TabOrder = 3
        Text = '8400'
      end
      object Buz1Btn: TButton
        Left = 7
        Top = 122
        Width = 43
        Height = 25
        Caption = 'BUZ1'
        TabOrder = 4
        OnClick = Buz1BtnClick
      end
      object Buz2Btn: TButton
        Left = 56
        Top = 122
        Width = 43
        Height = 25
        Caption = 'BUZ2'
        TabOrder = 5
        OnClick = Buz2BtnClick
      end
    end
    object Panel3: TPanel
      Left = 7
      Top = 262
      Width = 369
      Height = 129
      TabOrder = 2
      object Inp1Gauge: TGauge
        Left = 8
        Top = 7
        Width = 65
        Height = 50
        Kind = gkNeedle
        Progress = 12
      end
      object Inp2Gauge: TGauge
        Left = 79
        Top = 7
        Width = 65
        Height = 50
        Kind = gkNeedle
        Progress = 0
      end
      object Inp3Gauge: TGauge
        Left = 150
        Top = 7
        Width = 65
        Height = 50
        Kind = gkNeedle
        Progress = 0
      end
      object Inp4Gauge: TGauge
        Left = 221
        Top = 7
        Width = 65
        Height = 50
        Kind = gkNeedle
        Progress = 0
      end
      object Inp5Gauge: TGauge
        Left = 292
        Top = 7
        Width = 65
        Height = 50
        Kind = gkNeedle
        Progress = 0
      end
      object Inp1Text: TStaticText
        Left = 8
        Top = 63
        Width = 65
        Height = 23
        Alignment = taCenter
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = sbsSingle
        Caption = 'Inp1Text'
        Color = clYellow
        ParentColor = False
        TabOrder = 0
        StyleElements = []
      end
      object Inp2Text: TStaticText
        Left = 79
        Top = 63
        Width = 65
        Height = 23
        Alignment = taCenter
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = sbsSingle
        Caption = 'Inp1Text'
        Color = clYellow
        ParentColor = False
        TabOrder = 1
        StyleElements = []
      end
      object Inp3Text: TStaticText
        Left = 150
        Top = 63
        Width = 65
        Height = 23
        Alignment = taCenter
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = sbsSingle
        Caption = 'Inp1Text'
        Color = clYellow
        ParentColor = False
        TabOrder = 2
        StyleElements = []
      end
      object Inp4Text: TStaticText
        Left = 221
        Top = 63
        Width = 65
        Height = 23
        Alignment = taCenter
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = sbsSingle
        Caption = 'Inp1Text'
        Color = clYellow
        ParentColor = False
        TabOrder = 3
        StyleElements = []
      end
      object Inp5Text: TStaticText
        Left = 292
        Top = 63
        Width = 65
        Height = 23
        Alignment = taCenter
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = sbsSingle
        Caption = 'Inp1Text'
        Color = clYellow
        ParentColor = False
        TabOrder = 4
        StyleElements = []
      end
      object StartBtn: TButton
        Left = 8
        Top = 92
        Width = 53
        Height = 25
        Caption = 'Start'
        TabOrder = 5
        OnClick = StartBtnClick
      end
      object StopBtn: TButton
        Left = 67
        Top = 92
        Width = 53
        Height = 25
        Caption = 'Stop'
        TabOrder = 6
        OnClick = StopBtnClick
      end
    end
    object Panel4: TPanel
      Left = 9
      Top = 214
      Width = 369
      Height = 42
      TabOrder = 3
      object PK1Box: TCheckBox
        Left = 183
        Top = 11
        Width = 49
        Height = 17
        Caption = 'PK1'
        TabOrder = 0
        OnClick = PK6BoxClick
      end
      object PK2Box: TCheckBox
        Left = 242
        Top = 11
        Width = 49
        Height = 17
        Caption = 'PK2'
        TabOrder = 1
        OnClick = PK6BoxClick
      end
      object PK3Box: TCheckBox
        Left = 301
        Top = 11
        Width = 49
        Height = 17
        Caption = 'PK3'
        TabOrder = 2
        OnClick = PK6BoxClick
      end
      object PK4Box: TCheckBox
        Left = 8
        Top = 11
        Width = 49
        Height = 17
        Caption = 'PK4'
        TabOrder = 3
        OnClick = PK6BoxClick
      end
      object PK5Box: TCheckBox
        Left = 63
        Top = 11
        Width = 49
        Height = 17
        Caption = 'PK5'
        TabOrder = 4
        OnClick = PK6BoxClick
      end
      object PK6Box: TCheckBox
        Left = 128
        Top = 11
        Width = 49
        Height = 17
        Caption = 'PK6'
        TabOrder = 5
        OnClick = PK6BoxClick
      end
    end
    object Panel5: TPanel
      Left = 8
      Top = 166
      Width = 298
      Height = 42
      TabOrder = 4
      object Label1: TLabel
        Left = 8
        Top = 14
        Width = 21
        Height = 13
        Caption = 'LDS'
      end
      object Lds4Box: TCheckBox
        Left = 147
        Top = 11
        Width = 30
        Height = 17
        Caption = '4'
        TabOrder = 0
        OnClick = Lds1BoxClick
      end
      object Lds5Box: TCheckBox
        Left = 177
        Top = 19
        Width = 30
        Height = 17
        Caption = '5'
        TabOrder = 1
        OnClick = Lds1BoxClick
      end
      object Lds6Box: TCheckBox
        Left = 209
        Top = 11
        Width = 30
        Height = 17
        Caption = '6'
        TabOrder = 2
        OnClick = Lds1BoxClick
      end
      object Lds1Box: TCheckBox
        Left = 56
        Top = 11
        Width = 30
        Height = 17
        Caption = '1'
        TabOrder = 3
        OnClick = Lds1BoxClick
      end
      object Lds2Box: TCheckBox
        Left = 86
        Top = 11
        Width = 30
        Height = 17
        Caption = '2'
        TabOrder = 4
        OnClick = Lds1BoxClick
      end
      object Lds3Box: TCheckBox
        Left = 117
        Top = 11
        Width = 30
        Height = 17
        Caption = '3'
        TabOrder = 5
        OnClick = Lds1BoxClick
      end
      object Lds7Box: TCheckBox
        Left = 239
        Top = 11
        Width = 30
        Height = 17
        Caption = '7'
        TabOrder = 6
        OnClick = Lds1BoxClick
      end
      object Lds8Box: TCheckBox
        Left = 265
        Top = 11
        Width = 30
        Height = 17
        Caption = '8'
        TabOrder = 7
        OnClick = Lds1BoxClick
      end
    end
    object Chart1: TChart
      Left = 394
      Top = 0
      Width = 633
      Height = 431
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Automatic = False
      BottomAxis.AutomaticMinimum = False
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Maximum = 4096.000000000000000000
      View3D = False
      TabOrder = 5
      Anchors = [akLeft, akTop, akRight, akBottom]
      DesignSize = (
        633
        431)
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object SaveBtn: TButton
        Left = 563
        Top = 14
        Width = 53
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Zapisz'
        TabOrder = 0
        OnClick = SaveBtnClick
      end
      object SGBox: TCheckBox
        Left = 575
        Top = 390
        Width = 42
        Height = 17
        Anchors = [akRight, akBottom]
        Caption = 'SG'
        TabOrder = 1
        OnClick = SGBoxClick
      end
      object Series1: TLineSeries
        Title = 'AD1'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        Title = 'AD2'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series3: TLineSeries
        Title = 'AD3'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series4: TLineSeries
        Title = 'AD4'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series5: TLineSeries
        Title = 'AD5'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object Write8kbBtn: TButton
    Left = 174
    Top = 135
    Width = 132
    Height = 25
    Caption = 'Write memo'
    TabOrder = 2
    OnClick = Write8kbBtnClick
  end
  object Panel6: TPanel
    Left = 0
    Top = 436
    Width = 1027
    Height = 173
    Align = alClient
    TabOrder = 3
    object Panel7: TPanel
      Left = 1
      Top = 1
      Width = 56
      Height = 171
      Align = alLeft
      TabOrder = 0
      object Button1: TButton
        Left = 6
        Top = 5
        Width = 44
        Height = 25
        Caption = 'Clr'
        TabOrder = 0
        OnClick = Button1Click
      end
      object MsgBox: TCheckBox
        Left = 8
        Top = 36
        Width = 44
        Height = 17
        Caption = 'Msg'
        TabOrder = 1
      end
    end
    object Memo1: TMemo
      Left = 57
      Top = 1
      Width = 969
      Height = 171
      Align = alClient
      Lines.Strings = (
        'Memo1')
      TabOrder = 1
    end
  end
end
