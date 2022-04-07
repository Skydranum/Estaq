unit uSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, acPNG, ExtCtrls;

type
  TfrmSplash = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

uses uEtapa1;
{$R *.dfm}

procedure TfrmSplash.BitBtn1Click(Sender: TObject);
begin

 if not assigned(FrmEtapa1) then
                 FrmEtapa1:=TFrmEtapa1.Create(Application);
                 FrmEtapa1.ShowModal;
                 FreeAndNil(FrmEtapa1);
 FrmSplash.Close;
end;

end.
