$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://my.lancom-systems.de/download/LANtools/LANmonitor-10.80.0006-Rel.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'LANmonitor*'

  checksum      = '8fcc8295659ac53590615020ca78ca6bc6fabf09254e49e4f5c0062ca74125b6'
  checksumType  = 'sha256'

  silentArgs    = "/params:/silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
