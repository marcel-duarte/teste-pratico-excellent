unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, View.Produto;

type
  TfrmViewPrincipal = class(TForm)
    btnPedido: TButton;
    btnSair: TButton;
    btnProduto: TButton;
    procedure btnSairClick(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewPrincipal: TfrmViewPrincipal;

implementation

{$R *.dfm}

procedure TfrmViewPrincipal.btnProdutoClick(Sender: TObject);
var
  frmProduto: TfrmProdutos;
begin
  frmProduto := TfrmProdutos.Create(Self);
  frmProduto.ShowModal;
  frmProduto.Free;
end;

procedure TfrmViewPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.
