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

  checksum64    = '24effff2b4c1fbecc4f0a2b3b646c75b1bfe7cec7c639225cb6fbbe79e4970d0'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs