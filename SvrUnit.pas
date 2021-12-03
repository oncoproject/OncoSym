unit SvrUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, iniFiles,
  Buttons, WinSock, SimpSock_Tcp, Vcl.ComCtrls, Vcl.Grids;

const
  wm_NewStr = WM_USER + 100;
  wm_Closed = WM_USER + 101;
  wm_NewBuf = WM_USER + 102;
  wm_Started = WM_USER + 103;
  wm_Created = WM_USER + 104;

type
  TStrObj = class(TObject)
    txt: string;
  end;

  TSvrForm = class;

  TTestClientTask = class(TClientTask)
  private
  protected
    PartCnt: integer;
    mRecIp: string;
    mRecPort: word;

    procedure ReciveMsg(s: string); override;
    procedure SocketClose; override;
    procedure Start(aSd: TSocket; recIp: string; RecPort: word); override;
    procedure Closed; override;
  public
    Form: TSvrForm;
    constructor Create(aOwnerList: TClientTaskList); override;
  end;

  TSvrForm = class(TForm)
    Memo1: TMemo;
    CloseSocketBtn: TButton;
    CloseOnCloseBox: TCheckBox;
    GroupBox1: TGroupBox;
    Led0Shape: TShape;
    Led1Shape: TShape;
    Led2Shape: TShape;
    Led3Shape: TShape;
    Led4Shape: TShape;
    Led5Shape: TShape;
    Led6Shape: TShape;
    Led7Shape: TShape;
    An1TrackBar: TTrackBar;
    GroupBox2: TGroupBox;
    An2TrackBar: TTrackBar;
    An3TrackBar: TTrackBar;
    An4TrackBar: TTrackBar;
    An5TrackBar: TTrackBar;
    MeasLabel: TLabel;
    AnalogTimer: TTimer;

    Splitter1: TSplitter;
    KalibrGrid: TStringGrid;
    KalibrMeasTimer: TTimer;
    Panel4: TPanel;
    PK1Box: TCheckBox;
    PK2Box: TCheckBox;
    PK3Box: TCheckBox;
    PK4Box: TCheckBox;
    PK5Box: TCheckBox;
    PK6Box: TCheckBox;
    GroupBox3: TGroupBox;
    IP_Edit: TLabeledEdit;
    Mask_Edit: TLabeledEdit;
    GW_Edit: TLabeledEdit;
    GroupBox4: TGroupBox;
    MaxPressureEdit: TLabeledEdit;
    LedSepGrid: TStringGrid;
    procedure CloseSocketBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AnalogTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure KalibrMeasTimerTimer(Sender: TObject);
    procedure PK1BoxClick(Sender: TObject);
    procedure Led0ShapeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
  private
    mLedsState: byte;
    TabLedShape: array [0 .. 7] of TShape;
    TabAnTrackBar: array [0 .. 4] of TTrackBar;
    TabPKBox: array [0 .. 5] of TCheckBox;

    procedure wmNewStr(var AMessage: TMessage); message wm_NewStr;
    procedure wmClosed(var AMessage: TMessage); message wm_Closed;
    procedure wmNewBuf(var AMessage: TMessage); message wm_NewBuf;
    procedure wmStarted(var AMessage: TMessage); message wm_Started;
    procedure proceedRecMsg(cmd: string; arg: TStringList);
    procedure SendCmd(cmd: string; arg: String); overload;
    procedure SendCmd(cmd: string; arg: TStringList); overload;
    procedure LoadFromIni;
    procedure SaveToIni;
    function Skalowanie(nr: integer; v: double): double;
    procedure SetShapeColor(idx: integer; Sh: TShape; q: boolean);
    procedure showLeds;

  public
    Strm: TFileStream;
    Client: TTestClientTask;
    procedure Wr(s: string);
  end;

implementation

{$R *.dfm}

uses
  MainSvr;

const
  NM_DIST = 'DIST';
  NM_PRESSURE = 'PRESSURE';
  NM_TAB: array [0 .. 1] of string = (NM_DIST, NM_PRESSURE);

  PK_NM_PUMP = 'PUMP';
  PK_NM_VALVE = 'VALVE';

  PK_NAME_TAB: array [0 .. 5] of String = (PK_NM_PUMP, PK_NM_VALVE, 'PK3', 'PK4', 'PK5', 'PK6');

