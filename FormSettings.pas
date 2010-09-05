{
------------------------
 Darkplaces Launcher
 Property of RazorWind Games
 coded by Pavel P. [VorteX] Timofeyev
 					    email:paul.vortex@gmail.com
------------------------
}

unit FormSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, ExtCtrls, common, util, defs;

type
  TSettingsForm = class(TForm)
    Reset: TButton;
    Save: TButton;
    XPManifest1: TXPManifest;
    CommandlineGroup: TGroupBox;
    Commandline: TEdit;
    DisableCommandline: TCheckBox;
    EngineGroup: TRadioGroup;
    SafeModeGroup: TGroupBox;
    Bevel1: TBevel;
    noVBO: TCheckBox;
    windowed: TCheckBox;
    procedure SaveClick(Sender: TObject);
    procedure DisableCommandlineClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ResetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}

procedure LoadSettings();
begin
  SettingsForm.EngineGroup.ItemIndex := GetSettingInt('Engine', 0);
  SettingsForm.windowed.Checked := GetSettingBool('windowed', False);
  SettingsForm.noVBO.Checked := GetSettingBool('noVBO', False);
  SettingsForm.Commandline.Text := GetSetting('Commandline', '');
  SettingsForm.DisableCommandline.Checked := GetSettingBool('CommandlineDisable', False);
end;

procedure SaveSettings();
begin
  SetSettingInt('Engine', SettingsForm.EngineGroup.ItemIndex);
  SetSettingBool('windowed', SettingsForm.windowed.Checked);
  SetSettingBool('noVBO', SettingsForm.noVBO.Checked);
  SetSetting('Commandline', SettingsForm.Commandline.Text);
  SetSettingBool('CommandlineDisable', SettingsForm.DisableCommandline.Checked);
end;

procedure ResetSettings();
begin
  SettingsForm.EngineGroup.ItemIndex := 0;
  SettingsForm.windowed.Checked := False;
  SettingsForm.noVBO.Checked := False;
  SettingsForm.Commandline.Text := '';
  SettingsForm.DisableCommandline.Checked := False;
end;

{ Form stuff }

procedure TSettingsForm.SaveClick(Sender: TObject);
begin
  SaveSettings();
  SettingsForm.Close();
end;

procedure TSettingsForm.DisableCommandlineClick(Sender: TObject);
begin
  if (DisableCommandline.Checked = True) Then
  begin
    Commandline.Enabled := False
  end else begin
    Commandline.Enabled := True;
  end
end;

procedure TSettingsForm.FormCreate(Sender: TObject);
begin
  SettingsForm.Caption := ProgramGetString('SettingsForm', '#caption', 0);
  EngineGroup.Caption := ProgramGetString('SettingsForm', '#engine', 0);
  SafeModeGroup.Caption := ProgramGetString('SettingsForm', '#safemode', 0);
  windowed.Caption := ProgramGetString('SettingsForm', '#windowed', 0);
  windowed.Hint := ProgramGetString('SettingsForm', '#windowed', 1);
  noVBO.Caption := ProgramGetString('SettingsForm', '#novbo', 0);
  noVBO.Hint := ProgramGetString('SettingsForm', '#novbo', 1);
  CommandlineGroup.Caption := ProgramGetString('SettingsForm', '#commandline', 0);
  DisableCommandline.Caption := ProgramGetString('SettingsForm', '#disable_commandline', 0);
  DisableCommandline.Hint := ProgramGetString('SettingsForm', '#disable_commandline', 1);
  Reset.Caption := ProgramGetString('SettingsForm', '#reset', 0);
  Reset.Hint := ProgramGetString('SettingsForm', '#reset', 1);
  Save.Caption := ProgramGetString('SettingsForm', '#save', 0);
  Save.Hint := ProgramGetString('SettingsForm', '#save', 1);
end;

procedure TSettingsForm.FormActivate(Sender: TObject);
begin
  LoadSettings();
end;

procedure TSettingsForm.ResetClick(Sender: TObject);
begin
  if (Application.MessageBox(ProgramGetStringPAnsiChar('SettingsForm', '#resetmsg', 0), ProgramGetStringPAnsiChar('SettingsForm', '#resetmsg', 1), MB_YESNO) = ID_YES) Then ResetSettings
end;

end.
