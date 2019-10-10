$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://dl.minio.io/client/mc/release/windows-amd64/mc.exe'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url64bit        = $url64
  FileFullPath    = "$toolsDir\minio.exe"
  softwareName    = 'minio-server*'

  checksum64    = '86c3a81bfb4e084a5b724427cd04698caffeb743f072f967dab90eb4f67499fa'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs