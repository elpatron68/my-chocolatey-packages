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

  checksum64      = '79291c36575b3eb4fda4480430624900ac6147461423ae094e3a1c59e5c52207'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs