unit Controller.Cliente;

interface

uses
  System.Generics.Collections,
  Dao.Cliente,
  Entity.Cliente;

type
  TControllerCliente = class
    private
      fDaoCliente: TDaoCliente;
    public
      //property DaoCliente: TDaoCliente read fDaoCliente write fDaoCliente;

      constructor Create;
      destructor Destroy; override;
      //function Login(pUsuario, pSenha: string; var pErro: string): Boolean;
      function BuscarCliente(pNome: String; var pErro: string): TObjectList<TCliente>;
  end;

implementation

{ TControllerCliente }

function TControllerCliente.BuscarCliente(pNome: String;
  var pErro: string): TObjectList<TCliente>;
begin
  Result := fDaoCliente.BuscarCliente(pNome, pErro);
end;

constructor TControllerCliente.Create;
begin
  fDaoCliente := TDaoCliente.Create;
end;

destructor TControllerCliente.Destroy;
begin
  fDaoCliente.DisposeOf;
  inherited;
end;

//function TControllerCliente.Login(pUsuario, pSenha: String; var pErro: String): Boolean;
//begin
//  Result := fDaoCliente.Login(pUsuario, pSenha, pErro);
//end;

end.
