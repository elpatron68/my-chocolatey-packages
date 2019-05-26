@echo off
del c:\temp\choco-autoupdate-update.log
set packages=openaudible minio-client minio-server gajim lanconfig lanmonitor streamwriter usbdlm
for %%a in (%packages%) do ( 
    echo Checking %%a for update...
    python autoupdate\update_%%a.py >> c:\temp\choco-autoupdate-update.log
    IF %ERRORLEVEL% EQU 0 (echo No update available) ELSE (echo Package updated and commited)
    echo.
    echo. >> c:\temp\choco-autoupdate-update.log
)

type c:\temp\choco-autoupdate-update.log | telegram-send --stdin
echo Sent log file as Telegram message

