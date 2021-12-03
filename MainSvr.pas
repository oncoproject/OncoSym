unit MainSvr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls,
  WinSock, SimpSock_Tcp,
  ClientUnit, iniFiles,
  SvrUnit, Vcl.Menus;

type
  TMainForm = class(TForm)
    SymKPPanel: TPanel;
    Label1: TLabel;
    ListenPortEdit: TSpinEdit;
    ListenBtn: TButton;
    StopBtn: TButton;
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    SymulatorAndroida1: TMenuItem;
    SymulatorKP1: TMenuItem;
    procedure ListenBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SymulatorAndroida1Click(Sender: TObject);
    procedure SymulatorKP1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    SimpServerTCP: TSimpServerTCP;
    procedure Wr(s: string);
    procedure wmCreated(var AMessage: TMessage); message wm_Created;
    procedure LoadFromIni;
    procedure SaveToIni;

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormShow(Sender: TObject);
begin
  LoadFromIni;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveToIni;
  Action := caFree;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SimpServerTCP := TSimpServerTCP.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SimpServerTCP.StopListen;
  SimpServerTCP.Free;
end;

procedure TMainForm.SaveToIni;
var
  Ini: TMemIniFile;
  FName: string;
begin
  FName := ChangeFileExt(ParamStr(0), '.ini');
  Ini := TMemIniFile.Create(FName);
  try
    Ini.WriteInteger('FRM_MAIN', 'TOP', Top);
    Ini.WriteInteger('FRM_MAIN', 'LEFT', Left);
    Ini.WriteInteger('FRM_MAIN', 'WIDTH', Width);
    Ini.WriteInteger('FRM_MAIN', 'HEIGHT', Height);

    Ini.UpdateFile;
  finally
    Ini.Free;
  end;

end;

procedure TMainForm.LoadFromIni;
var
  Ini: TMemIniFile;
  FName: string;
begin
  FName := ChangeFileExt(ParamStr(0), '.ini');
  Ini := TMemIniFile.Create(FName);
  try
    Top := Ini.ReadInteger('FRM_MAIN', 'TOP', Top);
    Left := Ini.ReadInteger('FRM_MAIN', 'LEFT', Left);
    Width := Ini.ReadInteger('FRM_MAIN', 'WIDTH', Width);
    Height := Ini.ReadInteger('FRM_MAIN', 'HEIGHT', Height);
  finally
    Ini.Free;
  end;

end;

procedure TMainForm.ListenBtnClick(Sender: TObject);
begin
  SimpServerTCP.Port := ListenPortEdit.Value;
  SimpServerTCP.Startlisten(TTestClientTask);
  Wr('StartListen');

end;

procedure TMainForm.SymulatorAndroida1Click(Sender: TObject);
begin
  TClientForm.Create(self);
end;

procedure TMainForm.SymulatorKP1Click(Sender: TObject);
begin
  SymKPPanel.Visible := not(SymKPPanel.Visible);
end;

procedure TMainForm.wmCreated(var AMessage: TMessage);
var
  Form: TSvrForm;
begin
  Form := TSvrForm.Create(self);
  Form.Client := TTestClientTask(AMessage.WParam);
  Form.Client.Form := Form;
  PostMessage(Form.Handle, wm_Started, 0, 0);
end;

procedure TMainForm.Wr(s: string);
begin
  Memo1.Lines.Add(s);
end;

end.
