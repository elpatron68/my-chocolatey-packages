$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.8/Gajim-1.8.4-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '8baba67d44909cda802da1e5d945e3936f6b276aa89e626a2ebb68d85e9fc34e'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
