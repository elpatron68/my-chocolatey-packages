$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.7/Gajim-1.7.1-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '9455f3929bfdb4f82b5368cf4cf2bf1b29df0d1b0ef99d635a2b33fc5f78fb58'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
