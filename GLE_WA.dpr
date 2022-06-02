program GLE_WA;

uses
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  UnitVerifikasiAkhir in 'form\UnitVerifikasiAkhir.pas' {frmVerAkhirHasil: TUniForm},
  UnitHasilDetail in 'form\UnitHasilDetail.pas' {frmHasilDetail: TUniForm},
  UnitWaMessages in 'form\UnitWaMessages.pas' {frmWaMessages: TUniForm},
  UnitApiWa in 'units\UnitApiWa.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.
