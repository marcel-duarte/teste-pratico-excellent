object frmAbastecimento: TfrmAbastecimento
  Left = 0
  Top = 0
  Caption = 'Gest'#227'o de Abastecimentos'
  ClientHeight = 420
  ClientWidth = 997
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object pnlBarraInferior: TPanel
    Left = 0
    Top = 358
    Width = 997
    Height = 62
    Align = alBottom
    TabOrder = 0
    object btnAbastecer: TButton
      Left = 383
      Top = 10
      Width = 230
      Height = 38
      Caption = 'Abastercer'
      TabOrder = 0
      OnClick = btnAbastecerClick
    end
    object btnExcluir: TButton
      Left = 627
      Top = 10
      Width = 230
      Height = 38
      Caption = 'Excluir'
      TabOrder = 1
      OnClick = btnExcluirClick
    end
    object btnSair: TButton
      Left = 871
      Top = 10
      Width = 116
      Height = 38
      Caption = 'Sair'
      TabOrder = 2
      OnClick = btnSairClick
    end
  end
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 997
    Height = 358
    ActivePage = tbCadastro
    Align = alClient
    TabOrder = 1
    object tbLista: TTabSheet
      Caption = 'Lista'
      object sgListaAbastecimento: TStringGrid
        Left = 0
        Top = 0
        Width = 989
        Height = 328
        Align = alClient
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
        TabOrder = 0
      end
    end
    object tbCadastro: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object Label1: TLabel
        Left = 40
        Top = 99
        Width = 38
        Height = 15
        Caption = 'Bomba'
      end
      object Label3: TLabel
        Left = 616
        Top = 99
        Width = 44
        Height = 15
        Caption = 'Imposto'
      end
      object leId: TLabeledEdit
        Left = 40
        Top = 56
        Width = 57
        Height = 23
        EditLabel.Width = 10
        EditLabel.Height = 15
        EditLabel.Caption = 'Id'
        ReadOnly = True
        TabOrder = 0
        Text = ''
      end
      object leQtdLitros: TLabeledEdit
        Left = 40
        Top = 184
        Width = 112
        Height = 23
        Alignment = taRightJustify
        EditLabel.Width = 52
        EditLabel.Height = 15
        EditLabel.Caption = 'Qtd Litros'
        TabOrder = 4
        Text = ''
        OnExit = leQtdLitrosExit
        OnKeyPress = leQtdLitrosKeyPress
      end
      object leDataAbastecimento: TLabeledEdit
        Left = 121
        Top = 56
        Width = 112
        Height = 23
        EditLabel.Width = 107
        EditLabel.Height = 15
        EditLabel.Caption = 'Data Abastecimento'
        Enabled = False
        TabOrder = 1
        Text = ''
      end
      object leValorAbastecimento: TLabeledEdit
        Left = 232
        Top = 184
        Width = 171
        Height = 25
        TabStop = False
        Alignment = taRightJustify
        EditLabel.Width = 133
        EditLabel.Height = 15
        EditLabel.Caption = 'Valor Abastecimento (R$)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        Text = ''
        OnExit = leValorAbastecimentoExit
        OnKeyPress = leQtdLitrosKeyPress
      end
      object leValorImposto: TLabeledEdit
        Left = 479
        Top = 184
        Width = 171
        Height = 25
        TabStop = False
        Alignment = taRightJustify
        EditLabel.Width = 97
        EditLabel.Height = 15
        EditLabel.Caption = 'Valor Imposto (R$)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        Text = ''
        OnKeyPress = leQtdLitrosKeyPress
      end
      object leValorFinalAbastecimento: TLabeledEdit
        Left = 725
        Top = 182
        Width = 171
        Height = 25
        TabStop = False
        Alignment = taRightJustify
        EditLabel.Width = 161
        EditLabel.Height = 15
        EditLabel.Caption = 'Valor Final Abastecimento (R$)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
        Text = ''
        OnKeyPress = leQtdLitrosKeyPress
      end
      object cbxBomba: TComboBoxEx
        Left = 40
        Top = 120
        Width = 193
        Height = 24
        ItemsEx = <>
        Style = csExDropDownList
        TabOrder = 2
        OnSelect = cbxBombaSelect
      end
      object btnConfirmar: TButton
        Left = 592
        Top = 244
        Width = 144
        Height = 41
        Caption = 'Confirmar'
        TabOrder = 8
        OnClick = btnConfirmarClick
      end
      object btnCancelar: TButton
        Left = 749
        Top = 244
        Width = 144
        Height = 41
        Caption = 'Cancelar'
        TabOrder = 9
        OnClick = btnCancelarClick
      end
      object cbxImposto: TComboBoxEx
        Left = 616
        Top = 120
        Width = 186
        Height = 24
        ItemsEx = <>
        Style = csExDropDownList
        TabOrder = 3
        OnSelect = cbxImpostoSelect
      end
      object lePercentualImposto: TLabeledEdit
        Left = 803
        Top = 120
        Width = 93
        Height = 23
        Alignment = taRightJustify
        EditLabel.Width = 94
        EditLabel.Height = 15
        EditLabel.Caption = 'Perc. Imposto (%)'
        Enabled = False
        TabOrder = 10
        Text = ''
        OnKeyPress = leQtdLitrosKeyPress
      end
      object leValorLitro: TLabeledEdit
        Left = 483
        Top = 120
        Width = 91
        Height = 23
        Alignment = taRightJustify
        EditLabel.Width = 77
        EditLabel.Height = 15
        EditLabel.Caption = 'Valor Litro (R$)'
        Enabled = False
        TabOrder = 11
        Text = ''
        OnKeyPress = leQtdLitrosKeyPress
      end
      object leTanque: TLabeledEdit
        Left = 236
        Top = 120
        Width = 108
        Height = 23
        EditLabel.Width = 38
        EditLabel.Height = 15
        EditLabel.Caption = 'Tanque'
        Enabled = False
        TabOrder = 12
        Text = ''
        OnKeyPress = leQtdLitrosKeyPress
      end
      object leCombustivel: TLabeledEdit
        Left = 347
        Top = 120
        Width = 133
        Height = 23
        EditLabel.Width = 67
        EditLabel.Height = 15
        EditLabel.Caption = 'Combustivel'
        Enabled = False
        TabOrder = 13
        Text = ''
        OnKeyPress = leQtdLitrosKeyPress
      end
    end
  end
end
