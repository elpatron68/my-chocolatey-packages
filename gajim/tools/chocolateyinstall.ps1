$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/2.3/Gajim-2.3.1-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '5d1d82407c7216785794b6e1548c37218047b0e15f1ab3f1f50014f3a5b5aac1'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
