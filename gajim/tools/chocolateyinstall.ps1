$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/2.3/Gajim-2.3.4-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum      = 'f1f169d75c2eb10c91c8c61f26e16e7dcaf8e8a66681bbac7af3a424451f3911'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
