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

  checksum64      = '994383797B31E80A0E7340B3BAA7D8236C1B571546720B15740CD0419654B319'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs