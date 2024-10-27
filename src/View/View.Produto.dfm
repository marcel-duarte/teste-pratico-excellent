object frmProdutos: TfrmProdutos
  Left = 0
  Top = 0
  Caption = 'Cadastro de Produtos'
  ClientHeight = 419
  ClientWidth = 993
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlBarraInferior: TPanel
    Left = 0
    Top = 357
    Width = 993
    Height = 62
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 356
    ExplicitWidth = 989
    object btnAlterar: TButton
      Left = 374
      Top = 12
      Width = 230
      Height = 38
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnExcluir: TButton
      Left = 618
      Top = 12
      Width = 230
      Height = 38
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnExcluirClick
    end
    object btnSair: TButton
      Left = 862
      Top = 12
      Width = 116
      Height = 38
      Caption = 'Sair'
      TabOrder = 3
      OnClick = btnSairClick
    end
    object btnIncluir: TButton
      Left = 132
      Top = 12
      Width = 230
      Height = 38
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnIncluirClick
    end
  end
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 993
    Height = 357
    ActivePage = tbCadastro
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 989
    ExplicitHeight = 356
    object tbLista: TTabSheet
      Caption = 'Lista'
      object sgListaProduto: TStringGrid
        Left = 0
        Top = 62
        Width = 985
        Height = 265
        Align = alClient
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
        TabOrder = 0
        ExplicitWidth = 981
        ExplicitHeight = 264
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 985
        Height = 62
        Align = alTop
        TabOrder = 1
        ExplicitWidth = 981
        object lblPesquisa: TLabel
          Left = 20
          Top = 6
          Width = 142
          Height = 15
          Caption = 'Informe dados da pesquisa'
        end
        object Label4: TLabel
          Left = 600
          Top = 6
          Width = 72
          Height = 15
          Caption = 'Tipo Pesquisa'
        end
        object edtPesquisa: TEdit
          Left = 20
          Top = 24
          Width = 569
          Height = 23
          TabOrder = 0
          OnKeyDown = edtPesquisaKeyDown
          OnKeyPress = edtPesquisaKeyPress
        end
        object cbxPesquisa: TComboBox
          Left = 600
          Top = 24
          Width = 169
          Height = 23
          TabOrder = 1
          Items.Strings = (
            'Id Produto'
            'Descri'#231#227'o')
        end
      end
    end
    object tbCadastro: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object Image1: TImage
        Left = 256
        Top = 128
        Width = 233
        Height = 169
        Visible = False
      end
      object ledIdProduto: TLabeledEdit
        Left = 41
        Top = 40
        Width = 57
        Height = 23
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo'
        ReadOnly = True
        TabOrder = 0
        Text = ''
      end
      object ledQtdeEstoque: TLabeledEdit
        Left = 781
        Top = 88
        Width = 112
        Height = 23
        Alignment = taRightJustify
        EditLabel.Width = 65
        EditLabel.Height = 15
        EditLabel.Caption = 'Qtd.Estoque'
        TabOrder = 3
        Text = ''
        OnKeyPress = ledValorVendaKeyPress
      end
      object btnConfirmar: TButton
        Left = 599
        Top = 268
        Width = 144
        Height = 41
        Caption = 'Confirmar'
        TabOrder = 4
        OnClick = btnConfirmarClick
      end
      object btnCancelar: TButton
        Left = 749
        Top = 268
        Width = 144
        Height = 41
        Caption = 'Cancelar'
        TabOrder = 5
        OnClick = btnCancelarClick
      end
      object ledValorVenda: TLabeledEdit
        Left = 657
        Top = 88
        Width = 110
        Height = 23
        Alignment = taRightJustify
        EditLabel.Width = 85
        EditLabel.Height = 15
        EditLabel.Caption = 'Valor Venda (R$)'
        TabOrder = 2
        Text = ''
        OnKeyPress = ledValorVendaKeyPress
      end
      object ledDescricao: TLabeledEdit
        Left = 41
        Top = 88
        Width = 600
        Height = 23
        EditLabel.Width = 51
        EditLabel.Height = 15
        EditLabel.Caption = 'Descri'#231#227'o'
        TabOrder = 1
        Text = ''
      end
      object StringGrid1: TStringGrid
        Left = 41
        Top = 128
        Width = 193
        Height = 169
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
        TabOrder = 6
        Visible = False
      end
    end
  end
end
