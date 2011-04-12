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
  FormSettings in '..\..\FormSettings.pas' {SettingsForm},
  defs in 'defs.pas',
  common in '..\..\Units\common.pas',
  winVersion in '..\..\Units\winVersion.pas',
  util in '..\..\Units\util.pas';
  
{$R *.res}

begin
  Application.Initialize;
  InitProgram();
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.Run;
end.
