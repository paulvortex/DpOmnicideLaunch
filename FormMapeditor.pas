unit FormMapeditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, common, util, defs;

type
  TfrmMapeditor = class(TForm)
    Launch: TButton;
    ResetSettings: TCheckBox;
    Image1: TImage;
    DisableAero: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure LaunchClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMapeditor: TfrmMapeditor;

implementation

{$R *.dfm}

function LoadLauncherPref(FilePath : string) : Boolean;
var
  f : TextFile;
  s : string;

begin
  result := True;
  try
  AssignFile(f, FilePath);
  {$I-}
  Reset(f);
  {$I+}
  if (IOResult <> 0) then begin
    result := False;
  end else begin
    { чтение версии }
    ReadLn(f, s);
    if (s <> '1') then result := False;
    { чтение остальных параметров }
    CloseFile(f);
  end;
  except
  result := False;
  Application.MessageBox('Failed to read launcher.pref because of file I/O runtime error', 'Error!');
  end;
end;


function CreateGlobalPref(FilePath : string) : Boolean;
var
  f : TextFile;
begin
  result := True;
  try
  AssignFile(f, FilePath);
  {$I-}
  Rewrite(f);
  {$I+}
  if (IOResult <> 0) then begin
    result := False;
    Application.MessageBox('Failed to create global.pref: cannot create file!', 'Error!');
  end else begin
    { запись файла }
    WriteLn(f, '<?xml version="1.0"?>');
    WriteLn(f, '<qpref version="1.0">');
    WriteLn(f, '<epair name="gamePrompt">false</epair>');
    WriteLn(f, '<epair name="gamefile">kain.game</epair>');
    WriteLn(f, '<epair name="log console">true</epair>');
    WriteLn(f, '</qpref>');
    CloseFile(f);
  end;
  except
  result := False;
  Application.MessageBox('Failed to create global.pref because of file I/O runtime error', 'Error!');
  end;
end;

function CreateLocalPref(FilePath : string) : Boolean;
var
  f : TextFile;
  enginePath: string;
  i : integer;
