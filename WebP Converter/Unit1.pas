unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  libwebp, WebpHelpers, Vcl.ExtCtrls, Vcl.StdCtrls, Winapi.GDIPOBJ, Vcl.Menus,
  WinApi.ShellAPI, Vcl.ComCtrls, System.UITypes, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg, Vcl.Samples.Spin, System.IniFiles,
  System.IOUtils;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Panel2: TPanel;
    Open1: TMenuItem;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Panel3: TPanel;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Panel4: TPanel;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label4: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Close1: TMenuItem;
    N1: TMenuItem;
    LoadwebP1: TMenuItem;
    GroupBox1: TGroupBox;
    SpinEdit1: TSpinEdit;
    Label6: TLabel;
    CheckBox4: TCheckBox;
    HeaderControl1: THeaderControl;
    Label5: TLabel;
    Label7: TLabel;
    PopupMenu1: TPopupMenu;
    Clear1: TMenuItem;
    Remove1: TMenuItem;
    Properties1: TMenuItem;
    Panel5: TPanel;
    ListBox1: TListBox;
    Panel6: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Splitter1: TSplitter;
    CheckBox5: TCheckBox;
    Label8: TLabel;
    SpinEdit2: TSpinEdit;
    CheckBox6: TCheckBox;
    Label9: TLabel;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    Label10: TLabel;
    Label11: TLabel;
    Button2: TButton;
    Options1: TMenuItem;
    N2: TMenuItem;
    Settings1: TMenuItem;
    Convert1: TMenuItem;
    Abort1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Export1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Clear2: TMenuItem;
    N5: TMenuItem;
    Staytop1: TMenuItem;
    About1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Close1Click(Sender: TObject);
    procedure LoadwebP1Click(Sender: TObject);
    procedure HeaderControl1DrawSection(HeaderControl: THeaderControl;
      Section: THeaderSection; const Rect: TRect; Pressed: Boolean);
    procedure Clear1Click(Sender: TObject);
    procedure Remove1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure Convert1Click(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Clear2Click(Sender: TObject);
    procedure Staytop1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    abort : boolean;
    flbHorzScrollWidth: Integer;
    FSplitFileSize: Int64;
    procedure GetSplitFileSize;
    procedure GetSplitFileSizeWebP;
    procedure GetSplitFileSizeExportWebP;
  public
    { Public-Deklarationen }
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form1: TForm1;
  TIF : TIniFile;

const
  libwebp_dll = 'Data\Drivers\libwebp32.dll';  // 32 bit driver
// Import of the original C function from the DLL
function WebPDecodeRGBA(
  data: PByte;
  data_size: NativeUInt;
  var width: Integer;
  var height: Integer
): PByte; cdecl; external libwebp_dll;

// Important: The memory allocated by libwebp MUST be freed.
procedure WebPFree(
  data: Pointer);
  cdecl;
  external 'Data\Drivers\libwebp.dll'
  name 'WebPFree';


implementation

{$R *.dfm}
{$R-}
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT :string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
    WriteInteger(OPT,'Import',Combobox1.ItemIndex);
    WriteString(OPT,'Quality',Edit1.Text);
    WriteInteger(OPT,'Sepia',SpinEdit2.Value);
    WriteInteger(OPT,'Red',SpinEdit3.Value);
    WriteInteger(OPT,'Green',SpinEdit4.Value);
    WriteInteger(OPT,'Blue',SpinEdit5.Value);
    WriteBool(OPT,'ViewProgress',CheckBox3.Checked);
    WriteBool(OPT,'SwapPixel',CheckBox1.Checked);
    WriteBool(OPT,'Transparent',CheckBox2.Checked);
    WriteBool(OPT,'Grayscale',CheckBox5.Checked);
    WriteBool(OPT,'Invert',CheckBox6.Checked);
    WriteBool(OPT,'Resize',CheckBox4.Checked);
    WriteInteger(OPT,'ResizeValue',SpinEdit1.Value);
    WriteBool(OPT,'Settings',Settings1.Checked);
    WriteBool(OPT,'StayTop',StayTop1.Checked);
    Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
    TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
    with TIF do
    begin
      Combobox1.ItemIndex:=ReadInteger(OPT,'Import',ComboBox1.ItemIndex);
      Edit1.Text:=ReadString(OPT,'Quality',Edit1.Text);
      SpinEdit2.Value:=ReadInteger(OPT,'Sepia',SpinEdit2.Value);
      SpinEdit3.Value:=ReadInteger(OPT,'Red',SpinEdit3.Value);
      SpinEdit4.Value:=ReadInteger(OPT,'Green',SpinEdit4.Value);
      SpinEdit5.Value:=ReadInteger(OPT,'Blue',SpinEdit5.Value);
      CheckBox3.Checked:=ReadBool(OPT,'ViewProgress',CheckBox3.Checked);
      CheckBox1.Checked:=ReadBool(OPT,'SwapPixel',CheckBox1.Checked);
      CheckBox2.Checked:=ReadBool(OPT,'Transparent',CheckBox2.Checked);
      CheckBox5.Checked:=ReadBool(OPT,'Grayscale',CheckBox5.Checked);
      CheckBox6.Checked:=ReadBool(OPT,'Invert',CheckBox6.Checked);
      CheckBox4.Checked:=ReadBool(OPT,'Resize',CheckBox4.Checked);
      SpinEdit1.Value:=ReadInteger(OPT,'ResizeValue',SpinEdit1.Value);
      Settings1.Checked:=ReadBool(OPT,'Settings',Settings1.Checked);
      StayTop1.Checked:=ReadBool(OPT,'StayTop',StayTop1.Checked);
      Free;
    end;
  end;
end;

// convert png graphic to bitmap
procedure LoadPngToBmp(var Dest: TBitmap; AFilename: TFilename);
type
  TRGB32 = packed record
    B, G, R, A : Byte;
  end;
  PRGBArray32 = ^TRGBArray32;
  TRGBArray32 = array[0..0] of TRGB32;
type
  TRG24 = packed record
    rgbtBlue, rgbtGreen, rgbtRed : Byte;
  end;
  PRGBArray24 = ^TPRGBArray24;
  TPRGBArray24 = array[0..0] of TRG24;
type
  TByteArray = Array[Word] of Byte;
  PByteArray = ^TByteArray;
  TPByteArray = array[0..0] of TByteArray;
var
  BMP : TBitmap;
  PNG: TPNGObject;
  x, y: Integer;
  BmpRow: PRGBArray32;
  PngRow : PRGBArray24;
  AlphaRow: PByteArray;
begin
  Bmp := TBitmap.Create;
  PNG := TPNGObject.Create;
  try
    if AFilename <> '' then
    begin
      PNG.LoadFromFile(AFilename);
      BMP.PixelFormat := pf32bit;
      BMP.Height := PNG.Height;
      BMP.Width := PNG.Width;
      if ( PNG.TransparencyMode = ptmPartial ) then
      begin
        for Y := 0 to BMP.Height-1 do
        begin
          BmpRow := PRGBArray32(BMP.ScanLine[Y]);
          PngRow := PRGBArray24(PNG.ScanLine[Y]);
          AlphaRow := PByteArray(PNG.AlphaScanline[Y]);

          for X := 0 to BMP.Width - 1 do
          begin
            with BmpRow[X] do
            begin
              with PngRow[X] do
              begin
                R := rgbtRed; G := rgbtGreen; B := rgbtBlue;
              end;
              A := Byte(AlphaRow[X]);
            end;
          end;
        end;
      end else
      begin
        for Y := 0 to BMP.Height-1 do
        begin
          BmpRow := PRGBArray32(BMP.ScanLine[Y]);
          PngRow := PRGBArray24(PNG.ScanLine[Y]);

          for X := 0 to BMP.Width - 1 do
          begin
            with BmpRow[X] do
            begin
              with PngRow[X] do
              begin
                R := rgbtRed; G := rgbtGreen; B := rgbtBlue;
              end;
              A := 255;
            end;
          end;
        end;
      end;
      Dest.Assign(BMP);
    end;
  finally
    Bmp.Free;
    PNG.Free;
  end;
end;

// Coloring the RGB channels
function SetRGBChannelValue(Bitmap: TBitmap; Red, Green, Blue: Integer): Boolean;
var
  i, j: Integer;
  rgbc: array[0..2] of Byte;
  c: TColor;
  r, g, b: Byte;
begin
  // If there is no change, exit:
  if (Red = 0) and (Green = 0) and (Blue = 0) then
  begin
    Result := False;
    Exit;
  end;

  for i := 0 to Bitmap.Height do
  begin
    for j := 0 to Bitmap.Width do
    begin
      // Get the old Color
      c := Bitmap.Canvas.Pixels[j, i];
      // Splitt the old color into the different colors:
      rgbc[0] := GetRValue(c);
      rgbc[1] := GetGValue(c);
      rgbc[2] := GetBValue(c);

      //Check that there is no "new" color while the addition
      //of the values:
      if not (rgbc[0] + Red < 0) and not (rgbc[0] + Red > 255) then
        rgbc[0] := rgbc[0] + Red;
      if not (rgbc[1] + Green < 0) and not (rgbc[1] + Green > 255) then
        rgbc[1] := rgbc[1] + Green;
      if not (rgbc[2] + Blue < 0) and not (rgbc[2] + Blue > 255) then
        rgbc[2] := rgbc[2] + Blue;

      r := rgbc[0];
      g := rgbc[1];
      b := rgbc[2];

      //set the new color back to the picture:
      Bitmap.Canvas.Pixels[j, i] := RGB(r, g, b);
    end;
  end;
  Result := True;
end;

// inverting RGB pixel
function InvertRGB(MyBitmap: TBitmap): TBitmap;
var
  x, y: Integer;
  ByteArray: PByteArray;
begin
  MyBitmap.PixelFormat := pf24Bit;
  for y := 0 to MyBitmap.Height - 1 do
  begin
    ByteArray := MyBitmap.ScanLine[y];
    for x := 0 to MyBitmap.Width * 3 - 1 do
    begin
      ByteArray[x] := 255 - ByteArray[x];
    end;
  end;
  Result := MyBitmap;
end;

// calculate sepia effect to picture
function Sepia(const bmp: TBitmap; depth: Integer): Boolean;
var
  color,color2:longint;
  r,g,b,rr,gg:byte;
  h,w:integer;
begin
  for h := 0 to bmp.height do
  begin
    for w := 0 to bmp.width do
    begin
      //first convert the bitmap to greyscale
      color:=colortorgb(bmp.Canvas.pixels[w,h]);

      r:=getrvalue(color);
      g:=getgvalue(color);
      b:=getbvalue(color);

      color2:=(r+g+b) div 3;
      bmp.canvas.Pixels[w,h]:=RGB(color2,color2,color2);

      //then convert it to sepia
      color:=colortorgb(bmp.Canvas.pixels[w,h]);

      r:=getrvalue(color);
      g:=getgvalue(color);
      b:=getbvalue(color);

      rr:=r+(depth*2);
      gg:=g+depth;

      if rr <= ((depth*2)-1) then
        rr:=255;

      if gg <= (depth-1) then
        gg:=255;
      bmp.canvas.Pixels[w,h]:=RGB(rr,gg,b);
    end;
  end;
end;

// calculating grayscale pixel
procedure BitmapGrayscale(ABitmap: TBitmap);
type
  // Definition of a pixel record for 24-bit (RGB)
  PRGBTriple = ^TRGBTriple;
  // TRGBTriple is already predefined in the 'Windows' or 'Vcl.Graphics' unit.
  // Definition for 32-bit (RGBA)
  PRGBQuad = ^TRGBQuad;
  // TRGBQuad is also predefined.
var
  X, Y: Integer;
  Row24: PRGBTriple;
  Row32: PRGBQuad;
  Gray: Byte;
begin
  // Ensure that the format is supported (24-bit or 32-bit).
  if not (ABitmap.PixelFormat in [pf24bit, pf32bit]) then
    // Force 32-bit if, for example, it was a JPEG/PNG.
    ABitmap.PixelFormat := pf32bit;
  for Y := 0 to ABitmap.Height - 1 do
  begin
    if ABitmap.PixelFormat = pf24bit then
    begin
      Row24 := ABitmap.ScanLine[Y];
      for X := 0 to ABitmap.Width - 1 do
      begin
        // Luminance formula: Y = 0.299*R + 0.587*G + 0.114*B (or similarly optimized)
        Gray := Round((Row24.rgbtRed * 0.299) + (Row24.rgbtGreen * 0.587) + (Row24.rgbtBlue * 0.114));
        Row24.rgbtRed   := Gray;
        Row24.rgbtGreen := Gray;
        Row24.rgbtBlue  := Gray;
        Inc(Row24);
      end;
    end
    else // pf32bit
    begin
      Row32 := ABitmap.ScanLine[Y];
      for X := 0 to ABitmap.Width - 1 do
      begin
        Gray := Round((Row32.rgbRed * 0.299) + (Row32.rgbGreen * 0.587) + (Row32.rgbBlue * 0.114));
        Row32.rgbRed   := Gray;
        Row32.rgbGreen := Gray;
        Row32.rgbBlue  := Gray;
        // rgbReserved (alpha channel) is left unchanged.
        Inc(Row32);
      end;
    end;
  end;
end;

{ For creating images that match in terms of relative size; here, the width
  is adjusted to match. }
procedure ResizeWidth(const src, dest: TGraphic;
  DestWidth, DestHeight: integer; Smooth: Boolean = true);
var
  temp, aCopy: TBitmap;
  faktor: double;
begin
  Assert(Assigned(src) and Assigned(dest));
  if (src.Width = 0) or (src.Height = 0) then
    raise Exception.CreateFmt('Invalid source dimensions: %d x %d',[src.Width, src.Height]);

  // factor in the width of the image
  if src.Width > DestWidth then
    begin
      faktor := DestWidth / src.Width;
      if (src.Height * faktor) > DestHeight then
        faktor := DestHeight / src.Height;
    end
  else
    begin
      faktor := DestHeight / src.Height;
      if (src.Width * faktor) > DestWidth then
        faktor := DestWidth / src.Width;
    end;
  try
    aCopy := TBitmap.Create;
    try
      aCopy.PixelFormat := pf24Bit;
      aCopy.Assign(src);
      temp := TBitmap.Create;
      try
        temp.Width := round(src.Width * faktor);
        temp.Height := round(src.Height * faktor);
        if Smooth then
          SetStretchBltMode(temp.Canvas.Handle, HALFTONE);

        // change the width
        StretchBlt(temp.Canvas.Handle, 0, 0, temp.Width, temp.Height,
          aCopy.Canvas.Handle, 0, 0, aCopy.Width, aCopy.Height, SRCCOPY);
        dest.Assign(temp);
      finally
        temp.Free;
      end;
    finally
      aCopy.Free;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar(E.Message), nil, MB_OK or MB_ICONERROR);
  end;
