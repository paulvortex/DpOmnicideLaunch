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
    SafeModeGroup: TGroupBox;
    Bevel1: TBevel;
    noVBO: TCheckBox;
    windowed: TCheckBox;
    UseLog: TCheckBox;
    Language: TGroupBox;
    LangList: TComboBox;
    NoHome: TCheckBox;
    noThreading: TCheckBox;
    threading: TCheckBox;
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

uses FormMain, FormMapeditor;

{$R *.dfm}

procedure LoadSettings();
var
  i : Integer;
begin
  GetSettingInt('Engine', 0);
  SettingsForm.windowed.Checked := GetSettingBool('windowed', False);
  SettingsForm.noVBO.Checked := GetSettingBool('noVBO', False);
  {
  SettingsForm.noThreading.Checked := GetSettingBool('noThreading', False);
  }
  SettingsForm.threading.Checked := GetSettingBool('threading', False);
  {}
  SettingsForm.NoHome.Checked := GetSettingBool('noHome', False);
  SettingsForm.UseLog.Checked := GetSettingBool('developerMode', False);
  SettingsForm.Commandline.Text := GetSetting('Commandline', '');
  SettingsForm.DisableCommandline.Checked := GetSettingBool('CommandlineDisable', False);
  { load language }
  SettingsForm.LangList.ItemIndex := 0;
  for i := 0 to NumLanguages-1 do
    if (Languages[i] = Language) then
      SettingsForm.LangList.ItemIndex := i;
end;

procedure SaveSettings();
var
  OldLang : String;
begin
  SetSettingInt('Engine', 0);
  SetSettingBool('windowed', SettingsForm.windowed.Checked);
  SetSettingBool('noVBO', SettingsForm.noVBO.Checked);
  {
  SetSettingBool('noThreading', SettingsForm.noThreading.Checked);
  }
  SetSettingBool('threading', SettingsForm.threading.Checked);
  {}
  SetSettingBool('noHome', SettingsForm.NoHome.Checked);
  SetSettingBool('developerMode', SettingsForm.UseLog.Checked);
  SetSetting('Commandline', SettingsForm.Commandline.Text);
  SetSettingBool('CommandlineDisable', SettingsForm.DisableCommandline.Checked);
  SetSetting('LauncherLang', SettingsForm.LangList.Items[SettingsForm.LangList.ItemIndex]);
  { update language }
  OldLang := Language;
  Language := GetSetting('LauncherLang', 'English');
  if (OldLang <> Language) then begin
    MainForm.FormCreate(nil);
    SettingsForm.FormCreate(nil);
    frmMapeditor.FormCreate(nil);
  end;
end;

procedure ResetSettings();
begin
  SettingsForm.windowed.Checked := False;
  SettingsForm.noVBO.Checked := False;
  {
  SettingsForm.noThreading.Checked := False;
  }
  SettingsForm.threading.Checked := False;
  {}
  SettingsForm.UseLog.Checked := False;
  SettingsForm.NoHome.Checked := False;
  SettingsForm.Commandline.Text := '';
  SettingsForm.DisableCommandline.Checked := False;
  SettingsForm.LangList.ItemIndex := 0;
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
var
  s : String;
  i : Integer;
begin
  SettingsForm.Caption := ProgramGetString('SettingsForm', '#caption', 0);
  SafeModeGroup.Caption := ProgramGetString('SettingsForm', '#safemode', 0);
  windowed.Caption := ProgramGetString('SettingsForm', '#windowed', 0);
  windowed.Hint := ProgramGetString('SettingsForm', '#windowed', 1);
  noVBO.Caption := ProgramGetString('SettingsForm', '#novbo', 0);
  noVBO.Hint := ProgramGetString('SettingsForm', '#novbo', 1);
  {
  noThreading.Caption := ProgramGetString('SettingsForm', '#nothreading', 0);
  noThreading.Hint := ProgramGetString('SettingsForm', '#nothreading', 1);
  }
  threading.Caption := ProgramGetString('SettingsForm', '#threading', 0);
  threading.Hint := ProgramGetString('SettingsForm', '#threading', 1);
  {}
  CommandlineGroup.Caption := ProgramGetString('SettingsForm', '#commandline', 0);
  DisableCommandline.Caption := ProgramGetString('SettingsForm', '#disable_commandline', 0);
  DisableCommandline.Hint := ProgramGetString('SettingsForm', '#disable_commandline', 1);
  Reset.Caption := ProgramGetString('SettingsForm', '#reset', 0);
  Reset.Hint := ProgramGetString('SettingsForm', '#reset', 1);
  Save.Caption := ProgramGetString('SettingsForm', '#save', 0);
  Save.Hint := ProgramGetString('SettingsForm', '#save', 1);
  UseLog.Caption := ProgramGetString('SettingsForm', '#uselog', 0);
  UseLog.Hint := ProgramGetString('SettingsForm', '#uselog', 1);
  Language.Caption := ProgramGetString('SettingsForm', '#language', 0);
  Language.Hint := ProgramGetString('SettingsForm', '#language', 1);
  NoHome.Caption := ProgramGetString('SettingsForm', '#nohome', 0);
  NoHome.Hint := ProgramGetString('SettingsForm', '#nohome', 1);
  { set languages }
  s := '';
  for i := 0 to NumLanguages-1 do begin
    if (s <> '') then s := s + ';';
    s := s + Languages[i];
  end;
  LangList.Items.Delimiter := ';';
  LangList.Items.DelimitedText := s;
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
