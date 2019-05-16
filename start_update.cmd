@echo off
cd c:\Users\mbusc\Documents\projects\my-chocolatey-packages

rem Openaudible
echo Checking openaudible...
python autoupdate\update_openaudible.py > c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

rem Minio Client
echo Checking Minio Client
python autoupdate\update_minio-client.py >> c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

rem Minio Server
echo Checking Minio Server
python autoupdate\update_minio-server.py >> c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

rem Gajim
echo Checking Gajim
python autoupdate\update_gajim.py >> c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

type c:\temp\choco-autoupdate-update.log | telegram-send --stdin
del c:\temp\choco-autoupdate-update.log
