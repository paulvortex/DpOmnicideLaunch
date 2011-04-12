{
------------------------
 Darkplaces Launcher
 Property of RazorWind Games
 coded by Pavel P. [VorteX] Timofeyev
 					    email:paul.vortex@gmail.com
------------------------
}

unit common;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, ShellApi, util, defs, winVersion;

Function ProgramGetStringPAnsiChar(FormName : String; ControlName : String; C : Integer) : PAnsiChar;
Function LaunchGameString : String;
Function LaunchGame : String;

implementation

{
------------------------
 Program strings function
 with languages we support (currently none of them)
------------------------
}

Function ProgramGetStringPAnsiChar(FormName : String; ControlName : String; C : Integer) : PAnsiChar;
var
  s : string;
begin
  s := ProgramGetString(FormName, ControlName, c);
  result := PAnsiChar(s);
end;

{
------------------------
 Game Launch routines
 this builds launch string based on options
 be sure that defaults are same as you have in SettingsForm!
 todo: make generic setting struct in future
------------------------
}

Function LaunchGameString() : String;
var
  s : String;
  OS : TOSInfo;
begin
  result := GameExe + '.exe';
  if (GameParms <> '') then
	  result := result + GameParms;
  { special exe for 64 bit OS }
  Os := TOSInfo.Create();
  if (Os.IsWow64 = true) then begin
    s := GameExe + '64.exe';
    if (FileExists(s)) then result := s;
  end;
  OS.Destroy();
end;
Function LaunchGameParms() : String;
begin
  result := '';
  if (GetSettingBool('CommandlineDisable', False) = False) Then
    result := result + GetSetting('Commandline', '') + ' ';
  if (GetSettingBool('noVBO', False) = True) Then
    result := result + '-novbo ';
  if (GetSettingBool('windowed', False) = True) Then
    result := result + '-window ';
end;
Function LaunchGame() : String;
var
  f : PAnsiChar;
  c : PAnsiChar;
  m : PAnsiChar;
  s : String;
begin
  try
    if not (FileExists(LaunchGameString())) then begin
      s := ProgramGetString('Generic', '#execerror', 0) + LaunchGameString() + ' ' + LaunchGameParms();
      m := PAnsiChar(s);
      Application.MessageBox(m, ProgramGetStringPAnsiChar('Generic', '#err', 0), 0);
    end else begin
      f := PAnsiChar(LaunchGameString());
      c := PAnsiChar(LaunchGameParms());
      Application.MainForm.Close();
      ShellExecute(0, nil, f, c, nil, SW_SHOWNORMAL);
    end;
  except
    s := ProgramGetString('Generic', '#execerror', 0) + chr(13) + chr(10) + ' ' + chr(13) + chr(10) + LaunchGameString() + ' ' + LaunchGameParms();
    m := PAnsiChar(s);
    Application.MessageBox(m, ProgramGetStringPAnsiChar('Generic', '#err', 0), 0);
  end;
end;


end.

