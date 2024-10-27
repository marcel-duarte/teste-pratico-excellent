unit View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Controller.Usuario;

type
  TfrmViewLogin = class(TForm)
    lblUsuario: TLabel;
    edtUsuario: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    btnLogar: TButton;
    btnSair: TButton;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLogarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fControllerUsuario: TControllerUsuario;
    fStatusLogin: Boolean;
  public
    { Public declarations }
    property StatusLogin: Boolean read fStatusLogin write fStatusLogin;
  end;

var
  frmViewLogin: TfrmViewLogin;

implementation

{$R *.dfm}

procedure TfrmViewLogin.btnLogarClick(Sender: TObject);
var
  vErro: string;
begin
  fStatusLogin := fControllerUsuario.Login(edtUsuario.Text, edtSenha.Text, vErro);
  if not fStatusLogin then
    MessageDlg(vErro, mtError ,[mbOk], 0);
  Close;
end;

procedure TfrmViewLogin.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmViewLogin.FormCreate(Sender: TObject);
begin
  fControllerUsuario := TControllerUsuario.Create;
  fStatusLogin := False;
end;

procedure TfrmViewLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  end;
end;

end.
