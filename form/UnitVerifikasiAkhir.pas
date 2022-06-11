unit UnitVerifikasiAkhir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniDateTimePicker,
  uniBasicGrid, uniDBGrid, uniEdit, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniButton, uniMultiItem,
  uniComboBox, uniDBComboBox, uniDBLookupComboBox;

type
  TfrmVerAkhirHasil = class(TUniForm)
    UniContainerPanel2: TUniContainerPanel;
    UniContainerPanel3: TUniContainerPanel;
    QHasilPDF: TFDQuery;
    DSHasilPDF: TDataSource;
    btnDtl: TUniButton;
    UniDBGrid1: TUniDBGrid;
    UniHiddenPanel1: TUniHiddenPanel;
    edNomor: TUniEdit;
    edNama: TUniEdit;
    edAlamat: TUniEdit;
    cbJk: TUniDBLookupComboBox;
    dtTgl: TUniDateTimePicker;
    QJk: TFDQuery;
    dsJk: TDataSource;
    cbStatus: TUniComboBox;
    procedure UniFormBeforeShow(Sender: TObject);
    procedure UniDBGrid1DrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure btnDtlClick(Sender: TObject);
    procedure UniDBGrid1ColumnFilter(Sender: TUniDBGrid;
      const Column: TUniDBGridColumn; const Value: Variant);
    procedure UniFormReady(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmVerAkhirHasil: TfrmVerAkhirHasil;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, UnitHasilDetail;

function frmVerAkhirHasil: TfrmVerAkhirHasil;
begin
  Result := TfrmVerAkhirHasil(UniMainModule.GetFormInstance(TfrmVerAkhirHasil));
end;

procedure DebugMsg(const Msg: String);
begin
  OutputDebugString(PChar(Msg + char(10)));
end;

procedure TfrmVerAkhirHasil.btnDtlClick(Sender: TObject);
begin
  frmHasilDetail.ShowModal;
  frmHasilDetail.nomor := QHasilPDF.FieldByName('nomor').AsString;
  frmHasilDetail.status := QHasilPDF.FieldByName('status_hasil').AsString;
  frmHasilDetail.Caption := 'Detail hasil [' + QHasilPDF.FieldByName('nomor')
    .AsString + ' ' + QHasilPDF.FieldByName('nama').AsString + ']';

end;

procedure TfrmVerAkhirHasil.UniDBGrid1ColumnFilter(Sender: TUniDBGrid;
  const Column: TUniDBGridColumn; const Value: Variant);
var
  V: Variant;
  I: Integer;
begin
  if QHasilPDF.Active then
    QHasilPDF.Active := False;

  for I := 0 to Sender.Columns.Count - 1 do
  begin
    if Sender.Columns[I].Filtering.Enabled then
    begin
      V := Sender.Columns[I].Filtering.VarValue;
      if Sender.Columns[I].FieldName = 'tanggal' then
        QHasilPDF.ParamByName('tanggal').Value :=
          FormatDateTime('yyyy-mm-dd', VarToDateTime(V));
      if Sender.Columns[I].FieldName = 'nomor' then
        QHasilPDF.ParamByName('nomor').Value := '%' + VarToStr(V);
      if Sender.Columns[I].FieldName = 'nama' then
        QHasilPDF.ParamByName('nama').Value := '%' + VarToStr(V) + '%';
      if Sender.Columns[I].FieldName = 'jk' then
        QHasilPDF.ParamByName('jk').Value := '%' + VarToStr(V) + '%';
      if Sender.Columns[I].FieldName = 'alamat' then
        QHasilPDF.ParamByName('alamat').Value := '%' + VarToStr(V) + '%';
      if Sender.Columns[I].FieldName = 'status_hasil' then
        QHasilPDF.ParamByName('status_hasil').Value := '%' + VarToStr(V) + '%';
    end;
  end;

  QHasilPDF.Active := True;
end;

procedure TfrmVerAkhirHasil.UniDBGrid1DrawColumnCell(Sender: TObject;
  ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  // if UniDBGrid1.DataSource.DataSet.FieldByName('status_hasil').AsString = 'Pending'
  // then
  // begin
  // // Attribs.Font.Style := [fsbold];
  // // Attribs.Font.Color := clWhite; // font color
  // Attribs.Color := clInactiveBorder; // background color
  // end;
  // if UniDBGrid1.DataSource.DataSet.FieldByName('status_hasil').AsString = 'Error'
  // then
  // begin
  // // Attribs.Font.Style := [fsbold];
  // // Attribs.Font.Color := clWhite; // font color
  // Attribs.Color := clRed; // background color
  // end;
  // if UniDBGrid1.DataSource.DataSet.FieldByName('status_hasil').AsString = 'Ready'
  // then
  // begin
  // // Attribs.Font.Style := [fsbold];
  // // Attribs.Font.Color := clWhite; // font color
  // Attribs.Color := clInfoBk; // background color
  // end;
end;

procedure TfrmVerAkhirHasil.UniFormBeforeShow(Sender: TObject);
begin
  // QHasilPDF.Open();
  QJk.Open();
end;

procedure TfrmVerAkhirHasil.UniFormReady(Sender: TObject);
begin
  dtTgl.DateTime := now;
end;

end.
