unit uAbastecimentoView;

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
  uAbastecimentoController,
  uAbastecimentoModel,
  Vcl.DBCtrls,
  uBombaController,
  UBombaModel,
  System.Generics.Collections,
  uImpostoModel,
  uImpostoController,
  uCombustivelModel,
  uCombustivelController,
  System.UITypes,
  DateUtils;

type
  TAcao = (acIncluir, acExcluir);

  TfrmAbastecimento = class(TForm)
    pnlBarraInferior: TPanel;
    btnAbastecer: TButton;
    btnExcluir: TButton;
    btnSair: TButton;
    pgcPrincipal: TPageControl;
    tbLista: TTabSheet;
    tbCadastro: TTabSheet;
    leId: TLabeledEdit;
    leQtdLitros: TLabeledEdit;
    leDataAbastecimento: TLabeledEdit;
    leValorAbastecimento: TLabeledEdit;
    leValorImposto: TLabeledEdit;
    leValorFinalAbastecimento: TLabeledEdit;
    cbxBomba: TComboBoxEx;
    Label1: TLabel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    cbxImposto: TComboBoxEx;
    Label3: TLabel;
    sgListaAbastecimento: TStringGrid;
    lePercentualImposto: TLabeledEdit;
    leValorLitro: TLabeledEdit;
    leTanque: TLabeledEdit;
    leCombustivel: TLabeledEdit;
    //
    procedure btnSairClick(Sender: TObject);
    procedure btnAbastecerClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcluirClick(Sender: TObject);
    procedure leQtdLitrosKeyPress(Sender: TObject; var Key: Char);
    procedure cbxImpostoSelect(Sender: TObject);
    procedure leValorAbastecimentoExit(Sender: TObject);
    procedure leQtdLitrosExit(Sender: TObject);
    procedure cbxBombaSelect(Sender: TObject);
  private
    { Private declarations }
    fAcao: TAcao;
    fAbastecimentoController: TAbastecimentoController;
    fBombaController: TBombaController;
    fImpostoController: TImpostoController;
    fCombustivelController: TCombustivelController;
    fListaAbastecimentos: TList<TAbastecimento>;
    //
    procedure IncluirRegistro;
    procedure CancelarRegistro;
    procedure ConfiguracoesIniciais;
    procedure LimparCampos;
    procedure CarregarComboBombas;
    procedure CarregarComboImposto;
    procedure PreencheGrade;
    procedure PreparaGrade;
    procedure LimpaGrade;
    procedure CalculaTudo;
    function ValidaCampos(pDataAbastecimento: TDatetime; pIdBomba, pIdImposto: integer;
      pQtdLitros, pValorAbastecimento, pValorImposto, pValorFinalAbastecimento: Double;
  var pErro: string): Boolean;
    procedure AtualizaGrade;
  public
    { Public declarations }
    function ExcluirRegistro(pIdAbastecimento: integer; var pErro: string): Boolean;
    function ConfirmarRegistro(pDataAbastecimento: TDatetime; pIdBomba, pIdCombustivel,
      pIdImposto: integer; pQtdLitros, pValorAbastecimento, pValorImposto,
      pValorFinalAbastecimento: Double; var pErro: string): Boolean;
  end;

var
  frmAbastecimento: TfrmAbastecimento;

implementation

{$R *.dfm}

procedure TfrmAbastecimento.LimparCampos;
begin
  leId.Text := EmptyStr;
  leDataAbastecimento.Text := DateToStr(Now);
  leQtdLitros.Text := FormatFloat('#,##0.00',0.00);
  leValorAbastecimento.Text := FormatFloat('#,##0.00',0.00);
  leValorImposto.Text := FormatFloat('#,##0.00',0.00);
  leValorFinalAbastecimento.Text := FormatFloat('#,##0.00',0.00);
  lePercentualImposto.Text := FormatFloat('#,##0.00',0.00);
  leValorLitro.Text := FormatFloat('#,##0.00',0.00);
  //
  cbxBomba.ItemIndex := -1;
  cbxImposto.ItemIndex := -1;
end;

procedure TfrmAbastecimento.btnAbastecerClick(Sender: TObject);
begin
  IncluirRegistro;
end;

procedure TfrmAbastecimento.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAbastecimento.btnConfirmarClick(Sender: TObject);
var
  vErro: string;
