unit Dao.Produto;

interface

uses
  System.Generics.Collections,
  System.StrUtils,
  SysUtils,
  System.JSON,
  Dao.Base.FB,
  Entity.Produto, Constants;

type
  TDaoProduto = class
    private
      MyConnection: TMyConnection;
    public
      constructor Create;
      destructor Destroy; override;
      function BuscarProduto(pDescricao: String; var pErro: string): TObjectList<TProduto>; overload;
      function BuscarProduto(pIdProduto: Integer; var pErro: string): TProduto; overload;
      function MovimentaEstoque(pIdProduto: Integer; pQtdeMovimentada: Double; pAcao: TTipoAcaoEstoque;
        var pErro: string): TObjectList<TProduto>;
      function IncluirProduto(pProduto: TProduto; var pErro: string): Boolean;
      function AlterarProduto(pProduto: TProduto; var pErro: string): Boolean;
      function ExcluirProduto(pIdProduto: Integer; var pErro: string): Boolean;

  end;

implementation

{ TDaoProduto }

function TDaoProduto.AlterarProduto(pProduto: TProduto;
  var pErro: string): Boolean;
var
  vSql: string;
  vId: integer;
  vProduto: TProduto;
begin
  Result := False;
  try
    vSql := ' UPDATE PRODUTO SET DESCRICAO = :DESCRICAO, VALORVENDA = :VALORVENDA, '+
            ' QTDEESTOQUE = :QTDMOVIMENTADA WHERE IDPRODUTO = :IDPRODUTO ';
    MyConnection.PrepareStatement(vSql);
    MyConnection.SetValue(0, pProduto.Descricao);
    MyConnection.SetValue(1, pProduto.ValorVenda);
    MyConnection.SetValue(2, pProduto.QtdeEstoque);
    MyConnection.SetValue(3, pProduto.IdProduto);
    MyConnection.ExecSQL;
    Result := True;
  except
    on e: exception do
      begin
        MyConnection.Rollback;
        pErro := 'Ocorreu algum erro na alteração do produto - Msg:'+e.Message;
      end;
  end;
end;

function TDaoProduto.BuscarProduto(pDescricao: String; var pErro: string): TObjectList<TProduto>;
var
  vSql: string;
  vId: integer;
  vProduto: TProduto;
begin
  try
    vSql := 'SELECT P.IDPRODUTO, P.DESCRICAO, P.VALORVENDA, P.QTDEESTOQUE '+
            'FROM PRODUTO P '+
            ifthen(pDescricao <> EmptyStr,'WHERE UPPER(P.DESCRICAO) LIKE UPPER(:DESCRICAO)','');
    MyConnection.PrepareStatement(vSql);
    MyConnection.SetValue(0, '%'+pDescricao+'%');
    MyConnection.Activate;

    if (MyConnection.IsEmpty) and (pDescricao <> EmptyStr) then
    begin
      pErro := 'Nenhum produto não encontrado!';
      MyConnection.Rollback;
      Exit;
    end
    else
    begin
      with MyConnection do
      begin
        Result := TObjectList<TProduto>.Create;
        Query.First;
        while not Query.Eof do
        begin
          vProduto := TProduto.Create;
          vProduto.IdProduto := Query.FieldByName('IdProduto').AsInteger;
          vProduto.Descricao := Query.FieldByName('Descricao').AsString;
          vProduto.ValorVenda := Query.FieldByName('ValorVenda').AsFloat;
          vProduto.QtdeEstoque := Query.FieldByName('QtdeEstoque').AsFloat;
          Result.Add(vProduto);
          Query.Next;
        end;
      end;
    end;
  except
    on e: exception do
      begin
        MyConnection.Rollback;
        pErro := 'Ocorreu algum erro na busca do produto - Msg:'+e.Message;
      end;
  end;
end;

function TDaoProduto.BuscarProduto(pIdProduto: Integer;
  var pErro: string): TProduto;
var
  vSql: string;
begin
  try
    vSql := 'SELECT P.IDPRODUTO, P.DESCRICAO, P.VALORVENDA, P.QTDEESTOQUE '+
            'FROM PRODUTO P WHERE P.IDPRODUTO = :IDPRODUTO';
    MyConnection.PrepareStatement(vSql);
    MyConnection.SetValue(0, pIdProduto);
    MyConnection.Activate;

    if MyConnection.IsEmpty then
    begin
      pErro := 'Nenhum produto não encontrado!';
      MyConnection.Rollback;
      Exit;
    end
    else
    begin
      with MyConnection do
      begin
        Result := TProduto.Create;
        Result.IdProduto := Query.FieldByName('IdProduto').AsInteger;
        Result.Descricao := Query.FieldByName('Descricao').AsString;
        Result.ValorVenda := Query.FieldByName('ValorVenda').AsFloat;
        Result.QtdeEstoque := Query.FieldByName('QtdeEstoque').AsFloat;
      end;
    end;
  except
    on e: exception do
      begin
        MyConnection.Rollback;
        pErro := 'Ocorreu algum erro na busca do produto - Msg:'+e.Message;
      end;
  end;
