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
    txtUser: TEdit;
    txtPassword: TEdit;
    btnLogin: TSpeedButton;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure btnLoginClick(Sender: TObject);
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

uses Menu;

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin
     if Trim(txtUser.Text) = '' then
     begin
        MessageDlg('Preencha o usu�rio!', mtInformation, mbOKCancel, 0);
        txtUser.SetFocus;
        exit;
     end;

      if Trim(txtPassword.Text) = '' then
     begin
        MessageDlg('Preencha a senha!', mtInformation, mbOKCancel, 0);
        txtPassword.SetFocus;
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

procedure TFrmLogin.login;
begin
//Codigo de login
  FrmMenu := TFrmMenu.Create(FrmLogin);
  FrmMenu.ShowModal;
end;

end.
