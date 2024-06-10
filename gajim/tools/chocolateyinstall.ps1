$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.9/Gajim-1.9.0-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'a59a1b0405a462d2d1f4561d64c0836632ac83177c4307911a5c379697c64a04'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
