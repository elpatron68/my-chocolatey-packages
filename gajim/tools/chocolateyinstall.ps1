$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.9/Gajim-1.9.1-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'f73dff966668a3e5f302e76d890fdc06ecc90cb2cf538709598aa3de306bd2b7'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
