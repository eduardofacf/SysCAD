unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.Buttons;

type
  TFrmLogin = class(TForm)
    Panel1: TPanel;
    imgFundo: TImage;
    pnlLogin: TPanel;
    imgLogin: TImage;
    txtUsuario: TEdit;
    txtSenha: TEdit;
    btnLogin: TSpeedButton;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure btnLoginClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure centralizarPainel;
    procedure login;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses Menu, Modulo;

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin
     if Trim(txtUsuario.Text) = '' then
     begin
        MessageDlg('Preencha o usuário!', mtInformation, mbOKCancel, 0);
        txtUsuario.SetFocus;
        exit;
     end;

      if Trim(txtSenha.Text) = '' then
     begin
        MessageDlg('Preencha a senha!', mtInformation, mbOKCancel, 0);
        txtSenha.SetFocus;
        exit;
     end;

     login;
end;

procedure TFrmLogin.centralizarPainel;
begin
  pnlLogin.Top := (self.Height div 2) - (pnlLogin.Height div 2);
  pnlLogin.Left := (self.Width div 2) - (pnlLogin.Width div 2);
end;

procedure TFrmLogin.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
     centralizarPainel;
end;

procedure TFrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  login;
end;

procedure TFrmLogin.login;
begin
//Codigo de login
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('SELECT * FROM tb_Usuarios WHERE Usuario = :Usuario and Senha = :Senha');
  dm.query_usuarios.Parameters.ParamByName('Usuario').Value := txtUsuario.Text;
  dm.query_usuarios.Parameters.ParamByName('Senha').Value := txtSenha.Text;
  dm.query_usuarios.Open;

  if not dm.query_usuarios.IsEmpty then
    begin
      nomeUsuario := dm.query_usuarios['Usuario'];
      cargoUsuario := dm.query_usuarios['Cargo'];
      FrmMenu := TFrmMenu.Create(FrmLogin);
      txtSenha.Text := '';
      FrmMenu.ShowModal;

    end
      else
    begin
      MessageDlg('Os dados de login estão incorretos!', mtInformation, mbOKCancel, 0);
      txtUsuario.Text := '';
      txtSenha.Text := '';
      txtUsuario.SetFocus;
    end;

end;

end.
