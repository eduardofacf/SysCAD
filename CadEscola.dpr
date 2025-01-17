program CadEscola;

uses
  Vcl.Forms,
  Login in 'Login.pas' {FrmLogin},
  Menu in 'Menu.pas' {FrmMenu},
  Usuarios in 'Cadastros\Usuarios.pas' {FrmUsuarios},
  Funcionarios in 'Cadastros\Funcionarios.pas' {FrmFuncionarios},
  Cargos in 'Cadastros\Cargos.pas' {FrmCargos},
  Modulo in 'Modulo.pas' {dm: TDataModule},
  Materia in 'Cadastros\Materia.pas' {FrmMateria},
  Escolas in 'Cadastros\Escolas.pas' {FrmEscolas},
  Serie in 'Cadastros\Serie.pas' {FrmSerie},
  Alunos in 'Cadastros\Alunos.pas' {FrmAluno};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmEscolas, FrmEscolas);
  Application.CreateForm(TFrmSerie, FrmSerie);
  Application.CreateForm(TFrmAluno, FrmAluno);
  Application.Run;
end.
