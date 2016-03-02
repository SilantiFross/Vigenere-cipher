object Lab_1: TLab_1
  Left = 480
  Top = 187
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Lab_1'
  ClientHeight = 697
  ClientWidth = 883
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object KeyLabel: TLabel
    Left = 131
    Top = 283
    Width = 22
    Height = 13
    Caption = 'Key:'
  end
  object HintLabel: TLabel
    Left = 131
    Top = 309
    Width = 185
    Height = 13
    Caption = 'Key must be more than three symbols.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object AnswerLabel: TLabel
    Left = 16
    Top = 394
    Width = 838
    Height = 275
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object AnswerKeyLabel: TLabel
    Left = 8
    Top = 676
    Width = 838
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object OriginalMemo: TMemo
    Left = 16
    Top = 16
    Width = 409
    Height = 249
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object OpenButton: TButton
    Left = 16
    Top = 278
    Width = 75
    Height = 25
    Caption = 'Open file'
    TabOrder = 1
    OnClick = OpenButtonClick
  end
  object EncryptButton: TButton
    Left = 350
    Top = 278
    Width = 75
    Height = 25
    Caption = 'Encrypt'
    TabOrder = 2
    Visible = False
    OnClick = EncryptButtonClick
  end
  object SaveButton: TButton
    Left = 790
    Top = 278
    Width = 75
    Height = 25
    Caption = 'Save as...'
    TabOrder = 3
    OnClick = SaveButtonClick
  end
  object KeyEdit: TEdit
    Left = 159
    Top = 282
    Width = 149
    Height = 21
    TabOrder = 4
    OnChange = KeyEditChange
    OnKeyPress = KeyEditKeyPress
  end
  object RadioButton1: TRadioButton
    Left = 16
    Top = 344
    Width = 90
    Height = 17
    Caption = 'Encrypt text'
    Checked = True
    TabOrder = 5
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 16
    Top = 367
    Width = 90
    Height = 17
    Caption = 'Decrypt text'
    TabOrder = 6
    OnClick = RadioButton2Click
  end
  object DecryptButton: TButton
    Left = 350
    Top = 278
    Width = 75
    Height = 25
    Caption = 'Decrypt'
    TabOrder = 7
    Visible = False
    OnClick = DecryptButtonClick
  end
  object CryptMemo: TMemo
    Left = 456
    Top = 16
    Width = 409
    Height = 249
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 8
  end
  object TestButton: TButton
    Left = 350
    Top = 309
    Width = 75
    Height = 25
    Caption = 'Test'
    Enabled = False
    TabOrder = 9
    OnClick = TestButtonClick
  end
  object OpenDialog: TOpenDialog
    Left = 32
    Top = 216
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.txt'
    Left = 808
    Top = 224
  end
end
