$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.9/Gajim-1.9.2-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'b8de0cdfdeda1fb19a38b67099f8f777f84ba8083dc9cbfa12c3df9c6f1a894e'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
