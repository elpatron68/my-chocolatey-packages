$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.6/Gajim-1.6.0-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'cc1085ad62f56a93e0c3841c29aa3d8f5a68b68da30e658d6031697437fabfa0'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