begin
  result := True;
  try
  AssignFile(f, FilePath);
  {$I-}
  Rewrite(f);
  {$I+}
  if (IOResult <> 0) then begin
    result := False;
    Application.MessageBox('Failed to create local.pref: cannot create file!', 'Error!');
  end else begin
    { запись файла }
    enginePath := ExtractFilePath(Application.ExeName);
    for I := 1 TO Length(enginePath) do begin
      if (enginePath[i] = '\') then
        enginePath[i] := '/';
    end;
    WriteLn(f, '<?xml version="1.0"?>');
    WriteLn(f, '<qpref version="1.0">');
    WriteLn(f, '<epair name="AlternativeTextureProjection">false</epair>');
    WriteLn(f, '<epair name="AngleSpeed">3</epair>');
    WriteLn(f, '<epair name="Autosave">true</epair>');
    WriteLn(f, '<epair name="AutosaveMinutes">2</epair>');
    WriteLn(f, '<epair name="BrushAlwaysCaulk">true</epair>');
    WriteLn(f, '<epair name="BrushSnapPlanes">false</epair>');
    WriteLn(f, '<epair name="CamDiscrete">true</epair>');
    WriteLn(f, '<epair name="CamHeight">362</epair>');
    WriteLn(f, '<epair name="CamInverseMouse">false</epair>');
    WriteLn(f, '<epair name="CamLinkSpeed">true</epair>');
    WriteLn(f, '<epair name="CamWidth">200</epair>');
    WriteLn(f, '<epair name="CamWnd">30 154 400 300</epair>');
    WriteLn(f, '<epair name="CamXYUpdate">true</epair>');
    WriteLn(f, '<epair name="CameraRenderMode">2</epair>');
    WriteLn(f, '<epair name="ChaseMouse">true</epair>');
    WriteLn(f, '<epair name="ClipCaulk">true</epair>');
    WriteLn(f, '<epair name="Count">1</epair>');
    WriteLn(f, '<epair name="CubicClipping">false</epair>');
    WriteLn(f, '<epair name="CubicScale">13</epair>');
    WriteLn(f, '<epair name="DetachableMenus">false</epair>');
    WriteLn(f, '<epair name="EmbedEntityInspector">false</epair>');
    WriteLn(f, '<epair name="EmbedEntityInspectorAlign">1</epair>');
    WriteLn(f, '<epair name="EmbedEntityInspectorTextureBrowser">true</epair>');
    WriteLn(f, '<epair name="EmbedPaneWidth">247</epair>');
    WriteLn(f, '<epair name="EnginePath">' + enginePath + '</epair>');
    WriteLn(f, '<epair name="EntityInfoDlg">50 25 400 300</epair>');
    WriteLn(f, '<epair name="EntitySplit1">133</epair>');
    WriteLn(f, '<epair name="EntitySplit2">22</epair>');
    WriteLn(f, '<epair name="EntitySplit3">225</epair>');
    WriteLn(f, '<epair name="EntityWnd">113 141 462 611</epair>');
    WriteLn(f, '<epair name="File0">' + enginePath + 'kain/maps/w1m1-cemetery.map</epair>');
    WriteLn(f, '<epair name="File1">' + enginePath + 'kain/maps/w1m2-ziegsturhl.map</epair>');
    WriteLn(f, '<epair name="File2">' + enginePath + 'kain/maps/w1m1-cemetery-mausoleum.map</epair>');
    WriteLn(f, '<epair name="File3">' + enginePath + 'kain/maps/w1m1-cemetery-crypt.map</epair>');
    WriteLn(f, '<epair name="FilterNotex">true</epair>');
    WriteLn(f, '<epair name="FixedSize">true</epair>');
    WriteLn(f, '<epair name="FixedSizePixels">96</epair>');
    WriteLn(f, '<epair name="GameMode"></epair>');
    WriteLn(f, '<epair name="GameName">kain</epair>');
    WriteLn(f, '<epair name="GridDefault">6</epair>');
    WriteLn(f, '<epair name="Height">844</epair>');
    WriteLn(f, '<epair name="LastLightIntensity">200</epair>');
    WriteLn(f, '<epair name="LastMap">' + enginePath + 'kain/maps/w1m1-cemetery.map</epair>');
    WriteLn(f, '<epair name="LeakStop">true</epair>');
    WriteLn(f, '<epair name="LightRadiuses">true</epair>');
    WriteLn(f, '<epair name="LoadLastMap">true</epair>');
    WriteLn(f, '<epair name="LoadShaders">0</epair>');
    WriteLn(f, '<epair name="MapInfoDlg">50 25 400 300</epair>');
    WriteLn(f, '<epair name="MouseButtons">1</epair>');
    WriteLn(f, '<epair name="MoveSpeed">100</epair>');
    WriteLn(f, '<epair name="NewLightStyle">true</epair>');
    WriteLn(f, '<epair name="NewRightClick">true</epair>');
    WriteLn(f, '<epair name="NoStipple">true</epair>');
    WriteLn(f, '<epair name="NoSysMenuPopups">false</epair>');
    WriteLn(f, '<epair name="PatchToolBar">true</epair>');
    WriteLn(f, '<epair name="PatchWnd">127 142 472 300</epair>');
    WriteLn(f, '<epair name="PluginToolBar">true</epair>');
    WriteLn(f, '<epair name="PositionX">0</epair>');
    WriteLn(f, '<epair name="PositionY">26</epair>');
    WriteLn(f, '<epair name="QE4StyleWindows">0</epair>');
    WriteLn(f, '<epair name="RunQuake2Run">false</epair>');
    WriteLn(f, '<epair name="SI_AxisColors0">1 0 0</epair>');
    WriteLn(f, '<epair name="SI_AxisColors1">0 1 0</epair>');
    WriteLn(f, '<epair name="SI_AxisColors2">0 0 1</epair>');
    WriteLn(f, '<epair name="SI_Colors0">0.25 0.25 0.25</epair>');
    WriteLn(f, '<epair name="SI_Colors1">0.77 0.77 0.77</epair>');
    WriteLn(f, '<epair name="SI_Colors10">0 0 1</epair>');
    WriteLn(f, '<epair name="SI_Colors11">0.5 0 0.75</epair>');
    WriteLn(f, '<epair name="SI_Colors12">1 0 0</epair>');
    WriteLn(f, '<epair name="SI_Colors13">0 0 0</epair>');
    WriteLn(f, '<epair name="SI_Colors14">0 0 0</epair>');
    WriteLn(f, '<epair name="SI_Colors2">0.83 0.83 0.83</epair>');
    WriteLn(f, '<epair name="SI_Colors3">0.89 0.89 0.89</epair>');
    WriteLn(f, '<epair name="SI_Colors4">0.25 0.25 0.25</epair>');
    WriteLn(f, '<epair name="SI_Colors5">0 0 0</epair>');
    WriteLn(f, '<epair name="SI_Colors6">1 1 1</epair>');
    WriteLn(f, '<epair name="SI_Colors7">0 0 0</epair>');
    WriteLn(f, '<epair name="SI_Colors8">0 0 0</epair>');
    WriteLn(f, '<epair name="SI_Colors9">1 0 0</epair>');
    WriteLn(f, '<epair name="SI_Exclude">1024</epair>');
    WriteLn(f, '<epair name="SI_Gamma">0.7</epair>');
    WriteLn(f, '<epair name="SI_PatchTexdef_Rotate">45</epair>');
    WriteLn(f, '<epair name="SI_PatchTexdef_Scale1">0.1</epair>');
    WriteLn(f, '<epair name="SI_PatchTexdef_Scale2">0.9</epair>');
    WriteLn(f, '<epair name="SI_PatchTexdef_Shift1">1</epair>');
    WriteLn(f, '<epair name="SI_PatchTexdef_Shift2">1</epair>');
    WriteLn(f, '<epair name="SI_ShowAngles">true</epair>');
    WriteLn(f, '<epair name="SI_ShowAxis">true</epair>');
    WriteLn(f, '<epair name="SI_ShowCoords">true</epair>');
    WriteLn(f, '<epair name="SI_ShowNames">false</epair>');
    WriteLn(f, '<epair name="SI_ShowOutlines">false</epair>');
    WriteLn(f, '<epair name="SI_SurfaceTexdef_Rotate">1</epair>');
    WriteLn(f, '<epair name="SI_SurfaceTexdef_Scale1">0.1</epair>');
    WriteLn(f, '<epair name="SI_SurfaceTexdef_Scale2">0.1</epair>');
    WriteLn(f, '<epair name="SI_SurfaceTexdef_Shift1">1</epair>');
    WriteLn(f, '<epair name="SI_SurfaceTexdef_Shift2">1</epair>');
    WriteLn(f, '<epair name="ShowShaderlistOnly">true</epair>');
    WriteLn(f, '<epair name="ShowShaders">true</epair>');
    WriteLn(f, '<epair name="ShowStats">true</epair>');
    WriteLn(f, '<epair name="ShowTextureNames">true</epair>');
    WriteLn(f, '<epair name="ShowWorkzone">false</epair>');
    WriteLn(f, '<epair name="SizePainting">false</epair>');
    WriteLn(f, '<epair name="SleepMode">true</epair>');
    WriteLn(f, '<epair name="SnapTToGrid">false</epair>');
    WriteLn(f, '<epair name="Snapshots">false</epair>');
    WriteLn(f, '<epair name="StartOnPrimMon">false</epair>');
    WriteLn(f, '<epair name="State">4</epair>');
    WriteLn(f, '<epair name="Subdivisions">1</epair>');
    WriteLn(f, '<epair name="SurfaceWnd">314 140 287 294</epair>');
    WriteLn(f, '<epair name="TexdefDefaultScale">1</epair>');
    WriteLn(f, '<epair name="TextureCompressionFormat">0</epair>');
    WriteLn(f, '<epair name="TextureFiltering">5</epair>');
    WriteLn(f, '<epair name="TextureLock">true</epair>');
    WriteLn(f, '<epair name="TextureQuality">3</epair>');
    WriteLn(f, '<epair name="TextureScale">50</epair>');
    WriteLn(f, '<epair name="TextureScrollbar">true</epair>');
    WriteLn(f, '<epair name="TextureThumbnailBorderSize">2</epair>');
    WriteLn(f, '<epair name="UndoLevels">999</epair>');
    WriteLn(f, '<epair name="UseCustomShaderEditor">true</epair>');
    WriteLn(f, '<epair name="WatchBSP">true</epair>');
    WriteLn(f, '<epair name="WheelMouseInc">128</epair>');
    WriteLn(f, '<epair name="Width">875</epair>');
    WriteLn(f, '<epair name="XYHeight">764</epair>');
    WriteLn(f, '<epair name="XYWidth">809</epair>');
    WriteLn(f, '<epair name="XYWnd">271 251 400 300</epair>');
    WriteLn(f, '<epair name="XZVIS">false</epair>');
    WriteLn(f, '<epair name="XZWnd">50 25 400 300</epair>');
    WriteLn(f, '<epair name="YZVIS">false</epair>');
    WriteLn(f, '<epair name="YZWnd">50 25 400 300</epair>');
    WriteLn(f, '</qpref>');
    CloseFile(f);
  end;
  except
  result := False;
  Application.MessageBox('Failed to create local.pref because of file I/O runtime error', 'Error!');
  end;
end;

function CreateLauncherPref(FilePath : string) : Boolean;
var
  f : TextFile;
begin
  result := True;
  try
  AssignFile(f, FilePath);
  {$I-}
  Rewrite(f);
  {$I+}
  if (IOResult <> 0) then begin
    result := False;
    Application.MessageBox('Failed to create launcher.pref: cannot create file!', 'Error!');
  end else begin
    { запись файла }
    WriteLn(f, '1');
    CloseFile(f);
  end;
  except
  result := False;
  Application.MessageBox('Failed to create launcher.pref because of file I/O runtime error', 'Error!');
  end;
end;

procedure ResetMapeditorSettings();
var
  p : string;
  needReset : Boolean;
begin
  p := ExtractFilePath(Application.ExeName) + 'mapeditor';

  { check if we need reset }
  needReset := False;
  if (frmMapeditor.ResetSettings.Checked = true) then needReset := true;
  if (LoadLauncherPref(p + '\settings\launcher.pref') = False) then needReset := true;

  { check paths }
  if not (DirectoryExists(p + '\settings')) then begin
    CreateDir(p + '\settings');
    needReset := True;
  end;
  if not (DirectoryExists(p + '\settings\1.5.0')) then begin
    CreateDir(p + '\settings\1.5.0');
    needReset := True;
  end;
  if not (DirectoryExists(p + '\settings\1.5.0\kain.game')) then begin
    CreateDir(p + '\settings\1.5.0\kain.game');
    needReset := True;
  end;

  { reset }
  if (needReset) then begin
    CreateGlobalPref(p + '\settings\1.5.0\global.pref');
    CreateLocalPref(p + '\settings\1.5.0\kain.game\local.pref');
    CreateLauncherPref(p + '\settings\launcher.pref');
  end;
end;

procedure TfrmMapeditor.FormCreate(Sender: TObject);
begin
  self.Caption := ProgramGetString('MapeditorForm', '#caption', 0);
  ResetSettings.Caption := ProgramGetString('MapeditorForm', '#reset', 0);
  ResetSettings.Hint := ProgramGetString('MapeditorForm', '#reset', 1);
  DisableAero.Caption := ProgramGetString('MapeditorForm', '#disable_aero', 0);
  DisableAero.Hint := ProgramGetString('MapeditorForm', '#disable_aero', 1);
  Launch.Caption := ProgramGetString('MapeditorForm', '#launch', 0);
  Launch.Hint := ProgramGetString('MapeditorForm', '#launch', 1);
end;

procedure TfrmMapeditor.LaunchClick(Sender: TObject);
var
  p : string;
  s : string;
begin
  SetSettingBool('mapeditorDisableAero', frmMapeditor.DisableAero.Checked);
  { fidn radiant executable }
  p := ExtractFilePath(Application.ExeName) + 'mapeditor\gtkradiant.exe';
  if not (FileExists(p)) then
    p := ExtractFilePath(Application.ExeName) + 'mapeditor\radiant.exe';
  if not (FileExists(p)) then begin
      s := ProgramGetString('Generic', '#execerror', 0) + p;
      Application.MessageBox(PAnsiChar(s), ProgramGetStringPAnsiChar('Generic', '#err', 0), 0);
  end else begin
    { set compatibility flags }
    SetCompatibilityFlag(P, 'DISABLEDWM', DisableAero.Checked);
    { reset settings if required }
    ResetMapeditorSettings();
    { launch }
    LaunchGame(p, '');
  end;
end;

procedure TfrmMapeditor.FormActivate(Sender: TObject);
begin
  DisableAero.Checked := GetSettingBool('mapeditorDisableAero', False);
end;

end.
