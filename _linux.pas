unit _linux;

interface

uses
  classes,
  sysUtils;

const
  LINUX_DIRECTORY_SEPARATOR='/';
  LINUX_DRIVE_SEPARATOR='';
  LINUX_EOL=#10;

function LINUX_OS:string;
function LINUX_KERNEL_VERSION:string;
function LINUX_KERNEL_RELEASE:string;
function LINUX_OS_VERSION:string;
function LINUX_DISTRO:string;
function LINUX_DISTRO_NAME:string;
function LINUX_DISTRO_ID:string;
function LINUX_DISTRO_VERSION:string;
function LINUX_FULLY_QUALIFIED_VERSION:string;
function LINUX_USER:string;
function LINUX_HOSTNAME:string;
function LINUX_SCREEN_HEIGHT:longint;
function LINUX_SCREEN_WIDTH:longint;

implementation

uses
  process;

function LINUX_OS:string;
begin
  runCommand('sh',['-c','uname -o'],result);
  result:=trim(result);
end;

function LINUX_KERNEL_VERSION:string;
begin
  runCommand('sh',['-c','uname --kernel-version'],result);
  result:=trim(result);
end;

function LINUX_KERNEL_RELEASE:string;
begin
  runCommand('sh',['-c','uname --kernel-release'],result);
  result:=trim(result);
end;

function LINUX_OS_VERSION:string;
begin
  runCommand('sh',['-c','uname --all'],result);
  result:=trim(result);
end;

function LINUX_DISTRO:string;
begin
  runCommand('bash',['-c','source /etc/os-release && echo $PRETTY_NAME'],result);
  result:=trim(result);
end;

function LINUX_DISTRO_NAME:string;
begin
  runCommand('bash',['-c','source /etc/os-release && echo $NAME'],result);
  result:=trim(result);
end;

function LINUX_DISTRO_ID:string;
begin
  runCommand('bash',['-c','source /etc/os-release && echo $ID'],result);
  result:=trim(result);
end;

function LINUX_DISTRO_VERSION:string;
begin
  runCommand('bash',['-c','source /etc/os-release && echo $VERSION_ID'],result);
  result:=trim(result);
end;

function LINUX_FULLY_QUALIFIED_VERSION:string;
begin
  result:=LINUX_DISTRO+' (Linux '+LINUX_KERNEL_RELEASE+') ('+LINUX_KERNEL_VERSION+')';
end;

function LINUX_USER:string;
begin
  result:=getEnvironmentVariable('USERNAME');
  if result='' then result:=getEnvironmentVariable('USER');
end;

function LINUX_HOSTNAME:string;
begin
  runCommand('bash',['-c','cat /etc/hostname'],result);
  result:=trim(result);
end;

function LINUX_SCREEN_WIDTH:longint;
var
  strcmdresult:string;
begin
  runCommand('bash',['-c','xdpyinfo | awk ''/dimensions/{print $2}'' | cut -d ''x'' -f1'],strcmdresult);
  result:=strToInt(trim(strcmdresult));
end;

function LINUX_SCREEN_HEIGHT:longint;
var
  strcmdresult:string;
begin
  runCommand('bash',['-c','xdpyinfo | awk ''/dimensions/{print $2}'' | cut -d ''x'' -f2'],strcmdresult);
  result:=strToInt(trim(strcmdresult));
end;

end.
