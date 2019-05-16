@echo off
cd c:\Users\mbusc\Documents\projects\my-chocolatey-packages

rem Openaudible
python autoupdate\update_openaudible.py > c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

rem Minio Client
python autoupdate\update_minio-client.py >> c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

rem Minio Server
python autoupdate\update_minio-server.py >> c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

rem Gajim
python autoupdate\update_gajim.py >> c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

type c:\temp\choco-autoupdate-update.log | telegram-send --stdin
del c:\temp\choco-autoupdate-update.log
