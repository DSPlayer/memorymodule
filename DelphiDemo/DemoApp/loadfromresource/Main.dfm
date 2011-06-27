object Form1: TForm1
  Left = 978
  Top = 246
  Width = 330
  Height = 91
  Caption = 'MemoryModule Demo Application'
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
  object BtnMemCall: TButton
    Left = 80
    Top = 16
    Width = 153
    Height = 25
    Caption = 'resource memory call'
    TabOrder = 0
    OnClick = BtnMemCallClick
  end
end
