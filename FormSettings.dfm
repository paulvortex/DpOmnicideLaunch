object SettingsForm: TSettingsForm
  Left = 669
  Top = 241
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Launch settings'
  ClientHeight = 303
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Bevel1: TBevel
    Left = 0
    Top = 256
    Width = 321
    Height = 2
  end
  object Reset: TButton
    Left = 8
    Top = 264
    Width = 121
    Height = 33
    HelpKeyword = 'btnReset'
    HelpContext = 32
    Caption = '#reset'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = ResetClick
  end
  object Save: TButton
    Left = 192
    Top = 264
    Width = 121
    Height = 33
    HelpKeyword = 'btnSave'
    HelpContext = 33
    Caption = '#save'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = SaveClick
  end
  object CommandlineGroup: TGroupBox
    Left = 8
    Top = 160
    Width = 305
    Height = 81
    Caption = '#commandline '
    TabOrder = 2
    object Commandline: TEdit
      Left = 8
      Top = 24
      Width = 289
      Height = 24
      HelpContext = 30
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object DisableCommandline: TCheckBox
      Left = 8
      Top = 56
      Width = 153
      Height = 17
      HelpContext = 31
      Caption = '#disable_commandline'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = DisableCommandlineClick
    end
  end
  object EngineGroup: TRadioGroup
    Left = 8
    Top = 0
    Width = 305
    Height = 73
    HelpContext = 1
    Caption = '#engine'
    ItemIndex = 0
    Items.Strings = (
      'OpenGL'
      'Direct3D')
    TabOrder = 3
  end
  object SafeModeGroup: TGroupBox
    Left = 8
    Top = 80
    Width = 305
    Height = 73
    Caption = '#safemode'
    TabOrder = 4
    object noVBO: TCheckBox
      Left = 152
      Top = 24
      Width = 145
      Height = 17
      HelpContext = 2
      Caption = '#noVBO'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object windowed: TCheckBox
      Left = 8
      Top = 24
      Width = 137
      Height = 17
      HelpContext = 2
      Caption = '#windowed'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object XPManifest1: TXPManifest
    Left = 160
    Top = 272
  end
end
