object DataModule1: TDataModule1
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Marcel\Projetos\Delphi\Teste_Pratico_Excellent\Datab' +
        'ase\DBEXCELLENT.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 304
    Top = 224
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 384
    Top = 368
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 480
    Top = 256
  end
end
