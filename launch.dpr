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
  common in 'Units\common.pas',
  winVersion in 'Units\winVersion.pas',
  util in 'Units\util.pas',
  defs in 'Units\defs.pas';

{$R *.res}

begin
  Application.Initialize;
  InitProgram();
  Application.Title := 'Blood Omnicide';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.Run;
end.
