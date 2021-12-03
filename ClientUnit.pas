unit ClientUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, SimpSock_Tcp, Vcl.ComCtrls,
  Vcl.Samples.Gauges, VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.Series,
  VclTee.TeeProcs, VclTee.Chart;

type
  TClientForm = class;

  TMyTcp = class(TSimpTcp)
  protected
    procedure DoOnConnect; override;
    procedure DoOnClose; override;
    procedure DoOnMsgRead; override;
    procedure DoOnMsgWrite; override;
  public
    Form: TClientForm;

  end;

  TClientForm = class(TForm)
    Memo1: TMemo;
    CloseSocketBtn: TButton;
    Write8kbBtn: TButton;
    OpenBtn: TButton;
    IpEdit: TLabeledEdit;
    PortEdit: TLabeledEdit;
    Panel2: TPanel;
    cmdMemo: TMemo;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Inp1Gauge: TGauge;
    Inp2Gauge: TGauge;
    Inp3Gauge: TGauge;
    Inp4Gauge: TGauge;
    Inp5Gauge: TGauge;
    Inp1Text: TStaticText;
    Inp2Text: TStaticText;
    Inp3Text: TStaticText;
    Inp4Text: TStaticText;
    Inp5Text: TStaticText;
    Panel3: TPanel;
    StartBtn: TButton;
    StopBtn: TButton;
    Panel4: TPanel;
    PK1Box: TCheckBox;
    PK2Box: TCheckBox;
    PK3Box: TCheckBox;
    PK4Box: TCheckBox;
    PK5Box: TCheckBox;
    PK6Box: TCheckBox;
    Panel5: TPanel;
    Lds4Box: TCheckBox;
    Lds5Box: TCheckBox;
    Lds6Box: TCheckBox;
    Lds1Box: TCheckBox;
    Lds2Box: TCheckBox;
    Lds3Box: TCheckBox;
    Lds7Box: TCheckBox;
    Lds8Box: TCheckBox;
    Label1: TLabel;
    Panel6: TPanel;
    Panel7: TPanel;
    Splitter1: TSplitter;
    Button1: TButton;
    MsgBox: TCheckBox;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    SaveBtn: TButton;
    Buz1Btn: TButton;
    Buz2Btn: TButton;
    SGBox: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure CloseSocketBtnClick(Sender: TObject);
    procedure Write8kbBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure PK6BoxClick(Sender: TObject);
    procedure Lds1BoxClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure Buz1BtnClick(Sender: TObject);
    procedure Buz2BtnClick(Sender: TObject);
    procedure SGBoxClick(Sender: TObject);
  private
    SimpTcp: TMyTcp;
    TabInpGauge: array [0 .. 4] of TGauge;
    TabInpText: array [0 .. 4] of TStaticText;
    TabPKBox: array [0 .. 5] of TCheckBox;
    TabLDSBox: array [0 .. 7] of TCheckBox;
    TabSer: array [0 .. 4] of TLineSeries;

    procedure Wr(s: string);
    procedure SendCmd(cmd: string; arg: String); overload;
    procedure SendCmd(cmd: string; arg: TStringList); overload;

  public
    { Public declarations }
  end;

var
  ClientForm: TClientForm;

implementation

{$R *.dfm}


procedure TClientForm.FormCreate(Sender: TObject);
begin
  SimpTcp := TMyTcp.Create;
  SimpTcp.Form := self;
  TabInpGauge[0] := Inp1Gauge;
  TabInpGauge[1] := Inp2Gauge;
  TabInpGauge[2] := Inp3Gauge;
  TabInpGauge[3] := Inp4Gauge;
  TabInpGauge[4] := Inp5Gauge;

  TabInpText[0] := Inp1Text;
  TabInpText[1] := Inp2Text;
  TabInpText[2] := Inp3Text;
  TabInpText[3] := Inp4Text;
  TabInpText[4] := Inp5Text;

  TabPKBox[0] := PK1Box;
  TabPKBox[1] := PK2Box;
  TabPKBox[2] := PK3Box;
  TabPKBox[3] := PK4Box;
  TabPKBox[4] := PK5Box;
  TabPKBox[5] := PK6Box;

  TabLDSBox[0] := Lds1Box;
  TabLDSBox[1] := Lds2Box;
  TabLDSBox[2] := Lds3Box;
  TabLDSBox[3] := Lds4Box;
  TabLDSBox[4] := Lds5Box;
  TabLDSBox[5] := Lds6Box;
  TabLDSBox[6] := Lds7Box;
  TabLDSBox[7] := Lds8Box;

  TabSer[0] := Series1;
  TabSer[1] := Series2;
  TabSer[2] := Series3;
  TabSer[3] := Series4;
  TabSer[4] := Series5;

end;

procedure TClientForm.FormDestroy(Sender: TObject);
begin
  SimpTcp.Close;
  SimpTcp.Free;
end;

procedure TClientForm.SendCmd(cmd: string; arg: String);
var
  s: string;
begin
  if arg <> '' then
    s := Format('%s=%s', [cmd, arg])
  else
    s := cmd;
  SimpTcp.WriteStrNL(s)
end;

procedure TClientForm.SendCmd(cmd: string; arg: TStringList);
begin
  arg.Delimiter := ';';
  SendCmd(cmd, arg.DelimitedText);
end;

procedure TClientForm.Lds1BoxClick(Sender: TObject);
var
  i: integer;
  b: byte;
  s: string;
