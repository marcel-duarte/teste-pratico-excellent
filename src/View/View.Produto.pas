unit View.Produto;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Math,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  Vcl.Mask,
  Controller.Produto,
  Vcl.DBCtrls,
  System.Generics.Collections,
  System.UITypes,
  DateUtils,
  Entity.Produto,
  Constants;

type
  TfrmProdutos = class(TForm)
    pnlBarraInferior: TPanel;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnSair: TButton;
    pgcPrincipal: TPageControl;
    tbLista: TTabSheet;
    tbCadastro: TTabSheet;
    ledIdProduto: TLabeledEdit;
    ledQtdeEstoque: TLabeledEdit;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    sgListaProduto: TStringGrid;
    ledValorVenda: TLabeledEdit;
    ledDescricao: TLabeledEdit;
    btnIncluir: TButton;
    Panel1: TPanel;
    lblPesquisa: TLabel;
    Label4: TLabel;
    edtPesquisa: TEdit;
    cbxPesquisa: TComboBox;
    StringGrid1: TStringGrid;
    Image1: TImage;
    //
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ledValorVendaKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtPesquisaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fAcao: TAcao;
    fControllerProduto: TControllerProduto;
    fListaProduto: TObjectList<TProduto>;
    //
    procedure IncluirRegistro;
    procedure AlterarRegistro;
    procedure CancelarRegistro;
    procedure ConfiguracoesIniciais;
    procedure LimparCampos;
    procedure PreencheGrade;
    procedure PreencheCampos;
    procedure PreparaGrade;
    procedure LimpaGrade;
    procedure AtualizaGrade;
  public
    { Public declarations }
    function ExcluirRegistro(pIdProduto: integer; var pErro: string): Boolean;
    function ConfirmarRegistro(pAcao: TAcao; pIdProduto: Integer; pDescricao: String; pValorVenda, pQtdeEstoque: Double;
      var pErro: string): Boolean;
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

procedure TfrmProdutos.LimparCampos;
begin
  ledIdProduto.Text := EmptyStr;
  ledDescricao.Text := '';
  ledValorVenda.Text := FormatFloat('#,##0.00',0.00);
  ledQtdeEstoque.Text := '0';
end;

procedure TfrmProdutos.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProdutos.btnConfirmarClick(Sender: TObject);
var
  vErro: string;
  vIdProduto: Integer;
begin
  vErro := '';

  if ledIdProduto.Text = EmptyStr then
    vIdProduto := 0
  else
    vIdProduto := StrToInt(ledIdProduto.Text);

  if not ConfirmarRegistro(
    fAcao,
    vIdProduto,
    ledDescricao.Text,
    StrToFloat(ledValorVenda.Text),
    StrToFloat(ledQtdeEstoque.Text),
    vErro) then
  begin
    MessageDlg(vErro, mtError ,[mbOk], 0);
    Exit;
  end;

  AtualizaGrade;
end;

procedure TfrmProdutos.btnExcluirClick(Sender: TObject);
var
  vErro: string;
begin
  /// OBS: essa rotina nao foi pedida mas apenas a criei pra demosntrar que é possivel executar outras rotinas de um CRUD
  //       usando a estrutura criada
  if not ExcluirRegistro(
    StrToInt(sgListaProduto.Cells[sgListaProduto.Selection.Left, sgListaProduto.Selection.Top]),
    vErro) then
  begin
    if not (vErro = EmptyStr) then
      MessageDlg(vErro, mtError ,[mbOk], 0);
    Exit;
  end;

  AtualizaGrade;
end;

procedure TfrmProdutos.btnIncluirClick(Sender: TObject);
begin
  IncluirRegistro;
end;

procedure TfrmProdutos.btnAlterarClick(Sender: TObject);
begin
  AlterarRegistro;
end;

procedure TfrmProdutos.btnCancelarClick(Sender: TObject);
begin
  CancelarRegistro;
end;

procedure TfrmProdutos.IncluirRegistro;
begin
  pgcPrincipal.ActivePage := tbCadastro;
  LimparCampos;
  fAcao := acIncluir;
  ledDescricao.SetFocus;
end;

procedure TfrmProdutos.AlterarRegistro;
begin
  pgcPrincipal.ActivePage := tbCadastro;
  LimparCampos;
  PreencheCampos;
  fAcao := acAlterar;
  ledDescricao.SetFocus;
end;

