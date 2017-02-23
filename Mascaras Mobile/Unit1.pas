unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    edtCNPJ: TEdit;
    Label1: TLabel;
    edtCPF: TEdit;
    Label2: TLabel;
    edtMaskPesonalizada: TEdit;
    Label3: TLabel;
    procedure edtCNPJTyping(Sender: TObject);
    procedure edtCPFTyping(Sender: TObject);
    procedure edtMaskPesonalizadaTyping(Sender: TObject);
  private
    function GetValorFormatado(const AValor, AMascara: String): String;
    function GetValorFormatado2(const AValor, AMascara: String): String;
  public

  end;

var
  Form1: TForm1;

implementation

uses
  System.MaskUtils;

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}

function TForm1.GetValorFormatado(const AValor, AMascara: String): String;
var
  I, X: Integer;
  MaskTmp: String;
  StrLimpa: String;
const
  CARACTERES_MASCARA = ['.', ',', '/', '\', '-'];
begin
  if not AValor.Trim.IsEmpty then
  begin
    // remover mascara
    StrLimpa := '';
    for I := Low(AValor) to High(AValor) do
    begin
      if not CharInSet(AValor[I], CARACTERES_MASCARA) then
        StrLimpa := StrLimpa + AValor[I];
    end;

    // formatar
    Result := '';
    X := Low(AMascara);
    for I := Low(AMascara) to High(AMascara) do
    begin
      if AMascara[I] = '*' then
      begin
        Result := Result + StrLimpa[X];
        X := X + 1;
      end
      else
        Result := Result + AMascara[I];

      if X > StrLimpa.Length then
        Exit;
    end;

    if CharInSet(Result[Result.Length], CARACTERES_MASCARA) then
      Delete(Result, Result.Length, 1);
  end
  else
    Result := '';
end;

function TForm1.GetValorFormatado2(const AValor, AMascara: String): String;
var
  I: Integer;
  MaskTmp: String;
const
  CARACTERES_MASCARA = ['.', ',', '/', '\', '-'];
begin
  if not AValor.Trim.IsEmpty then
  begin
    // remover mascara
    Result := '';
    for I := Low(AValor) to High(AValor) do
    begin
      if not CharInSet(AValor[I], CARACTERES_MASCARA) then
        Result := Result + AValor[I];
    end;

    // formatar
    Result := FormatMaskText(AMascara, Result);
  end
  else
    Result := '';
end;




procedure TForm1.edtCNPJTyping(Sender: TObject);
begin
  edtCNPJ.Text := GetValorFormatado(edtCNPJ.Text, '**.***.***/****-**');
  edtCNPJ.GoToTextEnd;
end;

procedure TForm1.edtCPFTyping(Sender: TObject);
begin
  edtCPF.Text := GetValorFormatado(edtCPF.Text, '***.***.***-**');
  edtCPF.GoToTextEnd;
end;

procedure TForm1.edtMaskPesonalizadaTyping(Sender: TObject);
begin
  edtMaskPesonalizada.Text := GetValorFormatado(edtMaskPesonalizada.Text, '**.******.***.*.*.*.*');
  edtMaskPesonalizada.GoToTextEnd;
end;

end.
