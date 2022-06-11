unit UnitHasilDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniPanel, uniPageControl, uniGUIBaseClasses,
  Vcl.Imaging.jpeg, uniImage, uniURLFrame, uniBasicGrid, uniDBGrid, uniEdit,
  uniMemo, uniLabel, uniImageList, uniButton, uniBitBtn, uniSpeedButton,
  REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmHasilDetail = class(TUniForm)
    UniPageControl1: TUniPageControl;
    tsGeneral: TUniTabSheet;
    UniTabSheet2: TUniTabSheet;
    UniTabSheet3: TUniTabSheet;
    UniContainerPanel4: TUniContainerPanel;
    UniDBGrid1: TUniDBGrid;
    UniContainerPanel3: TUniContainerPanel;
    UniContainerPanel5: TUniContainerPanel;
    UniDBGrid2: TUniDBGrid;
    PDFFrame: TUniPDFFrame;
    pnlFoto: TUniContainerPanel;
    edNama: TUniEdit;
    edJk: TUniEdit;
    edTglLahir: TUniEdit;
    mmAlamat: TUniMemo;
    edPerujuk: TUniEdit;
    UniPageControl2: TUniPageControl;
    tsDemo: TUniTabSheet;
    imFotoPasien: TUniImage;
    UniContainerPanel2: TUniContainerPanel;
    UniTabSheet5: TUniTabSheet;
    pnlProgressSt: TUniPanel;
    edJanji: TUniEdit;
    UniImageList1: TUniImageList;
    UniLabel1: TUniLabel;
    btnWa: TUniSpeedButton;
    btnEmail: TUniSpeedButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    QPasien: TFDQuery;
    imWa: TUniImage;
    imEmail: TUniImage;
    lblWa: TUniLabel;
    lblEmail: TUniLabel;
    imPerujuk: TUniImage;
    lbPerujuk: TUniLabel;
    imAmbil: TUniImage;
    lblAmbil: TUniLabel;
    QPengiriman: TFDQuery;
    QDtl: TFDQuery;
    dsDtl: TDataSource;
    pFlgLunas: TUniPanel;
    UniContainerPanel6: TUniContainerPanel;
    QDtlid: TFDAutoIncField;
    QDtlheader_id: TIntegerField;
    QDtltest_kode: TStringField;
    QDtlnama_test: TStringField;
    QDtlharga: TBCDField;
    QSum: TFDQuery;
    QSumid: TFDAutoIncField;
    QSumsub_total: TBCDField;
    QSumdisc_amount: TBCDField;
    QSumtotal: TBCDField;
    QSumtagihan: TBCDField;
    QSumflgLunas: TStringField;
    edSubTotal: TUniEdit;
    edDisc: TUniEdit;
    edTotal: TUniEdit;
    edTagihan: TUniEdit;
    mmCatatanPasien: TUniMemo;
    QKirimLog: TFDQuery;
    dsKirimLog: TDataSource;
    QPdf: TFDQuery;
    QParam: TFDQuery;
    procedure btnWaClick(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniFormBeforeShow(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    pdf_file, pdf_file_encrypted: string;
  public
    { Public declarations }
    nomor: string;
    status: string;
  end;

function frmHasilDetail: TfrmHasilDetail;

implementation

{$R *.dfm}

uses
  MainModule, ServerModule, uniGUIApplication, UnitWaMessages, UnitApiWa,
  UnitEmailMessage, UnitVerifikasiAkhir;

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
var
  I: integer;
  DestName: string;
  DestFolder: string;
  tmpWa: string;
begin

  if QPdf.Active then
    QPdf.Active := False;
  QPdf.ParamByName('nomor').Value := nomor;
  QPdf.Active := True;

  // copy file pdf to temp folder
  DestFolder := uniServerModule.FilesFolderPath + 'tmp\';
  DestName := DestFolder + ExtractFileName(QPdf.FieldByName('pdf_file')
    .AsString);
  CopyFile(PChar(QPdf.FieldByName('pdf_file').AsString),
    PChar(DestName), False);

  DestName := DestFolder + ExtractFileName
    (QPdf.FieldByName('pdf_file_encrypted').AsString);
  CopyFile(PChar(QPdf.FieldByName('pdf_file_encrypted').AsString),
    PChar(DestName), False);

  pdf_file := 'tmp\' + ExtractFileName(QPdf.FieldByName('pdf_file').AsString);
  pdf_file_encrypted := 'tmp\' + ExtractFileName
    (QPdf.FieldByName('pdf_file_encrypted').AsString);

  PDFFrame.PdfURL := uniServerModule.FilesFolderURL + pdf_file;

  UniPageControl1.ActivePage := tsGeneral;
  UniPageControl2.ActivePage := tsDemo;

  //
  if QPasien.Active then
    QPasien.Active := False;
  QPasien.ParamByName('nomor').Value := nomor;
  QPasien.Active := True;

  mmCatatanPasien.Lines.Text := QPasien.FieldByName('catatan_pasien').AsString;

  if QDtl.Active then
    QDtl.Active := False;
  QDtl.ParamByName('nomor').Value := nomor;
  QDtl.Active := True;

  if QSum.Active then
    QSum.Active := False;
  QSum.ParamByName('nomor').Value := nomor;
  QSum.Active := True;

  edSubTotal.Text := FormatFloat('#,##0.00',
    QSum.FieldByName('sub_total').AsFloat);
  edDisc.Text := FormatFloat('#,##0.00',
    QSum.FieldByName('disc_amount').AsFloat);
  edTotal.Text := FormatFloat('#,##0.00', QSum.FieldByName('total').AsFloat);
  edTagihan.Text := FormatFloat('#,##0.00', QSum.FieldByName('tagihan')
    .AsFloat);

  if QKirimLog.Active then
    QKirimLog.Active := False;
  QKirimLog.ParamByName('nomor').Value := nomor;
  QKirimLog.Active := True;

  pFlgLunas.Caption := 'ADA TAGIHAN';
  pFlgLunas.Color := clYellow;

  if QSum.FieldByName('flgLunas').AsString = 'Y' then
  begin
    pFlgLunas.Caption := 'LUNAS';
    pFlgLunas.Color := clGreen;
  end;

  edNama.Text := QPasien.FieldByName('nama').AsString;
  edJk.Text := QPasien.FieldByName('jenis_kelamin').AsString;
  edTglLahir.Text := QPasien.FieldByName('tanggal_lahir').AsString;
  mmAlamat.Text := QPasien.FieldByName('alamat').AsString;
  edPerujuk.Text := QPasien.FieldByName('perujuk').AsString;
  edJanji.Text := QPasien.FieldByName('janji_hasil').AsString;

  pnlProgressSt.Caption := status;

  if status = 'Ready' then
    pnlProgressSt.Color := clGreen;

  if status = 'Pending' then
    pnlProgressSt.Color := clYellow;

  if QPengiriman.Active then
    QPengiriman.Active := False;
  QPengiriman.ParamByName('nomor').Value := nomor;
  QPengiriman.Active := True;

  if QPengiriman.RecordCount > 0 then
  begin
    lblEmail.Caption := 'N/A';
    lblAmbil.Caption := 'N/A';
    lblWa.Caption := 'N/A';
    lbPerujuk.Caption := 'N/A';
    btnWa.Enabled := False;
    btnEmail.Enabled := False;

    QPengiriman.First;
    while not QPengiriman.Eof do
    begin

      if QPengiriman.FieldByName('metode').Value = 'whatsapp' then
      begin
        imWa.Enabled := True;
        lblWa.Caption := QPengiriman.FieldByName('data').Value;
        btnWa.Enabled := True;
        btnWa.Caption := QPengiriman.FieldByName('data').Value;
        if btnWa.Caption[1] = '0' then
        begin
          tmpWa := '62';
          for I := 2 to Length(btnWa.Caption) do
            tmpWa := tmpWa + btnWa.Caption[I];
          btnWa.Caption := tmpWa;

        end;

      end;

      if QPengiriman.FieldByName('metode').Value = 'email' then
      begin
        imEmail.Enabled := True;
        lblEmail.Caption := QPengiriman.FieldByName('data').Value;
        btnEmail.Enabled := True;
        btnEmail.Caption := QPengiriman.FieldByName('data').Value;
      end;

      if QPengiriman.FieldByName('metode').Value = 'perujuk' then
      begin
        imPerujuk.Enabled := True;
        lbPerujuk.Caption := QPengiriman.FieldByName('data').Value;
      end;

      if QPengiriman.FieldByName('metode').Value = 'ambil' then
      begin
        imAmbil.Enabled := True;
        lblAmbil.Caption := 'Ambil';
      end;
      QPengiriman.Next;
    end;

  end;

end;

procedure TfrmHasilDetail.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // delete file tmp
  DeleteFile(uniServerModule.FilesFolderPath + pdf_file);
  DeleteFile(uniServerModule.FilesFolderPath + pdf_file_encrypted);
end;

procedure TfrmHasilDetail.btnEmailClick(Sender: TObject);
begin
  frmEmailMessages.pdf_file_encrypted := pdf_file_encrypted.Replace('tmp\', '');
  frmEmailMessages.edReceipt.Text := btnEmail.Caption;

  if QParam.Active then
    QParam.Active := False;
  QParam.ParamByName('name').Value := 'MAIL_SUBJECT_FORMAT';
  QParam.Active := True;
  frmEmailMessages.edSubject.Text := QParam.FieldByName('value_char')
    .AsString.Replace('[nama_pasien]', edNama.Text).Replace('[tanggal]',
    frmVerAkhirHasil.QHasilPDF.FieldByName('tanggal').AsString);

  if QParam.Active then
    QParam.Active := False;
  QParam.ParamByName('name').Value := 'MAIL_BODY_FORMAT';
  QParam.Active := True;
  frmEmailMessages.mmMessage.Lines.Text :=
    QParam.FieldByName('value_text').AsString;

  frmEmailMessages.ShowModal;
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

  frmWaMessages.pdf_file_encrypted := pdf_file_encrypted.Replace('tmp\', '');

  frmWaMessages.ShowModal;
//  frmWaMessages.btnAttach.Caption := PDFFrame.PdfURL;
  frmWaMessages.number := btnWa.Caption;

  if QParam.Active then
    QParam.Active := False;
  QParam.ParamByName('name').Value := 'MAIL_BODY_FORMAT';
  QParam.Active := True;
  frmWaMessages.mmMsg.Lines.Text := QParam.FieldByName('value_text').AsString;

end;

end.
