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
  p := ExtractFilePath(Application.ExeName) + 'mapeditor\gtkradiant.exe';
  if not (FileExists(p)) then
    p := ExtractFilePath(Application.ExeName) + 'mapeditor\radiant.exe';
  if not (FileExists(p)) then begin
      s := ProgramGetString('Generic', '#execerror', 0) + p;
      Application.MessageBox(PAnsiChar(s), ProgramGetStringPAnsiChar('Generic', '#err', 0), 0);
  end else begin
    SetCompatibilityFlag(P, 'DISABLEDWM', DisableAero.Checked);
    if (self.ResetSettings.Checked = true) then
      LaunchGame('mapeditor.cmd', '1')
    else
      LaunchGame('mapeditor.cmd', '');
  end;
end;

procedure TfrmMapeditor.FormActivate(Sender: TObject);
begin
  DisableAero.Checked := GetSettingBool('mapeditorDisableAero', False);
end;

end.