procedure TfrmProdutos.ledValorVendaKeyPress(Sender: TObject; var Key: Char);
begin
 if not(key in ['0'..'9','.',',',#8,#13]) then
    key := #0;
  if key in [',','.'] then
    key := FormatSettings.DecimalSeparator;
  if key = FormatSettings.DecimalSeparator then
  if pos(key,TEdit(Sender).Text) <> 0 then
    key := #0;
end;

function TfrmProdutos.ExcluirRegistro(pIdProduto: integer; var pErro: string): boolean;
begin
  Result := False;

  fAcao := acExcluir;

  if sgListaProduto.RowCount = 0 then
    Exit;

  if MessageDlg('Confirma exclusão do registro ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Result :=  fControllerProduto.ExcluirProduto(pIdProduto, pErro)
end;

procedure TfrmProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fControllerProduto.DisposeOf;
  fListaProduto.DisposeOf;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  ConfiguracoesIniciais;
end;

procedure TfrmProdutos.FormShow(Sender: TObject);
begin
//  cbxPesquisa.ItemIndex := 1;
  edtPesquisa.SetFocus;
end;

procedure TfrmProdutos.ConfiguracoesIniciais;
var
  vErro: string;
begin
  fControllerProduto := TControllerProduto.Create;
  //
  tbLista.TabVisible := False;
  tbCadastro.TabVisible := False;
  pgcPrincipal.ActivePage := tbLista;
  //

//  fListaProduto := TObjectList<TProduto>.Create;
//  fListaProduto.Clear;

  fListaProduto := fControllerProduto.BuscarProduto('', vErro);
  if vErro <> EmptyStr then
  begin
    MessageDlg(vErro, mtError ,[mbOk], 0);
    Exit;
  end;
  LimpaGrade;
  PreencheGrade;
  cbxPesquisa.ItemIndex := 1;
end;

procedure TfrmProdutos.PreparaGrade;
begin
  if fListaProduto.Count > 0 then
    sgListaProduto.RowCount := fListaProduto.Count + 1
  else
    sgListaProduto.RowCount := 2;

  sgListaProduto.FixedRows := 1;

  sgListaProduto.ColCount := 4;
  sgListaProduto.Cells[0,0] := 'Id';
  sgListaProduto.Cells[1,0] := 'Descrição';
  sgListaProduto.Cells[2,0] := 'ValorVenda (R$)';
  sgListaProduto.Cells[3,0] := 'Estoque';

  sgListaProduto.ColWidths[0] := 64;
  sgListaProduto.ColWidths[1] := 700;
  sgListaProduto.ColWidths[2] := 110;
  sgListaProduto.ColWidths[3] := 80;
end;

procedure TfrmProdutos.PreencheCampos;
var
  vErro: String;
  vProduto: TProduto;
begin
  vProduto := fControllerProduto.BuscarProduto(StrToInt(sgListaProduto.Cells[sgListaProduto.Selection.Left, sgListaProduto.Selection.Top]), vErro);
  ledIdProduto.Text := vProduto.IdProduto.ToString;
  ledDescricao.Text := vProduto.Descricao;
  ledValorVenda.Text := FormatFloat('#,##0.00',vProduto.ValorVenda);
  ledQtdeEstoque.Text := FormatFloat('#,##0.00',vProduto.QtdeEstoque);
end;

procedure TfrmProdutos.PreencheGrade;
var
  vProduto: TProduto;
  vCount: integer;
begin
   for vCount := 0 to Pred(fListaProduto.Count) do
   begin
      vProduto := fListaProduto.Items[vCount];
      sgListaProduto.Cells[0, vCount+1] := vProduto.IdProduto.ToString;
      sgListaProduto.Cells[1, vCount+1] := vProduto.Descricao;
      sgListaProduto.Cells[2, vCount+1] := FormatFloat('#,##0.00',vProduto.ValorVenda);
      sgListaProduto.Cells[3, vCount+1] := FormatFloat('#,##0.00',vProduto.QtdeEstoque);
   end;
end;

procedure TfrmProdutos.LimpaGrade;
begin
  sgListaProduto.RowCount := 0;
  PreparaGrade;
end;

function TfrmProdutos.ConfirmarRegistro(pAcao: TAcao; pIdProduto: Integer; pDescricao: String; pValorVenda, pQtdeEstoque: Double;
  var pErro: string): Boolean;
var
  vProduto: TProduto;
begin
  vProduto := TProduto.Create;
  vProduto.IdProduto := pIdProduto;
  vProduto.Descricao := pDescricao;
  vProduto.ValorVenda := pValorVenda;
  vProduto.QtdeEstoque := pQtdeEstoque;
  if pAcao = acIncluir then
    Result := fControllerProduto.IncluirProduto(vProduto, pErro)
  else
    Result := fControllerProduto.AlterarProduto(vProduto, pErro)
end;

procedure TfrmProdutos.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  vErro: string;
  //vListaProdutos: TObjectList<TProduto>;
begin
  if Ord(key) = 13 then
  begin
    fListaProduto.Clear;
    if (cbxPesquisa.ItemIndex = 0) and (edtPesquisa.Text <> EmptyStr) then
      fListaProduto.Add(fControllerProduto.BuscarProduto(StrToInt(edtPesquisa.Text), vErro))
    else
      fListaProduto := fControllerProduto.BuscarProduto(edtPesquisa.Text, vErro);
    if vErro <> EmptyStr then
    begin
      MessageDlg(vErro, mtError ,[mbOk], 0);
      Exit;
    end;
    edtPesquisa.Clear;
    LimpaGrade;
    PreencheGrade;
  end;
end;

procedure TfrmProdutos.edtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if cbxPesquisa.ItemIndex = 0 then
  begin
    if not(key in ['0'..'9','.',',',#8,#13]) then
      key := #0;
    if key in [',','.'] then
      key := FormatSettings.DecimalSeparator;
    if key = FormatSettings.DecimalSeparator then
      if pos(key,TEdit(Sender).Text) <> 0 then
        key := #0;
  end;
end;

procedure TfrmProdutos.AtualizaGrade;
var
  vErro: String;
begin
  fListaProduto := fControllerProduto.BuscarProduto('',vErro);
  if vErro <> EmptyStr then
  begin
    MessageDlg(vErro, mtError ,[mbOk], 0);
    Exit;
  end;

  LimpaGrade;
  PreencheGrade;
  pgcPrincipal.ActivePage := tbLista;
  sgListaProduto.SetFocus;
end;

procedure TfrmProdutos.CancelarRegistro;
begin
  pgcPrincipal.ActivePage := tbLista;
  sgListaProduto.SetFocus;
end;

end.
