object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 368
  Width = 645
  object ADOcnct: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=punkroc3;Persist Security Info=True' +
      ';User ID=sa;Initial Catalog=SysCADproj;Data Source=PROGRAMADOR'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 280
    Top = 16
  end
  object tb_Cargos: TADOTable
    Active = True
    Connection = ADOcnct
    CursorType = ctStatic
    TableName = 'tb_Cargos'
    Left = 120
    Top = 72
  end
  object query_cargos: TADOQuery
    Connection = ADOcnct
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tb_Cargos order by  Descricao_Cargos asc')
    Left = 120
    Top = 120
    object query_cargosID_Cargos: TSmallintField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'ID_Cargos'
      ReadOnly = True
      Visible = False
    end
    object query_cargosDescricao_Cargos: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 40
      FieldName = 'Descricao_Cargos'
      Size = 50
    end
    object query_cargosexige_materia: TStringField
      FieldName = 'exige_materia'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsCargos: TDataSource
    DataSet = query_cargos
    Left = 120
    Top = 176
  end
  object tb_Materia: TADOTable
    Active = True
    Connection = ADOcnct
    CursorType = ctStatic
    TableName = 'tb_Materia'
    Left = 200
    Top = 72
  end
  object query_materia: TADOQuery
    Connection = ADOcnct
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tb_Materia order by Descricao_Materia asc')
    Left = 200
    Top = 120
    object query_materiaID_Materia: TSmallintField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'ID_Materia'
      ReadOnly = True
      Visible = False
    end
    object query_materiaDescricao_Materia: TStringField
      DisplayLabel = 'Mat'#233'ria'
      DisplayWidth = 40
      FieldName = 'Descricao_Materia'
      Size = 50
    end
  end
  object dsMateria: TDataSource
    DataSet = query_materia
    Left = 200
    Top = 176
  end
  object tb_Funcionarios: TADOTable
    Active = True
    Connection = ADOcnct
    CursorType = ctStatic
    TableName = 'tb_Funcionarios'
    Left = 368
    Top = 72
  end
  object query_funcionarios: TADOQuery
    Connection = ADOcnct
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tb_Funcionarios order by Nome asc ')
    Left = 368
    Top = 120
    object query_funcionariosID_Funcionarios: TSmallintField
      DisplayLabel = 'ID'
      FieldName = 'ID_Funcionarios'
      ReadOnly = True
      Visible = False
    end
    object query_funcionariosNome: TStringField
      DisplayWidth = 25
      FieldName = 'Nome'
      Size = 30
    end
    object query_funcionariosCPF: TStringField
      DisplayWidth = 15
      FieldName = 'CPF'
    end
    object query_funcionariosEndereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 30
      FieldName = 'Endereco'
      Size = 50
    end
    object query_funcionariosTelefone: TStringField
      DisplayWidth = 13
      FieldName = 'Telefone'
      Size = 15
    end
    object query_funcionariosCargo: TStringField
      DisplayWidth = 12
      FieldName = 'Cargo'
      Size = 25
    end
    object query_funcionariosMateria: TStringField
      DisplayLabel = 'Mat'#233'ria'
      DisplayWidth = 15
      FieldName = 'Materia'
      Size = 25
    end
  end
  object dsFuncionarios: TDataSource
    DataSet = query_funcionarios
    Left = 368
    Top = 176
  end
  object tb_Escolas: TADOTable
    Active = True
    Connection = ADOcnct
    CursorType = ctStatic
    TableName = 'tb_Escolas'
    Left = 280
    Top = 72
  end
  object query_escolas: TADOQuery
    Connection = ADOcnct
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tb_Escolas order by Nome asc ')
    Left = 280
    Top = 120
    object query_escolasID_Escola: TSmallintField
      FieldName = 'ID_Escola'
      ReadOnly = True
      Visible = False
    end
    object query_escolasNome: TStringField
      FieldName = 'Nome'
      Size = 30
    end
    object query_escolasCNPJ: TStringField
      FieldName = 'CNPJ'
    end
    object query_escolasEndereco: TStringField
      FieldName = 'Endereco'
      Size = 35
    end
    object query_escolasTelefone: TStringField
      FieldName = 'Telefone'
      Size = 15
    end
  end
  object dsEscolas: TDataSource
    DataSet = query_escolas
    Left = 280
    Top = 176
  end
  object tb_Serie: TADOTable
    Active = True
    Connection = ADOcnct
    CursorType = ctStatic
    TableName = 'tb_Serie'
    Left = 32
    Top = 72
  end
  object query_serie: TADOQuery
    Connection = ADOcnct
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tb_Serie order by  Descricao_Serie asc')
    Left = 32
    Top = 120
    object query_serieID_Serie: TSmallintField
      FieldName = 'ID_Serie'
      ReadOnly = True
      Visible = False
    end
    object query_serieDescricao_Serie: TStringField
      DisplayLabel = 'Turma'
      DisplayWidth = 40
      FieldName = 'Descricao_Serie'
      Size = 30
    end
  end
  object dsSerie: TDataSource
    DataSet = query_serie
    Left = 32
    Top = 176
  end
  object tb_Aluno: TADOTable
    Connection = ADOcnct
    TableName = 'tb_Aluno'
    Left = 448
    Top = 72
  end
  object query_aluno: TADOQuery
    Connection = ADOcnct
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tb_Aluno order by Nome asc ')
    Left = 448
    Top = 120
    object query_alunoID_Aluno: TSmallintField
      FieldName = 'ID_Aluno'
      ReadOnly = True
      Visible = False
    end
    object query_alunoNome: TStringField
      FieldName = 'Nome'
      Size = 30
    end
    object query_alunoMatricula: TStringField
      FieldName = 'Matricula'
      Size = 15
    end
    object query_alunoResponsavel: TStringField
      FieldName = 'Responsavel'
      Size = 30
    end
    object query_alunoTelefone: TStringField
      FieldName = 'Telefone'
      Size = 15
    end
    object query_alunoEndereco: TStringField
      FieldName = 'Endereco'
      Size = 30
    end
    object query_alunoSerie: TStringField
      FieldName = 'Serie'
      Size = 15
    end
  end
  object dsAluno: TDataSource
    DataSet = query_aluno
    Left = 448
    Top = 176
  end
  object tb_Usuarios: TADOTable
    Connection = ADOcnct
    TableName = 'tb_Usuarios'
    Left = 520
    Top = 72
  end
  object query_usuarios: TADOQuery
    Connection = ADOcnct
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tb_Usuarios order by Nome asc ')
    Left = 520
    Top = 120
    object query_usuariosID_Usuarios: TSmallintField
      FieldName = 'ID_Usuarios'
      ReadOnly = True
      Visible = False
    end
    object query_usuariosNome: TStringField
      DisplayWidth = 30
      FieldName = 'Nome'
      Size = 30
    end
    object query_usuariosUsuario: TStringField
      DisplayWidth = 15
      FieldName = 'Usuario'
      Size = 25
    end
    object query_usuariosSenha: TStringField
      DisplayWidth = 15
      FieldName = 'Senha'
      Size = 25
    end
    object query_usuariosCargo: TStringField
      DisplayWidth = 25
      FieldName = 'Cargo'
      Size = 25
    end
    object query_usuariosID_Funcionario: TSmallintField
      DisplayWidth = 10
      FieldName = 'ID_Funcionario'
      Visible = False
    end
  end
  object dsUsuarios: TDataSource
    DataSet = query_usuarios
    Left = 520
    Top = 176
  end
end