var
  ViewCounter: integer;

  // ------------------------------------------------------------------------
constructor TTestClientTask.Create(aOwnerList: TClientTaskList);
begin
  inherited;
  SendMessage(MainForm.Handle, wm_Created, integer(self), 0);
end;

procedure TTestClientTask.ReciveMsg(s: string);
var
  strObj: TStrObj;
begin
  // wywo³ywane z tasku !!
  strObj := TStrObj.Create;
  strObj.txt := s;
  PostMessage(Form.Handle, wm_NewStr, integer(strObj), 0);
  inherited;
end;

procedure TTestClientTask.SocketClose;
begin
  Form.Wr('SocketClose');
  inherited;
end;

procedure TTestClientTask.Start(aSd: TSocket; recIp: string; RecPort: word);
begin
  // wywo³ywane z tasku !!
  // PostMessage(Form.Handle,wm_Started,PartCnt,0);
  mRecIp := recIp;
  mRecPort := RecPort;

  PartCnt := 0;
  inherited;
end;

procedure TTestClientTask.Closed;
begin
  // wywo³ywane z tasku !!
  PostMessage(Form.Handle, wm_Closed, PartCnt, 0);
  if Form.CloseOnCloseBox.Checked then
    PostMessage(Form.Handle, wm_Close, 0, 0);
  inherited;
end;

// ------------------------------------------------------------------------
procedure TSvrForm.FormShow(Sender: TObject);
begin
  LoadFromIni;
end;

function TSvrForm.Skalowanie(nr: integer; v: double): double;
var
  wsp_a, wsp_b: string;
  w_a, w_b: double;
begin
  wsp_a := KalibrGrid.Cells[2 + nr, 5];
  wsp_b := KalibrGrid.Cells[2 + nr, 6];
  try
    w_a := StrToFloat(wsp_a, DotFormatSettings);
    w_b := StrToFloat(wsp_b, DotFormatSettings);
  except
    w_a := 1;
    w_b := 0;
  end;
  Result := w_a * v + w_b;
end;

procedure TSvrForm.KalibrMeasTimerTimer(Sender: TObject);
var
  i: integer;
  arg: TStringList;
  v, w: double;
begin
  arg := TStringList.Create;
  try
    for i := 0 to 1 do
    begin
      arg.Clear;
      arg.Add(NM_TAB[i]);
      v := 100 * (4095 - TabAnTrackBar[i].Position) / 4096;
      arg.Add(FormatFloat('00.00', v, DotFormatSettings));
      w := Skalowanie(i, v / 100);
      arg.Add(FormatFloat('0.000', w, DotFormatSettings));
      SendCmd('CALIBR_MEAS', arg);
    end;

  finally
    arg.Free;
  end;
end;

procedure TSvrForm.AnalogTimerTimer(Sender: TObject);
var
  i: integer;
  arg: TStringList;
  v, w: double;
begin
  arg := TStringList.Create;
  try
    for i := 0 to 1 do
    begin
      v := 100 * (4095 - TabAnTrackBar[i].Position) / 4096;
      w := Skalowanie(i, v / 100);
      arg.Add(FormatFloat('0.000', w, DotFormatSettings));
    end;
    SendCmd('MEASURES', arg);
  finally
    arg.Free;
  end;
end;

procedure TSvrForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveToIni;
  Action := caFree;
end;

procedure TSvrForm.Wr(s: string);
begin
  Memo1.Lines.Add(s);
end;

procedure TSvrForm.showLeds;
var
  i: integer;
begin
  for i := 0 to 7 do
    SetShapeColor(i, TabLedShape[i], ((mLedsState and (1 shl i)) <> 0));
end;

procedure TSvrForm.Led0ShapeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);

var
  i: integer;
  b: byte;
begin
  for i := 0 to 7 do
  begin
    if TabLedShape[i] = Sender then
    begin
      mLedsState := mLedsState xor (1 shl i);
      break;
    end;
  end;
  showLeds;

  SendCmd('LEDS', IntToHex(mLedsState, 2));

end;

procedure TSvrForm.LoadFromIni;
var
  Ini: TMemIniFile;
  FName: string;
  i: integer;
begin
  FName := ChangeFileExt(ParamStr(0), '.ini');
  Ini := TMemIniFile.Create(FName);
  try
    KalibrGrid.Cells[2, 1] := Ini.ReadString('DIST', 'PK1_X', KalibrGrid.Cells[2, 1]);
    KalibrGrid.Cells[2, 2] := Ini.ReadString('DIST', 'PK1_Y', KalibrGrid.Cells[2, 2]);
    KalibrGrid.Cells[2, 3] := Ini.ReadString('DIST', 'PK2_X', KalibrGrid.Cells[2, 3]);
    KalibrGrid.Cells[2, 4] := Ini.ReadString('DIST', 'PK2_Y', KalibrGrid.Cells[2, 4]);
    KalibrGrid.Cells[2, 5] := Ini.ReadString('DIST', 'WSPOL_A', KalibrGrid.Cells[2, 5]);
    KalibrGrid.Cells[2, 6] := Ini.ReadString('DIST', 'WSPOL_B', KalibrGrid.Cells[2, 6]);

    KalibrGrid.Cells[3, 1] := Ini.ReadString('PRESSURE', 'PK1_X', KalibrGrid.Cells[3, 1]);
    KalibrGrid.Cells[3, 2] := Ini.ReadString('PRESSURE', 'PK1_Y', KalibrGrid.Cells[3, 2]);
    KalibrGrid.Cells[3, 3] := Ini.ReadString('PRESSURE', 'PK2_X', KalibrGrid.Cells[3, 3]);
    KalibrGrid.Cells[3, 4] := Ini.ReadString('PRESSURE', 'PK2_Y', KalibrGrid.Cells[3, 4]);
    KalibrGrid.Cells[3, 5] := Ini.ReadString('PRESSURE', 'WSPOL_A', KalibrGrid.Cells[3, 5]);
    KalibrGrid.Cells[3, 6] := Ini.ReadString('PRESSURE', 'WSPOL_B', KalibrGrid.Cells[3, 6]);

    Top := Ini.ReadInteger('MAIN', 'TOP', Top);
    Left := Ini.ReadInteger('MAIN', 'LEFT', Left);
    Width := Ini.ReadInteger('MAIN', 'WIDTH', Width);
    Height := Ini.ReadInteger('MAIN', 'HEIGHT', Height);

    mLedsState := Ini.ReadInteger('MAIN', 'LEDS', mLedsState);
    showLeds;

    for i := 0 to 4 do
      TabAnTrackBar[i].Position := Ini.ReadInteger('ANALOGS', 'AN_' + IntToStr(i), TabAnTrackBar[i].Position);

    for i := 0 to 5 do
      TabPKBox[i].Checked := Ini.ReadBool('PK', 'PK_' + IntToStr(i), TabPKBox[i].Checked);

    IP_Edit.Text := Ini.ReadString('TCP', 'IP', IP_Edit.Text);
    Mask_Edit.Text := Ini.ReadString('TCP', 'MASK', Mask_Edit.Text);
    GW_Edit.Text := Ini.ReadString('TCP', 'GATEWAY', GW_Edit.Text);
    MaxPressureEdit.Text := Ini.ReadString('CFG_SERVICE', 'MaxPressure', MaxPressureEdit.Text);
    for i := 1 to 7 do
      LedSepGrid.Cells[i, 1] := Ini.ReadString('CFG_SERVICE', 'LED_DIST_' + IntToStr(i), LedSepGrid.Cells[i, 1]);

  finally
    Ini.Free;
  end;

end;

procedure TSvrForm.SaveToIni;
var
  Ini: TMemIniFile;
  FName: string;
  i: integer;
