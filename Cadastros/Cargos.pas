unit Cargos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, strutils;

type
  TFrmCargos = class(TForm)
    grid: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    Label2: TLabel;
    txtNome: TEdit;
    cbExigeMateria: TCheckBox;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure associarCampos;
    procedure listar;
  public
    { Public declarations }
  end;

var
  FrmCargos: TFrmCargos;
  id : string;

implementation

{$R *.dfm}

uses Modulo;

procedure TFrmCargos.associarCampos;
begin
  dm.tb_Cargos.FieldByName('Descricao_Cargos').Value := txtNome.Text;
  dm.tb_Cargos.FieldByName('exige_materia').Value := IfThen(cbExigeMateria.Checked, 'S', 'N');
end;

procedure TFrmCargos.btnEditarClick(Sender: TObject);
var
cargo : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o cargo!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  //VERIFICAR SE O CARGO J� FOI CADASTRADO
  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add('SELECT * FROM tb_Cargos WHERE Descricao_Cargos = ' + QuotedStr(Trim(txtNome.Text)));
  dm.query_cargos.Open;

  if not dm.query_cargos.IsEmpty then
  begin
    cargo := dm.query_cargos['Descricao_Cargos'];
    MessageDlg('O cargo ' + cargo + ' j� est� cadastrado!', mtInformation, mbOKCancel, 0);
    txtNome.Text := '';
    txtNome.SetFocus;
    exit
  end;

  associarCampos;
  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add('UPDATE tb_Cargos set Descricao_Cargos = :cargo WHERE ID_Cargos = :id');
  dm.query_cargos.Parameters.ParamByName('cargo').Value := txtNome.Text;
  dm.query_cargos.Parameters.ParamByName('id').Value := id;
  dm.query_cargos.ExecSQL;

  listar;
  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  txtNome.Text := '';


end;

procedure TFrmCargos.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.query_cargos.Delete;
    MessageDlg('Deletado com sucesso!', mtInformation, mbOKCancel, 0);
    listar;
    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    txtNome.Text := '';

  end;
end;

procedure TFrmCargos.btnNovoClick(Sender: TObject);
begin
  btnSalvar.Enabled := true;
  txtNome.Enabled := true;
  txtNome.Text := '';
  txtNome.SetFocus;

  dm.tb_Cargos.Insert;
end;

procedure TFrmCargos.btnSalvarClick(Sender: TObject);
var
cargo : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o cargo!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  //VERIFICAR SE O CARGO J� FOI CADASTRADO
  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add('SELECT * FROM tb_Cargos WHERE Descricao_Cargos = ' + QuotedStr(Trim(txtNome.Text)));
  dm.query_cargos.Open;

  if not dm.query_cargos.IsEmpty then
  begin
    cargo := dm.query_cargos['Descricao_Cargos'];
    MessageDlg('O cargo ' + cargo + ' j� est� cadastrado!', mtInformation, mbOKCancel, 0);
    txtNome.Text := '';
    txtNome.SetFocus;
    exit
  end;


  associarCampos;
  dm.tb_Cargos.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
  txtNome.Text := '';
  txtNome.Enabled := false;
  btnSalvar.Enabled := false;
  cbExigeMateria.Checked := false;
  listar;
end;

procedure TFrmCargos.FormCreate(Sender: TObject);
begin
  dm.tb_Cargos.Active := true;
  listar;
end;

procedure TFrmCargos.gridCellClick(Column: TColumn);
begin
  txtNome.Enabled := true;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_Cargos.Edit;
  if dm.query_cargos.FieldByName('Descricao_Cargos').Value <> null then
  txtNome.Text := dm.query_cargos.FieldByName('Descricao_Cargos').Value;

  id := dm.query_cargos.FieldByName('ID_Cargos').Value;
end;

procedure TFrmCargos.listar;
begin
  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add('SELECT * FROM tb_Cargos order by Descricao_Cargos asc');
  dm.query_cargos.Open;
end;

end.
