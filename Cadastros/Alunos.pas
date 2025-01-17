unit Alunos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFrmAluno = class(TForm)
    txtBuscarNome: TEdit;
    rbNome: TRadioButton;
    rbMatricula: TRadioButton;
    txtBuscarMatricula: TMaskEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    cbSerie: TComboBox;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnEditar: TSpeedButton;
    txtMatricula: TMaskEdit;
    txtEndereco: TEdit;
    txtNome: TEdit;
    txtTelefone: TMaskEdit;
    txtResponsavel: TEdit;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure txtBuscarNomeChange(Sender: TObject);
    procedure txtBuscarMatriculaChange(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbMatriculaClick(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;

    procedure carregarCombobox;
    procedure buscarNome;
    procedure buscarMatricula;
  public
    { Public declarations }
  end;

var
  FrmAluno: TFrmAluno;
  id : string;
  MatricAntiga : string;

implementation

{$R *.dfm}

uses Modulo;

{ FrmAluno }

procedure TFrmAluno.associarCampos;
begin
  dm.tb_Aluno.FieldByName('Nome').Value := txtNome.Text;
  dm.tb_Aluno.FieldByName('Matricula').Value := txtMatricula.Text;
  dm.tb_Aluno.FieldByName('Responsavel').Value := txtResponsavel.Text;
  dm.tb_Aluno.FieldByName('Telefone').Value := txtTelefone.Text;
  dm.tb_Aluno.FieldByName('Endereco').Value := txtEndereco.Text;
  dm.tb_Aluno.FieldByName('Serie').Value := cbSerie.Text;

end;

procedure TFrmAluno.btnEditarClick(Sender: TObject);
var
Matricula : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  if Trim(txtMatricula.Text) = '' then
  begin
    MessageDlg('Preencha a Matr�cula!', mtInformation, mbOKCancel, 0);
    txtMatricula.SetFocus;
    exit
  end;

  if MatricAntiga <> txtMatricula.Text  then
    begin
      //VERIFICAR SE A MATR�CULA J� FOI CADASTRADA
      dm.query_aluno.Close;
      dm.query_aluno.SQL.Clear;
      dm.query_aluno.SQL.Add('SELECT * FROM tb_Aluno WHERE Matricula = ' + QuotedStr(Trim(txtMatricula.Text)));
      dm.query_aluno.Open;

    if not dm.query_aluno.IsEmpty then
    begin
      Matricula := dm.query_aluno['Matricula'];
      MessageDlg('A matr�cula ' + Matricula + ' j� est� cadastrada!', mtInformation, mbOKCancel, 0);
      txtNome.Text := '';
      txtNome.SetFocus;
      exit
    end;
  end;

  if Trim(txtResponsavel.Text) = '' then
  begin
    MessageDlg('Preencha o respons�vel!', mtInformation, mbOKCancel, 0);
    txtResponsavel.SetFocus;
    exit
  end;

   if Trim(txtTelefone.Text) = '' then
  begin
    MessageDlg('Preencha o telefone!', mtInformation, mbOKCancel, 0);
    txtTelefone.SetFocus;
    exit
  end;

  if Trim(txtEndereco.Text) = '' then
  begin
    MessageDlg('Preencha o endere�o!', mtInformation, mbOKCancel, 0);
    txtEndereco.SetFocus;
    exit
  end;


  associarCampos;
  dm.query_aluno.Close;
  dm.query_aluno.SQL.Clear;
  dm.query_aluno.SQL.Add('UPDATE tb_Aluno set Nome = :Nome, Matricula = :Matricula, Responsavel = :Responsavel, Telefone = :Telefone, Endereco = :Endereco,  Serie = :Serie WHERE ID_Aluno = :id');
  dm.query_aluno.Parameters.ParamByName('Nome').Value := txtNome.Text;
  dm.query_aluno.Parameters.ParamByName('Matricula').Value := txtMatricula.Text;
  dm.query_aluno.Parameters.ParamByName('Responsavel').Value := txtResponsavel.Text;
  dm.query_aluno.Parameters.ParamByName('Telefone').Value := txtTelefone.Text;
  dm.query_aluno.Parameters.ParamByName('Endereco').Value := txtEndereco.Text;
  dm.query_aluno.Parameters.ParamByName('Serie').Value := cbSerie.Text;
  dm.query_aluno.Parameters.ParamByName('id').Value := id;
  dm.query_aluno.ExecSQL;

  listar;
  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;

end;

procedure TFrmAluno.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.query_aluno.Delete;
    MessageDlg('Deletado com sucesso!', mtInformation, mbOKCancel, 0);
    listar;
    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    txtNome.Text := '';
    limpar;

  end;
end;

procedure TFrmAluno.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  txtNome.SetFocus;
  dm.tb_Aluno.Insert;
  btnSalvar.Enabled := true;
end;

procedure TFrmAluno.btnSalvarClick(Sender: TObject);
var
Matricula : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  if Trim(txtMatricula.Text) = '' then
  begin
    MessageDlg('Preencha a matr�cula!', mtInformation, mbOKCancel, 0);
    txtMatricula.SetFocus;
    exit
  end;

  if Trim(txtResponsavel.Text) = '' then
  begin
    MessageDlg('Preencha o respons�vel!', mtInformation, mbOKCancel, 0);
    txtResponsavel.SetFocus;
    exit
  end;

  if Trim(txtTelefone.Text) = '' then
  begin
    MessageDlg('Preencha o telefone!', mtInformation, mbOKCancel, 0);
    txtTelefone.SetFocus;
    exit
  end;

  if Trim(txtEndereco.Text) = '' then
  begin
    MessageDlg('Preencha o endere�o!', mtInformation, mbOKCancel, 0);
    txtEndereco.SetFocus;
    exit
  end;



  //VERIFICAR SE A MATR�CULA J� FOI CADASTRADA
  dm.query_aluno.Close;
  dm.query_aluno.SQL.Clear;
  dm.query_aluno.SQL.Add('SELECT * FROM tb_Aluno WHERE Matricula = ' + QuotedStr(Trim(txtMatricula.Text)));
  dm.query_aluno.Open;

  if not dm.query_aluno.IsEmpty then
  begin
    Matricula := dm.query_aluno['Matricula'];
    MessageDlg('A matr�cula ' + Matricula + ' j� est� cadastrada!', mtInformation, mbOKCancel, 0);
    txtNome.Text := '';
    txtNome.SetFocus;
    exit
  end;

  associarCampos;
  dm.tb_Aluno.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;

end;

procedure TFrmAluno.buscarMatricula;
begin
  dm.query_aluno.Close;
  dm.query_aluno.SQL.Clear;
  dm.query_aluno.SQL.Add('SELECT * FROM tb_Aluno WHERE Matricula = :Matricula order by Nome asc');
  dm.query_aluno.Parameters.ParamByName('Matricula').Value := txtBuscarMatricula.Text;
  dm.query_aluno.Open;
end;

procedure TFrmAluno.buscarNome;
begin
  dm.query_aluno.Close;
  dm.query_aluno.SQL.Clear;
  dm.query_aluno.SQL.Add('SELECT * FROM tb_Aluno WHERE Nome LIKE :Nome order by Nome asc');
  dm.query_aluno.Parameters.ParamByName('Nome').Value := txtBuscarNome.Text + '%';
  dm.query_aluno.Open;
end;

procedure TFrmAluno.carregarCombobox;
begin

  dm.query_serie.Close;
  dm.query_serie.Open;

if not dm.query_serie.IsEmpty then
begin
  while not dm.query_serie.Eof do
  begin
    cbSerie.Items.Add(dm.query_serie.FieldByName('Descricao_Serie').AsString);
    dm.query_serie.Next;

  end;

end;

end;


procedure TFrmAluno.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_Aluno.Edit;

  txtNome.Text := dm.query_aluno.FieldByName('Nome').Value;
  txtMatricula.Text := dm.query_aluno.FieldByName('Matricula').Value;
  txtResponsavel.Text := dm.query_aluno.FieldByName('Responsavel').Value;
  txtTelefone.Text := dm.query_aluno.FieldByName('Telefone').Value;
  txtEndereco.Text := dm.query_aluno.FieldByName('Endereco').Value;
  cbSerie.Text := dm.query_aluno.FieldByName('Serie').Value;

  id := dm.query_aluno.FieldByName('ID_Aluno').Value;

  MatricAntiga :=  dm.query_aluno.FieldByName('Matricula').Value;
end;

procedure TFrmAluno.desabilitarCampos;
begin
 txtNome.Enabled := false;
 txtMatricula.Enabled := false;
 txtResponsavel.Enabled := false;
 txtTelefone.Enabled := false;
 txtEndereco.Enabled := false;
 cbSerie.Enabled := false;

end;


procedure TFrmAluno.FormShow(Sender: TObject);
begin
desabilitarCampos;
dm.tb_Aluno.Active := true;
listar;
carregarCombobox;
cbSerie.ItemIndex := 0;
txtBuscarMatricula.Visible := false;
rbNome.Checked := true;
end;

procedure TFrmAluno.habilitarCampos;
begin
  txtNome.Enabled := true;
  txtMatricula.Enabled := true;
  txtResponsavel.Enabled := true;
  txtTelefone.Enabled := true;
  txtEndereco.Enabled := true;
  cbSerie.Enabled := true;
end;

procedure TFrmAluno.limpar;
begin
  txtNome.Text := '';
  txtMatricula.Text := '';
  txtResponsavel.Text := '';
  txtEndereco.Text := '';
  txtTelefone.Text := '';
  cbSerie.ItemIndex := 0;

end;

procedure TFrmAluno.listar;
begin
  dm.query_aluno.Close;
  dm.query_aluno.SQL.Clear;
  dm.query_aluno.SQL.Add('SELECT * FROM tb_Aluno order by Nome asc');
  dm.query_aluno.Open;
end;

procedure TFrmAluno.rbMatriculaClick(Sender: TObject);
begin
  listar;
  txtBuscarMatricula.Visible := true;
  txtBuscarNome.Visible := false;
end;

procedure TFrmAluno.rbNomeClick(Sender: TObject);
begin
  listar;
  txtBuscarMatricula.Visible := false;
  txtBuscarNome.Visible := true;
end;

procedure TFrmAluno.txtBuscarMatriculaChange(Sender: TObject);
begin
  buscarMatricula;
end;

procedure TFrmAluno.txtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

end.
