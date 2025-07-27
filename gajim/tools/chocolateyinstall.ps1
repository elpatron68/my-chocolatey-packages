$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/2.3/Gajim-2.3.3-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '8bf67474da9525806547ff809c196b12578b2b0a77e8705fad19c5bdb1e602fb'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
