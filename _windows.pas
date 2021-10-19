unit _windows;

interface

uses
  classes,
  sysUtils;

const
  WINDOWS_DIRECTORY_SEPARATOR='\';
  WINDOWS_DRIVE_SEPARATOR=':';
  WINDOWS_EOL=#13#10;
  CSIDL_DESKTOP=0;
  CSIDL_INTERNET=1;
  CSIDL_PROGRAMS=2;
  CSIDL_CONTROLS=3;
  CSIDL_PRINTERS=4;
  CSIDL_PERSONAL=5;
  CSIDL_FAVORITES=6;
  CSIDL_STARTUP=7;
  CSIDL_RECENT=8;
  CSIDL_SENDTO=9;
  CSIDL_BITBUCKET=10;
  CSIDL_STARTMENU=11;
  CSIDL_DESKTOPDIRECTORY=16;
  CSIDL_DRIVES=17;
  CSIDL_NETWORK=18;
  CSIDL_NETHOOD=19;
  CSIDL_FONTS=20;
  CSIDL_TEMPLATES=21;
  CSIDL_COMMON_STARTMENU=22;
  CSIDL_COMMON_PROGRAMS=23;
  CSIDL_COMMON_STARTUP=24;
  CSIDL_COMMON_DESKTOPDIRECTORY=25;
  CSIDL_APPDATA=26;
  CSIDL_PRINTHOOD=27;
  CSIDL_LOCAL_APPDATA=28;
  CSIDL_ALTSTARTUP=29;
  CSIDL_COMMON_ALTSTARTUP=30;
  CSIDL_COMMON_FAVORITES=31;
  CSIDL_INTERNET_CACHE=32;
  CSIDL_COOKIES=33;
  CSIDL_HISTORY=34;
  CSIDL_COMMON_APPDATA=35;
  CSIDL_WINDOWS=36;
  CSIDL_SYSTEM=37;
  CSIDL_PROGRAM_FILES=38;
  CSIDL_MYPICTURES=39;
  CSIDL_PROFILE=40;
  CSIDL_SYSTEMX86=41;
  CSIDL_PROGRAM_FILESX86=42;
  CSIDL_PROGRAM_FILES_COMMON=43;
  CSIDL_PROGRAM_FILES_COMMONX86=44;
  CSIDL_COMMON_TEMPLATES=45;
  CSIDL_COMMON_DOCUMENTS=46;
  CSIDL_COMMON_ADMINTOOLS=47;
  CSIDL_ADMINTOOLS=48;
  CSIDL_CONNECTIONS=49;
  CSIDL_COMMON_MUSIC=53;
  CSIDL_COMMON_PICTURES=54;
  CSIDL_COMMON_VIDEO=55;
  CSIDL_RESOURCES=56;
  CSIDL_RESOURCES_LOCALIZED=57;
  CSIDL_COMMON_OEM_LINKS=58;
  CSIDL_CDBURN_AREA=59;
  CSIDL_COMPUTERSNEARME=61;
  CSIDL_FLAG_DONT_VERIFY=$4000;
  CSIDL_FLAG_CREATE=$8000;
  CSIDL_FLAG_MASK=$FF00;

function WINDOWS_EDITION:string;
function WINDOWS_VERSION:string;
function WINDOWS_FULLY_QUALIFIED_VERSION:string;
function WINDOWS_USER:string;
function WINDOWS_COMPUTERNAME:string;
function WINDOWS_SCREEN_HEIGHT:longint;
function WINDOWS_SCREEN_WIDTH:longint;

function specialdir(const csidlconst:integer):ansistring;

implementation

uses
  win32Proc,
  windows;

type
  csidl=CSIDL_DESKTOP..CSIDL_COMPUTERSNEARME;

var
  specialdirs:array[csidl] of ansistring;

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

function specialdir(const csidlconst:integer):ansistring;
begin
  if (csidlconst<low(csidl))or(csidlconst>high(csidl)) then
    result:=''
  else result:=specialdirs[csidlconst];
end;

procedure setspecialdirs;
begin
  //
end;

initialization
  setspecialdirs;
end.
