$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.7/Gajim-1.7.3-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'fcffade37a75142a45f3b65a03a9d597b4502ec6f66c3bf7b61409b459d0450d'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
