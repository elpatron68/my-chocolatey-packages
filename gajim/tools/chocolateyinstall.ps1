$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.4/Gajim-1.4.6-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '8e2f1533d5612778ba43071c2d5d33fbd32ebb89d1123be54a83a45132f1b5bc'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
