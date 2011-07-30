program Annuaire;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm},
  DetailFrm in 'DetailFrm.pas' {DetailForm},
  ListeTiersFrm in 'ListeTiersFrm.pas' {ListeTiersForm},
  NewTiersFrm in 'NewTiersFrm.pas' {NewTiersForm},
  Commun in 'Commun.pas',
  Adapter in 'Adapter.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
{$IF RTLVersion >= 19}
  Application.MainFormOnTaskbar := True;
{$IFEND}
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
