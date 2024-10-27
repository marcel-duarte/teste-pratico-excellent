unit Dao.Usuario;

interface

uses
  System.Generics.Collections,
  SysUtils,
  System.JSON,
  Dao.Base.FB;

type
  TDaoUsuario = class
    private
      MyConnection: TMyConnection;
    public
      constructor Create;
      destructor Destroy; override;
      function Login(pUsuario, pSenha: string; var pErro: String): Boolean;
  end;

implementation

{ TDaoUsuario }

constructor TDaoUsuario.Create;
begin
  //TDataSetSerializeConfig.getInstance.CaseNameDefinition := cndLower;
  //TDataSetSerializeConfig.getInstance.Import.DecimalSeparator := '.';
  MyConnection := TMyConnection.Create;
end;

destructor TDaoUsuario.Destroy;
begin
  MyConnection.DisposeOf;
  inherited;
end;

function TDaoUsuario.Login(pUsuario, pSenha: string; var pErro: String): Boolean;
var
  vSql: string;
  vId: integer;
begin
  try
    Result := False;
    vSql := 'select idusuario, nome, senha from usuario where nome = :nome';
    MyConnection.PrepareStatement(vSql);
    MyConnection.SetValue(0, pUsuario);
    MyConnection.Activate;

    if MyConnection.IsEmpty then
    begin
      pErro := 'Usuario não encontrado!';
      MyConnection.Rollback;
      Exit;
    end
    else
    begin
      if MyConnection.Query.FieldByName('senha').AsString = pSenha then
        Result := True
      else
        pErro := 'Senha incorreta!';
      end;
  except
    on e: exception do
      begin
        MyConnection.Rollback;
        pErro := 'Ocorreu algum erro no login - Msg:'+e.Message;
      end;
  end;
end;

end.
