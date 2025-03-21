$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://my.lancom-systems.de/download/LANtools/LANmonitor-10.90.0019-RU2.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'LANmonitor*'

  checksum      = '631836035407414b0abc7512e757f5e31c3a5d9b12d881d9d98df6d09738335b'
  checksumType  = 'sha256'

  silentArgs    = "/params:/silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
