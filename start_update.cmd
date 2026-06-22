@echo off
SETLOCAL EnableDelayedExpansion
cd C:\Users\mbusc\source\repos\my-chocolatey-packages
if exist "%~dp0start_update.local.cmd" call "%~dp0start_update.local.cmd"
set LOGFILE=%TEMP%\choco-autoupdate-update.log
if not defined GOTIFYURL set GOTIFYURL=https://gotify.elpatron.me
del /q %LOGFILE% >nul 2>&1
echo Git pull...
echo Git pull: > %LOGFILE%
"C:\Program Files\Git\bin\git.exe" pull origin master >> %LOGFILE% 2>&1
echo.
echo. >> %LOGFILE%
set packages=gajim lanconfig lanmonitor streamwriter usbdlm avpn netradio
for %%a in (%packages%) do (
    del /q %%a\*.nupkg >nul 2>&1
    echo Checking %%a for update...
    .\.venv\Scripts\python.exe autoupdate\update_%%a.py >> %LOGFILE% 2>&1

    IF !ERRORLEVEL! EQU 1 (
        if defined GOTIFYTOKEN (
            C:\Windows\System32\curl.exe "!GOTIFYURL!/message?token=!GOTIFYTOKEN!" -F "title=Chocolatey Update check %%a" -F "message=Update gefunden!" -F "priority=3"
        )
        echo %%a: Update found >> %LOGFILE%
    ) ELSE IF !ERRORLEVEL! EQU 0 (
        if defined GOTIFYTOKEN (
            C:\Windows\System32\curl.exe "!GOTIFYURL!/message?token=!GOTIFYTOKEN!" -F "title=Chocolatey Update check %%a" -F "message=Kein Update gefunden." -F "priority=5"
        )
        echo %%a: No update found >> %LOGFILE%
    ) ELSE (
        if defined GOTIFYTOKEN (
            C:\Windows\System32\curl.exe "!GOTIFYURL!/message?token=!GOTIFYTOKEN!" -F "title=Chocolatey Update check %%a" -F "message=Fehler beim Update-Check (Exit !ERRORLEVEL!)." -F "priority=8"
        )
        echo %%a: Error exit !ERRORLEVEL! >> %LOGFILE%
    )
    echo.
    echo. >> %LOGFILE%
)

rem echo Sent log file as Telegram message
rem type %LOGFILE% | telegram-send --stdin

echo Send log file as Gotify message
set NL=^
for /f "Tokens=* Delims=" %%x in (%LOGFILE%) do set LOGTEXT=!LOGTEXT!%%x%NL%
rem if defined GOTIFYTOKEN C:\Windows\System32\curl.exe "!GOTIFYURL!/message?token=!GOTIFYTOKEN!" -F "title=Chocolatey Updates" -F "message=!LOGTEXT!" -F "priority=1"
