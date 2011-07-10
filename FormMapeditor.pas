unit FormMapeditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, common, defs;

type
  TfrmMapeditor = class(TForm)
    Launch: TButton;
    ResetSettings: TCheckBox;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure LaunchClick(Sender: TObject);
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
  Launch.Caption := ProgramGetString('MapeditorForm', '#launch', 0);
  Launch.Hint := ProgramGetString('MapeditorForm', '#launch', 1);
end;

procedure TfrmMapeditor.LaunchClick(Sender: TObject);
begin
  if (self.ResetSettings.Checked = true) then
    LaunchGame('mapeditor.cmd', '1')
  else
    LaunchGame('mapeditor.cmd', '');
end;

end.
