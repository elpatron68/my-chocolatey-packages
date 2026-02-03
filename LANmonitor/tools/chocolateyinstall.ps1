$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://my.lancom-systems.de/download/LANtools/LANmonitor-10.94.0011-Rel.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'LANmonitor*'

  checksum      = 'c9187e83a7efda4c94a3c8367c498f28c743b69050fa2aa92ba5e976320af512'
  checksumType  = 'sha256'

  silentArgs    = "/params:/silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
