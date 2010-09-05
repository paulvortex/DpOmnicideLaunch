{
------------------------
 Darkplaces Launcher
 Property of RazorWind Games
 coded by Pavel P. [VorteX] Timofeyev
 					    email:paul.vortex@gmail.com
------------------------
}

unit util;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, Registry, defs;

{ get a string-value setting }
Function GetSetting(SettingName : String; DefaultValue : String) : String;
{ get an integer setting }
Function GetSettingInt(SettingName : String; DefaultValue : Integer) : Integer;
{ get a boolean setting }
Function GetSettingBool(SettingName : String; DefaultValue : Boolean) : Boolean;
{ set a string-value setting }
Function SetSetting(SettingName : String; NewValue : String) : Boolean;
{ set an integer setting }
Function SetSettingInt(SettingName : String; NewValue : Integer) : Boolean;
{ set a boolean setting }
Function SetSettingBool(SettingName : String; NewValue : Boolean) : Boolean;

var
  SettingStr : String;
  SettingInt : Integer;
  SettingBool : Boolean;

implementation

{
------------------------
 Working with Application Settings
------------------------
}

{ get a base registry path }
Function RegKeyPath() : String;
begin
  if (GameCompany = '') Then
    result := 'Software\' + GameName + '\'
  else
    result := 'Software\' + GameCompany + '\' + GameName + '\';
end;

{ generic get-setting uni-type routine }
Function GetProgramSetting(SettingName : String) : Boolean;
var
  r : TRegistry;
  t : TRegDataType;
begin
  SettingStr := '';
  SettingInt := 0;
  SettingBool := false;
  result := False;
  { read from Registry }
  r := TRegistry.Create();
  try
  r.RootKey := HKEY_CURRENT_USER;
  r.LazyWrite := False;
  if (r.OpenKey(RegKeyPath(), false)) then begin
    if (r.ValueExists(SettingName)) then begin
      t := r.GetDataType(SettingName);
      { read, check for proper type }
      if ((t = rdString) Or (t = rdExpandString)) then begin
        SettingStr := r.ReadString(SettingName);
        SettingInt := 0;
        SettingBool := False;
        result := True;
      end else if (t = rdInteger) then begin
        SettingInt := r.ReadInteger(SettingName);
        SettingStr := IntToStr(SettingInt);
        if (SettingInt = 0) then
          SettingBool := False
        else
          SettingBool := True;
        result := True;
      end;
    end;
    r.CloseKey;
  end;
  except
  r.Destroy;
  end;
  { todo : write INI }
end;

{ get a string-value setting }
Function GetSetting(SettingName : String; DefaultValue : String) : String;
begin
  if (GetProgramSetting(SettingName) = True) Then begin
    result := SettingStr;
  end else begin
    result := DefaultValue;
  end;
End;

{ get an integer setting }
Function GetSettingInt(SettingName : String; DefaultValue : Integer) : Integer;
begin
  if (GetProgramSetting(SettingName) = True) Then begin
    result := SettingInt;
  end else begin
    result := DefaultValue;
  end;
End;

{ get a boolean setting }
Function GetSettingBool(SettingName : String; DefaultValue : Boolean) : Boolean;
begin
  if (GetProgramSetting(SettingName) = True) Then begin
    result := SettingBool;
  end else begin
    result := DefaultValue;
  end;
End;

{ generic set-setting uni-type routine }
Function SetProgramSetting(SettingName : String; NewValue : String; ValueType : Integer) : Boolean;
var
  r : TRegistry;
  t : TRegDataType;
begin
  result := False;
  { write Registry }
  r := TRegistry.Create();
  try
  r.RootKey := HKEY_CURRENT_USER;
  r.LazyWrite := True;
  if (r.OpenKey(RegKeyPath(), true)) then begin
    { if already exists and wrong type - delete, so we dont get wrong type exception }
    if (r.ValueExists(SettingName)) then begin
      t := r.GetDataType(SettingName);
      if (ValueType = 0) Then begin
        if not ((t = rdString) Or (t = rdExpandString)) then
          r.DeleteValue(SettingName);
      end else begin
        if not (t = rdInteger) then
          r.DeleteValue(SettingName);
      end;
    end;
    { write new }
    if (ValueType = 0) Then
      r.WriteString(SettingName, NewValue)
    else if (ValueType = 1) Then
      r.WriteInteger(SettingName, StrToInt(NewValue))
    else if ((NewValue = 'true') Or (NewValue = '1') Or (NewValue = 'on')) Then
      r.WriteBool(SettingName, true)
    else
      r.WriteBool(SettingName, false);
    r.CloseKey;
    result := True;
  end;
  except
  r.Destroy;
  end;
  { todo : write INI }
end;

{ set a string-value setting }
Function SetSetting(SettingName : String; NewValue : String) : Boolean;
begin
  result := SetProgramSetting(SettingName, NewValue, 0);
end;

{ set an integer setting }
Function SetSettingInt(SettingName : String; NewValue : Integer) : Boolean;
begin
  result := SetProgramSetting(SettingName, IntToStr(NewValue), 1);
end;

{ set a boolean setting }
Function SetSettingBool(SettingName : String; NewValue : Boolean) : Boolean;
begin
  if (NewValue = True) then
    result := SetProgramSetting(SettingName, 'true', 2)
  else
    result := SetProgramSetting(SettingName, 'false', 2);
end;

end.
