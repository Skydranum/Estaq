program EstaqNetImportador;

uses
  Forms,
  uEtapa1 in 'uEtapa1.pas' {frmEtapa1},
  uDM in 'uDM.pas' {dm1: TDataModule},
  uSplash in 'uSplash.pas' {frmSplash};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'EstaqNETImportador';
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmEtapa1, frmEtapa1);
  Application.CreateForm(Tdm1, dm1);
  Application.Run;
end.
