{
------------------------
 Darkplaces Launcher
 Property of RazorWind Games
 coded by Pavel P. [VorteX] Timofeyev
 					    email:paul.vortex@gmail.com
------------------------
}

unit FormMain;

interface

uses
  Windows,
  Messages,
  Dialogs,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  StdCtrls,
  XPMan,
  common,
  util,
  defs,
  ExtCtrls;

type
  TMainForm = class(TForm)
    bg: TImage;
    XPManifest1: TXPManifest;
    Launch: TLabel;
    Exit: TLabel;
    Settings: TLabel;
    MapEditor: TLabel;
    procedure LaunchMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LaunchMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LaunchMouseEnter(Sender: TObject);
    procedure LaunchMouseLeave(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure ExitMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ExitMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ExitMouseEnter(Sender: TObject);
    procedure ExitMouseLeave(Sender: TObject);
    procedure SettingsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SettingsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SettingsMouseEnter(Sender: TObject);
    procedure SettingsMouseLeave(Sender: TObject);
    procedure SettingsClick(Sender: TObject);
    procedure bgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure LaunchClick(Sender: TObject);
    procedure MapEditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapEditorMouseEnter(Sender: TObject);
    procedure MapEditorMouseLeave(Sender: TObject);
    procedure MapEditorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapEditorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  Drag: Boolean;
  DragX: Integer;
  DragY: Integer;
  Launched: Boolean;

implementation

uses FormSettings, FormMapeditor;

{$R *.dfm}

{ Creating The Form }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  { load strings }
  MainForm.Caption := ProgramGetString('MainForm', '#caption', 0);
  Launch.Font.Color := ColorNormal;
  Launch.Caption := ProgramGetString('MainForm', '#launch', 0);
  Launch.Hint := ProgramGetString('MainForm', '#launch', 1);
  Settings.Font.Color := ColorNormal;
  Settings.Caption := ProgramGetString('MainForm', '#settings', 0);
  Settings.Hint := ProgramGetString('MainForm', '#settings', 1);
  Exit.Font.Color := ColorNormal;
  Exit.Caption := ProgramGetString('MainForm', '#quit', 0);
  Exit.Hint := ProgramGetString('MainForm', '#quit', 1);
  MapEditor.Font.Color := ColorNormal;
  MapEditor.Caption := ProgramGetString('MainForm', '#mapeditor', 0);
  MapEditor.Hint := ProgramGetString('MainForm', '#mapeditor', 1);
  { setup positions }
  if (GameName = 'Steel Storm') then begin
    MainForm.Launch.Left := 23;
    MainForm.Launch.Top := 189;
    MainForm.Launch.Alignment := taLeftJustify;
    MainForm.Settings.Left := 23;
    MainForm.Settings.Top := 250;
    MainForm.Settings.Alignment := taLeftJustify;
    MainForm.Exit.Left := 308;
    MainForm.Exit.Top := 250;
    MainForm.Exit.Alignment := taLeftJustify;
  end;
end;

{ Dragging The Form }

procedure TMainForm.bgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  SC_DragMove = $F012;  { a magic number }
begin
  ReleaseCapture;
  MainForm.Perform(WM_SysCommand, SC_DragMove, 0);
end;

{ Launch Button }

procedure TMainForm.LaunchMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Launch.Font.Color := ColorPressed;
end;

procedure TMainForm.LaunchMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Launch.Font.Color := ColorNormal;
end;

procedure TMainForm.LaunchMouseEnter(Sender: TObject);
begin
  Launch.Font.Color := ColorSelected;
end;

procedure TMainForm.LaunchMouseLeave(Sender: TObject);
begin
  Launch.Font.Color := ColorNormal;
end;

{ Exit Button }

procedure TMainForm.ExitClick(Sender: TObject);
begin
  MainForm.Close
end;

procedure TMainForm.ExitMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Exit.Font.Color := ColorPressed;
end;

procedure TMainForm.ExitMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Exit.Font.Color := ColorNormal;
end;

procedure TMainForm.ExitMouseEnter(Sender: TObject);
begin
  Exit.Font.Color := ColorSelected;
end;

procedure TMainForm.ExitMouseLeave(Sender: TObject);
begin
  Exit.Font.Color := ColorNormal;
end;

{ Settings Button }

procedure TMainForm.SettingsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Settings.Font.Color := ColorPressed;
end;

procedure TMainForm.SettingsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Settings.Font.Color := ColorNormal;
end;

procedure TMainForm.SettingsMouseEnter(Sender: TObject);
begin
  Settings.Font.Color := ColorSelected;
end;

procedure TMainForm.SettingsMouseLeave(Sender: TObject);
begin
  Settings.Font.Color := ColorNormal;
end;

procedure TMainForm.SettingsClick(Sender: TObject);
begin
  SettingsForm.Left := Round(MainForm.Left + (MainForm.Width - SettingsForm.Width)*0.5);
  SettingsForm.Top := Round(MainForm.Top + (MainForm.Height - SettingsForm.Height)*0.5);
  SettingsForm.ShowModal;
end;

procedure TMainForm.LaunchClick(Sender: TObject);
begin
  LaunchGame('', '');
  Application.MainForm.Close();
end;

procedure TMainForm.MapEditorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MapEditor.Font.Color := ColorPressed;
end;

procedure TMainForm.MapEditorMouseEnter(Sender: TObject);
begin
  MapEditor.Font.Color := ColorSelected;
end;

procedure TMainForm.MapEditorMouseLeave(Sender: TObject);
begin
  MapEditor.Font.Color := ColorNormal;
end;

procedure TMainForm.MapEditorMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MapEditor.Font.Color := ColorNormal;
end;

procedure TMainForm.MapEditorClick(Sender: TObject);
begin
  frmMapeditor.Left := Round(self.Left + (self.Width - frmMapeditor.Width)*0.5);
  frmMapeditor.Top := Round(self.Top + (self.Height - frmMapeditor.Height)*0.5);
  frmMapeditor.ShowModal
end;
end.
