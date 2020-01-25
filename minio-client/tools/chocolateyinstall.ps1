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

  checksum64    = 'db78807fd27cfa12cf67f2c3e0ae459bece58f552ab17367a660c095b35cc963'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs