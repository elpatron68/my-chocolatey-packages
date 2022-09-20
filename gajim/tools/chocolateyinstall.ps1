$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.5/Gajim-1.5.1-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'ceef51d9dfa49c6303cf8c15f76a016028f596f16f7a80f65f72d936650c9d42'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
