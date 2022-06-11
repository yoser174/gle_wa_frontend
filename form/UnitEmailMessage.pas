unit UnitEmailMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniEdit, uniMemo, uniMultiItem,
  uniListBox, uniLabel, uniButton, uniFileUpload, uniBitBtn, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client;

type
  TfrmEmailMessages = class(TUniForm)
    edSubject: TUniEdit;
    edReceipt: TUniEdit;
    mmMessage: TUniMemo;
    lsAttach: TUniListBox;
    UniLabel1: TUniLabel;
    uniFileUpload: TUniFileUpload;
    UniBitBtn2: TUniBitBtn;
    UniFileUpload1: TUniFileUpload;
    UniBitBtn1: TUniBitBtn;
    UniBitBtn3: TUniBitBtn;
    btnSend: TUniBitBtn;
    cmdLog: TFDCommand;
    procedure UniButton1Click(Sender: TObject);
    procedure UniFileUploadMultiCompleted(Sender: TObject;
      Files: TUniFileInfoArray);
    procedure UniBitBtn2Click(Sender: TObject);
    procedure UniFileUpload1Completed(Sender: TObject; AStream: TFileStream);
    procedure UniBitBtn1Click(Sender: TObject);
    procedure UniBitBtn3Click(Sender: TObject);
    procedure UniFormBeforeShow(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pdf_file_encrypted: string;
  end;

function frmEmailMessages: TfrmEmailMessages;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, ServerModule, UnitApiWa, UnitHasilDetail;

function frmEmailMessages: TfrmEmailMessages;
begin
  Result := TfrmEmailMessages(UniMainModule.GetFormInstance(TfrmEmailMessages));
end;

procedure TfrmEmailMessages.btnSendClick(Sender: TObject);
var
  bSuccess: boolean;
  sMsg, sMsgAttch, outMsg: string;
  status, I: integer;
begin
  btnSend.Enabled := False;
  sMsgAttch := '';

  if lsAttach.Items.Count > 0 then
  begin
    for I := 0 to lsAttach.Items.Count - 1 do
    begin
      if I > 0 then
        sMsgAttch := sMsgAttch + ',';

      sMsgAttch := sMsgAttch + '{ "filename" : "' + lsAttach.Items[I] +
        '", "encoding" : "base64","content" : "' +
        EncodeFile(uniServerModule.FilesFolderPath + 'tmp\' + lsAttach.Items
        [I]) + '" }';
    end;
  end;

  sMsg := '{ "subject" : "' + edSubject.Text + '", ' + '"text" : "' +
    mmMessage.Lines.Text + '", ' + '"to" : "' + edReceipt.Text + '",' +
    '"attachments" : [ ' + sMsgAttch + '] }';

  mmMessage.Lines.Text := sMsg;
  bSuccess := SendEmail(sMsg, outMsg);

  status := 0;
  if bSuccess then
    status := 1;
  if cmdLog.Active then
    cmdLog.Active := False;
  cmdLog.ParamByName('status').Value := status;
  cmdLog.ParamByName('nomor').Value := frmHasilDetail.nomor;
  cmdLog.ParamByName('deskripsi').Value := outMsg;
  cmdLog.Execute;
  // refresh
  if frmHasilDetail.QKirimLog.Active then
    frmHasilDetail.QKirimLog.Active := False;
  frmHasilDetail.QKirimLog.Active := True;

  btnSend.Enabled := True;

  // log result
  if not bSuccess then
  begin
    MessageDlg(outMsg, mtError, [mbOk]);
    exit;
  end;

  UniSession.AddJS('Ext.toast({html: ' + outMsg +
    ', header: false, autoCloseDelay: 5000});');
  Close;

end;

procedure TfrmEmailMessages.UniBitBtn1Click(Sender: TObject);
begin
  if lsAttach.ItemIndex >= 0 then
    lsAttach.Items.Delete(lsAttach.ItemIndex);
end;

procedure TfrmEmailMessages.UniBitBtn2Click(Sender: TObject);
begin
  UniFileUpload1.Execute;
end;

procedure TfrmEmailMessages.UniBitBtn3Click(Sender: TObject);
begin
  if lsAttach.ItemIndex >= 0 then
    UniSession.SendFile(uniServerModule.FilesFolderPath + 'tmp\' +
      lsAttach.Items[lsAttach.ItemIndex]);
end;

procedure TfrmEmailMessages.UniButton1Click(Sender: TObject);
begin
  uniFileUpload.Execute;
end;

procedure TfrmEmailMessages.UniFileUpload1Completed(Sender: TObject;
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

procedure TfrmEmailMessages.UniFileUploadMultiCompleted(Sender: TObject;
  Files: TUniFileInfoArray);
var
  I: integer;
begin
  for I := Low(Files) to High(Files) do
    if Assigned(Files[I].Stream) then
      lsAttach.Items.Add(Files[I].FileName);

end;

procedure TfrmEmailMessages.UniFormBeforeShow(Sender: TObject);
begin
  lsAttach.Items.Add(pdf_file_encrypted);
end;

end.