end;

// Open the Windows properties dialog for the pictures
procedure PropertiesDialog(const aFilename: string);
var
  sei: ShellExecuteInfo;
begin
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.lpFile := PChar(aFilename);
  sei.lpVerb := 'properties';
  sei.fMask  := SEE_MASK_INVOKEIDLIST;
  ShellExecuteEx(@sei);
end;

// Determine the total size of many files
function GetTotalSizeOfFiles(const FileList: TStringList): Int64;
var
  FilePath: string;
begin
  Result := 0;
  for FilePath in FileList do
  begin
    if TFile.Exists(FilePath) then
      Result := Result + TFile.GetSize(FilePath);
  end;
end;

// Determine the exact size of a file
function GetFileSize(const AFile: string): Int64;
var
  SR: TSearchRec;
begin
  if FindFirst(AFile, 0, SR) = 0 then begin
    Int64Rec(Result).Lo := SR.FindData.nFileSizeLow;
    Int64Rec(Result).Hi := SR.FindData.nFileSizeHigh;
    System.SysUtils.FindClose(SR);
  end else
    Result := -1;
end;

// Determine the exact size of exported webP file
procedure TForm1.GetSplitFileSizeExportWebP;
begin
  FSplitFileSize := GetFileSize(SaveDialog1.FileName+
          ExtractFileName(ListBox1.Items.Strings[ListBox1.ItemIndex]) + '.webP');
  HeaderControl1.Sections[3].Text := Format(' %.0n bytes', [FSplitFileSize * 1.0]);
