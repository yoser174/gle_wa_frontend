object frmVerAkhirHasil: TfrmVerAkhirHasil
  Left = 0
  Top = 0
  ClientHeight = 540
  ClientWidth = 1041
  Caption = 'Verifikasi akhir hasil'
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnReady = UniFormReady
  OnBeforeShow = UniFormBeforeShow
  PixelsPerInch = 96
  TextHeight = 13
  object UniContainerPanel2: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 1041
    Height = 504
    Hint = ''
    ParentColor = False
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1014
    object UniDBGrid1: TUniDBGrid
      Left = 0
      Top = 0
      Width = 1041
      Height = 504
      Hint = ''
      DataSource = DSHasilPDF
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgFilterClearButton, dgTabs, dgCancelOnExit]
      ReadOnly = True
      LoadMask.ShowMessage = False
      LoadMask.Message = 'Loading data...'
      LoadMask.Opacity = 0.400000005960464500
      TrackOver = False
      Align = alClient
      TabOrder = 1
      TabStop = False
      OnColumnFilter = UniDBGrid1ColumnFilter
      Columns = <
        item
          FieldName = 'tanggal'
          Filtering.Enabled = True
          Filtering.Editor = dtTgl
          Title.Caption = 'Tanggal'
          Width = 119
        end
        item
          FieldName = 'nomor'
          Filtering.Enabled = True
          Filtering.Editor = edNomor
          Title.Caption = 'Nomor'
          Width = 85
        end
        item
          FieldName = 'nama'
          Filtering.Enabled = True
          Filtering.Editor = edNama
          Title.Caption = 'Nama'
          Width = 246
        end
        item
          FieldName = 'jk'
          Filtering.Enabled = True
          Filtering.Editor = cbJk
          Title.Caption = 'Jenis kelamin'
          Width = 89
        end
        item
          FieldName = 'tanggal_lahir'
          Title.Caption = 'Tgl. lahir'
          Width = 78
        end
        item
          FieldName = 'alamat'
          Filtering.Enabled = True
          Filtering.Editor = edAlamat
          Title.Caption = 'Alamat'
          Width = 278
        end
        item
          FieldName = 'status_hasil'
          Filtering.Enabled = True
          Filtering.Editor = cbStatus
          Title.Caption = 'Status'
          Width = 95
        end>
    end
    object UniHiddenPanel1: TUniHiddenPanel
      Left = 368
      Top = 152
      Width = 209
      Height = 201
      Hint = ''
      Visible = True
      object edNomor: TUniEdit
        Left = 16
        Top = 44
        Width = 121
        Hint = ''
        CharEOL = #13
        Text = 'edNomor'
        TabOrder = 0
        EmptyText = 'Nomor lab...'
        ClearButton = True
      end
      object edNama: TUniEdit
        Left = 16
        Top = 72
        Width = 121
        Hint = ''
        CharEOL = #13
        Text = 'edNama'
        TabOrder = 1
        EmptyText = 'Nama...'
        ClearButton = True
      end
      object edAlamat: TUniEdit
        Left = 16
        Top = 128
        Width = 121
        Hint = ''
        CharEOL = #13
        Text = 'edAlamat'
        TabOrder = 2
        EmptyText = 'Alamat...'
        ClearButton = True
      end
      object cbJk: TUniDBLookupComboBox
        Left = 13
        Top = 100
        Width = 145
        Hint = ''
        ListField = 'nama'
        ListSource = dsJk
        KeyField = 'nama'
        ListFieldIndex = 0
        EmptyText = 'Jenis kelamin...'
        TabOrder = 3
        Color = clWindow
      end
      object dtTgl: TUniDateTimePicker
        Left = 14
        Top = 16
        Width = 120
        Hint = ''
        DateTime = 44717.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 5
      end
      object cbStatus: TUniComboBox
        Left = 16
        Top = 156
        Width = 145
        Hint = ''
        Text = 'cbStatus'
        Items.Strings = (
          'Pending'
          'Ready'
          'Partial'
          'Complete')
        TabOrder = 6
        EmptyText = 'Status hasil...'
        IconItems = <>
      end
    end
  end
  object UniContainerPanel3: TUniContainerPanel
    Left = 0
    Top = 504
    Width = 1041
    Height = 36
    Hint = ''
    ParentColor = False
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 1014
    object btnDtl: TUniButton
      Left = 963
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
      'SELECT *'
      'FROM'
      '('
      
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
      'date(h.tanggal) like :tanggal'
      'and h.nomor like :nomor'
      'and p.nama like :nama'
      'and jk.nama like :jk'
      'and p.alamat like :alamat'
      'limit 1000'
      ') d'
      'where status_hasil like :status_hasil'
      'order by nomor')
    Left = 744
    Top = 56
    ParamData = <
      item
        Name = 'TANGGAL'
        DataType = ftString
        ParamType = ptInput
        Value = '2020-12-16'
      end
      item
        Name = 'NOMOR'
        DataType = ftString
        ParamType = ptInput
        Value = '%'
      end
      item
        Name = 'NAMA'
        DataType = ftString
        ParamType = ptInput
        Value = '%'
      end
      item
        Name = 'JK'
        DataType = ftString
        ParamType = ptInput
        Value = '%'
      end
      item
        Name = 'ALAMAT'
        DataType = ftString
        ParamType = ptInput
        Value = '%'
      end
      item
        Name = 'STATUS_HASIL'
        DataType = ftString
        ParamType = ptInput
        Value = '%'
      end>
  end
  object DSHasilPDF: TDataSource
    DataSet = QHasilPDF
    Left = 792
    Top = 56
  end
  object QJk: TFDQuery
    Connection = UniMainModule.FDConnection1
    SQL.Strings = (
      'select id,nama from jenis_kelamin')
    Left = 752
    Top = 88
  end
  object dsJk: TDataSource
    DataSet = QJk
    Left = 792
    Top = 88
  end
end
