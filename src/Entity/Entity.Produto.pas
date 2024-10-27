unit Entity.Produto;

interface

type
  TProduto = class
    private
      fIdProduto: Integer;
      fDescricao: String;
      fValorVenda: Double;
      fQtdeEstoque: Double;
    public
      property IdProduto: Integer read fIdProduto write fIdProduto;
      property Descricao: String read fDescricao write fDescricao;
      property ValorVenda: Double read fValorVenda write fValorVenda;
      property QtdeEstoque: Double read fQtdeEstoque write fQtdeEstoque;
  end;

implementation

end.
