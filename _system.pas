unit _system;

interface

function OS_USER:string;
function OS_USER_HOME:string;
function OS_VERSION:string;
function HOSTNAME:string;
function SCREEN_HEIGHT:longint;
function SCREEN_WIDTH:longint;

implementation

uses
  {$IFDEF Linux}
  _linux,
  {$ENDIF}

  {$IFDEF WINDOWS}
  _windows,
  {$ENDIF}

  sysUtils
  ;

function OS_USER:string;
begin
  result:={$IFDEF WINDOWS}WINDOWS_USER{$ELSE}LINUX_USER{$ENDIF};
end;

function OS_USER_HOME:string;
begin
  result:=getUserDir;
end;

function OS_VERSION:string;
begin
  result:={$IFDEF WINDOWS}WINDOWS_FULLY_QUALIFIED_VERSION{$ELSE}LINUX_FULLY_QUALIFIED_VERSION{$ENDIF};
end;

function HOSTNAME:string;
begin
  result:={$IFDEF WINDOWS}lowerCase(WINDOWS_COMPUTERNAME){$ELSE}LINUX_HOSTNAME{$ENDIF};
end;

function SCREEN_HEIGHT:longint;
begin
  result:={$IFDEF WINDOWS}WINDOWS_SCREEN_HEIGHT{$ELSE}LINUX_SCREEN_HEIGHT{$ENDIF};
end;

function SCREEN_WIDTH:longint;
begin
  result:={$IFDEF WINDOWS}WINDOWS_SCREEN_WIDTH{$ELSE}LINUX_SCREEN_WIDTH{$ENDIF};
end;

end.
