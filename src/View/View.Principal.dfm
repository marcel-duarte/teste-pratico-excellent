object frmViewPrincipal: TfrmViewPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Principal'
  ClientHeight = 420
  ClientWidth = 900
  Color = 16769734
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object btnPedido: TButton
    Left = 208
    Top = 152
    Width = 137
    Height = 89
    Caption = 'Pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnSair: TButton
    Left = 512
    Top = 152
    Width = 137
    Height = 89
    Caption = 'Sair'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnSairClick
  end
  object btnProduto: TButton
    Left = 361
    Top = 150
    Width = 137
    Height = 89
    Caption = 'Produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnProdutoClick
  end
end
