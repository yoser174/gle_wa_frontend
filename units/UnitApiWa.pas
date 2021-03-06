unit UnitApiWa;

interface

uses Windows, System.Classes, System.NetEncoding, REST.Types,
  Data.Bind.Components, Soap.EncdDecd,
  REST.Client, System.JSON, System.SysUtils;

function CheckReady(): boolean;
function SendMessage(sMsg: String; var OutMsg: string): boolean;
function SendPDF(sMsg: String; var OutMsg: string): boolean;
function SendEmail(sMsg: String; var OutMsg: string): boolean;
function IsRegisteredUser(number: string): boolean;
function GetProfilePic(number: string; var picUrl: string): boolean;
function GetContact(number: string; var name: string; var pushname: string;
  var shortName: string): boolean;
function EncodeFile(const FileName: string): String;

implementation

const
  WA_API_HOST = 'http://127.0.0.1:5000';

procedure DebugMsg(const Msg: String);
begin
  OutputDebugString(PChar(Msg + char(10)));
end;

function EncodeFile(const FileName: string): String;
var
  stream: TMemoryStream;
begin
  stream := TMemoryStream.Create;
  try
    stream.LoadFromFile(FileName);
    Result := String(EncodeBase64(stream.Memory, stream.Size))
      .Replace(#13#10, '');
  finally
    stream.Free;
  end;
end;

function GetApi(path: string): string;
var
  ResReq: TRESTRequest;
  ResResp: TRESTResponse;
  ResCli: TRESTClient;
begin
  ResCli := TRESTClient.Create(nil);
  ResCli.BaseURL := WA_API_HOST + path;
  DebugMsg('GetApi Url:' + ResCli.BaseURL);
  ResResp := TRESTResponse.Create(nil);
  ResReq := TRESTRequest.Create(nil);
  ResReq.Response := ResResp;
  ResReq.Client := ResCli;
  ResReq.Execute;
  Result := ResResp.Content;
end;

function PostApi(path: string; jsRequest: TJSONObject): string;
var
  ResReq: TRESTRequest;
  ResResp: TRESTResponse;
  ResCli: TRESTClient;
begin
  ResCli := TRESTClient.Create(nil);
  ResCli.BaseURL := WA_API_HOST + path;
  DebugMsg('GetApi Url:' + ResCli.BaseURL);
  ResResp := TRESTResponse.Create(nil);
  ResReq := TRESTRequest.Create(nil);
  ResReq.Response := ResResp;
  ResReq.Client := ResCli;
  ResReq.Method := rmPOST;
  ResReq.AddBody(jsRequest);
  ResReq.Execute;
  Result := ResResp.Content;
end;

function CheckReady(): boolean;
var
  LJSONObject: TJSONObject;
  Content, success, ready: string;
begin
  Content := GetApi('/auth/checkready');
  DebugMsg('CheckReady:' + Content);

  LJSONObject := nil;
  try
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Content),
      0) as TJSONObject;

    success := LJSONObject.Values['success'].ToString;
    ready := LJSONObject.Values['ready'].ToString;
  finally
    LJSONObject.Free;
  end;

  if UpperCase(ready) = 'TRUE' then
    Result := True
  else
    Result := False;
end;

function SendMessage(sMsg: String; var OutMsg: string): boolean;
var
  LJSONObject, jsRequest: TJSONObject;
  Content, success: string;
begin
  jsRequest := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(sMsg), 0)
    as TJSONObject;

  Content := PostApi('/chat/sendmessage', jsRequest);
  DebugMsg('SendMessage:' + Content);

  LJSONObject := nil;
  try
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Content),
      0) as TJSONObject;

    success := LJSONObject.Values['success'].ToString;
    OutMsg := LJSONObject.Values['message'].ToString;
  finally
    LJSONObject.Free;
  end;

  if UpperCase(success) = 'TRUE' then
    Result := True
  else
    Result := False;
end;

function SendPDF(sMsg: String; var OutMsg: string): boolean;
var
  LJSONObject, jsRequest: TJSONObject;
  Content, success: string;
