unit Controller.Produto;

interface

uses
  System.Generics.Collections,
  Dao.Produto,
  Entity.Produto;

type
  TControllerProduto = class
    private
      fDaoProduto: TDaoProduto;
    public
      //property DaoCliente: TDaoProduto read fDaoProduto write fDaoProduto;

      constructor Create;
      destructor Destroy; override;
      //function Login(pUsuario, pSenha: string; var pErro: string): Boolean;
      function BuscarProduto(pNome: String; var pErro: string): TObjectList<TProduto>; overload;
      function BuscarProduto(pIdProduto: Integer; var pErro: string): TProduto; overload;
      function IncluirProduto(pProduto: TProduto; var pErro: string): Boolean;
      function AlterarProduto(pProduto: TProduto; var pErro: string): Boolean;
      function ExcluirProduto(pIdProduto: Integer; var pErro: string): Boolean;
  end;

implementation

{ TControllerProduto }

function TControllerProduto.AlterarProduto(pProduto: TProduto;
  var pErro: string): Boolean;
begin
  Result := fDaoProduto.AlterarProduto(pProduto, pErro);
end;

function TControllerProduto.BuscarProduto(pNome: String;
  var pErro: string): TObjectList<TProduto>;
begin
  Result := fDaoProduto.BuscarProduto(pNome, pErro);
end;

function TControllerProduto.BuscarProduto(pIdProduto: Integer;
  var pErro: string): TProduto;
begin
  Result := fDaoProduto.BuscarProduto(pIdProduto, pErro);
end;

constructor TControllerProduto.Create;
begin
  fDaoProduto := TDaoProduto.Create;
end;

destructor TControllerProduto.Destroy;
begin
  fDaoProduto.DisposeOf;
  inherited;
end;

function TControllerProduto.ExcluirProduto(pIdProduto: Integer;
  var pErro: string): Boolean;
begin
  Result := fDaoProduto.ExcluirProduto(pIdProduto, pErro);
end;

function TControllerProduto.IncluirProduto(pProduto: TProduto;
  var pErro: string): Boolean;
begin
  Result := fDaoProduto.IncluirProduto(pProduto, pErro);
end;

//function TControllerProduto.Login(pUsuario, pSenha: String; var pErro: String): Boolean;
//begin
//  Result := fDaoProduto.Login(pUsuario, pSenha, pErro);
//end;

end.
