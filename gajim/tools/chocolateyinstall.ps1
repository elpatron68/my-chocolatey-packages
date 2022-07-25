$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.4/Gajim-1.4.7-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '208066f31aaf6b5e8da03ab614a258989db1161ec75270f9dbdd8f1aceac517d'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