begin
  b := 0;
  for i := 0 to 7 do
  begin
    if TabLDSBox[i].Checked then
      b := b or ($01 shl i);
  end;
  s := Format('LDS=%.2X', [b]);
  Wr(Format('Write=%d', [SimpTcp.WriteStrNL(s)]));

end;

procedure TClientForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMyTcp.DoOnConnect;
begin
  Form.Wr('**Connected');
end;

procedure TMyTcp.DoOnClose;
begin
  Form.Wr('**Close');
end;

procedure TMyTcp.DoOnMsgRead;
  procedure setGauge(idx: integer; rest: string);
  var
    w: double;
  begin
    if TryStrToFloat(rest, w, DotFormatSettings) then
    begin
      Form.TabInpText[idx].caption := FormatFloat('000.0', w);
      Form.TabInpGauge[idx].Progress := round(100 * w / 4095);
      Form.TabSer[idx].AddY(w);

    end;

  end;

var
  txtM: string;
  txt: string;
  cmd: string;
  rest: string;
  SL: TStringList;
  n: integer;
  i: integer;

begin
  self.ReadStr(txtM);
  if Form.MsgBox.Checked then
  begin
    Form.Wr('**Msg');
    Form.Wr('[' + txtM + ']');
  end;

  SL := TStringList.Create;
  try
    SL.Text := txtM;
    for i := 0 to SL.Count - 1 do
    begin
      txt := SL.Strings[i];

      n := length(txt);
      if (n >= 4) and (txt[4] = '=') then
      begin
        cmd := copy(txt, 1, 3);
        rest := '';
        if n > 4 then
          rest := copy(txt, 5, n - 4);
        if cmd = 'IN0' then
          setGauge(0, rest)
        else if cmd = 'IN1' then
          setGauge(1, rest)
        else if cmd = 'IN2' then
          setGauge(2, rest)
        else if cmd = 'IN3' then
          setGauge(3, rest)
        else if cmd = 'IN4' then
          setGauge(4, rest)

      end;
    end;
  finally
    SL.Free;
  end;
end;

procedure TMyTcp.DoOnMsgWrite;
begin
  Form.Wr('**Write');
end;

procedure TClientForm.Wr(s: string);
begin
  Memo1.Lines.Add(s);
end;

procedure TClientForm.Write8kbBtnClick(Sender: TObject);
var
  s1: string;
begin
  s1 := cmdMemo.Lines.Text;
  Wr(Format('Write=%d', [SimpTcp.WriteStr(s1)]));
end;

procedure TClientForm.OpenBtnClick(Sender: TObject);
begin
  SimpTcp.Port := StrToInt(PortEdit.Text);
  SimpTcp.Ip := IpEdit.Text;

  Wr(Format('Open=%d', [SimpTcp.Open]));
  Wr(Format('Connect=%d', [SimpTcp.Connect]));
  SimpTcp.Async := true;
end;

procedure TClientForm.PK6BoxClick(Sender: TObject);
var
  i: integer;
  s: string;
begin
  for i := 0 to 5 do
  begin
    if Sender = TabPKBox[i] then
    begin
      s := Format('PK%u=%u', [i + 1, byte(TabPKBox[i].Checked)]);
      Wr(Format('Write=%d', [SimpTcp.WriteStrNL(s)]));
      break;
    end;
  end;
end;

procedure TClientForm.SaveBtnClick(Sender: TObject);
var
  n: integer;
  k: integer;
  i: integer;
  idx: integer;
  TabV: array [0 .. 4] of double;
  s1: string;
  SL: TStringList;
  SL1: TStringList;
  dlg: TSaveDialog;
begin
  dlg := TSaveDialog.Create(self);
  try
    if dlg.Execute then
    begin
      SL := TStringList.Create;
      SL1 := TStringList.Create;
      try
        SL1.Delimiter := ';';
        n := TabSer[0].Count;
        for i := 0 to n - 1 do
        begin
          SL1.Clear;
          SL1.Add(IntToStr(i));
          for k := 0 to 4 do
            SL1.Add(Format('%f', [TabSer[k].YValues[i]]));
          SL.Add(SL1.DelimitedText);
        end;

        SL.SaveToFile(dlg.FileName);
      finally
        SL.Free;
        SL1.Free;
      end;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TClientForm.StartBtnClick(Sender: TObject);
var
  i: integer;
begin
  Wr(Format('Write=%d', [SimpTcp.WriteStrNL('MES=1')]));
  for i := 0 to 4 do
    TabSer[i].Clear;
end;

procedure TClientForm.StopBtnClick(Sender: TObject);
begin
  Wr(Format('Write=%d', [SimpTcp.WriteStrNL('MES=0')]));
end;

procedure TClientForm.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TClientForm.Buz1BtnClick(Sender: TObject);
begin
  Wr(Format('Write=%d', [SimpTcp.WriteStrNL('BUZ=1')]));
end;

procedure TClientForm.Buz2BtnClick(Sender: TObject);
begin
  Wr(Format('Write=%d', [SimpTcp.WriteStrNL('BUZ=2')]));
end;

procedure TClientForm.SGBoxClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to 4 do
  begin
    TabSer[i].Pointer.Visible := SGBox.Checked;
  end;

end;

procedure TClientForm.CloseSocketBtnClick(Sender: TObject);
begin
  SimpTcp.Close;
end;


end.
