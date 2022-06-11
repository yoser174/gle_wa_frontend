unit UnitWaMessages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, System.StrUtils,
  uniGUIClasses, uniGUIForm, uniEdit, Vcl.Imaging.jpeg, uniImage,
  uniGUIBaseClasses, uniPanel, uniButton, uniMemo, uniBitBtn, uniSpeedButton,
  uniMultiItem, uniListBox, uniLabel, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client, uniFileUpload;

type
  TfrmWaMessages = class(TUniForm)
    pnlFoto: TUniContainerPanel;
    imFotoPasien: TUniImage;
    edName: TUniEdit;
    edPushName: TUniEdit;
    edShortName: TUniEdit;
    mmMsg: TUniMemo;
    UniLabel1: TUniLabel;
    lsAttach: TUniListBox;
    UniBitBtn2: TUniBitBtn;
    UniBitBtn3: TUniBitBtn;
    UniBitBtn1: TUniBitBtn;
    UniFileUpload1: TUniFileUpload;
    cmdLog: TFDCommand;
    btnSend: TUniBitBtn;
    procedure UniButton3Click(Sender: TObject);
    procedure UniFormBeforeShow(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniButton2Click(Sender: TObject);
    procedure UniBitBtn2Click(Sender: TObject);
    procedure UniBitBtn3Click(Sender: TObject);
    procedure UniBitBtn1Click(Sender: TObject);
    procedure UniFileUpload1Completed(Sender: TObject; AStream: TFileStream);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  var
    number, pdf_file_encrypted: string;

  end;

function frmWaMessages: TfrmWaMessages;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, ServerModule, UnitApiWa, UnitHasilDetail;

function frmWaMessages: TfrmWaMessages;
begin
  Result := TfrmWaMessages(UniMainModule.GetFormInstance(TfrmWaMessages));
end;

procedure TfrmWaMessages.btnSendClick(Sender: TObject);
var
  bSuccess: boolean;
  outMsg: string;
  sMsg: string;
  status: integer;
  I: integer;
begin
  // message
  if mmMsg.Lines.Text <> '' then
  begin
    sMsg := '{ "message" : "' + mmMsg.Lines.Text + '", "phone" : "' +
      number + '" }';
    bSuccess := SendMessage(sMsg, outMsg);
    status := 0;
    if bSuccess then
      status := 1;
    if cmdLog.Active then
      cmdLog.Active := False;
    cmdLog.ParamByName('status').Value := status;
    cmdLog.ParamByName('nomor').Value := frmHasilDetail.nomor;
    cmdLog.ParamByName('deskripsi').Value := outMsg;
    cmdLog.Execute;

    UniSession.AddJS('Ext.toast({html: ' + outMsg +
      ', header: false, autoCloseDelay: 5000});');
  end;

  // attachment
  if lsAttach.Items.Count > 0 then
  begin
    for I := 0 to lsAttach.Items.Count - 1 do
    begin
      sMsg := '{ "pdf" : "' + EncodeFile(uniServerModule.FilesFolderPath +
        'tmp\' + lsAttach.Items[I]) + '", "phone" : "' + number +
        '", "filename" : "' + lsAttach.Items[I] + ' " } ';
      bSuccess := SendPDF(sMsg, outMsg);
      status := 0;
      if bSuccess then
        status := 1;
      if cmdLog.Active then
        cmdLog.Active := False;
      cmdLog.ParamByName('status').Value := status;
      cmdLog.ParamByName('nomor').Value := frmHasilDetail.nomor;
      cmdLog.ParamByName('deskripsi').Value := outMsg;
      cmdLog.Execute;

      UniSession.AddJS('Ext.toast({html: ' + outMsg +
        ', header: false, autoCloseDelay: 5000});');

    end;
  end;

  // refresh
  if frmHasilDetail.QKirimLog.Active then
    frmHasilDetail.QKirimLog.Active := False;
  frmHasilDetail.QKirimLog.Active := True;

end;

procedure TfrmWaMessages.UniBitBtn1Click(Sender: TObject);
begin
  if lsAttach.ItemIndex >= 0 then
    lsAttach.Items.Delete(lsAttach.ItemIndex);
end;

procedure TfrmWaMessages.UniBitBtn2Click(Sender: TObject);
begin
  UniFileUpload1.Execute;
end;

procedure TfrmWaMessages.UniBitBtn3Click(Sender: TObject);
begin
  if lsAttach.ItemIndex >= 0 then
    UniSession.SendFile(uniServerModule.FilesFolderPath + 'tmp\' +
      lsAttach.Items[lsAttach.ItemIndex]);
end;

procedure TfrmWaMessages.UniButton1Click(Sender: TObject);
var
  sMsg, outMsg: string;
begin
  sMsg := '{ "pdf" : "' + EncodeFile('D:\GSLIS_MAIL_PDF\PDF\3.pdf') +
    '", "phone" : "' + number + '" }';

  sMsg := sMsg.Replace(#13#10, '');

  if SendPDF(sMsg, outMsg) then
    UniSession.AddJS('Ext.toast({html: ' + outMsg +
      ', header: false, autoCloseDelay: 5000});');;

end;

procedure TfrmWaMessages.UniButton2Click(Sender: TObject);
var
  sMsg, name, pushname, shortName, outMsg: string;
begin
  if mmMsg.Lines.Text = '' then
  begin
    ShowMessage('Message kosong.');
    mmMsg.SetFocus;
    exit;
  end;

  sMsg := '{ "message" : "' + mmMsg.Lines.Text + '", "phone" : "' +
    number + '" }';
  if SendMessage(sMsg, outMsg) then
    UniSession.AddJS('Ext.toast({html: ' + outMsg +
      ', header: false, autoCloseDelay: 5000});');
end;

procedure TfrmWaMessages.UniButton3Click(Sender: TObject);
var
  sMsg, name, pushname, shortName, outMsg: string;
  stream: TMemoryStream;
begin
  // if not btnAttach.Enabled then
  // begin
  // ShowMessage('Attachment masih kosong, add file PDF sebelum kirim.');
  // exit;
  // end;
  //
  // sMsg := '{ "pdf" : "' + EncodeFile('D:\GSLIS_MAIL_PDF\PDF\3.pdf') +
  // '", "phone" : "' + number + '" }';
  //
  // sMsg := sMsg.Replace(#13#10, '');
  // SendPDF(sMsg, outMsg);

  exit;

end;

procedure TfrmWaMessages.UniFileUpload1Completed(Sender: TObject;
  AStream: TFileStream);
var
  DestName: string;
  DestFolder: string;
begin
  DestFolder := uniServerModule.FilesFolderPath + 'tmp\';
  DestName := DestFolder + ExtractFileName(UniFileUpload1.FileName);
  lsAttach.Items.Add(UniFileUpload1.FileName);
  CopyFile(PChar(AStream.FileName), PChar(DestName), False);

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

  lsAttach.Items.Add(pdf_file_encrypted);
end;

end.
