unit Dao.Base.FB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.Client;

type

  TMyConnection = class
    private
      FDConnection: TFDConnection;
      FDPhysFBDriverLink: TFDPhysFBDriverLink;
      FDQuery: TFDQuery;
    public
      procedure PrepareStatement(pSql: string);
      function GetValue(pIndex: integer): Variant;
      procedure ExecSQL;
      procedure StartTransaction;
      procedure Commit;
      procedure Rollback;
      procedure Activate;
      procedure Close;
      function IsEmpty: Boolean;
      function Query: TFDQuery;

      procedure SetDataType(pIndex: integer; pFieldType: TFieldType);
      procedure SetValue(pIndex: integer; pValue: Variant;
        pFieldType: TFieldType = ftUnknown);

      constructor Create;
      destructor Destroy; override;
  end;

implementation

{ TMyConnection }

procedure TMyConnection.Activate;
begin
  FDQuery.Active := True;
end;

procedure TMyConnection.Close;
begin
  FDQuery.Active := False;
end;

procedure TMyConnection.Commit;
begin
  FDConnection.Commit;
end;

constructor TMyConnection.Create;
begin
  FDConnection  := TFDConnection.Create(nil);
  FDConnection.Params.Values['Database'] := 'C:\Marcel\Projetos\Delphi\Teste_Pratico_Excellent\Database\DBEXCELLENT.FDB';
  FDConnection.Params.Values['DriverID'] := 'FB';
  FDConnection.Params.Values['User_Name'] := 'SYSDBA';
  FDConnection.Params.Values['Password'] := 'masterkey';
  //
  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := FDConnection;
  //
  FDConnection.Connected := True;
end;

destructor TMyConnection.Destroy;
begin
  FDQuery.DisposeOf;
  FDPhysFBDriverLink.DisposeOf;
  FDConnection.DisposeOf;

  inherited;
end;

procedure TMyConnection.ExecSQL;
begin
  FDQuery.ExecSQL;
end;

function TMyConnection.GetValue(pIndex: integer): Variant;
begin
  result := FDQuery.Fields[pIndex].Value;
end;

function TMyConnection.IsEmpty: Boolean;
begin
  Result := FDQuery.IsEmpty;
end;

function TMyConnection.Query: TFDQuery;
begin
  result := FDQuery;
end;

procedure TMyConnection.PrepareStatement(pSql: string);
begin
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(pSql);
end;

procedure TMyConnection.Rollback;
begin
  FDConnection.Rollback;
end;

procedure TMyConnection.SetDataType(pIndex: integer; pFieldType: TFieldType);
begin
  FDQuery.Params[pIndex].DataType := pFieldType;
end;

procedure TMyConnection.SetValue(pIndex: integer; pValue: Variant; pFieldType: TFieldType = ftUnknown);
var
  vInt: integer;
  vDate: TDate;
begin
  FDQuery.Params.Add;
  FDQuery.Params[pIndex].Value := pValue;
end;

procedure TMyConnection.StartTransaction;
begin
  FDConnection.StartTransaction;
end;

end.

