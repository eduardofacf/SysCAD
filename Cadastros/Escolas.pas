unit Escolas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFrmEscolas = class(TForm)
    txtBuscarNome: TEdit;
    rbNome: TRadioButton;
    rbCNPJ: TRadioButton;
    txtBuscarCNPJ: TMaskEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnEditar: TSpeedButton;
    txtCNPJ: TMaskEdit;
    txtEndereco: TEdit;
    txtNome: TEdit;
    txtTelefone: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure txtBuscarNomeChange(Sender: TObject);
    procedure txtBuscarCNPJChange(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbCNPJClick(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;

    procedure buscarNome;
    procedure buscarCNPJ;
  public
    { Public declarations }
  end;

var
  FrmEscolas: TFrmEscolas;
  id : string;
  CNPJantigo : string;

implementation

{$R *.dfm}

uses Modulo;

{ TFrmEscolas }

procedure TFrmEscolas.associarCampos;
begin
  dm.tb_Escolas.FieldByName('Nome').Value := txtNome.Text;
  dm.tb_Escolas.FieldByName('CNPJ').Value := txtCNPJ.Text;
  dm.tb_Escolas.FieldByName('Endereco').Value := txtEndereco.Text;
  dm.tb_Escolas.FieldByName('Telefone').Value := txtTelefone.Text;

  end;

procedure TFrmEscolas.btnEditarClick(Sender: TObject);
var
CNPJ : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  if Trim(txtCNPJ.Text) = '' then
  begin
    MessageDlg('Preencha o CNPJ!', mtInformation, mbOKCancel, 0);
    txtCNPJ.SetFocus;
    exit
  end;

  if CNPJantigo <> txtCNPJ.Text  then
    begin
      //VERIFICAR SE O CNPJ JÁ FOI CADASTRADO
      dm.query_escolas.Close;
      dm.query_escolas.SQL.Clear;
      dm.query_escolas.SQL.Add('SELECT * FROM tb_Escolas WHERE CNPJ = ' + QuotedStr(Trim(txtCNPJ.Text)));
      dm.query_escolas.Open;

    if not dm.query_escolas.IsEmpty then
    begin
      CNPJ := dm.query_funcionarios['CNPJ'];
      MessageDlg('O CNPJ ' + CNPJ + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
      txtNome.Text := '';
      txtNome.SetFocus;
      exit
    end;
  end;

  if Trim(txtEndereco.Text) = '' then
  begin
    MessageDlg('Preencha o endereço!', mtInformation, mbOKCancel, 0);
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
  dm.query_escolas.Close;
  dm.query_escolas.SQL.Clear;
  dm.query_escolas.SQL.Add('UPDATE tb_Escolas set Nome = :Nome, CNPJ = :CNPJ, Endereco = :Endereco, Telefone = :Telefone WHERE ID_Escola = :id');
  dm.query_escolas.Parameters.ParamByName('Nome').Value := txtNome.Text;
  dm.query_escolas.Parameters.ParamByName('CNPJ').Value := txtCNPJ.Text;
  dm.query_escolas.Parameters.ParamByName('Endereco').Value := txtEndereco.Text;
  dm.query_escolas.Parameters.ParamByName('Telefone').Value := txtTelefone.Text;
  dm.query_escolas.Parameters.ParamByName('id').Value := id;
  dm.query_escolas.ExecSQL;

  listar;
  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;

end;

procedure TFrmEscolas.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.query_escolas.Delete;
    MessageDlg('Deletado com sucesso!', mtInformation, mbOKCancel, 0);
    listar;
    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    txtNome.Text := '';
    limpar;

  end;
end;

procedure TFrmEscolas.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  txtNome.SetFocus;
  dm.tb_Escolas.Insert;
  btnSalvar.Enabled := true;
end;

procedure TFrmEscolas.btnSalvarClick(Sender: TObject);
var
CNPJ : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  if Trim(txtCNPJ.Text) = '' then
  begin
    MessageDlg('Preencha o CNPJ!', mtInformation, mbOKCancel, 0);
    txtCNPJ.SetFocus;
    exit
  end;

  if Trim(txtEndereco.Text) = '' then
  begin
    MessageDlg('Preencha o endereço!', mtInformation, mbOKCancel, 0);
    txtEndereco.SetFocus;
    exit
  end;

  if Trim(txtTelefone.Text) = '' then
  begin
    MessageDlg('Preencha o telefone!', mtInformation, mbOKCancel, 0);
    txtTelefone.SetFocus;
    exit
  end;

  //VERIFICAR SE O CNPJ JÁ FOI CADASTRADO
  dm.query_escolas.Close;
  dm.query_escolas.SQL.Clear;
  dm.query_escolas.SQL.Add('SELECT * FROM tb_Escolas WHERE CNPJ = ' + QuotedStr(Trim(txtCNPJ.Text)));
  dm.query_escolas.Open;

  if not dm.query_escolas.IsEmpty then
  begin
    CNPJ := dm.query_escolas['CNPJ'];
    MessageDlg('O CNPJ ' + CNPJ + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
    txtNome.Text := '';
    txtNome.SetFocus;
    exit
  end;

  associarCampos;
  dm.tb_Escolas.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;

end;

procedure TFrmEscolas.buscarCNPJ;
begin
  dm.query_escolas.Close;
  dm.query_escolas.SQL.Clear;
  dm.query_escolas.SQL.Add('SELECT * FROM tb_Escolas WHERE CNPJ = :CNPJ order by Nome asc');
  dm.query_escolas.Parameters.ParamByName('CNPJ').Value := txtBuscarCNPJ.Text;
  dm.query_escolas.Open;
end;

procedure TFrmEscolas.buscarNome;
begin
  dm.query_escolas.Close;
  dm.query_escolas.SQL.Clear;
  dm.query_escolas.SQL.Add('SELECT * FROM tb_Escolas WHERE Nome LIKE :Nome order by Nome asc');
  dm.query_escolas.Parameters.ParamByName('Nome').Value := txtBuscarNome.Text + '%';
  dm.query_escolas.Open;
end;

procedure TFrmEscolas.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_Escolas.Edit;

  txtNome.Text := dm.query_escolas.FieldByName('Nome').Value;
  txtCNPJ.Text := dm.query_escolas.FieldByName('CNPJ').Value;
  txtEndereco.Text := dm.query_escolas.FieldByName('Endereco').Value;
  txtTelefone.Text := dm.query_escolas.FieldByName('Telefone').Value;
  id := dm.query_escolas.FieldByName('ID_Escola').Value;
  CNPJantigo :=  dm.query_escolas.FieldByName('CNPJ').Value;
end;

procedure TFrmEscolas.desabilitarCampos;
begin
  txtNome.Enabled := false;
  txtCNPJ.Enabled := false;
  txtEndereco.Enabled := false;
  txtTelefone.Enabled := false;

end;


procedure TFrmEscolas.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  dm.tb_Funcionarios.Active := true;
  listar;
  txtBuscarCNPJ.Visible := false;
  rbNome.Checked := true;
end;

procedure TFrmEscolas.habilitarCampos;
begin
  txtNome.Enabled := true;
  txtCNPJ.Enabled := true;
  txtEndereco.Enabled := true;
  txtTelefone.Enabled := true;

end;

procedure TFrmEscolas.limpar;
begin
  txtNome.Text := '';
  txtCNPJ.Text := '';
  txtEndereco.Text := '';
  txtTelefone.Text := '';
end;

procedure TFrmEscolas.listar;
begin
  dm.query_escolas.Close;
  dm.query_escolas.SQL.Clear;
  dm.query_escolas.SQL.Add('SELECT * FROM tb_Escolas order by Nome asc');
  dm.query_escolas.Open;
end;

procedure TFrmEscolas.rbCNPJClick(Sender: TObject);
begin
  listar;
  txtBuscarCNPJ.Visible := true;
  txtBuscarNome.Visible := false;
end;

procedure TFrmEscolas.rbNomeClick(Sender: TObject);
begin
  listar;
  txtBuscarCNPJ.Visible := false;
  txtBuscarNome.Visible := true;
end;

procedure TFrmEscolas.txtBuscarCNPJChange(Sender: TObject);
begin
  buscarCNPJ;
end;

procedure TFrmEscolas.txtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

end.
