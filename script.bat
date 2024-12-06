@echo off
chcp 65001 >nul
color 0d
mode con: cols=160 lines=50
cls

goto kx7

:kx7
cls
color 0d
echo "           ____    ____                           ______       ______    ____      ____      ______  _____   ______   ";
echo "          |    |  |    | _____      _____     ___|\     \  ___|\     \  |    |    |    | ___|\     \|\    \ |\     \  ";
echo "          |    |  |    | \    \    /    /    |    |\     \|     \     \ |    |    |    ||     \     \\\    \| \     \ ";
echo "          |    | /    //  \    \  /    /     |    |/____/||     ,_____/||    |    |    ||     ,_____/|\|    \  \     |";
echo "          |    |/ _ _//    \____\/____/   ___|    \|   | ||     \--'\_|/|    |    |    ||     \--'\_|/ |     \  |    |";
echo "          |    |\    \'    /    /\    \  |    \    \___|/ |     /___/|  |    |    |    ||     /___/|   |      \ |    |";
echo "          |    | \    \   /    /  \    \ |    |\     \    |     \____|\ |\    \  /    /||     \____|\  |    |\ \|    |";
echo "          |____|  \____\ /____/ /\ \____\|\ ___\|_____|   |____ '     /|| \ ___\/___ / ||____ '     /| |____||\_____/|";
echo "          |    |   |    ||    |/  \|    || |    |     |   |    /_____/ | \ |   ||   | / |    /_____/ | |    |/ \|   ||";
echo "          |____|   |____||____|    |____| \|____|_____|   |____|     | /  \|___||___|/  |____|     | / |____|   |___|/";
echo "            \(       )/    \(        )/      \(    )/       \( |_____|/     \(    )/      \( |_____|/    \(       )/  ";
echo "             '       '      '        '        '    '         '    )/         '    '        '    )/        '       '   ";
echo "                         

echo.
echo.
echo         TOOLS
echo       ---------
echo     1) netstat
echo     2) ipconfig
echo     3) port scan
echo     4) net reset
echo     5) group policy reset
echo     6) fullscreen
echo     7) exit
echo.
set /p input=
if /I "%input%" EQU "1" goto netstat
if /I "%input%" EQU "2" goto ipconfig
if /I "%input%" EQU "3" goto portscan
if /I "%input%" EQU "4" goto reset
if /I "%input%" EQU "5" goto group
if /I "%input%" EQU "6" goto full
if /I "%input%" EQU "7" goto exit



:netstat
cls
@echo off
color 3
netstat 
pause
goto :kx7


:ipconfig
@echo off 
cls 
color 3
ipconfig
pause             
goto :kx7                           

:portscan
cls
set errorlevel=0
echo.
set /p ip=IP Address: 
set /p ports=Ports (e.g. 21,22,23): 
start cmd /c "mode 40, 15 && title Scanning Ports... && PortScanner.exe hosts=%ip% ports=%ports%>>portscan.txt"
ping localhost -n 5 >nul
taskkill /im PortScanner.exe /f >nul 2>&1
echo.
type portscan.txt
echo.
ping localhost -n 1 >nul
del portscan.txt
pause
goto :kx7



:group
echo off
echo To use this tool Kx7 must be run as admin
echo This will delete all GroupPolicys on your pc!!!
echo Only continue if you know what you're doing !!!
echo     y) yes
echo     n) no
set /p input=
if /I "%input%" EQU "y" goto yes
if /I "%input%" EQU "n" goto kx7
:yes
RD /S /Q "%WinDir%\System32\GroupPolicyUsers"
RD /S /Q "%WinDir%\System32\GroupPolicy"

gpupdate /force

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies" /f

reg delete "HKCU\Software\Policies" /f

reg delete "HKLM\Software\Microsoft\Policies" /f

reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies" /f

reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /f

reg delete "HKLM\Software\Policies" /f

reg delete "HKLM\Software\WOW6432Node\Microsoft\Policies" /f

reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Policies" /f

reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /f

:: Restore Settings / Apps / Startup page

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v SupportUwpStartupTasks /t REG_DWORD /d 1 /f

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableFullTrustStartupTasks /t REG_DWORD /d 2 /f

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableUwpStartupTasks /t REG_DWORD /d 2 /f

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v SupportFullTrustStartupTasks /t REG_DWORD /d 1 /f
pause
goto :kx7


:reset
color 3
ipconfig /flushdns
nbtstat -R
nbtstat -RR
netsh int reset all
netsh int ip reset
netsh winsock reset

:full
:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 1                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%
ECHO Wscript.Sleep 1                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"
pause
goto :kx7
