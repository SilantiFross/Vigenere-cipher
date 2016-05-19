unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TLab_1 = class(TForm)
    OriginalMemo: TMemo;
    OpenButton: TButton;
    EncryptButton: TButton;
    SaveButton: TButton;
    KeyEdit: TEdit;
    KeyLabel: TLabel;
    HintLabel: TLabel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    DecryptButton: TButton;
    CryptMemo: TMemo;
    TestButton: TButton;
    AnswerLabel: TLabel;
    AnswerKeyLabel: TLabel;
    procedure OpenButtonClick(Sender: TObject);
    procedure KeyEditChange(Sender: TObject);
    procedure EncryptButtonClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure DecryptButtonClick(Sender: TObject);
    procedure TestButtonClick(Sender: TObject);
    procedure KeyEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Lab_1: TLab_1;

implementation

{$R *.dfm}
var
  i: Integer = 1;

function FormulaEncr(alphaNumberText, alphaNumberKey: Integer): Integer;
begin
  Result := (alphaNumberText + alphaNumberKey) mod 33;
end;

function FormulaDecr(alphaNumberCipher, alphaNumberKey: Integer): Integer;
begin
  Result := (alphaNumberCipher - alphaNumberKey + 33) mod 33;
end;

function ObtainKeySymbols(key: String): Char;
begin
  Result := Key[i];
  inc(i);
end; 

procedure DataDisplay(data: String);
begin
  Lab_1.CryptMemo.Clear;
  Lab_1.CryptMemo.Lines.Add(data);
end;

procedure ControlAlphabet(var NumAlph: Integer);
begin
  if NumAlph < 6 then
    NumAlph := NumAlph + 1040
  else
    if NumAlph > 6 then
      NumAlph := NumAlph + 1039
    else
    NumAlph := 1025;
end;

function SetRusAlphabet(TblSym: Char): Integer;
var
  TblCoef: Integer;
begin
  case (Ord(TblSym)) of
    1040..1045:
      TblCoef := 1040;
    1046..1071:
      TblCoef := 1039;
    1072..1077:
      TblCoef := 1072;
    1078..1103:
      TblCoef := 1071;
  else
    Result := 6;
    exit;
  end;

  Result := Ord(TblSym) - TblCoef;
end;

procedure WorkingWithText;
Var
  TheOriginalText: TextFile;
  symbolOfTheText, symbolOfTheKey: Char;
  alphaNumberText: Integer;
  alphaNumberKey: Integer;
  workingCharacter: Integer;
  stringOutput, key: String;
begin
  assignFile(TheOriginalText, Lab_1.OpenDialog.FileName);
  reset(TheOriginalText);
  key := Lab_1.KeyEdit.Text;
  while not (Eof(TheOriginalText)) do
  begin
    read(TheOriginalText, symbolOfTheText);
    if (Ord(symbolOfTheText) >= 1040) and (Ord(symbolOfTheText) <= 1103)
        or (Ord(symbolOfTheText) = 1025) or (Ord(symbolOfTheText) = 1105)  then
    begin
      alphaNumberText := SetRusAlphabet(symbolOfTheText);

      if Lab_1.RadioButton1.Checked then
        key := key + symbolOfTheText;
        
      symbolOfTheKey := ObtainKeySymbols(key);
      alphaNumberKey := SetRusAlphabet(symbolOfTheKey);

      if Lab_1.RadioButton1.Checked then
      begin
        workingCharacter := FormulaEncr(alphaNumberText, alphaNumberKey);
        ControlAlphabet(workingCharacter);
      end
      else
      begin
        workingCharacter := FormulaDecr(alphaNumberText, alphaNumberKey);
        ControlAlphabet(workingCharacter);
        key := key + Chr(workingCharacter);
      end;
      stringOutput := stringOutput + Chr(workingCharacter);
    end
    else
    begin
      if symbolOfTheText = ' ' then
        stringOutput := stringOutput + ' ';
    end;
  end;

  CloseFile(TheOriginalText);
  DataDisplay(stringOutput);
end;

function NOD (var valueA: Integer; var valueB: Integer): Integer;
var
  tempValue: Integer;
begin
  while valueB > 0 do
  begin
    tempValue := valueA mod valueB;
    valueA := valueB;
    valueB := tempValue;
  end;

  result := valueA;
end;

procedure ChunkOfText (var Chunk: String; txt: String; position: Integer);
begin
  Chunk[1] := txt[position];
  Chunk[2] := txt[position + 1];
  Chunk[3] := txt[position + 2];
end;

procedure TestKasiski;
var
  cipFile: TextFile;
  cipheredString: String;
  strOne, strTwo: String;
  symbolCip: Char;
  i, j, z: Integer;
  Distance: array of Integer;
  pred: String;
  counterNODS: array [1..50] of Integer;
  counter: Integer;
  maxNOD, maxI: Integer;
