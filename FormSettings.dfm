object SettingsForm: TSettingsForm
  Left = 669
  Top = 241
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Launch settings'
  ClientHeight = 286
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  PrintScale = poNone
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 12
  object Bevel1: TBevel
    Left = 0
    Top = 240
    Width = 289
    Height = 2
  end
  object Reset: TButton
    Left = 6
    Top = 246
    Width = 115
    Height = 35
    HelpKeyword = 'btnReset'
    HelpContext = 32
    Caption = '#reset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = ResetClick
  end
  object Save: TButton
    Left = 176
    Top = 246
    Width = 105
    Height = 35
    HelpKeyword = 'btnSave'
    HelpContext = 33
    Caption = '#save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = SaveClick
  end
  object CommandlineGroup: TGroupBox
    Left = 6
    Top = 152
    Width = 275
    Height = 73
    Caption = '#commandline '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Commandline: TEdit
      Left = 6
      Top = 18
      Width = 259
      Height = 22
      HelpContext = 30
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object DisableCommandline: TCheckBox
      Left = 14
      Top = 47
      Width = 115
      Height = 18
      HelpContext = 31
      Caption = '#disable_commandline'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = DisableCommandlineClick
    end
  end
  object EngineGroup: TRadioGroup
    Left = 6
    Top = 8
    Width = 275
    Height = 65
    HelpContext = 1
    Caption = '#engine'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'OpenGL'
      'Direct3D')
    ParentFont = False
    TabOrder = 3
  end
  object SafeModeGroup: TGroupBox
    Left = 6
    Top = 84
    Width = 275
    Height = 55
    Caption = '#safemode'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object noVBO: TCheckBox
      Left = 130
      Top = 26
      Width = 109
      Height = 18
      HelpContext = 2
      Caption = '#noVBO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object windowed: TCheckBox
      Left = 14
      Top = 25
      Width = 103
      Height = 18
      HelpContext = 2
      Caption = '#windowed'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object XPManifest1: TXPManifest
    Left = 136
    Top = 248
  end
end
