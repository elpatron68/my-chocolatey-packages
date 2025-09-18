$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/2.3/Gajim-2.3.5-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum      = 'f45039ca55a0404dd677f5fd9d4cc11960b729bdd546b0e0d251fa0fd0077883'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
