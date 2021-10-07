unit _boolean;

interface

uses
  sysUtils;

const
  BOOLEAN_BYTE_SIZE=sizeOf(boolean);
  BOOLEAN_BIT_SIZE=8*BOOLEAN_BYTE_SIZE;
  BOOLEAN_FALSE_STRING='false';
  BOOLEAN_TRUE_STRING='true';
  BOOLEAN_FALSE_INTEGER_VALUE=0;
  BOOLEAN_TRUE_INTEGER_VALUE=1;

type
  UnaryLogicalOperator=function(b:boolean):boolean;
  BinaryLogicalOperator=function(b1,b2:boolean):boolean;

function biimpl(const b1,b2:boolean):boolean;
function boolToInt(b:boolean):byte;
function compare(const b1,b2:boolean):longint;
function commut(const binaryConnective:BinaryLogicalOperator;const arg1,arg2:boolean):boolean;
function equals(const b1,b2:boolean):boolean;
function eval(const binaryConnective:BinaryLogicalOperator;const arg1,arg2:boolean):boolean;overload;
function eval(const unaryOperator:UnaryLogicalOperator;const arg:boolean):boolean;overload;
function identity(const b:boolean):boolean;
function impl(const b1,b2:boolean):boolean;
function isCommutative(const binaryConnective:BinaryLogicalOperator):boolean;
function isIdempotent(const binaryConnective:BinaryLogicalOperator):boolean;overload;
function isIdempotent(const unaryOperator:UnaryLogicalOperator):boolean;overload;
function logicalAnd(const b1,b2:boolean):boolean;
function logicalOr(const b1,b2:boolean):boolean;
function logicalXor(const b1,b2:boolean):boolean;
function nand(const b1,b2:boolean):boolean;
function nor(const b1,b2:boolean):boolean;
function toString(const b:boolean):string;
function parseBoolean(const booleanString:string):boolean;
function xnor(const b1,b2:boolean):boolean;

type
Bool=class sealed
private
  value:boolean;
  class var OBJ_TRUE:Bool;
  class var OBJ_FALSE:Bool;
public
  constructor create(const b:boolean);overload;
  constructor create(const s:string);overload;
  function compareTo(const o:Bool):longint;
  function equals(obj:TObject):boolean;
  function toString:ansiString;override;overload;
  property booleanValue:boolean read value;
  class function logicalAnd(const a,b:boolean):boolean;
  class function logicalOr(const a,b:boolean):boolean;
  class function logicalXor(const a,b:boolean):boolean;
  class function nand(const b1,b2:boolean):boolean;
  class function nor(const b1,b2:boolean):boolean;
  class function compare(const x,y:boolean):longint;
  class function parseBoolean(const s:string):boolean;
  class function toString(const b:boolean):ansiString;overload;
  class function valueOf(const b:boolean):Bool;overload;
  class function valueOf(const s:string):Bool;overload;
  class property BOOL_TRUE:Bool read OBJ_TRUE;
  class property BOOL_FALSE:Bool read OBJ_FALSE;
end;


operator :=(b:boolean)obj:Bool;
operator :=(obj:Bool)b:boolean;

implementation

function biimpl(const b1,b2:boolean):boolean;
begin
  result:=impl(b1,b2) and impl(b2,b1);
end;

function boolToInt(b:boolean):byte;
begin
  if b then result:=BOOLEAN_TRUE_INTEGER_VALUE else result:=BOOLEAN_FALSE_INTEGER_VALUE;
end;

function compare(const b1,b2:boolean):longint;
begin
  if b1=b2 then result:=0
  else
  if (not b1) and b2 then result:=-1
  else result:=1;
end;

function commut(const binaryConnective:BinaryLogicalOperator; const arg1,arg2:boolean):boolean;
begin
  result:=binaryConnective(arg2,arg1);
end;

function equals(const b1,b2:boolean):boolean;
begin
  result:=b1=b2;
end;

function eval(const binaryConnective:BinaryLogicalOperator;const arg1,arg2:boolean):boolean;
begin
  result:=binaryConnective(arg1,arg2);
end;

function eval(const unaryOperator:UnaryLogicalOperator;const arg:boolean):boolean;
begin
  result:=unaryOperator(arg);
