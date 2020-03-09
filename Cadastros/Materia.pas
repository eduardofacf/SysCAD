unit Materia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmMateria = class(TForm)
    grid: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    Label2: TLabel;
    txtNome: TEdit;
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
  FrmMateria: TFrmMateria;
  id : string;

implementation

{$R *.dfm}

uses Modulo;

procedure TFrmMateria.associarCampos;
begin
  dm.tb_Materia.FieldByName('Descricao_Materia').Value := txtNome.Text;
end;

procedure TFrmMateria.btnEditarClick(Sender: TObject);
var
materia : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha a matéria!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  //VERIFICAR SE A MATÉRIA JÁ FOI CADASTRADA
  dm.query_materia.Close;
  dm.query_materia.SQL.Clear;
  dm.query_materia.SQL.Add('SELECT * FROM tb_Materia WHERE Descricao_Materia = ' + QuotedStr(Trim(txtNome.Text)));
  dm.query_materia.Open;

  if not dm.query_materia.IsEmpty then
  begin
    materia := dm.query_materia['Descricao_Materia'];
    MessageDlg('A matéria ' + materia + ' já está cadastrada!', mtInformation, mbOKCancel, 0);
    txtNome.Text := '';
    txtNome.SetFocus;
    exit
  end;

  associarCampos;
  dm.query_materia.Close;
  dm.query_materia.SQL.Clear;
  dm.query_materia.SQL.Add('UPDATE tb_Materia set Descricao_Materia = :materia WHERE ID_Materia = :id');
  dm.query_materia.Parameters.ParamByName('materia').Value := txtNome.Text;
  dm.query_materia.Parameters.ParamByName('id').Value := id;
  dm.query_materia.ExecSQL;

  listar;
  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  txtNome.Text := '';


end;

procedure TFrmMateria.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tb_Materia.Delete;
    MessageDlg('Deletado com sucesso!', mtInformation, mbOKCancel, 0);
    listar;
    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    txtNome.Text := '';

  end;
end;

procedure TFrmMateria.btnNovoClick(Sender: TObject);
begin
  btnSalvar.Enabled := true;
  txtNome.Enabled := true;
  txtNome.Text := '';
  txtNome.SetFocus;

  dm.tb_Materia.Insert;
end;

procedure TFrmMateria.btnSalvarClick(Sender: TObject);
var
materia : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha a matéria!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  //VERIFICAR SE O CARGO JÁ FOI CADASTRADO
  dm.query_materia.Close;
  dm.query_materia.SQL.Clear;
  dm.query_materia.SQL.Add('SELECT * FROM tb_Materia WHERE Descricao_Materia = ' + QuotedStr(Trim(txtNome.Text)));
  dm.query_materia.Open;

  if not dm.query_materia.IsEmpty then
  begin
    materia := dm.query_materia['Descricao_Materia'];
    MessageDlg('A matéria ' + materia + ' já está cadastrada!', mtInformation, mbOKCancel, 0);
    txtNome.Text := '';
    txtNome.SetFocus;
    exit
  end;


  associarCampos;
  dm.tb_Materia.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
  txtNome.Text := '';
  txtNome.Enabled := false;
  btnSalvar.Enabled := false;
  listar;
end;

procedure TFrmMateria.FormCreate(Sender: TObject);
begin
  dm.tb_Materia.Active := true;
  listar;
end;

procedure TFrmMateria.gridCellClick(Column: TColumn);
begin
  txtNome.Enabled := true;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_Materia.Edit;
  if dm.query_materia.FieldByName('Descricao_Materia').Value <> null then
  txtNome.Text := dm.query_materia.FieldByName('Descricao_Materia').Value;

  id := dm.query_materia.FieldByName('ID_Materia').Value;
end;

procedure TFrmMateria.listar;
begin
  dm.query_materia.Close;
  dm.query_materia.SQL.Clear;
  dm.query_materia.SQL.Add('SELECT * FROM tb_Materia order by Descricao_Materia asc');
  dm.query_materia.Open;
end;

end.
