object dm1: Tdm1
  OldCreateOrder = False
  Left = 609
  Top = 281
  Height = 394
  Width = 578
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Extended Properti' +
      'es="DBQ=D:\developer\estaq.net.br\documentacao\testemdb.MDB;Defa' +
      'ultDir=D:\developer\estaq.net.br\documentacao;Driver={Driver do ' +
      'Microsoft Access (*.mdb)};DriverId=25;FIL=MS Access;FILEDSN=C:\U' +
      'sers\ORION\Desktop\TECLADO\estaqmdb.dsn;MaxBufferSize=2048;MaxSc' +
      'anRows=8;PageTimeout=5;SafeTransactions=0;Threads=3;UID=admin;Us' +
      'erCommitSync=Yes;"'
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    TableName = 'ESTACA'
    Left = 136
    Top = 24
    object ADOTable1idEstaca: TAutoIncField
      FieldName = 'idEstaca'
      ReadOnly = True
    end
    object ADOTable1estNumero: TWideStringField
      FieldName = 'estNumero'
      Size = 10
    end
    object ADOTable1idImportacao: TIntegerField
      FieldName = 'idImportacao'
    end
    object ADOTable1estImprimir: TBooleanField
      FieldName = 'estImprimir'
    end
    object ADOTable1estContrato: TWideStringField
      FieldName = 'estContrato'
      Size = 50
    end
    object ADOTable1estData: TDateTimeField
      FieldName = 'estData'
    end
    object ADOTable1estObra: TWideStringField
      FieldName = 'estObra'
      Size = 50
    end
    object ADOTable1estDiametro: TFloatField
      FieldName = 'estDiametro'
    end
    object ADOTable1estVolBomba: TFloatField
      FieldName = 'estVolBomba'
    end
    object ADOTable1estInclinacao: TWideStringField
      FieldName = 'estInclinacao'
      Size = 50
    end
    object ADOTable1estPulsosVolta: TSmallintField
      FieldName = 'estPulsosVolta'
    end
    object ADOTable1estInicioP: TDateTimeField
      FieldName = 'estInicioP'
    end
    object ADOTable1estFimP: TDateTimeField
      FieldName = 'estFimP'
    end
    object ADOTable1estInicioC: TDateTimeField
      FieldName = 'estInicioC'
    end
    object ADOTable1estFimC: TDateTimeField
      FieldName = 'estFimC'
    end
    object ADOTable1estComprimento: TFloatField
      FieldName = 'estComprimento'
    end
    object ADOTable1estVolBetao: TFloatField
      FieldName = 'estVolBetao'
    end
    object ADOTable1estSuperConsumo: TFloatField
      FieldName = 'estSuperConsumo'
    end
    object ADOTable1estFlagImportacao: TBooleanField
      FieldName = 'estFlagImportacao'
    end
    object ADOTable1estBrevN: TIntegerField
      FieldName = 'estBrevN'
    end
    object ADOTable1estBrevD: TIntegerField
      FieldName = 'estBrevD'
    end
    object ADOTable1estPinhao: TIntegerField
      FieldName = 'estPinhao'
    end
    object ADOTable1estCoroa: TIntegerField
      FieldName = 'estCoroa'
    end
    object ADOTable1estCil1: TIntegerField
      FieldName = 'estCil1'
    end
    object ADOTable1estCil2: TIntegerField
      FieldName = 'estCil2'
    end
    object ADOTable1estEficiencia: TIntegerField
      FieldName = 'estEficiencia'
    end
    object ADOTable1estSpeedSensor: TIntegerField
      FieldName = 'estSpeedSensor'
    end
    object ADOTable1estPassoTrado: TIntegerField
      FieldName = 'estPassoTrado'
    end
    object ADOTable1estDiametroTubo: TIntegerField
      FieldName = 'estDiametroTubo'
    end
    object ADOTable1estMassa: TIntegerField
      FieldName = 'estMassa'
    end
    object ADOTable1estMedia: TIntegerField
      FieldName = 'estMedia'
    end
    object ADOTable1estTrabalhoTotal: TIntegerField
      FieldName = 'estTrabalhoTotal'
    end
    object ADOTable1estLimite: TIntegerField
      FieldName = 'estLimite'
    end
    object ADOTable1estFrgVer: TIntegerField
      FieldName = 'estFrgVer'
    end
    object ADOTable1lgSel: TIntegerField
      FieldName = 'lgSel'
    end
    object ADOTable1estLat: TWideStringField
      FieldName = 'estLat'
      Size = 255
    end
    object ADOTable1estLon: TWideStringField
      FieldName = 'estLon'
      Size = 255
    end
    object ADOTable1estAlt: TWideStringField
      FieldName = 'estAlt'
      Size = 255
    end
    object ADOTable1estGps: TIntegerField
      FieldName = 'estGps'
    end
  end
end
