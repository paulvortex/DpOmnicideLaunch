{
------------------------
 Darkplaces Launcher
 Property of RazorWind Games
 coded by Pavel P. [VorteX] Timofeyev
 					    email:paul.vortex@gmail.com
------------------------
}

unit defs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, ShellApi;

Procedure InitProgram;
Function ProgramGetString(FormName : String; ControlName : String; C : Integer) : String;

var
  ColorNormal: TColor;
  ColorSelected: TColor;
  ColorPressed: TColor;
  GameExe: String;
  GameParms : String;
  GameName: String;
  GameCompany: String;

implementation

{
------------------------
 Program Initialization
------------------------
}

procedure InitProgram();
begin
  GameName := 'Arcade Quake';
  GameCompany := 'Razorwind Games';
  GameExe := 'darkplaces';
  GameParms := ' -game aq';
  ColorNormal := $FFFFFF;
  ColorSelected := $22AAFF;
  ColorPressed := $0000AA;
  Application.Title := GameName;
end;

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
      result := GameName;
    end else if (ControlName = '#launch') then begin
      if (c = 0) then result := 'Launch!'
      else result := '';
    end else if (ControlName = '#settings') then begin
      if (c = 0) then result := 'Setup'
      else result := '';
    end else if (ControlName = '#quit') then begin
      if (c = 0) then result := 'X'
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

end.
