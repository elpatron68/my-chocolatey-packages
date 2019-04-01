$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://dl.minio.io/client/mc/release/windows-amd64/mc.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url64bit       = $url64
  FileFullPath   = "$toolsDir\mc.exe"
  softwareName   = 'minio-client*'
  checksum64     = '0cabfe8996ec3a2bde4f9b7907975e094be329bc7889fd9b80be1bebb8d6598a'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs