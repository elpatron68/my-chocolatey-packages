$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/1.3/Gajim-1.3.1-32bit-1.exe'
$url64      = 'https://gajim.org/downloads/1.3/Gajim-1.3.1-64bit-1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'gajim*'

  checksum      = '7753CCF4B18ADA2F4A5435433DAA7873DF25426EC93191E1B6A3D4C2E1EBD326'
  checksumType  = 'sha256'
  checksum64    = 'AB3AD907DFC4583D8E59BDA90F511A142CFC70C42197F47C0275D1BE859DA874'
  checksumType64= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
