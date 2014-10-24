{
------------------------
 Darkplaces Launcher
 Property of RazorWind Games
 coded by Pavel P. [VorteX] Timofeyev
 					    email:paul.vortex@gmail.com
------------------------
}

program launch;

uses
  Forms,
  FormMain in 'FormMain.pas' {MainForm},
  FormSettings in 'FormSettings.pas' {SettingsForm},
  defs in 'Units\defs.pas',
  common in 'Units\common.pas',
  winVersion in 'Units\winVersion.pas',
  util in 'Units\util.pas',
  FormMapeditor in 'FormMapeditor.pas' {frmMapeditor};

{$R *.res}
var
  i : Integer;
  cmdline : String;
  
begin
  Application.Initialize;
  InitProgram();
  Application.Title := 'DpOmnicide Launcher';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TfrmMapeditor, frmMapeditor);
  if ParamCount > 1 then begin
    cmdline := LaunchGameParms;
    {cmdline := cmdline + ' +set startvideos ""';}
    for i := 1 to ParamCount do
      cmdline := cmdline + ' "' + ParamStr(i) + '"';
    LaunchGame('', cmdline);
    Application.Terminate();
  end else
    Application.Run;
end.
