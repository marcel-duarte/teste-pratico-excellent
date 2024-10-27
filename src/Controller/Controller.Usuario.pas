unit Controller.Usuario;

interface

uses Dao.Usuario;

type
  TControllerUsuario = class
    private
      fDaoUsuario: TDaoUsuario;
    public
      property DaoUsuario: TDaoUsuario read fDaoUsuario write fDaoUsuario;

      constructor Create;
      destructor Destroy; override;
      function Login(pUsuario, pSenha: string; var pErro: string): Boolean;
  end;

implementation

{ TControllerUsuario }

constructor TControllerUsuario.Create;
begin
  fDaoUsuario := TDaoUsuario.Create;
end;

destructor TControllerUsuario.Destroy;
begin
  fDaoUsuario.DisposeOf;
  inherited;
end;

function TControllerUsuario.Login(pUsuario, pSenha: String; var pErro: String): Boolean;
begin
  Result := fDaoUsuario.Login(pUsuario, pSenha, pErro);
end;

end.