begin
  FName := ChangeFileExt(ParamStr(0), '.ini');
  Ini := TMemIniFile.Create(FName);
  try
    Ini.WriteString('DIST', 'PK1_X', KalibrGrid.Cells[2, 1]);
    Ini.WriteString('DIST', 'PK1_Y', KalibrGrid.Cells[2, 2]);
    Ini.WriteString('DIST', 'PK2_X', KalibrGrid.Cells[2, 3]);
    Ini.WriteString('DIST', 'PK2_Y', KalibrGrid.Cells[2, 4]);
    Ini.WriteString('DIST', 'WSPOL_A', KalibrGrid.Cells[2, 5]);
    Ini.WriteString('DIST', 'WSPOL_B', KalibrGrid.Cells[2, 6]);

    Ini.WriteString('PRESSURE', 'PK1_X', KalibrGrid.Cells[3, 1]);
    Ini.WriteString('PRESSURE', 'PK1_Y', KalibrGrid.Cells[3, 2]);
    Ini.WriteString('PRESSURE', 'PK2_X', KalibrGrid.Cells[3, 3]);
    Ini.WriteString('PRESSURE', 'PK2_Y', KalibrGrid.Cells[3, 4]);
    Ini.WriteString('PRESSURE', 'WSPOL_A', KalibrGrid.Cells[3, 5]);
    Ini.WriteString('PRESSURE', 'WSPOL_B', KalibrGrid.Cells[3, 6]);

    Ini.WriteInteger('MAIN', 'TOP', Top);
    Ini.WriteInteger('MAIN', 'LEFT', Left);
    Ini.WriteInteger('MAIN', 'WIDTH', Width);
    Ini.WriteInteger('MAIN', 'HEIGHT', Height);

    Ini.WriteInteger('MAIN', 'LEDS', mLedsState);

    for i := 0 to 4 do
      Ini.WriteInteger('ANALOGS', 'AN_' + IntToStr(i), TabAnTrackBar[i].Position);

    for i := 0 to 5 do
      Ini.WriteBool('PK', 'PK_' + IntToStr(i), TabPKBox[i].Checked);

    Ini.WriteString('TCP', 'IP', IP_Edit.Text);
    Ini.WriteString('TCP', 'MASK', Mask_Edit.Text);
    Ini.WriteString('TCP', 'GATEWAY', GW_Edit.Text);
    Ini.WriteString('CFG_SERVICE', 'MaxPressure', MaxPressureEdit.Text);
    for i := 1 to 7 do
      Ini.WriteString('CFG_SERVICE', 'LED_DIST_' + IntToStr(i), LedSepGrid.Cells[i, 1]);

    Ini.UpdateFile;
  finally
    Ini.Free;
  end;

end;

procedure TSvrForm.CloseSocketBtnClick(Sender: TObject);
begin
  Client.Stop;
end;

procedure TSvrForm.FormCreate(Sender: TObject);
begin
  Strm := nil;
  TabLedShape[0] := Led0Shape;
  TabLedShape[1] := Led1Shape;
  TabLedShape[2] := Led2Shape;
  TabLedShape[3] := Led3Shape;
  TabLedShape[4] := Led4Shape;
  TabLedShape[5] := Led5Shape;
  TabLedShape[6] := Led6Shape;
  TabLedShape[7] := Led7Shape;

  TabAnTrackBar[0] := An1TrackBar;
  TabAnTrackBar[1] := An2TrackBar;
  TabAnTrackBar[2] := An3TrackBar;
  TabAnTrackBar[3] := An4TrackBar;
  TabAnTrackBar[4] := An5TrackBar;

  TabPKBox[0] := PK1Box;
  TabPKBox[1] := PK2Box;
  TabPKBox[2] := PK3Box;
  TabPKBox[3] := PK4Box;
  TabPKBox[4] := PK5Box;
  TabPKBox[5] := PK6Box;

  KalibrGrid.Rows[0].CommaText := 'lp Element Dystans Ciœnienie';
  KalibrGrid.Cols[0].CommaText := 'lp 1 2 3 4 5 6';
  KalibrGrid.Cols[1].CommaText := 'Element P1-X[mm/Pa] P1-Y[%] P2-X[mm/Pa] P2-Y[%] Wspol.A Wspol.B';

  LedSepGrid.Rows[0].CommaText := 'idx Led8-7 Led7-6 Led6-5 Led5-4 Led4-3 Led3-2 Led2-1';
  LedSepGrid.Rows[1].CommaText := 'Dist';