begin
  vErro := '';
  if cbxBomba.ItemIndex < 0 then
  begin
    MessageDlg('Bomba não selecionada!', mtError ,[mbOk], 0);
    cbxBomba.SetFocus;
    Exit;
  end;
  if cbxImposto.ItemIndex < 0 then
  begin
    MessageDlg('Imposto não selecionado!', mtError ,[mbOk], 0);
    cbxImposto.SetFocus;
    Exit;
  end;
  //
  if not ConfirmarRegistro(
    StrToDate(leDataAbastecimento.Text),
    cbxBomba.ItemsEx[cbxBomba.ItemIndex].ImageIndex,
    fBombaController.CarregarBomba(cbxBomba.ItemsEx[cbxBomba.ItemIndex].ImageIndex).Tanque.Combustivel.IdCombustivel,
    cbxImposto.ItemsEx[cbxImposto.ItemIndex].ImageIndex,
    StrToFloat(leQtdLitros.Text),
    StrToFloat(leValorAbastecimento.Text),
    StrToFloat(leValorImposto.Text),
    StrToFloat(leValorFinalAbastecimento.Text),
    vErro) then
  begin
    MessageDlg(vErro, mtError ,[mbOk], 0);
    Exit;
  end;

  AtualizaGrade;
end;

procedure TfrmAbastecimento.btnExcluirClick(Sender: TObject);
var
  vErro: string;
begin
  /// OBS: essa rotina nao foi pedida mas apenas a criei pra demosntrar que é possivel executar outras rotinas de um CRUD
  //       usando a estrutura criada
  if not ExcluirRegistro(
    StrToInt(sgListaAbastecimento.Cells[sgListaAbastecimento.Selection.Left, sgListaAbastecimento.Selection.Top]),
    vErro) then
  begin
    if not (vErro = EmptyStr) then
      MessageDlg(vErro, mtError ,[mbOk], 0);
    Exit;
  end;

  AtualizaGrade;
end;

procedure TfrmAbastecimento.btnCancelarClick(Sender: TObject);
begin
  CancelarRegistro;
end;

procedure TfrmAbastecimento.IncluirRegistro;
begin
  pgcPrincipal.ActivePage := tbCadastro;
  LimparCampos;
  fAcao := acIncluir;
  cbxBomba.SetFocus;
end;

procedure TfrmAbastecimento.CalculaTudo;
var
  vValor: Double;
begin
  vValor := fAbastecimentoController.CalculaValorAbastecido(StrToFloat(leQtdLitros.Text), StrToFloat(leValorLitro.Text));
  leValorAbastecimento.Text := FormatFloat('#,##0.00',vValor);
  vValor := fAbastecimentoController.CalculaImposto(StrToFloat(leValorAbastecimento.Text), StrToFloat(lePercentualImposto.Text));
  leValorImposto.Text := FormatFloat('#,##0.00',vValor);
  vValor := StrToFloat(leValorAbastecimento.Text) - StrToFloat(leValorImposto.Text);
  leValorFinalAbastecimento.Text := FormatFloat('#,##0.00',vValor);
end;

procedure TfrmAbastecimento.leQtdLitrosExit(Sender: TObject);
begin
  CalculaTudo;
end;

