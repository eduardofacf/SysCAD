unit Serie;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmSerie = class(TForm)
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
  FrmSerie: TFrmSerie;
  id : string;

implementation

{$R *.dfm}

uses Modulo;

procedure TFrmSerie.associarCampos;
begin
  dm.tb_Serie.FieldByName('Descricao_Serie').Value := txtNome.Text;
end;

procedure TFrmSerie.btnEditarClick(Sender: TObject);
var
serie : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha a série!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  //VERIFICAR SE A SÉRIE JÁ FOI CADASTRADO
  dm.query_serie.Close;
  dm.query_serie.SQL.Clear;
  dm.query_serie.SQL.Add('SELECT * FROM tb_Serie WHERE Descricao_Serie = ' + QuotedStr(Trim(txtNome.Text)));
  dm.query_serie.Open;

  if not dm.query_serie.IsEmpty then
  begin
    serie := dm.query_serie['Descricao_Serie'];
    MessageDlg('A turma ' + serie + ' já está cadastrada!', mtInformation, mbOKCancel, 0);
    txtNome.Text := '';
    txtNome.SetFocus;
    exit
  end;

  associarCampos;
  dm.query_serie.Close;
  dm.query_serie.SQL.Clear;
  dm.query_serie.SQL.Add('UPDATE tb_Serie set Descricao_Serie = :serie WHERE ID_Serie = :id');
  dm.query_serie.Parameters.ParamByName('serie').Value := txtNome.Text;
  dm.query_serie.Parameters.ParamByName('id').Value := id;
  dm.query_serie.ExecSQL;

  listar;
  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  txtNome.Text := '';


end;

procedure TFrmSerie.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.query_serie.Delete;
    MessageDlg('Deletado com sucesso!', mtInformation, mbOKCancel, 0);
    listar;
    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    txtNome.Text := '';

  end;
end;

procedure TFrmSerie.btnNovoClick(Sender: TObject);
begin
  btnSalvar.Enabled := true;
  txtNome.Enabled := true;
  txtNome.Text := '';
  txtNome.SetFocus;

  dm.tb_Serie.Insert;
end;

procedure TFrmSerie.btnSalvarClick(Sender: TObject);
var
serie : string;
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha a série!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit
  end;

  //VERIFICAR SE A SÉRIE JÁ FOI CADASTRADO
  dm.query_serie.Close;
  dm.query_serie.SQL.Clear;
  dm.query_serie.SQL.Add('SELECT * FROM tb_Serie WHERE Descricao_Serie = ' + QuotedStr(Trim(txtNome.Text)));
  dm.query_serie.Open;

  if not dm.query_serie.IsEmpty then
  begin
    serie := dm.query_serie['Descricao_Serie'];
    MessageDlg('A turma ' + serie + ' já está cadastrada!', mtInformation, mbOKCancel, 0);
    txtNome.Text := '';
    txtNome.SetFocus;
    exit
  end;


  associarCampos;
  dm.tb_Serie.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
  txtNome.Text := '';
  txtNome.Enabled := false;
  btnSalvar.Enabled := false;
  listar;
end;

procedure TFrmSerie.FormCreate(Sender: TObject);
begin
  dm.tb_Serie.Active := true;
  listar;
end;

procedure TFrmSerie.gridCellClick(Column: TColumn);
begin
  txtNome.Enabled := true;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_Serie.Edit;
  if dm.query_serie.FieldByName('Descricao_Serie').Value <> null then
  txtNome.Text := dm.query_serie.FieldByName('Descricao_Serie').Value;

  id := dm.query_serie.FieldByName('ID_Serie').Value;
end;

procedure TFrmSerie.listar;
begin
  dm.query_serie.Close;
  dm.query_serie.SQL.Clear;
  dm.query_serie.SQL.Add('SELECT * FROM tb_Serie order by Descricao_Serie asc');
  dm.query_serie.Open;
end;

end.
