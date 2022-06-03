$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.4/Gajim-1.4.3-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'd5732fd04727d95f1e440f4d9dc608399998fdc09e6622641e34d84e7d3ba08e'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
