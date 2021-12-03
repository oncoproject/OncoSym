program OncoSym;

uses
  Vcl.Forms,
  MainSvr in 'MainSvr.pas' {MainForm},
  SimpSock_Tcp in 'SimpSock_Tcp.pas',
  SvrUnit in 'SvrUnit.pas' {SvrForm},
  ClientUnit in 'ClientUnit.pas' {ClientForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
