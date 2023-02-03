$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.7/Gajim-1.7.0-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '9078c0063c9a0130e4f55868b73534d531c6ea041fc3ae5e50b7999dff6edddb'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
