object FrmCargos: TFrmCargos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cargos'
  ClientHeight = 267
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnNovo: TSpeedButton
    Left = 355
    Top = 69
    Width = 80
    Height = 35
    Cursor = crHandPoint
    Caption = 'Novo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFEFEFEFCFCFCF7F7F7F3F3F3F1F1F1F2F2F2F7F7F7FCFC
      FCFEFEFEFFFFFFFFFFFFFDFDFDF5F5F5EFEFEFEEEEEEECECECE7E7E7C5CECA69
      9480347356256A4833735369927ECBD4CFF6F6F6FEFEFEFFFFFFF5F5F5B88D80
      AB705CAB6F5AC29A8CA2A1913075542D9D7124BA8223CB8E23BA8225986B2E72
      52ADC1B7F9F9F9FFFFFFF1F1F1AD735FFDFBF9FAF4F2DCE4DE38826040C39728
      CD9240956D487E5D3F946C26CD9127BA84337B5AD5DFDAFCFCFCF1F1F1B07762
      FDFBFAF6EFEB80AD9654B59336D29C2ECE954A8362FFFFFF4A81612CD0962CCF
      9531A87A79A691F9F9F9F3F3F3B07966FDFBFBF7F2EF4993716CDBBB469D764D
      88654D8765F6F1EB4D86654D8664459B7333C892438C6BF7F7F7F4F4F4B37C69
      FEFCFBF8F4F13C926D81E9CC508C6AEADBD3F8F3EFF9F3EFF8F3EFFFFFFF4E89
      683FD5A3398B67F7F7F7F5F5F5B67F6CFEFDFCF8F3F14FA07DB1E9D86CA98C52
      8F6E528F6DFAF5F3528F6C518E6B5EA58376DCBB4B9A78F8F8F8F6F6F6B98371
      FEFDFCFAF5F28CC2AA94CBB5E2FAF5C5F5E9539371ECDED8539270ABF0DDB0F1
      DE84C6AD88BDA6FBFBFBF8F8F8BC8877FEFEFDFBF4F0E4ECE64EAA84C8E7DBEE
      FDFA7AB09556967474AF94D9F9F2BEE5D84BA580E2EDE8FEFEFEF9F9F9BF8C7A
      FEFEFDFBF6F1FBF6F4C9E2D54FAD8593CEB7D2ECE3F3FCFBD2ECE392CDB64DA8
      81C0DBD0FDFDFDFFFFFFFAFAFAC18F7FFEFEFEFAF6F3FAF5F3FAF7F4E5EEE790
      CAB15BB48F46AB825BB48E8EC9B1C9BDB1F7F7F7FFFFFFFFFFFFFBFBFBC49382
      FFFEFEFBF7F4FBF6F4FBF6F4FBF6F3FCF8F6FCF7F6FCF9F7FBF8F5FCFBFAC495
      87FAFAFAFFFFFFFFFFFFFCFCFCC79985FFFEFEFCF8F7FCF8F6FCF7F5FCF7F5FB
      F6F4FBF6F4FCF6F3FCF6F2FDFCFAC28F7FFBFBFBFFFFFFFFFFFFFDFDFDC99A89
      FFFFFEFFFFFEFFFEFEFFFEFEFEFEFEFEFEFEFEFEFDFEFEFDFEFDFDFEFDFDC493
      82FCFCFCFFFFFFFFFFFFFEFEFED8B5A8CA9C8BCA9C8BC99C8AC99B89C99B8ACA
      9A88C89A88C99987C79887C89886D2B0A3FDFDFDFFFFFFFFFFFF}
    ParentFont = False
    OnClick = btnNovoClick
  end
  object btnSalvar: TSpeedButton
    Left = 355
    Top = 110
    Width = 80
    Height = 35
    Cursor = crHandPoint
    Caption = 'Salvar'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF4F4F490AFA18DA5
      99F4F4F4FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFF9F9F9B3C8BE217D55156842B0BEB7F8F8F8FFFFFFFDFDFDF5F5F5
      F0F0F0EFEFEFEFEFEFEFEFEFEEEEEEEEEEEEEAEAEAC8D1CD26825A20B17518AA
      6D226546D3DAD7FBFBFBF6F6F684716A60453B644A41B87D4EB97A4AB47444C6
      9777C4A89139865F26B07B1EB97C1EB87B1AA26A397259E9EBEAF2F2F26F5347
      9478696A4F46D8B07BD7AE77D7AB74E5CFB46596744BB5918FE5CC7FE1C35CD4
      AB69D8B440A581638E7AF3F3F373574A987D6E70564BFFFFFFF6EFEAF6EFE9F6
      F2EF20876020865D1F845D97EBD477E1C31A774F1A764E19754FF4F4F4785C4E
      9D8273765C50FFFFFFF7F0EBF7F0EBFAF6F4F6F2F0EFEBE9218B63A8F1DF8CEB
      D21C7B55F0F0F0F8F8F8F5F5F57C6050A287777B6154FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFAFAFA229067C7F8EFC5F8ED1C8158F9F9F9FFFFFFF6F6F67F6354
      A78E7D977A6A96796995796784695C705548775C51BAADA74D9B7B24946B2393
      6A5BAB8EFCFCFCFFFFFFF7F7F7836757AB9382634A416147405E463D5C443C5B
      433B59413994857FAA9E9ABBACA8AFA29DF3F3F3FFFFFFFFFFFFF8F8F8866A59
      AF9788674E44F3EAE4E7D5C8E7D4C6E6D3C5E6D3C5E6D3C5594139795D54674C
      40F6F6F6FFFFFFFFFFFFF9F9F9886D5CB39C8C6B5248F4ECE6E9D9CDE8D7CA4B
      3D3A50433EE6D3C55D453C7B60566B4F43F7F7F7FFFFFFFFFFFFFAFAFA8B705E
      B7A09170564DF6EFEAECDDD3EADAD0473A36473A36E7D4C76047407D62576E53
      47F8F8F8FFFFFFFFFFFFFBFBFB8E7260BBA595755A50F7F1ECF6F0EBF5EEE9F5
      EDE7F4ECE6F4EBE4654B437F645972574AF9F9F9FFFFFFFFFFFFFDFDFDAA9689
      8F7361795E54765D52745A5072584E70564C6E544A6B52486A5047795D4E9683
      78FBFBFBFFFFFFFFFFFFFEFEFEFDFDFDFCFCFCFCFCFCFCFCFCFBFBFBFBFBFBFB
      FBFBFBFBFBFBFBFBFBFBFBFBFBFBFCFCFCFEFEFEFFFFFFFFFFFF}
    ParentFont = False
    OnClick = btnSalvarClick
  end
  object btnEditar: TSpeedButton
    Left = 355
    Top = 151
    Width = 80
    Height = 35
    Cursor = crHandPoint
    Caption = 'Editar'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFE0E0E0421C11432720655652A3A4A7E4E4E4FAFAFAFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1E1E17E5443B9
      C7D27889A2244182556083DEDEDEFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD
      F6F6F6F1F1F1F0F0F0DFDFDF92776C879AB2C8E3F51F66B62B6BA8576488E0E0
      E0FBFBFBFFFFFFFFFFFFFFFFFFF7F7F7CBA596C38C7AC38C79CBA395A8989448
      8BC3DEFEFD51B4E31F68B73173AE5B6A8DE3E3E3FBFBFBFFFFFFFFFFFFF3F3F3
      C5917EFDFBFAFCF8F6FAF7F5ECEAE97CA3BF479FD2DEFEFD59BFE9216BB9367B
      B35F6F92E5E5E5FBFBFBFFFFFFF3F3F3C79481FEFBFAF9F0EAF8F0EAF7F0EBE8
      E4E17EA4BF4BA5D5DEFEFD61CAEF246FBC3B83B9647699E7E7E7FFFFFFF4F4F4
      C99786FEFCFBF9F2EDF9F2EDF9F0EBF8F2EDEBE7E582A7C24EAAD7DEFEFD68D4
      F42875BE3F8BBE6A7CA0FFFFFFF5F5F5CB9C8BFEFDFCFAF3EFFAF4EEFAF3EEFA
      F1ECF8F2EEEDE9E785ABC751AEDADEFEFD6EDDF82C7BC218448BFFFFFFF6F6F6
      CFA08DFEFEFDFBF5F1FBF5F0FBF4F0FAF3EFFAF3EFF8F4EFEFECE989AECA54B1
      DCDEFEFD4FA6D47C98BAFFFFFFF6F6F6D0A393FEFEFDFAF5F3FBF6F2FBF5F1FB
      F5F0FBF5F0FAF4EFFAF6F1F3EFED83A0B8357FBC87AAC9F3F3F3FFFFFFF7F7F7
      D3A897FEFEFEFBF6F4FBF6F4FCF6F3FCF6F3FCF4F2FBF5F1FBF5F0FAF6F3E2CC
      C4E9E9E9F9F9F9FEFEFEFFFFFFF8F8F8D3AB9AFFFEFEFCF8F6FCF7F5FCF7F5FB
      F6F4FBF6F4FCF6F3FCF6F2FBF6F1D1A494F3F3F3FFFFFFFFFFFFFFFFFFF9F9F9
      D8AE9DFFFFFEFDF9F7FDF9F7FCF8F7FCF8F6FCF7F5FBF7F5FBF7F4FCF7F3D3A8
      97F4F4F4FFFFFFFFFFFFFFFFFFF9F9F9D8B0A0FFFFFFFDFAF9FDFAF8FDFAF8FD
      F9F7FCF8F7FBF8F6FBF7F6FCF7F5D4AC9BF5F5F5FFFFFFFFFFFFFFFFFFFAFAFA
      D9B3A3FFFFFFFFFFFFFFFFFFFFFFFEFFFEFEFEFEFEFFFEFEFEFEFEFEFEFED7AE
      9EF6F6F6FFFFFFFFFFFFFFFFFFFCFCFCE2C5B9DBB5A5DAB5A4DAB5A4DAB4A4D9
      B3A3D9B3A3D9B3A2D9B2A2D8B2A2DDC0B4F9F9F9FFFFFFFFFFFF}
    ParentFont = False
    OnClick = btnEditarClick
  end
  object btnExcluir: TSpeedButton
    Left = 355
    Top = 192
    Width = 80
    Height = 35
    Cursor = crHandPoint
    Caption = 'Excluir'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF5F5F5EFEFEFF6F6F6FDFDFDFF
      FFFFFFFFFFFDFDFDF5F5F5EDEDEDF3F3F3FCFCFCFFFFFFFFFFFFFFFFFFFDFDFD
      F0F0F07C74AF2D1F8E8B88B9F1F1F1FDFDFDFDFDFDF0F0F08B87B72C1E8D7A73
      ACEDEDEDFDFDFDFFFFFFFFFFFFF7F7F77F78B43233AF3648CC1D1EA58B88BAF0
      F0F0F0F0F08A86B81F20A53747CC2D2FAE7C75B0F4F4F4FFFFFFFFFFFFF3F3F3
      362A9B596CD83B51D33A4FD21E22A68884B68683B62022A63A50D33A50D34C5F
      D4372B9AEFEFEFFFFFFFFFFFFFF9F9F99F9BC84D4FBA667EE0415AD6415AD71F
      24A72529A8415AD7415AD75B72DE484AB89995C2F6F6F6FFFFFFFFFFFFFEFEFE
      F5F5F5A29ECB585CC1758DE64A64DB4A65DB4A65DB4A64DB6983E35356C09D99
      C6F3F3F3FDFDFDFFFFFFFFFFFFFFFFFFFEFEFEF5F5F5A3A0CD5D63C76783E557
      74E25774E25774E2565CC69E9BC8F2F2F2FDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
      FEFEFEF6F6F69C9AC94A50BE7492EB6383E76483E76383E73840B6928FC0F3F3
      F3FDFDFDFFFFFFFFFFFFFFFFFFFEFEFEF8F8F8A5A4D2555CC585A1EF7897ED9C
      B6F49DB7F57997EE7796ED414ABC9A98C8F5F5F5FEFEFEFFFFFFFFFFFFFBFBFB
      ACACD9636CCF93AFF383A1F1A6BFF7676DCA7E87DDAFC7F883A3F283A1F15058
      C4A09ECEF9F9F9FFFFFFFFFFFFF9F9F96769D3AFC6F68EADF4ABC4F86F76D0A8
      A7D5B3B3DE868EE1B5CCF98DACF4A1B8F46768D3F6F6F6FFFFFFFFFFFFFCFCFC
      AAABE495A0EAC0D3F97880D7B0B0DDF9F9F9F8F8F8B8BAE58B93E6C1D3F9949E
      E9A8A9E0FAFAFAFFFFFFFFFFFFFEFEFEFBFBFBAEB0E87175DEB6B7E4FAFAFAFE
      FEFEFEFEFEFAFAFABBBCE77175DEADAEE4F8F8F8FEFEFEFFFFFFFFFFFFFFFFFF
      FFFFFFFDFDFDFBFBFBFDFDFDFEFEFEFFFFFFFFFFFFFEFEFEFCFCFCFAFAFAFBFB
      FBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    ParentFont = False
    OnClick = btnExcluirClick
  end
  object Label2: TLabel
    Left = 16
    Top = 15
    Width = 32
    Height = 13
    Caption = 'Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object grid: TDBGrid
    Left = 16
    Top = 69
    Width = 333
    Height = 185
    DataSource = dm.dsCargos
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = gridCellClick
  end
  object txtNome: TEdit
    Left = 16
    Top = 34
    Width = 225
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
end
