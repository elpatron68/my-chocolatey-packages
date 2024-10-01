$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.9/Gajim-1.9.5-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '522c14353d8028a0ac8e896aad88b101ad83ca8218731399ef9175e90d24cc30'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
