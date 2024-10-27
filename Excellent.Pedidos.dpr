program Excellent.Pedidos;

uses
  Vcl.Forms,
  View.Principal in 'src\View\View.Principal.pas' {frmViewPrincipal},
  Entity.Usuario in 'src\Entity\Entity.Usuario.pas',
  Entity.Produto in 'src\Entity\Entity.Produto.pas',
  Entity.Cliente in 'src\Entity\Entity.Cliente.pas',
  Entity.Pedido in 'src\Entity\Entity.Pedido.pas',
  Entity.PedidoItem in 'src\Entity\Entity.PedidoItem.pas',
  Constants in 'src\Lib\Constants.pas',
  Dao.Base.FB in 'src\Dao\Dao.Base.FB.pas',
  Controller.Usuario in 'src\Controller\Controller.Usuario.pas',
  Dao.Usuario in 'src\Dao\Dao.Usuario.pas',
  View.Login in 'src\View\View.Login.pas' {frmViewLogin},
  Dao.Teste.Conexao.FB in 'src\Dao\Dao.Teste.Conexao.FB.pas' {DataModule1: TDataModule},
  Controller.Cliente in 'src\Controller\Controller.Cliente.pas',
  Dao.Cliente in 'src\Dao\Dao.Cliente.pas',
  Controller.Produto in 'src\Controller\Controller.Produto.pas',
  Dao.Produto in 'src\Dao\Dao.Produto.pas',
  View.Produto in 'src\View\View.Produto.pas' {frmProdutos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmViewPrincipal, frmViewPrincipal);
  //Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmViewLogin, frmViewLogin);
  // força usuario e senha de teste
  if DebugHook = 1 then
  begin
    frmViewLogin.edtUsuario.Text := 'marcel';
    frmViewLogin.edtSenha.Text := '123';
  end;
  frmViewLogin.ShowModal;

  if not frmViewLogin.StatusLogin then
    Application.Terminate;
  Application.CreateForm(TfrmViewPrincipal, frmViewPrincipal);
  Application.Run;
end.
