object frmEmailMessages: TfrmEmailMessages
  Left = 0
  Top = 0
  ClientHeight = 513
  ClientWidth = 716
  Caption = 'Email message'
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnBeforeShow = UniFormBeforeShow
  DesignSize = (
    716
    513)
  PixelsPerInch = 96
  TextHeight = 13
  object edSubject: TUniEdit
    Left = 8
    Top = 8
    Width = 700
    Hint = ''
    Text = 'edSubject'
    TabOrder = 0
    FieldLabel = 'Subject'
    FieldLabelWidth = 70
  end
  object edReceipt: TUniEdit
    Left = 8
    Top = 36
    Width = 700
    Hint = ''
    Text = 'edSubject'
    TabOrder = 1
    FieldLabel = 'Receipt'
    FieldLabelWidth = 70
  end
  object mmMessage: TUniMemo
    Left = 8
    Top = 64
    Width = 700
    Height = 241
    Hint = ''
    Lines.Strings = (
      'mmMessage')
    TabOrder = 2
    FieldLabel = 'Message'
    FieldLabelWidth = 70
  end
  object lsAttach: TUniListBox
    Left = 8
    Top = 336
    Width = 669
    Height = 113
    Hint = ''
    TabOrder = 3
  end
  object UniLabel1: TUniLabel
    Left = 8
    Top = 317
    Width = 68
    Height = 13
    Hint = ''
    Caption = 'Attachments :'
    TabOrder = 4
  end
  object UniBitBtn2: TUniBitBtn
    Left = 683
    Top = 336
    Width = 25
    Height = 25
    Hint = ''
    Glyph.Data = {
      B6030000424DB603000000000000360000002800000012000000100000000100
      18000000000080030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00002020200000000000000000000000
      00000000000000000000000000000000000000000000000000000000191919FF
      FFFFFFFFFFFFFFFF0000E3E3E300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000B7B7B7FFFFFFFFFFFF
      0000FFFFFF2C2C2C000000000000000000000000000000000000000000000000
      0000000000000000000000000000000B0B0BFFFFFFFFFFFF00004D4D4DF0F0F0
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B7B7B7FFFFFF0000000000FFFFFF2C2C2C0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B0B0BFFFFFF0000000000595959F0F0F000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000C1C1C1
      0000000000000000FFFFFF2C2C2C000000000000000000000000000000000000
      0000000000000000000000000000000000000000002121210000000000000000
      585858FFFFFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000002A2A2A0000000000000000000000B5B5B5FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFFFFFFFFFFFFFFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000006D6D6DFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF00007F7F7F000000000000000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
    Caption = ''
    Anchors = [akLeft, akBottom]
    ParentFont = False
    TabOrder = 5
    OnClick = UniBitBtn2Click
  end
  object UniBitBtn1: TUniBitBtn
    Left = 683
    Top = 424
    Width = 25
    Height = 25
    Hint = ''
    Glyph.Data = {
      F6020000424DF60200000000000036000000280000000E000000100000000100
      180000000000C0020000C40E0000C40E00000000000000000000FFFFFFC7C7C7
      070707000000000000000000000000000000000000000000000000080808CBCB
      CBFFFFFF0000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000FFFFFF0000FFFFFF0000000000009595958282
      820000009595958B8B8B0000008C8C8C8C8C8C000000000000FFFFFF0000FFFF
      FF0000000000009B9B9B8686860000009A9A9A90909000000091919191919100
      0000000000FFFFFF0000FFFFFF0000000000009999998585850000009898988F
      8F8F000000909090909090000000000000FFFFFF0000FFFFFF00000000000099
      99998585850000009898988F8F8F000000909090909090000000000000FFFFFF
      0000FFFFFF0000000000009999998585850000009898988F8F8F000000909090
      909090000000000000FFFFFF0000FFFFFF000000000000999999858585000000
      9898988F8F8F000000909090909090000000000000FFFFFF0000FFFFFF000000
      0000009B9B9B8686860000009A9A9A9090900000009191919191910000000000
      00FFFFFF0000FFFFFF0000000000009595958282820000009595958B8B8B0000
      008C8C8C8C8C8C000000000000FFFFFF0000FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000000000FFFFFF0000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000024242400000000000000
      0000000000000000000000000000000000000000000000000000000000242424
      0000242424000000000000000000000000000000000000000000000000000000
      0000000000000000002424240000FFFFFFFFFFFFFFFFFFFFFFFF4E4E4E000000
      0000000000000000004E4E4EFFFFFFFFFFFFFFFFFFFFFFFF0000}
    Caption = ''
    Anchors = [akLeft, akBottom]
    ParentFont = False
    TabOrder = 6
    OnClick = UniBitBtn1Click
  end
  object UniBitBtn3: TUniBitBtn
    Left = 683
    Top = 367
    Width = 25
    Height = 25
    Hint = ''
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000444444000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000044444400000000000000000000000000000000000000000000
      0000000000000000000000000000000000282828000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002828
      28FFFFFF282828000000000000000000000000000000000000000000434343FF
      FFFFFFFFFF4444440000000000000000002828280000000000002B2B2B000000
      000000000000000000494949FFFFFF0A0A0A0A0A0AFFFFFF4949490000000000
      000000000000002B2B2BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF08080800
      0000000000070707FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF070707000000000000000000000000070707FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF07070700000024242400
      0000000000242424000000070707FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF050505000000070707FFFFFF000000000000FFFFFF0707070000000606
      06FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF060606060606FFFFFFFFFFFF00
      0000000000FFFFFFFFFFFF060606060606FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      2424242424FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Caption = ''
    Anchors = [akLeft, akBottom]
    ParentFont = False
    TabOrder = 7
    OnClick = UniBitBtn3Click
  end
  object btnSend: TUniBitBtn
    Left = 633
    Top = 480
    Width = 75
    Height = 25
    Hint = ''
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF000000CBCBCBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
      0000FFFFFFFFFFFFFFFFFF969696040404181818FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF0000000000004B4B4B6F6F6F0000000000000000
      00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
      0000000000000000000000000000000000000000D3D3D3FFFFFFFFFFFFFFFFFF
      FFFFFFF3F3F3FFFFFFFFFFFF5858580000000000000000000000000000000000
      00000000A1A1A1FFFFFFFFFFFFC6C6C6393939000000484848FFFFFFFFFFFF11
      1111000000000000000000000000000000000000707070FFFFFF252525000000
      0000000000000000002A2A2AFFFFFFFFFFFF0000000000000000000000000000
      000000003F3F3FFFFFFF1B1B1B000000000000000000000000000000111111FF
      FFFFD6D6D60000000000000000000000000000000D0D0DFFFFFFFFFFFF8C8C8C
      000000000000000000000000000000000000FFFFFF8A8A8A0000000000000000
      00000000000000FFFFFFFFFFFFFFFFFFFFFFFF5B5B5B00000000000000000000
      0000000000FFFFFF3F3F3F000000000000000000000000F0F0F0FFFFFFFFFFFF
      FFFFFFFFFFFFF0F0F0292929000000000000000000000000EBEBEB0D0D0D0000
      00000000000000C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C302
      0202000000000000000000A4A4A4000000000000000000979797FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9292920000000000000000003C3C
      3C0000000000006B6B6BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF6060600000000000000000000000003F3F3FFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F32E2E
      2E000000000000090909FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD1D1D11A1A1A3D3D3D}
    Caption = 'Send'
    TabOrder = 8
    OnClick = btnSendClick
  end
  object UniFileUpload: TUniFileUpload
    Filter = 'image/*'
    Title = 'Upload'
    Messages.Uploading = 'Uploading...'
    Messages.PleaseWait = 'Please Wait'
    Messages.Cancel = 'Cancel'
    Messages.Processing = 'Processing...'
    Messages.UploadError = 'Upload Error'
    Messages.Upload = 'Upload'
    Messages.NoFileError = 'Please Select a File'
    Messages.BrowseText = 'Browse...'
    Messages.UploadTimeout = 'Timeout occurred...'
    Messages.MaxSizeError = 'File is bigger than maximum allowed size'
    Messages.MaxFilesError = 'You can upload maximum %d files.'
    TargetFolder = 'UPLOAD'
    Overwrite = True
    ImageIndex = 0
    MultipleFiles = True
    EraseCacheAfterCompleted = True
    OnMultiCompleted = UniFileUploadMultiCompleted
    Left = 424
    Top = 424
  end
  object UniFileUpload1: TUniFileUpload
    MaxAllowedSize = 10485760
    Filter = '.pdf,.PDF'
    Title = 'Upload'
    Messages.Uploading = 'Uploading...'
    Messages.PleaseWait = 'Please Wait'
    Messages.Cancel = 'Cancel'
    Messages.Processing = 'Processing...'
    Messages.UploadError = 'Upload Error'
    Messages.Upload = 'Upload'
    Messages.NoFileError = 'Please Select a File'
    Messages.BrowseText = 'Browse...'
    Messages.UploadTimeout = 'Timeout occurred...'
    Messages.MaxSizeError = 'File is bigger than maximum allowed size'
    Messages.MaxFilesError = 'You can upload maximum %d files.'
    OnCompleted = UniFileUpload1Completed
    Left = 24
    Top = 432
  end
  object cmdLog: TFDCommand
    Connection = UniMainModule.FDConnection1
    CommandText.Strings = (
      
        'insert into kirim_hasil_log (status,nomor,deskripsi,audit_date,a' +
        'udit_user)'
      'values (:status,:nomor,:deskripsi,now(),0);')
    ParamData = <
      item
        Name = 'STATUS'
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NOMOR'
        ParamType = ptInput
      end
      item
        Name = 'DESKRIPSI'
        ParamType = ptInput
      end>
    Left = 288
    Top = 464
  end
end
