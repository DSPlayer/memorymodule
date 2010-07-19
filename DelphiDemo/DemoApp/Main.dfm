object Form1: TForm1
  Left = 373
  Top = 231
  Caption = 'MemoryModule Demo Application'
  ClientHeight = 53
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object BtnFileCAll: TButton
    Left = 24
    Top = 16
    Width = 121
    Height = 25
    Caption = 'file call'
    TabOrder = 0
    OnClick = BtnFileCAllClick
  end
  object BtnMemCall: TButton
    Left = 168
    Top = 16
    Width = 129
    Height = 25
    Caption = 'memory call'
    TabOrder = 1
    OnClick = BtnMemCallClick
  end
end
