$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.8/Gajim-1.8.0-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '5ad7511f03e7eef78d35fe99e5b38e9f42fbc43818cac90862765b1268b20831'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
