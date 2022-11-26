@shift /0
:QueryOff
@echo off
start AdaptersMonster.exe


title Monster Mods DHCP RESET KERNEL
color f0
mode 80,20
cls
SETLOCAL ENABLEDELAYEDEXPANSION
SET count=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic diskdrive get serialnumber`) DO (
  SET var!count!=%%F
  SET /a count=!count!+1
)
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid"') DO set "DFMT=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography" /v "MachineGuid"') DO set "LMAO=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "Hostname"') DO set "LOLL=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0007" /v "NetworkAddress"') DO set "YEAH=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e965-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid"') DO set "HIHI=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_CURRENT_USER\Monetone" /v "VolumeID"') DO set "VOLI=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductID"') DO set "PROD=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards\3" /v "ServiceName"') DO set "NETG=%%B"

ENDLOCAL
 ECHO.
 ECHO.
echo off
echo RENEW DHCP
 ECHO.
echo off
: Disable Static IP/Enable DHCP    Remove DNS     Enable NICs
for /f "skip=2 tokens=3*" %%i in ('netsh interface show interface') do (
netsh int ip set address "%%j" dhcp 
netsh int ip set dns "%%j" dhcp 
netsh interface set interface name="%%j" admin=enabled 
)
 ECHO.
 ECHO.
 ECHO.
echo Flush DNS: 
echo off
ipconfig /flushdns 
 ECHO.
 ECHO.
 ECHO.
echo Clear ARP:
echo off
netsh interface ip delete arpcache
 ECHO.
 ECHO.
 ECHO.
echo Clear SSL state:
echo off
certutil -URLCache * delete 
 ECHO.
 ECHO.
 ECHO.
echo Reset TCP/IP:
echo off
netsh int ip reset 
netsh int ipv4 reset 
netsh int ipv6 reset 
echo Clear Winsock:
echo off
netsh winsock reset 
 ECHO.
echo Reset Firewall Settings
echo off 
netsh advfirewall reset 
echo Generating random numbers...
rem VolumeID
Setlocal EnableDelayedExpansion
Set _RNDLength=4
Set _Alphanumeric=ABCDEF0123456789
Set _Str=%_Alphanumeric%987654321
:_LenLoop
IF NOT "%_Str:~18%"=="" SET _Str=%_Str:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%_Str:~9,1%
SET /A _Len=_Len+_tmp
Set _count=0
SET _RndAlphaNum=
:_loop
Set /a _count+=1
SET _RND=%Random%
Set /A _RND=_RND%%%_Len%
SET _RndAlphaNum=!_RndAlphaNum!!_Alphanumeric:~%_RND%,1!
If !_count! lss %_RNDLength% goto _loop
@echo Random string is !_RndAlphaNum!
 
Setlocal EnableDelayedExpansion
Set _RNDLength=4
Set _Alphanumeric=ABCDEF0123456789
Set _Str=%_Alphanumeric%987654321
:_LenLoop
IF NOT "%_Str:~18%"=="" SET _Str=%_Str:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%_Str:~9,1%
SET /A _Len=_Len+_tmp
Set _count=0
SET _RndAlphaNum2=
:_loop
Set /a _count2+=1
SET _RND=%Random%
Set /A _RND=_RND%%%_Len%
SET _RndAlphaNum2=!_RndAlphaNum2!!_Alphanumeric:~%_RND%,1!
If !_count2! lss %_RNDLength% goto _loop
@echo Random string is !_RndAlphaNum2!

set I=4
set N=16
set CHAR=0 1 2 3 4 5 6 7 8 9 A B C D E F

set I=4
:LOOP1
set /a R=1+%N%*%random%/32768
for /f "tokens=%R%" %%q in ("%CHAR%") do (set Hex0=%%q%Hex0%)
Set /a I-=1
If %I% GTR 0 goto LOOP1

set I=4
:LOOP2
set /a R=1+%N%*%random%/32768
for /f "tokens=%R%" %%q in ("%CHAR%") do (set Hex1=%%q%Hex1%)
Set /a I-=1
If %I% GTR 0 goto LOOP2

set I=8
:LOOP3
set /a R=1+%N%*%random%/32768
for /f "tokens=%R%" %%q in ("%CHAR%") do (set Hex8=%%q%Hex8%)
Set /a I-=1
If %I% GTR 0 goto LOOP3

set I=10
:LOOP4
set /a R=1+%N%*%random%/32768
for /f "tokens=%R%" %%q in ("%CHAR%") do (set Hex10=%%q%Hex10%)
Set /a I-=1
If %I% GTR 0 goto LOOP4
goto TextFiles

set min3=10
set max3=99
set /a m1=%random%%%(max3-min3+1)+min3

set min3=10
set max3=99
set /a m2=%random%%%(max3-min3+1)+min3

set min3=10
set max3=99
set /a m3=%random%%%(max3-min3+1)+min3

set min4=10000
set max4=32000
set /a m4=%random%%%(max4-min4+1)+min4

:TextFiles
rem MACadress
SET "TextFile=mac.txt"
FOR /f %%a IN ('type "%textfile%"^|find /c /v ""') DO SET /a numlines=%%a
SET /A RandomLine=(%RANDOM% %% %NumLines%)
IF "%RandomLine%"=="0" (SET "RandomLine=") ELSE (SET "RandomLine=skip=%randomline%")
FOR /F "usebackq tokens=* %RandomLine% delims=" %%A IN (`TYPE %TextFile%`) DO (
    @echo %%A
 set mac=%%A
    GOTO NextFile1
)
:NextFile1
rem Hostname change
SET "TextFile=host.txt"
FOR /f %%a IN ('type "%textfile%"^|find /c /v ""') DO SET /a numlines=%%a
SET /A RandomLine=(%RANDOM% %% %NumLines%)
IF "%RandomLine%"=="0" (SET "RandomLine=") ELSE (SET "RandomLine=skip=%randomline%")
FOR /F "usebackq tokens=* %RandomLine% delims=" %%A IN (`TYPE %TextFile%`) DO (
    @echo %%A
 set hostname=%%A
    GOTO NextFile2
)
:NextFile2
rem Username change
SET "TextFile=C:\antiOS\host.txt"
FOR /f %%a IN ('type "%textfile%"^|find /c /v ""') DO SET /a numlines=%%a
SET /A RandomLine=(%RANDOM% %% %NumLines%)
IF "%RandomLine%"=="0" (SET "RandomLine=") ELSE (SET "RandomLine=skip=%randomline%")
FOR /F "usebackq tokens=* %RandomLine% delims=" %%A IN (`TYPE %TextFile%`) DO (
    @echo %%A
 set user=%%A
    GOTO ExecuteVolumeID
)

:ExecuteVolumeID
rem VolumeID change
Volumeid64.exe C: !_RndAlphaNum!0-!_RndAlphaNum2!
REG ADD "HKEY_CURRENT_USER\Monetone" /v VolumeID /t REG_SZ /d !_RndAlphaNum!0-!_RndAlphaNum2! /f
goto ExecuteGuid

:ExecuteGuid
echo Changing hardware...
PowerShell.exe -nologo -ExecutionPolicy RemoteSigned -File "%~dp0hwid.ps1"
rem Hostname/username change
REG ADD   "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "NV Hostname" /t REG_SZ /d %hostname% /f
REG ADD   "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v Hostname /t REG_SZ /d %hostname% /f
REG ADD   "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v ComputerName /t REG_SZ /d %hostname% /f
REG ADD   "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName /t REG_SZ /d %hostname% /f
REG DELETE   "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOwner /f
REG ADD   "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOwner /t REG_SZ /d %user% /f
echo Disabling network...
netsh interface set interface name="Wi-Fi" admin=disabled
rem MAC address change
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0007" /v	NetworkAddress		    /d %mac%%m1%%m2%%m3% /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v	NetworkAddress		    /d %mac%%m1%%m2%%m3% /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v	NetworkAddress		    /d %mac%%m1%%m2%%m3% /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v	NetworkAddress		    /d %mac%%m1%%m2%%m3% /f
echo Enabling network...
netsh interface set interface name="Wi-Fi" admin=enabled
rem Device GUID
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e965-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v PropertyGuid /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-6a%Hex10%} /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e967-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v PropertyGuid /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-6a%Hex10%} /f
rem REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\DeviceDesc" /v PropertyGuid /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-67%Hex10%} /f
rem REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\Driver" /v PropertyGuid /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-67%Hex10%} /f
rem REG ADD "HKEY_LOCAL_MACH
goto ExecutePID

:ExecutePID
Changing product id...
rem Windows PID change
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductId /t REG_SZ /d 00331-10401-00001-A!_RndAlphaNum2! /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId /t REG_BINARY  /d A40000000%i3%00003030%i4%312D3836382D303030303030372D383535353700AA0000005831352D333%i5%3000000000000000C3AABF%Hex0%BA18B8878E89D%Hex0%000000000000396CC459B%i5%D0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000%Hex1%6736 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId4 /t REG_BINARY  /d %Hex8%0400000030003000330037%Hex1%002D00300030003100370030002D003800360038002D003000300030003000300030002D00300033002D0031003000330033002D0037003600300031002E0030003000300030002D003200360035003200300031003700000000000000000000000000000000000000000000000000000000000000000062003900320065003%Hex8%80030002D0062003900%i3%035002D0034003800320031002D0039006300390034002D003100340030006600360033003200660036003300310032000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000%i4%6F0066006500730073006%Hex1%F006E0061006C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C3AABFA65BBA18B8%i4%89D24ED80000C61%Hex8%D0BEDFD25E%Hex1%45B89FFF45564B8%i4%4E87CB968EC7F4D18F6E5066261A0B704B9D2739558B7E97DF882AB087AB0D8A314BA9BB1E06029EA28D5800310035002D0033003900310037003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000056006F006C0075006D006%i4%A00470056004C004B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000056006F006C007%i4%D0065000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 /f
goto SerialNumber

:SerialNumber
echo Changing serialnumber...
mapper.exe spoofer.sys
mapper.exe sw.sys spoofer.sys
mapper.exe sw.sys wd.sys
mapper.exe VSTXRAID.SYS print1337.sys

FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid"') DO set "DFMT=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography" /v "MachineGuid"') DO set "LMAO=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "Hostname"') DO set "LOLL=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0007" /v "NetworkAddress"') DO set "YEAH=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e965-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid"') DO set "HIHI=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_CURRENT_USER\Monetone" /v "VolumeID"') DO set "VOLI=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductID"') DO set "PROD=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards\3" /v "ServiceName"') DO set "NETG=%%B"



mapper.exe spoofer.sys
mapper.exe spoofer.sys


    setlocal enableextensions enabledelayedexpansion

taskkill /f /im epicgameslauncher.exe
taskkill /f /im FortniteClient-Win64-Shipping_EAC.exe
taskkill /f /im FortniteClient-Win64-Shipping.exe
taskkill /f /im FortniteClient-Win64-Shipping_BE.exe
taskkill /f /im FortniteLauncher.exe
taskkill /f /im EpicGamesLauncher.exe
taskkill /f /im FortniteClient-Win64-Shipping.exe
taskkill /f /im EpicGamesLauncher.exe

del "C:\Windows\TEMP\206F3FDC-B1A8-4FD6-BDB8-6CFE76122873",
del "C:\ProgramData\Microsoft\Windows\WER\Temp\WER95DF.tmp.mdmp",
del "C:\Windows.old\Users\All Users\Microsoft\Windows\WER\Temp\WER95DF.tmp.mdmp",
del "C:\Users\All Users\Microsoft\Windows\WER\Temp\WER95DF.tmp.mdmp",
del "C:\Windows\CbsTemp\30780525_1668355464",
del "C:\Windows\TEMP\6E04EF32-0387-48B1-B812-AC2BBA90A8D0",
del "C:\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Cookies",
del "C:\Users\%username%\AppData\Local\NVIDIA Corporation\GfeSDK\FORTNI~1.LOG",
del "C:\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\CMS\Files\9A71EB4A90946A4A0DCD9B7D82F48C55B49D0880\siphon-1024x512-4cc0ff3407053325e353c4aea55fb30316e6ecf6.jpg",
del "C:\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\CMS\Files\9A71EB4A90946A4A0DCD9B7D82F48C55B49D0880\Fortnite%2Ffortnite-game%2Ftournaments%2F11BR_Arena_ModeTiles_Squad_ModeTile-1024x512-c543a187ce733be5ee9f6d17bfb74fb1f2e15f4a.jpg",
del "C:\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\CMS\Files\9A71EB4A90946A4A0DCD9B7D82F48C55B49D0880\Fortnite%2Ffortnite-game%2Ftournaments%2F11BR_Arena_ModeTiles_Solo_ModeTile-1024x512-6cee09d7bcf82ce3f32ca7c77ca04948121ce617.jpg",
del "C:\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\V0100024.log",
del "C:\Users\All Users\Microsoft\Windows\WER\Temp\WER5CC2.tmp.xml",
del "C:\Windows.old\Users\All Users\Microsoft\Windows\WER\Temp\WER6D21.tmp.WERInternalMetadata.xml",
del "C:\Users\%username%\AppData\Local\Temp\ecache.bin",
del "C:\Users\%username%\AppData\Local\CrashDumps\BACKGR~2.DMP",
del "C:\Windows\prefetch\ATTRIB.EXE-58A07CAF.pf",
del "C:\Windows\prefetch\AgRobust.db",
del "C:\Users\%username%\AppData\Local\Microsoft\Feeds Cache",
del "C:\Windows\prefetch\CEPHTMLENGINE.EXE-E15640BA.pf",
del "C:\Windows\prefetch\CMD.EXE-0BD30981.pf",
del "C:\Windows\prefetch\CLIPUP.EXE-4C5C7B66.pf",
del "C:\Windows\prefetch\D3D9TEST.EXE-1B86F3FC.pf",
del "C:\Windows\prefetch\DISCORD.EXE-6BEBC47C.pf",
del "C:\Windows\prefetch\EPICGAMESLAUNCHER.EXE-FAB85FF0.pf",
del "C:\Windows\prefetch\EPICGAMESLAUNCHER.EXE-018FC121.pf",
del "C:\Windows\prefetch\GET-GRAPHICS-OFFSETS64.EXE-2BCB2EA4.pf",
del "C:\Windows\prefetch\GET-GRAPHICS-OFFSETS32.EXE-D4C865E3.pf",
del "C:\Windows\prefetch\OBS64.EXE-2B6570C7.pf",
del "C:\Windows\prefetch\OBS-FFMPEG-MUX.EXE-1C01271A.pf",
del "C:\Windows\prefetch\OBS-FFMPEG-MUX.EXE-1C01271A.pf",
cd C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\
cd D:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\
cd E:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\
cd F:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\
del /f /s /q "C:\Users\%username%\Desktop\test\*.*"
@del /s /f /a:h /a:a /q "C:\Users\All Users\NVIDIA\*.*"
@del /s /f /a:h /a:a /q "C:\ProgramData\NVIDIA\*.*"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\Logs\*.*"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Cache\*.*"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Local\FortniteGame\Saved\Config\CrashReportClient\*.*"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Local\FortniteGame\Saved\Demos\*.*"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\*.*"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Local\Google\Chrome\User Data\lockfile"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Local\Google\Chrome\User Data\BrowserMetrics\*.*"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Local\FortniteGame\Saved\Config\CrashReportClient\*.*"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Local\FortniteGame\Saved\Logs\*.*"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Local\Google\Chrome\User Data\Default\*.*"
@del /s /f /a:h /a:a /q "C:\Users\%username%\AppData\Local\NVIDIA Corporation\GfeSDK\*.*"
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\UnrealEngine\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\Logs\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Service Worker\CacheStorage\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Config\WindowsClient\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\LMS\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Demos\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Recovery\ntuser.sys\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\Public\Libraries\collection.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\MSOCache\{71230000-00E2-0000-1000-00000000}\Setup.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Feeds\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\NetworksCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\Rules\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\History\History.IE5\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Speech Graphics\Carnival\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\Content.IE5\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCookies\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.*" >nul 2>&1
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\UnrealEngine\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\Logs\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Service Worker\CacheStorage\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Config\WindowsClient\*.*
del /f /s /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\LMS\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud\*.*
del /f /s /q "%systemdrive%\Recovery\ntuser.sys\*.*
del /f /s /q "%systemdrive%\Users\Public\Libraries\collection.dat\*.*
del /f /s /q "%systemdrive%\MSOCache\{71230000-00E2-0000-1000-00000000}\Setup.dat\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Feeds\*.*"
del /f /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\NetworksCache\*.*
del /f /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\Rules\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\History\History.IE5\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Speech Graphics\Carnival\*.*
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\Content.IE5\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCookies\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.*
del /s /f /q %systemdrive%\Windows\Public\Libraries\*.*
del /s /f /q %systemdrive%\Windows\Prefetch\*.*
del /f /s /q %systemdrive%\Intel\*.*"
del /f /s /q %systemdrive%\\desktop.ini\*.*"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\UnrealEngine"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\Logs"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Service Worker\CacheStorage"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Config\WindowsClient"
rmdir /s /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\LMS"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud"
rmdir /s /q "%systemdrive%\Recovery\ntuser.sys"
rmdir /s /q "%systemdrive%\Users\Public\Libraries\collection.dat"
rmdir /s /q "%systemdrive%\MSOCache\{71230000-00E2-0000-1000-00000000}\Setup.dat"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Feeds"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\NetworksCache"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\Rules"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\History\History.IE5"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Speech Graphics\Carnival"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\Content.IE5"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCookies"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content"
rmdir /s /q "%systemdrive%\Windows\Public\Libraries"
rmdir /s /q "%systemdrive%\Windows\Prefetch"
rmdir /s /q "%systemdrive%\Intel"
rmdir /s /q "%systemdrive%\desktop.ini"
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.jfm\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files (x86)\Common Files\BattlEye\BEDaisy.sys\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Prefetch\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\Videos\Captures\desktop.ini\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AC\AppCache\YVV2MEXU\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AC\INetCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\DeviceMetadataCache\dmrc.idx\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\AC\INetCookies\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\AC\Microsoft\CryptnetUrlCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\AC\INetHistory\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\TempState\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\NVIDIA Corporation\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\DeviceMetadataCache\dmrc.idx\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Internet Explorer\CacheStorage\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\AMD\DxCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files (x86)\AMD\CNext\CCCSlim\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\NVIDIA Corporation\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\XboxLive\NSALCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\PlaceholderTileLogoFolder\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\LocalLow\Microsoft\CryptnetUrlCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\ServiceProfiles\LocalService\AppData\Local\FontCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\CloudStore\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Prefetch\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\LMS\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\EventStore.db-wal\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\perfc009.dat\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\perfh009.dat\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\INF\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\PerfStringBackup.TMP\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\PerfStringBackup.INI\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\ntuser.dat.LOG2\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\Settings\settings.dat.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\wbem\Performance\WmiApRpl.ini\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\TEMP\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\WDI\LogFiles\StartupInfo\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\State\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SysWOW64\Gms.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\spp\store\2.0\cache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\USOShared\Logs\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.ZuneVideo_8wekyb3d8bbwe\LocalState\Database\anonymous\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WER\ERC\*.*
del /s /q /f /a ".\desktop.ini" 
del /s /ah desktop.ini.
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\SettingSync\remotemetastore\v1\edb.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\SettingSync\metastore\edb.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\CBS\CBS.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Comms\Unistore\data\3\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Comms\Unistore\data\temp\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AppData\User\Default\Indexed DB\edb.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\SettingSync\metastore\meta.edb\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations\b05132b02959bc64.automaticDestinations-ms\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\appcompat\Programs\Amcache.hve\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\EasyAntiCheat\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup\EtwRTGraphicsPerfMonitorSession.etl\*.*
del /f /s /q "@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\*.*"
rmdir /s /q "@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame"  
@RD /S /Q "%localappdata%\FortniteGame"
@RD /S /Q "%localappdata%\EpicGamesLauncher"
@RD /S /Q "%localappdata%\UnrealEngine"
@RD /S /Q "%localappdata%\UnrealEngineLauncher"
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\MicrosoftEdge\User\Default\Recovery\Active\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!002\MicrosoftEdge\User\Default\AppCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\Autom\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\rescache\_merged\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\ntuser.dat.LOG1\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\ntuser.dat.LOG2\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\settings\Personal\logUploaderSettings_temp.ini\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\settings\Personal\logUploaderSettings.ini\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\sru\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\logs\Common\DeviceHealthSummaryConfiguration.ini\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\systemprofile\AppData\Local\Microsoft\XboxLive\AuthStateCache.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\BBI.LOG1\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\BBI.LOG2\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\DEFAULT.LOG2\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\MoSetup\UpdateAgent.log\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\PostRebootEventCache.V2\{323558A6-0300-4C3E-97A0-EDEDFEB96B00}.bin\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\TempState\CortanaUnifiedTileModelCache.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\SettingSync\metastore\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AC\INetCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AppData\Indexed DB\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup\EtwRTGraphicsPerfMonitorSession.etl\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\NVIDIA Corporation\GfeSDK\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\Logs\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Comms\Unistore\data\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Comms\UnistoreDB\USS.jtx\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Feeds\*.*" >nul 2>&1\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\AppRepository\Packages\Microsoft.XboxGameOverlay_1.42.4001.0_x64__8wekyb3d8bbwe\ActivationStore.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.SkypeApp_kzf8qxf38zg5c\LocalState\DiagOutputDir\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AppData\Indexed DB\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\ServiceState\EventLog\Data\lastalive0.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\UsrClass.dat.LOG2\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\UsrClass.dat.LOG1\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\Safety\edge\remote\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\WindowsUpdate.log\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\DataStore.edb\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\Logs\edb.log\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\Safety\edge\remote\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\Settings\settings.dat.LOG1\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\Logs\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\DEFAULT.LOG2\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\SYSTEM.LOG2\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\UsrClass.dat.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\logs\Common\DeviceHealthSummaryConfiguration.ini\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\appcompat\appraiser\AltData\Appraiser_Data.ini\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\System Volume Information\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\State\dosvcState.dat.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\appcompat\Programs\Amcache.hve.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\ClipSVC\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\CloudStore\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files\WindowsApps\Microsoft.LanguageExperiencePacken-GB_17763.9.22.0_neutral__8wekyb3d8bbwe\Windows\System32\driverstore\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\CBS\CBS.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\History\History.IE5\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\logs\Common\DeviceHealthSummaryConfiguration.ini\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\MoSetup\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AppData\Indexed DB\edb.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AC\INetCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files (x86)\Common Files\BattlEye\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\AMD\DxCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\NVIDIA Corporation\GfeSDK\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\AC\INetCookies\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\BBI.LOG2\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\UsrClass.dat.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\LogFiles\WMI\LwtNetLog.etl\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\ntuser.dat.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Notepad++\backup\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\temp\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\INF\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\Shared Files\*.*
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp"
rmdir /s /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\Shared Files"
rmdir /s /q "%systemdrive%\Windows\temp"
rmdir /s /q "%systemdrive%\Windows\Logs"
rmdir /s /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\Logs"
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\LocalCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\AC\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\microsoft.windowscommunicationsapps_8wekyb3d8bbwe\LocalState\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\BBI.LOG2\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\logs\*.*
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\TempState"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Roaming\EasyAntiCheat"
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files (x86)\EasyAntiCheat\EasyAntiCheat.sys\*.*
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\LocalCache"
rmdir /s /q "%systemdrive%\Program Files (x86)\Common Files\BattlEye"
@del /s /f /a:h /a:a /q "%systemdrive%\Users%username%\AppData\Local\Microsoft\OneDrive\settings\Personal\logUploaderSettings_temp.ini\*.*
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\settings\Personal"
rmdir /s /q "%systemdrive%\Windows\Logs"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud\9f92640e32874a76bb46156d11ae5fcf\"
rmdir /s /q "%systemdrive%\ProgramData\AMD\PPC\apprecord.csv\"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AppData\Indexed DB"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\EventStore.db-wal"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\DownloadedSettings"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\EventStore.db-wal"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\AW1C2HQS\"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\efe1e93f8bdd406aa6f0a42171c129a4"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\282fb338dbd04a7fbe725354ebc71bdf"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\efe1e93f8bdd406aa6f0a42171c129a4"
@del /s /f /q "%systemdrive%\Users\%username%\AppData\Local\AMD\DxCache\aa997381d1f6ca216f40b98a2d90cb44070036078e091a27.bin"
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup" >nul 2>&1
rmdir /s /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud\9f92640e32874a76bb46156d11ae5fcf\"
rmdir /s /q "%systemdrive%\ProgramData\AMD\PPC\apprecord.csv\"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AppData\Indexed DB"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\EventStore.db-wal"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\DownloadedSettings"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\EventStore.db-wal"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\AW1C2HQS\"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\efe1e93f8bdd406aa6f0a42171c129a4"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\282fb338dbd04a7fbe725354ebc71bdf"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\efe1e93f8bdd406aa6f0a42171c129a4"
@del /s /f /q "%systemdrive%\Users\Outbuilt\AppData\Local\AMD\DxCache\aa997381d1f6ca216f40b98a2d90cb44070036078e091a27.bin"
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup" >nul 2>&1
rmdir /s /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup"
rmdir /s /q "%systemdrive%\Windows\SoftwareDistribution\PostRebootEventCache.V2"
rmdir /s /q "%systemdrive%\Windows\INF"
reg delete "HKEY_LOCAL_MACHINE\Software\Epic Games" /f
reg delete "HKEY_CURRENT_USER\Software\Epic Games" /f
reg delete "HKEY_LOCAL_MACHINE\Software\Epic Games" /f
rd /q /s %systemdrive%\$Recycle.Bin
rd /q /s d:\$Recycle.Bin
rd /q /s e:\$Recycle.Bin
rd /q /s f:\$Recycle.Bin

@del /s /f /a:h /a:a /q "%systemdrive%\Program Files (x86)\Common Files\BattlEye\*.*
del /f /s /q "C:\Users\%username%\AppData\Local\FortniteGame\Saved\LMS\Manifest.sav\*.*"
del /f /s /q "C:\MSOCache\*.*"
del /f /s /q "C:\Users\Public\*.*"
del /f /s /q "C:\Recovery\*.*"
del /f /s /q "C:\Amd\*.*"
del /f /s /q "C:\Intel\*.*"
del /f /s /q "C:\Users\Public\*.*"
del /f /s /q "C:\MSOCache\*.*"
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud\*.*
del /f /s /q "%systemdrive%\Recovery\ntuser.sys\*.*
del /f /s /q "%systemdrive%\Users\Public\Libraries\collection.dat\*.*
del /f /s /q "%systemdrive%\MSOCache\{71230000-00E2-0000-1000-00000000}\Setup.dat\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Feeds\*.*"
del /f /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\NetworksCache\*.*
del /f /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\Rules\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\History\History.IE5\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Speech Graphics\Carnival\*.*
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\Content.IE5\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCookies\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.*
del /s /f /q %systemdrive%\Windows\Public\Libraries\*.*
del /s /f /q %systemdrive%\Windows\Prefetch\*.*
del /f /s /q %systemdrive%\Intel\*.*"
del /f /s /q %systemdrive%\\desktop.ini\*.*"
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\UnrealEngine\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\Logs\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Service Worker\CacheStorage\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Config\WindowsClient\*.*
del /f /s /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\LMS\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud\*.*
del /f /s /q "C:\Users\%username%\AppData\Local\Microsoft\Feeds\*.*"
del /f /s /q "C:\Users\%username%\AppData\Local\FortniteGame\*.*"
RD /s /q "C:\Users\%Username%\AppData\Local\BattlEye"
RD /s /q "C:\Users\%Username%\AppData\Local\CEF"
RD /s /q "C:\Users\%Username%\AppData\Local\ConnectedDevicesPlatform"
RD /s /q "C:\Users\%Username%\AppData\Local\Comms"
RD /s /q "C:\Users\%Username%\AppData\Local\UnrealEngine"
RD /s /q "C:\Users\%Username%\AppData\Local\UnrealEngineLauncher"
RD /s /q "C:\Users\%Username%\AppData\Local\FortniteGame"
RD /s /q "C:\Users\%Username%\AppData\Local\Microsoft\Feeds"
RD /s /q "C:\Users\%Username%\AppData\Local\Publishers"
RD /s /q "C:\Users\%Username%\AppData\Local\Programs\Common"
RD /s /q "C:\Users\%Username%\AppData\Roaming\EasyAntiCheat"
rmdir /s /q "C:\Users\%username%\AppData\Local\FortniteGame" 
rmdir /s /q "C:\Users\Public\Libraries" 
rmdir /s /q "C:\MSOCache" 
rmdir /s /q "C:\Users\Public"
rmdir /s /q "C:\Intel"
rmdir /s /q "C:\Recovery"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\UnrealEngine"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\Logs"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Service Worker\CacheStorage"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Config\WindowsClient"
rmdir /s /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\LMS"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud"
rmdir /s /q "%systemdrive%\Recovery\ntuser.sys"
rmdir /s /q "%systemdrive%\Users\Public\Libraries\collection.dat"
rmdir /s /q "%systemdrive%\MSOCache\{71230000-00E2-0000-1000-00000000}\Setup.dat"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Feeds"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\NetworksCache"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\Rules"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\History\History.IE5"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Speech Graphics\Carnival"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\Content.IE5"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCookies"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content"
rmdir /s /q "%systemdrive%\Windows\Public\Libraries"
rmdir /s /q "%systemdrive%\Windows\Prefetch"
rmdir /s /q "%systemdrive%\Intel"
rmdir /s /q "%systemdrive%\desktop.ini"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp"
rmdir /s /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\Shared Files"
rmdir /s /q "%systemdrive%\Windows\temp"
rmdir /s /q "%systemdrive%\Windows\Logs"
rmdir /s /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\Logs"
echo 1
del "C:\Windows\TEMP\206F3FDC-B1A8-4FD6-BDB8-6CFE76122873",
del "C:\ProgramData\Microsoft\Windows\WER\Temp\WER95DF.tmp.mdmp",
del "C:\Windows.old\Users\All Users\Microsoft\Windows\WER\Temp\WER95DF.tmp.mdmp",
del "C:\Users\All Users\Microsoft\Windows\WER\Temp\WER95DF.tmp.mdmp",
del "C:\Windows\CbsTemp\30780525_1668355464",
del "C:\Windows\TEMP\6E04EF32-0387-48B1-B812-AC2BBA90A8D0",
del "C:\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Cookies",
del "C:\Users\%username%\AppData\Local\NVIDIA Corporation\GfeSDK\FORTNI~1.LOG",
del "C:\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\CMS\Files\9A71EB4A90946A4A0DCD9B7D82F48C55B49D0880\siphon-1024x512-4cc0ff3407053325e353c4aea55fb30316e6ecf6.jpg",
del "C:\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\CMS\Files\9A71EB4A90946A4A0DCD9B7D82F48C55B49D0880\Fortnite%2Ffortnite-game%2Ftournaments%2F11BR_Arena_ModeTiles_Squad_ModeTile-1024x512-c543a187ce733be5ee9f6d17bfb74fb1f2e15f4a.jpg",
del "C:\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\CMS\Files\9A71EB4A90946A4A0DCD9B7D82F48C55B49D0880\Fortnite%2Ffortnite-game%2Ftournaments%2F11BR_Arena_ModeTiles_Solo_ModeTile-1024x512-6cee09d7bcf82ce3f32ca7c77ca04948121ce617.jpg",
del "C:\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\V0100024.log",
del "C:\Users\All Users\Microsoft\Windows\WER\Temp\WER5CC2.tmp.xml",
del "C:\Windows.old\Users\All Users\Microsoft\Windows\WER\Temp\WER6D21.tmp.WERInternalMetadata.xml",
del "C:\Users\%username%\AppData\Local\Temp\ecache.bin",
del "C:\Users\%username%\AppData\Local\CrashDumps\BACKGR~2.DMP",
del "C:\Windows\prefetch\ATTRIB.EXE-58A07CAF.pf",
del "C:\Windows\prefetch\AgRobust.db",
del "C:\Users\%username%\AppData\Local\Microsoft\Feeds Cache",
del "C:\Windows\prefetch\CEPHTMLENGINE.EXE-E15640BA.pf",
del "C:\Windows\prefetch\CMD.EXE-0BD30981.pf",
del "C:\Windows\prefetch\CLIPUP.EXE-4C5C7B66.pf",
del "C:\Windows\prefetch\D3D9TEST.EXE-1B86F3FC.pf",
del "C:\Windows\prefetch\DISCORD.EXE-6BEBC47C.pf",
del "C:\Windows\prefetch\EPICGAMESLAUNCHER.EXE-FAB85FF0.pf",
del "C:\Windows\prefetch\EPICGAMESLAUNCHER.EXE-018FC121.pf",
del "C:\Windows\prefetch\GET-GRAPHICS-OFFSETS64.EXE-2BCB2EA4.pf",
del "C:\Windows\prefetch\GET-GRAPHICS-OFFSETS32.EXE-D4C865E3.pf",
del "C:\Windows\prefetch\OBS64.EXE-2B6570C7.pf",
del "C:\Windows\prefetch\OBS-FFMPEG-MUX.EXE-1C01271A.pf",
del "C:\Windows\prefetch\OBS-FFMPEG-MUX.EXE-1C01271A.pf",
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BaseBoardManufacturer /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BaseBoardProduct /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BaseBoardVersion /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BIOSVersion /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemFamily /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemManufacturer /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemProductName /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemSKU /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemVersion /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemProductName /t REG_SZ /d opensource-%random% /f



@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.jfm\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files (x86)\Common Files\BattlEye\BEDaisy.sys\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Prefetch\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\Videos\Captures\desktop.ini\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AC\AppCache\YVV2MEXU\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AC\INetCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\DeviceMetadataCache\dmrc.idx\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\AC\INetCookies\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\AC\Microsoft\CryptnetUrlCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\AC\INetHistory\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\TempState\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\NVIDIA Corporation\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\DeviceMetadataCache\dmrc.idx\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Internet Explorer\CacheStorage\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\AMD\DxCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files (x86)\AMD\CNext\CCCSlim\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\NVIDIA Corporation\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\XboxLive\NSALCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\PlaceholderTileLogoFolder\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\LocalLow\Microsoft\CryptnetUrlCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\ServiceProfiles\LocalService\AppData\Local\FontCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\CloudStore\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Prefetch\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\LMS\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\EventStore.db-wal\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\perfc009.dat\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\perfh009.dat\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\INF\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\PerfStringBackup.TMP\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\PerfStringBackup.INI\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\ntuser.dat.LOG2\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\Settings\settings.dat.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\wbem\Performance\WmiApRpl.ini\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\TEMP\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\WDI\LogFiles\StartupInfo\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\State\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SysWOW64\Gms.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\spp\store\2.0\cache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\USOShared\Logs\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.ZuneVideo_8wekyb3d8bbwe\LocalState\Database\anonymous\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WER\ERC\*.*
del /s /q /f /a ".\desktop.ini" 
del /s /ah desktop.ini.
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\SettingSync\remotemetastore\v1\edb.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\SettingSync\metastore\edb.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\CBS\CBS.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Comms\Unistore\data\3\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Comms\Unistore\data\temp\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AppData\User\Default\Indexed DB\edb.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\SettingSync\metastore\meta.edb\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations\b05132b02959bc64.automaticDestinations-ms\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\appcompat\Programs\Amcache.hve\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\EasyAntiCheat\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup\EtwRTGraphicsPerfMonitorSession.etl\*.*
del /f /s /q "@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\*.*"
rmdir /s /q "@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame"  
@RD /S /Q "%localappdata%\FortniteGame"
@RD /S /Q "%localappdata%\EpicGamesLauncher"
@RD /S /Q "%localappdata%\UnrealEngine"
@RD /S /Q "%localappdata%\UnrealEngineLauncher"
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\MicrosoftEdge\User\Default\Recovery\Active\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!002\MicrosoftEdge\User\Default\AppCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\Autom\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\rescache\_merged\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\ntuser.dat.LOG1\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\ntuser.dat.LOG2\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\settings\Personal\logUploaderSettings_temp.ini\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\settings\Personal\logUploaderSettings.ini\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\sru\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\logs\Common\DeviceHealthSummaryConfiguration.ini\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\systemprofile\AppData\Local\Microsoft\XboxLive\AuthStateCache.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\BBI.LOG1\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\BBI.LOG2\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\DEFAULT.LOG2\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\MoSetup\UpdateAgent.log\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\PostRebootEventCache.V2\{323558A6-0300-4C3E-97A0-EDEDFEB96B00}.bin\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\TempState\CortanaUnifiedTileModelCache.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\SettingSync\metastore\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AC\INetCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AppData\Indexed DB\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup\EtwRTGraphicsPerfMonitorSession.etl\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\NVIDIA Corporation\GfeSDK\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\Logs\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Comms\Unistore\data\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Comms\UnistoreDB\USS.jtx\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Feeds\*.*" >nul 2>&1\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\AppRepository\Packages\Microsoft.XboxGameOverlay_1.42.4001.0_x64__8wekyb3d8bbwe\ActivationStore.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.SkypeApp_kzf8qxf38zg5c\LocalState\DiagOutputDir\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AppData\Indexed DB\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\ServiceState\EventLog\Data\lastalive0.dat\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\UsrClass.dat.LOG2\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\UsrClass.dat.LOG1\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\Safety\edge\remote\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\WindowsUpdate.log\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\DataStore.edb\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\Logs\edb.log\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\Safety\edge\remote\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\Settings\settings.dat.LOG1\*.*" >nul 2>&1
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\Logs\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\DEFAULT.LOG2\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\SYSTEM.LOG2\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\UsrClass.dat.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\logs\Common\DeviceHealthSummaryConfiguration.ini\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\appcompat\appraiser\AltData\Appraiser_Data.ini\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\System Volume Information\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\State\dosvcState.dat.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\appcompat\Programs\Amcache.hve.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\ClipSVC\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\CloudStore\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files\WindowsApps\Microsoft.LanguageExperiencePacken-GB_17763.9.22.0_neutral__8wekyb3d8bbwe\Windows\System32\driverstore\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\CBS\CBS.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\History\History.IE5\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\logs\Common\DeviceHealthSummaryConfiguration.ini\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\Logs\MoSetup\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AppData\Indexed DB\edb.log\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AC\INetCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files (x86)\Common Files\BattlEye\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\AMD\DxCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\NVIDIA Corporation\GfeSDK\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\AC\INetCookies\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\BBI.LOG2\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\UsrClass.dat.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\LogFiles\WMI\LwtNetLog.etl\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\ntuser.dat.LOG1\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Notepad++\backup\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\temp\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\INF\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\Shared Files\*.*
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp"
rmdir /s /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\Shared Files"
rmdir /s /q "%systemdrive%\Windows\temp"
rmdir /s /q "%systemdrive%\Windows\Logs"
rmdir /s /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\Logs"
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\LocalCache\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\AC\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Packages\microsoft.windowscommunicationsapps_8wekyb3d8bbwe\LocalState\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\config\BBI.LOG2\*.*
@del /s /f /a:h /a:a /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\logs\*.*
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\TempState"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Roaming\EasyAntiCheat"
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files (x86)\EasyAntiCheat\EasyAntiCheat.sys\*.*
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.XboxGamingOverlay_8wekyb3d8bbwe\LocalCache"
rmdir /s /q "%systemdrive%\Program Files (x86)\Common Files\BattlEye"
@del /s /f /a:h /a:a /q "%systemdrive%\Users%username%\AppData\Local\Microsoft\OneDrive\settings\Personal\logUploaderSettings_temp.ini\*.*
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\OneDrive\settings\Personal"
rmdir /s /q "%systemdrive%\Windows\Logs"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud\9f92640e32874a76bb46156d11ae5fcf\"
rmdir /s /q "%systemdrive%\ProgramData\AMD\PPC\apprecord.csv\"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AppData\Indexed DB"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\EventStore.db-wal"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\DownloadedSettings"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\EventStore.db-wal"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\AW1C2HQS\"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\efe1e93f8bdd406aa6f0a42171c129a4"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\282fb338dbd04a7fbe725354ebc71bdf"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\efe1e93f8bdd406aa6f0a42171c129a4"
@del /s /f /q "%systemdrive%\Users\%username%\AppData\Local\AMD\DxCache\aa997381d1f6ca216f40b98a2d90cb44070036078e091a27.bin"
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup" >nul 2>&1
rmdir /s /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud\9f92640e32874a76bb46156d11ae5fcf\"
rmdir /s /q "%systemdrive%\ProgramData\AMD\PPC\apprecord.csv\"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\AppData\Indexed DB"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\EventStore.db-wal"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\DownloadedSettings"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Diagnosis\EventStore.db-wal"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\AW1C2HQS\"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\efe1e93f8bdd406aa6f0a42171c129a4"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\282fb338dbd04a7fbe725354ebc71bdf"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Temp\VSRemoteControl\efe1e93f8bdd406aa6f0a42171c129a4"
@del /s /f /q "%systemdrive%\Users\Outbuilt\AppData\Local\AMD\DxCache\aa997381d1f6ca216f40b98a2d90cb44070036078e091a27.bin"
@del /s /f /a:h /a:a /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup" >nul 2>&1
rmdir /s /q "%systemdrive%\Windows\System32\LogFiles\WMI\RtBackup"
rmdir /s /q "%systemdrive%\Windows\SoftwareDistribution\PostRebootEventCache.V2"
rmdir /s /q "%systemdrive%\Windows\INF"
reg delete "HKEY_LOCAL_MACHINE\Software\Epic Games" /f
reg delete "HKEY_CURRENT_USER\Software\Epic Games" /f
reg delete "HKEY_LOCAL_MACHINE\Software\Epic Games" /f
rd /q /s %systemdrive%\$Recycle.Bin
rd /q /s d:\$Recycle.Bin
rd /q /s e:\$Recycle.Bin
rd /q /s f:\$Recycle.Bin
@del /s /f /a:h /a:a /q "%systemdrive%\Program Files (x86)\Common Files\BattlEye\*.*
del /f /s /q "C:\Users\%username%\AppData\Local\FortniteGame\Saved\LMS\Manifest.sav\*.*"
del /f /s /q "C:\MSOCache\*.*"
del /f /s /q "C:\Users\Public\*.*"
del /f /s /q "C:\Recovery\*.*"
del /f /s /q "C:\Amd\*.*"
del /f /s /q "C:\Intel\*.*"
del /f /s /q "C:\Users\Public\*.*"
del /f /s /q "C:\MSOCache\*.*"
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud\*.*
del /f /s /q "%systemdrive%\Recovery\ntuser.sys\*.*
del /f /s /q "%systemdrive%\Users\Public\Libraries\collection.dat\*.*
del /f /s /q "%systemdrive%\MSOCache\{71230000-00E2-0000-1000-00000000}\Setup.dat\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Feeds\*.*"
del /f /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\NetworksCache\*.*
del /f /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\Rules\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\History\History.IE5\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\Speech Graphics\Carnival\*.*
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\Content.IE5\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCookies\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*.*
del /f /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.*
del /s /f /q %systemdrive%\Windows\Public\Libraries\*.*
del /s /f /q %systemdrive%\Windows\Prefetch\*.*
del /f /s /q %systemdrive%\Intel\*.*"
del /f /s /q %systemdrive%\\desktop.ini\*.*"
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\UnrealEngine\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\Logs\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Service Worker\CacheStorage\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Config\WindowsClient\*.*
del /f /s /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\LMS\*.*
del /f /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud\*.*
del /f /s /q "C:\Users\%username%\AppData\Local\Microsoft\Feeds\*.*"
del /f /s /q "C:\Users\%username%\AppData\Local\FortniteGame\*.*"
RD /s /q "C:\Users\%Username%\AppData\Local\BattlEye"
RD /s /q "C:\Users\%Username%\AppData\Local\CEF"
RD /s /q "C:\Users\%Username%\AppData\Local\ConnectedDevicesPlatform"
RD /s /q "C:\Users\%Username%\AppData\Local\Comms"
RD /s /q "C:\Users\%Username%\AppData\Local\UnrealEngine"
RD /s /q "C:\Users\%Username%\AppData\Local\UnrealEngineLauncher"
RD /s /q "C:\Users\%Username%\AppData\Local\FortniteGame"
RD /s /q "C:\Users\%Username%\AppData\Local\Microsoft\Feeds"
RD /s /q "C:\Users\%Username%\AppData\Local\Publishers"
RD /s /q "C:\Users\%Username%\AppData\Local\Programs\Common"
RD /s /q "C:\Users\%Username%\AppData\Roaming\EasyAntiCheat"
rmdir /s /q "C:\Users\%username%\AppData\Local\FortniteGame" 
rmdir /s /q "C:\Users\Public\Libraries" 
rmdir /s /q "C:\MSOCache" 
rmdir /s /q "C:\Users\Public"
rmdir /s /q "C:\Intel"
rmdir /s /q "C:\Recovery"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\UnrealEngine"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\Logs"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Service Worker\CacheStorage"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\GPUCache"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Config\WindowsClient"
rmdir /s /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\LMS"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\FortniteGame\Saved\Cloud"
rmdir /s /q "%systemdrive%\Recovery\ntuser.sys"
rmdir /s /q "%systemdrive%\Users\Public\Libraries\collection.dat"
rmdir /s /q "%systemdrive%\MSOCache\{71230000-00E2-0000-1000-00000000}\Setup.dat"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\WebCache"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Feeds"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\NetworksCache"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\DataMart\PaidWiFi\Rules"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Microsoft\Windows\History\History.IE5"
rmdir /s /q "%systemdrive%\Users\%username%\AppData\Local\Speech Graphics\Carnival"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\Content.IE5"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\INetCookies"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData"
rmdir /s /q "%systemdrive%\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content"
rmdir /s /q "%systemdrive%\Windows\Public\Libraries"
rmdir /s /q "%systemdrive%\Windows\Prefetch"
rmdir /s /q "%systemdrive%\Intel"
rmdir /s /q "%systemdrive%\desktop.ini"
rmdir /s /q "%systemdrive%\ProgramData\Microsoft\Windows\WER\Temp"
rmdir /s /q "%systemdrive%\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\Shared Files"
rmdir /s /q "%systemdrive%\Windows\temp"
rmdir /s /q "%systemdrive%\Windows\Logs"
rmdir /s /q "%systemdrive%\Windows\SoftwareDistribution\DataStore\Logs"
echo 1
del "C:\Windows\TEMP\206F3FDC-B1A8-4FD6-BDB8-6CFE76122873",
del "C:\ProgramData\Microsoft\Windows\WER\Temp\WER95DF.tmp.mdmp",
del "C:\Windows.old\Users\All Users\Microsoft\Windows\WER\Temp\WER95DF.tmp.mdmp",
del "C:\Users\All Users\Microsoft\Windows\WER\Temp\WER95DF.tmp.mdmp",
del "C:\Windows\CbsTemp\30780525_1668355464",
del "C:\Windows\TEMP\6E04EF32-0387-48B1-B812-AC2BBA90A8D0",
del "C:\Users\%username%\AppData\Local\EpicGamesLauncher\Saved\webcache\Cookies",
del "C:\Users\%username%\AppData\Local\NVIDIA Corporation\GfeSDK\FORTNI~1.LOG",
del "C:\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\CMS\Files\9A71EB4A90946A4A0DCD9B7D82F48C55B49D0880\siphon-1024x512-4cc0ff3407053325e353c4aea55fb30316e6ecf6.jpg",
del "C:\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\CMS\Files\9A71EB4A90946A4A0DCD9B7D82F48C55B49D0880\Fortnite%2Ffortnite-game%2Ftournaments%2F11BR_Arena_ModeTiles_Squad_ModeTile-1024x512-c543a187ce733be5ee9f6d17bfb74fb1f2e15f4a.jpg",
del "C:\Program Files\Epic Games\Fortnite\FortniteGame\PersistentDownloadDir\CMS\Files\9A71EB4A90946A4A0DCD9B7D82F48C55B49D0880\Fortnite%2Ffortnite-game%2Ftournaments%2F11BR_Arena_ModeTiles_Solo_ModeTile-1024x512-6cee09d7bcf82ce3f32ca7c77ca04948121ce617.jpg",
del "C:\Users\%username%\AppData\Local\Microsoft\Windows\WebCache\V0100024.log",
del "C:\Users\All Users\Microsoft\Windows\WER\Temp\WER5CC2.tmp.xml",
del "C:\Windows.old\Users\All Users\Microsoft\Windows\WER\Temp\WER6D21.tmp.WERInternalMetadata.xml",
del "C:\Users\%username%\AppData\Local\Temp\ecache.bin",
del "C:\Users\%username%\AppData\Local\CrashDumps\BACKGR~2.DMP",
del "C:\Windows\prefetch\ATTRIB.EXE-58A07CAF.pf",
del "C:\Windows\prefetch\AgRobust.db",
del "C:\Users\%username%\AppData\Local\Microsoft\Feeds Cache",
del "C:\Windows\prefetch\CEPHTMLENGINE.EXE-E15640BA.pf",
del "C:\Windows\prefetch\CMD.EXE-0BD30981.pf",
del "C:\Windows\prefetch\CLIPUP.EXE-4C5C7B66.pf",
del "C:\Windows\prefetch\D3D9TEST.EXE-1B86F3FC.pf",
del "C:\Windows\prefetch\DISCORD.EXE-6BEBC47C.pf",
del "C:\Windows\prefetch\EPICGAMESLAUNCHER.EXE-FAB85FF0.pf",
del "C:\Windows\prefetch\EPICGAMESLAUNCHER.EXE-018FC121.pf",
del "C:\Windows\prefetch\GET-GRAPHICS-OFFSETS64.EXE-2BCB2EA4.pf",
del "C:\Windows\prefetch\GET-GRAPHICS-OFFSETS32.EXE-D4C865E3.pf",
del "C:\Windows\prefetch\OBS64.EXE-2B6570C7.pf",
del "C:\Windows\prefetch\OBS-FFMPEG-MUX.EXE-1C01271A.pf",
del "C:\Windows\prefetch\OBS-FFMPEG-MUX.EXE-1C01271A.pf",
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BaseBoardManufacturer /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BaseBoardProduct /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BaseBoardVersion /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BIOSVersion /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemFamily /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemManufacturer /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemProductName /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemSKU /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemVersion /t REG_SZ /d opensource-%random% /f
REG ADD HKLM\HARDWARE\DESCRIPTION\System\BIOS /v SystemProductName /t REG_SZ /d opensource-%random% /f
goto ResetSystemHWID
:ResetSystemHWID
color c
mode 45,9
echo.
echo  -------------AVISO IMPORTANTE--------------
echo.
echo      SEU PC IRA RENICIAR DESEJA CONTINUAR ?
echo.
echo            [S] SIM           [N] NAO
echo.            
echo            [I] INICIAR ADAPTADOR
echo  -------------------------------------------
set /p Comando=:

if "%Comando%" equ "S" (goto:exec)

if "%Comando%" equ "N"  (exit)

if "%Comando%" equ "s" (goto:exec)

if "%Comando%" equ "n"  (exit)

if "%Comando%" equ "i"  (start AdaptersMonster.exe)

if "%Comando%" equ "I"  (start AdaptersMonster.exe)


goto ResetSystemHWID
:exec
cmd /k "swind2 gdrv.sys Kernel.sys"
goto ResetSystemHWID
:errorlevel
if %errorlevel% EQU 1 (
    cls
    echo Failed. 
    timeout /t 3 >nul 2>nul
pause
    exit /b
) else (