begin
  jsRequest := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(sMsg), 0)
    as TJSONObject;

  Content := PostApi('/chat/sendpdf', jsRequest);
  DebugMsg('SendMessage:' + Content);

  LJSONObject := nil;
  try
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Content),
      0) as TJSONObject;

    success := LJSONObject.Values['success'].ToString;
    OutMsg := LJSONObject.Values['message'].ToString;
  finally
    LJSONObject.Free;
  end;

  if UpperCase(success) = 'TRUE' then
    Result := True
  else
    Result := False;
end;

function IsRegisteredUser(number: string): boolean;
var
  LJSONObject: TJSONObject;
  Content, success, sMessage: string;
begin
  Content := GetApi('/contact/isregistereduser/' + number);

  DebugMsg('IsRegisteredUser:' + Content);

  LJSONObject := nil;
  try
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Content),
      0) as TJSONObject;

    success := LJSONObject.Values['success'].ToString;

  finally
    LJSONObject.Free;
  end;
  DebugMsg('success:' + success);
  DebugMsg('success:' + UpperCase(Trim(success)));
  if UpperCase(Trim(success)) = 'TRUE' then
    Result := True
  else
    Result := False;
end;

function GetProfilePic(number: string; var picUrl: string): boolean;
var
  LJSONObject: TJSONObject;
  Content, success, sMessage: string;
begin
  Content := GetApi('/contact/getprofilepic/' + number);

  DebugMsg('GetProfilePic:' + Content);

  LJSONObject := nil;
  try
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Content),
      0) as TJSONObject;

    success := LJSONObject.Values['success'].ToString;
    sMessage := LJSONObject.Values['message'].ToString;
  finally
    LJSONObject.Free;
  end;
  DebugMsg('success:' + success);
  DebugMsg('sMessage:' + sMessage);
  sMessage := sMessage.Replace('\/', '/');
  sMessage := sMessage.Replace('"', '');

  picUrl := sMessage;
  if UpperCase(Trim(success)) = 'TRUE' then
    Result := True
  else
    Result := False;
end;

function GetContact(number: string; var name: string; var pushname: string;
  var shortName: string): boolean;
var
  LJSONObject, ContactObj: TJSONObject;
  Content, success, sMessage: string;
begin
  Content := GetApi('/contact/getcontact/' + number);

  DebugMsg('GetContact:' + Content);

  LJSONObject := nil;
  try
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Content),
      0) as TJSONObject;

    success := LJSONObject.Values['success'].ToString;
    ContactObj := LJSONObject.Values['contact'] as TJSONObject;
    name := '';
    pushname := '';
    shortName := '';

    try
      name := ContactObj.Values['name'].ToString.Replace('"', '');
      pushname := ContactObj.Values['pushname'].ToString.Replace('"', '');
      shortName := ContactObj.Values['shortName'].ToString.Replace('"', '');
    except
      DebugMsg('Warning cannot get detail contats, posbile not in contact yet.');
    end;
  finally
    LJSONObject.Free;
  end;
  DebugMsg('success:' + success);
  DebugMsg('name:' + name);
  DebugMsg('pushname:' + pushname);
  DebugMsg('shortName:' + shortName);

  if UpperCase(Trim(success)) = 'TRUE' then
    Result := True
  else
    Result := False;
end;

function SendEmail(sMsg: String; var OutMsg: string): boolean;
var
  LJSONObject, jsRequest: TJSONObject;
  Content, success: string;
begin
  DebugMsg('SendEmail:' + sMsg);
  DebugMsg('sMsg:' + sMsg);
  jsRequest := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(sMsg), 0)
    as TJSONObject;
  Content := PostApi('/mailer/sendmailpdf', jsRequest);

  LJSONObject := nil;
  try
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Content),
      0) as TJSONObject;

    success := LJSONObject.Values['success'].ToString;
    OutMsg := LJSONObject.Values['message'].ToString;
  finally
    LJSONObject.Free;
  end;

  if UpperCase(success) = 'TRUE' then
    Result := True
  else
    Result := False;
end;

end.
