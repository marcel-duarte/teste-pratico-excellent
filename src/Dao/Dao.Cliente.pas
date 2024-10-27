unit Dao.Cliente;

interface

uses
  System.Generics.Collections,
  SysUtils,
  System.JSON,
  Dao.Base.FB, Entity.Cliente;

type
  TDaoCliente = class
    private
      MyConnection: TMyConnection;
    public
      constructor Create;
      destructor Destroy; override;
      function BuscarCliente(pNome: String; var pErro: string): TObjectList<TCliente>;
  end;

implementation

{ TDaoCliente }

function TDaoCliente.BuscarCliente(pNome: String; var pErro: string): TObjectList<TCliente>;
var
  vSql: string;
  vId: integer;
  vCliente: TCliente;
begin
  try
    vSql := 'SELECT C.IDCLIENTE, C.NOME FROM CLIENTE C WHERE UPPER(C.NOME) LIKE UPPER(:NOME)';
    MyConnection.PrepareStatement(vSql);
    MyConnection.SetValue(0, '%'+pNome+'%');
    MyConnection.Activate;

    if MyConnection.IsEmpty then
    begin
      pErro := 'Cliente não encontrado!';
      MyConnection.Rollback;
      Exit;
    end
    else
    begin
      with MyConnection do
      begin
        Query.First;
        while Query.Eof do
        begin
          vCliente := TCliente.Create;
          vCliente.IdCliente := Query.FieldByName('IDCliente').AsInteger;
          vCliente.Nome := Query.FieldByName('Nome').AsString;
          Result.Add(vCliente);
          Query.Next;
        end;
      end;
    end;
  except
    on e: exception do
      begin
        MyConnection.Rollback;
        pErro := 'Ocorreu algum erro na busca de cliente - Msg:'+e.Message;
      end;
  end;
end;

constructor TDaoCliente.Create;
begin
  //TDataSetSerializeConfig.getInstance.CaseNameDefinition := cndLower;
  //TDataSetSerializeConfig.getInstance.Import.DecimalSeparator := '.';
  MyConnection := TMyConnection.Create;
end;

destructor TDaoCliente.Destroy;
begin
  MyConnection.DisposeOf;
  inherited;
end;

end.