end;

// Determine the exact size of converted webP file
procedure TForm1.GetSplitFileSizeWebP;
begin
  FSplitFileSize := GetFileSize(OpenDialog1.FileName);
  StatusBar1.Panels[7].Text := Format(' %.0n bytes', [FSplitFileSize * 1.0])
end;

// Output the header with font settings.
procedure TForm1.HeaderControl1DrawSection(HeaderControl: THeaderControl;
  Section: THeaderSection; const Rect: TRect; Pressed: Boolean);
begin
  // Set your custom font color
  HeaderControl.Canvas.Font.Color := clNavy; // or any TColor you want

  // Optional: preserve background or paint standard background first
  //HeaderControl.Canvas.FillRect(Rect);

  // Draw the section text
  HeaderControl.Canvas.TextOut(Rect.Left + 5, Rect.Top + 3, Section.Text);
end;

// display file size
procedure TForm1.GetSplitFileSize;
begin
  FSplitFileSize := GetFileSize(ListBox1.Items.Strings[ListBox1.ItemIndex]);
  StatusBar1.Panels[7].Text := Format(' %.0n bytes', [FSplitFileSize * 1.0])
end;

// Identify the files to be displayed in the ListBox with the shell icons.
procedure GetAllFilesExtra(List: TStrings);
var
  Path: String;
  Search: TSearchRec;
begin
  Path := ExtractFilePath(ParamStr(0));

  if FindFirst(Path + '*.*', faAnyFile, Search) = 0 then
  try
    repeat
      if (Search.Attr <> faDirectory) and (Search.Name[1] <> '.') then
        List.Add(Path + Search.Name);
    until FindNext(Search) <> 0;
  finally
    FindClose(Search);
  end;
end;

// Format shell icons
procedure IcoToBmpA(Ico: TIcon; Bmp: TBitmap; SmallIcon: Boolean);
var
  WH: Byte; // Width and Height
begin
  with Bmp do
  begin
    Canvas.Brush.Color := clFuchsia;
    TransparentColor := clFuchsia;

    Width := 16; Height := 16;
    Canvas.Draw(0, 0, Ico);

    if SmallIcon then
      WH := 16
    else
      WH := 32;

    Canvas.StretchDraw(Rect(0, 0, WH, WH), Bmp);
    Width := WH; Height := WH;

    Transparent :=  True;
  end;
end;

// Retrieve the icons from "shell32.dll"
procedure GetIconFromFileB(const FileName: String; Icon: TIcon;
  SmallIcon: Boolean);
var
  sfi: TSHFILEINFO;
const
  uFlags : array[Boolean] of DWord = (SHGFI_LARGEICON, SHGFI_SMALLICON);
begin
  if SHGetFileInfo(PChar(FileName), 0, sfi, SizeOf(sfi), SHGFI_ICON or
     uFlags[SmallIcon]) <> 0 then
    Icon.Handle := sfi.hIcon;
end;

