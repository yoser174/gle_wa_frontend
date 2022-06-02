unit UnitHasilDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniPanel, uniPageControl, uniGUIBaseClasses,
  Vcl.Imaging.jpeg, uniImage, uniURLFrame, uniBasicGrid, uniDBGrid, uniEdit,
  uniMemo, uniLabel, uniImageList, uniButton, uniBitBtn, uniSpeedButton,
  REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  System.JSON;

type
  TfrmHasilDetail = class(TUniForm)
    UniPageControl1: TUniPageControl;
    UniTabSheet1: TUniTabSheet;
    UniContainerPanel1: TUniContainerPanel;
    UniTabSheet2: TUniTabSheet;
    UniTabSheet3: TUniTabSheet;
    UniContainerPanel4: TUniContainerPanel;
    UniDBGrid1: TUniDBGrid;
    UniContainerPanel3: TUniContainerPanel;
    UniContainerPanel5: TUniContainerPanel;
    UniDBGrid2: TUniDBGrid;
    PDFFrame: TUniPDFFrame;
    pnlFoto: TUniContainerPanel;
    UniEdit1: TUniEdit;
    UniEdit2: TUniEdit;
    UniEdit3: TUniEdit;
    UniMemo1: TUniMemo;
    UniEdit4: TUniEdit;
    UniPageControl2: TUniPageControl;
    UniTabSheet4: TUniTabSheet;
    imFotoPasien: TUniImage;
    UniContainerPanel2: TUniContainerPanel;
    UniTabSheet5: TUniTabSheet;
    UniTabSheet6: TUniTabSheet;
    pnlProgressSt: TUniPanel;
    UniEdit5: TUniEdit;
    UniImageList1: TUniImageList;
    UniLabel1: TUniLabel;
    btnWa: TUniSpeedButton;
    UniSpeedButton4: TUniSpeedButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure btnWaClick(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniFormBeforeShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmHasilDetail: TfrmHasilDetail;

implementation

{$R *.dfm}

uses
  MainModule, ServerModule, uniGUIApplication, UnitWaMessages, UnitApiWa;

function frmHasilDetail: TfrmHasilDetail;
begin
  Result := TfrmHasilDetail(UniMainModule.GetFormInstance(TfrmHasilDetail));
end;

procedure TfrmHasilDetail.UniButton1Click(Sender: TObject);
var
  LJSONObject: TJSONObject;
  success, ready: string;
begin
  // UniMemo2.Lines.Add(EncodeFile('D:\GSLIS_MAIL_PDF\PDF_ENCRYPTED\xz.pdf'));

  // jValue := RESTResponse1.JSONValue;
  // // JO := TJSONObject.ParseJSONValue(RESTResponse1.JSONValue) as TJSONObject;
  //
  // if jValue.TryGetValue('success') then
  // ShowMessage(jValue.GetValue('success'));
  // if jValue.TryGetValue('ready') then
  // ShowMessage(jValue.GetValue('ready'));
  // UniMemo2.Lines.Text := jValue.ToString;
end;

procedure TfrmHasilDetail.UniFormBeforeShow(Sender: TObject);
begin
  PDFFrame.PdfURL := uniServerModule.FilesFolderURL + 'PDF/3.pdf';
end;

procedure TfrmHasilDetail.btnWaClick(Sender: TObject);
begin
  if not CheckReady then
  begin
    MessageDlg
      ('Whatsapp Service not READY. please try again later or call Support IT team.',
      mtError, [mbOK]);
    Exit;
  end;

  if not IsRegisteredUser(btnWa.Caption) then
  begin
    MessageDlg('Nomor [' + btnWa.Caption +
      '] tidak te-register di whatsapp. Cek nomor HP pasien.', mtError, [mbOK]);
    Exit;
  end;

  frmWaMessages.ShowModal;
  frmWaMessages.btnAttach.Caption := PDFFrame.PdfURL;
  frmWaMessages.number := btnWa.Caption;

end;

end.