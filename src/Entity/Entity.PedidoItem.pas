unit Entity.PedidoItem;

interface

type
  TPedidoItem = class
    private
      fIdPedido: Integer;
      fIdPedidoItem: Integer;
      fIdProduto: Integer;
      fQuantidade: Double;
      fValorVenda: Double;
      fValorTotal: Double;
    public
      property IdPedido: integer read fIdPedido write fIdPedido;
      property IdPedidoItem: integer read fIdPedidoItem write fIdPedidoItem;
      property IdProduto: integer read fIdProduto write fIdProduto;
      property Quantidade: Double read fQuantidade write fQuantidade;
      property ValorVenda: Double read fValorVenda write fValorVenda;
      property ValorTotal: Double read fValorTotal write fValorTotal;
      constructor Create(pIdPedido: integer);
      destructor Destroy; override;

      procedure CalculaTotal;
  end;

implementation

{ TPedidoItem }

procedure TPedidoItem.CalculaTotal; // ver se realmente precis disso !!!
begin
  fValorTotal := fQuantidade * fValorVenda;
end;

constructor TPedidoItem.Create(pIdPedido: integer);
begin
  if pIdPedido <> 0 then
    fIdPedido := pIdPedido
end;

destructor TPedidoItem.Destroy;
begin

  inherited;
end;

end.
