object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'webP Converter'
  ClientHeight = 500
  ClientWidth = 743
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 743
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 739
    object Label5: TLabel
      Left = 16
      Top = 4
      Width = 207
      Height = 39
      Caption = 'webP Converter'
    end
    object Label7: TLabel
      Left = 229
      Top = 25
      Width = 292
      Height = 13
      Caption = 'Supported formats : bitmap; jpg/jpeg; png; gif, export or batch.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 743
    Height = 432
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 739
    ExplicitHeight = 431
    object Splitter1: TSplitter
      Left = 201
      Top = 0
      Width = 5
      Height = 432
    end
    object Panel3: TPanel
      Left = 206
      Top = 0
      Width = 537
      Height = 432
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 533
      ExplicitHeight = 431
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 17
        Width = 537
        Height = 207
        HorzScrollBar.Smooth = True
        HorzScrollBar.Tracking = True
        VertScrollBar.Smooth = True
        VertScrollBar.Tracking = True
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        ExplicitWidth = 533
        ExplicitHeight = 206
        object Image1: TImage
          Left = 6
          Top = 6
          Width = 50
          Height = 50
          AutoSize = True
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 224
        Width = 537
        Height = 208
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitTop = 223
        ExplicitWidth = 533
        DesignSize = (
          537
          208)
        object Label2: TLabel
          Left = 15
          Top = 179
          Width = 51
          Height = 15
          Caption = 'Progress :'
        end
        object Label3: TLabel
          Left = 360
          Top = 179
          Width = 19
          Height = 15
          Anchors = [akTop, akRight]
          Caption = '0 %'
        end
        object Label4: TLabel
          Left = 22
          Top = 24
          Width = 44
          Height = 15
          Caption = 'Quality :'
        end
        object Label8: TLabel
          Left = 32
          Top = 54
          Width = 34
          Height = 15
          Caption = 'Sepia :'
        end
        object Label9: TLabel
          Left = 40
          Top = 83
          Width = 26
          Height = 15
          Caption = 'Red :'
        end
        object Label10: TLabel
          Left = 29
          Top = 113
          Width = 37
          Height = 15
          Caption = 'Green :'
        end
        object Label11: TLabel
          Left = 37
          Top = 143
          Width = 29
          Height = 15
          Caption = 'Blue :'
        end
        object Button1: TButton
          Left = 466
          Top = 175
          Width = 60
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Convert'
          TabOrder = 0
          TabStop = False
          OnClick = Button1Click
          ExplicitLeft = 462
        end
        object ProgressBar1: TProgressBar
          Left = 72
          Top = 179
          Width = 270
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          ExplicitWidth = 266
        end
        object CheckBox1: TCheckBox
          Left = 192
          Top = 47
          Width = 113
          Height = 17
          TabStop = False
          Caption = 'Swap RGB to BGR'
          TabOrder = 2
        end
        object Edit1: TEdit
          Left = 72
          Top = 21
          Width = 49
          Height = 23
          TabStop = False
          MaxLength = 6
          TabOrder = 3
          Text = '85.00'
          OnKeyPress = Edit1KeyPress
        end
        object CheckBox2: TCheckBox
          Left = 192
          Top = 70
          Width = 83
          Height = 17
          TabStop = False
          Caption = 'Transparent'
          TabOrder = 4
          OnClick = CheckBox2Click
        end
        object CheckBox3: TCheckBox
          Left = 192
          Top = 24
          Width = 137
          Height = 17
          TabStop = False
          Caption = 'View picture progress'
          TabOrder = 5
        end
        object GroupBox1: TGroupBox
          Left = 373
          Top = 24
          Width = 152
          Height = 131
          Caption = ' Graphic adjustment '
          TabOrder = 6
          object Label6: TLabel
            Left = 16
            Top = 72
            Width = 38
            Height = 15
            Caption = 'Width :'
          end
          object SpinEdit1: TSpinEdit
            Left = 60
            Top = 69
            Width = 65
            Height = 24
            TabStop = False
            MaxLength = 4
            MaxValue = 2000
            MinValue = 1
            TabOrder = 0
            Value = 300
          end
          object CheckBox4: TCheckBox
            Left = 16
            Top = 30
            Width = 97
            Height = 17
            Caption = 'Resize images'
            TabOrder = 1
            OnClick = CheckBox4Click
          end
        end
        object CheckBox5: TCheckBox
          Left = 192
          Top = 93
          Width = 74
          Height = 17
          Caption = 'Grayscale'
          TabOrder = 7
        end
        object SpinEdit2: TSpinEdit
          Left = 72
          Top = 50
          Width = 49
          Height = 24
          MaxLength = 3
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 0
        end
        object CheckBox6: TCheckBox
          Left = 192
          Top = 116
          Width = 78
          Height = 17
          Caption = 'Invert RGB'
          TabOrder = 9
        end
        object SpinEdit3: TSpinEdit
          Left = 72
          Top = 80
          Width = 49
          Height = 24
          Color = clRed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          MaxLength = 3
          MaxValue = 255
          MinValue = 0
          ParentFont = False
          TabOrder = 10
          Value = 0
        end
        object SpinEdit4: TSpinEdit
          Left = 72
          Top = 110
          Width = 49
          Height = 24
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          MaxLength = 3
          MaxValue = 255
          MinValue = 0
          ParentFont = False
          TabOrder = 11
          Value = 0
        end
        object SpinEdit5: TSpinEdit
          Left = 72
          Top = 140
          Width = 49
          Height = 24
          Color = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          MaxLength = 3
          MaxValue = 255
          MinValue = 0
          ParentFont = False
          TabOrder = 12
          Value = 0
        end
        object Button2: TButton
          Left = 400
          Top = 175
          Width = 60
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Abort'
          Enabled = False
          TabOrder = 13
          TabStop = False
          OnClick = Button2Click
          ExplicitLeft = 396
        end
      end
      object HeaderControl1: THeaderControl
        Left = 0
        Top = 0
        Width = 537
        Height = 17
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        Sections = <
          item
            ImageIndex = -1
            Text = 'Loaded pictures :'
            Width = 120
          end
          item
            ImageIndex = -1
            Style = hsOwnerDraw
            Text = '0 kb'
            Width = 150
          end
          item
            ImageIndex = -1
            Text = 'New size :'
            Width = 70
          end
          item
            ImageIndex = -1
            Style = hsOwnerDraw
            Text = '0 kb'
            Width = 1000
          end>
        Style = hsFlat
        OnDrawSection = HeaderControl1DrawSection
        ShowHint = True
        ParentFont = False
        ParentShowHint = False
        StyleElements = [seClient, seBorder]
        ExplicitWidth = 533
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 201
      Height = 432
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitHeight = 431
      object ListBox1: TListBox
        Left = 0
        Top = 27
        Width = 201
        Height = 405
        TabStop = False
        Style = lbOwnerDrawVariable
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ItemHeight = 15
        MultiSelect = True
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnClick = ListBox1Click
        OnDblClick = ListBox1DblClick
        OnDrawItem = ListBox1DrawItem
        ExplicitHeight = 404
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 201
        Height = 27
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 7
          Top = 3
          Width = 42
          Height = 15
          Caption = 'Import :'
        end
        object ComboBox1: TComboBox
          Left = 56
          Top = 0
          Width = 139
          Height = 23
          Style = csDropDownList
          TabOrder = 0
          TabStop = False
          Items.Strings = (
            'Bitmap'
            'Jpg/Jpeg'
            'Png'
            'Gif')
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 481
    Width = 743
    Height = 19
    Panels = <
      item
        Text = 'Count :'
        Width = 50
      end
      item
        Text = '0'
        Width = 50
      end
      item
        Text = 'Name :'
        Width = 50
      end
      item
        Width = 250
      end
      item
        Text = 'Dimension :'
        Width = 75
      end
      item
        Text = '0x0'
        Width = 80
      end
      item
        Text = 'Size :'
        Width = 40
      end
      item
        Text = '0 kb'
        Width = 50
      end>
    ExplicitTop = 480
    ExplicitWidth = 739
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 152
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open..'
        ShortCut = 16463
        OnClick = Open1Click
      end
      object LoadwebP1: TMenuItem
        Caption = 'Load webP..'
        ShortCut = 16471
        OnClick = LoadwebP1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Clear2: TMenuItem
        Caption = 'Clear..'
        ShortCut = 16430
        OnClick = Clear2Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Caption = 'Close'
        OnClick = Close1Click
      end
    end
    object Options1: TMenuItem
      Caption = 'Options'
      object Settings1: TMenuItem
        AutoCheck = True
        Caption = 'Settings'
        ShortCut = 112
        OnClick = Settings1Click
      end
      object Staytop1: TMenuItem
        AutoCheck = True
        Caption = 'Stay top'
        OnClick = Staytop1Click
      end
    end
    object N2: TMenuItem
      Caption = '?'
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 112
    Top = 152
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 225
    object Convert1: TMenuItem
      Caption = 'Convert'
      OnClick = Convert1Click
    end
    object Abort1: TMenuItem
      Caption = 'Abort'
      Enabled = False
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Export1: TMenuItem
      Caption = 'Export'
      OnClick = Export1Click
    end
    object Clear1: TMenuItem
      Caption = 'Clear..'
      ShortCut = 16430
      OnClick = Clear1Click
    end
    object Remove1: TMenuItem
      Caption = 'Remove'
      OnClick = Remove1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Properties1: TMenuItem
      Caption = 'Properties'
      OnClick = Properties1Click
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 112
    Top = 225
  end
end
