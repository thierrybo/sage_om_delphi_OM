{******************************************************************************}
{                                                                              }
{       Copyright (c) 2009 MBG partenaires                                     }
{                                                                              }
{******************************************************************************}

program DemoFraisTransport;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {frmFraisTransport};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'FraisTransport';
  Application.CreateForm(TfrmFraisTransport, frmFraisTransport);
  Application.Run;
end.
