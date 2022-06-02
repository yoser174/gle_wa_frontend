unit UnitVerifikasiAkhir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniDateTimePicker,
  uniBasicGrid, uniDBGrid, uniEdit, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniButton;

type
  TfrmVerAkhirHasil = class(TUniForm)
    UniContainerPanel2: TUniContainerPanel;
    UniContainerPanel3: TUniContainerPanel;
    UniDBGrid1: TUniDBGrid;
    QHasilPDF: TFDQuery;
    DSHasilPDF: TDataSource;
    btnDtl: TUniButton;
    procedure UniFormBeforeShow(Sender: TObject);
    procedure UniDBGrid1DrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure btnDtlClick(Sender: TObject);
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

procedure TfrmVerAkhirHasil.btnDtlClick(Sender: TObject);
begin
  frmHasilDetail.ShowModal;
  frmHasilDetail.Caption := 'Detail hasil [' + QHasilPDF.FieldByName('nomor')
    .AsString + ' ' + QHasilPDF.FieldByName('nama').AsString + ']';
end;

procedure TfrmVerAkhirHasil.UniDBGrid1DrawColumnCell(Sender: TObject;
  ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if UniDBGrid1.DataSource.DataSet.FieldByName('status_hasil').AsString = 'Pending'
  then
  begin
    // Attribs.Font.Style := [fsbold];
    // Attribs.Font.Color := clWhite; // font color
    Attribs.Color := clInactiveBorder; // background color
  end;
  if UniDBGrid1.DataSource.DataSet.FieldByName('status_hasil').AsString = 'Error'
  then
  begin
    // Attribs.Font.Style := [fsbold];
    // Attribs.Font.Color := clWhite; // font color
    Attribs.Color := clRed; // background color
  end;
  if UniDBGrid1.DataSource.DataSet.FieldByName('status_hasil').AsString = 'Ready'
  then
  begin
    // Attribs.Font.Style := [fsbold];
    // Attribs.Font.Color := clWhite; // font color
    Attribs.Color := clInfoBk; // background color
  end;
end;

procedure TfrmVerAkhirHasil.UniFormBeforeShow(Sender: TObject);
begin
  QHasilPDF.Open();
end;

end.
