$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/2.3/Gajim-2.3.6-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum      = 'bf8988d4ad2cc0757bb7d6896f728834038e8318513edf746eb8f39df278c8a3'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
