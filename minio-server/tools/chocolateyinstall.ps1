$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://dl.minio.io/server/minio/release/windows-amd64/minio.exe'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url64bit        = $url64
  FileFullPath    = "$toolsDir\minio.exe"
  softwareName    = 'minio-server*'

  checksum64      = '61287D7DBFC855BF5434FE0DA9015A46FAA14BD5BAFEE22FBF9D42D4FA4973B6'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs