unit _shortint;

interface

uses
  sysUtils;

const
  SHORTINT_BYTE_SIZE=sizeOf(shortint);
  SHORTINT_BIT_SIZE=8*SHORTINT_BYTE_SIZE;
  SHORTINT_MIN_VALUE=low(shortint);
  SHORTINT_MAX_VALUE=high(shortint);

function compare(const s1,s2:shortint):longint;overload;
function equals(const s1,s2:shortint):boolean;overload;
function toString(const s:shortint):string;overload;
function smallintValue(const s:shortint):smallint;overload;
function longintValue(const s:shortint):longint;overload;
function int64Value(const s:shortint):int64;overload;
function singleValue(const s:shortint):single;overload;
function doubleValue(const s:shortint):double;overload;
function extendedValue(const s:shortint):extended;overload;
function compValue(const s:shortint):comp;overload;
function currencyValue(const s:shortint):currency;overload;

implementation

function compare(const s1,s2:shortint):longint;
begin
	result:=s1-s2;
end;

function equals(const s1,s2:shortint):boolean;
begin
	result:=s1=s2;
end;

function toString(const s:shortint):string;
begin
	result:=intToStr(s);
end;

function smallintValue(const s:shortint):smallint;
begin
	result:=s;
end;

function longintValue(const s:shortint):longint;
begin
	result:=s;
end;

function int64Value(const s:shortint):int64;
begin
	result:=s;
end;

function singleValue(const s:shortint):single;
begin
	result:=s;
end;

function doubleValue(const s:shortint):double;
begin
	result:=s;
end;

function extendedValue(const s:shortint):extended;
begin
	result:=s;
end;

function compValue(const s:shortint):comp;
begin
	result:=s;
end;

function currencyValue(const s:shortint):currency;
begin
	result:=s;
end;

end.