end;

function identity(const b:boolean):boolean;
begin
  result:=b;
end;

function impl(const b1,b2:boolean):boolean;
begin
  result:=(not b1) or b2;
end;

function isCommutative(const binaryConnective:BinaryLogicalOperator):boolean;
begin
  result:=binaryConnective(false,true)=binaryConnective(true,false);
end;

function isIdempotent(const binaryConnective:BinaryLogicalOperator):boolean;
begin
  result:=
  (binaryConnective(false,false)=false)
   and
  (binaryConnective(true,true)=true);
end;

function isIdempotent(const unaryOperator:UnaryLogicalOperator):boolean;
begin
  result:=
    (unaryOperator(unaryOperator(false))=unaryOperator(false))
     and
    (unaryOperator(unaryOperator(true))=unaryOperator(true));
end;

function logicalAnd(const b1,b2:boolean):boolean;
begin
  result:=b1 and b2;
end;

function logicalOr(const b1,b2:boolean):boolean;
begin
  result:=b1 or b2;
end;

function logicalXor(const b1,b2:boolean):boolean;
begin
  result:=b1 xor b2;
end;

function nand(const b1,b2:boolean):boolean;
begin
  result:=not(b1 and b2);
end;

function nor(const b1,b2:boolean):boolean;
begin
  result:=not(b1 or b2);
end;

function toString(const b:boolean):string;
begin
  if b then result:=BOOLEAN_TRUE_STRING else result:=BOOLEAN_FALSE_STRING;
end;

function parseBoolean(const booleanString:string):boolean;
begin
  result:=lowerCase(trim(booleanString))='true';
end;

function xnor(const b1,b2:boolean):boolean;
begin
  result:=not(b1 xor b2);
end;


{Bool}

//
constructor Bool.create(const b:boolean);
begin
  inherited create;
  self.value:=b;
end;

//
constructor Bool.create(const s:string);
begin
  create(_boolean.parseBoolean(s));
end;

//
class function Bool.compare(const x,y:boolean):longint;
begin
  result:=_boolean.compare(x,y);
end;

//
function Bool.compareTo(const o:Bool):longint;
begin
  result:=_boolean.compare(self.value,o.value);
end;

//
function Bool.equals(obj:TObject):boolean;
begin
  if obj is Bool then
    result:=value=(obj as Bool).value
  else
    result:=false;
end;

//
class function Bool.parseBoolean(const s:string):boolean;
begin
  result:=_boolean.parseBoolean(s);
end;

//
class function Bool.toString(const b:boolean):ansiString;
begin
  result:=_boolean.toString(b);
end;

//
function Bool.toString:ansiString;
begin
  result:=Bool.toString(self.value);
end;

//
class function Bool.valueOf(const b:boolean):Bool;
begin
  if b then result:=Bool.OBJ_TRUE else result:=Bool.OBJ_FALSE;
end;

//
class function Bool.valueOf(const s:string):Bool;
begin
  if Bool.parseBoolean(s) then result:=Bool.OBJ_TRUE else result:=Bool.OBJ_FALSE;
end;

//
class function Bool.logicalAnd(const a,b:boolean):boolean;
begin
  result:=a and b;
end;

//
class function Bool.logicalOr(const a,b:boolean):boolean;
begin
  result:=a or b;
end;

//
class function Bool.logicalXor(const a,b:boolean):boolean;
begin
  result:=a xor b;
end;

//
class function Bool.nand(const b1,b2:boolean):boolean;
begin
  result:=_boolean.nand(b1,b2);
end;

//
class function Bool.nor(const b1,b2:boolean):boolean;
begin
  result:=_boolean.nor(b1,b2);
end;

{operadores}
operator :=(b:boolean)obj:Bool;
begin
  obj:=Bool.create(b);
end;

operator :=(obj:Bool)b:boolean;
begin
  b:=obj.booleanValue;
end;

initialization
  Bool.OBJ_TRUE:=Bool.create(true);
  Bool.OBJ_FALSE:=Bool.create(false);
finalization
  Bool.OBJ_TRUE.free;
  Bool.OBJ_FALSE.free;
end.
