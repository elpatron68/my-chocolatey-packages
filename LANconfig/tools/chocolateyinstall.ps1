$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://downloads.lancom-systems.de/LANtools/LANconfig-10.94.0052-RU6.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'LANconfig*'

  checksum      = '714d5b557aa52740d7ab711696db61e86ae1c63a7d9a63febedb650f9a651832'
  checksumType  = 'sha256'
  
  silentArgs    = "/params:/silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
