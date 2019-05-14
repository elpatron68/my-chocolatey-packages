@echo off
cd c:\Users\mbusc\Documents\projects\my-chocolatey-packages

rem Openaudible
python openaudible\update.py > c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

rem Minio Client
python minio-client\update.py >> c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

rem Minio Server
python minio-server\update.py >> c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

rem Gajim
python gajim\update.py >> c:\temp\choco-autoupdate-update.log
echo. >> c:\temp\choco-autoupdate-update.log

type c:\temp\choco-autoupdate-update.log | telegram-send --stdin
del c:\temp\choco-autoupdate-update.log
