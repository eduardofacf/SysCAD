unit Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls;

type
  TFrmUsuarios = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    txtNome: TEdit;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    txtBuscar: TEdit;
    btnBuscarFunc: TSpeedButton;
    Label3: TLabel;
    txtUsuario: TEdit;
    Label4: TLabel;
    txtSenha: TEdit;
    procedure btnBuscarFuncClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure txtBuscarChange(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;
    procedure buscarNome;

  public
    { Public declarations }
  end;

var
  FrmUsuarios: TFrmUsuarios;
  usuarioAntigo : string;

implementation

{$R *.dfm}

uses Modulo, Funcionarios;

procedure TFrmUsuarios.associarCampos;
begin
  dm.tb_Usuarios.FieldByName('Nome').Value := txtNome.Text;
  dm.tb_Usuarios.FieldByName('Usuario').Value := txtUsuario.Text;
  dm.tb_Usuarios.FieldByName('Senha').Value := txtSenha.Text;
  dm.tb_Usuarios.FieldByName('Cargo').Value := cargoFunc;
  dm.tb_Usuarios.FieldByName('ID_Funcionario').Value := idFunc;
end;

procedure TFrmUsuarios.btnBuscarFuncClick(Sender: TObject);
begin
  chamada := 'Func';
  FrmFuncionarios := TFrmFuncionarios.Create(Self);
  FrmFuncionarios.Show;
end;

procedure TFrmUsuarios.btnEditarClick(Sender: TObject);
var
Usuario : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  if Trim(txtUsuario.Text) = '' then
  begin
    MessageDlg('Preencha o usu�rio!', mtInformation, mbOKCancel, 0);
    txtUsuario.SetFocus;
    exit
  end;

  if usuarioAntigo <> txtUsuario.Text  then
  begin
    //VERIFICAR SE O USU�RIO J� FOI CADASTRADO
    dm.query_usuarios.Close;
    dm.query_usuarios.SQL.Clear;
    dm.query_usuarios.SQL.Add('SELECT * FROM tb_Usuarios WHERE Usuario = ' + QuotedStr(Trim(txtUsuario.Text)));
    dm.query_usuarios.Open;

    if not dm.query_usuarios.IsEmpty then
    begin
      Usuario := dm.query_usuarios['Usuario'];
      MessageDlg('O usu�rio ' + Usuario + ' j� est� cadastrado!', mtInformation, mbOKCancel, 0);
      txtUsuario.Text := '';
      txtUsuario.SetFocus;
      exit
    end;
  end;

   if Trim(txtSenha.Text) = '' then
    begin
      MessageDlg('Preencha a senha!', mtInformation, mbOKCancel, 0);
      txtSenha.SetFocus;
      exit
    end;

  //associarCampos;
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('UPDATE tb_Usuarios set Nome = :Nome, Usuario = :Usuario, Senha = :Senha WHERE ID_Usuarios = :id');
  dm.query_usuarios.Parameters.ParamByName('Nome').Value := txtNome.Text;
  dm.query_usuarios.Parameters.ParamByName('Usuario').Value := txtUsuario.Text;
  dm.query_usuarios.Parameters.ParamByName('Senha').Value := txtSenha.Text;
  dm.query_usuarios.Parameters.ParamByName('id').Value := id;
  dm.query_usuarios.ExecSQL;

  listar;
  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;

end;

procedure TFrmUsuarios.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.query_usuarios.Delete;
    MessageDlg('Deletado com sucesso!', mtInformation, mbOKCancel, 0);
    listar;
    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    txtNome.Text := '';
    limpar;

  end;
end;

procedure TFrmUsuarios.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  txtUsuario.SetFocus;
  dm.tb_Usuarios.Insert;
  btnSalvar.Enabled := true;
end;

procedure TFrmUsuarios.btnSalvarClick(Sender: TObject);
var
Usuario : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  if Trim(txtUsuario.Text) = '' then
  begin
    MessageDlg('Preencha o usu�rio!', mtInformation, mbOKCancel, 0);
    txtUsuario.SetFocus;
    exit
  end;

   if Trim(txtSenha.Text) = '' then
  begin
    MessageDlg('Preencha a senha!', mtInformation, mbOKCancel, 0);
    txtSenha.SetFocus;
    exit
  end;


  //VERIFICAR SE O USU�RIO J� FOI CADASTRADO
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('SELECT * FROM tb_Usuarios WHERE Usuario = ' + QuotedStr(Trim(txtUsuario.Text)));
  dm.query_usuarios.Open;

  if not dm.query_usuarios.IsEmpty then
  begin
    Usuario := dm.query_usuarios['Usuario'];
    MessageDlg('O usu�rio ' + Usuario + ' j� est� cadastrado!', mtInformation, mbOKCancel, 0);
    txtUsuario.Text := '';
    txtUsuario.SetFocus;
    exit
  end;

  associarCampos;
  dm.tb_Usuarios.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;

end;

procedure TFrmUsuarios.buscarNome;
begin
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('SELECT * FROM tb_Usuarios WHERE Nome LIKE :Nome AND Cargo <> :Cargo order by Nome asc');
  dm.query_usuarios.Parameters.ParamByName('Nome').Value := txtBuscar.Text + '%';
  dm.query_usuarios.Parameters.ParamByName('Cargo').Value := 'Administrador';
  dm.query_usuarios.Open;
end;

procedure TFrmUsuarios.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_Usuarios.Edit;

  txtNome.Text := dm.query_usuarios.FieldByName('Nome').Value;
  txtUsuario.Text := dm.query_usuarios.FieldByName('Usuario').Value;
  txtSenha.Text := dm.query_usuarios.FieldByName('Senha').Value;


  id := dm.query_usuarios.FieldByName('ID_Usuarios').Value;

  usuarioAntigo :=  dm.query_usuarios.FieldByName('Usuario').Value;
end;

procedure TFrmUsuarios.desabilitarCampos;
begin
  txtNome.Enabled := false;
  txtUsuario.Enabled := false;
  txtSenha.Enabled := false;
  btnBuscarFunc.Enabled := false;
 end;

procedure TFrmUsuarios.FormActivate(Sender: TObject);
begin
  txtNome.Text := nomeFunc;
end;

procedure TFrmUsuarios.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  dm.tb_Usuarios.Active := true;
  listar;
end;

procedure TFrmUsuarios.habilitarCampos;
begin
  txtUsuario.Enabled := true;
  txtSenha.Enabled := true;
  btnBuscarFunc.Enabled := true;
end;

procedure TFrmUsuarios.limpar;
begin
  txtNome.Text := '';
  txtUsuario.Text := '';
  txtSenha.Text := '';
end;

procedure TFrmUsuarios.listar;
begin
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('SELECT * FROM tb_Usuarios WHERE Cargo <> :Cargo order by Nome asc');
  dm.query_usuarios.Parameters.ParamByName('Cargo').Value := 'Administrador';
  dm.query_usuarios.Open;
end;

procedure TFrmUsuarios.txtBuscarChange(Sender: TObject);
begin
  buscarNome;
end;

end.
