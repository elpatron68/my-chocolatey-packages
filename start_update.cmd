@echo off
SETLOCAL EnableDelayedExpansion
cd C:\Users\mbusc\source\repos\my-chocolatey-packages
set LOGFILE=%TEMP%\choco-autoupdate-update.log
set GOTIFYTOKEN=ATP2A1mb6Zmu9u8
set GOTIFYURL=https://gotify.elpatron.me
del /q %LOGFILE% >nul 2>&1
echo Git pull...
echo Git pull: > %LOGFILE%
git pull origin master >> %LOGFILE%
echo.
echo. >> %LOGFILE%
set packages=gajim lanconfig lanmonitor streamwriter usbdlm explorergenie
for %%a in (%packages%) do (
    del /q %%a\*.nupkg >nul 2>&1
    echo Checking %%a for update...
    python autoupdate\update_%%a.py >> %LOGFILE%
    rem IF %ERRORLEVEL% EQU 0 (echo No update available) ELSE (echo Package updated and commited)
    IF %ERRORLEVEL% EQU 0 (
        C:\Windows\System32\curl.exe "%GOTIFYURL%/message?token=%GOTIFYTOKEN%" -F "title=Chocolatey Update check %%a" -F "message=Kein Update gefunden." -F "priority=5"
    ) ELSE (
        C:\Windows\System32\curl.exe "%GOTIFYURL%/message?token=%GOTIFYTOKEN%" -F "title=Chocolatey Update check %%a" -F "message=Update gefunden!" -F "priority=3"
    )
    echo.
    echo. >> %LOGFILE%
)

rem echo Sent log file as Telegram message
rem type %LOGFILE% | telegram-send --stdin

echo Send log file as Gotify message
set NL=^
for /f "Tokens=* Delims=" %%x in (%LOGFILE%) do set LOGTEXT=!LOGTEXT!%%x%NL%
rem C:\Windows\System32\curl.exe "%GOTIFYURL%/message?token=%GOTIFYTOKEN%" -F "title=Chocolatey Updates" -F "message=%LOGTEXT%" -F "priority=1"