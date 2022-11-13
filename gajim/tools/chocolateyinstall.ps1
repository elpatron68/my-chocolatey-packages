$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.5/Gajim-1.5.3-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'ead46125ef8d3c7438a5b888c4599361a9368b5f727cf57ffb68b901385e061b'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
