unit Entity.Pedido;

interface

uses
  System.Generics.Collections,
  Constants,
  Entity.PedidoItem;

type
  TPedido = class
    private
      fIdPedido: Integer;
      fIdUsuario: Integer;
      fIdCliente: Integer;
      fDataPedido: TDate;
      fValorTotalPedido: Double;
      fStatus: TStatusPedido;
      fPedidoItens: TObjectList<TPedidoItem>;
    public
      property IdPedido: integer read fIdPedido write fIdPedido;
      property IdUsuario: integer read fIdUsuario write fIdUsuario;
      property IdCliente: integer read fIdCliente write fIdCliente;
      property DataPedido: TDate read fDataPedido write fDataPedido;
      property ValorTotalPedido: Double read fValorTotalPedido write fValorTotalPedido;

      property PedidoItens: TObjectList<TPedidoItem> read fPedidoItens write fPedidoItens;
      constructor Create(pIdUsuario: Integer);
      destructor Destroy; override;

  end;

implementation

{ TPedido }

constructor TPedido.Create(pIdUsuario: Integer);
begin
  fIdUsuario := pIdUsuario;
  fStatus := spIniciado;
end;

destructor TPedido.Destroy;
begin

  inherited;
end;

end.
