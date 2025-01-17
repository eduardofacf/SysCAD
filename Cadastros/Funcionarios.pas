unit Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFrmFuncionarios = class(TForm)
    txtBuscarNome: TEdit;
    rbNome: TRadioButton;
    rbCPF: TRadioButton;
    txtBuscarCPF: TMaskEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    cbCargo: TComboBox;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnExcluir: TSpeedButton;
    cbMateria: TComboBox;
    Label7: TLabel;
    btnEditar: TSpeedButton;
    txtCPF: TMaskEdit;
    txtEndereco: TEdit;
    txtNome: TEdit;
    txtTelefone: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure cbCargoChange(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure txtBuscarNomeChange(Sender: TObject);
    procedure txtBuscarCPFChange(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbCPFClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;

    procedure carregarCombobox1;
    procedure carregarCombobox2;
    procedure buscarNome;
    procedure buscarCPF;
  public
    { Public declarations }
  end;

var
  FrmFuncionarios: TFrmFuncionarios;
  id : string;
  CPFantigo : string;

implementation

{$R *.dfm}

uses Modulo;

{ TFrmFuncionarios }

procedure TFrmFuncionarios.associarCampos;
begin
  dm.tb_Funcionarios.FieldByName('Nome').Value := txtNome.Text;
  dm.tb_Funcionarios.FieldByName('CPF').Value := txtCPF.Text;
  dm.tb_Funcionarios.FieldByName('Endereco').Value := txtEndereco.Text;
  dm.tb_Funcionarios.FieldByName('Telefone').Value := txtTelefone.Text;
  dm.tb_Funcionarios.FieldByName('Cargo').Value := cbCargo.Text;
  if SameText(cbMateria.Text, 'Selecione:') then
    dm.tb_Funcionarios.FieldByName('Materia').Value := ''
  else
    dm.tb_Funcionarios.FieldByName('Materia').Value := cbMateria.Text;
end;

procedure TFrmFuncionarios.btnEditarClick(Sender: TObject);
var
CPF : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  if Trim(txtCPF.Text) = '' then
  begin
    MessageDlg('Preencha o CPF!', mtInformation, mbOKCancel, 0);
    txtCPF.SetFocus;
    exit
  end;

  if CPFantigo <> txtCPF.Text  then
    begin
      //VERIFICAR SE O CPF J� FOI CADASTRADO
      dm.query_funcionarios.Close;
      dm.query_funcionarios.SQL.Clear;
      dm.query_funcionarios.SQL.Add('SELECT * FROM tb_Funcionarios WHERE CPF = ' + QuotedStr(Trim(txtCPF.Text)));
      dm.query_funcionarios.Open;

    if not dm.query_funcionarios.IsEmpty then
    begin
      CPF := dm.query_funcionarios['CPF'];
      MessageDlg('O CPF ' + CPF + ' j� est� cadastrado!', mtInformation, mbOKCancel, 0);
      txtNome.Text := '';
      txtNome.SetFocus;
      exit
    end;
  end;

  if Trim(txtEndereco.Text) = '' then
  begin
    MessageDlg('Preencha o endere�o!', mtInformation, mbOKCancel, 0);
    txtEndereco.SetFocus;
    exit
  end;

  if Trim(txtTelefone.Text) = '' then
  begin
    MessageDlg('Preencha o telefone!', mtInformation, mbOKCancel, 0);
    txtTelefone.SetFocus;
    exit
  end;

  associarCampos;
  dm.query_funcionarios.Close;
  dm.query_funcionarios.SQL.Clear;
  dm.query_funcionarios.SQL.Add('UPDATE tb_Funcionarios set Nome = :Nome, CPF = :CPF, Endereco = :Endereco, Telefone = :Telefone, Cargo = :Cargo, Materia = :Materia WHERE ID_Funcionarios = :id');
  dm.query_funcionarios.Parameters.ParamByName('Nome').Value := txtNome.Text;
  dm.query_funcionarios.Parameters.ParamByName('CPF').Value := txtCPF.Text;
  dm.query_funcionarios.Parameters.ParamByName('Endereco').Value := txtEndereco.Text;
  dm.query_funcionarios.Parameters.ParamByName('Telefone').Value := txtTelefone.Text;
  dm.query_funcionarios.Parameters.ParamByName('Cargo').Value := cbCargo.Text;
  dm.query_funcionarios.Parameters.ParamByName('Materia').Value := cbMateria.Text;
  dm.query_funcionarios.Parameters.ParamByName('id').Value := id;
  dm.query_funcionarios.ExecSQL;

  //EDITAR CARGO DE USU�RIO
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('UPDATE tb_Usuarios set Cargo = :Cargo WHERE ID_Funcionario = :id');
  dm.query_usuarios.Parameters.ParamByName('Cargo').Value := cbCargo.Text;
  dm.query_usuarios.Parameters.ParamByName('id').Value := id;
  dm.query_usuarios.ExecSQL;

  listar;
  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;

end;

procedure TFrmFuncionarios.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.query_funcionarios.Delete;
    MessageDlg('Deletado com sucesso!', mtInformation, mbOKCancel, 0);
    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    txtNome.Text := '';
    limpar;

  end;

  //DELETAR USU�RIO ASSOCIADO
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('DELETE FROM tb_Usuarios WHERE ID_Funcionario = :id');
  dm.query_usuarios.Parameters.ParamByName('id').Value := id;
  dm.query_usuarios.ExecSQL;

  listar;

end;

procedure TFrmFuncionarios.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  txtNome.SetFocus;
  dm.tb_Funcionarios.Insert;
  btnSalvar.Enabled := true;
end;

procedure TFrmFuncionarios.btnSalvarClick(Sender: TObject);
var
CPF : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  if Trim(txtCPF.Text) = '' then
  begin
    MessageDlg('Preencha o CPF!', mtInformation, mbOKCancel, 0);
    txtCPF.SetFocus;
    exit
  end;

  if Trim(txtEndereco.Text) = '' then
  begin
    MessageDlg('Preencha o endere�o!', mtInformation, mbOKCancel, 0);
    txtEndereco.SetFocus;
    exit
  end;

  if Trim(txtTelefone.Text) = '' then
  begin
    MessageDlg('Preencha o telefone!', mtInformation, mbOKCancel, 0);
    txtTelefone.SetFocus;
    exit
  end;

  //VERIFICAR SE O CPF J� FOI CADASTRADO
  dm.query_funcionarios.Close;
  dm.query_funcionarios.SQL.Clear;
  dm.query_funcionarios.SQL.Add('SELECT * FROM tb_Funcionarios WHERE CPF = ' + QuotedStr(Trim(txtCPF.Text)));
  dm.query_funcionarios.Open;

  if not dm.query_funcionarios.IsEmpty then
  begin
    CPF := dm.query_funcionarios['CPF'];
    MessageDlg('O CPF ' + CPF + ' j� est� cadastrado!', mtInformation, mbOKCancel, 0);
    txtNome.Text := '';
    txtNome.SetFocus;
    exit
  end;

  associarCampos;
  dm.tb_Funcionarios.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;

end;

procedure TFrmFuncionarios.buscarCPF;
begin
  dm.query_funcionarios.Close;
  dm.query_funcionarios.SQL.Clear;
  dm.query_funcionarios.SQL.Add('SELECT * FROM tb_Funcionarios WHERE CPF = :CPF order by Nome asc');
  dm.query_funcionarios.Parameters.ParamByName('CPF').Value := txtBuscarCPF.Text;
  dm.query_funcionarios.Open;
end;

procedure TFrmFuncionarios.buscarNome;
begin
  dm.query_funcionarios.Close;
  dm.query_funcionarios.SQL.Clear;
  dm.query_funcionarios.SQL.Add('SELECT * FROM tb_Funcionarios WHERE Nome LIKE :Nome order by Nome asc');
  dm.query_funcionarios.Parameters.ParamByName('Nome').Value := txtBuscarNome.Text + '%';
  dm.query_funcionarios.Open;
end;

procedure TFrmFuncionarios.carregarCombobox1;
begin

  dm.query_cargos.Close;
  dm.query_cargos.Open;

  if not dm.query_cargos.IsEmpty then
  begin
    cbCargo.Clear;
    cbCargo.Items.Add('Selecione:');
    dm.query_cargos.First;
    while not dm.query_cargos.Eof do
    begin
      cbCargo.Items.Add(dm.query_cargos.FieldByName('Descricao_Cargos').AsString);
      dm.query_cargos.Next;
    end;
  end;

end;

procedure TFrmFuncionarios.carregarCombobox2;
begin

  dm.query_materia.Close;
  dm.query_materia.Open;

if not dm.query_materia.IsEmpty then
begin
  cbMateria.Clear;
  cbMateria.Items.Add('Selecione:');
  while not dm.query_materia.Eof do
  begin
    cbMateria.Items.Add(dm.query_materia.FieldByName('Descricao_Materia').AsString);
    dm.query_materia.Next;
  end;

end;

end;

procedure TFrmFuncionarios.cbCargoChange(Sender: TObject);
begin
  if dm.query_cargos.Locate('Descricao_Cargos', cbCargo.Text, []) then
    cbMateria.Enabled := SameText(dm.query_cargos.FieldByName('exige_materia').AsString, 'S')
  else
    cbMateria.Enabled := False;
end;

procedure TFrmFuncionarios.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_Funcionarios.Edit;

  txtNome.Text := dm.query_funcionarios.FieldByName('Nome').Value;
  txtCPF.Text := dm.query_funcionarios.FieldByName('CPF').Value;
  txtEndereco.Text := dm.query_funcionarios.FieldByName('Endereco').Value;
  txtTelefone.Text := dm.query_funcionarios.FieldByName('Telefone').Value;
  cbCargo.Text := dm.query_funcionarios.FieldByName('Cargo').Value;
  cbMateria.Text := dm.query_funcionarios.FieldByName('Materia').Value;

  id := dm.query_funcionarios.FieldByName('ID_Funcionarios').Value;

  CPFantigo :=  dm.query_funcionarios.FieldByName('CPF').Value;
end;

procedure TFrmFuncionarios.DBGrid1DblClick(Sender: TObject);
begin
  if chamada = 'Func' then
  begin
    idFunc := dm.query_funcionarios.FieldByName('ID_Funcionarios').Value;
    nomeFunc := dm.query_funcionarios.FieldByName('Nome').Value;
    cargoFunc := dm.query_funcionarios.FieldByName('Cargo').Value;
    Close;
    chamada := '';
  end;

end;

procedure TFrmFuncionarios.desabilitarCampos;
begin
  txtNome.Enabled := false;
  txtCPF.Enabled := false;
  txtEndereco.Enabled := false;
  txtTelefone.Enabled := false;
  cbCargo.Enabled := false;
  cbMateria.Enabled := false;
  cbMateria.ItemIndex := 0;
end;


procedure TFrmFuncionarios.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  dm.tb_Funcionarios.Active := true;
  listar;
  carregarCombobox1;
  carregarCombobox2;
  cbCargo.ItemIndex := 0;
  cbMateria.ItemIndex := 0;
  txtBuscarCPF.Visible := false;
  rbNome.Checked := true;
end;

procedure TFrmFuncionarios.habilitarCampos;
begin
  txtNome.Enabled := true;
  txtCPF.Enabled := true;
  txtEndereco.Enabled := true;
  txtTelefone.Enabled := true;
  cbCargo.Enabled := true;
  cbMateria.Enabled := false;

end;

procedure TFrmFuncionarios.limpar;
begin
  txtNome.Text := '';
  txtCPF.Text := '';
  txtEndereco.Text := '';
  txtTelefone.Text := '';
  cbCargo.ItemIndex := 0;

end;

procedure TFrmFuncionarios.listar;
begin
  dm.query_funcionarios.Close;
  dm.query_funcionarios.SQL.Clear;
  dm.query_funcionarios.SQL.Add('SELECT * FROM tb_Funcionarios order by Nome asc');
  dm.query_funcionarios.Open;
end;

procedure TFrmFuncionarios.rbCPFClick(Sender: TObject);
begin
  listar;
  txtBuscarCPF.Visible := true;
  txtBuscarNome.Visible := false;
end;

procedure TFrmFuncionarios.rbNomeClick(Sender: TObject);
begin
  listar;
  txtBuscarCPF.Visible := false;
  txtBuscarNome.Visible := true;
end;

procedure TFrmFuncionarios.txtBuscarCPFChange(Sender: TObject);
begin
  buscarCPF;
end;

procedure TFrmFuncionarios.txtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

end.
