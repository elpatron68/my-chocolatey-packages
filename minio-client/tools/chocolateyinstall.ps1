$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://dl.min.io/client/mc/release/windows-amd64/mc.exe'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url64bit        = $url64
  FileFullPath    = "$toolsDir\mc.exe"
  softwareName    = 'minio-client*'

  checksum64    = 'f7ae6d6c0d0ec7b95f0fb0cfc8651a647d4c0d5f769488a0e9675ef0ab8e93d9'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs