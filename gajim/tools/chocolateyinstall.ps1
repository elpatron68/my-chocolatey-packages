$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/2.4/Gajim-2.4.7-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum      = 'c5f8dd375bdab423f5391b725caa3ac8e6857221f77784b3ae7e38a1c44a18e6'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
