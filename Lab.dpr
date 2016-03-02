program Lab;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Lab_1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLab_1, Lab_1);
  Application.Run;
end.
