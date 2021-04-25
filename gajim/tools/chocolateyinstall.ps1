$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/1.3/Gajim-1.3.2-32bit-1.exe'
$url64      = 'https://gajim.org/downloads/1.3/Gajim-1.3.2-64bit-1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'gajim*'

  checksum      = '7089f667cd7edf4934e3bb6eb56b5aae66677b3a5022cc9ce3a131c4c8d1ad4b'
  checksumType  = 'sha256'
  checksum64    = '98d51bcad3a614e7628f954fadd8e1e4203fd58ecba8765915a60a35e5a5abdd'
  checksumType64= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