// output everything together in the ListBox
procedure DrawListBoxExtra(Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
const
  Col1: array [Boolean] of TColor = ($00F8F8F8, clWindow);
  Col2: array [Boolean] of TColor = (clInactiveCaptionText, clWindowText);
var
  Icon: TIcon;
  Bmp: TBitmap;
begin
  with (Control as TListbox) do
  begin
    Icon := TIcon.Create;
    Bmp := TBitmap.Create;
    try
      if odSelected in State then
        Canvas.Font.Color := clCaptionText
      else
      begin
        Bmp.Canvas.Brush.Color := Canvas.Brush.Color;
        Canvas.Brush.Color := Col1[Odd(Index)];
        Canvas.Font.Color := Col2[(Control as TListBox).Enabled];
      end;
      GetIconFromFileB(Items[Index], Icon, True);
      IcoToBmpA(Icon, Bmp, True);
      Canvas.TextRect(Rect, Rect.Left + Bmp.Width + 2, Rect.Top + 2, Items[Index]);
      Canvas.Draw(Rect.Left, Rect.Top, Bmp);
    finally
      Bmp.Free;
      Icon.Free;
    end;
  end;
end;

{ Since working directly with C pointers in Delphi is error-prone, the
  call is usually encapsulated in a more convenient Delphi procedure that
  works with types such as TBytes (dynamic arrays). }
procedure DecodeRawWebP(const FilePath: string);
var
  FileStream: TFileStream;
  RawData: TBytes;
  PixelBuffer: PByte;
  Width, Height: Integer;
begin
  // Read a file into a byte array
  FileStream := TFileStream.Create(FilePath, fmOpenRead);
  try
    SetLength(RawData, FileStream.Size);
    FileStream.ReadBuffer(RawData[0], FileStream.Size);
  finally
    FileStream.Free;
  end;
  // Call the DLL function. Returns a pointer to the uncompressed RGBA pixels.
  PixelBuffer := WebPDecodeRGBA(@RawData[0], Length(RawData), Width, Height);
  if Assigned(PixelBuffer) then
  begin
    try
      // "PixelBuffer" now contains the raw data (width * height * 4 bytes).
      // You can now copy these into a TBitmap (PixelFormat = pf32bit).
    finally
      // Free memory in the DLL again
      WebPFree(PixelBuffer);
    end;
  end;
end;

{ The alternative function SwapRGBtoBGR is usually not entirely accurate.
function SwapRGBandBGR(C: LongWord): LongWord;
begin
  Result := ((C and $FF) shl 16) or (C and $FF00) or ((C shr 16) and $FF);
end;
}

{ There are various ways to swap the RGB color channels of a TBitmap to BGR.
  The most efficient and modern approach uses the ScanLine property, as it
  allows for direct memory manipulation. }
procedure SwapRGBtoBGR(ABitmap: TBitmap);
var
  X, Y: Integer;
  Pixel: PAlphaColorRec; // needs : uses System.UITypes
begin
  for Y := 0 to ABitmap.Height - 1 do
  begin
    Pixel := ABitmap.ScanLine[Y];
    for X := 0 to ABitmap.Width - 1 do
    begin
      // Swap red and blue
      var TempRed := Pixel^.R;
      Pixel^.R := Pixel^.B;
      Pixel^.B := TempRed;
      Inc(Pixel);
    end;
  end;
end;

// Save the bitmap in the highly compressed WebP format.
procedure SaveBitmapToWebP(ABitmap: TBitmap; const AFilename: string; AQuality: Single);
var
  Stream: TMemoryStream;
  BitData: pointer;
  X, Y: Integer;
  PixelPtr: PByte;
  RowStride: Integer;
  EncodedData: PByte;
  EncodedSize: NativeUInt;
begin
  // Safety check to determine whether the bitmap is valid
  if (ABitmap = nil) or ABitmap.Empty then Exit;

  // We force 24-bit (RGB) or 32-bit (RGBA) for libwebp processing.
  ABitmap.PixelFormat := pf24bit; // 24-bit is recommended.

  Stream := TMemoryStream.Create;
  try
    // Row width in memory (account for padding!)
    RowStride := BytesPerScanline(ABitmap.Width, 24, 32);
    // Reserve memory for raw data
    GetMem(BitData, RowStride * ABitmap.Height);
    try
      // Copy pixel data from bottom to top (or vice versa) into the buffer.
      // Since TBitmap is often stored "bottom-up" internally, we copy it line by line.

      for Y := 0 to ABitmap.Height - 1 do
      begin
        PixelPtr := ABitmap.ScanLine[Y];
        Move(PixelPtr^, Pointer(NativeUInt(BitData) + NativeUInt(Y * RowStride))^, ABitmap.Width * 3);
      end;

      // Encoding using the libwebp API
      // AQuality: 0 (worst) to 100 (best quality)
      EncodedSize := WebPEncodeRGB(BitData, ABitmap.Width, ABitmap.Height, RowStride, AQuality, EncodedData);

      if EncodedSize > 0 then
      begin
        // Write the encoded data to the stream and save it.
        Stream.Write(EncodedData^, EncodedSize);
        Stream.SaveToFile(AFilename);

        // Important: Free the memory reserved by the DLL!
        WebPFree(EncodedData);
      end;
    finally
      FreeMem(BitData);
    end;
  finally
    Stream.Free;
  end;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  MessageDlg('webP Converter 1.0' + chr(10) +
             'Copyright © hackbard' + chr(10) +
             'github.com | Release 2026',mtInformation, [mbOK], 0);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  bmp : TBitmap;
  JPEGImage: TJPEGImage;
  GIF : TGIFImage;
  i, procent, size : integer;
  list : TStringList;
  quality : single;
  s, path : string;
begin
  // go out no picture found
  if ListBox1.Items.Count = 0 then
  begin
    MessageDlg('Load pictures to convert!',mtInformation, [mbOK], 0);
    Exit;
  end;

  Screen.Cursor := crHourGlass;

  // copy quality single value
  s := Edit1.Text;

  Button1.Enabled := false;
  Button2.Enabled := true;
  Convert1.Enabled := false;
  Abort1.Enabled := true;
  abort := false;

  // Force FormatSettings to use a period as the decimal separator (optional)
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DecimalSeparator := '.';

  // copy quality value
  quality := StrToFloat(s, FormatSettings);
  StatusBar1.Panels[3].Text := 'calculating, please wait..';


  // starting import picture formats
  if ComboBox1.ItemIndex = 0 then   // bitmap import
  begin
  // memory access for the file sizes
  list := TStringList.Create;
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      // Abort the process.
      if abort = true then
        begin
          Button1.Enabled := true;
          Button2.Enabled := false;
          Convert1.Enabled := true;
          Abort1.Enabled := false;
          StatusBar1.Panels[3].Text := 'process abort.';
          Screen.Cursor := crDefault;
          Exit;
        end;

      try
        bmp := TBitmap.Create;
        // load pictures
        bmp.LoadFromFile(ListBox1.Items.Strings[i]);

        // the bit format must be 32-bit.
        bmp.PixelFormat := pf32bit;

        // set transparent
        if CheckBox2.Checked = true then
        begin
          bmp.TransparentColor := clBlack;
          bmp.Transparent := true;
        end;

        // Swap the RGB pixels with the BGR ones.
        if not CheckBox1.Checked = true then
        begin
          SwapRGBtoBGR(bmp);
        end;

        // view progress pictures
        if CheckBox3.Checked = true then
        begin
          Image1.Picture.Bitmap.Assign(bmp);
          SwapRGBtoBGR(Image1.Picture.Bitmap);
          StatusBar1.Panels[3].Text := ExtractFileName(ListBox1.Items.Strings[i]) + ' .. processing..';
        end;

        // align the image sizes with each other
        if CheckBox4.Checked = true then
        begin
          ResizeWidth(bmp, bmp, SpinEdit1.Value, SpinEdit1.Value,  true);
        end;

        // calculate to grayscale
        if CheckBox5.Checked = true then
        begin
          BitmapGrayscale(bmp);
        end;

        // calculate sepia
        if SpinEdit2.Value <> 0 then
        begin
          Sepia(bmp, SpinEdit1.Value);
        end;

        // create negativ rgb pixel
        if CheckBox6.Checked = true then
        begin
          InvertRGB(bmp);
        end;

        // tone & highlight pixel rgb
        if (SpinEdit3.Value <> 0) or (SpinEdit5.Value <> 0) or
           (SpinEdit5.Value <> 0) then
        begin
          SetRGBChannelValue(bmp, SpinEdit5.Value, SpinEdit4.Value, SpinEdit3.Value);
        end;

        // create webP picture format
        SaveBitmapToWebP(bmp, ExtractFilePath(Application.ExeName) + 'Export\' +
                      ExtractFileName(ListBox1.Items.Strings[i]) + '.webP', quality);

        // Round the progress bar to 100%, regardless of how many images have been loaded.
        ProgressBar1.Position := Round((i / ProgressBar1.Max) * 100);
        procent := Round((ProgressBar1.Position - ProgressBar1.Min) /
                   (ProgressBar1.Max - ProgressBar1.Min) * 100);

        // display progess status in %
        Label3.Caption := IntToStr(procent) + ' %';

        // Pass the new path for the WebP files.
        path := ExtractFilePath(Application.ExeName) + 'Export\' +
                      ExtractFileName(ListBox1.Items.Strings[i]) + '.webP';

        // add webP file to list
        list.AddStrings(path);

        // update process (form)
        Application.ProcessMessages;
      finally
        // Add up the sizes of the WebP files.
        size := GetTotalSizeOfFiles(list);
        // display the new size
        HeaderControl1.Sections[3].Text := IntToStr(size div 1000) + ' kb';
        bmp.Free;
      end;
    end;
    // reelase webP file list
    list.Free;
  end;


  if ComboBox1.ItemIndex = 1 then   // jpg/jpeg import
  begin
  // memory access for the file sizes
  list := TStringList.Create;
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      if abort = true then
        begin
          Button1.Enabled := true;
          Button2.Enabled := false;
          Convert1.Enabled := true;
          Abort1.Enabled := false;
          StatusBar1.Panels[3].Text := 'process abort.';
          Screen.Cursor := crDefault;
          Exit;
        end;

      try
        JPEGImage:=TJPEGImage.Create;
        JPEGImage.LoadFromFile(ListBox1.Items.Strings[i]);
        bmp := TBitmap.Create;
        bmp.Assign(JPEGImage);

        // the bit format must be 32-bit.
        bmp.PixelFormat := pf32bit;

        // set transparent
        if CheckBox2.Checked = true then
        begin
          bmp.TransparentColor := clBlack;
          bmp.Transparent := true;
        end;

        // Swap the RGB pixels with the BGR ones.
        if not CheckBox1.Checked = true then
        begin
          SwapRGBtoBGR(bmp);
        end;

        // view progress pictures
        if CheckBox3.Checked = true then
        begin
          Image1.Picture.Bitmap.Assign(bmp);
          SwapRGBtoBGR(Image1.Picture.Bitmap);
          StatusBar1.Panels[3].Text := ExtractFileName(ListBox1.Items.Strings[i]) + ' .. processing..';
        end;

        // align the image sizes with each other
        if CheckBox4.Checked = true then
        begin
          ResizeWidth(bmp, bmp, SpinEdit1.Value, SpinEdit1.Value,  true);
        end;

        // calculate to grayscale
        if CheckBox5.Checked = true then
        begin
          BitmapGrayscale(bmp);
        end;

        // calculate sepia
        if SpinEdit2.Value <> 0 then
        begin
          Sepia(bmp, SpinEdit1.Value);
        end;

        // create negativ rgb pixel
        if CheckBox6.Checked = true then
        begin
          InvertRGB(bmp);
        end;

        // tone & highlight pixel rgb
        if (SpinEdit3.Value <> 0) or (SpinEdit5.Value <> 0) or
           (SpinEdit5.Value <> 0) then
        begin
          SetRGBChannelValue(bmp, SpinEdit5.Value, SpinEdit4.Value, SpinEdit3.Value);
        end;

        SaveBitmapToWebP(bmp, ExtractFilePath(Application.ExeName) + 'Export\' +
                      ExtractFileName(ListBox1.Items.Strings[i]) + '.webP', quality);

        ProgressBar1.Position := Round((i / ProgressBar1.Max) * 100);
        procent := Round((ProgressBar1.Position - ProgressBar1.Min) /
                   (ProgressBar1.Max - ProgressBar1.Min) * 100);
        Label3.Caption := IntToStr(procent) + ' %';

        // Pass the new path for the WebP files.
        path := ExtractFilePath(Application.ExeName) + 'Export\' +
                      ExtractFileName(ListBox1.Items.Strings[i]) + '.webP';
        // add webP file to list
        list.AddStrings(path);
        Application.ProcessMessages;
      finally
        // Add up the sizes of the WebP files.
        size := GetTotalSizeOfFiles(list);
        // display the new size
        HeaderControl1.Sections[3].Text := IntToStr(size div 1000) + ' kb';
        bmp.Free;
        JPEGImage.Free;
      end;
    end;
    // reelase webP file list
    list.Free;
  end;

  if ComboBox1.ItemIndex = 2 then   // png import
  begin
  // memory access for the file sizes
  list := TStringList.Create;
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      if abort = true then
        begin
          Button1.Enabled := true;
          Button2.Enabled := false;
          Convert1.Enabled := true;
          Abort1.Enabled := false;
          StatusBar1.Panels[3].Text := 'process abort.';
          Screen.Cursor := crDefault;
          Exit;
        end;

      try
        bmp := TBitmap.Create;
        LoadPngToBmp(bmp, ListBox1.Items.Strings[i]);

        // the bit format must be 32-bit.
        bmp.PixelFormat := pf32bit;

        // set transparent
        if CheckBox2.Checked = true then
        begin
          bmp.TransparentColor := clBlack;
          bmp.Transparent := true;
        end;

        // Swap the RGB pixels with the BGR ones.
        if not CheckBox1.Checked = true then
        begin
          SwapRGBtoBGR(bmp);
        end;

        // view progress pictures
        if CheckBox3.Checked = true then
        begin
          Image1.Picture.Bitmap.Assign(bmp);
          SwapRGBtoBGR(Image1.Picture.Bitmap);
          StatusBar1.Panels[3].Text := ExtractFileName(ListBox1.Items.Strings[i]) + ' .. processing..';
        end;

        // align the image sizes with each other
        if CheckBox4.Checked = true then
        begin
          ResizeWidth(bmp, bmp, SpinEdit1.Value, SpinEdit1.Value,  true);
        end;

        // calculate to grayscale
        if CheckBox5.Checked = true then
        begin
          BitmapGrayscale(bmp);
        end;

        // calculate sepia
        if SpinEdit2.Value <> 0 then
        begin
          Sepia(bmp, SpinEdit1.Value);
        end;

        // create negativ rgb pixel
        if CheckBox6.Checked = true then
        begin
          InvertRGB(bmp);
        end;

        // tone & highlight pixel rgb
        if (SpinEdit3.Value <> 0) or (SpinEdit5.Value <> 0) or
           (SpinEdit5.Value <> 0) then
        begin
          SetRGBChannelValue(bmp, SpinEdit5.Value, SpinEdit4.Value, SpinEdit3.Value);
        end;

        SaveBitmapToWebP(bmp, ExtractFilePath(Application.ExeName) + 'Export\' +
                      ExtractFileName(ListBox1.Items.Strings[i]) + '.webP', quality);

        ProgressBar1.Position := Round((i / ProgressBar1.Max) * 100);
        procent := Round((ProgressBar1.Position - ProgressBar1.Min) /
                   (ProgressBar1.Max - ProgressBar1.Min) * 100);
        Label3.Caption := IntToStr(procent) + ' %';

        // Pass the new path for the WebP files.
        path := ExtractFilePath(Application.ExeName) + 'Export\' +
                      ExtractFileName(ListBox1.Items.Strings[i]) + '.webP';
        // add webP file to list
        list.AddStrings(path);
        Application.ProcessMessages;
      finally
        // Add up the sizes of the WebP files.
        size := GetTotalSizeOfFiles(list);
        // display the new size
        HeaderControl1.Sections[3].Text := IntToStr(size div 1000) + ' kb';
        bmp.Free;
      end;
    end;
    // reelase webP file list
    list.Free;
  end;

  if ComboBox1.ItemIndex = 3 then   // gif import
  begin
  // memory access for the file sizes
  list := TStringList.Create;
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      if abort = true then
        begin
          Button1.Enabled := true;
          Button2.Enabled := false;
          Convert1.Enabled := true;
          Abort1.Enabled := false;
          StatusBar1.Panels[3].Text := 'process abort.';
          Screen.Cursor := crDefault;
          Exit;
        end;

      try
        bmp := TBitmap.Create;
        GIF := TGIFImage.Create;
        GIF.LoadFromFile(ListBox1.Items.Strings[i]);

        // Set bitmap dimensions and format
        Bmp.Width := Gif.Width;
        Bmp.Height := Gif.Height;

        // the bit format must be 32-bit.
        bmp.PixelFormat := pf32bit;

        // set transparent
        if CheckBox2.Checked = true then
        begin
          bmp.TransparentColor := clBlack;
          bmp.Transparent := true;
        end;

        // copy pixel to bitmap
        Bmp.Canvas.Draw(0, 0, Gif);

        // Swap the RGB pixels with the BGR ones.
        if not CheckBox1.Checked = true then
        begin
          SwapRGBtoBGR(bmp);
        end;

        // view progress pictures
        if CheckBox3.Checked = true then
        begin
          Image1.Picture.Bitmap.Assign(bmp);
          SwapRGBtoBGR(Image1.Picture.Bitmap);
          StatusBar1.Panels[3].Text := ExtractFileName(ListBox1.Items.Strings[i]) + ' .. processing..';
        end;

        // align the image sizes with each other
        if CheckBox4.Checked = true then
        begin
          ResizeWidth(bmp, bmp, SpinEdit1.Value, SpinEdit1.Value,  true);
        end;

        // calculate to grayscale
        if CheckBox5.Checked = true then
        begin
          BitmapGrayscale(bmp);
        end;

        // calculate sepia
        if SpinEdit2.Value <> 0 then
        begin
          Sepia(bmp, SpinEdit1.Value);
        end;

        // create negativ rgb pixel
        if CheckBox6.Checked = true then
        begin
          InvertRGB(bmp);
        end;

        // tone & highlight pixel rgb
        if (SpinEdit3.Value <> 0) or (SpinEdit5.Value <> 0) or
           (SpinEdit5.Value <> 0) then
        begin
          SetRGBChannelValue(bmp, SpinEdit5.Value, SpinEdit4.Value, SpinEdit3.Value);
        end;

        SaveBitmapToWebP(bmp, ExtractFilePath(Application.ExeName) + 'Export\' +
                      ExtractFileName(ListBox1.Items.Strings[i]) + '.webP', quality);

        ProgressBar1.Position := Round((i / ProgressBar1.Max) * 100);
        procent := Round((ProgressBar1.Position - ProgressBar1.Min) /
                   (ProgressBar1.Max - ProgressBar1.Min) * 100);
        Label3.Caption := IntToStr(procent) + ' %';

        // Pass the new path for the WebP files.
        path := ExtractFilePath(Application.ExeName) + 'Export\' +
                      ExtractFileName(ListBox1.Items.Strings[i]) + '.webP';
        // add webP file to list
        list.AddStrings(path);
        Application.ProcessMessages;
      finally
        // Add up the sizes of the WebP files.
        size := GetTotalSizeOfFiles(list);
        // display the new size
        HeaderControl1.Sections[3].Text := IntToStr(size div 1000) + ' kb';
        bmp.Free;
        GIF.Free;
      end;
    end;
    // reelase webP file list
    list.Free;
  end;
  StatusBar1.Panels[3].Text := '';
  Button1.Enabled := true;
  Button2.Enabled := false;
  Convert1.Enabled := true;
  Abort1.Enabled := false;
  Image1.Picture.Graphic := nil;  // clear view image
  StatusBar1.Panels[3].Text := 'Process finish.';
  Screen.Cursor := crDefault;
  Beep;
  MessageDlg('Process finish.',mtInformation, [mbOK], 0);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  abort := true;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  Image1.Transparent := CheckBox2.Checked;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked = true then
  begin
    Label6.Enabled := true;
    SpinEdit1.Enabled := true;
  end else begin
    Label6.Enabled := false;
    SpinEdit1.Enabled := false;
  end;
end;

procedure TForm1.Clear1Click(Sender: TObject);

begin
  if ListBox1.Items.Count = 0 then Exit;

  StatusBar1.Panels[1].Text := '0';
  StatusBar1.Panels[3].Text := 'Cleared.';
  StatusBar1.Panels[5].Text := '0x0';
  StatusBar1.Panels[7].Text := '0 kb';

  HeaderControl1.Sections[1].Text := '0 kb';
  HeaderControl1.Sections[3].Text := '0 kb';

  ListBox1.Clear;
  Label1.Enabled := true;
  ComboBox1.Enabled := true;

  Image1.Picture.Graphic := nil;
end;

procedure TForm1.Clear2Click(Sender: TObject);
begin
  Clear1.Click;
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.Convert1Click(Sender: TObject);
begin
  Button1.Click;
end;

// Allow only numbers and dots for quality input.
procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If not (Key in [#46, #48..#57, #8]) then
    Key := #0;
end;

// single webP file format export
procedure TForm1.Export1Click(Sender: TObject);
var
  bmp : TBitmap;
  JPEGImage: TJPEGImage;
  GIF : TGIFImage;
  i, procent, size : integer;
  list : TStringList;
  quality : single;
  s, path : string;
begin
  // go out no picture found
  if ListBox1.Items.Count = 0 then
  begin
    MessageDlg('Load pictures to export webP format!',mtInformation, [mbOK], 0);
    Exit;
  end;

  // copy quality value
  s := Edit1.Text;

  // Force FormatSettings to use a period as the decimal separator (optional)
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DecimalSeparator := '.';

  // copy quality value
  quality := StrToFloat(s, FormatSettings);
  StatusBar1.Panels[3].Text := 'calculating, please wait..';

  if ComboBox1.ItemIndex = 0 then   // bitmap export single webP format file
  begin
    if SaveDialog1.Execute then
    begin
      try
        bmp := TBitmap.Create;
        bmp.LoadFromFile(ListBox1.Items.Strings[ListBox1.ItemIndex]);

        // the bit format must be 32-bit.
        bmp.PixelFormat := pf32bit;

        // set transparent
        if CheckBox2.Checked = true then
        begin
          bmp.TransparentColor := clBlack;
          bmp.Transparent := true;
        end;

        // Swap the RGB pixels with the BGR ones.
        if not CheckBox1.Checked = true then
        begin
          SwapRGBtoBGR(bmp);
        end;

        // align the image sizes with each other
        if CheckBox4.Checked = true then
        begin
          ResizeWidth(bmp, bmp, SpinEdit1.Value, SpinEdit1.Value,  true);
        end;

        // calculate to grayscale
        if CheckBox5.Checked = true then
        begin
          BitmapGrayscale(bmp);
        end;

        // calculate sepia
        if SpinEdit2.Value <> 0 then
        begin
          Sepia(bmp, SpinEdit1.Value);
        end;

        // create negativ rgb pixel
        if CheckBox6.Checked = true then
        begin
          InvertRGB(bmp);
        end;

        // tone & highlight pixel rgb
        if (SpinEdit3.Value <> 0) or (SpinEdit5.Value <> 0) or
           (SpinEdit5.Value <> 0) then
        begin
          SetRGBChannelValue(bmp, SpinEdit5.Value, SpinEdit4.Value, SpinEdit3.Value);
        end;

        // create webP picture format
        SaveBitmapToWebP(bmp, SaveDialog1.FileName +
          ExtractFileName(ListBox1.Items.Strings[ListBox1.ItemIndex]) + '.webP', quality);
      finally
        bmp.Free;
      end;

    end;
  end;

  if ComboBox1.ItemIndex = 1 then   // jpg/jpeg export single webP format file
  begin
    if SaveDialog1.Execute then
    begin
      try
        JPEGImage:=TJPEGImage.Create;
        JPEGImage.LoadFromFile(ListBox1.Items.Strings[ListBox1.ItemIndex]);
        bmp := TBitmap.Create;
        bmp.Assign(JPEGImage);

        // the bit format must be 32-bit.
        bmp.PixelFormat := pf32bit;

        // set transparent
        if CheckBox2.Checked = true then
        begin
          bmp.TransparentColor := clBlack;
          bmp.Transparent := true;
        end;

        // Swap the RGB pixels with the BGR ones.
        if not CheckBox1.Checked = true then
        begin
          SwapRGBtoBGR(bmp);
        end;

        // align the image sizes with each other
        if CheckBox4.Checked = true then
        begin
          ResizeWidth(bmp, bmp, SpinEdit1.Value, SpinEdit1.Value,  true);
        end;

        // calculate to grayscale
        if CheckBox5.Checked = true then
        begin
          BitmapGrayscale(bmp);
        end;

        // calculate sepia
        if SpinEdit2.Value <> 0 then
        begin
          Sepia(bmp, SpinEdit1.Value);
        end;

        // create negativ rgb pixel
        if CheckBox6.Checked = true then
        begin
          InvertRGB(bmp);
        end;

        // tone & highlight pixel rgb
        if (SpinEdit3.Value <> 0) or (SpinEdit5.Value <> 0) or
           (SpinEdit5.Value <> 0) then
        begin
          SetRGBChannelValue(bmp, SpinEdit5.Value, SpinEdit4.Value, SpinEdit3.Value);
        end;

        SaveBitmapToWebP(bmp, SaveDialog1.FileName +
          ExtractFileName(ListBox1.Items.Strings[ListBox1.ItemIndex]) + '.webP', quality);
      finally
        bmp.Free;
        JPEGImage.Free;
      end;
    end;
  end;

  if ComboBox1.ItemIndex = 2 then   // png export single webP format file
  begin
    if SaveDialog1.Execute then
    begin
      try
        bmp := TBitmap.Create;
        LoadPngToBmp(bmp, ListBox1.Items.Strings[ListBox1.ItemIndex]);

        // the bit format must be 32-bit.
        bmp.PixelFormat := pf32bit;

        // set transparent
        if CheckBox2.Checked = true then
        begin
          bmp.TransparentColor := clBlack;
          bmp.Transparent := true;
        end;

        // Swap the RGB pixels with the BGR ones.
        if not CheckBox1.Checked = true then
        begin
          SwapRGBtoBGR(bmp);
        end;

        // align the image sizes with each other
        if CheckBox4.Checked = true then
        begin
          ResizeWidth(bmp, bmp, SpinEdit1.Value, SpinEdit1.Value,  true);
        end;

        // calculate to grayscale
        if CheckBox5.Checked = true then
        begin
          BitmapGrayscale(bmp);
        end;

        // calculate sepia
        if SpinEdit2.Value <> 0 then
        begin
          Sepia(bmp, SpinEdit1.Value);
        end;

        // create negativ rgb pixel
        if CheckBox6.Checked = true then
        begin
          InvertRGB(bmp);
        end;

        // tone & highlight pixel rgb
        if (SpinEdit3.Value <> 0) or (SpinEdit5.Value <> 0) or
           (SpinEdit5.Value <> 0) then
        begin
          SetRGBChannelValue(bmp, SpinEdit5.Value, SpinEdit4.Value, SpinEdit3.Value);
        end;

        SaveBitmapToWebP(bmp, SaveDialog1.FileName +
          ExtractFileName(ListBox1.Items.Strings[ListBox1.ItemIndex]) + '.webP', quality);
      finally
        bmp.Free;
      end;
    end;
  end;

  if ComboBox1.ItemIndex = 3 then   // gif export single webP format file
  begin
    if SaveDialog1.Execute then
    begin
      try
        bmp := TBitmap.Create;
        GIF := TGIFImage.Create;
        GIF.LoadFromFile(ListBox1.Items.Strings[ListBox1.ItemIndex]);

        // Set bitmap dimensions and format
        Bmp.Width := Gif.Width;
        Bmp.Height := Gif.Height;

        // the bit format must be 32-bit.
        bmp.PixelFormat := pf32bit;

        // set transparent
        if CheckBox2.Checked = true then
        begin
          bmp.TransparentColor := clBlack;
          bmp.Transparent := true;
        end;

        // copy pixel to bitmap
        Bmp.Canvas.Draw(0, 0, Gif);

        // Swap the RGB pixels with the BGR ones.
        if not CheckBox1.Checked = true then
        begin
          SwapRGBtoBGR(bmp);
        end;

        // align the image sizes with each other
        if CheckBox4.Checked = true then
        begin
          ResizeWidth(bmp, bmp, SpinEdit1.Value, SpinEdit1.Value,  true);
        end;

        // calculate to grayscale
        if CheckBox5.Checked = true then
        begin
          BitmapGrayscale(bmp);
        end;

        // calculate sepia
        if SpinEdit2.Value <> 0 then
        begin
          Sepia(bmp, SpinEdit1.Value);
        end;

        // create negativ rgb pixel
        if CheckBox6.Checked = true then
        begin
          InvertRGB(bmp);
        end;

        // tone & highlight pixel rgb
        if (SpinEdit3.Value <> 0) or (SpinEdit5.Value <> 0) or
           (SpinEdit5.Value <> 0) then
        begin
          SetRGBChannelValue(bmp, SpinEdit5.Value, SpinEdit4.Value, SpinEdit3.Value);
        end;

        SaveBitmapToWebP(bmp, SaveDialog1.FileName +
          ExtractFileName(ListBox1.Items.Strings[ListBox1.ItemIndex]) + '.webP', quality);
      finally
        bmp.Free;
        GIF.Free;
      end;
    end;
  end;
  // get file size from exported webP file
  GetSplitFileSizeExportWebP;
  StatusBar1.Panels[3].Text := 'Export done.';
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteOptions;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Prevent flickering while the process is running.
  Panel2.DoubleBuffered := true;

  // Draw a horizontal scrollbar on the ListBox.
  Listbox1.Perform(LB_SetHorizontalExtent, 1000, Longint(0));

  // ensures that the list box is no longer drawn by the operating system
  ListBox1.Style := lbOwnerDrawFixed;

  // set a fixed item height
  ListBox1.ItemHeight := 16;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;

  CheckBox4.OnClick(sender);
  Settings1.OnClick(sender);
  StayTop1.OnClick(sender);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  try
    // display the imported picture
    Image1.Picture.LoadFromFile(ListBox1.Items.Strings[ListBox1.ItemIndex]);

    StatusBar1.Panels[3].Text := ExtractFilename(ListBox1.Items.Strings[ListBox1.ItemIndex]);
    StatusBar1.Panels[5].Text := IntToStr(Image1.Width) + 'x' +
                                 IntToStr(Image1.Height);

    // Determine the exact file size of the image.
    GetSplitFileSize;
  except
    on E:exception do
      ShowMessage(E.Message);
  end;
end;

// Open the image with the standard Windows image viewer.
procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open',
    PChar(ListBox1.Items.Strings[ListBox1.ItemIndex]), nil, nil, SW_SHOWNORMAL) ;
end;

// Draw the system's shell32 icons and bar into the ListBox.
procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
 Len: Integer;
 NewText: String;
begin
  NewText:=Listbox1.Items[Index];

  // This part is for the scrollbar.
  with Listbox1.Canvas do
  begin
    FillRect(Rect);
    TextOut(Rect.Left + 1, Rect.Top, NewText);
    Len:=TextWidth(NewText) + Rect.Left + 10;
    if Len>flbHorzScrollWidth then
    begin
      flbHorzScrollWidth:=Len;
      Listbox1.Perform(LB_SETHORIZONTALEXTENT, flbHorzScrollWidth, 0 );
    end;
  end;

  // The icons are drawn here.
  DrawListBoxExtra(Control, Index, Rect, State);
end;

// Open a WebP image and display
procedure TForm1.LoadwebP1Click(Sender: TObject);
var
  WICImage: TWICImage;
begin
  OpenDialog1.Filter := 'WebP lossy file (*.webp)|*.webp;';

  // create memory access for WICImage
  WICImage := TWICImage.Create;
  if OpenDialog1.Execute then
  begin
    try
      { loads an image file (such as JPEG, PNG, TIFF, or BMP) from disk
        using the Windows Imaging Component (WIC)
        Available in the Vcl.Graphics unit (Windows VCL only) }
      WICImage.LoadFromFile(OpenDialog1.FileName);

      // Can be directly allocated or subscribed to.
      Image1.Picture.Assign(WICImage);

      StatusBar1.Panels[3].Text := ExtractFilename(OpenDialog1.FileName);
      StatusBar1.Panels[5].Text := IntToStr(Image1.Width) + 'x' +
                                   IntToStr(Image1.Height);

      // Determine the exact file size of a webP file.
      GetSplitFileSizeWebP;
    finally
      // release WICImage
      WICImage.Free;
    end;
  end;
end;

procedure TForm1.Open1Click(Sender: TObject);
var
  size : integer;
  list : TStringList;
begin
  // Enable multi-select in the file dialog
  OpenDialog1.Options := OpenDialog1.Options + [ofAllowMultiSelect];

  // Pass the file format to the visible Windows dialog filter.
  case ComboBox1.ItemIndex of
    0 : OpenDialog1.Filter := 'Windows Bitmap (*.bmp)|*.bmp;';
    1 : OpenDialog1.Filter := 'Jpg/Jpeg (*.jpeg)|*.jpg;*.jpeg';
    2 : OpenDialog1.Filter := 'Portable Network Graphic (*.png)|*.png;';
    3 : OpenDialog1.Filter := 'Graphics Interchange Format (*.gif)|*.gif;';
  end;

  if OpenDialog1.Execute then
  begin
    { Set up memory access for the list of files whose sizes are to
      be determined. }
    list := TStringList.Create;

    // faster ListBox performance
    ListBox1.Items.BeginUpdate;
    try
      // Clear existing entries or omit this line to append them
      ListBox1.Items.Clear;

      // Add all selected files to the ListBox
      ListBox1.Items.AddStrings(OpenDialog1.Files);

      { Here, the files are combined to determine the total size of all files;
        this is important for comparing sizes after conversion. }
      list.AddStrings(OpenDialog1.Files);

      // Calculation of the file(s) size from the list
      size := GetTotalSizeOfFiles(list);
    finally
      // end ListBox work
      ListBox1.Items.EndUpdate;

      // Passing the maximum number of files to the progress bar
      ProgressBar1.Max := ListBox1.Items.Count;

      // display file  count
      StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);

      // display the maximal size from all loaded pictures
      HeaderControl1.Sections[1].Text := IntToStr(size div 1000) + ' kb';

      // release the file list
      list.Free;

      Label1.Enabled := false;
      ComboBox1.Enabled := false;
    end;
  end;
end;

// execute the windows properties dialog for slected picture
procedure TForm1.Properties1Click(Sender: TObject);
begin
  if ListBox1.Items.Count = 0 then Exit;
  PropertiesDialog(ListBox1.Items.Strings[ListBox1.ItemIndex]);
end;

// This part removes one or more pictures from the ListBox.
procedure TForm1.Remove1Click(Sender: TObject);
var
  i : Integer;
  size : integer;
  list : TStringList;
begin
  if ListBox1.Items.Count = 0 then Exit;   // go out no picture loaded

  // faster ListBox performance
  ListBox1.Items.BeginUpdate; // Prevents the UI from flickering
  try
    for i := ListBox1.Items.Count - 1 downto 0 do
    begin
      if ListBox1.Selected[i] then
      begin
        ListBox1.Items.Delete(i);
      end;
    end;
  finally
    StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);
    ListBox1.Items.EndUpdate; // Re-enables UI rendering
  end;

  // must be set to zero to obtain an exact result
  size := 0; // multiple file size variable

  // Recalculate the total size of the remaining files.
  for i := 0 to ListBox1.Items.Count -1 do
  begin
    try
      list := TStringList.Create;
      list.AddStrings(ListBox1.Items.Strings[i]);
      size := size + GetTotalSizeOfFiles(list);
    finally
      // Display the size of the remaining files.
      HeaderControl1.Sections[1].Text := IntToStr(size div 1000) + ' kb';

      // release file list
      list.Free;
    end;
  end;
end;

// view setting panel
procedure TForm1.Settings1Click(Sender: TObject);
begin
  Panel4.Visible := Settings1.Checked;
end;

procedure TForm1.Staytop1Click(Sender: TObject);
begin
  if StayTop1.Checked = true then
  begin
    SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
    SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

(* ------------------------------ *)
(* sorry for my terrible english. *)
(* ------------------------------ *)
end.