procedure TfrmAbastecimento.leQtdLitrosKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not(key in ['0'..'9','.',',',#8,#13]) then
    key := #0;
  if key in [',','.'] then
    key := FormatSettings.DecimalSeparator;
  if key = FormatSettings.DecimalSeparator then
  if pos(key,TEdit(Sender).Text) <> 0 then
    key := #0;
end;

procedure TfrmAbastecimento.leValorAbastecimentoExit(Sender: TObject);
begin
  CalculaTudo;
end;

function TfrmAbastecimento.ExcluirRegistro(pIdAbastecimento: integer; var pErro: string): boolean;
begin
  Result := False;

  fAcao := acExcluir;

  if sgListaAbastecimento.RowCount = 0 then
    Exit;

  if MessageDlg('Confirma exclusão do registro ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Result :=  fAbastecimentoController.ExcluiAbastecimento(pIdAbastecimento, pErro)
end;

procedure TfrmAbastecimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fAbastecimentoController.DisposeOf;
  fBombaController.DisposeOf;
  fCombustivelController.DisposeOf;
  fImpostoController.DisposeOf;
  fListaAbastecimentos.DisposeOf;
end;

procedure TfrmAbastecimento.FormCreate(Sender: TObject);
begin
  ConfiguracoesIniciais;
end;

procedure TfrmAbastecimento.CarregarComboBombas;
var
  vListaBombas: TList<TBomba>;
  vBomba: TBomba;
begin
  vListaBombas := fBombaController.CarregarBombas;
  cbxBomba.ItemsEx.Clear;
  for vBomba in vListaBombas do
    cbxBomba.ItemsEx.AddItem(vBomba.Descricao, vBomba.IdBomba, 0, 0, vBomba.IdBomba, nil);
end;

procedure TfrmAbastecimento.CarregarComboImposto;
var
  vListaImpostos: TList<TImposto>;
  vImposto: TImposto;
begin
  vListaImpostos := fImpostoController.CarregarImpostos;
  cbxImposto.ItemsEx.Clear;
  for vImposto in vListaImpostos do
    cbxImposto.ItemsEx.AddItem(vImposto.Descricao, vImposto.IdImposto, 0, 0, vImposto.IdImposto, nil);
end;

procedure TfrmAbastecimento.cbxBombaSelect(Sender: TObject);
var
  vBomba: TBomba;
begin
  vBomba := fBombaController.CarregarBomba(cbxBomba.ItemsEx[cbxBomba.ItemIndex].ImageIndex);
  leTanque.Text := vBomba.Tanque.Descricao;
  leCombustivel.Text := vBomba.Tanque.Combustivel.Descricao;
  leValorLitro.Text := FormatFloat('#,##0.00',vBomba.Tanque.Combustivel.ValorLitro);
  CalculaTudo;
end;

procedure TfrmAbastecimento.cbxImpostoSelect(Sender: TObject);
var
  vImposto: TImposto;
begin
  vImposto := fImpostoController.CarregarImposto(cbxImposto.ItemsEx[cbxImposto.ItemIndex].ImageIndex);
  lePercentualImposto.Text := FormatFloat('#,##0.00',vImposto.Percentual);
  CalculaTudo;
end;

procedure TfrmAbastecimento.ConfiguracoesIniciais;
begin
  fAbastecimentoController := TAbastecimentoController.Create;
  fBombaController := TBombaController.Create;
  fCombustivelController := TCombustivelController.Create;
  fImpostoController := TImpostoController.Create;
  fListaAbastecimentos := TList<TAbastecimento>.Create;
  //
  tbLista.TabVisible := False;
  tbCadastro.TabVisible := False;
  pgcPrincipal.ActivePage := tbLista;
  //
  fListaAbastecimentos.Clear;
  fListaAbastecimentos := fAbastecimentoController.CarregaAbastecimentos;
  CarregarComboBombas;
  CarregarComboImposto;
  LimpaGrade;
  PreencheGrade;
end;

procedure TfrmAbastecimento.PreparaGrade;
begin
  if fListaAbastecimentos.Count > 0 then
    sgListaAbastecimento.RowCount := fListaAbastecimentos.Count + 1
  else
    sgListaAbastecimento.RowCount := 2;

  sgListaAbastecimento.FixedRows := 1;

  sgListaAbastecimento.ColCount := 9;
  sgListaAbastecimento.Cells[0,0] := 'Id';
  sgListaAbastecimento.Cells[1,0] := 'Bomba';
  sgListaAbastecimento.Cells[2,0] := 'Combustivel';
  sgListaAbastecimento.Cells[3,0] := 'Imposto (%)';
  sgListaAbastecimento.Cells[4,0] := 'Qtd.Litros';
  sgListaAbastecimento.Cells[5,0] := 'Data Abastec.';
  sgListaAbastecimento.Cells[6,0] := 'Valor Abastec. (R$)';
  sgListaAbastecimento.Cells[7,0] := 'Valor Imposto (R$)';
  sgListaAbastecimento.Cells[8,0] := 'Valor Final Abastec. (R$)';

  sgListaAbastecimento.ColWidths[0] := 64;
  sgListaAbastecimento.ColWidths[1] := 130;
  sgListaAbastecimento.ColWidths[2] := 130;
  sgListaAbastecimento.ColWidths[3] := 80;
  sgListaAbastecimento.ColWidths[4] := 68;
  sgListaAbastecimento.ColWidths[5] := 97;
  sgListaAbastecimento.ColWidths[6] := 110;
  sgListaAbastecimento.ColWidths[7] := 115;
  sgListaAbastecimento.ColWidths[8] := 167;
end;

procedure TfrmAbastecimento.PreencheGrade;
var
  vAbastecimento: TAbastecimento;
  vCount: integer;
begin
   for vCount := 0 to Pred(fListaAbastecimentos.Count) do
   begin
      vAbastecimento := fListaAbastecimentos.Items[vCount];
      sgListaAbastecimento.Cells[0, vCount+1] := vAbastecimento.IdAbastecimento.ToString;
      sgListaAbastecimento.Cells[1, vCount+1] := vAbastecimento.Bomba.Descricao;
      sgListaAbastecimento.Cells[2, vCount+1] := vAbastecimento.Combustivel.Descricao;
      sgListaAbastecimento.Cells[3, vCount+1] := FormatFloat('#,##0.00',vAbastecimento.Imposto.Percentual);
      sgListaAbastecimento.Cells[4, vCount+1] := FormatFloat('#,##0.00',vAbastecimento.QtdLitros);
      sgListaAbastecimento.Cells[5, vCount+1] := FormatDateTime('dd/mm/yyyy',vAbastecimento.DataAbastecimento);
      sgListaAbastecimento.Cells[6, vCount+1] := FormatFloat('#,##0.00',vAbastecimento.ValorAbastecimento);
      sgListaAbastecimento.Cells[7, vCount+1] := FormatFloat('#,##0.00',vAbastecimento.ValorImposto);
      sgListaAbastecimento.Cells[8, vCount+1] := FormatFloat('#,##0.00',vAbastecimento.ValorFinalAbastecimento);
   end;
end;

procedure TfrmAbastecimento.LimpaGrade;
begin
  sgListaAbastecimento.RowCount := 0;
  PreparaGrade;
end;

function TfrmAbastecimento.ValidaCampos(pDataAbastecimento: TDatetime; pIdBomba, pIdImposto: integer;
  pQtdLitros, pValorAbastecimento, pValorImposto, pValorFinalAbastecimento: Double;
  var pErro: string): Boolean;
begin
  Result := False;

  if pIdBomba < 0 then
  begin
    pErro := 'Bomba não informada!';
    cbxBomba.SetFocus;
    Exit;
  end;
  if pIdImposto < 0 then
  begin
    pErro := 'Imposto não informado!';
    cbxImposto.SetFocus;
    Exit;
  end;
  if pQtdLitros <= 0 then
  begin
    pErro := 'Qtd de litros inválida!';
    leQtdLitros.SetFocus;
    Exit;
  end;

  Result := True;
end;

function TfrmAbastecimento.ConfirmarRegistro(pDataAbastecimento: TDatetime; pIdBomba, pIdCombustivel,
  pIdImposto: integer; pQtdLitros, pValorAbastecimento, pValorImposto, pValorFinalAbastecimento: Double;
  var pErro: string): Boolean;
var
  vAbastecimento: TAbastecimento;
begin
  if not ValidaCampos(pDataAbastecimento, pIdBomba, pIdImposto, pQtdLitros,
    pValorAbastecimento, pValorImposto, pValorFinalAbastecimento, pErro) then
  begin
    Result := False;
    Exit;
  end;

  vAbastecimento := TAbastecimento.Create;
  vAbastecimento.DataAbastecimento := pDataAbastecimento;
  vAbastecimento.Bomba := fBombaController.CarregarBomba(pIdBomba);
  vAbastecimento.Combustivel := fCombustivelController.CarregarCombustivel(pIdCombustivel);
  vAbastecimento.Imposto := fImpostoController.CarregarImposto(pIdImposto);
  vAbastecimento.QtdLitros := pQtdLitros;
  vAbastecimento.ValorAbastecimento := pValorAbastecimento;
  vAbastecimento.ValorImposto := pValorImposto;
  vAbastecimento.ValorFinalAbastecimento := pValorFinalAbastecimento;

  Result := fAbastecimentoController.GeraAbastecimento(vAbastecimento, pErro);
end;

procedure TfrmAbastecimento.AtualizaGrade;
begin
  fListaAbastecimentos := fAbastecimentoController.CarregaAbastecimentos;
  LimpaGrade;
  PreencheGrade;
  pgcPrincipal.ActivePage := tbLista;
  sgListaAbastecimento.SetFocus;
end;

procedure TfrmAbastecimento.CancelarRegistro;
begin
  pgcPrincipal.ActivePage := tbLista;
  sgListaAbastecimento.SetFocus;
end;

end.
