@echo off
cd c:\Users\mbusc\Documents\projects\my-chocolatey-packages

rem Openaudible
echo Checking openaudible for update
python autoupdate\update_openaudible.py > c:\temp\choco-autoupdate-update.log
IF %ERRORLEVEL% EQU 0 (echo No update available) ELSE (echo Package updated and commited)
echo. >> c:\temp\choco-autoupdate-update.log

rem Minio Client
echo Checking Minio Client for update
python autoupdate\update_minio-client.py >> c:\temp\choco-autoupdate-update.log
IF %ERRORLEVEL% EQU 0 (echo No update available) ELSE (echo Package updated and commited)
echo. >> c:\temp\choco-autoupdate-update.log

rem Minio Server
echo Checking Minio Server for update
python autoupdate\update_minio-server.py >> c:\temp\choco-autoupdate-update.log
IF %ERRORLEVEL% EQU 0 (echo No update available) ELSE (echo Package updated and commited)
echo. >> c:\temp\choco-autoupdate-update.log

rem Gajim
echo Checking Gajim for update
python autoupdate\update_gajim.py >> c:\temp\choco-autoupdate-update.log
IF %ERRORLEVEL% EQU 0 (echo No update available) ELSE (echo Package updated and commited)
echo. >> c:\temp\choco-autoupdate-update.log

rem LANconfig
echo Checking LANconfig for update
python autoupdate\update_lanconfig.py >> c:\temp\choco-autoupdate-update.log
IF %ERRORLEVEL% EQU 0 (echo No update available) ELSE (echo Package updated and commited)
echo .
echo. >> c:\temp\choco-autoupdate-update.log

rem LANmonitor
echo Checking LANmonitor for update
python autoupdate\update_lanmonitor.py >> c:\temp\choco-autoupdate-update.log
IF %ERRORLEVEL% EQU 0 (echo No update available) ELSE (echo Package updated and commited)
echo .
echo. >> c:\temp\choco-autoupdate-update.log

rem Streamwriter
echo Checking Streamwriter for update
python autoupdate\update_streamwriter.py >> c:\temp\choco-autoupdate-update.log
IF %ERRORLEVEL% EQU 0 (echo No update available) ELSE (echo Package updated and commited)
echo .
echo. >> c:\temp\choco-autoupdate-update.log

rem USBDLM
echo Checking USBDLM for update
python autoupdate\update_usbdlm.py >> c:\temp\choco-autoupdate-update.log
IF %ERRORLEVEL% EQU 0 (echo No update available) ELSE (echo Package updated and commited)
echo .
echo. >> c:\temp\choco-autoupdate-update.log

type c:\temp\choco-autoupdate-update.log | telegram-send --stdin
echo Sent Telegram message
del c:\temp\choco-autoupdate-update.log
