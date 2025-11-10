$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://my.lancom-systems.de/download/LANtools/LANconfig-10.92.0021-RU6.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'LANconfig*'

  checksum      = 'a7d2415916dbbe5c70a4f628e31a641e6a224b4382fa0f80f1fc08884ac68776'
  checksumType  = 'sha256'
  
  silentArgs    = "/params:/silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