begin
  assignFile(cipFile, Lab_1.OpenDialog.FileName);
  reset(cipFile);
  while not (Eof(cipFile)) do
  begin
    read(cipFile, symbolCip);
    if symbolCip <> ' ' then
      cipheredString := cipheredString + symbolCip;
  end;
  closeFile(cipFile);

  setlength(strOne, 3);
  setlength(strTwo, 3);

  z := 0;
  for i := 1 to 50 do
    counterNODS[i] := 0;

  for i := 1 to length(cipheredString) do
  begin
    if (cipheredString[i] <> ' ') and (cipheredString[i + 1] <> ' ') and (cipheredString[i + 2] <> ' ') then
      ChunkOfText(strOne, cipheredString, i)
    else
      strOne := '000';

    for j := i + 1 to length(cipheredString) do
    begin
      if (cipheredString[j] <> ' ') and (cipheredString[j + 1] <> ' ') and (cipheredString[j + 2] <> ' ') then
        ChunkOfText(strTwo, cipheredString, j)
      else
        strTwo := '111';

      if strOne = strTwo then
      begin
        if pred <> strOne then
          Lab_1.CryptMemo.Lines.Add(strOne + ': ');

        pred := strOne;
        setlength(Distance, z + 1);
        Distance[z] := j - i;
        Lab_1.CryptMemo.Text := Lab_1.CryptMemo.Text + IntToStr(Distance[z]) + ', ';

        inc(z);
      end;
    end;
  end;

  for i := 1 to z - 1 do
  begin
    for j := i + 1 to z - 1 do
    begin
      counter := NOD(Distance[i], Distance[j]);
      if (counter >= 2) and (counter <= 50) then
        inc(counterNODS[counter]);
    end;
  end;

  maxNOD := 0;
  maxI := 0;

 for i := 1 to 49 do
 begin
   if counterNODS[i] > maxNOD then
   begin
     maxNOD := counterNODS[i];
     maxI := i;
   end;
 end;
 
 Lab_1.AnswerKeyLabel.Caption := 'Length key: ' + IntToStr(maxI);
end;

procedure TLab_1.OpenButtonClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Text only|*.txt';
  OpenDialog.Execute;
  if OpenDialog.FileName <> '' then
  begin
    TestButton.Enabled := true;
    OriginalMemo.Lines.LoadFromFile(OpenDialog.FileName);
  end
  else
    Application.MessageBox('File is not opened', 'Error');
end;

procedure TLab_1.RadioButton1Click(Sender: TObject);
begin
  DecryptButton.Visible := false;
  EncryptButton.Visible := true;
  KeyEdit.Clear;
end;

procedure TLab_1.RadioButton2Click(Sender: TObject);
begin
  DecryptButton.Visible := true;
  EncryptButton.Visible := false;
  KeyEdit.Clear;
end;

procedure TLab_1.SaveButtonClick(Sender: TObject);
begin
  SaveDialog.Filter := 'Text only|*.txt';
  if SaveDialog.Execute then
    CryptMemo.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TLab_1.KeyEditChange(Sender: TObject);
begin
  if RadioButton1.Checked then
    if (Length(KeyEdit.Text)) > 2 then
    begin
      EncryptButton.Visible := true;
      HintLabel.Visible := false;
    end
    else
    begin
      EncryptButton.Visible := false;
      HintLabel.Visible := true;
    end;
  if RadioButton2.Checked then
    if (Length(KeyEdit.Text)) > 2 then
    begin
      DecryptButton.Visible := true;
      HintLabel.Visible := false;
    end
    else
    begin
      DecryptButton.Visible := false;
      HintLabel.Visible := true;
    end;
end;

procedure TLab_1.KeyEditKeyPress(Sender: TObject; var Key: Char);
const
  EnAlphSmll = ['a'..'z'];
  EnAlphBg = ['A'..'Z'];
  Digit = ['0'..'9'];
  Gabage = ['!','@','#','$','%','^','&','*','(',')', '-', '_', '+', '=', ',', '.', '/', '?', '}', '{', ':', ';', '"', ']', '[', '<', '>'];
begin
  if (key in EnAlphSmll) or (key in EnAlphBg) or (key in Digit) or (key in Gabage) then
    key := #0;
end;

procedure TLab_1.TestButtonClick(Sender: TObject);
begin
  TestKasiski;
end;

procedure TLab_1.DecryptButtonClick(Sender: TObject);
begin
  WorkingWithText;
  KeyEdit.Clear;
  i := 1;
end;

procedure TLab_1.EncryptButtonClick(Sender: TObject);
begin
  WorkingWithText;
  KeyEdit.Clear;
  i := 1;
end;

end.