end;

constructor TDaoProduto.Create;
begin
  //TDataSetSerializeConfig.getInstance.CaseNameDefinition := cndLower;
  //TDataSetSerializeConfig.getInstance.Import.DecimalSeparator := '.';
  MyConnection := TMyConnection.Create;
end;

destructor TDaoProduto.Destroy;
begin
  MyConnection.DisposeOf;
  inherited;
end;

function TDaoProduto.ExcluirProduto(pIdProduto: Integer;
  var pErro: string): Boolean;
var
  vSql: string;
  vId: integer;
  vProduto: TProduto;
begin
  Result := False;
  try
    vSql := ' DELETE FROM PRODUTO WHERE IDPRODUTO = :IDPRODUTO ';
    MyConnection.PrepareStatement(vSql);
    MyConnection.SetValue(0, pIdProduto);
    MyConnection.ExecSQL;
    Result := True;
  except
    on e: exception do
      begin
        MyConnection.Rollback;
        pErro := 'Ocorreu algum erro na exclusão do produto - Msg:'+e.Message;
      end;
  end;
end;

function TDaoProduto.IncluirProduto(pProduto: TProduto;
  var pErro: string): Boolean;
var
  vSql: string;
  vId: integer;
  vProduto: TProduto;
begin
  Result := False;
  try
    vSql := ' INSERT INTO PRODUTO (DESCRICAO, VALORVENDA, QTDEESTOQUE) '+
            ' VALUES (:DESCRICAO, :VALORVENDA, :QTDEESTOQUE) ';
    MyConnection.PrepareStatement(vSql);
    MyConnection.SetValue(0, pProduto.Descricao);
    MyConnection.SetValue(1, pProduto.ValorVenda);
    MyConnection.SetValue(2, pProduto.QtdeEstoque);
    MyConnection.ExecSQL;
    Result := True;
  except
    on e: exception do
      begin
        MyConnection.Rollback;
        pErro := 'Ocorreu algum erro na inclusão do produto - Msg:'+e.Message;
      end;
  end;
end;

function TDaoProduto.MovimentaEstoque(pIdProduto: Integer;
  pQtdeMovimentada: Double; pAcao: TTipoAcaoEstoque;
  var pErro: string): TObjectList<TProduto>;
var
  vSql, sAcao: string;
  vId: integer;
  vProduto: TProduto;
begin
  try

    // OBS: validação abaixo poderia ser feita a parte para reaproveitamento posterior !!!
    if pAcao = taeSaida then
    begin
      vSql := 'SELECT P.ESTOQUE FROM PRODUTO P WHERE P.IDPRODUTO = :IDPRODUTO';
      MyConnection.PrepareStatement(vSql);
      MyConnection.SetValue(0, pIdProduto);
      MyConnection.Activate;

      if MyConnection.IsEmpty then
      begin
        pErro := 'Produto não encontrado!';
        MyConnection.Rollback;
        Exit;
      end
      else
      begin
        with MyConnection do
        begin
            if Query.FieldByName('QtdeEstoque').AsFloat < pQtdeMovimentada then
            begin
              pErro := 'Produto não encontrado!';
              MyConnection.Rollback;
              Exit;
            end;
        end;
      end;
    end;
    //
    //
    MyConnection.Close;
    sAcao := ifthen(pAcao = taeEntrada, '+', '-');
    vSql := 'UPDATE PRODUTO P SET P.QTDEESTOQUE = P.QTDEESTOQUE '+ sAcao +' :QTDMOVIMENTADA WHERE P.IDPRODUTO = :IDPRODUTO';
    MyConnection.PrepareStatement(vSql);
    MyConnection.SetValue(0, pQtdeMovimentada);
    MyConnection.SetValue(1, pIdProduto);
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
          vProduto := TProduto.Create;
          vProduto.IdProduto := Query.FieldByName('IdProduto').AsInteger;
          vProduto.Descricao := Query.FieldByName('Descricao').AsString;
          vProduto.ValorVenda := Query.FieldByName('ValorVenda').AsFloat;
          vProduto.QtdeEstoque := Query.FieldByName('QtdeEstoque').AsFloat;
          Result.Add(vProduto);
          Query.Next;
        end;
      end;
    end;
  except
    on e: exception do
      begin
        MyConnection.Rollback;
        pErro := 'Ocorreu algum erro na movimentação de estoque do produto - Msg:'+e.Message;
      end;
  end;
end;

end.
