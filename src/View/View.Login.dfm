object frmViewLogin: TfrmViewLogin
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 189
  ClientWidth = 205
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  TextHeight = 15
  object lblUsuario: TLabel
    Left = 26
    Top = 23
    Width = 40
    Height = 15
    Caption = 'Usuario'
  end
  object lblSenha: TLabel
    Left = 26
    Top = 79
    Width = 32
    Height = 15
    Caption = 'Senha'
  end
  object edtUsuario: TEdit
    Left = 26
    Top = 44
    Width = 153
    Height = 23
    TabOrder = 0
  end
  object edtSenha: TEdit
    Left = 26
    Top = 100
    Width = 153
    Height = 23
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnLogar: TButton
    Left = 26
    Top = 143
    Width = 75
    Height = 25
    Caption = 'Logar'
    TabOrder = 2
    OnClick = btnLogarClick
  end
  object btnSair: TButton
    Left = 104
    Top = 143
    Width = 75
    Height = 25
    Caption = 'Sair'
    TabOrder = 3
    OnClick = btnSairClick
  end
end
