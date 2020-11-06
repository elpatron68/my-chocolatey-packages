$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.lancom-systems.de/fileadmin/download/LANtools/LANconfig-10.40.0068-RU4.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'LANconfig*'

  checksum      = 'ad9c1c649da95d3ee8085106c46bdd7c22c9bd543fea7fae801e7996ee0770cb'
  checksumType  = 'sha256'
  
  silentArgs    = "/params:/silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
