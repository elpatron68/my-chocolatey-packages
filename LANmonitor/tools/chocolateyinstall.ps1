$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://downloads.lancom-systems.de/LANtools/LANmonitor-10.94.0015-RU6.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'LANmonitor*'

  checksum      = 'cc19ea3f2f74b3739688e0834e6176097df0a0b5e04321ae18fde6b26b1e3a46'
  checksumType  = 'sha256'

  silentArgs    = "/params:/silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
