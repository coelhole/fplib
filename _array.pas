unit _array;

interface

uses
  sysUtils;

type
  shortarr = array of shortint;
  smallarr = array of smallint;
  wordarr = array of word;
  longarr= array of longint;
  longwordarr = array of longword;
  int64arr = array of int64;
  qwordarr = array of qword;

  singlearr=array of single;
  doublearr=array of double;
  extendedarr=array of extended;
  comparr=array of comp;
  currencyarr=array of currency;

  chararr=array of char;
  ansichararr=array of ansichar;
  widechararr=array of widechar;
  shortstringarr=array of shortstring;
  ansistringarr=array of ansistring;
  stringarr=array of string;
  widestringarr=array of widestring;

generic ArrayOf<T> = class
  private
    fArray: array of T;
    procedure setLen(const newLength:longint);
    function getLen:longint;
    function getElement(index:longint):T;
    procedure setElement(index:longint;elmnt:T);
  public
    constructor create(const len:longint);overload;
    constructor create;overload;
    function append(const elmnt:T):longint;
    property len:longint read getLen write setLen;
    property element[index:longint]:T read getElement write setElement;
end;

ArrayOfBoolean=specialize ArrayOf<boolean>;
ArrayOfByte=specialize ArrayOf<byte>;
ArrayOfShortint=specialize ArrayOf<shortint>;
ArrayOfSmallint=specialize ArrayOf<smallint>;
ArrayOfWord=specialize ArrayOf<word>;
ArrayOfLongint=specialize ArrayOf<longint>;
ArrayOfLongword=specialize ArrayOf<longword>;
ArrayOfInt64=specialize ArrayOf<int64>;
ArrayOfQword=specialize ArrayOf<qword>;
ArrayOfSingle=specialize ArrayOf<single>;
ArrayOfDouble=specialize ArrayOf<double>;
ArrayOfExtended=specialize ArrayOf<extended>;
ArrayOfComp=specialize ArrayOf<comp>;
ArrayOfCurrency=specialize ArrayOf<currency>;
ArrayOfChar=specialize ArrayOf<char>;
ArrayOfAnsiChar=specialize ArrayOf<ansiChar>;
ArrayOfWideChar=specialize ArrayOf<wideChar>;
ArrayOfShortString=specialize ArrayOf<shortString>;
ArrayOfString=specialize ArrayOf<string>;
ArrayOfAnsiString=specialize ArrayOf<ansiString>;
ArrayOfWideString=specialize ArrayOf<wideString>;

implementation

uses
  _exceptions;

constructor ArrayOf.create(const len:longint);
begin
  self.setLen(len);
end;

constructor ArrayOf.create;
begin
  create(0);
end;

procedure ArrayOf.setLen(const newLength:longint);
begin
  if newLength<0 then raise ENegativeArraySize.create('illegal len value: '+intToStr(newLength)+': len must be a non-negative integer');
  setLength(self.fArray,newLength);
end;

function ArrayOf.getLen:longint;
begin
  result:=length(self.fArray);
end;

function ArrayOf.getElement(index:longint):T;
begin
  if (index<0)or(index>=len) then raise EArrayIndexOutOfBounds.create(index);
  result:=self.fArray[index];
end;

procedure ArrayOf.setElement(index:longint;elmnt:T);
begin
  if (index<0)or(index>=len) then raise EArrayIndexOutOfBounds.create(index);
  self.fArray[index]:=elmnt;
end;

function ArrayOf.append(const elmnt:T):longint;
begin
  try
    result:=length(self.fArray);
    setLength(self.fArray,result+1);
    self.fArray[result]:=elmnt;
  except
    result:=-1;
  end;
end;

end.
