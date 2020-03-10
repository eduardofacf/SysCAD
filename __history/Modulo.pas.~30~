unit Modulo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  Tdm = class(TDataModule)
    ADOcnct: TADOConnection;
    tb_Cargos: TADOTable;
    query_cargos: TADOQuery;
    query_cargosID_Cargos: TSmallintField;
    query_cargosDescricao_Cargos: TStringField;
    dsCargos: TDataSource;
    tb_Materia: TADOTable;
    query_materia: TADOQuery;
    query_materiaID_Materia: TSmallintField;
    query_materiaDescricao_Materia: TStringField;
    dsMateria: TDataSource;
    tb_Funcionarios: TADOTable;
    query_funcionarios: TADOQuery;
    dsFuncionarios: TDataSource;
    query_funcionariosID_Funcionarios: TSmallintField;
    query_funcionariosNome: TStringField;
    query_funcionariosCPF: TStringField;
    query_funcionariosEndereco: TStringField;
    query_funcionariosTelefone: TStringField;
    query_funcionariosCargo: TStringField;
    query_funcionariosMateria: TStringField;
    tb_Escolas: TADOTable;
    query_escolas: TADOQuery;
    dsEscolas: TDataSource;
    query_escolasID_Escola: TSmallintField;
    query_escolasNome: TStringField;
    query_escolasCNPJ: TStringField;
    query_escolasEndereco: TStringField;
    query_escolasTelefone: TStringField;
    tb_Serie: TADOTable;
    query_serie: TADOQuery;
    query_serieID_Serie: TSmallintField;
    query_serieDescricao_Serie: TStringField;
    dsSerie: TDataSource;
    tb_Aluno: TADOTable;
    query_aluno: TADOQuery;
    dsAluno: TDataSource;
    query_alunoID_Aluno: TSmallintField;
    query_alunoNome: TStringField;
    query_alunoMatricula: TStringField;
    query_alunoResponsavel: TStringField;
    query_alunoTelefone: TStringField;
    query_alunoEndereco: TStringField;
    query_alunoSerie: TStringField;
    tb_Usuarios: TADOTable;
    query_usuarios: TADOQuery;
    dsUsuarios: TDataSource;
    query_usuariosID_Usuarios: TSmallintField;
    query_usuariosNome: TStringField;
    query_usuariosUsuario: TStringField;
    query_usuariosSenha: TStringField;
    query_usuariosCargo: TStringField;
    query_usuariosID_Funcionario: TSmallintField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

  //VARIÁVEIS GLOBAIS
  idFunc : string;
  nomeFunc : string;
  cargoFunc : string;

  chamada : string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
   ADOcnct.Connected := true;
end;

end.
