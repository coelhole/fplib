unit _exceptions;

interface

uses
  classes,
  sysUtils;

function backTraceStr(addr:codePointer):shortString;
procedure dumpExceptionBackTrace;
procedure printStackTrace(const e:TObject=nil;const message:string='');

type
EIndexOutOfBounds=class(Exception);

EArrayIndexOutOfBounds=class(EIndexOutOfBounds)
public
  constructor create(const index:longint);
end;

ENegativeArraySize=class(Exception);

implementation

uses
  lineInfo;

function backTraceStr(addr:codePointer):shortString;
var
  func,
  source  : shortString;
  hs      : string;
  line    : longint;
  success : boolean;
begin
  func:='';
  source:='';
  success:=false;
  line:=0;
  success:=getLineInfo(ptruint(addr),func,source,line);
  result:=#9+'at $'+lowerCase(hexStr(addr));
  if success then
  begin
    if func<>'' then
      result:=result+' '+lowerCase(func);
    if source<>'' then
    begin
      if func<>'' then
        result:=result+'(';
      if line<>0 then
      begin
        str(line,hs);
        result:=result+source;
      end;
      result:=result+':'+hs+')';
    end;
  end;
end;

procedure dumpExceptionBackTrace;
var
  frameNumber,
  frameCount   : longint;
  frames       : ^codepointer;
begin
  if raiseList=nil then exit;
  writeLn(backTraceStr(raiseList^.addr));
  frameCount:=raiseList^.frameCount;
  frames:=raiseList^.frames;
  for frameNumber := 0 to frameCount-1 do
    writeLn(backTraceStr(frames[frameNumber]));
end;

procedure printStackTrace(const e:TObject=nil;const message:string='');
var
  exceptionInfo:string;
begin
  exceptionInfo:='Exception in thread ' + intToStr(TThread.currentThread.threadID);
  if e<>nil then exceptionInfo:=exceptionInfo+' '+e.unitName+'.' +e.className;
  if message<>'' then exceptionInfo:=exceptionInfo+': '+message+lineEnding;
  write(exceptionInfo);
  dumpExceptionBackTrace;
end;

constructor EArrayIndexOutOfBounds.create(const index:longint);
begin
  inherited create('Array index out of range: ' + intToStr(index));
end;

end.
