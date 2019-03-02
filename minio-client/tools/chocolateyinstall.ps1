$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.minio.io/client/mc/release/windows-amd64/mc.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = "$toolsDir\mc.exe"
  softwareName  = 'minio-client*'

  checksum      = '0CE01C7DAFD3B6353F6A1E39DE6316D6480D6E2807A94F2C62083D15B3A5B744'
  checksumType  = 'sha256'

  
}
Get-ChocolateyWebFile @packageArgs