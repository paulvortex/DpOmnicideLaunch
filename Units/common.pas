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
  StdCtrls, ShellApi, util, defs;

Function ProgramGetString(FormName : String; ControlName : String; C : Integer) : String;
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

Function ProgramGetString(FormName : String; ControlName : String; C : Integer) : String;
begin
  if (FormName = 'Generic') then begin
    if (ControlName = '#execerror') then begin
      result := 'Failed execute game, perharps file not found!' + chr(13) + chr(10) + 'commandline was: ' + chr(13) + chr(10);
    end else if (ControlName = '#err') then begin
      result := 'Oops..';
    end;
  end else if (FormName = 'MainForm') then begin
    if (ControlName = '#caption') then begin
      result := Application.Title;
    end else if (ControlName = '#launch') then begin
      if (c = 0) then result := 'Launch game!'
      else result := '';
    end else if (ControlName = '#settings') then begin
      if (c = 0) then result := 'Settings'
      else result := '';
    end else if (ControlName = '#quit') then begin
      if (c = 0) then result := 'Quit'
      else result := '';
    end;
  end else if (FormName = 'SettingsForm') then begin
    if (ControlName = '#caption') then begin
      result := 'Launch settings';
    end else if (ControlName = '#resetmsg') then begin
      if (c = 0) then result := 'Reset all settings to default values?'
      else result := 'Reset to Defaults';
    end else if (ControlName = '#engine') then begin
      result := ' Engine ';
    end else if (ControlName = '#safemode') then begin
      result := ' Safe mode ';
    end else if (ControlName = '#commandline') then begin
      result := ' Additional commandline parms ';
    end else if (ControlName = '#windowed') then begin
      if (c = 0) then result := 'Windowed'
      else result := 'Run game in windowed state instead of fullscreen.';
    end else if (ControlName = '#novbo') then begin
      if (c = 0) then result := 'Disable VBO'
      else result := 'Disable Vertex Buffer Objects feature if you have weird triangles showing during gameplay.';
    end else if (ControlName = '#disable_commandline') then begin
      if (c = 0) then result := 'Disable commandline'
      else result := 'This will disable additional commandline even if it has some text in it.';
    end else if (ControlName = '#reset') then begin
      if (c = 0) then result := 'Reset to defaults'
      else result := 'Reset all settings to default values.';
    end else if (ControlName = '#save') then begin
      if (c = 0) then result := 'Save'
      else result := 'Save settings.';
    end;
  end;
end;
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
begin
  if (GetSettingInt('Engine', 0) = 1) Then
    result := GameExe + '-d3d.exe'
  else
    result := GameExe + '.exe';
end;
Function LaunchGameParms() : String;
begin
  result := '';
  if (GetSettingBool('CommandlineDisable', False) = True) Then
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

