unit _windows;

interface

uses
  classes,
  sysUtils;

const
  WINDOWS_DIRECTORY_SEPARATOR='\';
  WINDOWS_DRIVE_SEPARATOR=':';
  WINDOWS_EOL=#13#10;

function WINDOWS_EDITION:string;
function WINDOWS_VERSION:string;
function WINDOWS_FULLY_QUALIFIED_VERSION:string;
function WINDOWS_USER:string;
function WINDOWS_COMPUTERNAME:string;
function WINDOWS_SCREEN_HEIGHT:longint;
function WINDOWS_SCREEN_WIDTH:longint;

implementation

uses
  win32Proc,
  windows;

function WINDOWS_EDITION:string;
begin
  case windowsVersion of
    WV95:result:='Windows 95';
    WV98:result:='Windows 98';
    WVNT4:result:='Windows NT 4.0';
    WVME:result:='Windows Millennium';
    WV2000:result:='Windows 2000';
    WVXP:result:='Windows XP';
    WVSERVER2003:result:='Windows Server 2003/Windows XP x64';
    WVVISTA:result:='Windows Vista';
    WV7:result:='Windows 7';
    WV8:result:='Windows 8';
    WV8_1:result:='Windows 8.1';
    WV10:result:='Windows 10';
    else result:='Windows (unknown)';
  end;
  if win32CSDVersion<>'' then result:=result+' '+win32CSDVersion;
end;

function WINDOWS_VERSION:string;
begin
  result:='Microsoft Windows versão '+intToStr(win32MajorVersion)+'.'+intToStr(win32MinorVersion)+'.'+intToStr(win32BuildNumber);
end;

function WINDOWS_FULLY_QUALIFIED_VERSION:string;
begin
  result:=WINDOWS_EDITION+' ('+WINDOWS_VERSION+')';
end;

function WINDOWS_USER:string;
var
  userNameBuffer:array[0..255] of char;
  sizeBuffer:dword;
begin
  sizeBuffer:=256;
  getUserName(userNameBuffer,sizeBuffer);
  result:=string(userNameBuffer);
end;

function WINDOWS_COMPUTERNAME:string;
var
  computerName:array[0..256] of char;
  size:dword;
begin
 size:=256;
 getComputerName(computerName,size);
 result:=computerName;
end;

function WINDOWS_SCREEN_HEIGHT:longint;
var
  DM:TDevMode;
begin
  fillChar(DM,sizeOf(DM),#0);
  DM.DMSize:=sizeOf(DM);
  enumDisplaySettings(nil,ENUM_CURRENT_SETTINGS,@DM);
  result:=DM.DMPelsHeight;
end;

function WINDOWS_SCREEN_WIDTH:longint;
var
  DM:TDevMode;
begin
  fillChar(DM,sizeOf(DM),#0);
  DM.DMSize:=sizeOf(DM);
  enumDisplaySettings(nil,ENUM_CURRENT_SETTINGS,@DM);
  result:=DM.DMPelsWidth;
end;


end.
