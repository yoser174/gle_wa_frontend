object frmVerAkhirHasil: TfrmVerAkhirHasil
  Left = 0
  Top = 0
  ClientHeight = 540
  ClientWidth = 1014
  Caption = 'Verifikasi akhir hasil'
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnBeforeShow = UniFormBeforeShow
  PixelsPerInch = 96
  TextHeight = 13
  object UniContainerPanel2: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 1014
    Height = 504
    Hint = ''
    ParentColor = False
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 168
    ExplicitTop = 120
    ExplicitWidth = 256
    ExplicitHeight = 128
    object UniDBGrid1: TUniDBGrid
      Left = 0
      Top = 0
      Width = 1014
      Height = 504
      Hint = ''
      DataSource = DSHasilPDF
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgAutoRefreshRow]
      LoadMask.Message = 'Loading data...'
      Align = alClient
      TabOrder = 1
      OnDrawColumnCell = UniDBGrid1DrawColumnCell
      Columns = <
        item
          FieldName = 'tanggal'
          Title.Caption = 'Tanggal'
          Width = 64
        end
        item
          FieldName = 'nomor'
          Title.Caption = 'Nomor'
          Width = 72
        end
        item
          FieldName = 'nama'
          Title.Caption = 'Nama'
          Width = 196
        end
        item
          FieldName = 'jk'
          Title.Caption = 'Jns. Kel'
          Width = 65
        end
        item
          FieldName = 'tanggal_lahir'
          Title.Caption = 'Tgl. lahir'
          Width = 64
        end
        item
          FieldName = 'alamat'
          Title.Caption = 'Alamat'
          Width = 417
        end
        item
          FieldName = 'status_hasil'
          Title.Caption = 'Status hasil'
          Width = 84
        end>
    end
  end
  object UniContainerPanel3: TUniContainerPanel
    Left = 0
    Top = 504
    Width = 1014
    Height = 36
    Hint = ''
    ParentColor = False
    Align = alBottom
    TabOrder = 1
    object btnDtl: TUniButton
      Left = 936
      Top = 6
      Width = 75
      Height = 25
      Hint = ''
      Caption = 'Detail...'
      TabOrder = 1
      OnClick = btnDtlClick
    end
  end
  object QHasilPDF: TFDQuery
    Connection = UniMainModule.FDConnection1
    SQL.Strings = (
      
        'SELECT h.id,date(h.tanggal) tanggal,h.nomor,p.nama,jk.nama jk,p.' +
        'tanggal_lahir,p.alamat,r.id pdf_id,'
      'case when r.id IS NULL then '#39'Pending'#39' '
      '-- when LOAD_FILE(r.pdf_file) IS NULL  THEN '#39'Error'#39
      'when r.status_id = 0 then '#39'Ready'#39
      'when r.status_id = 1 then '#39'Partial'#39
      'ELSE '#39'Completed'#39' end status_hasil'
      'FROM'
      'order_header h'
      'LEFT JOIN pasien p ON h.pasien_id = p.id'
      'LEFT JOIN jenis_kelamin jk ON p.jenis_kelamin_id = jk.id'
      'LEFT JOIN result_pdf r ON h.id = r.header_id'
      'WHERE'
      'date(h.tanggal) = '#39'2020-12-16'#39
      'order by h.tanggal desc')
    Left = 744
    Top = 16
  end
  object DSHasilPDF: TDataSource
    DataSet = QHasilPDF
    Left = 792
    Top = 16
  end
end
