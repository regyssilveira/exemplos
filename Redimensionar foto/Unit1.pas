unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JPEG, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Logo: TImage;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  bmp: TBitmap;
  jpg: TJPEGImage;
  scale: Double;
  widthL, HeightL, pt1, pt2, pt3, pt4: integer;
  verdd : boolean;
begin
  if OpenDialog1.Execute then
  begin
    try
      jpg := TJPEGImage.Create;
      verdd := false;
      try
        //Dimensões
//            widthL := 98;
//            HeightL := 98;
        widthL  := 1024;
        HeightL := 768;

        jpg.LoadFromFile(OpenDialog1.FileName);

        if (jpg.Height >= jpg.Width) AND (HeightL <= jpg.Height) then
        begin
          scale := widthL / jpg.Height;
        end
        else
        if (jpg.Height <= jpg.Width) AND (widthL <=  jpg.Width) then
        begin
          scale := HeightL / jpg.Width;
        end
        else
        begin
          verdd := true;
        end;

        bmp := TBitmap.Create;
        try
          bmp.SetSize(widthL, HeightL);
          if not verdd then
          begin
            pt1 := (widthL - Round(jpg.Width * scale)) div 2;
            pt2 := (HeightL - Round(jpg.Height * scale)) div 2;
            pt3 := Round(jpg.Width * scale) + pt1;
            pt4 := Round(jpg.Height * scale) + pt2;

            bmp.Canvas.StretchDraw(Rect(pt1, pt2, pt3, pt4), jpg);
          end
          else
          begin
            pt1 := (widthL - jpg.Width) div 2;
            pt2 := (HeightL - jpg.Height) div 2;
            pt3 := jpg.Width + pt1;
            pt4 := jpg.Height + pt2;

            bmp.Canvas.StretchDraw(Rect(pt1, pt2, pt3, pt4), jpg);
          end;

          // Convert back to JPEG and save to file
          Logo.Picture.Assign(bmp);
          jpg.Assign(bmp);
          jpg.SaveToFile(ChangeFileExt(OpenDialog1.FileName, '_thumb.JPG'));
        finally
          bmp.free;
        end;
      finally
        jpg.free;
      end;
    except
      showMessage('Erro ao carregar imagem');
    end;
  end;
end;





procedure TForm1.Button2Click(Sender: TObject);
var
  bmp: TBitmap;
  jpg: TJpegImage;
  scale: Double;
  widthL, HeightL: Integer;
begin
  if opendialog1.execute then
  begin
    jpg := TJpegImage.Create;
    try
      jpg.Loadfromfile(opendialog1.filename);

      widthL  := 200;
      HeightL := 200;

      if jpg.Height > jpg.Width then
        scale := widthL / jpg.Height
      else
        scale := HeightL / jpg.Width;

      bmp := TBitmap.Create;
      try
        bmp.Width := Round(jpg.Width * scale);
        bmp.Height:= Round(jpg.Height * scale);
        bmp.Canvas.StretchDraw(bmp.Canvas.Cliprect, jpg);

        Self.Canvas.Draw(100, 10, bmp);

        jpg.Assign(bmp);
        jpg.SaveToFile(
          ChangeFileext(opendialog1.filename, '_thumb.JPG')
        );
      finally
        bmp.free;
      end;
    finally
      jpg.free;
    end;
  end;
end;

end.
