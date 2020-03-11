unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TFrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Escola1: TMenuItem;
    Aluno1: TMenuItem;
    Srie1: TMenuItem;
    Consulta1: TMenuItem;
    Usurio1: TMenuItem;
    Funcionrios1: TMenuItem;
    Cargos1: TMenuItem;
    Sair1: TMenuItem;
    pnlMenu: TPanel;
    Image1: TImage;
    Matria1: TMenuItem;
    Label1: TLabel;
    procedure Usurio1Click(Sender: TObject);
    procedure Funcionrios1Click(Sender: TObject);
    procedure Cargos1Click(Sender: TObject);
    procedure Matria1Click(Sender: TObject);
    procedure Escola1Click(Sender: TObject);
    procedure Srie1Click(Sender: TObject);
    procedure Aluno1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  procedure centralizarPainel;
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses Usuarios, Funcionarios, Cargos, Materia, Escolas, Serie, Alunos, Modulo;

procedure TFrmMenu.FormShow(Sender: TObject);
begin
  if (cargoUsuario = 'Administrador') or (cargoUsuario = 'Diretor(a)') then
  begin
    Usurio1.Enabled := true;
  end;

end;

procedure TFrmMenu.Funcionrios1Click(Sender: TObject);
begin
  FrmFuncionarios := TFrmFuncionarios.Create(Self);
  FrmFuncionarios.ShowModal;
end;

procedure TFrmMenu.Matria1Click(Sender: TObject);
begin
  FrmMateria := TFrmMateria.Create(Self);
  FrmMateria.ShowModal;
end;

procedure TFrmMenu.Srie1Click(Sender: TObject);
begin
  FrmSerie := TFrmSerie.Create(Self);
  FrmSerie.ShowModal;
end;

procedure TFrmMenu.Aluno1Click(Sender: TObject);
begin
  FrmAluno := TFrmAluno.Create(Self);
  FrmAluno.ShowModal;
end;

procedure TFrmMenu.Cargos1Click(Sender: TObject);
begin
  FrmCargos := TFrmCargos.Create(Self);
  FrmCargos.ShowModal;
end;

procedure TFrmMenu.centralizarPainel;
begin
  pnlMenu.Top := (self.Height div 2) - (pnlMenu.Height div 2);
  pnlMenu.Left := (self.Width div 2) - (pnlMenu.Width div 2);
end;

procedure TFrmMenu.Escola1Click(Sender: TObject);
begin
  FrmEscolas := TFrmEscolas.Create(Self);
  FrmEscolas.ShowModal;
end;

procedure TFrmMenu.Usurio1Click(Sender: TObject);
begin
  FrmUsuarios := TFrmUsuarios.Create(Self);
  FrmUsuarios.ShowModal;
end;

end.
