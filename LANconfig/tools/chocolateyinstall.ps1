$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://my.lancom-systems.de/download/LANtools/LANconfig-10.80.0061-RU8.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'LANconfig*'

  checksum      = '45c7b4bc73963da25860b3b2631ed960f00c0a6a1ecc81d0e9ecf701e6d9b79e'
  checksumType  = 'sha256'
  
  silentArgs    = "/params:/silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
