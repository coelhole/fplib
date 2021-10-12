unit _ansichar;

interface

uses
  sysUtils;

const
  CHAR_BYTE_SIZE=sizeOf(char);
  CHAR_BIT_SIZE=8*CHAR_BYTE_SIZE;
  ANSICHAR_BYTE_SIZE=CHAR_BYTE_SIZE;
  ANSICHAR_BIT_SIZE=CHAR_BIT_SIZE;
  MIN_RADIX=1;
  MAX_RADIX=36;
  MIN_DIGIT_CODEPOINT=48;
  MAX_DIGIT_CODEPOINT=122;

type
  radix=MIN_RADIX..MAX_RADIX;
  digitCodePoint=MIN_DIGIT_CODEPOINT..MAX_DIGIT_CODEPOINT;

function digit(const codePoint,radix:longint):longint;overload;
function digit(const ch:char; const radix:longint):longint;overload;inline;

implementation

var
  DigitValue:array[radix,digitCodePoint] of longint;

function digit(const codePoint,radix:longint):longint;
begin
  if (radix<MIN_RADIX) or (radix>MAX_RADIX) then
    result:=-1
  else
  if (codePoint<MIN_DIGIT_CODEPOINT) or (codePoint>MAX_DIGIT_CODEPOINT) then
    result:=-1
  else
    result:=DIGITVALUE[radix,codePoint];
end;

function digit(const ch:char; const radix:longint):longint;
begin
  result:=digit(ord(ch),radix);
end;

procedure popularDigitValueArray;
var
  codep,rdx:longint;
begin
  for codep in [58..64, 91..96] do
    for rdx in radix do
      DigitValue[rdx,codep]:=-1;

  //
end;

initialization
  popularDigitValueArray;
end.
