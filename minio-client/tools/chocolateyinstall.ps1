$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://dl.minio.io/client/mc/release/windows-amd64/mc.exe'
$url        = 'https://dl.minio.io/client/mc/release/windows-386/mc.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  url64bit       = $url64
  FileFullPath   = "$toolsDir\mc.exe"
  softwareName   = 'minio-client*'

  cecksum        = 'B7FB12A589CE9CDAE03897AB464EDE784CA941E70E52371B555AB2FEDF58A361'
  checksumType   = 'sha256'
  checksum64     = '0CE01C7DAFD3B6353F6A1E39DE6316D6480D6E2807A94F2C62083D15B3A5B744'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs