$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://dl.min.io/client/mc/release/windows-amd64/mc.exe'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url64bit        = $url64
  FileFullPath    = "$toolsDir\minio.exe"
  softwareName    = 'minio-server*'

  checksum64    = '62950b56952192b92ac18cbe29fce5b65f1c7992f9d1e8dcd212f138fb580ed2'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs