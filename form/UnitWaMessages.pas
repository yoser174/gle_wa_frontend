unit UnitWaMessages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, System.StrUtils,
  uniGUIClasses, uniGUIForm, uniEdit, Vcl.Imaging.jpeg, uniImage,
  uniGUIBaseClasses, uniPanel, uniButton, uniMemo, uniBitBtn, uniSpeedButton;

type
  TfrmWaMessages = class(TUniForm)
    pnlFoto: TUniContainerPanel;
    imFotoPasien: TUniImage;
    edName: TUniEdit;
    edPushName: TUniEdit;
    edShortName: TUniEdit;
    UniButton1: TUniButton;
    mmMsg: TUniMemo;
    btnAttach: TUniSpeedButton;
    UniButton2: TUniButton;
    UniSpeedButton2: TUniSpeedButton;
    procedure UniButton3Click(Sender: TObject);
    procedure UniFormBeforeShow(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  var
    number: string;
  end;

function frmWaMessages: TfrmWaMessages;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, UnitApiWa;

function frmWaMessages: TfrmWaMessages;
begin
  Result := TfrmWaMessages(UniMainModule.GetFormInstance(TfrmWaMessages));
end;

procedure TfrmWaMessages.UniButton1Click(Sender: TObject);
var
  sMsg, OutMsg: string;
begin
  sMsg := '{ "pdf" : "' + EncodeFile('D:\GSLIS_MAIL_PDF\PDF\3.pdf') +
    '", "phone" : "' + number + '" }';

  sMsg := sMsg.Replace(#13#10, '');

  if SendPDF(sMsg, OutMsg) then
    UniSession.AddJS('Ext.toast({html: ' + OutMsg +
      ', header: false, autoCloseDelay: 5000});');;

end;

procedure TfrmWaMessages.UniButton2Click(Sender: TObject);
var
  sMsg, name, pushname, shortName, OutMsg: string;
begin
  if mmMsg.Lines.Text = '' then
  begin
    ShowMessage('Message kosong.');
    mmMsg.SetFocus;
    exit;
  end;

  sMsg := '{ "message" : "' + mmMsg.Lines.Text + '", "phone" : "' +
    number + '" }';
  if SendMessage(sMsg, OutMsg) then
    UniSession.AddJS('Ext.toast({html: ' + OutMsg +
      ', header: false, autoCloseDelay: 5000});');
end;

procedure TfrmWaMessages.UniButton3Click(Sender: TObject);
var
  sMsg, name, pushname, shortName, OutMsg: string;
  stream: TMemoryStream;
begin
  if not btnAttach.Enabled then
  begin
    ShowMessage('Attachment masih kosong, add file PDF sebelum kirim.');
    exit;
  end;

  sMsg := '{ "pdf" : "' + EncodeFile('D:\GSLIS_MAIL_PDF\PDF\3.pdf') +
    '", "phone" : "' + number + '" }';

  sMsg := sMsg.Replace(#13#10, '');
  SendPDF(sMsg, OutMsg);

  exit;

end;

procedure TfrmWaMessages.UniFormBeforeShow(Sender: TObject);
var
  picUrl, name, pushname, shortName: string;
begin
  frmWaMessages.Caption := 'Whatsapp [' + number + ']';
  if GetProfilePic(number, picUrl) then
    imFotoPasien.Url := picUrl;
  if GetContact(number, name, pushname, shortName) then
  begin
    edName.Text := name;
    edPushName.Text := pushname;
    edShortName.Text := shortName;
    if edName.Text = '' then
      edName.Text := '<blm. add contact>';
  end;
end;

end.