end;

procedure TSvrForm.wmNewStr(var AMessage: TMessage);
  procedure remooveNL_1(var s: string);
  const
    EOF_S: set of char = [#$0d, #$0A];
  begin
    if s[length(s)] in EOF_S then
      s := copy(s, 1, length(s) - 1);
  end;
  procedure remooveNL(var s: string);
  begin
    remooveNL_1(s);
    remooveNL_1(s);
  end;

var
  strObj: TStrObj;
  X: integer;
  s: string;
  cmd: string;
  rest: string;
  rSL: TStringList;
begin
  strObj := TStrObj(AMessage.WParam);
  s := strObj.txt;
  strObj.Free;

  rSL := TStringList.Create;
  try

    remooveNL(s);
    Wr(s);

    X := pos('=', s);
    rest := '';
    if X > 0 then
    begin
      cmd := copy(s, 1, X - 1);
      if X < length(s) then
      begin
        rest := copy(s, X + 1, length(s) - X);
      end;
    end
    else
      cmd := s;
    rSL.Delimiter := ';';
    rSL.DelimitedText := rest;
    proceedRecMsg(cmd, rSL);

  finally
    rSL.Free;

  end;

end;

procedure TSvrForm.SendCmd(cmd: string; arg: String);
var
  s: string;
begin
  if arg <> '' then
    s := Format('%s=%s', [cmd, arg])
  else
    s := cmd;
  Client.SendNL(s);
end;

procedure TSvrForm.SendCmd(cmd: string; arg: TStringList);
begin
  arg.Delimiter := ';';
  SendCmd(cmd, arg.DelimitedText);
end;

procedure TSvrForm.SetShapeColor(idx: integer; Sh: TShape; q: boolean);
begin
  if q then
  begin
    if (idx = 7) or (idx < 4) then
      Sh.Brush.Color := clRed
    else
      Sh.Brush.Color := clLime;
  end
  else
    Sh.Brush.Color := clGray;
end;

procedure TSvrForm.proceedRecMsg(cmd: string; arg: TStringList);

  procedure setLeds(txt: string);
  var
    b: integer;
    i: integer;
  begin
    if tryStrToInt('$' + txt, b) then
    begin
      for i := 0 to 7 do
      begin
        SetShapeColor(i, TabLedShape[i], (b and (1 shl i)) <> 0);
      end;
    end;

  end;

  procedure GetCfgService;
  var
    arg: TStringList;
    i: integer;
  begin
    arg := TStringList.Create;
    try
      arg.Add(IP_Edit.Text);
      arg.Add(Mask_Edit.Text);
      arg.Add(GW_Edit.Text);
      arg.Add(MaxPressureEdit.Text);
      for i := 1 to 7 do
        arg.Add(LedSepGrid.Cells[i, 1]);
      SendCmd('CFG_SERVICE', arg);
    finally
      arg.Free;
    end;

  end;
  procedure SetCfgService(arg: TStringList);
  var
    i: integer;
  begin
    IP_Edit.Text := arg.Strings[0];
    Mask_Edit.Text := arg.Strings[1];
    GW_Edit.Text := arg.Strings[2];
    MaxPressureEdit.Text := arg.Strings[3];
    for i := 1 to 7 do
      LedSepGrid.Cells[i, 1] := arg.Strings[4 + i - 1];
  end;

  procedure SetFactors(arg: TStringList);
  begin

  end;
  procedure makeCalibr(arg: TStringList);
  begin

  end;

  procedure ForcePk(arg: TStringList);
  var
    idx: integer;
  begin
    idx := -1;
    if arg.Strings[0] = PK_NM_PUMP then
      idx := 0
    else if arg.Strings[0] = PK_NM_VALVE then
      idx := 1;
    if idx >= 0 then
    begin
      TabPKBox[idx].Checked := (arg.Strings[1] = '1');
    end;

  end;

  procedure SendKalibr;
  var
    arg: TStringList;
  begin
    arg := TStringList.Create;
    try
      arg.Clear;
      arg.Add(NM_DIST);
      arg.Add('P1');
      arg.Add(KalibrGrid.Cells[2, 1]);
      arg.Add(KalibrGrid.Cells[2, 2]);
      SendCmd('CALIBR', arg);

      arg.Clear;
      arg.Add(NM_DIST);
      arg.Add('P2');
      arg.Add(KalibrGrid.Cells[2, 3]);
      arg.Add(KalibrGrid.Cells[2, 4]);
      SendCmd('CALIBR', arg);

      arg.Clear;
      arg.Add(NM_DIST);
      arg.Add('FACTOR');
      arg.Add(KalibrGrid.Cells[2, 5]);
      arg.Add(KalibrGrid.Cells[2, 6]);
      SendCmd('CALIBR', arg);

      arg.Clear;
      arg.Add(NM_PRESSURE);
      arg.Add('P1');
      arg.Add(KalibrGrid.Cells[3, 1]);
      arg.Add(KalibrGrid.Cells[3, 2]);
      SendCmd('CALIBR', arg);

      arg.Clear;
      arg.Add(NM_PRESSURE);
      arg.Add('P2');
      arg.Add(KalibrGrid.Cells[3, 3]);
      arg.Add(KalibrGrid.Cells[3, 4]);
      SendCmd('CALIBR', arg);

      arg.Clear;
      arg.Add(NM_PRESSURE);
      arg.Add('FACTOR');
      arg.Add(KalibrGrid.Cells[3, 5]);
      arg.Add(KalibrGrid.Cells[3, 6]);
      SendCmd('CALIBR', arg);

    finally
      arg.Free;
    end;
  end;

begin
  if cmd = 'LDS' then
  begin
    setLeds(arg.Strings[0]);

  end
  else if cmd = 'BUZ' then
  begin

  end
  else if cmd = 'GET_MEAS' then
  begin
    AnalogTimer.Enabled := (arg.Strings[0] = '1');
    if AnalogTimer.Enabled then
      MeasLabel.Caption := 'POMIAR'
    else
      MeasLabel.Caption := '...';
  end
  else if cmd = 'SET_FACTOR' then
  begin
    SetFactors(arg);
  end
  else if cmd = 'MAKE_CALIBR' then
  begin
    makeCalibr(arg);
  end
  else if cmd = 'GET_CALIBR' then
  begin
    SendKalibr;
  end
  else if cmd = 'CALIBR_MEAS' then
  begin
    KalibrMeasTimer.Enabled := (arg.Strings[0] = '1');
  end
  else if cmd = 'FORCE_PK' then
  begin
    ForcePk(arg);
  end
  else if cmd = 'GET_CFG_SERVICE' then
  begin
    GetCfgService;
  end
  else if cmd = 'SET_CFG_SERVICE' then
  begin
    SetCfgService(arg);
  end;

end;

procedure TSvrForm.PK1BoxClick(Sender: TObject);
var
  i: integer;
  idx: integer;
  arg: TStringList;
  s1: string;
begin
  idx := -1;
  for i := 0 to 5 do
  begin
    if Sender = TabPKBox[i] then
    begin
      idx := i;
      break;
    end;
  end;
  if idx >= 0 then
  begin
    arg := TStringList.Create;
    try
      arg.Add(PK_NAME_TAB[idx]);
      if (Sender as TCheckBox).Checked then
        s1 := '1'
      else
        s1 := '0';

      arg.Add(s1);
      SendCmd('PK_STATE', arg);
    finally
      arg.Free;
    end;
  end;
end;

procedure TSvrForm.wmNewBuf(var AMessage: TMessage);
begin
  Wr('!');
end;

procedure TSvrForm.wmStarted(var AMessage: TMessage);
begin
  Wr(Format('Start, Ip=%s Port=%u', [Client.mRecIp, Client.mRecPort]));
end;

procedure TSvrForm.wmClosed(var AMessage: TMessage);
begin
  Wr('Closed  PC=' + IntToStr(AMessage.WParam));
end;

initialization

ViewCounter := 100;

end.
