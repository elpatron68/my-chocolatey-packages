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

  checksum64      = '51b7c0cbbe00037f8da013b09e835648722e298b9bf9c56ab20a6dd9ea72acdf'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs