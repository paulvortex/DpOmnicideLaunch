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
  Messages, SysUtils, Graphics, Controls, StdCtrls;

Procedure InitProgram;

var
  ColorNormal: TColor;
  ColorSelected: TColor;
  ColorPressed: TColor;
  GameExe: String;
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
  GameName := 'Blood Omnicide';
  GameCompany := 'Razorwind Games';
  GameExe := 'omnicide';
  ColorNormal := $FFFFFF;
  ColorSelected := $22AAFF;
  ColorPressed := $0000AA;
end;

end.
