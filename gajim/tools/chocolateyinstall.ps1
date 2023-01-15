$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.6/Gajim-1.6.1-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '5170d8ddffa448465da16afcb82a5dd551c0b2420e1e1cd371cdff152a07b67b'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
